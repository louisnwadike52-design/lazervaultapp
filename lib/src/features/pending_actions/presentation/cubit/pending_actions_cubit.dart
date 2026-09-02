import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/domain/repositories/tagged_invoice_repository.dart';
import 'package:lazervault/src/features/pending_actions/domain/pending_action.dart';
import 'package:lazervault/src/features/split_bills/domain/entities/split_bill_entity.dart';
import 'package:lazervault/src/features/split_bills/domain/repositories/split_bill_repository.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_tag_entity.dart';
import 'package:lazervault/src/features/tag_pay/domain/repositories/tag_pay_repository.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';

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
  })  : _tagPay = tagPayRepository,
        _invoices = invoiceRepository,
        _splitBills = splitBillRepository,
        super(const PendingActionsSnapshot());

  final TagPayRepository _tagPay;
  final TaggedInvoiceRepository _invoices;
  final SplitBillRepository _splitBills;

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

  Future<void> _refreshAll(String userId) async {
    final results = await Future.wait([
      _guard(PendingActionSource.tagPay, _loadTags),
      _guard(PendingActionSource.invoice, () => _loadInvoices(userId)),
      _guard(PendingActionSource.splitBill, () => _loadSplitBills(userId)),
    ]);

    final next = <PendingActionSource, List<PendingAction>>{};
    final stale = <PendingActionSource>{};
    for (final result in results) {
      final actions = result.actions;
      if (actions == null) {
        // Failed: retain whatever we last knew for this source.
        final previous = state.bySource[result.source];
        if (previous != null && previous.isNotEmpty) {
          next[result.source] = previous;
        }
        stale.add(result.source);
      } else if (actions.isNotEmpty) {
        next[result.source] = actions;
      }
    }

    _safeEmit(PendingActionsSnapshot(
      bySource: next,
      isLoading: false,
      fetchedAt: DateTime.now(),
      staleSources: stale,
    ));
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
  /// Two exclusions mirror the incoming-invoices screen exactly, and both are
  /// money-correctness rules rather than cosmetics: a QUOTE is a document, not
  /// a payable, until its creator converts it; and on a split invoice this
  /// user's own share may already be settled while the invoice as a whole is
  /// still pending for everyone else.
  Future<List<PendingAction>> _loadInvoices(String userId) async {
    final invoices = await _invoices.getIncomingTaggedInvoices(
      page: 1,
      limit: _perSourceLimit,
      statusFilter: InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING,
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
