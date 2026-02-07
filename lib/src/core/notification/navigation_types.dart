part of 'notification_service.dart';

enum NotificationType {
  none('none', navigation: HomeNavigation()),

  walletTransactionNotification(
    'wallet_transaction_notification',
    navigation: WalletNavigation(),
  ),
  blockNotification(
    'block_notification',
    navigation: BlockNotificationNavigation(),
  ),
  deleteAccountNotification(
    'delete_account_notification',
    navigation: BlockNotificationNavigation(),
  ),
  adminNotification(
    'admin_notification',
    navigation: NotificationScreenNavigation(),
  ),
  adminReplyComplaintNotification(
    'admin_reply_complaint_notification',
    navigation: ComplainDetailsNavigation(),
  ),
  adminComplaintInProgressNotification(
    'admin_complaint_in_progress_notification',
    navigation: ComplainDetailsNavigation(),
  );

  final String id;
  final NotificationNavigation navigation;
  const NotificationType(this.id, {required this.navigation});
}
