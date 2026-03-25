part of '../imports/view_imports.dart';

class RegisterCreatePinScreen extends StatelessWidget {
  const RegisterCreatePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterCreatePinView();
  }
}

class _RegisterCreatePinView extends StatefulWidget {
  const _RegisterCreatePinView();

  @override
  State<_RegisterCreatePinView> createState() => _RegisterCreatePinViewState();
}

class _RegisterCreatePinViewState extends State<_RegisterCreatePinView> {
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
      body: SafeArea(
        child: _RegisterPinBody(
          title: LocaleKeys.registerCreatePinTitle,
          subtitle: LocaleKeys.registerCreatePinSubtitle,
          onConfirm: (_) async {
            await Future.delayed(const Duration(milliseconds: 400));
            if (!context.mounted) return;
            Go.to(const RegisterConfirmPinScreen());
          },
        ),
      ),
    );
  }
}
