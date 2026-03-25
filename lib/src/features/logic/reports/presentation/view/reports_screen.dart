part of '../imports/view_imports.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late final ReportsViewController _vc = ReportsViewController();

  @override
  void dispose() {
    _vc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DefaultScaffold(
      showArrow: false,
      title: LocaleKeys.reportsTitle.tr(),
      body: _ReportsBody(vc: _vc),
    );
  }
}
