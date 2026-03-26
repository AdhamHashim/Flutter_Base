part of '../imports/view_imports.dart';

class RegisterConfirmPinScreen extends StatelessWidget {
  const RegisterConfirmPinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterConfirmPinView();
  }
}

class _RegisterConfirmPinView extends StatefulWidget {
  const _RegisterConfirmPinView();

  @override
  State<_RegisterConfirmPinView> createState() =>
      _RegisterConfirmPinViewState();
}

class _RegisterConfirmPinViewState extends State<_RegisterConfirmPinView> {
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
          title: LocaleKeys.registerConfirmPinTitle,
          subtitle: LocaleKeys.registerConfirmPinSubtitle,
          onConfirm: (_) async {
            await Future.delayed(const Duration(milliseconds: 400));
            if (!context.mounted) return;
            Go.to(const RegisterFinancialDataScreen());
          },
        ),
      ),
    );
  }
}
