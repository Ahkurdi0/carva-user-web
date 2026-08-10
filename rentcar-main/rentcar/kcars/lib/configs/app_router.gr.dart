// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i76;
import 'package:collection/collection.dart' as _i82;
import 'package:flutter/material.dart' as _i77;
import 'package:flutter_map/flutter_map.dart' as _i96;
import 'package:kcars/features/app_settings/data/model/sliders.dart' as _i95;
import 'package:kcars/features/app_settings/data/model/suppprt.dart' as _i90;
import 'package:kcars/features/app_settings/presentation/screen/brands_screen.dart'
    as _i9;
import 'package:kcars/features/app_settings/presentation/screen/car_types_screen.dart'
    as _i12;
import 'package:kcars/features/app_settings/presentation/screen/city_screen.dart'
    as _i14;
import 'package:kcars/features/app_settings/presentation/screen/company_statiscs_screen.dart'
    as _i22;
import 'package:kcars/features/app_settings/presentation/screen/new_edit_brand_screen.dart'
    as _i38;
import 'package:kcars/features/app_settings/presentation/screen/new_edit_car_types_screen.dart'
    as _i40;
import 'package:kcars/features/app_settings/presentation/screen/new_edit_city_screen.dart'
    as _i41;
import 'package:kcars/features/app_settings/presentation/screen/new_edit_support.screen.dart'
    as _i45;
import 'package:kcars/features/app_settings/presentation/screen/new_edit_town_screen.dart'
    as _i46;
import 'package:kcars/features/app_settings/presentation/screen/new_notification_screen.dart'
    as _i47;
import 'package:kcars/features/app_settings/presentation/screen/new_slider_screen.dart'
    as _i50;
import 'package:kcars/features/app_settings/presentation/screen/sliders_screen.dart'
    as _i65;
import 'package:kcars/features/app_settings/presentation/screen/statistics_screen.dart'
    as _i67;
import 'package:kcars/features/app_settings/presentation/screen/support_screen.dart'
    as _i68;
import 'package:kcars/features/auth/data/model/auth.dart' as _i97;
import 'package:kcars/features/auth/data/model/permissions.dart' as _i81;
import 'package:kcars/features/auth/data/model/profile.dart' as _i78;
import 'package:kcars/features/auth/presentation/screens/auth_screens/login_screen.dart'
    as _i32;
import 'package:kcars/features/auth/presentation/screens/auth_screens/signup_screen.dart'
    as _i64;
import 'package:kcars/features/auth/presentation/screens/modal_sheet.dart'
    as _i37;
import 'package:kcars/features/auth/presentation/screens/reset_password/reset_password_screen.dart'
    as _i57;
import 'package:kcars/features/auth/presentation/screens/reset_password/reset_send_screen.dart'
    as _i58;
import 'package:kcars/features/auth/presentation/screens/reset_password/reset_verify_screen.dart'
    as _i59;
import 'package:kcars/features/auth/presentation/screens/update_email/update_send_screen.dart'
    as _i69;
import 'package:kcars/features/auth/presentation/screens/verify_email/verify_new_email_screen.dart'
    as _i73;
import 'package:kcars/features/auth/presentation/screens/verify_email/verify_send_screen.dart'
    as _i74;
import 'package:kcars/features/booking/presentation/screen/all_books_screen.dart'
    as _i1;
import 'package:kcars/features/booking/presentation/screen/booked_screen.dart'
    as _i7;
import 'package:kcars/features/booking/presentation/screen/search_books_screen.dart'
    as _i60;
import 'package:kcars/features/car/data/model/brand.dart' as _i85;
import 'package:kcars/features/car/data/model/car.dart' as _i80;
import 'package:kcars/features/car/data/model/car_type.dart' as _i86;
import 'package:kcars/features/car/data/model/city.dart' as _i87;
import 'package:kcars/features/car/data/model/enums.dart' as _i84;
import 'package:kcars/features/car/data/model/paln.dart' as _i94;
import 'package:kcars/features/car/data/model/promotion.dart' as _i92;
import 'package:kcars/features/car/data/model/rental_plan.dart' as _i93;
import 'package:kcars/features/car/data/model/town.dart' as _i91;
import 'package:kcars/features/car/presentation/screens/all_cars_screen.dart'
    as _i3;
import 'package:kcars/features/car/presentation/screens/booking_screen.dart'
    as _i8;
import 'package:kcars/features/car/presentation/screens/car_details_screen.dart'
    as _i10;
import 'package:kcars/features/car/presentation/screens/car_screen.dart'
    as _i13;
import 'package:kcars/features/car/presentation/screens/explorer_map_screen.dart'
    as _i27;
import 'package:kcars/features/car/presentation/screens/favorite_screen.dart'
    as _i28;
import 'package:kcars/features/car/presentation/screens/featured_cars_screen.dart'
    as _i29;
import 'package:kcars/features/car/presentation/screens/filter_screen.dart'
    as _i30;
import 'package:kcars/features/car/presentation/screens/map_screen.dart'
    as _i36;
import 'package:kcars/features/car/presentation/screens/search_car_screen.dart'
    as _i61;
import 'package:kcars/features/company/data/model/company.dart' as _i88;
import 'package:kcars/features/company/data/model/contact.dart' as _i89;
import 'package:kcars/features/company/presentation/screen/all_companies_screen.dart'
    as _i4;
import 'package:kcars/features/company/presentation/screen/companies_review_screen.dart'
    as _i15;
import 'package:kcars/features/company/presentation/screen/companies_screen.dart'
    as _i16;
import 'package:kcars/features/company/presentation/screen/company_booked_screen.dart'
    as _i17;
import 'package:kcars/features/company/presentation/screen/company_car_reviews_screen.dart'
    as _i18;
import 'package:kcars/features/company/presentation/screen/company_cars_screen.dart'
    as _i19;
import 'package:kcars/features/company/presentation/screen/company_details_screen_screen.dart'
    as _i20;
import 'package:kcars/features/company/presentation/screen/edit_company_screen.dart'
    as _i24;
import 'package:kcars/features/company/presentation/screen/new_edit_car_screen.dart'
    as _i39;
import 'package:kcars/features/company/presentation/screen/new_edit_company_screen.dart'
    as _i42;
import 'package:kcars/features/company/presentation/screen/new_edit_contact_screen.dart'
    as _i43;
import 'package:kcars/features/company/presentation/screen/new_edit_featured_screen.dart'
    as _i44;
import 'package:kcars/features/company/presentation/screen/new_promotion_screen.dart'
    as _i48;
import 'package:kcars/features/company/presentation/screen/new_rental_plan_screen.dart'
    as _i49;
import 'package:kcars/features/company/presentation/screen/promotions_screen.dart'
    as _i56;
import 'package:kcars/features/company/presentation/screen/sorting_images_screen.dart'
    as _i66;
import 'package:kcars/features/company/presentation/views/map_screen.dart'
    as _i55;
import 'package:kcars/features/review/presentation/screen/all_car_review_screen.dart'
    as _i2;
import 'package:kcars/features/review/presentation/screen/all_company_review_screen.dart'
    as _i5;
import 'package:kcars/features/review/presentation/screen/car_review_flag_screen.dart'
    as _i11;
import 'package:kcars/features/review/presentation/screen/company_reviews_flag_screen.dart'
    as _i21;
