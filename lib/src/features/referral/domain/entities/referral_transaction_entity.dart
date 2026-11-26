import 'package:equatable/equatable.dart';

enum ReferralStatus { pending, completed, failed, cancelled }

class ReferralTransactionEntity extends Equatable {
  final int id;
  final int referrerUserId;
  final int refereeUserId;
  final String referralCodeUsed;
  final ReferralStatus status;
  final int referrerRewardAmount;
  final int refereeRewardAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;
  final String refereeFirstName;
  final String refereeLastName;
  final String refereeUsername;
  final String referrerUsername;
  final bool refereeHasJoined;

  const ReferralTransactionEntity({
    required this.id,
    required this.referrerUserId,
    required this.refereeUserId,
    required this.referralCodeUsed,
    required this.status,
    required this.referrerRewardAmount,
    required this.refereeRewardAmount,
    required this.currency,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
    this.refereeFirstName = '',
    this.refereeLastName = '',
    this.refereeUsername = '',
    this.referrerUsername = '',
    this.refereeHasJoined = false,
  });

  String get refereeDisplayName {
    if (refereeFirstName.isNotEmpty || refereeLastName.isNotEmpty) {
      return '$refereeFirstName $refereeLastName'.trim();
    }
    if (refereeUsername.isNotEmpty) return '@$refereeUsername';
    return 'Referral #$id';
  }

  /// WHAT THE REFERRER ACTUALLY NEEDS TO KNOW.
  ///
  /// The bonus is released only when the person you referred completes KYC, so
  /// "did they sign up" and "did they verify" are different questions and the
  /// screen used to answer neither — a referral in flight rendered as a name
  /// and a timestamp, with no hint that KYC was the thing still outstanding.
  /// One referrer reported six signups against his code and assumed the code
  /// was broken.
  ///
  /// `completed` is the only status a credit can produce, and a credit happens
  /// only after KYC approval, so it is a sound proxy for "verified".
  bool get refereeKycVerified => status == ReferralStatus.completed;

  /// Signed up, but the bonus is still waiting on their KYC.
  bool get awaitingRefereeKyc => status == ReferralStatus.pending;

  /// True when the server has told us this referral cannot pay, even though it
  /// is still sitting in `pending`.
  ///
  /// A bonus needs a KYC-verified referee AND a handset nobody else signed up
  /// on. Only the backend can judge the second, so it writes the reason onto
  /// the row rather than inventing a new status — the referral stays `pending`
  /// because the referrer has not lost anything permanent, but it will not pay
  /// as things stand, and saying "KYC not completed yet" about somebody who
  /// completed it is simply false.
  bool get blockedWhilePending =>
      status == ReferralStatus.pending &&
      (failureReason?.trim().isNotEmpty ?? false);

  /// One short line naming the stage this referral is at.
  String get kycStageLabel {
    switch (status) {
      case ReferralStatus.completed:
        return 'KYC verified · bonus earned';
      case ReferralStatus.pending:
        // A server-supplied reason WINS over the stage wording. It is the only
        // thing on this screen that can explain a referral which is verified
        // and still unpaid; without it the row said "KYC not completed yet" to
        // a referrer whose referee was plainly verified, and one referrer with
        // six signups and no bonus had no way to find out why.
        final blockedReason = failureReason?.trim();
        if (blockedReason != null && blockedReason.isNotEmpty) {
          return blockedReason;
        }
        return refereeHasJoined
            ? 'Joined · KYC not completed yet'
            : 'Signed up · KYC not completed yet';
      case ReferralStatus.failed:
        final reason = failureReason?.trim();
        return (reason == null || reason.isEmpty)
            ? 'Could not be completed'
            : reason;
      case ReferralStatus.cancelled:
        return 'Cancelled';
    }
  }

  ReferralTransactionEntity copyWith({
    int? id,
    int? referrerUserId,
    int? refereeUserId,
    String? referralCodeUsed,
    ReferralStatus? status,
    int? referrerRewardAmount,
    int? refereeRewardAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? completedAt,
    String? failureReason,
    String? refereeFirstName,
    String? refereeLastName,
    String? refereeUsername,
    String? referrerUsername,
    bool? refereeHasJoined,
  }) {
    return ReferralTransactionEntity(
      id: id ?? this.id,
      referrerUserId: referrerUserId ?? this.referrerUserId,
      refereeUserId: refereeUserId ?? this.refereeUserId,
      referralCodeUsed: referralCodeUsed ?? this.referralCodeUsed,
      status: status ?? this.status,
      referrerRewardAmount: referrerRewardAmount ?? this.referrerRewardAmount,
      refereeRewardAmount: refereeRewardAmount ?? this.refereeRewardAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      failureReason: failureReason ?? this.failureReason,
      refereeFirstName: refereeFirstName ?? this.refereeFirstName,
      refereeLastName: refereeLastName ?? this.refereeLastName,
      refereeUsername: refereeUsername ?? this.refereeUsername,
      referrerUsername: referrerUsername ?? this.referrerUsername,
      refereeHasJoined: refereeHasJoined ?? this.refereeHasJoined,
    );
  }

  @override
  List<Object?> get props => [
        id,
        referrerUserId,
        refereeUserId,
        referralCodeUsed,
        status,
        referrerRewardAmount,
        refereeRewardAmount,
        currency,
        createdAt,
        completedAt,
        failureReason,
        refereeFirstName,
        refereeLastName,
        refereeUsername,
        referrerUsername,
        refereeHasJoined,
      ];

  @override
  String toString() {
    return 'ReferralTransactionEntity(id: $id, referee: $refereeDisplayName, status: $status, referrerReward: $referrerRewardAmount, currency: $currency)';
  }
}
