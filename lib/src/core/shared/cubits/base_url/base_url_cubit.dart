import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../helpers/cache_service.dart';

@injectable
class BaseUrlCubit extends AsyncCubit<String?> {
  BaseUrlCubit() : super(null);

  Future<bool> fetchBaseUrl() async {
    final String? storedBaseUrl = await SecureStorage.read(
      SecureLocalVariableKeys.baseUrlKey,
    );

    final bool hasStoredBaseUrl =
        storedBaseUrl != null && storedBaseUrl.isNotEmpty;

    int attempts = 0;

    while (true) {
      try {
        final remoteConfig = await _prepareRemoteConfig();
        await _fetchAndStoreRemoteValue(
          remoteConfig: remoteConfig,
          key: SecureLocalVariableKeys.baseUrlKey,
          isRequired: true,
        );
        // لو عاوز تضيف للسوكت او اي حاجه تانيه متغييرهزي التوكن الخاص بالدفع او غيره
        //  await _fetchAndStoreRemoteValue(
        //   remoteConfig: remoteConfig,
        //   key: SecureLocalVariableKeys.baseUrlKey,بس هنا هنبدل القيمه اللي هي البيز او السوكت او اي حاجه تانيه متغييره زي التوكن الخاص بالدفع او غيره
        //   isRequired: false,
        // );

        return true;
      } catch (_) {
        attempts++;

        if (hasStoredBaseUrl && attempts >= 2) {
          return true;
        }

        if (!hasStoredBaseUrl && attempts >= 5) {
          setError(
            errorMessage: LocaleKeys.dataUpdatingNowComeLater,
            showToast: true,
          );
          return false;
        }

        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Future<FirebaseRemoteConfig> _prepareRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.fetchAndActivate();
    return remoteConfig;
  }

  Future<String> _fetchAndStoreRemoteValue({
    required FirebaseRemoteConfig remoteConfig,
    required String key,
    required bool isRequired,
  }) async {
    final value = remoteConfig.getString(key).trim();

    if (isRequired && value.isEmpty) {
      throw Exception('Empty value for key $key from remote config');
    }

    await SecureStorage.write(key, value);
    return value;
  }
}
