import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/device_info_service.dart';
import 'package:kcars/core/services/dio_service.dart';
import 'package:kcars/core/services/secure_storage.dart';
import 'package:kcars/core/utils/permissions.dart';
import 'package:kcars/features/app_settings/data/remote/app_settings_remote.dart';
import 'package:kcars/features/app_settings/data/repo/app_settings_repo_impl.dart';
import 'package:kcars/features/app_settings/domain/repo/app_settings_repo.dart';
import 'package:kcars/features/auth/data/remote/auth_remote.dart';
import 'package:kcars/features/auth/data/repository/auth_repo_impl.dart';
import 'package:kcars/features/auth/domain/repository/auth_repo.dart';
import 'package:kcars/features/booking/data/remote/book_remote.dart';
import 'package:kcars/features/booking/data/repo/book_repo_impl.dart';
import 'package:kcars/features/booking/domain/repo/book_repo.dart';
import 'package:kcars/features/car/data/remote/car_remote.dart';
import 'package:kcars/features/car/data/repo/car_repo_impl.dart';
import 'package:kcars/features/car/domain/repo/car_repo.dart';
import 'package:kcars/features/company/data/remote/company_remote.dart';
import 'package:kcars/features/company/data/repo/company_repo_impl.dart';
import 'package:kcars/features/company/domain/company_repo.dart';
import 'package:kcars/features/review/data/remote/review_remote.dart';
import 'package:kcars/features/review/data/repo/review_repo_impl.dart';
import 'package:kcars/features/review/domain/repo/review_repo.dart';
import 'package:kcars/features/user/data/remote/user_remote.dart';
import 'package:kcars/features/user/data/repo/user_repo_impl.dart';
import 'package:kcars/features/user/domain/repo/user_repo.dart';
import 'package:upgrader/upgrader.dart';

final sl = GetIt.I;

void initServiceLocator(BuildContext context, WidgetRef ref) {
  final locale = context.locale.languageCode.toString();
  sl
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemote>(() => AuthRemoteImpl(sl()))
    //cars
    ..registerLazySingleton<CarRepo>(() => CarRepoImpl(sl()))
    ..registerLazySingleton<CarRemote>(() => CarRemoteImpl(sl()))
    //review
    ..registerLazySingleton<ReviewRepo>(() => ReviewRepoImpl(sl()))
    ..registerLazySingleton<ReviewRemote>(() => ReviewRemoteImpl(sl()))
    //User
    ..registerLazySingleton<UserRepo>(() => UserRepoImpl(sl()))
    ..registerLazySingleton<UserRemote>(() => UserRemoteImpl(sl()))
    //User
    ..registerLazySingleton<BookRepo>(() => BookRepoImpl(sl()))
    ..registerLazySingleton<BookRemote>(() => BookRemoteImpl(sl()))
    //company
    ..registerLazySingleton<CompanyRepo>(() => CompanyRepoImpl(sl()))
    ..registerLazySingleton<CompanyRemote>(() => CompanyRemoteImpl(sl()))
    //appSettings
    ..registerLazySingleton<AppSettingsRepo>(() => AppSettingsRepoImpl(sl()))
    ..registerLazySingleton<AppSettingsRemote>(
      () => AppSettingsRemoteImpl(sl()),
    )
    //other service
    ..registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>())
    ..registerLazySingleton(() => DeviceInfoSerice())
    ..registerLazySingleton(() => SecureStorage())
    ..registerLazySingleton(() => LocationService())
    ..registerLazySingleton(() => Upgrader())
    ..registerLazySingleton(
      () => DioService(
        secureStorage: sl<SecureStorage>(),
        deviceLang: locale,
        ref: ref,
      ),
    )
    ..registerLazySingleton(() => ApiService(sl<DioService>()));
}
