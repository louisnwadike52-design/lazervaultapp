/// Re-open Send Funds pre-filled from a transfer the user already made.
///
/// "Repeat" and "Redo" were two different implementations of one idea, and only
/// one of them worked. The history sheet reconstructed the recipient properly;
/// the receipt screens threw the user back at "select account" with empty
/// fields, because they synthesised a result object carrying no account ids.
/// This is the single reconstruction both now use, so a fix to either lands in
/// both.
///
/// The hard part is not the amount — it is deciding which RAIL the repeat
/// belongs on. Getting that wrong does not show a wrong number; it routes a
/// bank account number into the LazerVault-user lookup and the transfer fails
/// outright. See [recipientFrom].
library;

import '../../funds/presentation/send_funds_launcher.dart';
import '../../recipients/data/models/recipient_model.dart';

class RepeatTransfer {
  const RepeatTransfer._();

  /// Metadata keys that can carry the payee's LazerVault user id, in the order
  /// they should be trusted.
  static const _uidKeys = ['counterparty_user_id', 'recipient_user_id'];
  static const _bankNameKeys = [
    'recipient_bank_name',
    'destination_bank_name',
    'bank_name',
  ];
  static const _bankCodeKeys = ['destination_bank_code', 'bank_code'];

  static String _firstOf(Map<String, dynamic> md, List<String> keys) {
    for (final k in keys) {
      final v = md[k]?.toString().trim() ?? '';
      if (v.isNotEmpty) return v;
    }
    return '';
  }

  /// Rebuild the payee from a past transfer's row.
  ///
  /// INTERNAL REQUIRES PROOF — either a resolved LazerVault user id, or a bank
  /// explicitly named LazerVault. Absent proof the repeat goes out as EXTERNAL,
  /// because that is the read that can still complete: an external transfer
  /// mis-read as internal sends a bank account number to the LazerVault-user
  /// lookup, which correctly 404s ("couldn't find that recipient"). An internal
  /// transfer mis-read as external is merely slower and costs a fee, and the
  /// confirmation screen shows the user both before they commit.
  static RecipientModel recipientFrom({
    required String counterpartyName,
    required String counterpartyAccount,
    Map<String, dynamic>? metadata,
  }) {
    final md = metadata ?? const <String, dynamic>{};
    final uid = _firstOf(md, _uidKeys);
    final bankName = _firstOf(md, _bankNameKeys);
    final bankCode = _firstOf(md, _bankCodeKeys);

    final hasInternalUid = uid.isNotEmpty;
    final isExternal =
        !hasInternalUid && !bankName.toLowerCase().contains('lazervault');

    return RecipientModel(
      id: '',
      name: counterpartyName,
      accountNumber: counterpartyAccount,
      bankName: isExternal ? bankName : 'LazerVault',
      isFavorite: false,
      sortCode: isExternal ? bankCode : '',
      type: isExternal ? 'external' : 'internal',
      internalUserId: hasInternalUid ? uid : null,
    );
  }

  /// The amount to pre-fill, in minor units — the PRINCIPAL, never
  /// principal + fee.
  ///
  /// A completed external transfer's history row is the CAPTURE ledger row,
  /// whose amount already includes the fee. Repeating that verbatim would
  /// quietly send more than the user sent last time, and then charge a fee on
  /// top of the inflated figure. Prefer the backend-stamped `principal_minor`;
  /// else subtract `total_fee_minor`; else use the amount as-is (internal and
  /// no-fee rows carry neither key).
  static int prefillAmountMinor({
    required double amount,
    Map<String, dynamic>? metadata,
  }) {
    final md = metadata ?? const <String, dynamic>{};
    final principal = int.tryParse('${md['principal_minor'] ?? ''}') ?? 0;
    if (principal > 0) return principal;

    final total = (amount * 100).round();
    final fee = int.tryParse('${md['total_fee_minor'] ?? ''}') ?? 0;
    // `fee < total` guards a mis-stamped row from yielding zero or a negative.
    return (fee > 0 && fee < total) ? total - fee : total;
  }

  /// True when there is enough on the row to rebuild a payee at all.
  ///
  /// Without this a "Repeat" button renders on rows it cannot act on — a dead
  /// control, which is worse than an absent one.
  static bool canRepeat({
    String? counterpartyName,
    String? counterpartyAccount,
    Map<String, dynamic>? metadata,
  }) {
    if ((counterpartyName ?? '').trim().isEmpty) return false;
    final hasAccount = (counterpartyAccount ?? '').trim().isNotEmpty;
    final hasUid = _firstOf(metadata ?? const {}, _uidKeys).isNotEmpty;
    // An internal payee resolves by user id, so it needs no account number.
    return hasAccount || hasUid;
  }

  /// Open Send Funds pre-filled, so only the transaction PIN remains.
  static void open({
    required String counterpartyName,
    required String counterpartyAccount,
    required double amount,
    Map<String, dynamic>? metadata,
    String? currency,
    String? description,
  }) {
    SendFundsLauncher.open(
      recipient: recipientFrom(
        counterpartyName: counterpartyName,
        counterpartyAccount: counterpartyAccount,
        metadata: metadata,
      ),
      autoContinue: true,
      prefillAmountMinor:
          prefillAmountMinor(amount: amount, metadata: metadata),
      prefillCurrency: currency,
      prefillDescription: description,
    );
  }
}
