import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/tagged_invoice_repository.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/domain/repositories/family_account_repository.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';
import 'package:lazervault/src/features/group_account/domain/repositories/group_account_repository.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/pending_actions/domain/pending_action.dart';
import 'package:lazervault/src/features/split_bills/domain/entities/split_bill_entity.dart';
import 'package:lazervault/src/features/split_bills/domain/repositories/split_bill_repository.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_tag_entity.dart';
import 'package:lazervault/src/features/tag_pay/domain/repositories/tag_pay_repository.dart';

/// Aggregates everything the user still owes money on — tags raised against
/// them, invoices they were tagged to pay, split-bill shares — into one
/// snapshot that drives BOTH the service-tile badges and the launch prompt.
///
/// Client-side aggregation on purpose. Each list endpoint is one the owning
/// screen already calls, so this adds no new backend surface and ships without
/// a proto change or a gateway deploy. If the fan-out ever becomes a cost, a
/// single server-side digest can replace [_refreshAll] without touching a
/// single consumer.
///
/// Failure policy is the important part: a source that throws keeps its LAST
/// GOOD list and is marked stale, instead of collapsing to zero. A badge that
/// vanishes on a flaky connection tells the user they owe nothing — the exact
/// failure this feature exists to prevent.
class PendingActionsCubit extends Cubit<PendingActionsSnapshot> {
  PendingActionsCubit({
    required TagPayRepository tagPayRepository,
    required TaggedInvoiceRepository invoiceRepository,
    required SplitBillRepository splitBillRepository,
    required FamilyAccountRepository familyRepository,
    required GroupAccountRepository groupRepository,
    required P2PChatRepository chatRepository,
  })  : _tagPay = tagPayRepository,
        _invoices = invoiceRepository,
        _splitBills = splitBillRepository,
        _family = familyRepository,
        _groups = groupRepository,
        _chat = chatRepository,
        super(const PendingActionsSnapshot());

  final TagPayRepository _tagPay;
  final TaggedInvoiceRepository _invoices;
  final SplitBillRepository _splitBills;
  final FamilyAccountRepository _family;
  final GroupAccountRepository _groups;
  final P2PChatRepository _chat;

  /// How many items each source contributes. The prompt shows a handful and
  /// links out for the rest; the badge counts what we fetched. Deliberately
  /// generous so a badge is only ever wrong for users with 50+ open demands in
  /// one service, where the exact number has stopped mattering anyway.
  static const int _perSourceLimit = 50;

  bool _inFlight = false;

  /// Refreshes every source concurrently. Safe to call repeatedly and never
  /// throws. Concurrent calls collapse — a second call while one is in flight
  /// returns immediately rather than doubling the fan-out (the dashboard
  /// refreshes on launch AND on resume, which can coincide).
  Future<void> refresh() async {
    if (_inFlight || isClosed) return;
    _inFlight = true;
    _safeEmit(state.copyWith(isLoading: true));
    try {
      final userId = await _resolveCurrentUserId();
      if (userId == null || userId.isEmpty) {
        // Signed out (or not hydrated yet): clear rather than keep another
        // user's counts on screen.
        _safeEmit(const PendingActionsSnapshot());
        return;
      }
      await _refreshAll(userId);
    } finally {
      _inFlight = false;
    }
  }

  /// Drops everything. Called on logout / user switch so the next user never
  /// inherits the previous one's badges.
  void clear() => _safeEmit(const PendingActionsSnapshot());

  /// Refreshes in two waves rather than one six-way fan-out.
  ///
  /// Payments first, and the snapshot is emitted as soon as they land, so the
  /// launch prompt is not gated on six round-trips completing. Requests follow
  /// and emit again.
  ///
  /// The split is deliberate on two counts. The prompt exists to catch someone
  /// at launch, so the half that costs them money if missed should not wait on
  /// the half that does not. And six concurrent calls at launch is exactly the
  /// connection pressure that made the app's gRPC channels trip Cloudflare's
  /// ENHANCE_YOUR_CALM — see `grpc_channel_factory.dart`.
  Future<void> _refreshAll(String userId) async {
    final payments = await Future.wait([
      _guard(PendingActionSource.tagPay, _loadTags),
      _guard(PendingActionSource.invoice, () => _loadInvoices(userId)),
      _guard(PendingActionSource.splitBill, () => _loadSplitBills(userId)),
    ]);
    var snapshot = _merge(state, payments, isLoading: true);
    _safeEmit(snapshot);
    if (isClosed) return;

    final requests = await Future.wait([
      _guard(PendingActionSource.familyInvite, _loadFamilyInvites),
      _guard(PendingActionSource.groupInvite, _loadGroupInvites),
      _guard(PendingActionSource.connectionRequest, _loadConnectionRequests),
    ]);
    _safeEmit(_merge(snapshot, requests, isLoading: false));
  }

