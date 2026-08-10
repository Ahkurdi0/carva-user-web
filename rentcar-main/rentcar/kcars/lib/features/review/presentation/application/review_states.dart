import 'package:equatable/equatable.dart';

class ReviewSates extends Equatable {
  const ReviewSates();
  @override
  List<Object?> get props => [];
}

class RevewInitialState extends ReviewSates {
  const RevewInitialState();
}

class NewCarReviewLoading extends ReviewSates {
  const NewCarReviewLoading();
}

class NewCarReviewFailed extends ReviewSates {
  final String message;
  const NewCarReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewCarReviewCompleted extends ReviewSates {
  final String? id;
  const NewCarReviewCompleted([this.id]);

  @override
  List<Object?> get props => [id];
}

class NewCompanyReviewLoading extends ReviewSates {
  const NewCompanyReviewLoading();
}

class NewCompanyReviewFailed extends ReviewSates {
  final String message;
  const NewCompanyReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewCompanyReviewCompleted extends ReviewSates {
  final String? id;
  const NewCompanyReviewCompleted([this.id]);

  @override
  List<Object?> get props => [id];
}

class FlagCarReviewLoading extends ReviewSates {
  const FlagCarReviewLoading();
}

class FlagCarReviewFailed extends ReviewSates {
  final String message;
  const FlagCarReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class FlagCarReviewCompleted extends ReviewSates {
  const FlagCarReviewCompleted();
}

class FlagCompanyReviewLoading extends ReviewSates {
  const FlagCompanyReviewLoading();
}

class FlagCompanyReviewFailed extends ReviewSates {
  final String message;
  const FlagCompanyReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class FlagCompanyReviewCompleted extends ReviewSates {
  const FlagCompanyReviewCompleted();
}

class UpdateCarReviewLoading extends ReviewSates {
  const UpdateCarReviewLoading();
}

class UpdateCarReviewFailed extends ReviewSates {
  final String message;
  const UpdateCarReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateCarReviewCompleted extends ReviewSates {
  const UpdateCarReviewCompleted();
}

class UpdateCompanyReviewLoading extends ReviewSates {
  const UpdateCompanyReviewLoading();
}

class UpdateCompanyReviewFailed extends ReviewSates {
  final String message;
  const UpdateCompanyReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateCompanyReviewCompleted extends ReviewSates {
  const UpdateCompanyReviewCompleted();
}

class DeleteCarReviewLoading extends ReviewSates {
  const DeleteCarReviewLoading();
}

class DeleteCarReviewFailed extends ReviewSates {
  final String message;
  const DeleteCarReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteCarReviewCompleted extends ReviewSates {
  const DeleteCarReviewCompleted();
}

class DeleteCompanyReviewLoading extends ReviewSates {
  const DeleteCompanyReviewLoading();
}

class DeleteCompanyReviewFailed extends ReviewSates {
  final String message;
  const DeleteCompanyReviewFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteCompanyReviewCompleted extends ReviewSates {
  const DeleteCompanyReviewCompleted();
}
