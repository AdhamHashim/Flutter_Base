part of 'notification_service.dart';

enum NotificationType {
  none(0, navigation: HomeNavigation()),
  message(1, navigation: MessageNavigation()),
  update(2, navigation: UpdateNavigation()),
  warning(3, navigation: HomeNavigation()),
  error(4, navigation: HomeNavigation()),
  success(5, navigation: HomeNavigation());

  final int id;
  final NotificationNavigation navigation;
  const NotificationType(this.id, {required this.navigation});
}
