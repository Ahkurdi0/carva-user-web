import 'package:equatable/equatable.dart';

class CompanyStates extends Equatable {
  const CompanyStates();
  @override
  List<Object?> get props => [];
}

class CompanyInitial extends CompanyStates {}

class UpdateCompanyLoading extends CompanyStates {
  const UpdateCompanyLoading();
}

class UpdateCompanyCompleted extends CompanyStates {
  const UpdateCompanyCompleted();

  @override
  List<Object?> get props => [];
}

class UpdateCompanyFailed extends CompanyStates {
  final String message;
  const UpdateCompanyFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewCompanyLoading extends CompanyStates {
  const NewCompanyLoading();
}

class NewCompanyCompleted extends CompanyStates {
  final String? id;
  const NewCompanyCompleted([this.id]);

  @override
  List<Object?> get props => [id];
}

class NewCompanyFailed extends CompanyStates {
  final String message;
  const NewCompanyFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class SortContactsLoading extends CompanyStates {
  const SortContactsLoading();
}

class SortContactsCompleted extends CompanyStates {
  const SortContactsCompleted();

  @override
  List<Object?> get props => [];
}

class SortContactsFailed extends CompanyStates {
  final String message;
  const SortContactsFailed(this.message);

  @override
  List<Object?> get props => [message];
}
