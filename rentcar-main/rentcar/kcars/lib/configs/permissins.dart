enum Permissions {
  company("access_company"),
  users("access_users"),
  updateUserPassword("access_update_user_password"),
  recoverAccount("access_recover_account"),
  books("access_books"),
  carReviews("access_car_reviews"),
  companyReviews("access_company_reviews"),
  carReviewsFlag("access_car_reviews_flag"),
  companyReviewsFlag("access_company_reviews_flag"),
  cars("access_cars"),
  createCompany("access_create_company"),
  companyCars("access_company_cars"),
  companyStatuses("access_company_statuses"),
  userPassword("access_user_password"),
  adminStatistics("access_admin_statistics"),
  companyStatistics("access_company_statistics"),
  userStatistics("access_user_statistics"),
  userRoles("access_user_roles"),
  accountStatus("access_account_status"),
  support('access_support'),
  featuredCars('access_featured_cars'),
  notification('access_notifications'),
  brands('access_brands'),
  carTypes('access_car_types'),
  towns('access_towns'),
  cities('access_cities'),
  sliders('access_sliders')
  //
  ;

  final String value;
  const Permissions(this.value);
}
