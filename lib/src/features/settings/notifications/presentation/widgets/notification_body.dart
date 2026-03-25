part of '../imports/view_imports.dart';

class _NotificationBody extends StatelessWidget {
  const _NotificationBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSize.sH8.szH,
        const _NotificationClearAllRow(),
        AppSize.sH12.szH,
        Expanded(
          child: PaginatedListWidget<NotificationsCubit, NotificationEntity>(
            skeletonItemCount: 4,
            config: PaginatedListConfig(
              padding: EdgeInsetsDirectional.only(
                start: AppPadding.pW12,
                end: AppPadding.pW12,
                bottom: AppPadding.pH16,
              ),
            ),
            skeletonBuilder: (context) =>
                _NotificationCardWidget(NotificationEntity.initial()),
            itemBuilder: (context, item, index) => _NotificationCardWidget(item),
            emptyWidget: EmptyWidget(
              path: AppAssets.svg.baseSvg.notificationEmpty.path,
              title: LocaleKeys.noNotificationsTitle,
              desc: LocaleKeys.noNotificationsDesc,
            ),
          ),
        ),
      ],
    );
  }
}
