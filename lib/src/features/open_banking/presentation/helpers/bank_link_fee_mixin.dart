import 'package:flutter/widgets.dart';
import '../../cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';

/// Cost-confirmed bank-linking gate, shared by EVERY link entry point (the
/// dedicated Link Bank screen plus the inline deposit/move/withdraw/direct-debit
/// sheets) so none of them re-implements the fee UX.
///
/// Mono Connect linking is a billed provider action, so linking MAY carry a fee
/// (Mono cost + LazerVault margin, admin-tunable, default 0). When a fee applies
/// this quotes it, shows the cost + takes a txPIN, then runs [doLink] with the
/// verification token; when it's free it runs [doLink] with nulls. The backend
/// charges only a genuinely new link and unlinks on a failed charge, so re-links
/// and wrong-PIN attempts never cost anything.
mixin BankLinkFeeMixin<T extends StatefulWidget>
    on State<T>, TransactionPinMixin<T> {
  /// Gate a link behind the (optional) cost + txPIN. [doLink] receives the
  /// verification token + transaction id (both null when the link is free) and
  /// should perform the actual `cubit.linkAccount(...)` — this keeps each entry
  /// point's own params (auto-mandate info, set-as-default) intact.
  Future<void> linkBankWithFee({
    required BuildContext context,
    required OpenBankingCubit cubit,
    required Future<void> Function(String? verificationToken, String? transactionId) doLink,
  }) async {
    final feeMinor = await cubit.quoteLinkFeeMinor();
    if (!mounted) return;
    if (feeMinor <= 0) {
      await doLink(null, null);
      return;
    }
    final feeNaira = feeMinor / 100.0;
    final txnId = 'link-${DateTime.now().millisecondsSinceEpoch}';
    await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'bank_link',
      amount: feeNaira,
      fee: feeNaira,
      totalAmount: feeNaira,
      currency: 'NGN',
      title: 'Link this bank',
      message:
          'Linking a bank costs ₦${feeNaira.toStringAsFixed(2)}, charged to your wallet.',
      successMessage: 'Bank linked',
      onPinValidated: (token) async => doLink(token, txnId),
    );
  }
}