  /// Folds one wave's results into [base], preserving the other wave's entries.
  ///
  /// A source that failed keeps its LAST GOOD list and is marked stale rather
  /// than collapsing to zero: a badge that vanishes on a flaky connection tells
  /// the user they owe nothing, which is the exact failure this feature exists
  /// to prevent.
  PendingActionsSnapshot _merge(
    PendingActionsSnapshot base,
    List<_SourceResult> results, {
    required bool isLoading,
  }) {
    final next = Map<PendingActionSource, List<PendingAction>>.from(
      base.bySource,
    );
    final stale = Set<PendingActionSource>.from(base.staleSources);

    for (final result in results) {
      final actions = result.actions;
      if (actions == null) {
        // Failed: retain whatever we last knew for this source, and say so.
        stale.add(result.source);
        continue;
      }
      stale.remove(result.source);
      if (actions.isEmpty) {
        // Genuinely nothing here now — drop any stale entry so a cleared
        // queue stops badging.
        next.remove(result.source);
      } else {
        next[result.source] = actions;
      }
    }

    return PendingActionsSnapshot(
      bySource: next,
      isLoading: isLoading,
      fetchedAt: DateTime.now(),
      staleSources: stale,
    );
  }

  Future<_SourceResult> _guard(
    PendingActionSource source,
    Future<List<PendingAction>> Function() load,
  ) async {
    try {
      return _SourceResult(source, await load());
    } catch (e) {
      debugPrint('PendingActionsCubit: ${source.name} refresh failed: $e');
      return _SourceResult(source, null);
    }
  }

  // -------------------------------------------------------------------
  // Sources
  // -------------------------------------------------------------------

  /// Tags OTHERS raised against this user. Incoming = I owe them.
  ///
  /// TagPay money requests are deliberately NOT a fourth source. They exist in
  /// the repository and the cubit, but nothing in the app renders or accepts
  /// one — "Request Funds" on the TagPay home screen creates a TAG. Listing
  /// them here would put rows in the launch prompt whose Pay button has
  /// nowhere to go. Add them here when a screen exists to send them to.
  ///
  /// The server filter is `status = 'pending'`, which still includes tags whose
  /// 7-day lifetime has elapsed but that the expiry sweeper hasn't closed yet.
  /// Those are not payable, so [UserTagEntity.isActionable] re-checks the
  /// deadline here rather than trusting the status column alone.
  Future<List<PendingAction>> _loadTags() async {
    final page = await _tagPay.getMyIncomingTags(
      page: 1,
      limit: _perSourceLimit,
      status: 'pending',
    );
    return page.tags
        .where((tag) => tag.isActionable)
        .map((tag) => PendingAction(
              source: PendingActionSource.tagPay,
              id: tag.id,
              title: tag.taggerName.isNotEmpty ? tag.taggerName : 'Someone',
              subtitle: tag.taggerTagPay.isNotEmpty
                  ? '@${tag.taggerTagPay}'
                  : (tag.description.isNotEmpty ? tag.description : null),
              amount: tag.amount,
              currency: tag.currency,
              createdAt: tag.createdAt,
              dueAt: tag.expiresAt,
              route: AppRoutes.tagPaymentConfirmation,
              routeArguments: tag,
            ))
        .toList();
  }

