import 'package:kcars/core/services/type_defs.dart';
import 'package:kcars/features/auth/data/model/auth.dart';
import 'package:kcars/features/auth/data/model/profile.dart';

abstract class AuthRepo {
  Result<Profile> login(Auth param);
  Result<Profile> signup(Auth param);
  Result<void> logout(Auth param);
  Result<Profile> refreshProfile([bool? isCheking]);
  Result<void> updateName(Auth param);
  Result<void> updatePassword(Auth param);
  Result<void> updateEmailSendOtp(Auth param);
  Result<void> updateEmailVerifyOtp(Auth param);
  Result<void> resetSendOtp(Auth param);
  Result<void> resetVerifyOtp(Auth param);
  Result<void> resetPassword(Auth param);
  Result<void> updatePreflang(Auth param);
  Result<Auth> updateProfilePicture(Auth param);
  Result<void> updatePhoneNumber(Auth param);
  Result<void> verifyEmailSendOtp(Auth param);
  Result<void> verifyEmailVerifyOtp(Auth param);
  Result<void> deleteAccount();
  Result<Auth> refreshToken(Auth param);
}
