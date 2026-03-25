part of '../imports/view_imports.dart';

class ChangePhoneOtpViewController {
  ChangePhoneOtpViewController() {
    startResendTimer();
  }

  final TextEditingController otpController = TextEditingController();
  final ValueNotifier<int> resendSeconds = ValueNotifier(59);
  Timer? _timer;

  void startResendTimer() {
    _timer?.cancel();
    resendSeconds.value = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (resendSeconds.value <= 0) {
        _timer?.cancel();
        return;
      }
      resendSeconds.value--;
    });
  }

  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    resendSeconds.dispose();
  }
}
