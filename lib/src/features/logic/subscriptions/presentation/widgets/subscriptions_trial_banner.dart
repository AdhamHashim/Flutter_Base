part of '../imports/view_imports.dart';

class _SubscriptionsTrialBanner extends StatelessWidget {
  const _SubscriptionsTrialBanner();

  static const LinearGradient _trialGradient = LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [
      Color(0xFFF97316),
      Color(0xFFEA580C),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: _trialGradient,
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.subscriptionsTrialTitle,
                      style: const TextStyle().setWhiteColor.s14.bold,
                    ),
                    AppMargin.mH4.szH,
                    Text(
                      LocaleKeys.subscriptionsTrialRemaining(
                        days: '${SubscriptionUiConstants.trialDaysRemaining}',
                      ),
                      style: const TextStyle().setWhiteColor.s13.regular
                          .copyWith(color: AppColors.white.withValues(alpha: 0.9)),
                    ),
                  ],
                ),
              ),
              AppMargin.mW12.szW,
              Container(
                width: AppSize.sH50,
                height: AppSize.sH50,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IconWidget(
                    icon: AppAssets.svg.wzeinIcons.button48.path,
                    height: AppSize.sH25,
                    width: AppSize.sW25,
                    color: AppColors.forth,
                  ),
                ),
              ),
            ],
          ),
          AppMargin.mH16.szH,
          Text(
            LocaleKeys.subscriptionsTrialDescription,
            style: const TextStyle().setWhiteColor.s13.regular
                .copyWith(color: AppColors.white.withValues(alpha: 0.9)),
          ),
        ],
      ).paddingSymmetric(
        vertical: AppPadding.pH20,
        horizontal: AppPadding.pW20,
      ),
    );
  }
}
