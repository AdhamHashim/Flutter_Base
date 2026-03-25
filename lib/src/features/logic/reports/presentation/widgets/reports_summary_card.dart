part of '../imports/view_imports.dart';

class _ReportsSummaryCard extends StatelessWidget {
  const _ReportsSummaryCard({required this.model});

  final ReportsUiModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.border),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: AppPadding.pW16,
              end: AppPadding.pW16,
              top: AppPadding.pH14,
            ),
            child: Text(
              LocaleKeys.reportsSummaryTitle.tr(),
              style: const TextStyle().setMainTextColor.s14.semiBold,
            ),
          ),
          AppMargin.mH12.szH,
          _SummaryRow(
            label: LocaleKeys.reportsTotalSpending.tr(),
            trailing: RiyalPriceText(
              price: model.totalSpendingDigits,
              priceTextStyle: const TextStyle().setMainTextColor.s14.medium,
            ),
          ),
          _divider,
          _SummaryRow(
            label: LocaleKeys.reportsGoalDefined.tr(),
            trailing: RiyalPriceText(
              price: model.goalDigits,
              priceTextStyle: const TextStyle().setMainTextColor.s14.medium,
            ),
          ),
          _divider,
          _SummaryRow(
            label: LocaleKeys.reportsBudgetAdherence.tr(),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model.budgetAdherencePercentDigits}%',
                  style: const TextStyle().setColor(AppColors.success).s14.semiBold,
                ),
                AppMargin.mW6.szW,
                Container(
                  width: AppSize.sH30,
                  height: AppSize.sH30,
                  decoration: const BoxDecoration(
                    color: AppColors.infoBoxLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconWidget(
                      icon: AppAssets.svg.baseSvg.checkBox.path,
                      height: AppSize.sH16,
                      width: AppSize.sW16,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _divider,
          _SummaryRow(
            label: LocaleKeys.reportsDailyAverageExpense.tr(),
            trailing: RiyalPriceText(
              price: model.dailyAverageDigits,
              priceTextStyle: const TextStyle().setMainTextColor.s14.medium,
            ),
          ),
          AppMargin.mH14.szH,
        ],
      ),
    ).marginBottom(AppMargin.mH12);
  }

  static const Widget _divider = Divider(height: 1, color: AppColors.border);
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.trailing});

  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle().setHintColor.s12.regular,
            ),
          ),
          trailing,
        ],
      ),
    ).paddingOnly(bottom: AppPadding.pH12);
  }
}