import 'package:kcars/features/user/data/model/account_status.dart' as _i79;
import 'package:kcars/features/user/presentation/screen/ban_user_screen.dart'
    as _i6;
import 'package:kcars/features/user/presentation/screen/edit_profile_screen.dart'
    as _i25;
import 'package:kcars/features/user/presentation/screen/permissions_screen.dart'
    as _i54;
import 'package:kcars/features/user/presentation/screen/search_user_screen.dart'
    as _i62;
import 'package:kcars/features/user/presentation/screen/settings_screen.dart'
    as _i63;
import 'package:kcars/features/user/presentation/screen/users_screen.dart'
    as _i72;
import 'package:kcars/features/user/presentation/user_screens/update_user_password_screen.dart'
    as _i70;
import 'package:kcars/features/user/presentation/user_screens/user_details_screen.dart'
    as _i71;
import 'package:kcars/screens/connectivity_screen.dart' as _i23;
import 'package:kcars/screens/empty_route.dart' as _i26;
import 'package:kcars/screens/home_route.dart' as _i31;
import 'package:kcars/screens/main_admin_screen.dart' as _i33;
import 'package:kcars/screens/main_company_screen.dart' as _i34;
import 'package:kcars/screens/main_screen.dart' as _i35;
import 'package:kcars/screens/not_loggedin_main_screen.dart' as _i51;
import 'package:kcars/screens/not_loggedin_screen.dart' as _i52;
import 'package:kcars/screens/not_loggedin_trip_screen.dart' as _i53;
import 'package:kcars/screens/welcome_screen.dart' as _i75;
import 'package:latlong2/latlong.dart' as _i83;

/// generated route for
/// [_i1.AllBooksScreen]
class AllBooksRoute extends _i76.PageRouteInfo<void> {
  const AllBooksRoute({List<_i76.PageRouteInfo>? children})
    : super(AllBooksRoute.name, initialChildren: children);

  static const String name = 'AllBooksRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i1.AllBooksScreen();
    },
  );
}

/// generated route for
/// [_i2.AllCarReviewScreen]
class AllCarReviewRoute extends _i76.PageRouteInfo<void> {
  const AllCarReviewRoute({List<_i76.PageRouteInfo>? children})
    : super(AllCarReviewRoute.name, initialChildren: children);

  static const String name = 'AllCarReviewRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i2.AllCarReviewScreen();
    },
  );
}

/// generated route for
/// [_i3.AllCarsScreen]
class AllCarsRoute extends _i76.PageRouteInfo<void> {
  const AllCarsRoute({List<_i76.PageRouteInfo>? children})
    : super(AllCarsRoute.name, initialChildren: children);

  static const String name = 'AllCarsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i3.AllCarsScreen();
    },
  );
}

/// generated route for
/// [_i4.AllCompaniesScreen]
class AllCompaniesRoute extends _i76.PageRouteInfo<void> {
  const AllCompaniesRoute({List<_i76.PageRouteInfo>? children})
    : super(AllCompaniesRoute.name, initialChildren: children);

  static const String name = 'AllCompaniesRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i4.AllCompaniesScreen();
    },
  );
}

/// generated route for
/// [_i5.AllCompanyReviewScreen]
class AllCompanyReviewRoute extends _i76.PageRouteInfo<void> {
  const AllCompanyReviewRoute({List<_i76.PageRouteInfo>? children})
    : super(AllCompanyReviewRoute.name, initialChildren: children);

  static const String name = 'AllCompanyReviewRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i5.AllCompanyReviewScreen();
    },
  );
}

/// generated route for
/// [_i6.BanUserScreen]
class BanUserRoute extends _i76.PageRouteInfo<BanUserRouteArgs> {
  BanUserRoute({
    _i77.Key? key,
    required _i78.Profile profile,
    _i79.AccountStatus? accountStatus,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         BanUserRoute.name,
         args: BanUserRouteArgs(
           key: key,
           profile: profile,
           accountStatus: accountStatus,
         ),
         initialChildren: children,
       );

  static const String name = 'BanUserRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BanUserRouteArgs>();
      return _i6.BanUserScreen(
        key: args.key,
        profile: args.profile,
        accountStatus: args.accountStatus,
      );
    },
  );
}

class BanUserRouteArgs {
  const BanUserRouteArgs({this.key, required this.profile, this.accountStatus});

  final _i77.Key? key;

  final _i78.Profile profile;

  final _i79.AccountStatus? accountStatus;

  @override
  String toString() {
    return 'BanUserRouteArgs{key: $key, profile: $profile, accountStatus: $accountStatus}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BanUserRouteArgs) return false;
    return key == other.key &&
        profile == other.profile &&
        accountStatus == other.accountStatus;
  }

  @override
  int get hashCode => key.hashCode ^ profile.hashCode ^ accountStatus.hashCode;
}

/// generated route for
/// [_i7.BookedScreen]
class BookedRoute extends _i76.PageRouteInfo<void> {
  const BookedRoute({List<_i76.PageRouteInfo>? children})
    : super(BookedRoute.name, initialChildren: children);

  static const String name = 'BookedRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i7.BookedScreen();
    },
  );
}

/// generated route for
/// [_i8.BookingScreen]
class BookingRoute extends _i76.PageRouteInfo<BookingRouteArgs> {
  BookingRoute({
    _i77.Key? key,
    required _i80.Car car,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         BookingRoute.name,
         args: BookingRouteArgs(key: key, car: car),
         initialChildren: children,
       );

  static const String name = 'BookingRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingRouteArgs>();
      return _i8.BookingScreen(key: args.key, car: args.car);
    },
  );
}

class BookingRouteArgs {
  const BookingRouteArgs({this.key, required this.car});

  final _i77.Key? key;

  final _i80.Car car;

  @override
  String toString() {
    return 'BookingRouteArgs{key: $key, car: $car}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BookingRouteArgs) return false;
    return key == other.key && car == other.car;
  }

  @override
  int get hashCode => key.hashCode ^ car.hashCode;
}

/// generated route for
/// [_i9.BrandsScreen]
class BrandsRoute extends _i76.PageRouteInfo<void> {
  const BrandsRoute({List<_i76.PageRouteInfo>? children})
    : super(BrandsRoute.name, initialChildren: children);

  static const String name = 'BrandsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i9.BrandsScreen();
    },
  );
}

/// generated route for
/// [_i10.CarDetailsScreen]
class CarDetailsRoute extends _i76.PageRouteInfo<CarDetailsRouteArgs> {
  CarDetailsRoute({
    _i77.Key? key,
    required String carId,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         CarDetailsRoute.name,
         args: CarDetailsRouteArgs(key: key, carId: carId),
         initialChildren: children,
       );

  static const String name = 'CarDetailsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CarDetailsRouteArgs>();
      return _i10.CarDetailsScreen(key: args.key, carId: args.carId);
    },
  );
}

class CarDetailsRouteArgs {
  const CarDetailsRouteArgs({this.key, required this.carId});

  final _i77.Key? key;

  final String carId;

  @override
  String toString() {
    return 'CarDetailsRouteArgs{key: $key, carId: $carId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CarDetailsRouteArgs) return false;
    return key == other.key && carId == other.carId;
  }

  @override
  int get hashCode => key.hashCode ^ carId.hashCode;
}

