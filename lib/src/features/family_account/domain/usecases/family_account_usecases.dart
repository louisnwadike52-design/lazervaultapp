import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/family_account_entities.dart';
import '../repositories/family_account_repository.dart' show FamilyAccountRepository, MemberAllocationEntry;
part 'family_account_usecases_widgets.dart';


class AddFamilyMemberParams {
  final String familyId;
  final String invitationMethod;
  final String invitationDestination;
  final double initialAllocation;
  final double dailyLimit;
  final double monthlyLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final String role;
  final String? personalMessage;
  final String? displayName;

  AddFamilyMemberParams({
    required this.familyId,
    required this.invitationMethod,
    required this.invitationDestination,
    required this.initialAllocation,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.role,
    this.personalMessage,
    this.displayName,
  });
}
