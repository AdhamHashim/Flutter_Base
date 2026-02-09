import '../../../config/res/config_imports.dart';
import 'base_notification_config.dart';

/// iOS-specific notification configuration.
/// Holds permission and presentation options for iOS.
final class IosNotificationConfig implements BaseNotificationConfig {
  const IosNotificationConfig({
    this.defaultIcon = '',
    this.appName = ConstantManager.appName,
    this.requestAlertPermission = false,
    this.requestBadgePermission = false,
    this.requestSoundPermission = false,
    this.presentAlert = true,
    this.presentBadge = true,
    this.presentSound = true,
  });

  @override
  final String defaultIcon;
  @override
  final String appName;
  final bool requestAlertPermission;
  final bool requestBadgePermission;
  final bool requestSoundPermission;
  final bool presentAlert;
  final bool presentBadge;
  final bool presentSound;
}
