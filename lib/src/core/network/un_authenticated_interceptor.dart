import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef UnAuthenticatedCallBackType = void Function();

class UnAuthenticatedInterceptor extends Interceptor {
  UnAuthenticatedInterceptor._();

  static UnAuthenticatedInterceptor? _instance;

  static UnAuthenticatedInterceptor get instance =>
      _instance ??= UnAuthenticatedInterceptor._();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data =
        response.data is String ? json.decode(response.data) : response.data;
    if (response.statusCode == 401 ||
        (response.statusCode == 200 &&
            (data['key'] == "unauthenticated" || data['key'] == "block"))) {
      notifyListeners();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      notifyListeners();
    }
    super.onError(err, handler);
  }

  final ObserverList<UnAuthenticatedCallBackType> _listeners =
      ObserverList<UnAuthenticatedCallBackType>();

  void addListener(UnAuthenticatedCallBackType listener) {
    _listeners.add(listener);
  }

  void removeListener(UnAuthenticatedCallBackType listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    if (_listeners.isEmpty) {
      return;
    }

    final localListeners = List<UnAuthenticatedCallBackType>.from(_listeners);
    for (var listener in localListeners) {
      if (_listeners.contains(listener)) {
        listener();
      }
    }
  }

  void dispose() {
    _listeners.clear();
  }
}
