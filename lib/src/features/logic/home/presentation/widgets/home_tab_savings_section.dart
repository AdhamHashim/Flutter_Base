part of '../imports/view_imports.dart';

class _HomeTabSavingsSection extends StatelessWidget {
  const _HomeTabSavingsSection({required this.model});

  final HomeTabUiModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppMargin.mH20.szH,
        Container(
          margin: EdgeInsetsDirectional.only(
            start: AppMargin.mW20,
            end: AppMargin.mW20,
          ),
          padding: EdgeInsets.all(AppPadding.pH20),
          decoration: BoxDecoration(
            color: AppColors.selectedButton,
            borderRadius: BorderRadius.circular(AppCircular.r15),
            boxShadow: [AppColors.containerShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.homeTabSavingsTitle,
                    style: const TextStyle()
                        .setMainTextColor
                        .s14
                        .bold
                        .setFontFamily,
                  ),
                  AppMargin.mW8.szW,
                  Container(
                    width: AppSize.sH30,
                    height: AppSize.sH30,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              AppMargin.mH16.szH,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _HomeSavingsBox(
                      periodLabel: LocaleKeys.homeTabSavingsToday,
                      amount: model.savingsTodayAmount,
                    ),
                  ),
                  AppMargin.mW12.szW,
                  Expanded(
                    child: _HomeSavingsBox(
                      periodLabel: LocaleKeys.homeTabSavingsWeek,
                      amount: model.savingsWeekAmount,
                    ),
                  ),
                  AppMargin.mW12.szW,
                  Expanded(
                    child: _HomeSavingsBox(
                      periodLabel: LocaleKeys.homeTabSavingsMonth,
                      amount: model.savingsMonthAmount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeSavingsBox extends StatelessWidget {
  const _HomeSavingsBox({
    required this.periodLabel,
    required this.amount,
  });

  final String periodLabel;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            periodLabel,
            style: const TextStyle().setHintColor.s12.regular.setFontFamily,
          ),
          AppMargin.mH4.szH,
          Text(
            amount,
            style: const TextStyle()
                .setColor(AppColors.success)
                .s16
                .bold
                .setFontFamily,
          ),
          Text(
            LocaleKeys.homeTabCurrencyRiyal,
            style: const TextStyle()
                .setHintColor
                .s12
                .regular
                .setFontFamily,
          ),
        ],
      ),
    );
  }
}
