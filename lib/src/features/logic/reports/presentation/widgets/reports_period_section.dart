part of '../imports/view_imports.dart';

class _ReportsPeriodSection extends StatelessWidget {
  const _ReportsPeriodSection({required this.vc});

  final ReportsViewController vc;

  @override
  Widget build(BuildContext context) {
    final selected = vc.period.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppMargin.mH12.szH,
        Text(
          LocaleKeys.reportsTimePeriod.tr(),
          style: const TextStyle().setMainTextColor.s14.semiBold,
        ),
        AppMargin.mH8.szH,
        Row(
          children: [
            Expanded(
              child: _PeriodChip(
                label: LocaleKeys.reportsPeriodDaily.tr(),
                selected: selected == ReportsPeriod.daily,
                onTap: () => vc.period.value = ReportsPeriod.daily,
              ),
            ),
            AppMargin.mW8.szW,
            Expanded(
              child: _PeriodChip(
                label: LocaleKeys.reportsPeriodWeekly.tr(),
                selected: selected == ReportsPeriod.weekly,
                onTap: () => vc.period.value = ReportsPeriod.weekly,
              ),
            ),
            AppMargin.mW8.szW,
            Expanded(
              child: _PeriodChip(
                label: LocaleKeys.reportsPeriodMonthly.tr(),
                selected: selected == ReportsPeriod.monthly,
                onTap: () => vc.period.value = ReportsPeriod.monthly,
              ),
            ),
          ],
        ),
        AppMargin.mH12.szH,
      ],
    );
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.forth : AppColors.grey1,
      borderRadius: BorderRadius.circular(AppCircular.r10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppCircular.r10),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.pH10,
              horizontal: AppPadding.pW8,
            ),
            child: Text(
              label,
              style: selected
                  ? const TextStyle().setWhiteColor.s12.medium
                  : const TextStyle().setPrimaryColor.s12.regular,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
