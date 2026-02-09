import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../config/res/config_imports.dart';
import 'base_notification_config.dart';

/// Android-specific notification configuration.
/// Holds channel and display settings for Android notifications.
final class AndroidNotificationConfig implements BaseNotificationConfig {
  const AndroidNotificationConfig({
    this.channelId = 'high_importance_channel',
    this.channelName = 'High Importance Notifications',
    this.importance = Importance.high,
    this.defaultIcon = '@mipmap/ic_launcher',
    this.appName = ConstantManager.appName,
    this.enableVibration = true,
    this.playSound = true,
    this.priority = Priority.max,
  });

  final String channelId;
  final String channelName;
  final Importance importance;
  @override
  final String defaultIcon;
  @override
  final String appName;
  final bool enableVibration;
  final bool playSound;
  final Priority priority;

  /// Builds the Android notification channel for the plugin.
  AndroidNotificationChannel get channel => AndroidNotificationChannel(
    channelId,
    channelName,
    importance: importance,
  );

  /// Builds Android notification details for a text-only notification.
  AndroidNotificationDetails toNotificationDetails() =>
      AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: appName,
        enableVibration: enableVibration,
        playSound: playSound,
        icon: defaultIcon,
        importance: importance,
        priority: priority,
      );

  /// Builds Android notification details for a notification with a big picture.
  AndroidNotificationDetails toNotificationDetailsWithBigPicture({
    required String bigPicturePath,
    String? contentTitle,
    String? summaryText,
  }) {
    final style = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      contentTitle: contentTitle,
      summaryText: summaryText,
    );
    return AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: appName,
      enableVibration: enableVibration,
      playSound: playSound,
      icon: defaultIcon,
      importance: importance,
      priority: priority,
      styleInformation: style,
    );
  }
}
