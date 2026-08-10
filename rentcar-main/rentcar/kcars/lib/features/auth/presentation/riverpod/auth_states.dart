import 'package:equatable/equatable.dart';
import 'package:kcars/features/auth/data/model/profile.dart';

class AuthStates extends Equatable {
  const AuthStates();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthStates {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthStates {
  const AuthLoading();
}

class AuthCompleted extends AuthStates {
  const AuthCompleted(this.profile);
  final Profile profile;
  @override
  List<Object?> get props => [profile];
}

class AuthFailed extends AuthStates {
  const AuthFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class SignupLoading extends AuthStates {
  const SignupLoading();
}

class SignupCompleted extends AuthStates {
  const SignupCompleted(this.profile);
  final Profile profile;
  @override
  List<Object?> get props => [profile];
}

class SignupFailed extends AuthStates {
  const SignupFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class LogoutLoading extends AuthStates {
  const LogoutLoading();
}

class LogoutCompleted extends AuthStates {
  const LogoutCompleted();
}

class LogoutFailed extends AuthStates {
  const LogoutFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class DeleteAccountLoading extends AuthStates {
  const DeleteAccountLoading();
}

class DeleteAccountCompleted extends AuthStates {
  const DeleteAccountCompleted();
}

class DeleteAccountFailed extends AuthStates {
  const DeleteAccountFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdateProfilePicLoading extends AuthStates {
  const UpdateProfilePicLoading();
}

class UpdateProfilePicCompleted extends AuthStates {
  const UpdateProfilePicCompleted();
}

class UpdateProfilePicFailed extends AuthStates {
  const UpdateProfilePicFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdatePasswordLoading extends AuthStates {
  const UpdatePasswordLoading();
}

class UpdatePasswordCompleted extends AuthStates {
  const UpdatePasswordCompleted();
}

class UpdatePasswordFailed extends AuthStates {
  const UpdatePasswordFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdateNameLoading extends AuthStates {
  const UpdateNameLoading();
}

class UpdateNameCompleted extends AuthStates {
  const UpdateNameCompleted();
}

class UpdateNameFailed extends AuthStates {
  const UpdateNameFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdatePhoneLoading extends AuthStates {
  const UpdatePhoneLoading();
}

class UpdatePhoneCompleted extends AuthStates {
  const UpdatePhoneCompleted();
}

class UpdatePhoneFailed extends AuthStates {
  const UpdatePhoneFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdateEmailSendOtpLoading extends AuthStates {
  const UpdateEmailSendOtpLoading();
}

class UpdateEmailSendOtpCompleted extends AuthStates {
  const UpdateEmailSendOtpCompleted();
}

class UpdateEmailSendOtpFailed extends AuthStates {
  const UpdateEmailSendOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdateEmailVerifyOtpLoading extends AuthStates {
  const UpdateEmailVerifyOtpLoading();
}

class UpdateEmailVerifyOtpCompleted extends AuthStates {
  const UpdateEmailVerifyOtpCompleted();
}

class UpdateEmailVerifyOtpFailed extends AuthStates {
  const UpdateEmailVerifyOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class VerifyEamilSendOtpLoading extends AuthStates {
  const VerifyEamilSendOtpLoading();
}

class VerifyEamilSendOtpCompleted extends AuthStates {
  const VerifyEamilSendOtpCompleted();
}

class VerifyEamilSendOtpFailed extends AuthStates {
  const VerifyEamilSendOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class VerifyEamilVerifytpLoading extends AuthStates {
  const VerifyEamilVerifytpLoading();
}

class VerifyEamilVerifytpCompleted extends AuthStates {
  const VerifyEamilVerifytpCompleted();
}

class VerifyEamilVerifytpFailed extends AuthStates {
  const VerifyEamilVerifytpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class ResetSendOtpLoading extends AuthStates {
  const ResetSendOtpLoading();
}

class ResetSendOtpCompleted extends AuthStates {
  const ResetSendOtpCompleted();
}

class ResetSendOtpFailed extends AuthStates {
  const ResetSendOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class ResetVerifyOtpLoading extends AuthStates {
  const ResetVerifyOtpLoading();
}

class ResetVerifyOtpCompleted extends AuthStates {
  const ResetVerifyOtpCompleted();
}

class ResetVerifyOtpFailed extends AuthStates {
  const ResetVerifyOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class ResetPasswordLoading extends AuthStates {
  const ResetPasswordLoading();
}

class ResetPasswordCompleted extends AuthStates {
  const ResetPasswordCompleted();
}

class ResetPasswordFailed extends AuthStates {
  const ResetPasswordFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class UpdatePrefLangLoading extends AuthStates {
  const UpdatePrefLangLoading();
}

class UpdatePrefLangCompleted extends AuthStates {
  const UpdatePrefLangCompleted();
}

class UpdatePrefLangFailed extends AuthStates {
  const UpdatePrefLangFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class RefreshLoading extends AuthStates {
  const RefreshLoading();
}

class RefreshCompleted extends AuthStates {
  const RefreshCompleted();
}

class RefreshFailed extends AuthStates {
  const RefreshFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class SetOnBoardingLoading extends AuthStates {
  const SetOnBoardingLoading();
}

class SetOnBoardingCompleted extends AuthStates {
  const SetOnBoardingCompleted();
}

class SetOnBoardingFailed extends AuthStates {
  const SetOnBoardingFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
