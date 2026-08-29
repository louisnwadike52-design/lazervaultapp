/// Resolves which institution a transfer went to, for display.
///
/// Every transfer has a destination institution — an external bank, or
/// LazerVault itself. The receipt used to render a "Bank" row only when
/// metadata happened to carry a bank name, so internal LazerVault-to-LazerVault
/// transfers showed no institution at all: the one field that tells a user
/// where their money actually went was simply missing.
///
/// This is the single source of truth for that decision so the receipt, the
/// dashboard history, the recipient history and the select-recipients sheet
/// cannot disagree about the same transaction.
class TransferBankDisplay {
  /// Display name of the destination institution ("Access Bank", "LazerVault").
  final String name;

  /// Bank code when known — [BankLogo] prefers it over the name for asset
  /// resolution. Null for LazerVault, which the widget matches by name.
  final String? code;

  /// True when the money stayed on LazerVault.
  final bool isLazerVault;

  const TransferBankDisplay({
    required this.name,
    required this.code,
    required this.isLazerVault,
  });

  static const String lazerVaultName = 'LazerVault';

  /// Short badge label. "LV" is the compact mark used where a full name will
  /// not fit (history rows, list tiles).
  String get shortLabel => isLazerVault ? 'LV' : name;

  /// Resolve from a transaction's metadata map.
  ///
  /// Returns null only when the transaction is not a transfer at all (a bill
  /// payment, an airtime top-up), where an institution row would be wrong
  /// rather than merely missing.
  ///
  /// [isTransfer] should be true for transfer-like categories. When a bank name
  /// is present it always wins — that is positive evidence of an external
  /// destination regardless of any type flag.
  static TransferBankDisplay? resolve(
    Map<String, dynamic>? metadata, {
    required bool isTransfer,
  }) {
    final md = metadata ?? const <String, dynamic>{};

    String? pick(List<String> keys) {
      for (final k in keys) {
        final v = md[k];
        if (v != null && v.toString().trim().isNotEmpty) {
          return v.toString().trim();
        }
      }
      return null;
    }

    final bankName = pick(const [
      'bank_name',
      'destination_bank_name',
      'recipient_bank_name',
      'bankName',
      'destinationBankName',
      'recipientBank',
    ]);
    final bankCode = pick(const [
      'bank_code',
      'destination_bank_code',
      'recipient_bank_code',
      'bankCode',
      'destinationBankCode',
    ]);

    // An explicitly LazerVault "bank" is an internal transfer wearing a bank
    // field — normalise it rather than rendering it as an external institution.
    if (bankName != null && bankName.toLowerCase().contains('lazervault')) {
      return const TransferBankDisplay(
        name: lazerVaultName,
        code: null,
        isLazerVault: true,
      );
    }
    if (bankName != null) {
      return TransferBankDisplay(
        name: bankName,
        code: bankCode,
        isLazerVault: false,
      );
    }

    if (!isTransfer) return null;

    // No bank on a transfer. Only call it internal on POSITIVE evidence — a
    // declared internal type, or a resolved LazerVault counterparty. Guessing
    // from the absence of a bank is the same mistake that mis-routed live
    // transfers, and here it would state a destination we cannot support.
    final type = pick(const [
      'transfer_type',
      'transferType',
      'Transfer Type',
    ])?.toLowerCase();
    final hasInternalUser = pick(const [
      'recipient_user_id',
      'internal_user_id',
      'internalUserId',
    ]) != null;

    if ((type != null && type.contains('internal')) || hasInternalUser) {
      return const TransferBankDisplay(
        name: lazerVaultName,
        code: null,
        isLazerVault: true,
      );
    }
    return null;
  }
}
