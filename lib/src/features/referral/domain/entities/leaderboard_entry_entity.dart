import 'package:equatable/equatable.dart';

class LeaderboardEntryEntity extends Equatable {
  final int rank;
  final int userId;
  final String username;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final int totalReferrals;
  final int totalRewardsEarned;
  final String currency;

  const LeaderboardEntryEntity({
    required this.rank,
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    required this.totalReferrals,
    required this.totalRewardsEarned,
    required this.currency,
  });

  String get displayName => '$firstName $lastName';

  String get initials {
    final first = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final last = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$first$last';
  }

  LeaderboardEntryEntity copyWith({
    int? rank,
    int? userId,
    String? username,
    String? firstName,
    String? lastName,
    String? profilePicture,
    int? totalReferrals,
    int? totalRewardsEarned,
    String? currency,
  }) {
    return LeaderboardEntryEntity(
      rank: rank ?? this.rank,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
      totalReferrals: totalReferrals ?? this.totalReferrals,
      totalRewardsEarned: totalRewardsEarned ?? this.totalRewardsEarned,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [
        rank,
        userId,
        username,
        firstName,
        lastName,
        profilePicture,
        totalReferrals,
        totalRewardsEarned,
        currency,
      ];

  @override
  String toString() {
    return 'LeaderboardEntryEntity(rank: $rank, userId: $userId, username: $username, firstName: $firstName, lastName: $lastName, totalReferrals: $totalReferrals, totalRewardsEarned: $totalRewardsEarned, currency: $currency)';
  }
}
