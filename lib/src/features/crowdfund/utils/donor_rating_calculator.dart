import 'dart:math';
import '../domain/entities/crowdfund_entities.dart';

/// Rating result for a crowdfund donor
class DonorRating {
  final double overallScore;
  final int starCount;
  final double generosityScore;
  final double repeatSupportScore;
  final double engagementScore;
  final double earlySupportScore;
  final String label;

  const DonorRating({
    required this.overallScore,
    required this.starCount,
    required this.generosityScore,
    required this.repeatSupportScore,
    required this.engagementScore,
    required this.earlySupportScore,
    required this.label,
  });

  static const DonorRating anonymous = DonorRating(
    overallScore: 1.0,
    starCount: 1,
    generosityScore: 0,
    repeatSupportScore: 0,
    engagementScore: 0,
    earlySupportScore: 0,
    label: 'Anonymous',
  );

  static const DonorRating newDonor = DonorRating(
    overallScore: 1.0,
    starCount: 1,
    generosityScore: 0,
    repeatSupportScore: 0,
    engagementScore: 0,
    earlySupportScore: 0,
    label: 'New',
  );
}

/// Calculates AI-powered star ratings for crowdfund donors.
///
/// Four factors weighted to produce a 1-5 star score:
/// - Generosity (40%): Donor's total donated vs average donation
/// - Repeat Support (25%): Number of donations from this donor vs most active donor
/// - Engagement (20%): Left a message (50%) + not anonymous (50%)
/// - Early Support (15%): How early in campaign lifecycle they first donated
class DonorRatingCalculator {
  static DonorRating calculateRating(
    CrowdfundDonation donation,
    List<CrowdfundDonation> allDonations,
    Crowdfund crowdfund,
  ) {
    // Edge case: anonymous donation
    if (donation.isAnonymous) {
      return DonorRating.anonymous;
    }

    // Edge case: no donations
    if (allDonations.isEmpty) {
      return DonorRating.newDonor;
    }

    final donorId = donation.donorUserId;

    // Gather all donations by this donor
    final donorDonations = allDonations
        .where((d) => d.donorUserId == donorId)
        .toList();

    if (donorDonations.isEmpty) {
      return DonorRating.newDonor;
    }

    // 1. Generosity (40%) - total donated vs average donation
    final donorTotal = donorDonations.fold<double>(0, (sum, d) => sum + d.amount);
    final avgDonation = allDonations.fold<double>(0, (sum, d) => sum + d.amount) / allDonations.length;
    final generosityScore = avgDonation > 0
        ? (donorTotal / (avgDonation * 2)).clamp(0.0, 1.0) // 2x average = max score
        : 0.0;

    // 2. Repeat Support (25%) - donor's donation count vs most active donor
    final donationCounts = <int, int>{};
    for (final d in allDonations) {
      donationCounts[d.donorUserId] = (donationCounts[d.donorUserId] ?? 0) + 1;
    }
    final maxDonationCount = donationCounts.values.fold<int>(1, max);
    final repeatSupportScore = maxDonationCount > 0
        ? (donorDonations.length / maxDonationCount).clamp(0.0, 1.0)
        : 0.0;

    // 3. Engagement (20%) - has message (50%) + not anonymous (50%)
    final hasMessage = donorDonations.any((d) => d.message != null && d.message!.isNotEmpty);
    final engagementScore = (hasMessage ? 0.5 : 0.0) + 0.5; // +0.5 for being non-anonymous

    // 4. Early Support (15%) - how early the first donation was relative to campaign age
    final campaignAge = DateTime.now().difference(crowdfund.createdAt).inDays;
    final earliestDonation = donorDonations.map((d) => d.donationDate).reduce(
        (a, b) => a.isBefore(b) ? a : b);
    final daysSinceCampaignStart = earliestDonation.difference(crowdfund.createdAt).inDays;
    final earlySupportScore = campaignAge > 0
        ? (1.0 - (daysSinceCampaignStart / campaignAge)).clamp(0.0, 1.0)
        : 1.0; // If donated on same day as creation, max score

    // Weighted average
    final weightedAverage =
        (generosityScore * 0.40) +
        (repeatSupportScore * 0.25) +
        (engagementScore * 0.20) +
        (earlySupportScore * 0.15);

    // Map to 1-5 stars
    final overallScore = 1.0 + (weightedAverage * 4.0);
    final starCount = overallScore.round().clamp(1, 5);
    final label = _getLabel(starCount);

    return DonorRating(
      overallScore: overallScore,
      starCount: starCount,
      generosityScore: generosityScore,
      repeatSupportScore: repeatSupportScore,
      engagementScore: engagementScore,
      earlySupportScore: earlySupportScore,
      label: label,
    );
  }

  static String _getLabel(int starCount) {
    switch (starCount) {
      case 5:
        return 'Champion';
      case 4:
        return 'Generous';
      case 3:
        return 'Supporter';
      case 2:
        return 'Backer';
      default:
        return 'New';
    }
  }
}
