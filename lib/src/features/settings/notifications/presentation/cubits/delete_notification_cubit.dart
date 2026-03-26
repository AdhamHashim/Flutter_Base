part of '../imports/view_imports.dart';

class DeleteNotificationCubit extends AsyncCubit<BaseModel?> {
  DeleteNotificationCubit(this.notificationsCubit) : super(null);

  final NotificationsCubit notificationsCubit;

  Future<void> deleteOneNotification(NotificationEntity notification) async {
    if (kNotificationsUiOnly) {
      notificationsCubit.deleteOneNotification(notification);
      Go.back();
      return;
    }

    final result = await baseCrudUseCase.call(
      CrudBaseParams(
        api: '${ApiConstants.deleteNotification}${notification.id}',
        httpRequestType: HttpRequestType.delete,
        mapper: (json) => BaseModel.fromJson(json),
      ),
    );

    result.when(
      (success) {
        notificationsCubit.deleteOneNotification(notification);
        Go.back();
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: success.message,
        );
      },
      (error) {
        setError(showToast: true, errorMessage: error.message);
        Go.back();
      },
    );
  }

  Future<void> deleteAllNotifications() async {
    if (kNotificationsUiOnly) {
      notificationsCubit.clearData();
      Go.back();
      return;
    }

    final result = await baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.deleteAllNotifications,
        httpRequestType: HttpRequestType.delete,
        mapper: (json) => BaseModel.fromJson(json),
      ),
    );

    result.when(
      (success) {
        notificationsCubit.clearData();
        Go.back();
      },
      (error) {
        setError(showToast: true, errorMessage: error.message);
        Go.back();
      },
    );
  }
}
