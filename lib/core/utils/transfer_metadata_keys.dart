import 'package:lazervault/core/utilities/banks_data.dart';

/// The keys a transfer's metadata actually uses for its destination, in one
/// place.
///
/// WHY THIS EXISTS. Two features read the destination bank out of a transfer
/// row — the history receipt's institution line and "Redo" — and each had its
/// own hand-written key list. Both lists were wrong in the same way: they
/// looked for `destination_bank_code`, which core-payments does not write.
/// Measured against production (`payments.payments`, transfers only):
///
///   destination_bank   69 rows   ← the bank CODE, despite the name
///   beneficiary_name   69
///   bank_name          41
///   rail_bank_code      5
///   destination_bank_code  0     ← what both lists looked for
///
/// So the history receipt showed no institution at all, and Redo rebuilt every
/// external payee with an EMPTY bank code — a transfer that cannot be sent. A
/// third copy of the list would have been wrong a third time; there is now one.
///
/// Both spellings of every key are kept: the snake_case ones are what the
/// service writes today, the camelCase ones what a JSON-mapped gateway payload
/// can produce, and the `*_code`/`*_name` variants are what a future writer
/// would reasonably choose. Reading a key that never appears is free; missing
/// one costs a broken feature.
class TransferMetadataKeys {
  const TransferMetadataKeys._();

  /// Display name of the destination institution ("Zenith Bank").
  static const bankName = <String>[
    'bank_name',
    'destination_bank_name',
    'recipient_bank_name',
    'bankName',
    'destinationBankName',
    'recipientBank',
  ];

  /// The destination bank CODE ("057").
  ///
  /// `destination_bank` holds a CODE, not a name — that is what core-payments
  /// stamps, and reading it as a name would put "057" on the receipt.
  static const bankCode = <String>[
    'destination_bank_code',
    'destination_bank',
    'rail_bank_code',
    'bank_code',
    'recipient_bank_code',
    'bankCode',
    'destinationBankCode',
  ];

  /// The payee's LazerVault user id, when the transfer stayed on-platform.
  static const internalUserId = <String>[
    'counterparty_user_id',
    'recipient_user_id',
    'internal_user_id',
    'internalUserId',
  ];

  /// First non-empty value among [keys].
  static String? pick(Map<String, dynamic>? metadata, List<String> keys) {
    final md = metadata ?? const <String, dynamic>{};
    for (final k in keys) {
      final v = md[k];
      if (v == null) continue;
      final s = v.toString().trim();
      if (s.isNotEmpty) return s;
    }
    return null;
  }

  /// Same as [pick] but never null — '' when nothing matched.
  static String pickOrEmpty(Map<String, dynamic>? metadata, List<String> keys) =>
      pick(metadata, keys) ?? '';

  /// A bank's display name from its code, for rows that carry the code alone —
  /// the majority: 28 of the 69 production transfers with a destination have a
  /// code and no name. Without this the receipt shows a bare "057".
  ///
  /// Returns null for an unknown code rather than echoing the digits: a code
  /// we cannot name is better shown as nothing than as a number the user has
  /// no way to read.
  static String? bankNameForCode(String? code) {
    final c = code?.trim() ?? '';
    if (c.isEmpty) return null;
    for (final country in const ['NG', 'GH', 'KE', 'ZA', 'GB', 'US']) {
      for (final bank in BanksData.getBanksForCountry(country)) {
        if (bank['code'] == c) return bank['name'];
      }
    }
    return null;
  }
}
