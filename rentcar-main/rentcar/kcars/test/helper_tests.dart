import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/exception.dart';
import 'package:kcars/configs/error/failure.dart';
import 'package:kcars/core/services/type_defs.dart';
import 'package:mockito/mockito.dart';

class DummyFailure extends Failure {
  const DummyFailure({required super.message, required super.statusCode});
}

dummyFailure({String? message, int? statusCode}) => DummyFailure(
  message: message ?? 'Dummy error',
  statusCode: statusCode ?? 400,
);

const dummyEitherVoid = Right<Failure, void>(null);

void registerEitherVoidFallback() {
  provideDummy<Either<Failure, void>>(dummyEitherVoid);
}

// Register dummy Failure
void registerFailureFallback() {
  provideDummy<Failure>(dummyFailure());
}

void registerEitherFallback<T>() {
  provideDummy<Either<Failure, T>>(
    Left(DummyFailure(message: 'dummy', statusCode: 400)),
  );
}

void registerEitherListFallback<T>() {
  provideDummy<Either<Failure, List<T>>>(Right(<T>[]));
}

Answering<Result<T>> failureAnswer<T>({
  String message = 'Operation failed',
  int statusCode = 400,
}) {
  return (Invocation _) async =>
      Left(DummyFailure(message: message, statusCode: statusCode));
}

void expectFailureWithStatusCode(
  Either<Failure, dynamic> result, [
  int code = 400,
]) {
  expect(result.isLeft(), true);
  expect(result.fold((l) => l.statusCode, (r) => null), equals(code));
}

void expectSuccess<T>(Either<Failure, T> result, T expectedData) {
  expect(result.isRight(), true);
  expect(result, equals(Right(expectedData)));
}

/// Remite Reusable
///
ApiException apiException({
  int statusCode = 500,
  String message = 'Internal Server Error',
}) {
  return ApiException(statusCode: statusCode, message: message);
}

Answering<Future<T>> apiExceptionThrower<T>({
  int statusCode = 500,
  String message = 'Internal Server Error',
}) {
  return (_) async =>
      throw apiException(statusCode: statusCode, message: message);
}

Future<void> expectApiException(
  Future<dynamic> Function() func, {
  int statusCode = 500,
  String message = 'Internal Server Error',
}) async {
  await expectLater(
    func(),
    throwsA(
      isA<ApiException>()
          .having((e) => e.statusCode, 'statusCode', statusCode)
          .having((e) => e.message, 'message', message),
    ),
  );
}
