import 'navigation_types.dart';
import 'notification_navigation.dart';

/// Routes to the appropriate screen based on notification payload type.
class NotificationRoutes {
  static void navigateByType(
    Map<String, dynamic> data, {
    bool isFromNotificationScreen = false,
  }) {
    final String? type = data['type'];
    if (type == null) return;
    final notificationType = type.toNotificationType;
    if (isFromNotificationScreen &&
        notificationType.navigation is NotificationScreenNavigation) {
      return;
    }
    final Map<String, dynamic> navigationData = isFromNotificationScreen
        ? data['data'] as Map<String, dynamic>
        : data;
    notificationType.navigation.navigate(data: navigationData);
  }
}

extension GetNotificationTypeByKey on String {
  NotificationType get toNotificationType {
    return NotificationType.values.firstWhere(
      (element) => element.id == this,
      orElse: () => NotificationType.none,
    );
  }
}
