import '../../../config/res/config_imports.dart';
import '../../network/dio_service.dart';
import '../../network/network_service.dart';
import '../../notification/notification_service.dart';
import '../user_cubit/user_cubit.dart' show UserCubit;

void setUpServiceLocator() {
  setUpGeneralDependencies();
}

void setUpGeneralDependencies() {
  sl.registerLazySingleton<NetworkService>(
    () => DioService(),
  );

  sl.registerLazySingleton<UserCubit>(
    () => UserCubit(),
  );

  sl.registerFactory<NotificationService>(
    () => NotificationService(),
  );
}
