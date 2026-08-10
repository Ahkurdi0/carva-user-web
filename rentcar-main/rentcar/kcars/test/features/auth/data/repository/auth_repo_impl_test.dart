import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/features/company/data/model/company.dart';
import 'package:mockito/mockito.dart';
import 'auth_repo_test_helper.dart.dart';

void main() {
  late AuthRepoTest h;

  setUp(() {
    h = AuthRepoTest();
  });

  group("Auth Repo Impl Login", () {
    test("Return Right[Profile] when login success", () async {
      when(h.mockAuthRemote.login(h.auth)).thenAnswer(((_) async => h.profile));
      final result = await h.authRepo.login(h.auth);

      expect(result.isRight(), true);
      expect(result.getRight().toNullable(), h.profile);

      verify(h.mockAuthRemote.login(h.auth)).called(1);
    });

    test("Return Left(ApiFailure) when login fail", () async {
      when(
        h.mockAuthRemote.login(h.auth),
      ).thenThrow(ApiException(message: "Login failed", statusCode: 400));

      final result = await h.authRepo.login(h.auth);
      expect(result.isLeft(), true);

      verify(h.mockAuthRemote.login(h.auth)).called(1);
    });

    test("Return Profile with Compnay", () async {
      final withCompnay = h.profile.copyWith(
        company: Company(
          id: "COMP123",
          name: "Test Company",
          review: 0.0,
          rate: 0,
        ),
      );
      when(
        h.mockAuthRemote.login(h.auth),
      ).thenAnswer(((_) async => withCompnay));

      final result = await h.authRepo.login(h.auth);
      expect(result.isRight(), true);
      expect(result, Right(withCompnay));
      verify(h.mockAuthRemote.login(h.auth)).called(1);
    });

    test("Shoul Return Profile when singup success", () async {
      when(
        h.mockAuthRemote.signup(h.auth),
      ).thenAnswer(((_) async => h.profile));
      final result = await h.authRepo.signup(h.auth);
      expect(result.isRight(), true);
      expect(result.getRight().toNullable(), h.profile);
      verify(h.mockAuthRemote.signup(h.auth)).called(1);
    });

    test("Should return Profile when Refresh", () async {
      when(
        h.mockAuthRemote.refreshProfile(),
      ).thenAnswer(((_) async => h.profile));
      final result = await h.authRepo.refreshProfile();
      expect(result.isRight(), true);
      expect(result.getRight().toNullable(), h.profile);
      verify(h.mockAuthRemote.refreshProfile()).called(1);
    });
    test("Should log out user", () async {
      when(
        h.mockAuthRemote.logout(h.auth),
      ).thenAnswer((_) => Future.value(null));
      final result = await h.authRepo.logout(h.auth);
      expect(result.isRight(), true);
      verify(h.mockAuthRemote.logout(h.auth)).called(1);
    });

    test("Should Return ImagegUrl when update profile picture", () async {
      final imageUrl = "https://example.com/image.jpg";
      final updatedAuth = h.auth.copyWith(image: imageUrl);

      when(
        h.mockAuthRemote.updateProfilePicture(h.auth),
      ).thenAnswer(((_) async => updatedAuth));

      final result = await h.authRepo.updateProfilePicture(h.auth);
      expect(result.isRight(), true);
      expect(result.getRight().toNullable(), updatedAuth);
      verify(h.mockAuthRemote.updateProfilePicture(h.auth)).called(1);
    });

    test("Should Update prefLang when success", () async {
      final updatedAuth = h.auth.copyWith(prefLang: "en");
      when(
        h.mockAuthRemote.updatePreflang(h.auth),
      ).thenAnswer(((_) async => updatedAuth));
      final result = await h.authRepo.updatePreflang(h.auth);
      expect(result.isRight(), true);
      expect(result, Right(null));

      verify(h.mockAuthRemote.updatePreflang(h.auth)).called(1);
    });

    test("Should Update Phone Number when success", () async {
      final updatedAuth = h.auth.copyWith(phoneNumber: "1234567890");
      when(
        h.mockAuthRemote.updatePhoneNumber(h.auth),
      ).thenAnswer(((_) async => updatedAuth));
      final result = await h.authRepo.updatePhoneNumber(h.auth);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.updatePhoneNumber(h.auth)).called(1);
    });

    test("Should Update Name when success", () async {
      when(
        h.mockAuthRemote.updateName(h.auth),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.updateName(h.auth);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.updateName(h.auth)).called(1);
    });

    test("Should Update Password when success", () async {
      final password = h.auth.copyWith(
        oldPassword: "12345678",
        password: "123456788",
      );
      when(
        h.mockAuthRemote.updatePassword(password),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.updatePassword(password);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.updatePassword(password)).called(1);
    });

    test("Should sucess when delete account", () async {
      when(
        h.mockAuthRemote.deleteAccount(),
      ).thenAnswer(((_) async => Future.value(null)));

      final result = await h.authRepo.deleteAccount();

      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.deleteAccount()).called(1);
    });
  });

  group("Reset Password", () {
    test("Should Send Otp", () async {
      final resetEmail = h.auth.copyWith(email: "test@gmail.com");
      when(
        h.mockAuthRemote.resetSendOtp(resetEmail),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.resetSendOtp(resetEmail);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.resetSendOtp(resetEmail)).called(1);
    });

    test("Should Verify Otp", () async {
      final resetEmail = h.auth.copyWith(
        email: "test@gmail.com",
        code: "123456",
      );
      when(
        h.mockAuthRemote.resetVerifyOtp(resetEmail),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.resetVerifyOtp(resetEmail);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.resetVerifyOtp(resetEmail)).called(1);
    });

    test("Should Reset Password", () async {
      final resetEmail = h.auth.copyWith(
        email: "test@gmail.com",
        code: "123456",
        password: "newpassword123",
      );
      when(
        h.mockAuthRemote.resetPassword(resetEmail),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.resetPassword(resetEmail);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.resetPassword(resetEmail)).called(1);
    });
  });

  group("Verify Email", () {
    test("Should Send Otp to Update Email", () async {
      final updateEmail = h.auth.copyWith(email: "test@gmail.com");
      when(
        h.mockAuthRemote.updateEmailSendOtp(updateEmail),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.updateEmailSendOtp(updateEmail);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.updateEmailSendOtp(updateEmail)).called(1);
    });

    test("Should Verify Otp to Update Email", () async {
      final updateEmail = h.auth.copyWith(
        email: "  test@gmail.com",
        code: "123456",
      );
      when(
        h.mockAuthRemote.updateEmailVerifyOtp(updateEmail),
      ).thenAnswer(((_) async => Future.value(null)));
      final result = await h.authRepo.updateEmailVerifyOtp(updateEmail);
      expect(result.isRight(), true);
      expect(result, Right(null));
      verify(h.mockAuthRemote.updateEmailVerifyOtp(updateEmail)).called(1);
    });
  });
}
