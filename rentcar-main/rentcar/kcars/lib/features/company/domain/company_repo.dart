import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/company/data/model/company_cursor.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/company_statistic.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';

abstract class CompanyRepo {
  Result<void> updateCompany(PostCompany params);
  Result<void> sortContacts(List<Contact> param);
  Result<List<Company>> companies([CompanyCursor? param]);
  Result<String?> newCompany(Company param);
  Result<Company> company(String id);
  Result<Company> myCompany([String? id]);
  Result<List<City>> cities();
  Result<List<CompanyStatistic>> companyStatistic([DateTime? date]);
  Result<List<Company>> allCompanies([CompanyCursor? param]);
}
