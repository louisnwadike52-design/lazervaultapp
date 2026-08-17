part of 'create_family_account_carousel.dart';

/// One member the user has queued to invite while creating the account.
/// [allocation] rides on the invitation and is only applied once the invitee
/// accepts — money never sits in a non-member's balance.
class _DraftMember {
  final UserSearchResultEntity user;
  double allocation = 0;
  double dailyLimit = 0;
  double monthlyLimit = 0;

  _DraftMember(this.user);
}
