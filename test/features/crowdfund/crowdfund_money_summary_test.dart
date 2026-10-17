import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_money_summary.dart';

/// Crowdfund had no statistics page: "My Activity" opened a LIST of campaigns
/// and a LIST of donations, so "how much have I raised, how much can I still
/// take out, how much have I given away" had to be answered by adding rows up
/// by hand.
///
/// This is the arithmetic behind the new page. It is a plain function over
/// two lists precisely so the part that could quietly tell someone the wrong
/// figure about their own money is testable without a widget or a cubit.

Crowdfund campaign({
  required String id,
  required double current,
  double refunded = 0,
  CrowdfundStatus status = CrowdfundStatus.active,
  String currency = 'NGN',
}) =>
    Crowdfund(
      id: id,
      creatorUserId: 1,
      creator: const CrowdfundCreator(
        userId: 1,
        username: 'onahpraiz',
        firstName: 'Praiz',
        lastName: 'Onah',
        verified: false,
        facialRecognitionEnabled: false,
      ),
      title: 'Campaign $id',
      description: '',
      story: '',
      crowdfundCode: 'CF$id',
      targetAmount: 1000,
      currentAmount: current,
      currency: currency,
      category: 'community',
      status: status,
      donorCount: 1,
      progressPercentage: 0,
      createdAt: DateTime(2026, 10, 1),
      updatedAt: DateTime(2026, 10, 1),
      totalRefunded: refunded,
    );

CrowdfundDonation donation({
  required String id,
  required String campaignId,
  required double amount,
  DonationStatus status = DonationStatus.completed,
  String currency = 'NGN',
}) =>
    CrowdfundDonation(
      id: id,
      crowdfundId: campaignId,
      donorUserId: 2,
      donor: const CrowdfundDonor(
        userId: 2,
        displayName: 'Chris E',
        isAnonymous: false,
        isCreator: false,
      ),
      amount: amount,
      currency: currency,
      donationDate: DateTime(2026, 10, 2),
      status: status,
      isAnonymous: false,
      paymentMethod: 'wallet',
    );

void main() {
  group('money you raised', () {
    test('available to withdraw is the live pot, not everything raised', () {
      // THE FIGURE PEOPLE ACT ON. currentAmount is what is left after
      // withdrawals and refunds; presenting raised-to-date as withdrawable
      // invites a withdrawal of money that has already left.
      final s = CrowdfundMoneySummary.from(
        created: [campaign(id: 'a', current: 500, refunded: 150)],
        donations: const [],
      );
      expect(s.availableToWithdraw, 500);
      expect(s.totalRaised, 650, reason: 'the pot plus what has left it');
      expect(s.totalRefundedToDonors, 150);
    });

    test('adds up across campaigns and counts the open ones', () {
      final s = CrowdfundMoneySummary.from(
        created: [
          campaign(id: 'a', current: 500),
          campaign(id: 'b', current: 0, status: CrowdfundStatus.expired),
          campaign(id: 'c', current: 250, status: CrowdfundStatus.active),
        ],
        donations: const [],
      );
      expect(s.campaignCount, 3);
      expect(s.activeCampaigns, 2);
      expect(s.availableToWithdraw, 750);
    });

    test('a cancelled campaign that refunded everything shows nothing left',
        () {
      final s = CrowdfundMoneySummary.from(
        created: [
          campaign(
              id: 'a',
              current: 0,
              refunded: 150,
              status: CrowdfundStatus.cancelled)
        ],
        donations: const [],
      );
      expect(s.availableToWithdraw, 0);
      expect(s.totalRaised, 150);
      expect(s.totalRefundedToDonors, 150);
      expect(s.activeCampaigns, 0);
    });
  });

  group('money you gave', () {
    test('only settled donations count', () {
      // A pending or failed donation has not left the donor's wallet.
      final s = CrowdfundMoneySummary.from(
        created: const [],
        donations: [
          donation(id: '1', campaignId: 'x', amount: 500),
          donation(
              id: '2',
              campaignId: 'y',
              amount: 900,
              status: DonationStatus.pending),
          donation(
              id: '3',
              campaignId: 'z',
              amount: 700,
              status: DonationStatus.failed),
        ],
      );
      expect(s.totalDonated, 500);
      expect(s.donationCount, 1);
      expect(s.campaignsBacked, 1);
    });

    test('a refunded donation is shown on BOTH sides, never netted away', () {
      // "You gave X, Y came back" is the honest statement. Silently netting
      // them hides a cancellation the donor should know about.
      final s = CrowdfundMoneySummary.from(
        created: const [],
        donations: [
          donation(id: '1', campaignId: 'x', amount: 500),
          donation(
              id: '2',
              campaignId: 'y',
              amount: 150,
              status: DonationStatus.refunded),
        ],
      );
      expect(s.totalDonated, 650);
      expect(s.donationsRefunded, 150);
      expect(s.netGiven, 500);
      expect(s.donationCount, 2);
    });

    test('backing one campaign twice is one campaign', () {
      final s = CrowdfundMoneySummary.from(
        created: const [],
        donations: [
          donation(id: '1', campaignId: 'x', amount: 100),
          donation(id: '2', campaignId: 'x', amount: 200),
        ],
      );
      expect(s.donationCount, 2);
      expect(s.campaignsBacked, 1);
      expect(s.totalDonated, 300);
    });
  });

  group('empty and currency', () {
    test('nothing at all reads as empty, with no currency invented', () {
      final s = CrowdfundMoneySummary.from(created: const [], donations: const []);
      expect(s.isEmpty, isTrue);
      expect(s.currency, '');
    });

    test('the currency comes from the data, not from a default', () {
      final s = CrowdfundMoneySummary.from(
        created: [campaign(id: 'a', current: 10, currency: 'GHS')],
        donations: const [],
      );
      expect(s.currency, 'GHS');
    });

    test('a donor with no campaigns is not empty', () {
      final s = CrowdfundMoneySummary.from(
        created: const [],
        donations: [donation(id: '1', campaignId: 'x', amount: 500)],
      );
      expect(s.isEmpty, isFalse);
      expect(s.hasCreated, isFalse);
      expect(s.hasBacked, isTrue);
    });
  });

  test('the real production account: NGN500 raised, NGN500 donated', () {
    // Measured 2026-10-17: Praiz created "Building" (NGN500/NGN500, pot
    // NGN500 unwithdrawn) and "Community building" (NGN0), and donated
    // NGN500 to "Building".
    final s = CrowdfundMoneySummary.from(
      created: [
        campaign(id: 'building', current: 500, status: CrowdfundStatus.completed),
        campaign(
            id: 'community', current: 0, status: CrowdfundStatus.expired),
      ],
      donations: [donation(id: 'd1', campaignId: 'building', amount: 500)],
    );
    expect(s.campaignCount, 2);
    expect(s.availableToWithdraw, 500);
    expect(s.totalDonated, 500);
    expect(s.campaignsBacked, 1);
    expect(s.currency, 'NGN');
  });
}
