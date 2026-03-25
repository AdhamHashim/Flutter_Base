part of '../imports/view_imports.dart';

class LoginConfirmPinScreen extends StatelessWidget {
  const LoginConfirmPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginConfirmPinView();
  }
}

class _LoginConfirmPinView extends StatefulWidget {
  const _LoginConfirmPinView();

  @override
  State<_LoginConfirmPinView> createState() => _LoginConfirmPinViewState();
}

class _LoginConfirmPinViewState extends State<_LoginConfirmPinView> {
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: const SafeArea(child: _LoginConfirmPinBody()),
    );
  }
}
