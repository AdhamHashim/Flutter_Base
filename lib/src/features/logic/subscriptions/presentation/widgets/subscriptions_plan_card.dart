part of '../imports/view_imports.dart';

class _SubscriptionsPlanCard extends StatelessWidget {
  const _SubscriptionsPlanCard({required this.vc});

  final SubscriptionsViewController vc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.subscriptionsChoosePlan,
            style: const TextStyle().setMainTextColor.s14.semiBold,
          ),
          AppMargin.mH16.szH,
          _SubscriptionsPlanToggle(vc: vc),
          AppMargin.mH20.szH,
          ValueListenableBuilder<bool>(
            valueListenable: vc.isYearly,
            builder: (context, isYearly, _) {
              return _SubscriptionsPlanPriceSection(isYearly: isYearly);
            },
          ),
          AppMargin.mH20.szH,
          _SubscriptionsDiscountRow(vc: vc),
        ],
      ).paddingAll(AppPadding.pH20),
    );
  }
}
