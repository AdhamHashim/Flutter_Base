part of '../imports/view_imports.dart';

class _NotificationCardWidget extends StatelessWidget {
  const _NotificationCardWidget(this.notificationEntity);

  final NotificationEntity notificationEntity;

  Color _accentBackground() {
    switch (notificationEntity.accent) {
      case NotificationAccent.success:
        return AppColors.success.withValues(alpha: 0.08);
      case NotificationAccent.warning:
        return AppColors.warning.withValues(alpha: 0.1);
      case NotificationAccent.info:
        return AppColors.info.withValues(alpha: 0.1);
    }
  }

  Color _accentForeground() {
    switch (notificationEntity.accent) {
      case NotificationAccent.success:
        return AppColors.success;
      case NotificationAccent.warning:
        return AppColors.warning;
      case NotificationAccent.info:
        return AppColors.info;
    }
  }

  String _accentIconPath() {
    switch (notificationEntity.accent) {
      case NotificationAccent.success:
        return AppAssets.svg.baseSvg.correct.path;
      case NotificationAccent.warning:
        return AppAssets.svg.baseSvg.notify.path;
      case NotificationAccent.info:
        return AppAssets.svg.baseSvg.notifications.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppMargin.mH12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        boxShadow: [AppColors.containerShadow],
        border: notificationEntity.isUnread
            ? BorderDirectional(
                start: BorderSide(
                  width: AppSize.sW4,
                  color: AppColors.forth,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSize.sH50,
            height: AppSize.sH50,
            decoration: BoxDecoration(
              color: _accentBackground(),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconWidget(
                icon: _accentIconPath(),
                width: AppSize.sW20,
                height: AppSize.sH20,
                color: _accentForeground(),
              ),
            ),
          ),
          AppMargin.mW12.szW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notificationEntity.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle().setMainTextColor.s14.semiBold,
                      ),
                    ),
                    AppMargin.mW8.szW,
                    Skeleton.ignore(
                      child: IconWidget(
                        icon: AppAssets.svg.wzeinIcons.delete02.path,
                        width: AppSize.sW20,
                        height: AppSize.sH20,
                        color: AppColors.primary,
                      ).onClick(
                        onTap: () {
                          final cubit = context.read<DeleteNotificationCubit>();
                          deleteNotifications(
                            cubit: cubit,
                            title: LocaleKeys.notificationsDeleteSheetTitle,
                            message: LocaleKeys.notificationsDeleteSheetDesc,
                            onConfirm: () async =>
                                cubit.deleteOneNotification(notificationEntity),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                AppMargin.mH6.szH,
                Text(
                  notificationEntity.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle().setPrimaryColor.s12.regular,
                ),
                AppMargin.mH8.szH,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      notificationEntity.createdAt,
                      style: const TextStyle().setHintColor.s12.regular,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).paddingAll(AppPadding.pH16),
    ).onClick(
      onTap: () =>
          NotificationRoutes.navigateByType(notificationEntity.toMap),
    );
  }
}
