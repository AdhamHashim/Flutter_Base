part of '../imports/view_imports.dart';

class ReportsMonthDetailSheet {
  ReportsMonthDetailSheet._();

  static Future<void> show(BuildContext context, {required String monthName}) {
    return showDefaultBottomSheet(
      context: context,
      child: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.reportsMonthDetailTitle(monthName: monthName),
              textAlign: TextAlign.center,
              style: const TextStyle().setMainTextColor.s14.semiBold,
            ),
            AppMargin.mH16.szH,
            ...List.generate(
              5,
              (_) => _MonthDetailLine(
                label: LocaleKeys.reportsCategoryRent.tr(),
                amountDigits: '3050',
              ).marginBottom(AppMargin.mH8),
            ),
            AppMargin.mH8.szH,
          ],
        ).paddingSymmetric(horizontal: AppPadding.pW16),
      ),
    );
  }
}

class _MonthDetailLine extends StatelessWidget {
  const _MonthDetailLine({required this.label, required this.amountDigits});

  final String label;
  final String amountDigits;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH50,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppCircular.r12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle().setSecondryColor.s13.medium,
          ),
          RiyalPriceText(
            price: amountDigits,
            priceTextStyle: const TextStyle().setMainTextColor.s13.medium,
          ),
        ],
      ),
    );
  }
}
