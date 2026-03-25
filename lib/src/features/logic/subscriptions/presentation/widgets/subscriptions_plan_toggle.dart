part of '../imports/view_imports.dart';

class _SubscriptionsPlanToggle extends StatelessWidget {
  const _SubscriptionsPlanToggle({required this.vc});

  final SubscriptionsViewController vc;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: vc.isYearly,
      builder: (context, isYearly, _) {
        return Row(
          children: [
            Expanded(
              child: _PlanSegmentButton(
                label: LocaleKeys.subscriptionsPlanMonthly,
                selected: !isYearly,
                onTap: () => vc.isYearly.value = false,
              ),
            ),
            AppMargin.mW12.szW,
            Expanded(
              child: _PlanSegmentButton(
                label: LocaleKeys.subscriptionsPlanYearly,
                selected: isYearly,
                onTap: () => vc.isYearly.value = true,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PlanSegmentButton extends StatelessWidget {
  const _PlanSegmentButton({
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
      color: selected ? AppColors.forth : AppColors.selectedButton,
      borderRadius: BorderRadius.circular(AppCircular.r12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        child: SizedBox(
          height: AppSize.sH44,
          child: Center(
            child: Text(
              label,
              style: selected
                  ? const TextStyle().setWhiteColor.s13.medium
                  : const TextStyle().setHintColor.s13.medium,
            ),
          ),
        ),
      ),
    );
  }
}
