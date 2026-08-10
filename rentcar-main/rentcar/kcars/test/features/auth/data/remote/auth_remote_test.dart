import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kcars/core/services/info.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/model/session.dart';

import 'package:mockito/mockito.dart';

import '../../../../utils.dart';
import 'auth_remote_test_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthRemoteTests h;

  setUp(() {
    h = AuthRemoteTests();
  });

  group("Auth Remote Tests", () {
    test("should return Profile when login is successful", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/login",
          data: anyNamed('data'),
          fromMap: anyNamed('fromMap'),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as Profile Function(Map<String, dynamic>);
        final data = await loadJsonData("profile");

        return fromMap(data);
      });

      final result = await h.authRemote.login(h.auth);

      expect(result, equals(h.profile));

      verify(
        h.mockApiService.post(
          "${Info.auth}/login",
          data: anyNamed('data'),
          fromMap: anyNamed('fromMap'),
        ),
      ).called(1);
    });

    test("should return Profile when signup is successful", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/signup",
          data: anyNamed('data'),
          fromMap: anyNamed('fromMap'),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as Profile Function(Map<String, dynamic>);
        final data = await loadJsonData("profile");

        return fromMap(data);
      });
      final signup = h.auth.copyWith(
        name: "Tester",
        email: "test@gmail.com",
        phoneNumber: "77012345678",
        password: "12345678",
        countryCode: "+964",
        session: Session(),
        prefLang: "en",
      );

      final result = await h.authRemote.signup(signup);

      expect(result, equals(h.profile));

      verify(
        h.mockApiService.post(
          "${Info.auth}/signup",
          data: anyNamed('data'),
          fromMap: anyNamed('fromMap'),
        ),
      ).called(1);
    });

    test("should return Profile when refresh is successful", () async {
      when(
        h.mockApiService.post(
          any,
          options: anyNamed("options"),
          fromMap: anyNamed('fromMap'),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap]
                as Profile Function(Map<String, dynamic>);
        final data = await loadJsonData("profile");

        return fromMap(data);
      });
      final result = await h.authRemote.refreshProfile(true);
      expect(result, equals(h.profile));
      verify(
        h.mockApiService.post(
          "${Info.auth}/refresh",
          options: argThat(
            predicate<Options>((opt) => opt.headers?["isChecking"] == true),
            named: "options",
          ),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });

    test("Should success when upadte password", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/updatePassword",
          data: anyNamed("data"),
        ),
      ).thenAnswer((invocation) async => null);
      final updatePassword = h.auth.copyWith(
        oldPassword: "12345678",
        password: "12345678",
      );
      await h.authRemote.updatePassword(updatePassword);
      verify(
        h.mockApiService.post(
          "${Info.auth}/updatePassword",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Should success when upadte phone number", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/updatePhoneNumber",
          data: anyNamed("data"),
        ),
      ).thenAnswer((invocation) async => null);
      final updatePhoneNumber = h.auth.copyWith(
        phoneNumber: "77012345678",
        countryCode: "+964",
      );
      await h.authRemote.updatePhoneNumber(updatePhoneNumber);
      verify(
        h.mockApiService.post(
          "${Info.auth}/updatePhoneNumber",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Should success when upadte name", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/updateName",
          data: anyNamed("data"),
        ),
      ).thenAnswer((invocation) async => null);
      final updateName = h.auth.copyWith(name: "Tester");
      await h.authRemote.updateName(updateName);
      verify(
        h.mockApiService.post(
          "${Info.auth}/updateName",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Update Preflang", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/updatePreflang",
          data: anyNamed("data"),
        ),
      ).thenAnswer((invocation) async => null);
      final preflang = h.auth.copyWith(prefLang: "en");
      await h.authRemote.updatePreflang(preflang);

      verify(
        h.mockApiService.post(
          "${Info.auth}/updatePreflang",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Success when logout", () async {
      when(
        h.mockApiService.post("${Info.auth}/logout", data: anyNamed("data")),
      ).thenAnswer((invocation) async => null);
      await h.authRemote.logout(h.auth.copyWith(allDevices: true));
      verify(
        h.mockApiService.post("${Info.auth}/logout", data: anyNamed("data")),
      ).called(1);
    });

    test("Should success when delete account", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/deleteAccount",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      await h.authRemote.deleteAccount();

      verify(
        h.mockApiService.post(
          "${Info.auth}/deleteAccount",
          data: anyNamed("data"),
        ),
      ).called(1);
    });
  });
  group("Upload Image", () {
    test("Sould return image url when update profile picture", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/updateProfilePicture",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).thenAnswer((invocation) async {
        final fromMap =
            invocation.namedArguments[#fromMap] as Auth Function(DataMap);
        return fromMap({"imageUrl": "https://example.com/image.jpg"});
      });
      final tempFile = File('/Users/mac/Downloads/Ellipse/75.png');
      await tempFile.create(recursive: true);
      final image = h.auth.copyWith(image: tempFile.path);

      final result = await h.authRemote.updateProfilePicture(image);
      expect(result.imageUrl, "https://example.com/image.jpg");

      verify(
        h.mockApiService.post(
          "${Info.auth}/updateProfilePicture",
          data: anyNamed("data"),
          fromMap: anyNamed("fromMap"),
        ),
      ).called(1);
    });
  });

  group("Verify email", () {
    test("Shold send otp", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/v/send",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com");
      await h.authRemote.verifyEmailSendOtp(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/v/send",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Shoul verify otp", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/v/verify",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com", code: "123456");
      await h.authRemote.verifyEmailVerifyOtp(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/v/verify",
          data: anyNamed("data"),
        ),
      ).called(1);
    });
  });

  group("Reset password", () {
    test("Reset password Send Ootp", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/r/send",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com");
      await h.authRemote.resetSendOtp(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/r/send",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Reset password verify otp", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/r/verify",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com", code: "123456");
      await h.authRemote.resetVerifyOtp(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/r/verify",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Reset password Update password", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/r/resetPassword",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com", code: "123456");
      await h.authRemote.resetPassword(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/r/resetPassword",
          data: anyNamed("data"),
        ),
      ).called(1);
    });
  });

  group("Updat Eamil address", () {
    test("Update email Send OTP", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/u/send",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com");
      await h.authRemote.updateEmailSendOtp(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/u/send",
          data: anyNamed("data"),
        ),
      ).called(1);
    });

    test("Update email and veorify otp", () async {
      when(
        h.mockApiService.post(
          "${Info.auth}/email/u/verify",
          data: anyNamed("data"),
        ),
      ).thenAnswer((_) async => null);
      final email = h.auth.copyWith(email: "test@gmail.com", code: "123456");
      await h.authRemote.updateEmailVerifyOtp(email);
      verify(
        h.mockApiService.post(
          "${Info.auth}/email/u/verify",
          data: anyNamed("data"),
        ),
      ).called(1);
    });
  });
}
