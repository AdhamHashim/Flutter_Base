part of '../imports/view_imports.dart';

class _HomeTabBalanceCardSection extends StatelessWidget {
  const _HomeTabBalanceCardSection({required this.model});

  final HomeTabUiModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: AppMargin.mW20,
        end: AppMargin.mW20,
        top: AppMargin.mH20,
      ),
      padding: EdgeInsetsDirectional.only(
        start: AppPadding.pW20,
        end: AppPadding.pW20,
        top: AppPadding.pH20,
        bottom: AppPadding.pH20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppCircular.r20),
        gradient: AppColors.gradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.homeTabMonthlySalaryLabel,
                      style: const TextStyle()
                          .setColor(AppColors.buttonText)
                          .s13
                          .regular
                          .setFontFamily,
                    ),
                    AppMargin.mH4.szH,
                    RiyalPriceText(
                      price: model.monthlySalaryAmount,
                      priceTextStyle: const TextStyle()
                          .setWhiteColor
                          .s28
                          .bold
                          .setFontFamily,
                      currencyTextStyle: const TextStyle()
                          .setWhiteColor
                          .s28
                          .bold
                          .setFontFamily,
                    ),
                    AppMargin.mH4.szH,
                    Text(
                      LocaleKeys.homeTabSaudiRiyalLabel,
                      style: const TextStyle()
                          .setColor(AppColors.cardFill)
                          .s13
                          .regular
                          .setFontFamily,
                    ),
                  ],
                ),
              ),
              AppMargin.mW12.szW,
              Container(
                width: AppSize.sH60,
                height: AppSize.sH60,
                decoration: const BoxDecoration(
                  color: AppColors.cardFill,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconWidget(
                    icon: AppAssets.svg.wzeinIcons.aX338Expenses.path,
                    width: AppSize.sW30,
                    height: AppSize.sH30,
                    color: AppColors.forth,
                  ),
                ),
              ),
            ],
          ),
          AppMargin.mH16.szH,
          Divider(
            height: AppSize.sH1,
            thickness: AppSize.sH1,
            color: AppColors.white.withValues(alpha: 0.35),
          ),
          AppMargin.mH16.szH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.homeTabMonthlyExpenseLabel,
                      style: const TextStyle()
                          .setColor(AppColors.buttonText)
                          .s13
                          .regular
                          .setFontFamily,
                    ),
                    AppMargin.mH8.szH,
                    RiyalPriceText(
                      price: model.monthlyExpenseAmount,
                      priceTextStyle: const TextStyle()
                          .setWhiteColor
                          .s18
                          .bold
                          .setFontFamily,
                      currencyTextStyle: const TextStyle()
                          .setWhiteColor
                          .s18
                          .bold
                          .setFontFamily,
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSize.sW40, height: AppSize.sH40),
            ],
          ),
        ],
      ),
    );
  }
}