/// generated route for
/// [_i11.CarReviewsFlagScreen]
class CarReviewsFlagRoute extends _i76.PageRouteInfo<void> {
  const CarReviewsFlagRoute({List<_i76.PageRouteInfo>? children})
    : super(CarReviewsFlagRoute.name, initialChildren: children);

  static const String name = 'CarReviewsFlagRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i11.CarReviewsFlagScreen();
    },
  );
}

/// generated route for
/// [_i12.CarTypesScreen]
class CarTypesRoute extends _i76.PageRouteInfo<void> {
  const CarTypesRoute({List<_i76.PageRouteInfo>? children})
    : super(CarTypesRoute.name, initialChildren: children);

  static const String name = 'CarTypesRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i12.CarTypesScreen();
    },
  );
}

/// generated route for
/// [_i13.CarsScreen]
class CarsRoute extends _i76.PageRouteInfo<CarsRouteArgs> {
  CarsRoute({
    _i77.Key? key,
    bool isLogged = true,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         CarsRoute.name,
         args: CarsRouteArgs(key: key, isLogged: isLogged),
         initialChildren: children,
       );

  static const String name = 'CarsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CarsRouteArgs>(
        orElse: () => const CarsRouteArgs(),
      );
      return _i13.CarsScreen(key: args.key, isLogged: args.isLogged);
    },
  );
}

class CarsRouteArgs {
  const CarsRouteArgs({this.key, this.isLogged = true});

  final _i77.Key? key;

  final bool isLogged;

  @override
  String toString() {
    return 'CarsRouteArgs{key: $key, isLogged: $isLogged}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CarsRouteArgs) return false;
    return key == other.key && isLogged == other.isLogged;
  }

  @override
  int get hashCode => key.hashCode ^ isLogged.hashCode;
}

/// generated route for
/// [_i14.CityScreen]
class CityRoute extends _i76.PageRouteInfo<void> {
  const CityRoute({List<_i76.PageRouteInfo>? children})
    : super(CityRoute.name, initialChildren: children);

  static const String name = 'CityRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i14.CityScreen();
    },
  );
}

/// generated route for
/// [_i15.CompaniesReviewScreen]
class CompaniesReviewRoute extends _i76.PageRouteInfo<void> {
  const CompaniesReviewRoute({List<_i76.PageRouteInfo>? children})
    : super(CompaniesReviewRoute.name, initialChildren: children);

  static const String name = 'CompaniesReviewRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i15.CompaniesReviewScreen();
    },
  );
}

/// generated route for
/// [_i16.CompaniesScreen]
class CompaniesRoute extends _i76.PageRouteInfo<void> {
  const CompaniesRoute({List<_i76.PageRouteInfo>? children})
    : super(CompaniesRoute.name, initialChildren: children);

  static const String name = 'CompaniesRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i16.CompaniesScreen();
    },
  );
}

/// generated route for
/// [_i17.CompanyBookedScreen]
class CompanyBookedRoute extends _i76.PageRouteInfo<void> {
  const CompanyBookedRoute({List<_i76.PageRouteInfo>? children})
    : super(CompanyBookedRoute.name, initialChildren: children);

  static const String name = 'CompanyBookedRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i17.CompanyBookedScreen();
    },
  );
}

/// generated route for
/// [_i18.CompanyCarReviewsScreen]
class CompanyCarReviewsRoute extends _i76.PageRouteInfo<void> {
  const CompanyCarReviewsRoute({List<_i76.PageRouteInfo>? children})
    : super(CompanyCarReviewsRoute.name, initialChildren: children);

  static const String name = 'CompanyCarReviewsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i18.CompanyCarReviewsScreen();
    },
  );
}

/// generated route for
/// [_i19.CompanyCarsScreen]
class CompanyCarsRoute extends _i76.PageRouteInfo<void> {
  const CompanyCarsRoute({List<_i76.PageRouteInfo>? children})
    : super(CompanyCarsRoute.name, initialChildren: children);

  static const String name = 'CompanyCarsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i19.CompanyCarsScreen();
    },
  );
}

/// generated route for
/// [_i20.CompanyDetailsScreen]
class CompanyDetailsRoute extends _i76.PageRouteInfo<CompanyDetailsRouteArgs> {
  CompanyDetailsRoute({
    _i77.Key? key,
    required String companyId,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         CompanyDetailsRoute.name,
         args: CompanyDetailsRouteArgs(key: key, companyId: companyId),
         initialChildren: children,
       );

  static const String name = 'CompanyDetailsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyDetailsRouteArgs>();
      return _i20.CompanyDetailsScreen(
        key: args.key,
        companyId: args.companyId,
      );
    },
  );
}

class CompanyDetailsRouteArgs {
  const CompanyDetailsRouteArgs({this.key, required this.companyId});

  final _i77.Key? key;

  final String companyId;

  @override
  String toString() {
    return 'CompanyDetailsRouteArgs{key: $key, companyId: $companyId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyDetailsRouteArgs) return false;
    return key == other.key && companyId == other.companyId;
  }

  @override
  int get hashCode => key.hashCode ^ companyId.hashCode;
}

/// generated route for
/// [_i21.CompanyReviewsFlagScreen]
class CompanyReviewsFlagRoute extends _i76.PageRouteInfo<void> {
  const CompanyReviewsFlagRoute({List<_i76.PageRouteInfo>? children})
    : super(CompanyReviewsFlagRoute.name, initialChildren: children);

  static const String name = 'CompanyReviewsFlagRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i21.CompanyReviewsFlagScreen();
    },
  );
}

/// generated route for
/// [_i22.CompanyStatiscsScreen]
class CompanyStatiscsRoute extends _i76.PageRouteInfo<void> {
  const CompanyStatiscsRoute({List<_i76.PageRouteInfo>? children})
    : super(CompanyStatiscsRoute.name, initialChildren: children);

  static const String name = 'CompanyStatiscsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i22.CompanyStatiscsScreen();
    },
  );
}

/// generated route for
/// [_i23.ConnectivityScreen]
class ConnectivityRoute extends _i76.PageRouteInfo<void> {
  const ConnectivityRoute({List<_i76.PageRouteInfo>? children})
    : super(ConnectivityRoute.name, initialChildren: children);

  static const String name = 'ConnectivityRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i23.ConnectivityScreen();
    },
  );
}

/// generated route for
/// [_i24.EditCompanyScreen]
class EditCompanyRoute extends _i76.PageRouteInfo<void> {
  const EditCompanyRoute({List<_i76.PageRouteInfo>? children})
    : super(EditCompanyRoute.name, initialChildren: children);

  static const String name = 'EditCompanyRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i24.EditCompanyScreen();
    },
  );
}

/// generated route for
/// [_i25.EditProfileScreen]
class EditProfileRoute extends _i76.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i77.Key? key,
    required _i78.Profile profile,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(key: key, profile: profile),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i25.EditProfileScreen(key: args.key, profile: args.profile);
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({this.key, required this.profile});

  final _i77.Key? key;

  final _i78.Profile profile;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, profile: $profile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditProfileRouteArgs) return false;
    return key == other.key && profile == other.profile;
  }

  @override
  int get hashCode => key.hashCode ^ profile.hashCode;
}

