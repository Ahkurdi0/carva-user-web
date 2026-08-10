import 'package:equatable/equatable.dart';

class UserStates extends Equatable {
  const UserStates();
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserStates {
  const UserInitialState();
}

class UpdateUserRoleLoading extends UserStates {
  const UpdateUserRoleLoading();
}

class UpdateUserRoleCompleted extends UserStates {
  const UpdateUserRoleCompleted();
}

class UpdateUserRoleFailed extends UserStates {
  final String message;
  const UpdateUserRoleFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateAccountStatusLoading extends UserStates {
  const UpdateAccountStatusLoading();
}

class UpdateAccountStatusCompleted extends UserStates {
  const UpdateAccountStatusCompleted();
}

class UpdateAccountStatusFailed extends UserStates {
  final String message;
  const UpdateAccountStatusFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteBanLoading extends UserStates {
  const DeleteBanLoading();
}

class DeleteBanCompleted extends UserStates {
  const DeleteBanCompleted();
}

class DeleteBanFailed extends UserStates {
  final String message;
  const DeleteBanFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateUserPasswordLoading extends UserStates {
  const UpdateUserPasswordLoading();
}

class UpdateUserPasswordCompleted extends UserStates {
  const UpdateUserPasswordCompleted();
}

class UpdateUserPasswordFailed extends UserStates {
  final String message;
  const UpdateUserPasswordFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class RecoverAccountLoading extends UserStates {
  const RecoverAccountLoading();
}

class RecoverAccountCompleted extends UserStates {
  const RecoverAccountCompleted();
}

class RecoverAccountFailed extends UserStates {
  final String message;
  const RecoverAccountFailed(this.message);

  @override
  List<Object?> get props => [message];
}
