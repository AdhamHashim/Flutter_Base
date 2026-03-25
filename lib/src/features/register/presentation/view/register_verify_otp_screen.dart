part of '../imports/view_imports.dart';

class RegisterVerifyOtpScreen extends StatelessWidget {
  const RegisterVerifyOtpScreen({super.key, required this.phone});
  final String phone;

  @override
  Widget build(BuildContext context) {
    return const _RegisterVerifyOtpView();
  }
}

class _RegisterVerifyOtpView extends StatefulWidget {
  const _RegisterVerifyOtpView();

  @override
  State<_RegisterVerifyOtpView> createState() => _RegisterVerifyOtpViewState();
}

class _RegisterVerifyOtpViewState extends State<_RegisterVerifyOtpView> {
  @override
  void initState() {
    super.initState();
    Helpers.changeStatusbarColor(
      statusBarColor: AppColors.scaffoldBackground,
      statusBarIconBrightness: Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(child: _RegisterVerifyOtpBody()),
    );
  }
}