/// generated route for
/// [_i26.EmptyScreen]
class EmptyRoute extends _i76.PageRouteInfo<void> {
  const EmptyRoute({List<_i76.PageRouteInfo>? children})
    : super(EmptyRoute.name, initialChildren: children);

  static const String name = 'EmptyRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i26.EmptyScreen();
    },
  );
}

/// generated route for
/// [_i27.ExplorerMapScreen]
class ExplorerMapRoute extends _i76.PageRouteInfo<void> {
  const ExplorerMapRoute({List<_i76.PageRouteInfo>? children})
    : super(ExplorerMapRoute.name, initialChildren: children);

  static const String name = 'ExplorerMapRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i27.ExplorerMapScreen();
    },
  );
}

/// generated route for
/// [_i28.FavoriteScreen]
class FavoriteRoute extends _i76.PageRouteInfo<void> {
  const FavoriteRoute({List<_i76.PageRouteInfo>? children})
    : super(FavoriteRoute.name, initialChildren: children);

  static const String name = 'FavoriteRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i28.FavoriteScreen();
    },
  );
}

/// generated route for
/// [_i29.FeaturedCarsScreen]
class FeaturedCarsRoute extends _i76.PageRouteInfo<void> {
  const FeaturedCarsRoute({List<_i76.PageRouteInfo>? children})
    : super(FeaturedCarsRoute.name, initialChildren: children);

  static const String name = 'FeaturedCarsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i29.FeaturedCarsScreen();
    },
  );
}

/// generated route for
/// [_i30.FilterScreen]
class FilterRoute extends _i76.PageRouteInfo<void> {
  const FilterRoute({List<_i76.PageRouteInfo>? children})
    : super(FilterRoute.name, initialChildren: children);

  static const String name = 'FilterRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i30.FilterScreen();
    },
  );
}

/// generated route for
/// [_i31.HomeScreen]
class HomeRoute extends _i76.PageRouteInfo<void> {
  const HomeRoute({List<_i76.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i31.HomeScreen();
    },
  );
}

/// generated route for
/// [_i32.LoginScreen]
class LoginRoute extends _i76.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i77.Key? key,
    bool backButton = true,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         LoginRoute.name,
         args: LoginRouteArgs(key: key, backButton: backButton),
         initialChildren: children,
       );

  static const String name = 'LoginRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i32.LoginScreen(key: args.key, backButton: args.backButton);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.backButton = true});

  final _i77.Key? key;

  final bool backButton;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, backButton: $backButton}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key && backButton == other.backButton;
  }

  @override
  int get hashCode => key.hashCode ^ backButton.hashCode;
}

/// generated route for
/// [_i33.MainAdminScreen]
class MainAdminRoute extends _i76.PageRouteInfo<MainAdminRouteArgs> {
  MainAdminRoute({
    _i77.Key? key,
    required List<_i81.Permissions> permissions,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         MainAdminRoute.name,
         args: MainAdminRouteArgs(key: key, permissions: permissions),
         initialChildren: children,
       );

  static const String name = 'MainAdminRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainAdminRouteArgs>();
      return _i33.MainAdminScreen(key: args.key, permissions: args.permissions);
    },
  );
}

class MainAdminRouteArgs {
  const MainAdminRouteArgs({this.key, required this.permissions});

  final _i77.Key? key;

  final List<_i81.Permissions> permissions;

  @override
  String toString() {
    return 'MainAdminRouteArgs{key: $key, permissions: $permissions}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainAdminRouteArgs) return false;
    return key == other.key &&
        const _i82.ListEquality().equals(permissions, other.permissions);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i82.ListEquality().hash(permissions);
}

/// generated route for
/// [_i34.MainCompanyScreen]
class MainCompanyRoute extends _i76.PageRouteInfo<void> {
  const MainCompanyRoute({List<_i76.PageRouteInfo>? children})
    : super(MainCompanyRoute.name, initialChildren: children);

  static const String name = 'MainCompanyRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i34.MainCompanyScreen();
    },
  );
}

/// generated route for
/// [_i35.MainScreen]
class MainRoute extends _i76.PageRouteInfo<void> {
  const MainRoute({List<_i76.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i35.MainScreen();
    },
  );
}

/// generated route for
/// [_i36.MapScreen]
class MapRoute extends _i76.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    _i77.Key? key,
    required _i83.LatLng latLng,
    String? image,
    _i84.MapMarkerType markerType = _i84.MapMarkerType.car,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         MapRoute.name,
         args: MapRouteArgs(
           key: key,
           latLng: latLng,
           image: image,
           markerType: markerType,
         ),
         initialChildren: children,
       );

  static const String name = 'MapRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MapRouteArgs>();
      return _i36.MapScreen(
        key: args.key,
        latLng: args.latLng,
        image: args.image,
        markerType: args.markerType,
      );
    },
  );
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    required this.latLng,
    this.image,
    this.markerType = _i84.MapMarkerType.car,
  });

  final _i77.Key? key;

  final _i83.LatLng latLng;

  final String? image;

  final _i84.MapMarkerType markerType;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, latLng: $latLng, image: $image, markerType: $markerType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapRouteArgs) return false;
    return key == other.key &&
        latLng == other.latLng &&
        image == other.image &&
        markerType == other.markerType;
  }

  @override
  int get hashCode =>
      key.hashCode ^ latLng.hashCode ^ image.hashCode ^ markerType.hashCode;
}

/// generated route for
/// [_i37.ModalSheetScreen]
class ModalSheetRoute extends _i76.PageRouteInfo<void> {
  const ModalSheetRoute({List<_i76.PageRouteInfo>? children})
    : super(ModalSheetRoute.name, initialChildren: children);

  static const String name = 'ModalSheetRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i37.ModalSheetScreen();
    },
  );
}

/// generated route for
/// [_i38.NewEditBrandScreen]
class NewEditBrandRoute extends _i76.PageRouteInfo<NewEditBrandRouteArgs> {
  NewEditBrandRoute({
    _i77.Key? key,
    _i85.Brand? brand,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditBrandRoute.name,
         args: NewEditBrandRouteArgs(key: key, brand: brand),
         initialChildren: children,
       );

  static const String name = 'NewEditBrandRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditBrandRouteArgs>(
        orElse: () => const NewEditBrandRouteArgs(),
      );
      return _i38.NewEditBrandScreen(key: args.key, brand: args.brand);
    },
  );
}

class NewEditBrandRouteArgs {
  const NewEditBrandRouteArgs({this.key, this.brand});

  final _i77.Key? key;

  final _i85.Brand? brand;

  @override
  String toString() {
    return 'NewEditBrandRouteArgs{key: $key, brand: $brand}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditBrandRouteArgs) return false;
    return key == other.key && brand == other.brand;
  }

  @override
  int get hashCode => key.hashCode ^ brand.hashCode;
}

/// generated route for
/// [_i39.NewEditCarScreen]
class NewEditCarRoute extends _i76.PageRouteInfo<NewEditCarRouteArgs> {
  NewEditCarRoute({
    _i77.Key? key,
    _i80.Car? car,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditCarRoute.name,
         args: NewEditCarRouteArgs(key: key, car: car),
         initialChildren: children,
       );

  static const String name = 'NewEditCarRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditCarRouteArgs>(
        orElse: () => const NewEditCarRouteArgs(),
      );
      return _i39.NewEditCarScreen(key: args.key, car: args.car);
    },
  );
}

