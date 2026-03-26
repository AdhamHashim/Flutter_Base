part of '../imports/view_imports.dart';

class _ReportsComparisonSection extends StatelessWidget {
  const _ReportsComparisonSection({required this.model});

  final ReportsUiModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.reportsPeriodCompareTitle.tr(),
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),
        AppMargin.mH10.szH,
        Row(
          children: [
            Expanded(
              child: _CompareCard(
                title: LocaleKeys.reportsThisMonth.tr(),
                amountDigits: model.thisMonthTotalDigits,
                dailyAvgDigits: model.thisMonthDailyAvgDigits,
                highlight: true,
              ),
            ),
            AppMargin.mW10.szW,
            Expanded(
              child: _CompareCard(
                title: LocaleKeys.reportsLastMonth.tr(),
                amountDigits: model.lastMonthTotalDigits,
                dailyAvgDigits: model.lastMonthDailyAvgDigits,
                highlight: false,
              ),
            ),
          ],
        ),
      ],
    ).marginBottom(AppMargin.mH12);
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.title,
    required this.amountDigits,
    required this.dailyAvgDigits,
    required this.highlight,
  });

  final String title;
  final String amountDigits;
  final String dailyAvgDigits;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final amountStyle = highlight
        ? const TextStyle().setColor(AppColors.forth).s18.semiBold
        : const TextStyle().setHintColor.s18.semiBold;
    return Container(
      padding: EdgeInsets.all(AppPadding.pH14),
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle().setHintColor.s11.regular,
          ),
          AppMargin.mH8.szH,
          RiyalPriceText(
            price: amountDigits,
            priceTextStyle: amountStyle,
          ),
          AppMargin.mH8.szH,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${LocaleKeys.reportsDailyAvgLabel.tr()} ',
                style: const TextStyle().setHintColor.s11.regular,
              ),
              RiyalPriceText(
                price: dailyAvgDigits,
                priceTextStyle: const TextStyle().setPrimaryColor.s11.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
