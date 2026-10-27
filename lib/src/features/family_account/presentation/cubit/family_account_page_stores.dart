import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

import '../../domain/entities/family_account_entities.dart';

/// The family-accounts overview and the pending invitations, remembered
/// across opens of the Family Accounts list.
///
/// WHY: `FamilyAccountCubit` is a FACTORY and the list screen keeps its rows
/// in screen-local fields, so every open started with an empty list, a
/// loader, and two network reads — over accounts the user had looked at a
/// moment ago. The screen now seeds its rows from here, the cubits paint the
/// same rows at once, and both reads refresh them behind.
///
/// Two stores because the two reads are independent and land at different
/// times. The overview is stored whole (accounts + the creation quota) so the
/// quota line paints with the rows instead of after them.
///
/// In memory only — the entities carry no JSON codec, so a cold start still
/// pays one loader. Per user (stamped) and cleared with every other
/// SessionPageStore on a user switch.
class FamilyAccountPageStores {
  FamilyAccountPageStores._();

  /// One entry: the overview the list was last painted from.
  static final SessionPageStore<FamilyAccountsOverview> overview =
      SessionPageStore<FamilyAccountsOverview>('family_accounts_overview');

  static final SessionPageStore<PendingInvitation> pendingInvitations =
      SessionPageStore<PendingInvitation>('family_pending_invitations');

  /// Who the remembered rows belong to. Reads the signed-in identity; tests
  /// swap it so the cubit can be driven without GetIt.
  static String Function() userIdResolver = _signedInUserId;

  /// Whoever is signed in, or '' when nobody is — the stores then refuse to
  /// remember and the screen behaves exactly as it did before.
  static String _signedInUserId() {
    try {
      if (serviceLocator.isRegistered<AuthenticationCubit>()) {
        return serviceLocator<AuthenticationCubit>().userId ?? '';
      }
    } catch (_) {/* best-effort */}
    return '';
  }

  static String scopeFor(String? statusFilter) => statusFilter ?? '';

  static FamilyAccountsOverview? peekOverview({String? statusFilter}) {
    final userId = userIdResolver();
    if (userId.isEmpty) return null;
    final rows = overview.peek(userId: userId, scope: scopeFor(statusFilter));
    if (rows == null || rows.isEmpty) return null;
    return rows.first;
  }

  static void rememberOverview(FamilyAccountsOverview o,
      {String? statusFilter}) {
    final userId = userIdResolver();
    if (userId.isEmpty) return;
    overview.put([o], userId: userId, scope: scopeFor(statusFilter));
  }

  static List<PendingInvitation>? peekInvitations() {
    final userId = userIdResolver();
    if (userId.isEmpty) return null;
    return pendingInvitations.peek(userId: userId);
  }

  static void rememberInvitations(List<PendingInvitation> rows) {
    final userId = userIdResolver();
    if (userId.isEmpty) return;
    pendingInvitations.put(rows, userId: userId);
  }
}