class NewEditCarRouteArgs {
  const NewEditCarRouteArgs({this.key, this.car});

  final _i77.Key? key;

  final _i80.Car? car;

  @override
  String toString() {
    return 'NewEditCarRouteArgs{key: $key, car: $car}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditCarRouteArgs) return false;
    return key == other.key && car == other.car;
  }

  @override
  int get hashCode => key.hashCode ^ car.hashCode;
}

/// generated route for
/// [_i40.NewEditCarTypeScreen]
class NewEditCarTypeRoute extends _i76.PageRouteInfo<NewEditCarTypeRouteArgs> {
  NewEditCarTypeRoute({
    _i77.Key? key,
    _i86.CarType? carType,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditCarTypeRoute.name,
         args: NewEditCarTypeRouteArgs(key: key, carType: carType),
         initialChildren: children,
       );

  static const String name = 'NewEditCarTypeRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditCarTypeRouteArgs>(
        orElse: () => const NewEditCarTypeRouteArgs(),
      );
      return _i40.NewEditCarTypeScreen(key: args.key, carType: args.carType);
    },
  );
}

class NewEditCarTypeRouteArgs {
  const NewEditCarTypeRouteArgs({this.key, this.carType});

  final _i77.Key? key;

  final _i86.CarType? carType;

  @override
  String toString() {
    return 'NewEditCarTypeRouteArgs{key: $key, carType: $carType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditCarTypeRouteArgs) return false;
    return key == other.key && carType == other.carType;
  }

  @override
  int get hashCode => key.hashCode ^ carType.hashCode;
}

/// generated route for
/// [_i41.NewEditCityScreen]
class NewEditCityRoute extends _i76.PageRouteInfo<NewEditCityRouteArgs> {
  NewEditCityRoute({
    _i77.Key? key,
    _i87.City? city,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditCityRoute.name,
         args: NewEditCityRouteArgs(key: key, city: city),
         initialChildren: children,
       );

  static const String name = 'NewEditCityRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditCityRouteArgs>(
        orElse: () => const NewEditCityRouteArgs(),
      );
      return _i41.NewEditCityScreen(key: args.key, city: args.city);
    },
  );
}

class NewEditCityRouteArgs {
  const NewEditCityRouteArgs({this.key, this.city});

  final _i77.Key? key;

  final _i87.City? city;

  @override
  String toString() {
    return 'NewEditCityRouteArgs{key: $key, city: $city}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditCityRouteArgs) return false;
    return key == other.key && city == other.city;
  }

  @override
  int get hashCode => key.hashCode ^ city.hashCode;
}

/// generated route for
/// [_i42.NewEditCompanyScreen]
class NewEditCompanyRoute extends _i76.PageRouteInfo<NewEditCompanyRouteArgs> {
  NewEditCompanyRoute({
    _i77.Key? key,
    _i88.Company? company,
    required _i78.Profile profile,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditCompanyRoute.name,
         args: NewEditCompanyRouteArgs(
           key: key,
           company: company,
           profile: profile,
         ),
         initialChildren: children,
       );

  static const String name = 'NewEditCompanyRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditCompanyRouteArgs>();
      return _i42.NewEditCompanyScreen(
        key: args.key,
        company: args.company,
        profile: args.profile,
      );
    },
  );
}

class NewEditCompanyRouteArgs {
  const NewEditCompanyRouteArgs({
    this.key,
    this.company,
    required this.profile,
  });

  final _i77.Key? key;

  final _i88.Company? company;

  final _i78.Profile profile;

  @override
  String toString() {
    return 'NewEditCompanyRouteArgs{key: $key, company: $company, profile: $profile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditCompanyRouteArgs) return false;
    return key == other.key &&
        company == other.company &&
        profile == other.profile;
  }

  @override
  int get hashCode => key.hashCode ^ company.hashCode ^ profile.hashCode;
}

/// generated route for
/// [_i43.NewEditContactScreen]
class NewEditContactRoute extends _i76.PageRouteInfo<NewEditContactRouteArgs> {
  NewEditContactRoute({
    _i77.Key? key,
    _i89.Contact? contact,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditContactRoute.name,
         args: NewEditContactRouteArgs(key: key, contact: contact),
         initialChildren: children,
       );

  static const String name = 'NewEditContactRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditContactRouteArgs>(
        orElse: () => const NewEditContactRouteArgs(),
      );
      return _i43.NewEditContactScreen(key: args.key, contact: args.contact);
    },
  );
}

class NewEditContactRouteArgs {
  const NewEditContactRouteArgs({this.key, this.contact});

  final _i77.Key? key;

  final _i89.Contact? contact;

  @override
  String toString() {
    return 'NewEditContactRouteArgs{key: $key, contact: $contact}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditContactRouteArgs) return false;
    return key == other.key && contact == other.contact;
  }

  @override
  int get hashCode => key.hashCode ^ contact.hashCode;
}

/// generated route for
/// [_i44.NewEditFeaturedScreen]
class NewEditFeaturedRoute
    extends _i76.PageRouteInfo<NewEditFeaturedRouteArgs> {
  NewEditFeaturedRoute({
    _i77.Key? key,
    required _i80.Car car,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditFeaturedRoute.name,
         args: NewEditFeaturedRouteArgs(key: key, car: car),
         initialChildren: children,
       );

  static const String name = 'NewEditFeaturedRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditFeaturedRouteArgs>();
      return _i44.NewEditFeaturedScreen(key: args.key, car: args.car);
    },
  );
}

class NewEditFeaturedRouteArgs {
  const NewEditFeaturedRouteArgs({this.key, required this.car});

  final _i77.Key? key;

  final _i80.Car car;

  @override
  String toString() {
    return 'NewEditFeaturedRouteArgs{key: $key, car: $car}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditFeaturedRouteArgs) return false;
    return key == other.key && car == other.car;
  }

  @override
  int get hashCode => key.hashCode ^ car.hashCode;
}

/// generated route for
/// [_i45.NewEditSupportScreen]
class NewEditSupportRoute extends _i76.PageRouteInfo<NewEditSupportRouteArgs> {
  NewEditSupportRoute({
    _i77.Key? key,
    _i90.Support? support,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditSupportRoute.name,
         args: NewEditSupportRouteArgs(key: key, support: support),
         initialChildren: children,
       );

  static const String name = 'NewEditSupportRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditSupportRouteArgs>(
        orElse: () => const NewEditSupportRouteArgs(),
      );
      return _i45.NewEditSupportScreen(key: args.key, support: args.support);
    },
  );
}

class NewEditSupportRouteArgs {
  const NewEditSupportRouteArgs({this.key, this.support});

  final _i77.Key? key;

  final _i90.Support? support;

  @override
  String toString() {
    return 'NewEditSupportRouteArgs{key: $key, support: $support}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditSupportRouteArgs) return false;
    return key == other.key && support == other.support;
  }

  @override
  int get hashCode => key.hashCode ^ support.hashCode;
}

