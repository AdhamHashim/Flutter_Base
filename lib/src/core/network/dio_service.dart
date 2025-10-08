import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../generated/locale_keys.g.dart';
import '../../config/res/config_imports.dart';
import '../error/exceptions.dart';
import '../navigation/navigator.dart';
import '../shared/base_model.dart';
import 'backend_configuation.dart';
import 'configuration_interceptor.dart';
import 'extensions.dart';
import 'network_request.dart';
import 'network_service.dart';
import 'un_authenticated_interceptor.dart';

@LazySingleton(as: NetworkService)
class DioService implements NetworkService {
  late final Dio _dio;

  DioService() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio()
      ..options.baseUrl = ConstantManager.baseUrl
      ..options.connectTimeout = const Duration(
        seconds: ConstantManager.connectTimeoutDuration,
      )
      ..options.receiveTimeout = const Duration(
        seconds: ConstantManager.recieveTimeoutDuration,
      )
      ..options.responseType = ResponseType.json;

    if (BackendConfiguation.type.isPhp) {
      _dio.interceptors.add(ConfigurationInterceptor());
    }

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 100,
        ),
      );
    }
    _dio.interceptors.add(UnAuthenticatedInterceptor.instance);
  }

  @override
  void setToken(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${token.replaceAll('Bearer', '').trim()}';
    changeLocale();
  }

  @override
  void removeToken() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  void changeLocale({String? locale}) {
    _dio.options.headers[HttpHeaders.acceptLanguageHeader] =
        locale ?? Go.context.locale.languageCode;
    _dio.options.headers['Lang'] = locale ?? Go.context.locale.languageCode;
  }

  @override
  Future<BaseModel<Model>> callApi<Model>(
    NetworkRequest networkRequest, {
    Model Function(dynamic json)? mapper,
  }) async {
    try {
      await networkRequest.prepareRequestData();
      final response = await _dio.request(
        networkRequest.path,
        data: networkRequest.hasBodyAndProgress()
            ? networkRequest.isFormData
                  ? FormData.fromMap(networkRequest.body!)
                  : networkRequest.body
            : networkRequest.body,
        queryParameters: networkRequest.queryParameters,
        onSendProgress: networkRequest.hasBodyAndProgress()
            ? networkRequest.onSendProgress
            : null,
        onReceiveProgress: networkRequest.hasBodyAndProgress()
            ? networkRequest.onReceiveProgress
            : null,
        options: Options(
          method: networkRequest.asString(),
          headers: networkRequest.headers,
        ),
      );
      if (mapper != null) {
        return BaseModel.fromJson(response.data, jsonToModel: mapper);
      } else {
        return BaseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  dynamic _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NoInternetConnectionException(LocaleKeys.app_check_internet.tr());
      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case HttpStatus.badRequest:
            throw BadRequestException(
              error.response?.data['message'] ??
                  LocaleKeys.app_bad_request.tr(),
            );
          case HttpStatus.unauthorized:
            throw UnauthorizedException(
              error.response?.data['message'] ??
                  LocaleKeys.app_bad_request.tr(),
            );
          case HttpStatus.locked:
            throw BlockedException(
              error.response?.data['message'] ??
                  LocaleKeys.app_bad_request.tr(),
            );
          case HttpStatus.forbidden:
            throw NeedActiveException(
              error.response?.data['message'] ??
                  LocaleKeys.app_bad_request.tr(),
            );
          case HttpStatus.notFound:
            throw NotFoundException(LocaleKeys.app_not_found.tr());
          case HttpStatus.conflict:
            throw ConflictException(
              error.response?.data['message'] ??
                  LocaleKeys.app_server_error.tr(),
            );
          case HttpStatus.internalServerError:
            throw InternalServerErrorException(
              error.response?.data['message'] ??
                  LocaleKeys.app_server_error.tr(),
            );
          default:
            throw ServerException(LocaleKeys.app_server_error.tr());
        }
      case DioExceptionType.cancel:
        throw ServerException(LocaleKeys.app_intenet_weakness.tr());
      case DioExceptionType.unknown:
        throw ServerException(
          error.response?.data['message'] ??
              LocaleKeys.app_exception_error.tr(),
        );
      default:
        throw ServerException(
          error.response?.data['message'] ??
              LocaleKeys.app_exception_error.tr(),
        );
    }
  }
}
