library;

import 'package:flutter/foundation.dart';

import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// The last account summaries the server gave us, readable from anywhere.
///
/// WHY THIS EXISTS
/// ---------------
/// `AccountCardsSummaryCubit` is registered with `registerFactory`, so EVERY
/// `serviceLocator<AccountCardsSummaryCubit>()` hands back a BRAND NEW cubit
/// sitting in `AccountCardsSummaryInitial`. The dashboard holds one instance
/// (main.dart's `BlocProvider.value`); each route that provides its own with
/// `create:` holds another; and any helper that reaches through the locator
/// gets a third that has never fetched anything.
///
/// That is why Lazerspray's Fund Wallet sheet said "No account selected" no
/// matter how many times the resolution logic was fixed: the fix read the
/// state of a cubit that was constructed one line earlier. Worse, the
/// "fetch it then" repair fetched into instance A and then re-read instance
/// B — so even a successful network call changed nothing on screen.
///
/// Switching the registration to a singleton is NOT the fix: `BlocProvider`
/// with `create:` closes the cubit it creates when its route pops, which would
/// close the shared instance for the whole app the first time any of those ~20
/// routes was dismissed.
///
/// So the rows live here instead, written by whichever instance fetched them
/// and read by everyone. The backend stays the source of truth — this only
/// remembers what it last said.
///
/// USER SCOPING
/// ------------
/// Rows are stamped with the user they belong to and dropped on
/// [clear]. Two people sharing one phone must never see each other's wallets,
/// so a read that names a user gets nothing when the stamp disagrees rather
/// than the previous session's accounts.
class AccountSummariesStore {
  AccountSummariesStore._();

  static List<AccountSummaryEntity> _rows = const [];
  static String? _userId;
  static DateTime? _at;

  /// Bumped on every publish and clear, so a widget can rebuild when the
  /// summaries land after it was built.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  /// When the rows were last written, or null when there are none.
  static DateTime? get updatedAt => _at;

  /// The user the current rows belong to, or null when empty.
  static String? get userId => _userId;

  /// The latest rows. Empty when nothing has loaded yet.
  ///
  /// Pass [forUserId] from any surface that knows who is signed in: rows
  /// belonging to someone else are withheld rather than returned.
  static List<AccountSummaryEntity> rows({String? forUserId}) {
    if (_rows.isEmpty) return const [];
    if (forUserId != null &&
        forUserId.isNotEmpty &&
        _userId != null &&
        _userId!.isNotEmpty &&
        _userId != forUserId) {
      return const [];
    }
    return _rows;
  }

  /// Record the rows a cubit just loaded.
  ///
  /// An EMPTY list is ignored rather than stored. A cubit emitting its initial
  /// or loading state must not blank out summaries another instance already
  /// has — use [clear] to do that deliberately on logout.
  static void publish(List<AccountSummaryEntity> rows, {String? userId}) {
    if (rows.isEmpty) return;
    _rows = List<AccountSummaryEntity>.unmodifiable(rows);
    if (userId != null && userId.isNotEmpty) _userId = userId;
    _at = DateTime.now();
    revision.value++;
  }

  /// Forget everything. Called on logout and on user switch.
  static void clear() {
    if (_rows.isEmpty && _userId == null) return;
    _rows = const [];
    _userId = null;
    _at = null;
    revision.value++;
  }
}
