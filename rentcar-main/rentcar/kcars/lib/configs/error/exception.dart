import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const CustomException({required this.message, required this.statusCode});

  @override
  String toString() => message;
  @override
  List<Object?> get props => [message, statusCode];
}

class ApiException extends CustomException {
  const ApiException({required super.message, required super.statusCode});

  factory ApiException.exception({String? message, int? statusCode}) =>
      const ApiException(message: "test", statusCode: 400);
  @override
  List<Object?> get props => [message, statusCode];
}
