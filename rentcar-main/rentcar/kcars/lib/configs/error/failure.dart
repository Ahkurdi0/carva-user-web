import 'package:equatable/equatable.dart';
import 'package:kcars/configs/error/exception.dart';

class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});
  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  @override
  List<Object?> get props => [message, statusCode];

  factory ApiFailure.fromExcaption(ApiException e) {
    return ApiFailure(message: e.message, statusCode: e.statusCode);
  }
}
