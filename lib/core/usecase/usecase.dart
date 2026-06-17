import 'package:lazervault/core/typedefs.dart';
import 'package:equatable/equatable.dart';

abstract class UseCaseWithParams<T, Params extends Equatable> {
  const UseCaseWithParams();
  ResultFuture<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();
  ResultFuture<T> call();
}
