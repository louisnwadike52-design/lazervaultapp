import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/family_account_entities.dart';

abstract class FamilyAccountRepository {
  // Get all family accounts for the authenticated user
  Future<Either<Failure, List<FamilyAccount>>> getFamilyAccounts({
    String? statusFilter,
  });

  // Get a specific family account by ID
  Future<Either<Failure, FamilyAccount>> getFamilyAccount(String familyId);

  // Create a new family account
  Future<Either<Failure, FamilyAccount>> createFamilyAccount({
    required String name,
    String? description,
    required String initialCurrency,
    required double initialFunding,
    required bool allowMemberContributions,
  });

  // Add a member to a family account
  Future<Either<Failure, FamilyMember>> addFamilyMember({
    required String familyId,
    required String invitationMethod, // email, phone, username
    required String invitationDestination,
    required double initialAllocation,
    required double dailyLimit,
    required double monthlyLimit,
    required double perTransactionLimit,
    required double allocationPercentageCap,
    required String role, // admin, member
    String? personalMessage,
  });

  // Update a family member's settings
  Future<Either<Failure, FamilyMember>> updateFamilyMember({
    required String familyId,
    required String memberId,
    double? allocatedBalance,
    double? dailySpendingLimit,
    double? monthlySpendingLimit,
    double? perTransactionLimit,
    double? allocationPercentageCap,
    String? role,
  });

  // Remove a member from the family account
  Future<Either<Failure, double>> removeFamilyMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  });

  // Accept a family invitation
  Future<Either<Failure, FamilyAccount>> acceptFamilyInvitation({
    required String invitationToken,
  });

  // Decline a family invitation
  Future<Either<Failure, bool>> declineFamilyInvitation({
    required String invitationToken,
    String? reason,
  });

  // Get pending invitations for the authenticated user
  Future<Either<Failure, List<PendingInvitation>>> getPendingInvitations();

  // Get transaction history for a family account
  Future<Either<Failure, List<FamilyTransaction>>> getFamilyTransactions({
    required String familyId,
    String? memberId,
    FamilyTransactionType? type,
    int page = 1,
    int pageSize = 20,
    DateTime? startDate,
    DateTime? endDate,
  });

  // Allocate funds to a specific member
  Future<Either<Failure, FamilyMember>> allocateFunds({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  });

  // Generate a virtual card for a family member
  Future<Either<Failure, FamilyMember>> generateMemberCard({
    required String familyId,
    required String memberId,
    String? cardName,
  });

  // Freeze a family account
  Future<Either<Failure, FamilyAccount>> freezeFamilyAccount({
    required String familyId,
    String? reason,
  });

  // Unfreeze a family account
  Future<Either<Failure, FamilyAccount>> unfreezeFamilyAccount({
    required String familyId,
  });

  // Delete a family account
  Future<Either<Failure, double>> deleteFamilyAccount({
    required String familyId,
    required String confirmationCode,
  });

  // Member contribution to family pool (hybrid funding)
  Future<Either<Failure, FamilyAccount>> processMemberContribution({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  });
}
