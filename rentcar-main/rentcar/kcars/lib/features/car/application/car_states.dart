import 'package:equatable/equatable.dart';

class CarStates extends Equatable {
  const CarStates();
  @override
  List<Object?> get props => [];
}

class InitialCarState extends CarStates {
  const InitialCarState();
}

class NewCarLoading extends CarStates {
  const NewCarLoading();
}

class NewCarCompleted extends CarStates {
  const NewCarCompleted();
}

class NewCarFailed extends CarStates {
  final String message;

  const NewCarFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateCarLoading extends CarStates {
  const UpdateCarLoading();
}

class UpdateCarCompleted extends CarStates {
  const UpdateCarCompleted();
}

class UpdateCarFailed extends CarStates {
  final String message;

  const UpdateCarFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteCarLoading extends CarStates {
  const DeleteCarLoading();
}

class DeleteCarCompleted extends CarStates {
  const DeleteCarCompleted();
}

class DeleteCarFailed extends CarStates {
  final String message;
  const DeleteCarFailed(this.message);

  @override
  List<Object?> get props => [message];
}

//
class NewPromotionLoading extends CarStates {
  const NewPromotionLoading();
}

class NewPromotionCompleted extends CarStates {
  const NewPromotionCompleted();
}

class NewPromotionFailed extends CarStates {
  final String message;
  const NewPromotionFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletePromotionLoading extends CarStates {
  const DeletePromotionLoading();
}

class DeletePromotionCompleted extends CarStates {
  const DeletePromotionCompleted();
}

class DeletePromotionFailed extends CarStates {
  final String message;
  const DeletePromotionFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class SortImagesLoading extends CarStates {
  const SortImagesLoading();
}

class SortImagesCompleted extends CarStates {
  const SortImagesCompleted();
}

class SortImagesFailed extends CarStates {
  final String message;
  const SortImagesFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class SortItemLoading extends CarStates {
  const SortItemLoading();
}

class SortItemCompleted extends CarStates {
  const SortItemCompleted();
}

class SortItemFailed extends CarStates {
  final String message;
  const SortItemFailed(this.message);

  @override
  List<Object?> get props => [message];
}

///
class LoadMoreCarsLoading extends CarStates {
  const LoadMoreCarsLoading();
}

class LoadMoreCarsCompleted extends CarStates {
  const LoadMoreCarsCompleted();
}

class LoadMoreCarsFailed extends CarStates {
  final String message;
  const LoadMoreCarsFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteCarLoading extends CarStates {
  const FavoriteCarLoading();
}

class FavoriteCarCompleted extends CarStates {
  const FavoriteCarCompleted();
}

class FavoriteCarFailed extends CarStates {
  final String message;
  const FavoriteCarFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewFeatureCarLoading extends CarStates {
  const NewFeatureCarLoading();
}

class NewFeatureCarCompleted extends CarStates {
  const NewFeatureCarCompleted();
}

class NewFeatureCarFailed extends CarStates {
  final String message;
  const NewFeatureCarFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteFeatureCarLoading extends CarStates {
  const DeleteFeatureCarLoading();
}

class DeleteFeatureCarCompleted extends CarStates {
  const DeleteFeatureCarCompleted();
}

class DeleteFeatureCarFailed extends CarStates {
  final String message;
  const DeleteFeatureCarFailed(this.message);

  @override
  List<Object?> get props => [message];
}
