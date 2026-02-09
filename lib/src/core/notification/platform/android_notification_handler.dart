import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config/android_notification_config.dart';
import '../config/base_notification_config.dart';
import 'notification_platform_handler.dart';
 
/// Android implementation of [NotificationPlatformHandler].
/// Handles channel creation, permissions, and Android notification details.
final class AndroidNotificationHandler implements NotificationPlatformHandler {
  AndroidNotificationHandler([AndroidNotificationConfig? config])
      : _config = config ?? const AndroidNotificationConfig();

  final AndroidNotificationConfig _config;

  @override
  BaseNotificationConfig get config => _config;

  @override
  bool get showLocalNotificationInForeground => true;

  @override
  Future<bool> requestPermissions(FlutterLocalNotificationsPlugin plugin) async {
    final result = await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return result ?? false;
  }

  @override
  Future<void> createChannelIfNeeded(
      FlutterLocalNotificationsPlugin plugin) async {
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_config.channel);
  }

  @override
  InitializationSettings getInitializationSettings() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    return const InitializationSettings(
      android: android,
      iOS: null,
    );
  }

  @override
  NotificationDetails buildTextNotificationDetails({
    required String title,
    String? body,
    String? channelDescription,
  }) {
    final android = _config.toNotificationDetails();
    return NotificationDetails(android: android, iOS: null);
  }

  @override
  NotificationDetails buildImageNotificationDetails({
    required String title,
    String? body,
    String? channelDescription,
    required String imageFilePath,
  }) {
    final android = _config.toNotificationDetailsWithBigPicture(
      contentTitle: title,
      summaryText: body,
      bigPicturePath: imageFilePath,
    );
    return NotificationDetails(android: android, iOS: null);
  }
}
