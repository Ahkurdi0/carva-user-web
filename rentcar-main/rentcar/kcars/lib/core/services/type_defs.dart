import 'package:fpdart/fpdart.dart';
import 'package:kcars/configs/error/failure.dart';

typedef Result<T> = Future<Either<Failure, T>>;
typedef ResultV<T> = Result<void>;
typedef DataMap = Map<String, dynamic>;
