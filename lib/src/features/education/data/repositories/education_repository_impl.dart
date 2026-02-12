import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../domain/entities/education_purchase_entity.dart';
import '../../domain/repositories/education_repository.dart';
import '../datasources/education_remote_datasource.dart';

class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource remoteDataSource;

  EducationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<EducationProviderEntity>>> getProviders({bool activeOnly = true}) async {
    try {
      final result = await remoteDataSource.getProviders(activeOnly: activeOnly);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to get education providers', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, EducationPurchaseEntity>> purchasePin({
    required String serviceId,
    required int quantity,
    required String phone,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    try {
      final result = await remoteDataSource.purchasePin(
        serviceId: serviceId,
        quantity: quantity,
        phone: phone,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Failed to purchase education pin', statusCode: e.codeName));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
