part of '../imports/view_imports.dart';

class _NotificationClearAllRow extends StatelessWidget {
  const _NotificationClearAllRow();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, AsyncState<PaginatedData<NotificationEntity>>>(
      builder: (context, state) {
        if (state.data.items.isEmpty) {
          return const SizedBox.shrink();
        }
        return Text(
          LocaleKeys.notificationsDeleteAllText,
          style: const TextStyle().setErrorColor.s14.semiBold,
        ).paddingSymmetric(horizontal: AppPadding.pW12).onClick(
              onTap: () {
                final cubit = context.read<DeleteNotificationCubit>();
                deleteNotifications(
                  cubit: cubit,
                  title: LocaleKeys.notificationsDeleteAllNotifications,
                  onConfirm: () async => cubit.deleteAllNotifications(),
                );
              },
            );
      },
    );
  }
}
