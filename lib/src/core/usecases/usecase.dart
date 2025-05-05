import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

/// A type alias for a Future that returns either a Failure or a Type.
/// This is commonly used in use cases to represent asynchronous operations
/// that might fail.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// A type alias for a Future that returns either a Failure or void.
/// Useful for operations that don't return a value upon success but can fail.
typedef ResultVoid = ResultFuture<void>;

/// An abstract class representing a use case that takes parameters.
///
/// [Type] is the return type upon success.
/// [Params] is the type of the parameters required to execute the use case.
abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  /// Executes the use case with the given [params].
  ResultFuture<Type> call(Params params);
}

/// An abstract class representing a use case that does not take parameters.
///
/// [Type] is the return type upon success.
abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  /// Executes the use case.
  ResultFuture<Type> call();
} 