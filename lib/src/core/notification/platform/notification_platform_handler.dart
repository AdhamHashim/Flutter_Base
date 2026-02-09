import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../config/base_notification_config.dart';

/// Contract for platform-specific notification behavior (Android / iOS).
/// Implementations handle permissions, channels, and notification display details.
abstract interface class NotificationPlatformHandler {
  /// Platform-specific config.
  BaseNotificationConfig get config;

  /// Requests notification permissions. Returns true if granted or already granted.
  Future<bool> requestPermissions(FlutterLocalNotificationsPlugin plugin);

  /// Creates notification channel if needed (e.g. Android). No-op on iOS.
  Future<void> createChannelIfNeeded(FlutterLocalNotificationsPlugin plugin);

  /// Returns platform-specific initialization settings for local notifications.
  InitializationSettings getInitializationSettings();

  /// Whether to show a local notification when a message is received in foreground.
  /// Android typically true; iOS often false (system may show banner).
  bool get showLocalNotificationInForeground;

  /// Builds platform-specific [NotificationDetails] for a text-only notification
  /// (title + body).
  NotificationDetails buildTextNotificationDetails({
    required String title,
    String? body,
    String? channelDescription,
  });

  /// Builds platform-specific [NotificationDetails] for a notification with
  /// a large image (title + body + image at [imageFilePath]).
  /// [imageFilePath] is a local file path (e.g. after downloading from FCM).
  NotificationDetails buildImageNotificationDetails({
    required String title,
    String? body,
    String? channelDescription,
    required String imageFilePath,
  });
}
