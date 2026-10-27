import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../../domain/entities/escrow_deal_entity.dart';
import '../../domain/entities/escrow_offer_entity.dart';
import '../../domain/repositories/escrow_repository.dart';
import 'escrow_session_store.dart';

part 'escrow_state.dart';

/// Strips the noisy "Exception: " / gRPC envelope from an error so the UI shows
/// the human-readable service message.
String _clean(Object e) {
  var s = e.toString();
  s = s.replaceAll('Exception: ', '');
  final idx = s.indexOf('message: ');
  if (idx >= 0) s = s.substring(idx + 'message: '.length);
  return s.trim().isEmpty
      ? 'Something went wrong. Please try again.'
      : s.trim();
}

class EscrowCubit extends Cubit<EscrowState> {
  final EscrowRepository repository;
  final GrpcClient grpcClient;

  EscrowCubit({required this.repository, required this.grpcClient})
      : super(const EscrowInitial());

  String _currentUserId = '';

  Future<String> _userId() async {
    if (_currentUserId.isNotEmpty) return _currentUserId;
    _currentUserId = (await grpcClient.getCurrentUserId()) ?? '';
    return _currentUserId;
  }

  /// Load the caller's deals. role: "", "buyer", "seller".
  /// Rows per page, for EVERY paged list in EscrowPay.
  ///
  /// FIVE, not twenty. A deal card is tall — parties, amount, state, the
  /// action it is waiting on — so twenty of them is a long scroll with a
  /// pager at the bottom nobody reaches, which is the worst of both designs:
  /// the cost of pagination without its benefit. Five is about one screen, so
  /// the numbered bar is visible with the list and paging is a tap rather
  /// than a scroll-then-tap.
  ///
  /// One constant for deals AND offers: two lists that page differently in
  /// the same feature is a detail the user has to notice.
  static const int dealsPageSize = 5;

  /// Alias for readability at the offers call sites. Same number on purpose.
  static const int offersPageSize = dealsPageSize;

  /// The next page, fetched in the background after the current one lands.
  /// Keyed by (role, status, page) so a filter change cannot serve a page
  /// prefetched for a different list — the bug that makes prefetching worse
  /// than not prefetching.
  String? _prefetchKey;
  EscrowDealsPage? _prefetched;

  String _key(String role, String status, int page) => '$role|$status|$page';

  Future<void> loadDeals({
    String role = '',
    String status = '',
    int page = 1,
  }) async {
    // A page change keeps the current list visible and flags it loading; a
    // first load paints the page one a previous open stored for this user
    // and (role, status), or the shimmer when there is none.
    final current = state;
    final scope = escrowDealsScope(role, status);
    // The store stamp is the signed-in user; the cubit's own id (resolved
    // from the gRPC session below) is used once known so the two agree.
    final sessionUid =
        _currentUserId.isNotEmpty ? _currentUserId : SessionUserId.current();
    var paintedCached = false;
    if (current is EscrowDealsLoaded && page != current.page) {
      emit(current.copyWith(pageLoading: true));
    } else {
      final cached = page == 1
          ? escrowDealsPageStore
              .peek(userId: sessionUid, scope: scope)
              ?.firstOrNull
          : null;
      if (cached != null) {
        paintedCached = true;
        emit(EscrowDealsLoaded(
          cached.items,
          sessionUid,
          page: cached.page,
          totalPages: cached.totalPages,
        ));
      } else {
        emit(const EscrowLoading());
      }
    }
    try {
      final uid = await _userId();

      // Serve the prefetch when it is for exactly this list and page.
      EscrowDealsPage result;
      final want = _key(role, status, page);
      final hit = _prefetched;
      if (hit != null && _prefetchKey == want) {
        result = hit;
      } else {
        result = await repository.listMyDealsPaged(
            role: role, status: status, page: page, limit: dealsPageSize);
      }
      _prefetched = null;
      _prefetchKey = null;

      if (result.page == 1) {
        escrowDealsPageStore.put([result], userId: uid, scope: scope);
      }
      emit(EscrowDealsLoaded(
        result.items,
        uid,
        page: result.page,
        totalPages: result.totalPages,
      ));

      // Warm the next page AFTER emitting, so it never delays what the user
      // asked for. Failures are swallowed: a prefetch that cannot run is a
      // missed optimisation, not an error anyone should see.
      if (result.page < result.totalPages) {
        final nextPage = result.page + 1;
        unawaited(repository
            .listMyDealsPaged(
                role: role,
                status: status,
                page: nextPage,
                limit: dealsPageSize)
            .then((p) {
          _prefetched = p;
          _prefetchKey = _key(role, status, nextPage);
        }).catchError((_) {
          _prefetched = null;
          _prefetchKey = null;
          return;
        }));
      }
    } catch (e) {
      // A failed refresh behind a painted page keeps the page on screen.
      if (paintedCached) return;
      emit(EscrowError(_clean(e)));
    }
  }

  /// Statuses that mean a deal reached its end, whichever way it ended.
  ///
  /// Kept here beside the query that uses it, and deliberately the same set
  /// [EscrowDealEntity.isReleased] and `.isRefunded` recognise.
  static const String _terminalStatuses =
      'RELEASED,RESOLVED_RELEASED,REFUNDED,RESOLVED_REFUNDED,CANCELLED';

