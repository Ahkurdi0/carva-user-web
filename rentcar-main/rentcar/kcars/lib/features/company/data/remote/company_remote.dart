import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/features/car/data/model/city.dart';
import 'package:kcars/features/company/data/model/company_cursor.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:kcars/features/company/data/model/company_statistic.dart';
import 'package:kcars/features/company/data/model/contact.dart';
import 'package:kcars/features/company/data/model/post_company.dart';
import 'package:http_parser/http_parser.dart';

abstract class CompanyRemote {
  Future<void> updateCompany(PostCompany params);
  Future<void> sortContacts(List<Contact> param);
  Future<List<Company>> companies([CompanyCursor? param]);
  Future<String?> newCompany(Company param);
  Future<Company> company(String id);
  Future<Company> myCompany([String? id]);
  Future<List<City>> cities();
  Future<List<CompanyStatistic>> companyStatistic([DateTime? date]);
  Future<List<Company>> allCompanies([CompanyCursor? param]);
}

class CompanyRemoteImpl implements CompanyRemote {
  CompanyRemoteImpl(this._apiService);
  final ApiService _apiService;
  final url = Info.company;
  final adminUrl = Info.admin;
  final userUrl = Info.user;
  @override
  Future<void> sortContacts(List<Contact> param) async {
    return await _apiService.post(
      "$url/sortContacts",
      data: param.map((e) => {"id": e.id, "sort": e.sort}).toList(),
    );
  }

  @override
  Future<void> updateCompany(PostCompany params) async {
    final formData = FormData();
    if (params.image != null) {
      final mimeType = getMimeType(params.image!.path);
      final multipartFile = await MultipartFile.fromFile(
        params.image!.path,
        filename: params.image!.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      );
      formData.files.add(MapEntry('image', multipartFile));
    }

    if (params.coverImage != null) {
      final mimeType = getMimeType(params.coverImage!.path);
      final multipartFile = await MultipartFile.fromFile(
        params.coverImage!.path,
        filename: params.coverImage!.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      );
      formData.files.add(MapEntry('coverImage', multipartFile));
    }

    if (params.company?.name != null && params.company!.name.length >= 3) {
      formData.fields.add(MapEntry('name', params.company!.name));
    }
    if (params.company?.desc != null && params.company!.desc!.isNotEmpty) {
      formData.fields.add(MapEntry('desc', params.company!.desc ?? ""));
    }
    if (params.company?.contact != null &&
        params.company!.contact!.isNotEmpty) {
      formData.fields.add(MapEntry('contact', params.company?.contact ?? ""));
    }

    if (params.company?.location != null) {
      var location = {};
      if (params.company!.location!.lat != -1 &&
          params.company!.location!.long != -1) {
        location["lat"] = params.company!.location!.lat;
        location["long"] = params.company!.location!.long;
      }

      location["townId"] = params.company?.location?.townId;

      // if (params.company!.location!.cityId != null) {}
      formData.fields.add(MapEntry('location', jsonEncode(location)));
    }

    if (params.deletedContacts != null) {
      formData.fields.add(
        MapEntry(
          'deletedContacts',
          jsonEncode(params.deletedContacts?.map((c) => {"id": c.id}).toList()),
        ),
      );
    }
    if (params.newContacts != null) {
      formData.fields.add(
        MapEntry(
          'newContacts',
          jsonEncode(params.newContacts?.map((c) => c.toMap()).toList()),
        ),
      );
    }

    return await _apiService.post("$url/updateCompany", data: formData);
  }

  @override
  Future<List<Company>> companies([CompanyCursor? param]) async {
    return await _apiService.post(
      "$adminUrl/companies",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((c) => CompanyMapper.fromMap(c)).toList(),
    );
  }

  @override
  Future<String?> newCompany(Company param) async {
    var location = {};

    if (param.location != null) {
      if (param.location!.lat != -1 && param.location!.long != -1) {
        location["lat"] = param.location!.lat;
        location["long"] = param.location!.long;
      }

      location["townId"] = param.location?.townId;
      location["cityId"] = param.location?.cityId;
    }

    return await _apiService.post(
      "$adminUrl/newCompany",
      data: {
        "id": param.id == "" ? null : param.id,
        "userId": param.profile?.userId,
        "name": param.name == "" ? null : param.name,
        "desc": param.desc == "" ? null : param.desc,
        "international": param.international,
        "contact": param.contact,
        "activeDate": param.activeDate?.toUtc().toIso8601String(),
        "expiresAt": param.expiresAt?.toUtc().toIso8601String(),
        "location": location.isEmpty ? null : location,
        "available": param.available,
      },
    );
  }

  @override
  Future<Company> company(String id) async {
    return await _apiService.post(
      "$userUrl/company",
      data: {"id": id},
      fromMap: (data) => CompanyMapper.fromMap(data),
    );
  }

  @override
  Future<List<City>> cities() async {
    return await _apiService.post(
      "$url/cities",
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((city) => CityMapper.fromMap(city)).toList(),
    );
  }

  @override
  Future<Company> myCompany([String? id]) async {
    return await _apiService.post(
      "$url/company",
      data: {"id": id},
      fromMap: (data) => CompanyMapper.fromMap(data),
    );
  }

  @override
  Future<List<Company>> allCompanies([CompanyCursor? param]) async {
    return await _apiService.post(
      "$userUrl/companies",
      data: param?.cleanedMap(),
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((c) => CompanyMapper.fromMap(c)).toList(),
    );
  }

  @override
  Future<List<CompanyStatistic>> companyStatistic([DateTime? date]) async {
    return await _apiService.post(
      "$adminUrl/companyStatistics",
      data: {"date": date?.toUtc().toIso8601String()},
      fromMap: (data) => List<DataMap>.from(
        data,
      ).map((c) => CompanyStatisticMapper.fromMap(c)).toList(),
    );
  }
}
