import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/utils/crowdfund_withdrawal_receipt.dart';

/// A campaign withdrawal used to end at a SnackBar and nothing else — no
/// record of what was taken, what the platform charged, what actually landed,
/// or where. These are the figures the new receipt states, and getting the
/// gross/net distinction wrong would tell a creator they received money the
/// platform kept.

Crowdfund campaign({String currency = 'NGN', String title = 'Building'}) =>
    Crowdfund(
      id: 'cf-1',
      creatorUserId: 1,
      creator: const CrowdfundCreator(
        userId: 1,
        username: 'onahpraiz',
        firstName: 'Praiz',
        lastName: 'Onah',
        verified: false,
        facialRecognitionEnabled: false,
      ),
      title: title,
      description: '',
      story: '',
      crowdfundCode: 'CF1',
      targetAmount: 1000,
      currentAmount: 500,
      currency: currency,
      category: 'community',
      status: CrowdfundStatus.active,
      donorCount: 1,
      progressPercentage: 50,
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 1),
    );

CrowdfundWithdrawalResult result({
  double gross = 500,
  double fee = 0,
  double net = 0,
  double remaining = 0,
}) =>
    CrowdfundWithdrawalResult(
      crowdfundId: 'cf-1',
      amountWithdrawn: gross,
      remainingBalance: remaining,
      destinationAccountId: 'acct-1',
      destinationNewBalance: 1000,
      message: 'ok',
      feeAmount: fee,
      netAmount: net,
      feeType: fee > 0 ? 'percentage' : '',
    );

void main() {
  test('with a fee, the headline is what the creator RECEIVED', () {
    final r = CrowdfundWithdrawalReceipt.from(
      crowdfund: campaign(),
      result: result(gross: 500, fee: 25, net: 475, remaining: 0),
    );
    expect(r.netAmount, 'NGN 475.00',
        reason: 'leading with the gross 500 claims they got money the '
            'platform kept');
    final labels = r.lines.map((l) => l.label).toList();
    expect(labels, containsAll(<String>['Platform fee', 'You received']));
    expect(
      r.lines.firstWhere((l) => l.label == 'Platform fee').value,
      '- NGN 25.00',
      reason: 'a deduction must read as one',
    );
    expect(r.lines.firstWhere((l) => l.emphasise).label, 'You received');
  });

  test('with no fee, net falls back to gross instead of showing zero', () {
    // The server only fills netAmount when it books a fee. Trusting it blindly
    // prints a receipt saying nothing arrived.
    final r = CrowdfundWithdrawalReceipt.from(
      crowdfund: campaign(),
      result: result(gross: 500, fee: 0, net: 0, remaining: 0),
    );
    expect(r.netAmount, 'NGN 500.00');
    expect(r.lines.any((l) => l.label == 'Platform fee'), isFalse,
        reason: 'a zero fee line is noise on a receipt');
  });

  test('a partial withdrawal reports what is left in the campaign', () {
    final r = CrowdfundWithdrawalReceipt.from(
      crowdfund: campaign(),
      result: result(gross: 200, remaining: 300),
    );
    expect(r.lines.firstWhere((l) => l.label == 'Left in campaign').value,
        'NGN 300.00');
  });

  test('it says where the money went, in the campaign currency', () {
    final r = CrowdfundWithdrawalReceipt.from(
      crowdfund: campaign(currency: 'ghs'),
      result: result(),
    );
    expect(r.destinationNote, 'Paid into your personal GHS account',
        reason: 'the creator asked to be told it lands in their personal '
            'account; currency is normalised so "ghs" never reaches the page');
    expect(r.netAmount, startsWith('GHS'));
  });

  test('a blank currency does not print an empty symbol', () {
    final r = CrowdfundWithdrawalReceipt.from(
      crowdfund: campaign(currency: '   '),
      result: result(),
    );
    expect(r.netAmount, startsWith('NGN'));
  });
}
