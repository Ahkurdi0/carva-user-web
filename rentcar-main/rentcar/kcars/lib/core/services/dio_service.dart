import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kcars/configs/app_router.gr.dart';
import 'package:kcars/core/providers/app_router_provider.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/secure_storage.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/presentation/riverpod/auth_controller.dart';
import 'package:kcars/features/auth/presentation/riverpod/current_user_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class DioService {
  final WidgetRef ref;
  final SecureStorage secureStorage;
  final Dio _dio = Dio();

  bool _isRefreshing = false;
  Completer<String?>? _refreshCompleter;

  // Global error completers (keyed by status code or error type)
  final Map<String, Completer<void>> _errorCompleters = {};

  DioService({
    required this.secureStorage,
    required this.ref,
    String deviceLang = "en",
  }) {
    _dio.options = BaseOptions(
      baseUrl: Info.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'devicelang': deviceLang,
      },
    );
    _setupInterceptors();
  }

  Dio get dio => _dio;

  Future<String?> _refreshToken() async {
    debugPrint("_refreshToken repeated");

    if (_isRefreshing) {
      return _refreshCompleter?.future;
    }

    debugPrint("_refreshToken once");

    _isRefreshing = true;
    _refreshCompleter = Completer();

    try {
      final refreshToken = await secureStorage.getRefreshToken();
      if (refreshToken == null) {
        _refreshCompleter?.complete(null);
        return null;
      }

      final dioNoInterceptor = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $refreshToken',
          },
        ),
      );

      final response = await dioNoInterceptor.post(
        "${Info.baseUrl}/auth/refreshToken",
      );

      final newAccessToken = response.data["accessToken"];
      final newRefreshToken = response.data["refreshToken"];

      if (newAccessToken != null && newRefreshToken != null) {
        await secureStorage.setSession(
          accessToken: newAccessToken,
          refreshToekn: newRefreshToken,
        );
        _refreshCompleter?.complete(newAccessToken);
        return newAccessToken;
      }

      _refreshCompleter?.complete(null);
      return null;
    } catch (e) {
      _refreshCompleter?.complete(null);
      debugPrint("Token refresh failed: $e");
      return null;
    } finally {
      _isRefreshing = false;
    }
  }

  void _forceLogout({bool force = false}) async {
    debugPrint("Forcing logout...");
    ref.read(authControllerProvider.notifier).logout(Auth(allDevices: false));
    ref.read(appRouterProvider).replaceAll([const WelcomeRoute()]);
    ref.read(currentUserControllerProvider.notifier).logout();
    await secureStorage.deleteAll();
    OneSignal.logout();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await secureStorage.getAcessToken();

          if (accessToken != null) {
            if (JwtDecoder.isExpired(accessToken)) {
              final newToken = await _refreshToken();
              if (newToken != null) {
                options.headers['Authorization'] = 'Bearer $newToken';
              }
            } else {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }

          return handler.next(options);
        },

        onError: (e, handler) async {
          final statusCode = e.response?.statusCode;
          final path = e.requestOptions.path;
          final hadToken = e.requestOptions.headers.containsKey(
            'Authorization',
          );

          // --- Handle 401 errors ---
          if (statusCode == 401 &&
              hadToken &&
              !path.contains("/refreshToken")) {
            final completerKey = '401';

            // Wait if already handling a 401
            if (_errorCompleters.containsKey(completerKey)) {
              await _errorCompleters[completerKey]?.future;
              return handler.next(e);
            }

            final errorCompleter = Completer<void>();
            _errorCompleters[completerKey] = errorCompleter;

            try {
              final newToken = await _refreshToken();
              if (newToken != null) {
                final retryRequest = e.requestOptions;
                retryRequest.headers['Authorization'] = 'Bearer $newToken';
                final retryResponse = await _dio.fetch(retryRequest);
                errorCompleter.complete();
                _errorCompleters.remove(completerKey);
                return handler.resolve(retryResponse);
              } else {
                _forceLogout();
                errorCompleter.complete();
                _errorCompleters.remove(completerKey);
                return handler.reject(e);
              }
            } catch (retryError) {
              errorCompleter.complete();
              _errorCompleters.remove(completerKey);
              return handler.reject(retryError as DioException);
            }
          }

          // --- Handle 401 on refresh token endpoint ---
          if (statusCode == 401 && path.contains("/refreshToken")) {
            _forceLogout(force: true);
            return handler.reject(e);
          }

          // --- Handle other global errors (e.g., 500) ---
          if (statusCode != null && statusCode >= 500) {
            final completerKey = 'error_$statusCode';

            if (_errorCompleters.containsKey(completerKey)) {
              await _errorCompleters[completerKey]?.future;
              return handler.next(e);
            }

            final errorCompleter = Completer<void>();
            _errorCompleters[completerKey] = errorCompleter;

            // Optionally, you can add global handling here (e.g., show snackbar)
            debugPrint("Handling global error $statusCode for multiple calls");

            // Simulate async handling
            await Future.delayed(const Duration(milliseconds: 100));
            errorCompleter.complete();
            _errorCompleters.remove(completerKey);
          }

          return handler.next(e);
        },
      ),
    );
  }
}

class DelayInterceptor extends Interceptor {
  final int delayMilliseconds;

  DelayInterceptor({this.delayMilliseconds = 3000});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Introduce a delay
    await Future.delayed(Duration(milliseconds: delayMilliseconds));
    return super.onRequest(options, handler);
  }
}
