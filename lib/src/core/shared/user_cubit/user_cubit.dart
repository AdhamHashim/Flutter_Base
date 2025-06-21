import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/src/config/res/constants_manager.dart';
import 'package:flutter_base/src/core/helpers/cache_service.dart' show CacheStorage, SecureStorage;
import 'package:flutter_base/src/core/network/log_interceptor.dart' show logDebug;
import 'package:flutter_base/src/core/network/network_service.dart';
import 'package:flutter_base/src/core/shared/models/user_model.dart' show UserModel;
import 'package:flutter_bloc/flutter_bloc.dart'; 
part 'user_state.dart';
part 'user_utils.dart';

const String _userKey = 'user';
const String _tokenKey = 'token';

class UserCubit extends Cubit<UserState> with UserUtils {
  UserCubit() : super(UserState.initial());

  Future<void> setUserLoggedIn({
    required UserModel user,
    required String token,
  }) async {
    await Future.wait([
      _saveUser(user),
      _saveToken(token),
    ]);
    sl<NetworkService>().setToken(token);
    emit(state.copyWith(userModel: user, userStatus: UserStatus.loggedIn));
  }

  Future<void> logout() async {
    await Future.wait([
      CacheStorage.delete(_userKey),
      SecureStorage.delete(_tokenKey),
    ]);
    _clearUser();
    emit(state.copyWith(userStatus: UserStatus.loggedOut));
  }

  Future<void> updateToken(String token) async {
    _saveToken(token);
  }

  Future<void> updateUser(UserModel user) async {
    await _saveUser(user);
    emit(state.copyWith(userModel: user));
  }

  Future<bool> init() async {
    final Map<String, dynamic>? userMap = CacheStorage.read(
      _userKey,
      isDecoded: true,
    );
    final token = await SecureStorage.read(_tokenKey);
    log('userMap $userMap, token $token');
    if (token != null && userMap != null) {
      sl<NetworkService>().setToken(token);
      emit(
        state.copyWith(
          userModel: UserModel.fromJson(userMap),
          userStatus: UserStatus.loggedIn,
        ),
      );
      return true;
    }
    return false;
  }

  void _clearUser() {
    sl<NetworkService>().removeToken();
    emit(UserState.initial());
  }

  UserModel get user => state.userModel;
  static UserCubit get instance => sl<UserCubit>();

  bool get isUserLoggedIn => state.userStatus == UserStatus.loggedIn;
}
