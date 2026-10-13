import 'package:equatable/equatable.dart';

import 'group_entities.dart';

/// One person waiting on THIS admin to let them into a group.
///
/// Carries the group alongside the requester because the Join Requests tab is
/// cross-group: a row has to say which group it is for, and fetching that per
/// row would be a request per row on a tab that opens on every visit.
class PendingJoinRequest extends Equatable {
  const PendingJoinRequest({
    required this.member,
    required this.groupId,
    required this.groupName,
    this.groupImageUrl = '',
    this.groupMemberCount = 0,
  });

  final GroupMember member;
  final String groupId;
  final String groupName;
  final String groupImageUrl;
  final int groupMemberCount;

  /// When they asked.
  ///
  /// GroupMember does not carry requested_at on this build, and joinedAt is
  /// the row's creation time for a pending request — which is the same moment.
  DateTime get requestedAt => member.joinedAt;

  /// How long they have been waiting, phrased for a queue an admin is
  /// working through — the number that decides who to answer first.
  String get waitingLabel {
    final d = DateTime.now().difference(requestedAt);
    if (d.inDays >= 1) {
      return d.inDays == 1 ? 'Waiting 1 day' : 'Waiting ${d.inDays} days';
    }
    if (d.inHours >= 1) {
      return d.inHours == 1 ? 'Waiting 1 hour' : 'Waiting ${d.inHours} hours';
    }
    return 'Just now';
  }

  /// A request nobody has answered for a week is the one most likely to be
  /// forgotten, so the row says so rather than leaving it to be noticed.
  bool get isStale => DateTime.now().difference(requestedAt).inDays >= 7;

  @override
  List<Object?> get props =>
      [member, groupId, groupName, groupImageUrl, groupMemberCount];
}
