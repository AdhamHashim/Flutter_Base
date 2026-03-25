part of '../imports/view_imports.dart';

class _SubscriptionsPlanPriceSection extends StatelessWidget {
  const _SubscriptionsPlanPriceSection({required this.isYearly});

  final bool isYearly;

  static final List<String Function()> _featureLabels = [
    () => LocaleKeys.subscriptionsFeatureUnlimitedExpenses,
    () => LocaleKeys.subscriptionsFeatureAdvancedReports,
    () => LocaleKeys.subscriptionsFeatureInvoicesWarranties,
    () => LocaleKeys.subscriptionsFeatureSmartNotifications,
    () => LocaleKeys.subscriptionsFeatureAutoBackup,
    () => LocaleKeys.subscriptionsFeatureSupport24,
  ];

  @override
  Widget build(BuildContext context) {
    final price = isYearly
        ? '${SubscriptionUiConstants.yearlyPriceSar}'
        : '${SubscriptionUiConstants.monthlyPriceSar}';
    final period = isYearly
        ? LocaleKeys.subscriptionsPricePeriodYearly
        : LocaleKeys.subscriptionsPricePeriodMonthly;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.dashboardBackground,
            AppColors.grey1,
          ],
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
        ),
        borderRadius: BorderRadius.circular(AppCircular.r15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.subscriptionsPriceLabel,
                style: const TextStyle().setPrimaryColor.s12.regular,
              ),
              AppMargin.mH4.szH,
              RiyalPriceText(
                price: price,
                priceTextStyle: const TextStyle().setMainTextColor.s22.bold,
                currencyTextStyle:
                    const TextStyle().setPrimaryColor.s14.regular,
              ),
              AppMargin.mH4.szH,
              Text(
                period,
                style: const TextStyle().setHintColor.s12.regular,
              ),
            ],
          ),
          AppMargin.mH16.szH,
          for (var i = 0; i < _featureLabels.length; i++) ...[
            if (i > 0) AppMargin.mH8.szH,
            _SubscriptionsFeatureRow(label: _featureLabels[i]()),
          ],
        ],
      ).paddingSymmetric(
        vertical: AppPadding.pH20,
        horizontal: AppPadding.pW20,
      ),
    );
  }
}
