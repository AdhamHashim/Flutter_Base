import '../../../config/res/config_imports.dart';
import '../../notification/notification_service.dart';
import '../user_cubit/user_cubit.dart' show UserCubit;

void setUpServiceLocator() {
  setUpGeneralDependencies();
}

void setUpGeneralDependencies() {

  injector.registerLazySingleton<UserCubit>(
    () => UserCubit(),
  );

  injector.registerFactory<NotificationService>(
    () => NotificationService(),
  );
}
