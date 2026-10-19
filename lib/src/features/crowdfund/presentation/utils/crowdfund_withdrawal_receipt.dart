library;

import 'package:intl/intl.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';

/// The lines of a campaign-withdrawal receipt, built once and rendered twice.
///
/// The withdrawal used to end at a SnackBar — "Withdrew ₦X successfully" — and
/// nothing else. That is the one moment a creator takes real money out of a
/// campaign, and it left them no record of what was taken, what the platform
/// charged, what actually landed, or where it landed.
///
/// The screen and the shareable PDF read from this same list so they cannot
/// drift. It is a plain function over the withdrawal result precisely because
/// the arithmetic — gross vs fee vs net — is the part that would quietly tell
/// someone the wrong figure about their own money.
class CrowdfundWithdrawalReceiptLine {
  const CrowdfundWithdrawalReceiptLine(this.label, this.value,
      {this.emphasise = false});

  final String label;
  final String value;

  /// Rendered heavier: the figure that actually reached the creator.
  final bool emphasise;
}

class CrowdfundWithdrawalReceipt {
  const CrowdfundWithdrawalReceipt({
    required this.title,
    required this.netAmount,
    required this.lines,
    required this.destinationNote,
    required this.reference,
    required this.createdAt,
  });

  /// Campaign the money came out of.
  final String title;

  /// Headline figure: what the creator actually received.
  final String netAmount;

  final List<CrowdfundWithdrawalReceiptLine> lines;

  /// Where the money went, in words.
  final String destinationNote;

  final String reference;
  final DateTime createdAt;

  static String _money(double v, String currency) =>
      '$currency ${NumberFormat('#,##0.00').format(v)}';

  static CrowdfundWithdrawalReceipt from({
    required Crowdfund crowdfund,
    required CrowdfundWithdrawalResult result,
    DateTime? now,
  }) {
    final c = crowdfund.currency.trim().isEmpty
        ? 'NGN'
        : crowdfund.currency.trim().toUpperCase();

    // NET, NOT GROSS, IS THE HEADLINE.
    //
    // amountWithdrawn is what was taken OUT of the campaign; netAmount is what
    // reached the creator. When a platform fee applies those differ, and
    // leading with the gross figure tells someone they received money the
    // platform kept. netAmount is 0 on a no-fee withdrawal (the server only
    // fills it when it books a fee), so fall back to gross rather than
    // printing a receipt that says nothing arrived.
    final hasFee = result.feeAmount > 0;
    final net = hasFee && result.netAmount > 0
        ? result.netAmount
        : result.amountWithdrawn;

    final lines = <CrowdfundWithdrawalReceiptLine>[
      CrowdfundWithdrawalReceiptLine(
          'Withdrawn from campaign', _money(result.amountWithdrawn, c)),
      if (hasFee)
        CrowdfundWithdrawalReceiptLine(
            'Platform fee', '- ${_money(result.feeAmount, c)}'),
      CrowdfundWithdrawalReceiptLine('You received', _money(net, c),
          emphasise: true),
      CrowdfundWithdrawalReceiptLine(
          'Left in campaign', _money(result.remainingBalance, c)),
    ];

    return CrowdfundWithdrawalReceipt(
      title: crowdfund.title,
      netAmount: _money(net, c),
      lines: lines,
      // The destination is resolved server-side to the creator's own primary
      // account; the sheet says so before the PIN and the receipt repeats it
      // afterwards, so "where did it go?" is never a question.
      destinationNote: 'Paid into your personal $c account',
      reference: result.crowdfundId,
      createdAt: now ?? DateTime.now(),
    );
  }
}
