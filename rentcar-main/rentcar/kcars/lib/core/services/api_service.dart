import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/core/services/dio_service.dart';
import 'package:kcars/translations/locale_keys.g.dart';
import 'package:retry/retry.dart';

class ApiService {
  late final Dio _dio;
  ApiService(DioService api) : _dio = api.dio;

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic data)? fromMap,
    Function(int, int)? onSendProgress,
  }) async {
    const r = RetryOptions(maxAttempts: 3, delayFactor: Duration(seconds: 2));
    return await r.retry(() async {
      try {
        final response = await _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          onSendProgress: onSendProgress,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (fromMap != null) {
            return fromMap(response.data);
          }
          if (T == dynamic || response.data is T) {
            return response.data as T;
          }
        }

        throw ApiException(
          message: LocaleKeys.alertMessages_someThingWentWrong.tr(),
          statusCode: 400,
        );
      } on DioException catch (e) {
        if (e.response != null && e.response?.statusCode != 502) {
          throw ApiException(
            statusCode: e.response?.statusCode ?? 400,
            message: e.response.toString(),
          );
        }

        throw ApiException(
          statusCode: e.response?.statusCode ?? 400,
          message: LocaleKeys.alertMessages_netWorkError.tr(),
        );
      } catch (e) {
        throw ApiException(
          statusCode: 500,
          message: LocaleKeys.alertMessages_someThingWentWrong.tr(),
        );
      }
    }, retryIf: shouldRetryOnError);
  }
}

bool shouldRetryOnError(Exception e) {
  if (e is DioException) {
    final status = e.response?.statusCode;
    final isTimeout =
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionTimeout;

    final isRetryableStatus = status == 500 || status == 502 || status == 503;

    return isTimeout || isRetryableStatus;
  }

  return false;
}
