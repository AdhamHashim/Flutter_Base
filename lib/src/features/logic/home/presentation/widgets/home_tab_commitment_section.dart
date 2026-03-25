part of '../imports/view_imports.dart';

class _HomeTabCommitmentSection extends StatelessWidget {
  const _HomeTabCommitmentSection({required this.model});

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
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.circular(AppCircular.r15),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.homeTabCommitmentIndicators,
                style: const TextStyle()
                    .setMainTextColor
                    .s14
                    .semiBold
                    .setFontFamily,
              ),
              AppMargin.mH16.szH,
              _HomeCommitmentRow(
                label: LocaleKeys.homeTabCommitmentDaily,
                amount: model.commitmentDailyAmount,
                fillColor: AppColors.error,
                trackColor: AppColors.error.withValues(alpha: 0.15),
                widthFactor: 1,
              ),
              AppMargin.mH16.szH,
              _HomeCommitmentRow(
                label: LocaleKeys.homeTabCommitmentWeekly,
                amount: model.commitmentWeeklyAmount,
                fillColor: AppColors.success,
                trackColor: AppColors.grey1,
                widthFactor: model.commitmentWeeklyProgress,
              ),
              AppMargin.mH16.szH,
              _HomeCommitmentRow(
                label: LocaleKeys.homeTabCommitmentMonthly,
                amount: model.commitmentMonthlyAmount,
                fillColor: AppColors.warning,
                trackColor: AppColors.grey1,
                widthFactor: model.commitmentMonthlyProgress,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeCommitmentRow extends StatelessWidget {
  const _HomeCommitmentRow({
    required this.label,
    required this.amount,
    required this.fillColor,
    required this.trackColor,
    required this.widthFactor,
  });

  final String label;
  final String amount;
  final Color fillColor;
  final Color trackColor;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style:
                  const TextStyle().setPrimaryColor.s13.regular.setFontFamily,
            ),
            RiyalPriceText(
              price: amount,
              priceTextStyle: const TextStyle()
                  .setSecondryColor
                  .s14
                  .medium
                  .setFontFamily,
              currencyTextStyle: const TextStyle()
                  .setSecondryColor
                  .s14
                  .medium
                  .setFontFamily,
            ),
          ],
        ),
        AppMargin.mH8.szH,
        ClipRRect(
          borderRadius: BorderRadius.circular(AppCircular.infinity),
          child: SizedBox(
            height: AppSize.sH8,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: trackColor),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: FractionallySizedBox(
                    widthFactor: widthFactor.clamp(0.0, 1.0),
                    heightFactor: 1,
                    alignment: AlignmentDirectional.centerEnd,
                    child: ColoredBox(color: fillColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
