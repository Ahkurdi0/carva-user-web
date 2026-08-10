import 'package:equatable/equatable.dart';

class AppSettingsStates extends Equatable {
  const AppSettingsStates();

  @override
  List<Object?> get props => [];
}

class AppSettingsInitialState extends AppSettingsStates {
  const AppSettingsInitialState();
}

class NewCityLoading extends AppSettingsStates {
  const NewCityLoading();
}

class NewCityCompleted extends AppSettingsStates {
  const NewCityCompleted();
}

class NewCityFailed extends AppSettingsStates {
  final String message;
  const NewCityFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteCityLoading extends AppSettingsStates {
  const DeleteCityLoading();
}

class DeleteCityCompleted extends AppSettingsStates {
  const DeleteCityCompleted();
}

class DeleteCityFailed extends AppSettingsStates {
  final String message;
  const DeleteCityFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewTownLoading extends AppSettingsStates {
  const NewTownLoading();
}

class NewTownCompleted extends AppSettingsStates {
  const NewTownCompleted();
}

class NewTownFailed extends AppSettingsStates {
  final String message;
  const NewTownFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteTownLoading extends AppSettingsStates {
  const DeleteTownLoading();
}

class DeleteTownCompleted extends AppSettingsStates {
  const DeleteTownCompleted();
}

class DeleteTownFailed extends AppSettingsStates {
  final String message;
  const DeleteTownFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewSupportLoading extends AppSettingsStates {
  const NewSupportLoading();
}

class NewSupportCompleted extends AppSettingsStates {
  const NewSupportCompleted();
}

class NewSupportFailed extends AppSettingsStates {
  final String message;
  const NewSupportFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteSupportLoading extends AppSettingsStates {
  const DeleteSupportLoading();
}

class DeleteSupportCompleted extends AppSettingsStates {
  const DeleteSupportCompleted();
}

class DeleteSupportFailed extends AppSettingsStates {
  final String message;
  const DeleteSupportFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewCarTypeLoading extends AppSettingsStates {
  const NewCarTypeLoading();
}

class NewCarTypeCompleted extends AppSettingsStates {
  const NewCarTypeCompleted();
}

class NewCarTypeFailed extends AppSettingsStates {
  final String message;
  const NewCarTypeFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteCarTypeLoading extends AppSettingsStates {
  const DeleteCarTypeLoading();
}

class DeleteCarTypeCompleted extends AppSettingsStates {
  const DeleteCarTypeCompleted();
}

class DeleteCarTypeFailed extends AppSettingsStates {
  final String message;
  const DeleteCarTypeFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewBrandLoading extends AppSettingsStates {
  const NewBrandLoading();
}

class NewBrandCompleted extends AppSettingsStates {
  const NewBrandCompleted();
}

class NewBrandFailed extends AppSettingsStates {
  final String message;
  const NewBrandFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteBrandLoading extends AppSettingsStates {
  const DeleteBrandLoading();
}

class DeleteBrandCompleted extends AppSettingsStates {
  const DeleteBrandCompleted();
}

class DeleteBrandFailed extends AppSettingsStates {
  final String message;
  const DeleteBrandFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class SortingLoading extends AppSettingsStates {
  const SortingLoading();
}

class SortingCompleted extends AppSettingsStates {
  const SortingCompleted();
}

class SortingFailed extends AppSettingsStates {
  final String message;
  const SortingFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewNotificationLoading extends AppSettingsStates {
  const NewNotificationLoading();
}

class NewNotificationCompleted extends AppSettingsStates {
  const NewNotificationCompleted();
}

class NewNotificationFailed extends AppSettingsStates {
  final String message;
  const NewNotificationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteNotificationLoading extends AppSettingsStates {
  const DeleteNotificationLoading();
}

class DeleteNotificationCompleted extends AppSettingsStates {
  const DeleteNotificationCompleted();
}

class DeleteNotificationFailed extends AppSettingsStates {
  final String message;
  const DeleteNotificationFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class NewSliderLoading extends AppSettingsStates {
  const NewSliderLoading();
}

class NewSliderCompleted extends AppSettingsStates {
  const NewSliderCompleted();
}

class NewSliderFailed extends AppSettingsStates {
  final String message;
  const NewSliderFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteSliderLoading extends AppSettingsStates {
  const DeleteSliderLoading();
}

class DeleteSliderCompleted extends AppSettingsStates {
  const DeleteSliderCompleted();
}

class DeleteSliderFailed extends AppSettingsStates {
  final String message;
  const DeleteSliderFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class SliderLoading extends AppSettingsStates {
  const SliderLoading();
}

class SliderCompleted extends AppSettingsStates {
  final String? result;
  const SliderCompleted([this.result]);
  @override
  List<Object?> get props => [result];
}

class SliderFailed extends AppSettingsStates {
  final String message;
  const SliderFailed(this.message);

  @override
  List<Object?> get props => [message];
}
