part of '../imports/view_imports.dart';

class _ReportsBody extends StatelessWidget {
  const _ReportsBody({required this.vc});

  final ReportsViewController vc;

  static final ReportsUiModel _model = ReportsUiModel.mock();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.scaffoldBackground,
      child: RefreshIndicator(
        onRefresh: () async {},
        child: AnimatedBuilder(
          animation: Listenable.merge([vc.period, vc.chartMode]),
          builder: (context, _) {
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _ReportsPeriodSection(vc: vc).toSliver(),
                _ReportsSummaryCard(model: _model).toSliver(),
                _ReportsSavingsSection(model: _model).toSliver(),
                _ReportsChartSection(vc: vc, model: _model).toSliver(),
                _ReportsFixedExpensesSection(vc: vc, model: _model).toSliver(),
                _ReportsComparisonSection(model: _model).toSliver(),
                _ReportsExportSection().toSliver(),
                SliverToBoxAdapter(child: AppMargin.mH20.szH),
              ],
            );
          },
        ),
      ),
    ).paddingSymmetric(horizontal: AppPadding.pW12);
  }
}
