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

import 'package:lazervault/core/utils/brand_bank.dart';
import 'package:lazervault/core/utils/transfer_metadata_keys.dart';
import '../../funds/presentation/send_funds_launcher.dart';
import '../../recipients/data/models/recipient_model.dart';

class RepeatTransfer {
  const RepeatTransfer._();

  // The key lists live in TransferMetadataKeys, shared with the receipt's
  // institution line. They were duplicated here and BOTH copies looked for
  // `destination_bank_code`, which core-payments never writes — it writes
  // `destination_bank`, holding the code. Every external Redo was therefore
  // built with an empty bank code: a transfer that cannot be sent.
  static String _firstOf(Map<String, dynamic> md, List<String> keys) =>
      TransferMetadataKeys.pickOrEmpty(md, keys);

  /// Rebuild the payee from a past transfer's row.
  ///
  /// THE RULE IS "PICK THE READ THAT CAN STILL COMPLETE", and which read that
  /// is depends on what the row carries:
  ///
  ///   * A bank code or name  → EXTERNAL. Positive evidence of a bank, and an
  ///     internal transfer mis-read as external is merely slower and costs a
  ///     fee, which the confirmation screen shows before the user commits.
  ///   * A LazerVault user id, or a bank named LazerVault → INTERNAL.
  ///   * NOTHING AT ALL → internal. This is not a guess about the payee; it is
  ///     the only read with a route. In production every internal transfer
  ///     lands with `metadata = {}` — no bank, no type, no user id — and
  ///     reading those as external produced a payee with an empty bank code,
  ///     which the send-funds form refuses outright ("Bank details are
  ///     incomplete"). Nothing could ever be repeated. Read as internal, a
  ///     genuinely internal transfer repeats, and a genuinely external one
  ///     fails at the recipient lookup with a sentence that says what to do
  ///     ("That recipient isn't a LazerVault account. Send to their bank
  ///     instead"). Neither path moves money on a mistake.
  static RecipientModel recipientFrom({
    required String counterpartyName,
    required String counterpartyAccount,
    Map<String, dynamic>? metadata,
  }) {
    final md = metadata ?? const <String, dynamic>{};
    final uid = _firstOf(md, TransferMetadataKeys.internalUserId);
    final bankCode = _firstOf(md, TransferMetadataKeys.bankCode);
    // A row that carries only the code still names a bank we can send to.
    final bankName = _firstOf(md, TransferMetadataKeys.bankName).isNotEmpty
        ? _firstOf(md, TransferMetadataKeys.bankName)
        : (TransferMetadataKeys.bankNameForCode(bankCode) ?? '');

    final hasInternalUid = uid.isNotEmpty;
    final hasBankEvidence = bankCode.isNotEmpty || bankName.isNotEmpty;
    final isExternal =
        !hasInternalUid && hasBankEvidence && !BrandBank.isOurs(bankName);

    return RecipientModel(
      id: '',
      name: counterpartyName,
      accountNumber: counterpartyAccount,
      bankName: isExternal ? bankName : BrandBank.displayName,
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

  /// True when there is enough on the row to rebuild a payee the send-funds
  /// form will ACCEPT.
  ///
  /// Derived from [recipientFrom] rather than from its own rules, so the button
  /// appears exactly when the repeat can proceed. The two used to disagree:
  /// canRepeat asked only for a name plus an account number, while the long
  /// flow refuses an external payee that is missing either half of its bank
  /// details —
  ///
  ///   "Bank details are incomplete. Please verify the recipient's bank
  ///    information."
  ///
  /// — which is exactly what every Redo produced while the bank-code key was
  /// wrong. A button that always fails is worse than no button; a button that
  /// is present only when the flow will take the payee is the invariant.
  static bool canRepeat({
    String? counterpartyName,
    String? counterpartyAccount,
    Map<String, dynamic>? metadata,
  }) {
    final name = (counterpartyName ?? '').trim();
    if (name.isEmpty) return false;
    final payee = recipientFrom(
      counterpartyName: name,
      counterpartyAccount: (counterpartyAccount ?? '').trim(),
      metadata: metadata,
    );
    if (payee.type == 'internal') {
      // Resolves by user id, or by account number on our own rail.
      return (payee.internalUserId ?? '').isNotEmpty ||
          payee.accountNumber.isNotEmpty;
    }
    return payee.accountNumber.isNotEmpty &&
        payee.sortCode.trim().isNotEmpty &&
        payee.bankName.trim().isNotEmpty;
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
