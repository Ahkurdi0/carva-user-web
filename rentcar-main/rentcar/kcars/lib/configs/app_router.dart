import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kcars/configs/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final Ref? ref;
  AppRouter({super.navigatorKey, this.ref});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: true),

    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(
          page: HomeRoute.page,
          path: "home",
          initial: true,
          children: [
            AutoRoute(path: "", page: CarsRoute.page, initial: true),
            AutoRoute(path: "filters", page: FilterRoute.page),
          ],
        ),
        AutoRoute(page: FavoriteRoute.page),
        AutoRoute(page: AllCompaniesRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignupRoute.page),
    AutoRoute(page: EditProfileRoute.page),
    //
    AutoRoute(page: CarDetailsRoute.page),
    AutoRoute(page: BookingRoute.page),
    AutoRoute(page: CompanyDetailsRoute.page),

    // Companies screen
    AutoRoute(
      page: MainCompanyRoute.page,
      children: [
        AutoRoute(page: CompanyBookedRoute.page),
        AutoRoute(page: CompaniesReviewRoute.page),
        AutoRoute(page: CompanyCarReviewsRoute.page),
        AutoRoute(page: CompanyCarsRoute.page),
      ],
    ),

    AutoRoute(page: NewEditCarRoute.page),
    AutoRoute(page: NewRentalPlanRoute.page),
    AutoRoute(page: PromotionsRoute.page),
    AutoRoute(page: NewPromotionRoute.page),
    AutoRoute(page: MapRoute.page),
    AutoRoute(page: PickUpMapRoute.page),
    AutoRoute(page: SortingImageRoute.page),
    AutoRoute(page: EditCompanyRoute.page),
    AutoRoute(page: NewEditContactRoute.page),
    AutoRoute(page: SearchBooksRoute.page),
    //

    //admins
    AutoRoute(
      page: MainAdminRoute.page,
      children: [
        AutoRoute(page: UsersRoute.page),
        AutoRoute(page: CompaniesRoute.page),
        AutoRoute(page: AllCarsRoute.page),
        AutoRoute(page: FeaturedCarsRoute.page),
        AutoRoute(page: AllBooksRoute.page),
        AutoRoute(page: AllCarReviewRoute.page),
        AutoRoute(page: AllCompanyReviewRoute.page),
        AutoRoute(page: CompanyReviewsFlagRoute.page),
        AutoRoute(page: CarReviewsFlagRoute.page),
        AutoRoute(page: EmptyRoute.page),
      ],
    ),
    AutoRoute(page: AllCompaniesRoute.page),
    AutoRoute(page: PermissionsRoute.page),
    AutoRoute(page: BanUserRoute.page),
    AutoRoute(page: UserDetailsRoute.page),
    AutoRoute(page: NewEditCompanyRoute.page),
    AutoRoute(page: SearchUserRoute.page),
    AutoRoute(page: UpdateUserPasswordRoute.page),

    //
    AutoRoute(page: CityRoute.page),
    AutoRoute(page: NewEditCityRoute.page),
    AutoRoute(page: NewEditTownRoute.page),

    AutoRoute(page: SupportsRoute.page),
    AutoRoute(page: NewEditSupportRoute.page),

    AutoRoute(page: CarTypesRoute.page),
    AutoRoute(page: NewEditCarTypeRoute.page),

    AutoRoute(page: BrandsRoute.page),
    AutoRoute(page: NewEditBrandRoute.page),
    AutoRoute(page: NewNotificationRoute.page),

    AutoRoute(page: StatisticsRoute.page),
    AutoRoute(page: CompanyStatiscsRoute.page),
    AutoRoute(page: NewSliderRoute.page),
    AutoRoute(page: SlidersRoute.page),
    AutoRoute(page: SearchCarRoute.page),

    AutoRoute(
      page: NotLoggedInMainRoute.page,
      children: [
        AutoRoute(
          page: HomeRoute.page,
          children: [
            AutoRoute(path: "", page: CarsRoute.page, initial: true),
            AutoRoute(path: "filters", page: FilterRoute.page),
          ],
        ),
        AutoRoute(page: NotLoggedinRoute.page),
        AutoRoute(page: AllCompaniesRoute.page),
      ],
    ),
    AutoRoute(page: ResetSendOtpRoute.page),
    AutoRoute(page: ResetVerifyOtpRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),

    AutoRoute(page: ConnectivityRoute.page),
    AutoRoute(page: NewEditFeaturedRoute.page),
  ];
}
