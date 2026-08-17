part of 'create_split_bill_screen.dart';

class _SelectedParticipant {
  /// Preferred stable id (from the search result). Co-payers are keyed by this
  /// so a valid Lazervault user with no public @username can still be added.
  final String userId;
  final String username;
  final String displayName;

  const _SelectedParticipant({
    required this.userId,
    required this.username,
    required this.displayName,
  });

  /// Stable map/dedupe key: the user id when present, else the username.
  String get key => userId.isNotEmpty ? userId : username;
}

enum _SplitMethod { equal, custom, percentage }

enum _ReceiverMode { collectMyself, lazerVaultUser, bankAccount }
