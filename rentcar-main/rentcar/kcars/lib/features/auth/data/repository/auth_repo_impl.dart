import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';
import 'package:kcars/features/auth/data/remote/auth_remote.dart';
import 'package:kcars/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this.authRemote);

  final AuthRemote authRemote;

  @override
  Result<Profile> login(Auth param) async {
    try {
      final result = await authRemote.login(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> logout(Auth param) async {
    try {
      await authRemote.logout(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Profile> refreshProfile([bool? isCheking]) async {
    try {
      final result = await authRemote.refreshProfile(isCheking);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Auth> refreshToken(Auth param) async {
    try {
      final result = await authRemote.refreshToken(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> resetPassword(Auth param) async {
    try {
      await authRemote.resetPassword(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> resetSendOtp(Auth param) async {
    try {
      await authRemote.resetSendOtp(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> resetVerifyOtp(Auth param) async {
    try {
      await authRemote.resetVerifyOtp(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Profile> signup(Auth param) async {
    try {
      final result = await authRemote.signup(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateEmailSendOtp(Auth param) async {
    try {
      await authRemote.updateEmailSendOtp(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateEmailVerifyOtp(Auth param) async {
    try {
      await authRemote.updateEmailVerifyOtp(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updateName(Auth param) async {
    try {
      await authRemote.updateName(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updatePassword(Auth param) async {
    try {
      await authRemote.updatePassword(param);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<Auth> updateProfilePicture(Auth param) async {
    try {
      final result = await authRemote.updateProfilePicture(param);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updatePhoneNumber(Auth param) async {
    try {
      await authRemote.updatePhoneNumber(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> updatePreflang(Auth param) async {
    try {
      await authRemote.updatePreflang(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> verifyEmailSendOtp(Auth param) async {
    try {
      await authRemote.verifyEmailSendOtp(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> verifyEmailVerifyOtp(Auth param) async {
    try {
      await authRemote.verifyEmailVerifyOtp(param);
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }

  @override
  Result<void> deleteAccount() async {
    try {
      await authRemote.deleteAccount();
      return Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromExcaption(e));
    }
  }
}