/// generated route for
/// [_i46.NewEditTownScreen]
class NewEditTownRoute extends _i76.PageRouteInfo<NewEditTownRouteArgs> {
  NewEditTownRoute({
    _i77.Key? key,
    _i91.Town? town,
    _i87.City? city,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewEditTownRoute.name,
         args: NewEditTownRouteArgs(key: key, town: town, city: city),
         initialChildren: children,
       );

  static const String name = 'NewEditTownRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewEditTownRouteArgs>(
        orElse: () => const NewEditTownRouteArgs(),
      );
      return _i46.NewEditTownScreen(
        key: args.key,
        town: args.town,
        city: args.city,
      );
    },
  );
}

class NewEditTownRouteArgs {
  const NewEditTownRouteArgs({this.key, this.town, this.city});

  final _i77.Key? key;

  final _i91.Town? town;

  final _i87.City? city;

  @override
  String toString() {
    return 'NewEditTownRouteArgs{key: $key, town: $town, city: $city}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewEditTownRouteArgs) return false;
    return key == other.key && town == other.town && city == other.city;
  }

  @override
  int get hashCode => key.hashCode ^ town.hashCode ^ city.hashCode;
}

/// generated route for
/// [_i47.NewNotificationScreen]
class NewNotificationRoute extends _i76.PageRouteInfo<void> {
  const NewNotificationRoute({List<_i76.PageRouteInfo>? children})
    : super(NewNotificationRoute.name, initialChildren: children);

  static const String name = 'NewNotificationRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i47.NewNotificationScreen();
    },
  );
}

/// generated route for
/// [_i48.NewPromotionScreen]
class NewPromotionRoute extends _i76.PageRouteInfo<NewPromotionRouteArgs> {
  NewPromotionRoute({
    _i77.Key? key,
    _i80.Car? car,
    _i92.Promotion? promotion,
    required _i92.PromotionPost param,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewPromotionRoute.name,
         args: NewPromotionRouteArgs(
           key: key,
           car: car,
           promotion: promotion,
           param: param,
         ),
         initialChildren: children,
       );

  static const String name = 'NewPromotionRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewPromotionRouteArgs>();
      return _i48.NewPromotionScreen(
        key: args.key,
        car: args.car,
        promotion: args.promotion,
        param: args.param,
      );
    },
  );
}

class NewPromotionRouteArgs {
  const NewPromotionRouteArgs({
    this.key,
    this.car,
    this.promotion,
    required this.param,
  });

  final _i77.Key? key;

  final _i80.Car? car;

  final _i92.Promotion? promotion;

  final _i92.PromotionPost param;

  @override
  String toString() {
    return 'NewPromotionRouteArgs{key: $key, car: $car, promotion: $promotion, param: $param}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewPromotionRouteArgs) return false;
    return key == other.key &&
        car == other.car &&
        promotion == other.promotion &&
        param == other.param;
  }

  @override
  int get hashCode =>
      key.hashCode ^ car.hashCode ^ promotion.hashCode ^ param.hashCode;
}

/// generated route for
/// [_i49.NewRentalPlanScreen]
class NewRentalPlanRoute extends _i76.PageRouteInfo<NewRentalPlanRouteArgs> {
  NewRentalPlanRoute({
    _i77.Key? key,
    _i93.RentalPlan? rentalPlan,
    _i94.Plan? plan,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewRentalPlanRoute.name,
         args: NewRentalPlanRouteArgs(
           key: key,
           rentalPlan: rentalPlan,
           plan: plan,
         ),
         initialChildren: children,
       );

  static const String name = 'NewRentalPlanRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewRentalPlanRouteArgs>(
        orElse: () => const NewRentalPlanRouteArgs(),
      );
      return _i49.NewRentalPlanScreen(
        key: args.key,
        rentalPlan: args.rentalPlan,
        plan: args.plan,
      );
    },
  );
}

class NewRentalPlanRouteArgs {
  const NewRentalPlanRouteArgs({this.key, this.rentalPlan, this.plan});

  final _i77.Key? key;

  final _i93.RentalPlan? rentalPlan;

  final _i94.Plan? plan;

  @override
  String toString() {
    return 'NewRentalPlanRouteArgs{key: $key, rentalPlan: $rentalPlan, plan: $plan}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewRentalPlanRouteArgs) return false;
    return key == other.key &&
        rentalPlan == other.rentalPlan &&
        plan == other.plan;
  }

  @override
  int get hashCode => key.hashCode ^ rentalPlan.hashCode ^ plan.hashCode;
}

/// generated route for
/// [_i50.NewSliderScreen]
class NewSliderRoute extends _i76.PageRouteInfo<NewSliderRouteArgs> {
  NewSliderRoute({
    _i77.Key? key,
    _i84.SlideType type = _i84.SlideType.url,
    String? carId,
    String? companyId,
    _i95.Sliders? sliders,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NewSliderRoute.name,
         args: NewSliderRouteArgs(
           key: key,
           type: type,
           carId: carId,
           companyId: companyId,
           sliders: sliders,
         ),
         initialChildren: children,
       );

  static const String name = 'NewSliderRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewSliderRouteArgs>(
        orElse: () => const NewSliderRouteArgs(),
      );
      return _i50.NewSliderScreen(
        key: args.key,
        type: args.type,
        carId: args.carId,
        companyId: args.companyId,
        sliders: args.sliders,
      );
    },
  );
}

class NewSliderRouteArgs {
  const NewSliderRouteArgs({
    this.key,
    this.type = _i84.SlideType.url,
    this.carId,
    this.companyId,
    this.sliders,
  });

  final _i77.Key? key;

  final _i84.SlideType type;

  final String? carId;

  final String? companyId;

  final _i95.Sliders? sliders;

  @override
  String toString() {
    return 'NewSliderRouteArgs{key: $key, type: $type, carId: $carId, companyId: $companyId, sliders: $sliders}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NewSliderRouteArgs) return false;
    return key == other.key &&
        type == other.type &&
        carId == other.carId &&
        companyId == other.companyId &&
        sliders == other.sliders;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      type.hashCode ^
      carId.hashCode ^
      companyId.hashCode ^
      sliders.hashCode;
}

/// generated route for
/// [_i51.NotLoggedInMainScreen]
class NotLoggedInMainRoute extends _i76.PageRouteInfo<void> {
  const NotLoggedInMainRoute({List<_i76.PageRouteInfo>? children})
    : super(NotLoggedInMainRoute.name, initialChildren: children);

  static const String name = 'NotLoggedInMainRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i51.NotLoggedInMainScreen();
    },
  );
}

/// generated route for
/// [_i52.NotLoggedinScreen]
class NotLoggedinRoute extends _i76.PageRouteInfo<NotLoggedinRouteArgs> {
  NotLoggedinRoute({
    _i77.Key? key,
    String? content,
    String? icon,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NotLoggedinRoute.name,
         args: NotLoggedinRouteArgs(key: key, content: content, icon: icon),
         initialChildren: children,
       );

  static const String name = 'NotLoggedinRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotLoggedinRouteArgs>(
        orElse: () => const NotLoggedinRouteArgs(),
      );
      return _i52.NotLoggedinScreen(
        key: args.key,
        content: args.content,
        icon: args.icon,
      );
    },
  );
}

class NotLoggedinRouteArgs {
  const NotLoggedinRouteArgs({this.key, this.content, this.icon});

  final _i77.Key? key;

  final String? content;

  final String? icon;

