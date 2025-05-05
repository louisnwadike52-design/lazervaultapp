import 'package:lazervault/core/typedefs.dart';
import 'package:equatable/equatable.dart';

abstract class UseCaseWithParams<Type, Params extends Equatable> {
  const UseCaseWithParams();
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();
  ResultFuture<Type> call();
}
