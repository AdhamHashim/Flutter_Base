part of '../imports/view_imports.dart';

class _HomeTabBody extends StatelessWidget {
  const _HomeTabBody();

  @override
  Widget build(BuildContext context) {
    final HomeTabUiModel model = HomeTabUiModel.mock();
    return ColoredBox(
      color: AppColors.scaffoldBackground,
      child: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _HomeTabHeaderSection(model: model).toSliver(),
            _HomeTabBalanceCardSection(model: model).toSliver(),
            const _HomeTabShortcutsSection().toSliver(),
            _HomeTabDailySummarySection(model: model).toSliver(),
            _HomeTabCommitmentSection(model: model).toSliver(),
            _HomeTabSavingsSection(model: model).toSliver(),
            SliverToBoxAdapter(child: AppMargin.mH20.szH),
          ],
        ),
      ),
    );
  }
}
