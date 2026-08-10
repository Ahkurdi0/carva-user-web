import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/company/data/model/company_cursor.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/company_statistic.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:kcars/features/company/data/remote/company_remote.dart';
import 'package:kcars/features/company/domain/company_repo.dart';

class CompanyRepoImpl implements CompanyRepo {
  CompanyRepoImpl(this._companyRemoete);
  final CompanyRemote _companyRemoete;

  @override
  Result<void> sortContacts(List<Contact> param) async {
    try {
      await _companyRemoete.sortContacts(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateCompany(PostCompany params) async {
    try {
      final result = await _companyRemoete.updateCompany(params);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Company>> companies([CompanyCursor? param]) async {
    try {
      final result = await _companyRemoete.companies(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<String?> newCompany(Company param) async {
    try {
      final result = await _companyRemoete.newCompany(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Company> company(String id) async {
    try {
      final result = await _companyRemoete.company(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<City>> cities() async {
    try {
      final result = await _companyRemoete.cities();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Company> myCompany([String? id]) async {
    try {
      final result = await _companyRemoete.myCompany(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<Company>> allCompanies([CompanyCursor? param]) async {
    try {
      final result = await _companyRemoete.allCompanies(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<List<CompanyStatistic>> companyStatistic([DateTime? date]) async {
    try {
      final result = await _companyRemoete.companyStatistic(date);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