  @override
  String toString() {
    return 'NotLoggedinRouteArgs{key: $key, content: $content, icon: $icon}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotLoggedinRouteArgs) return false;
    return key == other.key && content == other.content && icon == other.icon;
  }

  @override
  int get hashCode => key.hashCode ^ content.hashCode ^ icon.hashCode;
}

/// generated route for
/// [_i53.NotLoggedinTripScreen]
class NotLoggedinTripRoute
    extends _i76.PageRouteInfo<NotLoggedinTripRouteArgs> {
  NotLoggedinTripRoute({
    _i77.Key? key,
    String? content,
    String? icon,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         NotLoggedinTripRoute.name,
         args: NotLoggedinTripRouteArgs(key: key, content: content, icon: icon),
         initialChildren: children,
       );

  static const String name = 'NotLoggedinTripRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotLoggedinTripRouteArgs>(
        orElse: () => const NotLoggedinTripRouteArgs(),
      );
      return _i53.NotLoggedinTripScreen(
        key: args.key,
        content: args.content,
        icon: args.icon,
      );
    },
  );
}

class NotLoggedinTripRouteArgs {
  const NotLoggedinTripRouteArgs({this.key, this.content, this.icon});

  final _i77.Key? key;

  final String? content;

  final String? icon;

  @override
  String toString() {
    return 'NotLoggedinTripRouteArgs{key: $key, content: $content, icon: $icon}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotLoggedinTripRouteArgs) return false;
    return key == other.key && content == other.content && icon == other.icon;
  }

  @override
  int get hashCode => key.hashCode ^ content.hashCode ^ icon.hashCode;
}

/// generated route for
/// [_i54.PermissionsScreen]
class PermissionsRoute extends _i76.PageRouteInfo<PermissionsRouteArgs> {
  PermissionsRoute({
    required _i78.Profile profile,
    _i77.Key? key,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         PermissionsRoute.name,
         args: PermissionsRouteArgs(profile: profile, key: key),
         initialChildren: children,
       );

  static const String name = 'PermissionsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PermissionsRouteArgs>();
      return _i54.PermissionsScreen(args.profile, key: args.key);
    },
  );
}

class PermissionsRouteArgs {
  const PermissionsRouteArgs({required this.profile, this.key});

  final _i78.Profile profile;

  final _i77.Key? key;

  @override
  String toString() {
    return 'PermissionsRouteArgs{profile: $profile, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PermissionsRouteArgs) return false;
    return profile == other.profile && key == other.key;
  }

  @override
  int get hashCode => profile.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i55.PickUpMapScreen]
class PickUpMapRoute extends _i76.PageRouteInfo<PickUpMapRouteArgs> {
  PickUpMapRoute({
    _i77.Key? key,
    _i88.Company? company,
    dynamic Function(_i96.TapPosition, _i83.LatLng)? onSelect,
    _i84.MapMarkerType type = _i84.MapMarkerType.car,
    _i80.Car? car,
    _i83.LatLng? latLng,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         PickUpMapRoute.name,
         args: PickUpMapRouteArgs(
           key: key,
           company: company,
           onSelect: onSelect,
           type: type,
           car: car,
           latLng: latLng,
         ),
         initialChildren: children,
       );

  static const String name = 'PickUpMapRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PickUpMapRouteArgs>(
        orElse: () => const PickUpMapRouteArgs(),
      );
      return _i55.PickUpMapScreen(
        key: args.key,
        company: args.company,
        onSelect: args.onSelect,
        type: args.type,
        car: args.car,
        latLng: args.latLng,
      );
    },
  );
}

class PickUpMapRouteArgs {
  const PickUpMapRouteArgs({
    this.key,
    this.company,
    this.onSelect,
    this.type = _i84.MapMarkerType.car,
    this.car,
    this.latLng,
  });

  final _i77.Key? key;

  final _i88.Company? company;

  final dynamic Function(_i96.TapPosition, _i83.LatLng)? onSelect;

  final _i84.MapMarkerType type;

  final _i80.Car? car;

  final _i83.LatLng? latLng;

  @override
  String toString() {
    return 'PickUpMapRouteArgs{key: $key, company: $company, onSelect: $onSelect, type: $type, car: $car, latLng: $latLng}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PickUpMapRouteArgs) return false;
    return key == other.key &&
        company == other.company &&
        type == other.type &&
        car == other.car &&
        latLng == other.latLng;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      company.hashCode ^
      type.hashCode ^
      car.hashCode ^
      latLng.hashCode;
}

/// generated route for
/// [_i56.PromotionsScreen]
class PromotionsRoute extends _i76.PageRouteInfo<PromotionsRouteArgs> {
  PromotionsRoute({
    _i77.Key? key,
    required _i80.Car car,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         PromotionsRoute.name,
         args: PromotionsRouteArgs(key: key, car: car),
         initialChildren: children,
       );

  static const String name = 'PromotionsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PromotionsRouteArgs>();
      return _i56.PromotionsScreen(key: args.key, car: args.car);
    },
  );
}

class PromotionsRouteArgs {
  const PromotionsRouteArgs({this.key, required this.car});

  final _i77.Key? key;

  final _i80.Car car;

  @override
  String toString() {
    return 'PromotionsRouteArgs{key: $key, car: $car}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PromotionsRouteArgs) return false;
    return key == other.key && car == other.car;
  }

  @override
  int get hashCode => key.hashCode ^ car.hashCode;
}

/// generated route for
/// [_i57.ResetPasswordScreen]
class ResetPasswordRoute extends _i76.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i77.Key? key,
    required _i97.Auth auth,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(key: key, auth: auth),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i57.ResetPasswordScreen(key: args.key, auth: args.auth);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key, required this.auth});

  final _i77.Key? key;

  final _i97.Auth auth;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, auth: $auth}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordRouteArgs) return false;
    return key == other.key && auth == other.auth;
  }

  @override
  int get hashCode => key.hashCode ^ auth.hashCode;
}

/// generated route for
/// [_i58.ResetSendOtpScreen]
class ResetSendOtpRoute extends _i76.PageRouteInfo<void> {
  const ResetSendOtpRoute({List<_i76.PageRouteInfo>? children})
    : super(ResetSendOtpRoute.name, initialChildren: children);

  static const String name = 'ResetSendOtpRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i58.ResetSendOtpScreen();
    },
  );
}

/// generated route for
/// [_i59.ResetVerifyOtpScreen]
class ResetVerifyOtpRoute extends _i76.PageRouteInfo<ResetVerifyOtpRouteArgs> {
  ResetVerifyOtpRoute({
    _i77.Key? key,
    required _i97.Auth auth,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         ResetVerifyOtpRoute.name,
         args: ResetVerifyOtpRouteArgs(key: key, auth: auth),
         initialChildren: children,
       );

  static const String name = 'ResetVerifyOtpRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetVerifyOtpRouteArgs>();
      return _i59.ResetVerifyOtpScreen(key: args.key, auth: args.auth);
    },
  );
}

class ResetVerifyOtpRouteArgs {
  const ResetVerifyOtpRouteArgs({this.key, required this.auth});

  final _i77.Key? key;

  final _i97.Auth auth;

  @override
  String toString() {
    return 'ResetVerifyOtpRouteArgs{key: $key, auth: $auth}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetVerifyOtpRouteArgs) return false;
    return key == other.key && auth == other.auth;
  }

