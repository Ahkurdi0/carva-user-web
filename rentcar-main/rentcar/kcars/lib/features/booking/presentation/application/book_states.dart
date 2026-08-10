import 'package:equatable/equatable.dart';
import 'package:kcars/features/booking/data/model/promotion_result.dart';

class BookStates extends Equatable {
  const BookStates();
  @override
  List<Object?> get props => [];
}

class BookInitial extends BookStates {
  const BookInitial();
}

class NewBookLoading extends BookStates {
  const NewBookLoading();
}

class NewBookCompleted extends BookStates {
  const NewBookCompleted();
}

class NewBookFailed extends BookStates {
  final String message;
  const NewBookFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class CancelBookLoading extends BookStates {
  const CancelBookLoading();
}

class CancelBookCompleted extends BookStates {
  const CancelBookCompleted();
}

class CancelBookFailed extends BookStates {
  final String message;
  const CancelBookFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateBookLoading extends BookStates {
  const UpdateBookLoading();
}

class UpdateBookCompleted extends BookStates {
  const UpdateBookCompleted();
}

class UpdateBookFailed extends BookStates {
  final String message;
  const UpdateBookFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadMoreBookLoading extends BookStates {
  const LoadMoreBookLoading();
}

class LoadMoreBookCompleted extends BookStates {
  const LoadMoreBookCompleted();
}

class LoadMoreBookFailed extends BookStates {
  final String message;
  const LoadMoreBookFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class LoadMoreCompanyBookCompleted extends BookStates {
  const LoadMoreCompanyBookCompleted();
}

class LoadMoreCompanyBookFailed extends BookStates {
  final String message;
  const LoadMoreCompanyBookFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class ApplyPromotionLoading extends BookStates {
  const ApplyPromotionLoading();
}

class ApplyPromotionCompleted extends BookStates {
  final PromotionResult result;
  const ApplyPromotionCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

class ApplyPromotionFailed extends BookStates {
  final String message;
  const ApplyPromotionFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class ContactLoading extends BookStates {
  const ContactLoading();
}

class ContactCompleted extends BookStates {
  final String? result;
  const ContactCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

class ContactFailed extends BookStates {
  final String message;
  const ContactFailed(this.message);

  @override
  List<Object?> get props => [message];
}
