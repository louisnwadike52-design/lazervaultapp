import 'dart:developer' as developer;
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as pb; // Use accounts.proto from backend

class AccountSummaryModel extends AccountSummaryEntity {
  const AccountSummaryModel({
    required super.id,
    required super.accountType,
    required super.currency,
    required super.balance,
    super.availableBalance = 0,
    super.reservedBalance = 0,
    required super.accountNumberLast4, // Keep entity field name
    super.accountNumber, // Full account number for deposits
    super.bankName, // Bank name for deposits
    super.accountName, // Account holder name for deposits
    super.accountLabel, // Custom display name (e.g., "Kids Allowance")
    // Trend percentage is missing in proto, set default or remove from entity
    super.trendPercentage = 0.0,
  });

  factory AccountSummaryModel.fromProto(pb.AccountSummary proto) {
    // Helper to extract last 4 digits if maskedAccountNumber is like '•••• 1234'
    String extractLast4(String masked) {
      if (masked.isNotEmpty && masked.length >= 4) {
        return masked.substring(masked.length - 4);
      } else if (masked.isNotEmpty) {
        return masked; // Return the whole string if less than 4 chars
      }
      return '????'; // Return placeholder if empty
    }

    // Debug logging to understand what backend is returning
    developer.log(
      'AccountSummary.fromProto: uuid="${proto.uuid}", id=${proto.id}, accountType="${proto.accountType}"',
      name: 'AccountSummary',
    );

    // Use UUID for cross-service communication (banking-service expects UUID)
    // Fall back to numeric ID if UUID is not available (backward compatibility)
    final accountId = proto.uuid.isNotEmpty ? proto.uuid : proto.id.toString();

    // Warn if we're using a potentially invalid ID
    if (accountId.isEmpty || accountId == '0') {
      developer.log(
        'WARNING: Account "${proto.accountType}" has invalid ID: "$accountId"',
        name: 'AccountSummary',
      );
    }

    var totalBalance = proto.balance.toDouble() / 100.0;
    if (totalBalance < 0) {
      developer.log(
        'WARNING: Account "${proto.accountType}" (id=$accountId) has negative balance: $totalBalance, clamping to 0',
        name: 'AccountSummary',
      );
      totalBalance = 0;
    }
    // available_balance defaults to 0 in proto; if 0 and balance > 0, use balance as available
    // (backward compat for accounts without clearing/holds)
    final availBal = proto.availableBalance.toDouble() / 100.0;
    final reservedBal = proto.reservedBalance.toDouble() / 100.0;
    final effectiveAvailable = (availBal == 0 && totalBalance > 0) ? totalBalance : availBal;

    return AccountSummaryModel(
      id: accountId,
      // Backend sends lowercase (e.g., "personal"), map to display name with capitalized initials
      accountType: VirtualAccountType.fromString(proto.accountType).displayName,
      currency: proto.currency,
      // Convert Int64 balance (assuming minor units) to double (major units)
      balance: totalBalance,
      availableBalance: effectiveAvailable,
      reservedBalance: reservedBal,
      accountNumberLast4: extractLast4(proto.maskedAccountNumber), // Use maskedAccountNumber
      // Full virtual account details for deposits (Pay by Transfer)
      accountNumber: proto.accountNumber.isNotEmpty ? proto.accountNumber : null,
      accountName: proto.accountName.isNotEmpty ? proto.accountName : null,
      accountLabel: proto.accountName.isNotEmpty ? proto.accountName : null,
      // trendPercentage: proto.trendPercentage, // Field missing in proto
      // clearingEstimate: null — will be populated when backend adds clearing time fields
    );
  }
} 