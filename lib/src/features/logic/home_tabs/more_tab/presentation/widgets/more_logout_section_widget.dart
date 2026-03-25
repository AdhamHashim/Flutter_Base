part of '../imports/view_imports.dart';

class _MoreLogoutSectionWidget extends StatelessWidget {
  const _MoreLogoutSectionWidget();

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: context.isArabic
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
        children: [
          IconWidget(
            icon: AppAssets.svg.baseSvg.arrowBack.path,
            width: AppSize.sW20,
            height: AppSize.sH20,
          ),
          AppMargin.mW8.szW,
          Text(
            LocaleKeys.logout,
            textDirection: context.isArabic
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            style: const TextStyle()
                .setErrorColor
                .s14
                .semiBold
                .setFontFamily,
          ),
        ],
      ).paddingSymmetric(
        vertical: AppPadding.pH16,
        horizontal: AppPadding.pW20,
      ),
    ).onClick(onTap: () async => logOut());
  }
}
