import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/vendor_campaigns/domain/vendor_entities.dart';

/// THE VENDOR MUST BE ABLE TO ASK FOR MONEY THE SERVER WOULD PAY.
///
/// `WithdrawCampaignEarnings` accepts a campaign whose WINDOW HAS ENDED even
/// when the stored status still reads `active` — it relabels it on the spot
/// rather than making the vendor wait on a tick. And nothing else closes an
/// expired campaign: there is no vendor closing worker (ticketing has one;
/// this does not).
///
/// So when this checked the status alone, a session that ran out at 11pm
/// stayed `active`, the Withdraw control stayed hidden, and the vendor had no
/// way to start a payout the server would have accepted. The one screen that
/// could ask was the one deciding it was not allowed.
void main() {
  VendorCampaign campaign({
    required String status,
    required DateTime endsAt,
    int outstanding = 5000000,
  }) =>
      VendorCampaign(
        id: 'c1',
        name: 'Launch night',
        currency: 'NGN',
        unitAmountKobo: 500000,
        maxRedemptions: 200,
        redeemedCount: 10,
        remainingRedemptions: 190,
        accruedAmountKobo: 5000000,
        paidOutKobo: 0,
        outstandingKobo: outstanding,
        status: status,
        startsAt: DateTime.now().subtract(const Duration(hours: 5)),
        endsAt: endsAt,
        closeReason: '',
        uniquenessScope: 'campaign',
      );

  final past = DateTime.now().subtract(const Duration(minutes: 1));
  final future = DateTime.now().add(const Duration(hours: 2));

  test('an ENDED window is payable even while the status says active', () {
    expect(
      campaign(status: 'active', endsAt: past).isPayable,
      isTrue,
      reason: 'no worker closes an expired campaign, and the server accepts '
          'this — hiding Withdraw strands the vendor’s earnings',
    );
  });

  test('a RUNNING campaign is not payable', () {
    // The accrued total is not final while another customer can still be
    // scanned; paying now would underpay or force a second partial payout.
    expect(campaign(status: 'active', endsAt: future).isPayable, isFalse);
    expect(campaign(status: 'scheduled', endsAt: future).isPayable, isFalse);
  });

  test('the three terminal statuses stay payable regardless of the clock', () {
    for (final s in ['closed', 'exhausted', 'cancelled']) {
      expect(campaign(status: s, endsAt: future).isPayable, isTrue,
          reason: '$s is payable even before its window would have ended — a '
              'campaign exhausted at 9pm must not wait until 11pm');
    }
  });

  test('a campaign still inside its window cannot be withdrawn early', () {
    // Guards the inverse mistake: making everything payable would let a
    // vendor bank a partial total mid-session.
    final c = campaign(status: 'active', endsAt: future);
    expect(c.isPayable, isFalse);
    expect(c.looksScannable, isTrue);
  });
}
