part of '../imports/view_imports.dart';

class _ReportsFixedExpensesSection extends StatelessWidget {
  const _ReportsFixedExpensesSection({required this.vc, required this.model});

  final ReportsViewController vc;
  final ReportsUiModel model;

  String _monthName(BuildContext context, int month) {
    final lang = context.locale.languageCode;
    return DateFormat.MMMM(lang).format(DateTime(2025, month, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.reportsFixedExpensesTitle.tr(),
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),
        AppMargin.mH10.szH,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.reportsDateFrom.tr(),
                    style: const TextStyle().setHintColor.s11.regular,
                  ),
                  AppMargin.mH4.szH,
                  DefaultTextField(
                    controller: vc.dateFromController,
                    readOnly: true,
                    label: LocaleKeys.reportsDateHint.tr(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            AppMargin.mW10.szW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.reportsDateTo.tr(),
                    style: const TextStyle().setHintColor.s11.regular,
                  ),
                  AppMargin.mH4.szH,
                  DefaultTextField(
                    controller: vc.dateToController,
                    readOnly: true,
                    label: LocaleKeys.reportsDateHint.tr(),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        AppMargin.mH12.szH,
        ...model.fixedMonths.map(
          (row) => _FixedMonthRow(
            monthLabel: _monthName(context, row.month),
            row: row,
            onTap: () => ReportsMonthDetailSheet.show(
              context,
              monthName: _monthName(context, row.month),
            ),
          ).marginBottom(AppMargin.mH8),
        ),
      ],
    ).marginBottom(AppMargin.mH12);
  }
}

class _FixedMonthRow extends StatelessWidget {
  const _FixedMonthRow({
    required this.monthLabel,
    required this.row,
    required this.onTap,
  });

  final String monthLabel;
  final ReportsFixedMonthRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffoldBackground,
      borderRadius: BorderRadius.circular(AppCircular.r12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.pW14,
            vertical: AppPadding.pH12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: AppSize.sW8,
                    height: AppSize.sH8,
                    decoration: const BoxDecoration(
                      color: AppColors.forth,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AppMargin.mW8.szW,
                  Text(
                    monthLabel,
                    style: const TextStyle().setSecondryColor.s13.medium,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RiyalPriceText(
                        price: row.amountDigits,
                        priceTextStyle: const TextStyle().setMainTextColor.s13.semiBold,
                      ),
                      if (row.deltaPercent != null) ...[
                        AppMargin.mH2.szH,
                        Text(
                          '${row.deltaPositive ? '+' : '-'}${row.deltaPercent!.toStringAsFixed(1)}%',
                          style: TextStyle().setColor(
                            row.deltaPositive ? AppColors.success : AppColors.error,
                          ).s11.medium,
                        ),
                      ],
                    ],
                  ),
                  AppMargin.mW8.szW,
                  IconWidget(
                    icon: AppAssets.svg.baseSvg.arrowDown.path,
                    height: AppSize.sH18,
                    width: AppSize.sW18,
                    color: AppColors.hintText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
