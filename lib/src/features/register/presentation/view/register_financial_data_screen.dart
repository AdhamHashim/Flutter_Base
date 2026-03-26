part of '../imports/view_imports.dart';

class RegisterFinancialDataScreen extends StatelessWidget {
  const RegisterFinancialDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _RegisterFinancialDataView();
  }
}

class _RegisterFinancialDataView extends StatefulWidget {
  const _RegisterFinancialDataView();

  @override
  State<_RegisterFinancialDataView> createState() =>
      _RegisterFinancialDataViewState();
}

class _RegisterFinancialDataViewState extends State<_RegisterFinancialDataView> {
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
      body: SafeArea(child: _RegisterFinancialDataBody()),
    );
  }
}
