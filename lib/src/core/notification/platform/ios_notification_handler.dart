import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config/base_notification_config.dart';
import '../config/ios_notification_config.dart';
import 'notification_platform_handler.dart';

/// iOS implementation of [NotificationPlatformHandler].
/// Handles iOS permissions and Darwin notification details.
final class IosNotificationHandler implements NotificationPlatformHandler {
  IosNotificationHandler([IosNotificationConfig? config])
    : _config = config ?? const IosNotificationConfig();

  final IosNotificationConfig _config;

  @override
  BaseNotificationConfig get config => _config;

  @override
  bool get showLocalNotificationInForeground => false;

  @override
  Future<bool> requestPermissions(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    final result = await plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(
          alert: _config.presentAlert,
          badge: _config.presentBadge,
          sound: _config.presentSound,
        );
    return result ?? false;
  }

  @override
  Future<void> createChannelIfNeeded(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    // No-op on iOS; channels are Android-only.
  }

  @override
  InitializationSettings getInitializationSettings() {
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    return const InitializationSettings(android: null, iOS: ios);
  }

  @override
  NotificationDetails buildTextNotificationDetails({
    required String title,
    String? body,
    String? channelDescription,
  }) {
    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    return const NotificationDetails(android: null, iOS: ios);
  }

  @override
  NotificationDetails buildImageNotificationDetails({
    required String title,
    String? body,
    String? channelDescription,
    required String imageFilePath,
  }) {
    // iOS: same as text; attachment would require extra setup.
    return buildTextNotificationDetails(
      title: title,
      body: body,
      channelDescription: channelDescription,
    );
  }
}
