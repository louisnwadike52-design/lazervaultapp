import 'dart:math';
import '../../group_account/domain/entities/group_entities.dart';

/// Rating result for a group member
class MemberRating {
  final double overallScore;
  final int starCount;
  final double complianceScore;
  final double consistencyScore;
  final double breadthScore;
  final double tenureScore;
  final String label;

  const MemberRating({
    required this.overallScore,
    required this.starCount,
    required this.complianceScore,
    required this.consistencyScore,
    required this.breadthScore,
    required this.tenureScore,
    required this.label,
  });

  static const MemberRating pending = MemberRating(
    overallScore: 1.0,
    starCount: 1,
    complianceScore: 0,
    consistencyScore: 0,
    breadthScore: 0,
    tenureScore: 0,
    label: 'Pending',
  );

  static const MemberRating newMember = MemberRating(
    overallScore: 1.0,
    starCount: 1,
    complianceScore: 0,
    consistencyScore: 0,
    breadthScore: 0,
    tenureScore: 0,
    label: 'New',
  );
}

/// Calculates AI-powered star ratings for group fund members.
///
/// Four factors weighted to produce a 1-5 star score:
/// - Payment Compliance (40%): totalPaid / expectedAmount averaged across contributions
/// - Consistency (25%): Ratio of hasPaidCurrentCycle == true across active contributions
/// - Contribution Breadth (20%): Number of contributions member is in vs total available
/// - Activity Tenure (15%): Days since joinedAt (90+ days = max score)
class MemberRatingCalculator {
  static MemberRating calculateRating(
    GroupMember member,
    List<Contribution> contributions,
  ) {
    // Edge case: partial/pending members
    if (member.isPartial || member.status == GroupMemberStatus.pending) {
      return MemberRating.pending;
    }

    // Edge case: no contributions in the group
    if (contributions.isEmpty) {
      return MemberRating.newMember;
    }

    // Find all contributions this member participates in
    final memberContributions = <_MemberContributionData>[];
    for (final contribution in contributions) {
      for (final cm in contribution.members) {
        if (cm.userId == member.userId) {
          memberContributions.add(_MemberContributionData(
            totalPaid: cm.totalPaid,
            expectedAmount: cm.expectedAmount,
            hasPaidCurrentCycle: cm.hasPaidCurrentCycle,
          ));
          break;
        }
      }
    }

    // Edge case: member not in any contributions
    if (memberContributions.isEmpty) {
      return MemberRating.newMember;
    }

    // 1. Payment Compliance (40%) - average of totalPaid/expectedAmount
    double complianceSum = 0;
    int complianceCount = 0;
    for (final mc in memberContributions) {
      if (mc.expectedAmount > 0) {
        complianceSum += (mc.totalPaid / mc.expectedAmount).clamp(0.0, 1.0);
        complianceCount++;
      }
    }
    final complianceScore = complianceCount > 0
        ? complianceSum / complianceCount
        : 0.0;

    // 2. Consistency (25%) - ratio of hasPaidCurrentCycle == true
    final paidCycles = memberContributions.where((mc) => mc.hasPaidCurrentCycle).length;
    final consistencyScore = memberContributions.isNotEmpty
        ? paidCycles / memberContributions.length
        : 0.0;

    // 3. Contribution Breadth (20%) - contributions joined vs total available
    final breadthScore = contributions.isNotEmpty
        ? (memberContributions.length / contributions.length).clamp(0.0, 1.0)
        : 0.0;

    // 4. Activity Tenure (15%) - days since joinedAt, 90+ = max
    final daysSinceJoin = DateTime.now().difference(member.joinedAt).inDays;
    final tenureScore = min(daysSinceJoin / 90.0, 1.0);

    // Weighted average
    final weightedAverage =
        (complianceScore * 0.40) +
        (consistencyScore * 0.25) +
        (breadthScore * 0.20) +
        (tenureScore * 0.15);

    // Map to 1-5 stars: 1.0 + (weightedAverage * 4.0)
    final overallScore = 1.0 + (weightedAverage * 4.0);
    final starCount = overallScore.round().clamp(1, 5);

    // Label
    final label = _getLabel(starCount);

    return MemberRating(
      overallScore: overallScore,
      starCount: starCount,
      complianceScore: complianceScore,
      consistencyScore: consistencyScore,
      breadthScore: breadthScore,
      tenureScore: tenureScore,
      label: label,
    );
  }

  static String _getLabel(int starCount) {
    switch (starCount) {
      case 5:
        return 'Excellent';
      case 4:
        return 'Good';
      case 3:
        return 'Average';
      case 2:
        return 'Fair';
      default:
        return 'New';
    }
  }
}

class _MemberContributionData {
  final double totalPaid;
  final double expectedAmount;
  final bool hasPaidCurrentCycle;

  const _MemberContributionData({
    required this.totalPaid,
    required this.expectedAmount,
    required this.hasPaidCurrentCycle,
  });
}
