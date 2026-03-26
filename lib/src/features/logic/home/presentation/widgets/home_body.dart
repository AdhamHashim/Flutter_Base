part of '../imports/view_imports.dart';

class _HomeBody extends StatelessWidget {
  final int index;
  const _HomeBody(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _HomeTabBody();
      case 1:
        return const BillsScreen();
      case 2:
        return const ReportsScreen();
      case 3:
        return const MoreTabView();

      default:
        return const SizedBox.shrink();
    }
  }
}
