import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../../domain/entities/id_pay_transaction_entity.dart';
import '../../domain/repositories/id_pay_repository.dart';
import '../datasources/id_pay_remote_datasource.dart';

class IDPayRepositoryImpl implements IDPayRepository {
  final IDPayRemoteDataSource remoteDataSource;

  IDPayRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, IDPayEntity>> createIDPay({
    required IDPayType type,
    required IDPayAmountMode amountMode,
    required double amount,
    required String currency,
    double? minAmount,
    double? maxAmount,
    String? description,
    required int validityMinutes,
    bool neverExpires = false,
    String? organizationId,
  }) async {
    try {
      final result = await remoteDataSource.createIDPay(
        type: type,
        amountMode: amountMode,
        amount: amount,
        currency: currency,
        minAmount: minAmount,
        maxAmount: maxAmount,
        description: description,
        validityMinutes: validityMinutes,
        neverExpires: neverExpires,
        organizationId: organizationId,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to create IDPay',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, IDPayEntity>> lookupIDPay({
    required String payId,
  }) async {
    try {
      final result = await remoteDataSource.lookupIDPay(payId: payId);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to lookup IDPay',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, (IDPayTransactionEntity, double)>> payIDPay({
    required String payId,
    required double amount,
    required String transactionPin,
    required String sourceAccountId,
    String? idempotencyKey,
  }) async {
    try {
      final result = await remoteDataSource.payIDPay(
        payId: payId,
        amount: amount,
        transactionPin: transactionPin,
        sourceAccountId: sourceAccountId,
        idempotencyKey: idempotencyKey,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to process IDPay payment',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<IDPayEntity>>> getMyIDPays({
    int? limit,
    int? offset,
    IDPayStatus? statusFilter,
  }) async {
    try {
      final result = await remoteDataSource.getMyIDPays(
        limit: limit,
        offset: offset,
        statusFilter: statusFilter,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get IDPays',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, List<IDPayTransactionEntity>>> getIDPayTransactions({
    required String payId,
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await remoteDataSource.getIDPayTransactions(
        payId: payId,
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get IDPay transactions',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelIDPay({
    required String id,
  }) async {
    try {
      await remoteDataSource.cancelIDPay(id: id);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to cancel IDPay',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, IDPayEntity>> getIDPayDetails({
    required String id,
  }) async {
    try {
      final result = await remoteDataSource.getIDPayDetails(id: id);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get IDPay details',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, IDPayOrganizationEntity>> createOrganization({
    required String name,
    required String description,
    String? logoUrl,
    required String accountId,
  }) async {
    try {
      final result = await remoteDataSource.createOrganization(
        name: name,
        description: description,
        logoUrl: logoUrl,
        accountId: accountId,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to create organization',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, (List<IDPayOrganizationEntity>, int)>>
      getMyOrganizations({
    required String accountId,
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await remoteDataSource.getMyOrganizations(
        accountId: accountId,
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get organizations',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, IDPayOrganizationEntity>> updateOrganization({
    required String id,
    String? name,
    String? description,
    String? logoUrl,
  }) async {
    try {
      final result = await remoteDataSource.updateOrganization(
        id: id,
        name: name,
        description: description,
        logoUrl: logoUrl,
      );
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to update organization',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrganization({
    required String id,
  }) async {
    try {
      await remoteDataSource.deleteOrganization(id: id);
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to delete organization',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, (IDPayOrganizationEntity, List<IDPayEntity>, double)>>
      getOrganizationDetails({
    required String id,
  }) async {
    try {
      final result = await remoteDataSource.getOrganizationDetails(id: id);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to get organization details',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }

  @override
  Future<Either<Failure, (IDPayEntity, IDPayOrganizationEntity?)>>
      lookupIDPayWithOrg({
    required String payId,
  }) async {
    try {
      final result = await remoteDataSource.lookupIDPayWithOrg(payId: payId);
      return Right(result);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: e.message ?? 'Failed to lookup IDPay',
          statusCode: e.codeName));
    } catch (e) {
      return Left(
          ServerFailure(message: e.toString(), statusCode: 'UNKNOWN'));
    }
  }
}
