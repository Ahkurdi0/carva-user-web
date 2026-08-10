import 'package:dio/dio.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/core/services/api_service.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/utils/extensions.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:http_parser/http_parser.dart';

abstract class AuthRemote {
  Future<Profile> login(Auth param);
  Future<Profile> signup(Auth param);
  Future<void> logout(Auth param);
  Future<Profile> refreshProfile([bool? isCheking]);
  Future<void> updateName(Auth param);
  Future<void> updatePassword(Auth param);
  Future<void> updateEmailSendOtp(Auth param);
  Future<void> updateEmailVerifyOtp(Auth param);
  Future<void> resetSendOtp(Auth param);
  Future<void> resetVerifyOtp(Auth param);
  Future<void> resetPassword(Auth param);
  Future<Auth> updateProfilePicture(Auth param);
  Future<void> updatePreflang(Auth param);
  Future<void> updatePhoneNumber(Auth param);
  Future<void> verifyEmailSendOtp(Auth param);
  Future<void> verifyEmailVerifyOtp(Auth param);
  Future<void> deleteAccount();
  Future<Auth> refreshToken(Auth param);
}

class AuthRemoteImpl implements AuthRemote {
  AuthRemoteImpl(this.apiService);
  final ApiService apiService;
  final baseUrl = Info.auth;
  @override
  Future<Profile> login(Auth param) async {
    assert(
      param.email != null && param.password != null,
      'Email and password are required for login.',
    );

    return await apiService.post(
      "$baseUrl/login",
      data: {
        "email": param.email,
        "password": param.password,
        "session": param.session?.toMap(),
      },
      fromMap: (data) => ProfileMapper.fromMap(data),
    );
  }

  @override
  Future<void> logout(Auth param) async {
    assert(param.allDevices != null, 'All devcice check required');
    return await apiService.post(
      "$baseUrl/logout",
      data: {"allDevices": param.allDevices},
    );
  }

  @override
  Future<Profile> refreshProfile([bool? isCheking]) async =>
      await apiService.post(
        "$baseUrl/refresh",
        options: Options(headers: {"isChecking": isCheking}),
        fromMap: (data) => ProfileMapper.fromMap(data),
      );

  @override
  Future<Auth> refreshToken(Auth param) async => await apiService.post(
    "$baseUrl/refreshToken",
    options: Options(
      headers: {"Authorization": "Bearer ${param.refreshToken}"},
    ),
    fromMap: (data) => AuthMapper.fromMap(data),
  );

  @override
  Future<void> resetPassword(Auth param) async {
    assert(
      param.email != null && param.code != null && param.password != null,
      "Email, password and otp are required for reset password.",
    );
    return await apiService.post(
      "$baseUrl/email/r/resetPassword",
      data: {
        "email": param.email,
        "code": param.code,
        "password": param.password,
      },
    );
  }

  @override
  Future<void> resetSendOtp(Auth param) async {
    assert(param.email != null, 'Email is required for reset password.');
    await apiService.post(
      "$baseUrl/email/r/send",
      data: {"email": param.email},
    );
  }

  @override
  Future<void> resetVerifyOtp(Auth param) async {
    assert(
      param.email != null && param.code != null,
      "Email and otp are required.",
    );
    return await apiService.post(
      "$baseUrl/email/r/verify",
      data: {"email": param.email, "code": param.code},
    );
  }

  @override
  Future<Profile> signup(Auth param) async {
    assert(
      param.email != null &&
          param.password != null &&
          param.name != null &&
          param.session != null,

      'Name, Emai, password, Phone number, session and country code are required for signup.',
    );
    return await apiService.post(
      "$baseUrl/signup",
      data: {
        "name": param.name,
        "email": param.email,
        "password": param.password,
        "phoneNumber": param.phoneNumber,
        "countryCode": param.countryCode,
        "session": param.session?.toMap(),
        "platform": param.platform,
      },
      fromMap: (data) => ProfileMapper.fromMap(data),
    );
  }

  @override
  Future<void> updateEmailSendOtp(Auth param) async {
    assert(param.email != null, 'Email is required for update email');
    return await apiService.post(
      "$baseUrl/email/u/send",
      data: {"email": param.email},
    );
  }

  @override
  Future<void> updateEmailVerifyOtp(Auth param) async {
    assert(
      param.email != null && param.code != null,
      'Email and otp are required.',
    );
    return await apiService.post(
      "$baseUrl/email/u/verify",
      data: {"email": param.email, "code": param.code},
    );
  }

  @override
  Future<void> updateName(Auth param) async {
    assert(param.name != null, 'Name is required for update name');
    return await apiService.post(
      "$baseUrl/updateName",
      data: {"name": param.name},
    );
  }

  @override
  Future<void> updatePassword(Auth param) async {
    assert(
      param.oldPassword != null && param.password != null,
      'Old password and new password are required for update password',
    );
    return await apiService.post(
      "$baseUrl/updatePassword",
      data: {"oldPassword": param.oldPassword, "newPassword": param.password},
    );
  }

  @override
  Future<Auth> updateProfilePicture(Auth auth) async {
    assert(
      auth.image != null,
      'Image file is required for profile picture update.',
    );

    if (auth.image == null || auth.image!.isEmpty) {
      throw ApiException(
        statusCode: 500,
        message: "Image file is required for profile picture update.",
      );
    }
    final mimeType = getMimeType(auth.image!);
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        auth.image!,
        filename: auth.image!.split("/").last,
        contentType: MediaType.parse(mimeType),
      ),
      "imageUrl": auth.imageUrl,
    });
    return await apiService.post(
      "$baseUrl/updateProfilePicture",
      data: formData,
      fromMap: (data) => AuthMapper.fromMap(data),
    );
  }

  @override
  Future<void> updatePhoneNumber(Auth param) async {
    assert(
      param.phoneNumber != null && param.countryCode != null,
      'Phone number is required for update',
    );
    await apiService.post(
      "$baseUrl/updatePhoneNumber",
      data: {
        "phoneNumber": param.phoneNumber,
        "countryCode": param.countryCode,
      },
    );
  }

  @override
  Future<void> updatePreflang(Auth param) async {
    assert(param.prefLang != null, 'Preflang is required for update');
    return await apiService.post(
      "$baseUrl/updatePreflang",
      data: {"prefLang": param.prefLang},
    );
  }

  @override
  Future<void> verifyEmailSendOtp(Auth param) async {
    assert(param.email != null, 'Email is required for verify email');
    return await apiService.post(
      "$baseUrl/email/v/send",
      data: {"email": param.email},
    );
  }

  @override
  Future<void> verifyEmailVerifyOtp(Auth param) async {
    assert(
      param.email != null && param.code != null,
      'Email and otp are required.',
    );
    return await apiService.post(
      "$baseUrl/email/v/verify",
      data: {"email": param.email, "code": param.code},
    );
  }

  @override
  Future<void> deleteAccount() async {
    return await apiService.post("$baseUrl/deleteAccount");
  }
}
