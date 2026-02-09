import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';
import '../extensions/base_state.dart';
import '../shared/cubits/user_cubit/user_cubit.dart';
import '../widgets/custom_messages.dart';

/// Contract for handling navigation when a notification is opened.
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
    // Chat navigation implementation
  }
}

class ReportDetailsNavigation implements NotificationNavigation {
  const ReportDetailsNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    final reportId = data['report_id'];
    if (reportId != null) {
      // Go.to(ReportDetailsScreen(id));
    }
  }
}

class NoNavigation implements NotificationNavigation {
  const NoNavigation();
  @override
  void navigate({required Map<String, dynamic> data}) {
    // Go.to(const NotificationScreen());
  }
}
