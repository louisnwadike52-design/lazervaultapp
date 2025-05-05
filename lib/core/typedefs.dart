// import 'package:fpdart/fpdart.dart'; // Change to dartz
import 'package:dartz/dartz.dart'; // Use dartz
import 'package:lazervault/core/error/failure.dart';

// Use dartz's Either
typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>; 