  /// Whether this user has EVER finished an escrow deal.
  ///
  /// Asks the server for one terminal-status row rather than inspecting the
  /// loaded list. The list is one page and is filtered by whatever chip is
  /// selected, so reading experience off it got the answer wrong two ways:
  /// a user whose completed deals sit on page 2+ looked new, and so did one
  /// who happened to arrive with the "In escrow" filter applied, because a
  /// filtered page contains no completed deals by construction.
  ///
  /// Cheap: `limit: 1`, and the `(user_id, status, created_at DESC)` index
  /// covers it. Returns false on failure — showing the terms to someone who
  /// has already seen them is a far smaller harm than hiding them from
  /// someone who never has, so this fails toward disclosure.
  Future<bool> hasCompletedAnyDeal() async {
    try {
      final page = await repository.listMyDealsPaged(
        status: _terminalStatuses,
        page: 1,
        limit: 1,
      );
      return page.total > 0 || page.items.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> loadDeal(String dealId) async {
    emit(const EscrowLoading());
    try {
      final uid = await _userId();
      final deal = await repository.getDeal(dealId);
      emit(EscrowDealLoaded(deal, uid));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Fee preview — emits EscrowFeeQuoted without disturbing list/detail state.
  Future<EscrowFeeQuote?> quoteFee(double amount,
      {String currency = 'NGN', String offerId = ''}) async {
    try {
      final q = await repository.quoteFee(
          amount: amount, currency: currency, offerId: offerId);
      emit(EscrowFeeQuoted(q));
      return q;
    } catch (_) {
      return null;
    }
  }

  Future<EscrowDealEntity?> createDeal({
    required String buyerAccountId,
    required String sellerQuery,
    required String title,
    String description = '',
    required double amount,
    int deadlineDays = 0,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String buyerItemImageUrl = '',
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.createDeal(
        buyerAccountId: buyerAccountId,
        sellerQuery: sellerQuery,
        title: title,
        description: description,
        amount: amount,
        deadlineDays: deadlineDays,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        buyerItemImageUrl: buyerItemImageUrl,
      );
      emit(EscrowActionSuccess('Deal funded and created', deal));
      return deal;
    } catch (e) {
      emit(EscrowError(_clean(e)));
      return null;
    }
  }

  Future<void> markDelivered({
    required String dealId,
    String deliveryNote = '',
    String sellerProofImageUrl = '',
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.markDelivered(
        dealId: dealId,
        deliveryNote: deliveryNote,
        sellerProofImageUrl: sellerProofImageUrl,
      );
      emit(EscrowActionSuccess('Marked as delivered', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<EscrowDealEntity?> validateRelease({
    required String dealId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.validateRelease(
        dealId: dealId,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      emit(EscrowActionSuccess('Funds released to seller', deal));
      return deal;
    } catch (e) {
      emit(EscrowError(_clean(e)));
      return null;
    }
  }

  Future<void> cancelDeal(
      {required String dealId,
      String reason = '',
      required String idempotencyKey}) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.cancelDeal(
          dealId: dealId, reason: reason, idempotencyKey: idempotencyKey);
      emit(EscrowActionSuccess('Deal cancelled and refunded', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<void> openDispute(
      {required String dealId,
      required String reason,
      String evidenceUrl = ''}) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.openDispute(
          dealId: dealId, reason: reason, evidenceUrl: evidenceUrl);
      emit(
          EscrowActionSuccess('Dispute opened. Our team will review it', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Attach an already-uploaded piece of media to a deal. Best effort: returns
  /// false on failure so callers can keep going without breaking the main flow.
  /// Does NOT emit state, so it never disturbs an in-flight action.
  Future<bool> addAttachment({
    required String dealId,
    required String purpose,
    required String mediaKind,
    required String url,
    String contentType = '',
    int sizeBytes = 0,
    int durationSeconds = 0,
  }) async {
    try {
      await repository.addAttachment(
        dealId: dealId,
        purpose: purpose,
        mediaKind: mediaKind,
        url: url,
        contentType: contentType,
        sizeBytes: sizeBytes,
        durationSeconds: durationSeconds,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Buyer asks for a refund after delivery.
  Future<void> requestRefund(
      {required String dealId, required String reason}) async {
    emit(const EscrowActionInProgress());
    try {
      final deal =
          await repository.requestRefund(dealId: dealId, reason: reason);
      emit(EscrowActionSuccess(
          'Refund requested. We let the seller know', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Seller accepts or declines a pending refund request.
  Future<void> respondRefund(
      {required String dealId, required bool accept, String note = ''}) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.respondRefund(
          dealId: dealId, accept: accept, note: note);
      emit(EscrowActionSuccess(
        accept ? 'Refund sent to the buyer' : 'Sent to our team to review',
        deal,
      ));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  // ── Two-sided offers (money-free agreement phase before funding) ──

  /// The next offers page, fetched in the background after the current one
  /// lands. Keyed exactly like the deals prefetch, so a role or status change
  /// cannot serve a page fetched for a different list.
  String? _offersPrefetchKey;
  EscrowOffersPage? _offersPrefetched;

  Future<void> loadOffers({
    String role = '',
    String status = '',
    int page = 1,
  }) async {
    // A page change keeps the current list visible and flags it loading; a
    // first load has nothing to keep, so it shows the shimmer.
    final current = state;
    if (current is EscrowOffersLoaded && page != current.page) {
      emit(current.copyWith(pageLoading: true));
    } else {
      emit(const EscrowLoading());
    }
    try {
      final uid = await _userId();

      // Serve the prefetch when it is for exactly this list and page.
      EscrowOffersPage result;
      final want = _key(role, status, page);
      final hit = _offersPrefetched;
      if (hit != null && _offersPrefetchKey == want) {
        result = hit;
      } else {
        result = await repository.listMyOffersPaged(
            role: role, status: status, page: page, limit: offersPageSize);
      }
      _offersPrefetched = null;
      _offersPrefetchKey = null;

      emit(EscrowOffersLoaded(
        result.items,
        uid,
        page: result.page,
        totalPages: result.totalPages,
      ));

      // Warm the next page AFTER emitting, so it never delays what the user
      // asked for. Failures are swallowed: a prefetch that cannot run is a
      // missed optimisation, not an error anyone should see.
      if (result.page < result.totalPages) {
        final nextPage = result.page + 1;
        unawaited(repository
            .listMyOffersPaged(
                role: role,
                status: status,
                page: nextPage,
                limit: offersPageSize)
            .then((p) {
          _offersPrefetched = p;
          _offersPrefetchKey = _key(role, status, nextPage);
        }).catchError((_) {
          _offersPrefetched = null;
          _offersPrefetchKey = null;
          return;
        }));
      }
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<void> loadOffer(String offerId) async {
    emit(const EscrowLoading());
    try {
      final uid = await _userId();
      final offer = await repository.getOffer(offerId);
      emit(EscrowOfferLoaded(offer, uid));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Resolve a share link (deep link entry — any signed-in user).
  Future<void> loadOfferByShareToken(String shareToken) async {
    emit(const EscrowLoading());
    try {
      final uid = await _userId();
      final offer = await repository.getOfferByShareToken(shareToken);
      emit(EscrowOfferLoaded(offer, uid));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Surface a load failure for a malformed/empty deep link — the view then
  /// shows its "not available" state instead of an endless spinner.
  void failOfferLoad(String message) => emit(EscrowError(message));

  /// Publish an offer. NO PIN — money-free; returns the offer (with its share
  /// token) so the success screen can offer the link, or null on failure.
  Future<EscrowOfferEntity?> createOffer({
    required String direction,
    String counterpartyQuery = '',
    required String title,
    String description = '',
    required double amount,
    String currency = 'NGN',
    String feePayerPreference = '',
    int deliveryDeadlineDays = 0,
    String condition = '',
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final offer = await repository.createOffer(
        direction: direction,
        counterpartyQuery: counterpartyQuery,
        title: title,
        description: description,
        amount: amount,
        currency: currency,
        feePayerPreference: feePayerPreference,
        deliveryDeadlineDays: deliveryDeadlineDays,
        condition: condition,
      );
      emit(EscrowOfferActionSuccess('Offer published', offer));
      return offer;
    } catch (e) {
      emit(EscrowError(_clean(e)));
      return null;
    }
  }

  Future<void> respondOffer(
      {required String offerId, required bool accept, String note = ''}) async {
    emit(const EscrowActionInProgress());
    try {
      final offer = await repository.respondOffer(
          offerId: offerId, accept: accept, note: note);
      emit(EscrowOfferActionSuccess(
        accept ? 'Accepted, waiting for the buyer to fund' : 'Offer declined',
        offer,
      ));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<void> cancelOffer(String offerId) async {
    emit(const EscrowActionInProgress());
    try {
      final offer = await repository.cancelOffer(offerId);
      emit(EscrowOfferActionSuccess('Offer withdrawn', offer));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Fund an agreed offer — THE money movement. Produces a funded DEAL, so it
  /// emits [EscrowActionSuccess] and rides the existing receipt routing.
  Future<EscrowDealEntity?> fundOffer({
    required String offerId,
    required String buyerAccountId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.fundOffer(
        offerId: offerId,
        buyerAccountId: buyerAccountId,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      emit(EscrowActionSuccess('Deal funded and created', deal));
      return deal;
    } catch (e) {
      emit(EscrowError(_clean(e)));
      return null;
    }
  }

  /// Attach listing media to an offer. Best effort, mirrors addAttachment.
  Future<bool> addOfferAttachment({
    required String offerId,
    required String mediaKind,
    required String url,
    String contentType = '',
    int sizeBytes = 0,
    int durationSeconds = 0,
  }) async {
    try {
      await repository.addOfferAttachment(
        offerId: offerId,
        mediaKind: mediaKind,
        url: url,
        contentType: contentType,
        sizeBytes: sizeBytes,
        durationSeconds: durationSeconds,
      );
      return true;
    } catch (_) {
      return false;
    }
  }
}
