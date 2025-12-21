import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/res/config_imports.dart';
import '../../../base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../helpers/cache_service.dart';

@injectable
class BaseUrlCubit extends AsyncCubit<String?> {
  BaseUrlCubit() : super(null);

  Future<bool> fetchBaseUrl() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      // Set config settings for fetch timeout and minimum fetch interval
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Fetch and activate the remote config
      await remoteConfig.fetchAndActivate();

      // Get the base URL from remote config
      final baseUrl = remoteConfig.getString(
        SecureLocalVariableKeys.baseUrlKey,
      );

      // Get the Socet_Io URL from remote config
      final socetIoUrl = remoteConfig.getString(
        SecureLocalVariableKeys.socetIoUrl,
      );

      if (baseUrl.isEmpty) {
        return false;
      }

      await SecureStorage.write(SecureLocalVariableKeys.baseUrlKey, baseUrl);
      await SecureStorage.write(SecureLocalVariableKeys.socetIoUrl, socetIoUrl);

      return true;
    } catch (e) {
      return await fetchBaseUrl();
    }
  }
}