  /// Invoices this user was tagged to pay.
  ///
  /// Filtered `unpaid`, NOT `pending`. The server matches the per-user tagged
  /// status exactly, so `pending` stops returning an invoice the moment that
  /// row becomes `viewed` — silently dropping exactly the invoices someone has
  /// looked at and not paid, which are the ones a reminder is for.
  ///
  /// Two further exclusions mirror the incoming-invoices screen, and both are
  /// money-correctness rules rather than cosmetics: a QUOTE is a document, not
  /// a payable, until its creator converts it; and on a split invoice this
  /// user's own share may already be settled while the invoice as a whole is
  /// still open for everyone else.
  Future<List<PendingAction>> _loadInvoices(String userId) async {
    final invoices = await _invoices.getIncomingTaggedInvoices(
      page: 1,
      limit: _perSourceLimit,
      rawStatusFilter: 'unpaid',
    );
    final actions = <PendingAction>[];
    for (final tagged in invoices) {
      final invoice = tagged.invoice;
      if (invoice == null) continue;
      if (invoice.isQuote) continue;
      if (_myInvoiceShareIsPaid(tagged, userId)) continue;

      actions.add(PendingAction(
        source: PendingActionSource.invoice,
        id: tagged.invoiceId,
        title: tagged.taggerName?.isNotEmpty == true
            ? tagged.taggerName!
            : (invoice.title.isNotEmpty ? invoice.title : 'Invoice'),
        subtitle: invoice.invoiceNumber.isNotEmpty
            ? 'Invoice #${invoice.invoiceNumber}'
            : (invoice.title.isNotEmpty ? invoice.title : null),
        amount: _myInvoiceShare(tagged, userId) ?? invoice.totalAmount,
        currency: invoice.currency,
        createdAt: tagged.taggedAt,
        dueAt: invoice.dueDate,
        route: AppRoutes.invoiceItemPayment,
        routeArguments: invoice,
      ));
    }
    return actions;
  }

  /// Split bills where this user is a co-payer still on the hook.
  ///
  /// The amount is the user's OWN share from their participant row, never the
  /// bill total. Routing goes to the detail screen rather than straight to the
  /// pay screen: the pay screen takes a loose argument map (amount, currency,
  /// names) and the detail screen derives all of it from the live record, so
  /// there is no way for this prompt to propose paying the wrong number.
  Future<List<PendingAction>> _loadSplitBills(String userId) async {
    final page = await _splitBills.getMyIncomingSplitBills(
      limit: _perSourceLimit,
      status: SplitBillStatus.active,
    );
    final actions = <PendingAction>[];
    for (final bill in page.bills) {
      final me = bill.participantForUser(userId);
      if (me == null || !me.isPending) continue;
      actions.add(PendingAction(
        source: PendingActionSource.splitBill,
        id: bill.id,
        title: bill.creatorName.isNotEmpty ? bill.creatorName : 'Split bill',
        subtitle: bill.title.isNotEmpty ? bill.title : bill.description,
        amount: me.amount,
        currency: bill.currency,
        createdAt: bill.createdAt,
        route: AppRoutes.splitBillDetail,
        routeArguments: {'splitBillId': bill.id},
      ));
    }
    return actions;
  }

  // -------------------------------------------------------------------
  // Requests — someone waiting on a decision, no money attached
  // -------------------------------------------------------------------

  /// Family-account invitations addressed to this user.
  ///
  /// The repository returns Either, so a Left is turned into a throw for
  /// [_guard] to catch — otherwise a failed fetch would look like an empty
  /// inbox and silently clear the entry.
  ///
  /// Carries no amount even though the invitation names an allocation: that is
  /// money the INVITER proposes to give, not money this user owes, and putting
  /// it on a row whose sibling rows are debts would read as a bill.
  Future<List<PendingAction>> _loadFamilyInvites() async {
    final result = await _family.getPendingInvitations();
    final invites = result.fold<List<PendingInvitation>>(
      (failure) => throw Exception('family invitations: ${failure.message}'),
      (list) => list,
    );
    final now = DateTime.now();
    return invites
        // An expired invitation cannot be accepted, so prompting for it would
        // send the user to a dead end.
        .where((i) => i.expiresAt.isAfter(now))
        .map((i) => PendingAction(
              source: PendingActionSource.familyInvite,
              id: i.invitationToken,
              title: i.creatorName.isNotEmpty
                  ? i.creatorName
                  : (i.familyName.isNotEmpty ? i.familyName : 'Family account'),
              subtitle: i.familyName.isNotEmpty
                  ? 'Invited you to ${i.familyName}'
                  : 'Invited you to a family account',
              createdAt: i.createdAt,
              dueAt: i.expiresAt,
              route: AppRoutes.familyInvitations,
              routeArguments: {'invitationToken': i.invitationToken},
            ))
        .toList();
  }

