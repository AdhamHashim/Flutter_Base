import 'package:firebase_messaging/firebase_messaging.dart';

/// Handles initial and tap notification routing via callbacks.
/// Single instance; register once (e.g. at app start) with [NotificationNavigator].
class NotificationNavigator {
  NotificationNavigator._({
    required this.onRoutingMessage,
    required this.onNoInitialMessage,
  });

  static NotificationNavigator? _instance;
  RemoteMessage? _message;

  factory NotificationNavigator({
    required void Function(RemoteMessage message) onRoutingMessage,
    required void Function() onNoInitialMessage,
  }) {
    return _instance ??= NotificationNavigator._(
      onRoutingMessage: onRoutingMessage,
      onNoInitialMessage: onNoInitialMessage,
    );
  }

  /// Call after FCM is ready. Routes to [onRoutingMessage] if app opened from
  /// a notification; otherwise calls [onNoInitialMessage].
  Future<void> init() async {
    _message = await FirebaseMessaging.instance.getInitialMessage();
    if (_message != null) {
      onRoutingMessage(_message!);
    } else {
      onNoInitialMessage();
    }
  }

  final void Function(RemoteMessage message) onRoutingMessage;
  final void Function() onNoInitialMessage;

  /// Used by [NotificationService] to delegate tap handling.
  static NotificationNavigator? get instance => _instance;
}
