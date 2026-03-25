part of '../imports/view_imports.dart';

class _ReportsSavingsSection extends StatelessWidget {
  const _ReportsSavingsSection({required this.model});

  final ReportsUiModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.reportsSavingsTitle.tr(),
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),
        AppMargin.mH10.szH,
        ...model.savingsItems.map(
          (e) => _SavingsCard(item: e).marginBottom(AppMargin.mH8),
        ),
      ],
    ).marginBottom(AppMargin.mH12);
  }
}

class _SavingsCard extends StatelessWidget {
  const _SavingsCard({required this.item});

  final ReportsSavingsItem item;

  String _title(BuildContext context) => switch (item.kind) {
        ReportsSavingsKind.daily => LocaleKeys.reportsSavingsDaily.tr(),
        ReportsSavingsKind.weekly => LocaleKeys.reportsSavingsWeekly.tr(),
        ReportsSavingsKind.monthly => LocaleKeys.reportsSavingsMonthly.tr(),
      };

  @override
  Widget build(BuildContext context) {
    final barColor = item.isPositive ? AppColors.success : AppColors.error;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.pH14),
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _title(context),
                  style: const TextStyle().setMainTextColor.s13.medium,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RiyalPriceText(
                    price: item.amountDigits,
                    priceTextStyle: const TextStyle().setMainTextColor.s14.semiBold,
                  ),
                  AppMargin.mH4.szH,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.rotate(
                        angle: item.isPositive ? math.pi : 0,
                        child: IconWidget(
                          icon: AppAssets.svg.baseSvg.arrowDown.path,
                          height: AppSize.sH14,
                          width: AppSize.sW14,
                          color: barColor,
                        ),
                      ),
                      AppMargin.mW4.szW,
                      Text(
                        '${item.isPositive ? '+' : '-'}${item.percentDigits}%',
                        style: TextStyle().setColor(barColor).s12.medium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          AppMargin.mH10.szH,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppCircular.r5),
            child: LinearProgressIndicator(
              value: item.progress.clamp(0.0, 1.0),
              minHeight: AppSize.sH6,
              backgroundColor: AppColors.grey1,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }
}