  /// Joint Funds (group account) invitations still awaiting a decision.
  Future<List<PendingAction>> _loadGroupInvites() async {
    final invites = await _groups.listMyInvitations(
      statuses: const [GroupInvitationStatus.pending],
      limit: _perSourceLimit,
    );
    final now = DateTime.now();
    return invites
        .where((i) => i.expiresAt.isAfter(now))
        .map((i) => PendingAction(
              source: PendingActionSource.groupInvite,
              id: i.id,
              title: i.inviterName.isNotEmpty ? i.inviterName : 'Someone',
              subtitle: i.groupName.isNotEmpty
                  ? 'Invited you to ${i.groupName}'
                  : 'Invited you to a joint account',
              createdAt: i.invitedAt,
              dueAt: i.expiresAt,
              route: AppRoutes.groupDetails,
              routeArguments: i.groupId,
            ))
        .toList();
  }

  /// Incoming financial-connection requests.
  ///
  /// Routes to the connections screen rather than to the conversation: the
  /// decision to accept lives there, and opening a chat with someone the user
  /// has not accepted yet would skip the decision the notification is asking
  /// for.
  Future<List<PendingAction>> _loadConnectionRequests() async {
    final requests = await _chat.listIncomingRequests(
      page: 1,
      limit: _perSourceLimit,
    );
    return requests
        .map((r) => PendingAction(
              source: PendingActionSource.connectionRequest,
              id: r.id,
              title: r.otherUserName?.isNotEmpty == true
                  ? r.otherUserName!
                  : 'Someone',
              subtitle: 'Wants to connect with you',
              createdAt: r.createdAt,
              route: AppRoutes.financialConnections,
            ))
        .toList();
  }

  // -------------------------------------------------------------------
  // Helpers
  // -------------------------------------------------------------------

  double? _myInvoiceShare(TaggedInvoice tagged, String userId) {
    final tags = tagged.invoice?.taggedUsers;
    if (tags == null || tags.isEmpty) return null;
    for (final t in tags) {
      if (t.userId == userId) {
        // shareAmount defaults to 0 for a non-split invoice; fall back to the
        // invoice total in that case rather than telling the user they owe
        // nothing.
        return t.shareAmount > 0 ? t.shareAmount : null;
      }
    }
    return null;
  }

  bool _myInvoiceShareIsPaid(TaggedInvoice tagged, String userId) {
    final tags = tagged.invoice?.taggedUsers;
    if (tags == null || tags.isEmpty) return false;
    for (final t in tags) {
      if (t.userId == userId) return t.status == 'paid';
    }
    return false;
  }

  /// Prefer the in-memory profile; fall back to secure storage since the
  /// locator-provided AuthenticationCubit is a factory and a fresh instance may
  /// not be hydrated yet. Mirrors [SplitBillCountCubit].
  Future<String?> _resolveCurrentUserId() async {
    try {
      final fromCubit = serviceLocator<AuthenticationCubit>().userId;
      if (fromCubit != null && fromCubit.isNotEmpty) return fromCubit;
    } catch (_) {
      // ignore — fall through to storage
    }
    try {
      return await serviceLocator<SecureStorageService>().getUserId();
    } catch (_) {
      return null;
    }
  }

  void _safeEmit(PendingActionsSnapshot snapshot) {
    if (!isClosed) emit(snapshot);
  }
}

/// Fire-and-forget refresh for callers that just changed what the user owes —
/// a paid tag, a settled invoice, a covered split-bill share.
///
/// The dashboard refreshes on launch and on resume, but neither fires when a
/// payment completes on a screen pushed above it, so a just-cleared badge would
/// sit there stale until the app was backgrounded. Safe to call before the
/// locator is ready (it simply does nothing) and never throws.
void refreshPendingActions() {
  try {
    serviceLocator<PendingActionsCubit>().refresh();
  } catch (e) {
    debugPrint('refreshPendingActions: skipped ($e)');
  }
}

class _SourceResult {
  const _SourceResult(this.source, this.actions);
  final PendingActionSource source;

  /// Null means the fetch failed — distinct from an empty list, which means
  /// the user genuinely owes nothing there.
  final List<PendingAction>? actions;
}
