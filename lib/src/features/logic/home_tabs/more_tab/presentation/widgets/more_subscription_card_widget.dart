part of '../imports/view_imports.dart';

class _MoreSubscriptionCardWidget extends StatelessWidget {
  const _MoreSubscriptionCardWidget();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final localeCode = context.locale.languageCode;
    final dateStr = DateFormat.yMMMd(
      localeCode == 'ar' ? 'ar' : 'en',
    ).format(SubscriptionUiConstants.trialEndsAt);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.moreSubscriptionTitle,
            textAlign: TextAlign.start,
            textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            style:
                const TextStyle().setMainTextColor.s14.semiBold.setFontFamily,
          ),
          AppMargin.mH16.szH,
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.pH16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppCircular.r12),
              gradient: const LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [Color(0xFFFFF7ED), Color(0xFFFFEDD5)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
                  children: [
                    Container(
                      width: AppSize.sH50,
                      height: AppSize.sH50,
                      decoration: const BoxDecoration(
                        color: AppColors.forth,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconWidget(
                          icon: AppAssets.svg.wzeinIcons.button48.path,
                          width: AppSize.sW25,
                          height: AppSize.sH25,
                        ),
                      ),
                    ),
                    AppMargin.mW12.szW,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            LocaleKeys.moreSubscriptionStatusLabel,
                            textAlign: TextAlign.start,
                            textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
                            style: const TextStyle()
                                .setHintColor
                                .s13
                                .regular
                                .setFontFamily,
                          ),
                          AppMargin.mH4.szH,
                          Text(
                            LocaleKeys.moreSubscriptionStatusActiveTrial,
                            textAlign: TextAlign.start,
                            textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
                            style: const TextStyle()
                                .setForthColor
                                .s14
                                .semiBold
                                .setFontFamily,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                AppMargin.mH12.szH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
                  children: [
                    IconWidget(
                      icon: AppAssets.svg.wzeinIcons.button19.path,
                      width: AppSize.sW16,
                      height: AppSize.sH16,
                    ),
                    AppMargin.mW8.szW,
                    Expanded(
                      child: Text(
                        LocaleKeys.moreSubscriptionEndsAt(date: dateStr),
                        textAlign: TextAlign.start,
                        textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
                        style: const TextStyle()
                            .setHintColor
                            .s13
                            .regular
                            .setFontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppMargin.mH16.szH,
          SizedBox(
            width: double.infinity,
            child: DefaultButton(
              title: LocaleKeys.moreManageSubscription,
              color: AppColors.forth,
              textColor: AppColors.white,
              height: AppSize.sH50,
              width: double.infinity,
              borderRadius: BorderRadius.circular(AppCircular.r12),
              fontWeight: FontWeightManager.bold,
              onTap: () => Go.to(const SubscriptionsScreen()),
            ),
          ),
        ],
      ).paddingAll(AppPadding.pH20),
    );
  }
}
