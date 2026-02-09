import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../generated/locale_keys.g.dart';
import '../extensions/base_state.dart';
import '../shared/cubits/user_cubit/user_cubit.dart';
import '../widgets/custom_messages.dart';
import 'helpers/notification_image_downloader.dart';
import 'models/notification_display_type.dart';
import 'navigation_types.dart';
import 'notification_navigator.dart';
import 'platform/android_notification_handler.dart';
import 'platform/ios_notification_handler.dart';
import 'platform/notification_platform_handler.dart';

// Re-export for single import from feature layer
export 'models/notification_display_type.dart';
export 'navigation_types.dart';
export 'notification_navigator.dart';
export 'notification_routes.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('========= >>> backGroundMessage ${message.data}');
}

/// Entry point for FCM and local notifications.
/// Delegates platform-specific behavior to [NotificationPlatformHandler].
class NotificationService {
  NotificationService([NotificationPlatformHandler? handler])
    : _handler = handler ?? _resolveHandler();

  static NotificationPlatformHandler _resolveHandler() {
    return Platform.isAndroid
        ? AndroidNotificationHandler()
        : IosNotificationHandler();
  }

  final NotificationPlatformHandler _handler;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static String deviceToken = '';

  Future<void> setupNotifications() async {
    await Future.wait([
      _saveFcmToken(),
      _setForegroundNotificationOptions(),
      _registerFcmPermission(),
      _requestPermissions(),
      NotificationNavigator.instance!.init(),
    ]);
    await _initLocalNotification();
    _configureFcmListeners();
  }

  Future<void> _requestPermissions() async {
    await _handler.createChannelIfNeeded(_plugin);
    await _handler.requestPermissions(_plugin);
  }

  Future<void> _initLocalNotification() async {
    final settings = _handler.getInitializationSettings();
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
  }

  void _onNotificationResponse(NotificationResponse? response) {
    if (response?.payload == null) return;
    final message = RemoteMessage.fromMap(
      json.decode(response!.payload!) as Map<String, dynamic>,
    );
    _handleNotificationTap(message);
  }

  Future<void> _registerFcmPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _handleNotificationTap(RemoteMessage? message) {
    if (message == null) return;
    NotificationNavigator.instance?.onRoutingMessage(message);
  }

  Future<void> _saveFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    deviceToken = token ?? '';
    log('Firebase Fcm token : $token');
  }

  Future<void> _setForegroundNotificationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureFcmListeners() {
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  Future<void> _onForegroundMessage(RemoteMessage event) async {
    final type = event.data['type'] as String?;
    if (_isLogoutNotification(type)) {
      await _handleLogoutNotification();
      return;
    }
    if (_handler.showLocalNotificationInForeground) {
      _showLocalNotification(event);
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title ?? '';
    final body = notification?.body;
    final displayType = _getDisplayType(message);
    final channelDesc = _handler.config.appName;

    if (displayType == FcmNotificationDisplayType.image) {
      final imageUrl = _getImageUrl(message);
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final path = await downloadImageToTempFile(imageUrl);
        if (path != null) {
          final details = _handler.buildImageNotificationDetails(
            title: title,
            body: body,
            channelDescription: channelDesc,
            imageFilePath: path,
          );
          await _plugin.show(
            message.hashCode,
            title,
            body,
            details,
            payload: json.encode(message.toMap()),
          );
          return;
        }
      }
    }

    final details = _handler.buildTextNotificationDetails(
      title: title,
      body: body,
      channelDescription: channelDesc,
    );
    await _plugin.show(
      message.hashCode,
      title,
      body,
      details,
      payload: json.encode(message.toMap()),
    );
  }

  /// Decides whether to show text-only or image notification from payload.
  FcmNotificationDisplayType _getDisplayType(RemoteMessage message) {
    final data = message.data;
    final style = data['notification_style'] ?? data['style'];
    if (style == 'image' || style == 'big_picture') {
      return FcmNotificationDisplayType.image;
    }
    if (_getImageUrl(message) != null) {
      return FcmNotificationDisplayType.image;
    }
    return FcmNotificationDisplayType.text;
  }

  /// Gets image URL from FCM payload (Android notification image or data).
  String? _getImageUrl(RemoteMessage message) {
    final android = message.notification?.android;
    if (android?.imageUrl != null && android!.imageUrl!.isNotEmpty) {
      return android.imageUrl;
    }
    final data = message.data;
    return data['image_url'] ?? data['image'];
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Public APIs: use the notification type you need
  // ─────────────────────────────────────────────────────────────────────────

  /// Shows a **text-only** FCM-style notification (title + body).
  /// Use this when you need only title and body, no image.
  Future<void> showTextNotification(
    int id,
    String title, {
    String? body,
    String? payload,
  }) async {
    final details = _handler.buildTextNotificationDetails(
      title: title,
      body: body,
      channelDescription: _handler.config.appName,
    );
    await _plugin.show(id, title, body, details, payload: payload);
  }

  /// Shows an **image** notification (title + body + large image).
  /// [imageUrl] is downloaded and shown as big picture (Android) or with body (iOS).
  /// Use this when you need to show an image with title and body.
  Future<void> showImageNotification(
    int id,
    String title, {
    String? body,
    required String imageUrl,
    String? payload,
  }) async {
    final path = await downloadImageToTempFile(imageUrl);
    final channelDesc = _handler.config.appName;
    final details = path != null
        ? _handler.buildImageNotificationDetails(
            title: title,
            body: body,
            channelDescription: channelDesc,
            imageFilePath: path,
          )
        : _handler.buildTextNotificationDetails(
            title: title,
            body: body,
            channelDescription: channelDesc,
          );
    await _plugin.show(id, title, body, details, payload: payload);
  }

  bool _isLogoutNotification(String? type) {
    return type == NotificationType.blockNotification.id ||
        type == NotificationType.deleteAccountNotification.id;
  }

  Future<void> _handleLogoutNotification() async {
    await UserCubit.instance.logout();
    MessageUtils.showSnackBar(
      baseStatus: BaseStatus.error,
      message: LocaleKeys.app_user_validity_expired.tr(),
    );
  }
}
