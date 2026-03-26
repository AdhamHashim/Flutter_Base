part of '../imports/view_imports.dart';

class _HomeTabHeaderSection extends StatelessWidget {
  const _HomeTabHeaderSection({required this.model});

  final HomeTabUiModel model;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cardFill,
        boxShadow: [AppColors.containerShadow],
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: AppSize.sH40,
              height: AppSize.sH40,
              decoration: const BoxDecoration(
                color: AppColors.scaffoldBackground,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ClipOval(
                  child: IconWidget(
                    icon: AppAssets.svg.baseSvg.profile.path,
                    width: AppSize.sW40,
                    height: AppSize.sH40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AppMargin.mW12.szW,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.homeTabWelcomeUser(
                      name: LocaleKeys.homeTabDemoUserName,
                    ),
                    style: const TextStyle()
                        .setMainTextColor
                        .s14
                        .semiBold
                        .setFontFamily,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppMargin.mH4.szH,
                  Text(
                    LocaleKeys.homeTabSmartExpenseTagline,
                    style: const TextStyle()
                        .setHintColor
                        .s12
                        .regular
                        .setFontFamily,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            AppMargin.mW12.szW,
            _NotificationBellButton(count: model.notificationCount),
          ],
        ).paddingSymmetric(
          horizontal: AppPadding.pW20,
          vertical: AppPadding.pH16,
        ),
      ),
    );
  }
}

class _NotificationBellButton extends StatelessWidget {
  const _NotificationBellButton({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: AppSize.sH40,
          height: AppSize.sH40,
          decoration: const BoxDecoration(
            color: AppColors.scaffoldBackground,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconWidget(
              icon: AppAssets.svg.baseSvg.notifications.path,
              width: AppSize.sW20,
              height: AppSize.sH20,
              color: AppColors.main,
            ),
          ),
        ).onClick(onTap: () {}),
        if (count > 0)
          PositionedDirectional(
            end: -AppSize.sW4,
            top: -AppSize.sH4,
            child: Container(
              constraints: BoxConstraints(
                minWidth: AppSize.sW18,
                minHeight: AppSize.sH18,
              ),
              padding: EdgeInsets.all(AppPadding.pH4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle()
                    .setWhiteColor
                    .s10
                    .medium
                    .setFontFamily,
              ),
            ),
          ),
      ],
    );
  }
}
