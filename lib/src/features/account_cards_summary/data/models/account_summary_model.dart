import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as pb; // Use accounts.proto from backend

class AccountSummaryModel extends AccountSummaryEntity {
  const AccountSummaryModel({
    required super.id,
    required super.accountType,
    required super.currency,
    required super.balance,
    required super.accountNumberLast4, // Keep entity field name
    super.accountNumber, // Full account number for deposits
    super.bankName, // Bank name for deposits
    super.accountName, // Account holder name for deposits
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

    // Use UUID for cross-service communication (banking-service expects UUID)
    // Fall back to numeric ID if UUID is not available (backward compatibility)
    final accountId = proto.uuid.isNotEmpty ? proto.uuid : proto.id.toString();

    return AccountSummaryModel(
      id: accountId,
      accountType: proto.accountType,
      currency: proto.currency,
      // Convert Int64 balance (assuming minor units) to double (major units)
      // Adjust the division factor (e.g., 100) based on your currency setup
      balance: proto.balance.toDouble() / 100.0,
      accountNumberLast4: extractLast4(proto.maskedAccountNumber), // Use maskedAccountNumber
      // Full virtual account details for deposits (Pay by Transfer)
      // Note: bankName and accountName not in AccountSummary proto - will use defaults
      accountNumber: proto.accountNumber.isNotEmpty ? proto.accountNumber : null,
      // trendPercentage: proto.trendPercentage, // Field missing in proto
    );
  }
} 