part of '../imports/view_imports.dart';

class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return DefaultScaffold(
      showArrow: false,
      title: LocaleKeys.billsOperationsTitle.tr(),
      body: const _BillsBody(),
    );
  }
}
