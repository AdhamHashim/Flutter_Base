import 'package:flutter_base/src/core/network/dio_service.dart';
import 'package:flutter_base/src/core/network/network_service.dart';
import 'package:flutter_base/src/core/notification/notification_service.dart';
import '../../../config/res/constants_manager.dart';
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
