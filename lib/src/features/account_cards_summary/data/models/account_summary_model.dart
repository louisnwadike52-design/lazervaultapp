import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/generated/account.pb.dart' as pb; // Use the correct proto file

class AccountSummaryModel extends AccountSummaryEntity {
  const AccountSummaryModel({
    required super.id,
    required super.accountType,
    required super.currency,
    required super.balance,
    required super.accountNumberLast4, // Keep entity field name
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

    return AccountSummaryModel(
      id: proto.id.toString(), 
      accountType: proto.accountType,
      currency: proto.currency,
      // Convert Int64 balance (assuming minor units) to double (major units)
      // Adjust the division factor (e.g., 100) based on your currency setup
      balance: proto.balance.toDouble() / 100.0, 
      accountNumberLast4: extractLast4(proto.maskedAccountNumber), // Use maskedAccountNumber
      // trendPercentage: proto.trendPercentage, // Field missing in proto
    );
  }
} 