  @override
  int get hashCode => key.hashCode ^ auth.hashCode;
}

/// generated route for
/// [_i60.SearchBooksScreen]
class SearchBooksRoute extends _i76.PageRouteInfo<void> {
  const SearchBooksRoute({List<_i76.PageRouteInfo>? children})
    : super(SearchBooksRoute.name, initialChildren: children);

  static const String name = 'SearchBooksRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i60.SearchBooksScreen();
    },
  );
}

/// generated route for
/// [_i61.SearchCarScreen]
class SearchCarRoute extends _i76.PageRouteInfo<void> {
  const SearchCarRoute({List<_i76.PageRouteInfo>? children})
    : super(SearchCarRoute.name, initialChildren: children);

  static const String name = 'SearchCarRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i61.SearchCarScreen();
    },
  );
}

/// generated route for
/// [_i62.SearchUserScreen]
class SearchUserRoute extends _i76.PageRouteInfo<void> {
  const SearchUserRoute({List<_i76.PageRouteInfo>? children})
    : super(SearchUserRoute.name, initialChildren: children);

  static const String name = 'SearchUserRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i62.SearchUserScreen();
    },
  );
}

/// generated route for
/// [_i63.SettingsScreen]
class SettingsRoute extends _i76.PageRouteInfo<void> {
  const SettingsRoute({List<_i76.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i63.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i64.SignupScreen]
class SignupRoute extends _i76.PageRouteInfo<void> {
  const SignupRoute({List<_i76.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i64.SignupScreen();
    },
  );
}

/// generated route for
/// [_i65.SlidersScreen]
class SlidersRoute extends _i76.PageRouteInfo<void> {
  const SlidersRoute({List<_i76.PageRouteInfo>? children})
    : super(SlidersRoute.name, initialChildren: children);

  static const String name = 'SlidersRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i65.SlidersScreen();
    },
  );
}

/// generated route for
/// [_i66.SortingImageScreen]
class SortingImageRoute extends _i76.PageRouteInfo<SortingImageRouteArgs> {
  SortingImageRoute({
    _i77.Key? key,
    required _i80.Car car,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         SortingImageRoute.name,
         args: SortingImageRouteArgs(key: key, car: car),
         initialChildren: children,
       );

  static const String name = 'SortingImageRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SortingImageRouteArgs>();
      return _i66.SortingImageScreen(key: args.key, car: args.car);
    },
  );
}

class SortingImageRouteArgs {
  const SortingImageRouteArgs({this.key, required this.car});

  final _i77.Key? key;

  final _i80.Car car;

  @override
  String toString() {
    return 'SortingImageRouteArgs{key: $key, car: $car}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SortingImageRouteArgs) return false;
    return key == other.key && car == other.car;
  }

  @override
  int get hashCode => key.hashCode ^ car.hashCode;
}

/// generated route for
/// [_i67.StatisticsScreen]
class StatisticsRoute extends _i76.PageRouteInfo<void> {
  const StatisticsRoute({List<_i76.PageRouteInfo>? children})
    : super(StatisticsRoute.name, initialChildren: children);

  static const String name = 'StatisticsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i67.StatisticsScreen();
    },
  );
}

/// generated route for
/// [_i68.SupportsScreen]
class SupportsRoute extends _i76.PageRouteInfo<void> {
  const SupportsRoute({List<_i76.PageRouteInfo>? children})
    : super(SupportsRoute.name, initialChildren: children);

  static const String name = 'SupportsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i68.SupportsScreen();
    },
  );
}

/// generated route for
/// [_i69.UpdateSendOtpScreen]
class UpdateSendOtpRoute extends _i76.PageRouteInfo<void> {
  const UpdateSendOtpRoute({List<_i76.PageRouteInfo>? children})
    : super(UpdateSendOtpRoute.name, initialChildren: children);

  static const String name = 'UpdateSendOtpRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i69.UpdateSendOtpScreen();
    },
  );
}

/// generated route for
/// [_i70.UpdateUserPasswordScreen]
class UpdateUserPasswordRoute
    extends _i76.PageRouteInfo<UpdateUserPasswordRouteArgs> {
  UpdateUserPasswordRoute({
    required _i78.Profile profile,
    _i77.Key? key,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         UpdateUserPasswordRoute.name,
         args: UpdateUserPasswordRouteArgs(profile: profile, key: key),
         initialChildren: children,
       );

  static const String name = 'UpdateUserPasswordRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UpdateUserPasswordRouteArgs>();
      return _i70.UpdateUserPasswordScreen(args.profile, key: args.key);
    },
  );
}

class UpdateUserPasswordRouteArgs {
  const UpdateUserPasswordRouteArgs({required this.profile, this.key});

  final _i78.Profile profile;

  final _i77.Key? key;

  @override
  String toString() {
    return 'UpdateUserPasswordRouteArgs{profile: $profile, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UpdateUserPasswordRouteArgs) return false;
    return profile == other.profile && key == other.key;
  }

  @override
  int get hashCode => profile.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i71.UserDetailsScreen]
class UserDetailsRoute extends _i76.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i77.Key? key,
    required _i78.Profile profile,
    List<_i76.PageRouteInfo>? children,
  }) : super(
         UserDetailsRoute.name,
         args: UserDetailsRouteArgs(key: key, profile: profile),
         initialChildren: children,
       );

  static const String name = 'UserDetailsRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserDetailsRouteArgs>();
      return _i71.UserDetailsScreen(key: args.key, profile: args.profile);
    },
  );
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({this.key, required this.profile});

  final _i77.Key? key;

  final _i78.Profile profile;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, profile: $profile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserDetailsRouteArgs) return false;
    return key == other.key && profile == other.profile;
  }

  @override
  int get hashCode => key.hashCode ^ profile.hashCode;
}

/// generated route for
/// [_i72.UsersScreen]
class UsersRoute extends _i76.PageRouteInfo<void> {
  const UsersRoute({List<_i76.PageRouteInfo>? children})
    : super(UsersRoute.name, initialChildren: children);

  static const String name = 'UsersRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i72.UsersScreen();
    },
  );
}

/// generated route for
/// [_i73.VerifyNewEmailOtpScreen]
class VerifyNewEmailOtpRoute extends _i76.PageRouteInfo<void> {
  const VerifyNewEmailOtpRoute({List<_i76.PageRouteInfo>? children})
    : super(VerifyNewEmailOtpRoute.name, initialChildren: children);

  static const String name = 'VerifyNewEmailOtpRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i73.VerifyNewEmailOtpScreen();
    },
  );
}

/// generated route for
/// [_i74.VerifySendOtpScreen]
class VerifySendOtpRoute extends _i76.PageRouteInfo<void> {
  const VerifySendOtpRoute({List<_i76.PageRouteInfo>? children})
    : super(VerifySendOtpRoute.name, initialChildren: children);

  static const String name = 'VerifySendOtpRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i74.VerifySendOtpScreen();
    },
  );
}

/// generated route for
/// [_i75.WelcomeScreen]
class WelcomeRoute extends _i76.PageRouteInfo<void> {
  const WelcomeRoute({List<_i76.PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static _i76.PageInfo page = _i76.PageInfo(
    name,
    builder: (data) {
      return const _i75.WelcomeScreen();
    },
  );
}
