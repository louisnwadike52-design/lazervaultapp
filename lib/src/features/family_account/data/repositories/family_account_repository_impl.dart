import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/grpc_exceptions.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/family_account/data/datasources/family_account_remote_data_source.dart';
import 'package:lazervault/src/features/family_account/data/models/family_account_models.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/domain/repositories/family_account_repository.dart';

class FamilyAccountRepositoryImpl implements FamilyAccountRepository {
  final FamilyAccountRemoteDataSource remoteDataSource;

  FamilyAccountRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<FamilyAccount>>> getFamilyAccounts({
    String? statusFilter,
  }) async {
    try {
      final accounts = await remoteDataSource.getFamilyAccounts(
        statusFilter: statusFilter,
      );
      return Right(accounts.map((proto) => proto.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyAccount>> getFamilyAccount(String familyId) async {
    try {
      final account = await remoteDataSource.getFamilyAccount(familyId);
      return Right(account.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyAccount>> createFamilyAccount({
    required String name,
    String? description,
    required String initialCurrency,
    required double initialFunding,
    required bool allowMemberContributions,
  }) async {
    try {
      final request = CreateFamilyAccountRequest(
        name: name,
        description: description,
        initialCurrency: initialCurrency,
        initialFunding: initialFunding,
        allowMemberContributions: allowMemberContributions,
        creatorId: 'current_user_id', // TODO: Get from auth service
        creatorName: 'Current User', // TODO: Get from auth service
        creatorEmail: null, // TODO: Get from auth service
      );

      final account = await remoteDataSource.createFamilyAccount(request);
      return Right(account.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyMember>> addFamilyMember({
    required String familyId,
    required String invitationMethod,
    required String invitationDestination,
    required double initialAllocation,
    required double dailyLimit,
    required double monthlyLimit,
    required double perTransactionLimit,
    required double allocationPercentageCap,
    required String role,
    String? personalMessage,
  }) async {
    try {
      // Extract full name from invitation destination (email or phone)
      // TODO: Allow user to provide full name separately
      final fullName = invitationMethod == 'email'
          ? (invitationDestination.split('@')[0])
          : 'Member';

      final request = AddFamilyMemberRequest(
        familyId: familyId,
        fullName: fullName,
        invitationMethod: invitationMethod,
        invitationDestination: invitationDestination,
        initialAllocation: initialAllocation,
        dailyLimit: dailyLimit,
        monthlyLimit: monthlyLimit,
        perTransactionLimit: perTransactionLimit,
        allocationPercentageCap: allocationPercentageCap,
        role: role,
        personalMessage: personalMessage,
      );

      final member = await remoteDataSource.addFamilyMember(request);
      return Right(member.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyMember>> updateFamilyMember({
    required String familyId,
    required String memberId,
    double? allocatedBalance,
    double? dailySpendingLimit,
    double? monthlySpendingLimit,
    double? perTransactionLimit,
    double? allocationPercentageCap,
    String? role,
  }) async {
    try {
      final request = UpdateFamilyMemberRequest(
        familyId: familyId,
        memberId: memberId,
        allocatedBalance: allocatedBalance,
        dailySpendingLimit: dailySpendingLimit,
        monthlySpendingLimit: monthlySpendingLimit,
        perTransactionLimit: perTransactionLimit,
        allocationPercentageCap: allocationPercentageCap,
        role: role,
      );

      final member = await remoteDataSource.updateFamilyMember(request);
      return Right(member.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, double>> removeFamilyMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  }) async {
    try {
      final returnedBalance = await remoteDataSource.removeFamilyMember(
        familyId: familyId,
        memberId: memberId,
        reason: reason,
        returnBalanceToPool: returnBalanceToPool,
      );
      return Right(returnedBalance);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyAccount>> acceptFamilyInvitation({
    required String invitationToken,
  }) async {
    try {
      final account = await remoteDataSource.acceptFamilyInvitation(invitationToken);
      return Right(account.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> declineFamilyInvitation({
    required String invitationToken,
    String? reason,
  }) async {
    try {
      final success = await remoteDataSource.declineFamilyInvitation(invitationToken);
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<PendingInvitation>>> getPendingInvitations() async {
    try {
      final invitations = await remoteDataSource.getPendingInvitations();
      return Right(invitations.map((proto) => proto.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, List<FamilyTransaction>>> getFamilyTransactions({
    required String familyId,
    String? memberId,
    FamilyTransactionType? type,
    int page = 1,
    int pageSize = 20,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final transactions = await remoteDataSource.getFamilyTransactions(
        familyId: familyId,
        memberId: memberId,
        type: type?.name,
        page: page,
        pageSize: pageSize,
      );
      return Right(transactions.map((proto) => proto.toDomain()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyMember>> allocateFunds({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    try {
      final member = await remoteDataSource.allocateFunds(
        familyId: familyId,
        memberId: memberId,
        amount: amount,
        description: description,
      );
      return Right(member.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyMember>> generateMemberCard({
    required String familyId,
    required String memberId,
    String? cardName,
  }) async {
    try {
      final member = await remoteDataSource.generateMemberCard(
        familyId: familyId,
        memberId: memberId,
        cardName: cardName,
      );
      return Right(member.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyAccount>> freezeFamilyAccount({
    required String familyId,
    String? reason,
  }) async {
    try {
      final account = await remoteDataSource.freezeFamilyAccount(
        familyId: familyId,
        reason: reason,
      );
      return Right(account.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyAccount>> unfreezeFamilyAccount({
    required String familyId,
  }) async {
    try {
      final account = await remoteDataSource.unfreezeFamilyAccount(familyId);
      return Right(account.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, double>> deleteFamilyAccount({
    required String familyId,
    required String confirmationCode,
  }) async {
    try {
      final returnedBalance = await remoteDataSource.deleteFamilyAccount(
        familyId: familyId,
        confirmationCode: confirmationCode,
      );
      return Right(returnedBalance);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, FamilyAccount>> processMemberContribution({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    try {
      final account = await remoteDataSource.processMemberContribution(
        familyId: familyId,
        memberId: memberId,
        amount: amount,
        description: description,
      );
      return Right(account.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.code ?? 500));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
