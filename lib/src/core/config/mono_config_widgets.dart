part of 'mono_config.dart';

/// Mono Institution details
class MonoInstitution {
  final String id;
  final String name;
  final String bankCode;
  final String type;

  const MonoInstitution({
    required this.id,
    required this.name,
    required this.bankCode,
    required this.type,
  });

  @override
  String toString() => 'MonoInstitution(id: $id, name: $name, bankCode: $bankCode)';
}

/// Result from Mono Connect flow
class MonoConnectResult {
  /// The authorization code to exchange for account access
  final String code;

  /// The institution (bank) that was connected
  final MonoInstitution? institution;

  /// The institution ID from Mono
  final String? institutionId;

  /// The institution name as displayed by Mono
  final String? institutionName;

  /// Account ID if available
  final String? accountId;

  const MonoConnectResult({
    required this.code,
    this.institution,
    this.institutionId,
    this.institutionName,
    this.accountId,
  });

  /// Get the display name for the connected bank
  String get bankDisplayName {
    if (institution != null) return institution!.name;
    if (institutionName != null) return institutionName!;
    if (institutionId != null) {
      final inst = MonoConfig.getInstitutionById(institutionId!);
      if (inst != null) return inst.name;
    }
    return 'Unknown Bank';
  }

  @override
  String toString() => 'MonoConnectResult(code: ${code.substring(0, code.length > 10 ? 10 : code.length)}..., bank: $bankDisplayName)';
}

/// Mono operation types for determining the correct scope
enum MonoOperation {
  /// Account linking - read-only access to account data
  accountLinking,

  /// DirectPay - one-time payment authorization
  directPay,

  /// Direct Debit - pull funds from linked account
  directDebit,

  /// Mandate - recurring access for future debits
  mandate,
}
