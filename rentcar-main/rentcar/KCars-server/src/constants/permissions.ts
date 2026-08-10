export const Permissions = {
  company: 'access_company',
  users: 'access_users',
  updateUserPassword: 'access_update_user_password',
  recoverAccount: 'access_recover_account',
  usersBooks: 'access_users_books',
  usersCarReview: 'access_users_car_review',
  usersCompanyReview: 'access_users_company_review',
  books: 'access_books',
  carReviews: 'access_car_reviews',
  companyReviews: 'access_company_reviews',
  carReviewsFlag: 'access_car_reviews_flag',
  companyReviewsFlag: 'access_company_reviews_flag',
  cars: 'access_cars',
  createCompany: 'access_create_company',
  companyCars: 'access_company_cars',
  companyStatuses: 'access_company_statuses',
  user_password: 'access_user_password',
  admin_statistics: 'access_admin_statistics',
  company_statistics: 'access_company_statistics',
  user_statistics: 'access_user_statistics',
  user_roles: 'access_user_roles',
  account_status: 'access_account_status',
  support: 'access_support',
  featuredCars: 'access_featured_cars',
  sliders: 'access_sliders',
  notification: 'access_notifications',
  brands: 'access_brands',
  carTypes: 'access_car_types',
  towns: 'access_towns',
  cities: 'access_cities',
} as const;

export type PermissionKeys = (typeof Permissions)[keyof typeof Permissions];

export interface AdminPermissions {
  role: {
    roleId: string;
    description: string | null;
    roleName: string;
  } | null;
  permissions: {
    permission: {
      description: string | null;
      permissionId: string;
      permissionName: string;
    };
  }[];
}
