part of '../imports/view_imports.dart';

class _ReportsChartSection extends StatelessWidget {
  const _ReportsChartSection({required this.vc, required this.model});

  final ReportsViewController vc;
  final ReportsUiModel model;

  static Color _pieColor(ReportsPieCategory c) => switch (c) {
        ReportsPieCategory.food => AppColors.forth,
        ReportsPieCategory.transport => AppColors.info,
        ReportsPieCategory.utilities => AppColors.success,
        ReportsPieCategory.health => AppColors.warning,
        ReportsPieCategory.other => AppColors.third,
      };

  static String _pieLabel(ReportsPieCategory c) => switch (c) {
        ReportsPieCategory.food => LocaleKeys.reportsPieFood.tr(),
        ReportsPieCategory.transport => LocaleKeys.reportsPieTransport.tr(),
        ReportsPieCategory.utilities => LocaleKeys.reportsPieUtilities.tr(),
        ReportsPieCategory.health => LocaleKeys.reportsPieHealth.tr(),
        ReportsPieCategory.other => LocaleKeys.reportsPieOther.tr(),
      };

  @override
  Widget build(BuildContext context) {
    final mode = vc.chartMode.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.reportsChartsTitle.tr(),
              style: const TextStyle().setMainTextColor.s14.semiBold,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label: LocaleKeys.reportsChartPieSemantics.tr(),
                  button: true,
                  child: Material(
                    color: AppColors.cardFill,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => vc.chartMode.value = ReportsChartMode.byCategory,
                      child: Padding(
                        padding: EdgeInsets.all(AppPadding.pH8),
                        child: IconWidget(
                          icon: AppAssets.svg.wzeinIcons.aX338Expenses.path,
                          height: AppSize.sH20,
                          width: AppSize.sW20,
                          color: mode == ReportsChartMode.byCategory
                              ? AppColors.forth
                              : AppColors.hintText,
                        ),
                      ),
                    ),
                  ),
                ),
                AppMargin.mW8.szW,
                Semantics(
                  label: LocaleKeys.reportsChartBarSemantics.tr(),
                  button: true,
                  child: Material(
                    color: AppColors.cardFill,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => vc.chartMode.value = ReportsChartMode.byDay,
                      child: Padding(
                        padding: EdgeInsets.all(AppPadding.pH8),
                        child: IconWidget(
                          icon: AppAssets.svg.wzeinIcons.aX338Expenses2.path,
                          height: AppSize.sH20,
                          width: AppSize.sW20,
                          color: mode == ReportsChartMode.byDay
                              ? AppColors.forth
                              : AppColors.hintText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        AppMargin.mH8.szH,
        Text(
          mode == ReportsChartMode.byDay
              ? LocaleKeys.reportsChartByDays.tr()
              : LocaleKeys.reportsChartByCategory.tr(),
          style: const TextStyle().setHintColor.s12.regular,
        ),
        AppMargin.mH12.szH,
        if (mode == ReportsChartMode.byDay)
          _BarByDay(model: model)
        else
          _PieByCategory(model: model),
      ],
    ).marginBottom(AppMargin.mH12);
  }
}

class _BarByDay extends StatelessWidget {
  const _BarByDay({required this.model});

  final ReportsUiModel model;

  String _dayLabel(BuildContext context, int offset) {
    final lang = context.locale.languageCode;
    final d = DateTime(2025, 3, 1).add(Duration(days: offset));
    return DateFormat.E(lang).format(d);
  }

  @override
  Widget build(BuildContext context) {
    final maxV = model.dayBars.fold<double>(
      1,
      (m, e) => math.max(m, e.amount),
    );
    return Column(
      children: model.dayBars
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(bottom: AppMargin.mH10),
              child: Row(
                children: [
                  SizedBox(
                    width: AppSize.sW40,
                    child: Text(
                      _dayLabel(context, e.dayOffsetFromSaturday),
                      style: const TextStyle().setHintColor.s11.regular,
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppCircular.r5),
                      child: LinearProgressIndicator(
                        value: (e.amount / maxV).clamp(0.0, 1.0),
                        minHeight: AppSize.sH8,
                        backgroundColor: AppColors.grey1,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.forth),
                      ),
                    ),
                  ),
                  AppMargin.mW8.szW,
                  RiyalPriceText(
                    price: e.amount.toStringAsFixed(0),
                    priceTextStyle: const TextStyle().setMainTextColor.s11.medium,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PieByCategory extends StatelessWidget {
  const _PieByCategory({required this.model});

  final ReportsUiModel model;

  @override
  Widget build(BuildContext context) {
    final sections = model.pieSlices
        .map(
          (e) => PieChartSectionData(
            color: _ReportsChartSection._pieColor(e.category),
            value: e.amount,
            title: '',
            radius: 52,
          ),
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: AppSize.sH85 + AppSize.sH85 + AppSize.sH30,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 44,
              sections: sections,
            ),
          ),
        ),
        AppMargin.mH12.szH,
        ...model.pieSlices.map(
          (e) => Padding(
            padding: EdgeInsets.only(bottom: AppMargin.mH8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: AppSize.sW10,
                      height: AppSize.sH10,
                      decoration: BoxDecoration(
                        color: _ReportsChartSection._pieColor(e.category),
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppMargin.mW8.szW,
                    Text(
                      _ReportsChartSection._pieLabel(e.category),
                      style: const TextStyle().setMainTextColor.s12.medium,
                    ),
                  ],
                ),
                RiyalPriceText(
                  price: e.amount.toStringAsFixed(0),
                  priceTextStyle: const TextStyle().setMainTextColor.s12.semiBold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
