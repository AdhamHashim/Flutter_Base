/// Base configuration for notification setup.
/// Implementations provide platform-specific values (Android/iOS).
abstract interface class BaseNotificationConfig {
  /// Default notification icon resource name (e.g. Android mipmap).
  String get defaultIcon;

  /// Application display name used in channel description and UI.
  String get appName;
}
