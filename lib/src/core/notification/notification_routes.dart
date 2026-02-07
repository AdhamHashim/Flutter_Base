part of 'notification_service.dart';

class NotificationRoutes {
  static void navigateByType(
    Map<String, dynamic> data, {
    bool isFromNotificationScreen = false,
  }) {
    final String? type = data['type'];
    if (type == null) return;
    final notificationType = type.toNotificationType;
    // Skip navigation if user is already on notification screen
    if (isFromNotificationScreen &&
        notificationType.navigation is NotificationScreenNavigation) {
      return;
    }
    // Use 'data' field for navigation params if available, otherwise use root map
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

abstract interface class NotificationNavigation {
  void navigate({required Map<String, dynamic> data});
}

class HomeNavigation implements NotificationNavigation {
  const HomeNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    // Go.offAll(const HomeScreen());
  }
}

class NotificationScreenNavigation implements NotificationNavigation {
  const NotificationScreenNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    // Go.to(const NotificationScreen());
  }
}

class BlockNotificationNavigation implements NotificationNavigation {
  const BlockNotificationNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) async {
    await UserCubit.instance.logout();
    // Go.offAll(const LoginScreen());
    MessageUtils.showSnackBar(
      baseStatus: BaseStatus.error,
      message: LocaleKeys.app_user_validity_expired.tr(),
    );
  }
}

class WalletNavigation implements NotificationNavigation {
  const WalletNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    // Go.to(const WalletScreen());
  }
}

class ComplainDetailsNavigation implements NotificationNavigation {
  const ComplainDetailsNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    final complaintId = data['complaint_id'];
    if (complaintId != null) {
      // final int id = complaintId is int
      //     ? complaintId
      //     : int.tryParse(complaintId.toString()) ?? 0;
      // Go.to(ComplainDetailsScreen(id: id));
    }
  }
}

class ChatNavigation implements NotificationNavigation {
  const ChatNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    // final roomId = data['room_id'];
    // if (roomId != null) {
    //   final int id = roomId is int
    //       ? roomId
    //       : int.tryParse(roomId.toString()) ?? 0;
    //   final int receiverId = data['sender_id'] is int
    //       ? data['sender_id']
    //       : int.tryParse(data['sender_id']?.toString() ?? '') ?? 0;
    //   final senderType = data['sender_type']?.toString();
    //   final chatType = senderType == 'Provider'
    //       ? ChatType.normal
    //       : ChatType.technicalSupport;
    //   final chatEntity = ChatEntity(
    //     id: id,
    //     recieverID: receiverId,
    //     appointmentNumber: '',
    //     name: data['sender_name']?.toString() ?? '',
    //     image: data['avatar']?.toString() ?? '',
    //     category: '',
    //     categoryType: null,
    //     unseenMessagesCount: 0,
    //   );
    //   Go.to(
    //     ChatScreen(chatUser: chatEntity, isComplete: false, chatType: chatType),
    //   );
    // }
  }
}

class ReportDetailsNavigation implements NotificationNavigation {
  const ReportDetailsNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    final reportId = data['report_id'];
    if (reportId != null) {
      // final int id = reportId is int
      //     ? reportId
      //     : int.tryParse(reportId.toString()) ?? 0;
      // Go.to(ReportDetailsScreen(id));
    }
  }
}

class NoNavigation implements NotificationNavigation {
  const NoNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    // Navigate to notifications screen for informational notifications
    // Go.to(const NotificationScreen());
  }
}
