import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/offline/mutation_queue.dart';
import '../../../../../core/offline/mutation.dart';
import 'package:lazervault/core/utils/grpc_error_handler.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
import 'package:lazervault/src/core/errors/grpc_exceptions.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../domain/repositories/tag_pay_repository.dart';
import '../../domain/entities/user_search_result_entity.dart';
import 'tag_pay_state.dart';

class TagPayCubit extends Cubit<TagPayState> {
  final TagPayRepository repository;
  final MutationQueue? mutationQueue;

  TagPayCubit({
    required this.repository,
    this.mutationQueue,
  }) : super(TagPayInitial());

  /// The one line shown when a money call's outcome is UNKNOWN rather than
  /// failed. Deliberately not a "try again": with no client idempotency key on
  /// the TagPay money RPCs, a second attempt is a second debit request, so the
  /// user must be able to see whether the first one landed before deciding.
  static const String _indeterminatePaymentMessage =
      'This is taking longer than expected. Your payment may still have gone '
      'through — check your transaction history before trying again.';

  /// Check if an error is a network-related error that should trigger offline queuing
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    // Also handle string errors that indicate network issues. The repository
    // maps a gRPC error through mapGrpcError before it reaches us, so what
    // actually arrives here for a deadline is the NetworkException text
    // "Request timed out" — which matched none of these substrings ('timeout'
    // is not 'timed out'), silently demoting a timeout to the generic
    // "Something went wrong" line. Match the string the mapper really emits.
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('timed out') ||
        errorStr.contains('deadline') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  /// True when the call reached the server and we gave up waiting, as opposed
  /// to never having got out of the device. The distinction is the whole point
  /// on a money call: "no connection" means nothing was charged and retrying is
  /// safe, while a deadline means the outcome is genuinely unknown.
  bool _isTimeoutError(dynamic error) {
    if (error is GrpcError) return error.code == StatusCode.deadlineExceeded;
    if (error is TimeoutException) return true;
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('timed out') ||
        errorStr.contains('timeout') ||
        errorStr.contains('deadline');
  }

  /// Error state for a transport-level failure on a MONEY-MOVING call, or null
  /// if the failure was not transport-level (caller falls back to its own
  /// mapping). Money calls may not reuse the ordinary "try again" copy: an
  /// unknown outcome has to be resolved by looking, not by paying twice.
  TagPayError? _moneyTransportError(dynamic error) {
    if (_isTimeoutError(error)) {
      return const TagPayError(
        _indeterminatePaymentMessage,
        isRetryable: false,
        isIndeterminate: true,
      );
    }
    if (_isNetworkError(error)) {
      return const TagPayError(
        'No internet connection. Please check your network and try again.',
        isRetryable: true,
      );
    }
    return null;
  }

  Future<void> createTagPay({
    required String tagPay,
    required String displayName,
    String? avatarUrl,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.createTagPay(
        tagPay: tagPay,
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
      if (isClosed) return;
      emit(TagPayLoaded(result));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getTagPay(String tagPay) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.getTagPay(tagPay);
      if (result != null) {
        if (isClosed) return;
        emit(TagPayLoaded(result));
      } else {
        if (isClosed) return;
        emit(const TagPayError('Tag pay not found'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> checkAvailability(String tagPay) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.checkTagPayAvailability(tagPay);
      if (isClosed) return;
      emit(TagPayAvailabilityChecked(
        available: result['available'] as bool,
        message: result['message'] as String,
        suggestions: (result['suggestions'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> searchTagPay(String query, {int limit = 20}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final results = await repository.searchTagPay(query, limit: limit);
      if (isClosed) return;
      emit(TagPaySearchResults(results));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> sendMoney({
    required String receiverTagPay,
    required double amount,
    required String currency,
    String? description,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final transaction = await repository.sendMoney(
        receiverTagPay: receiverTagPay,
        amount: amount,
        currency: currency,
        description: description,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
      );
      if (isClosed) return;
      emit(MoneyTransferSuccess(
        transaction: transaction,
        message: 'Money sent successfully',
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      final pinFailure = GrpcErrorHandler.extractPinFailure(e);
      if (pinFailure != null) {
        emit(TagPayPinFailure(pinInfo: pinFailure));
      } else {
        // Transport failure first: GrpcErrorHandler marks a deadline retryable,
        // which is right for a read and wrong for a debit.
        emit(_moneyTransportError(e) ??
            TagPayError(
              GrpcErrorHandler.userFriendlyMessage(e),
              isRetryable: GrpcErrorHandler.isRetryable(e),
            ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(_moneyTransportError(e) ?? TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> requestMoney({
    required String requesteeTagPay,
    required double amount,
    required String currency,
    String? description,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final request = await repository.requestMoney(
        requesteeTagPay: requesteeTagPay,
        amount: amount,
        currency: currency,
        description: description,
      );
      if (isClosed) return;
      emit(MoneyRequestSuccess(
        request: request,
        message: 'Money request sent successfully',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getTransactions({int page = 1, int limit = 20}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final transactions = await repository.getTransactions(
        page: page,
        limit: limit,
      );
      if (isClosed) return;
      emit(TagPayTransactionsLoaded(transactions));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getPendingRequests({
    int page = 1,
    int limit = 20,
    bool incoming = true,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final requests = await repository.getPendingMoneyRequests(
        page: page,
        limit: limit,
        incoming: incoming,
      );
      if (isClosed) return;
      emit(MoneyRequestsLoaded(requests));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> acceptMoneyRequest({
    required String requestId,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final transaction = await repository.acceptMoneyRequest(
        requestId: requestId,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
      );
      if (isClosed) return;
      emit(MoneyTransferSuccess(
        transaction: transaction,
        message: 'Money request accepted',
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      final pinFailure = GrpcErrorHandler.extractPinFailure(e);
      if (pinFailure != null) {
        emit(TagPayPinFailure(pinInfo: pinFailure));
      } else {
        // Accepting a request debits this user — same indeterminate-outcome
        // rule as sendMoney/payTag.
        emit(_moneyTransportError(e) ??
            TagPayError(
              GrpcErrorHandler.userFriendlyMessage(e),
              isRetryable: GrpcErrorHandler.isRetryable(e),
            ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(_moneyTransportError(e) ?? TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> declineMoneyRequest({
    required String requestId,
    String? reason,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      await repository.declineMoneyRequest(
        requestId: requestId,
        reason: reason,
      );
      // Refresh pending requests after declining
      await getPendingRequests();
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getMyTagPay({String? username}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());

      // If username is provided, fetch the tag pay from backend by username
      if (username != null && username.isNotEmpty) {
        final tagPay = await repository.getTagPay(username);
        if (tagPay != null) {
          if (isClosed) return;
          emit(TagPayLoaded(tagPay));
        } else {
          if (isClosed) return;
          emit(const TagPayError(
              'No username set. Please set a username in your profile.'));
        }
      } else {
        if (isClosed) return;
        emit(const TagPayError(
            'No username set. Please set a username in your profile.'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> createTag({
    required String taggedUserTagPay,
    required double amount,
    required String currency,
    String? description,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final tag = await repository.createTag(
        taggedUserTagPay: taggedUserTagPay,
        amount: amount,
        currency: currency,
        description: description,
      );
      if (isClosed) return;
      emit(TagCreatedSuccess(
        tag: tag,
        message:
            'Tagged ${tag.taggedUserName} with $currency ${amount.toStringAsFixed(2)}',
      ));
    } catch (e) {
      if (isClosed) return;

      // Check if this is a network error and we can queue for offline retry.
      // A timeout is excluded: the create may already have landed server-side,
      // and replaying it would produce a duplicate tag. Only a request that
      // never left the device is safe to queue.
      if (_isNetworkError(e) && !_isTimeoutError(e) && mutationQueue != null) {
        print(
            '📴 [TagPayCubit] Network error detected, queuing tag creation for offline retry');
        try {
          final mutation = await mutationQueue!.enqueue(QueuedMutation.create(
            type: MutationType.tagCreation,
            payload: {
              'taggedUserTagPay': taggedUserTagPay,
              'amount': amount,
              'currency': currency,
              'description': description,
            },
          ));
          emit(TagCreationQueued(
            taggedUserTagPay: taggedUserTagPay,
            amount: amount,
            currency: currency,
            message:
                'Tag creation queued. Will retry when you\'re back online.',
            mutationId: mutation?.id,
          ));
          return;
        } catch (queueError) {
          print('❌ [TagPayCubit] Failed to queue tag creation: $queueError');
          // Fall through to emit regular error
        }
      }

      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getMyTags({int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result =
          await repository.getMyTags(page: page, limit: limit, status: status);
      if (isClosed) return;
      emit(MyTagsLoaded(result.tags));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getMyOutgoingTags(
      {int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.getMyOutgoingTags(
          page: page, limit: limit, status: status);
      if (isClosed) return;
      emit(MyOutgoingTagsLoaded(result.tags,
          total: result.total,
          page: result.page,
          totalPages: result.totalPages));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> getMyIncomingTags(
      {int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.getMyIncomingTags(
          page: page, limit: limit, status: status);
      if (isClosed) return;
      emit(MyIncomingTagsLoaded(result.tags,
          total: result.total,
          page: result.page,
          totalPages: result.totalPages));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<void> payTag({
    required String tagId,
    required String sourceAccountId,
    String? transactionPin,
  }) async {
    try {
      print(
          '🏷️ [TagPayCubit] Starting payTag - tagId: $tagId, accountId: $sourceAccountId');
      if (isClosed) return;
      emit(TagPayLoading());
      final transaction = await repository.payTag(
        tagId: tagId,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin ?? '',
      );
      print(
          '✅ [TagPayCubit] Tag payment successful - transaction ID: ${transaction.id}');
      if (isClosed) return;
      emit(TagPaidSuccess(
        transaction: transaction,
        message: 'Tag paid successfully!',
      ));
    } on GrpcError catch (e) {
      print('❌ [TagPayCubit] Tag payment failed: $e');
      if (isClosed) return;

      // Check for PIN-specific failure first
      final pinFailure = GrpcErrorHandler.extractPinFailure(e);
      if (pinFailure != null) {
        emit(TagPayPinFailure(pinInfo: pinFailure));
      } else {
        // Transport failure first: GrpcErrorHandler marks a deadline retryable,
        // which is right for a read and wrong for a debit.
        emit(_moneyTransportError(e) ??
            TagPayError(
              GrpcErrorHandler.userFriendlyMessage(e),
              isRetryable: GrpcErrorHandler.isRetryable(e),
            ));
      }
    } catch (e) {
      print('❌ [TagPayCubit] Tag payment failed: $e');
      if (isClosed) return;

      // For financial operations, show clear error and let user retry manually
      // NEVER queue payments offline - security tokens expire, balances change.
      // A deadline is separated out from "no connection" inside
      // _moneyTransportError: a payment we stopped waiting on may have settled,
      // so it must not be presented as a failure the user can just repeat.
      emit(_moneyTransportError(e) ?? TagPayError(_friendlyMessage(e)));
    }
  }

  /// Withdraw a tag this user raised. Tagger-only, pending-only server-side.
  Future<void> cancelTag({
    required String tagId,
    String? reason,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final tag = await repository.cancelTag(tagId: tagId, reason: reason);
      if (isClosed) return;
      emit(TagLifecycleSuccess(
        tag: tag,
        message: 'Tag cancelled',
        wasCancelled: true,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_lifecycleMessage(e)));
    }
  }

  /// Refuse a tag raised against this user. Tagged-user-only, pending-only.
  Future<void> declineTag({
    required String tagId,
    String? reason,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final tag = await repository.declineTag(tagId: tagId, reason: reason);
      if (isClosed) return;
      emit(TagLifecycleSuccess(
        tag: tag,
        message: 'Tag declined',
        wasCancelled: false,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_lifecycleMessage(e)));
    }
  }

  Future<void> batchCreateTags({
    required List<String> taggedUserTagPays,
    required double amount,
    required String currency,
    String? description,
  }) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final tags = await repository.batchCreateTags(
        taggedUserTagPays: taggedUserTagPays,
        amount: amount,
        currency: currency,
        description: description,
      );
      if (isClosed) return;
      emit(BatchTagsCreatedSuccess(
        tags: tags,
        message: 'Created ${tags.length} tag(s)',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  Future<List<UserSearchResultEntity>> searchUsers(String query,
      {int limit = 10}) async {
    final q = normalizeLazerVaultUserSearchQuery(query);
    if (q.length < 2) {
      return [];
    }
    return repository.searchUsers(query: q, limit: limit);
  }

  /// Load home screen data: both incoming and outgoing tags for both tabs.
  /// Profile badge is read directly from ProfileCubit in the UI.
  Future<void> loadHomeData(
      {int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());

      final isPendingFilter = status == 'pending';

      // Load both incoming and outgoing tags in parallel for better UX
      final results = await Future.wait([
        repository.getMyIncomingTags(
          page: page,
          limit: limit,
          status: isPendingFilter ? null : status,
        ),
        repository.getMyOutgoingTags(
          page: page,
          limit: limit,
          status: isPendingFilter ? null : status,
        ),
      ]);

      final incomingResult = results[0];
      final outgoingResult = results[1];

      final incomingTags = isPendingFilter
          ? incomingResult.tags
              .where((t) => t.status == TagStatus.pending)
              .toList()
          : incomingResult.tags;

      final outgoingTags = isPendingFilter
          ? outgoingResult.tags
              .where((t) => t.status == TagStatus.pending)
              .toList()
          : outgoingResult.tags;

      if (isClosed) return;
      emit(TagPayHomeLoaded(
        incomingTags: incomingTags,
        incomingTotal: incomingResult.total,
        incomingPage: incomingResult.page,
        incomingTotalPages: incomingResult.totalPages,
        outgoingTags: outgoingTags,
        outgoingTotal: outgoingResult.total,
        outgoingPage: outgoingResult.page,
        outgoingTotalPages: outgoingResult.totalPages,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  /// Load incoming tags page (Received tab)
  Future<void> loadIncomingTagsPage(
      {int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      final currentState = state;
      if (currentState is! TagPayHomeLoaded) {
        emit(TagPayLoading());
      }

      final isPendingFilter = status == 'pending';
      final result = await repository.getMyIncomingTags(
        page: page,
        limit: limit,
        status: isPendingFilter ? null : status,
      );

      final tags = isPendingFilter
          ? result.tags.where((t) => t.status == TagStatus.pending).toList()
          : result.tags;

      if (isClosed) return;
      if (currentState is TagPayHomeLoaded) {
        emit(currentState.copyWith(
          incomingTags: tags,
          incomingTotal: result.total,
          incomingPage: result.page,
          incomingTotalPages: result.totalPages,
        ));
      } else {
        emit(TagPayHomeLoaded(
          incomingTags: tags,
          incomingTotal: result.total,
          incomingPage: result.page,
          incomingTotalPages: result.totalPages,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  /// Load outgoing tags page (Created tab)
  Future<void> loadOutgoingTagsPage(
      {int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      final currentState = state;
      if (currentState is! TagPayHomeLoaded) {
        emit(TagPayLoading());
      }

      final isPendingFilter = status == 'pending';
      final result = await repository.getMyOutgoingTags(
        page: page,
        limit: limit,
        status: isPendingFilter ? null : status,
      );

      final tags = isPendingFilter
          ? result.tags.where((t) => t.status == TagStatus.pending).toList()
          : result.tags;

      if (isClosed) return;
      if (currentState is TagPayHomeLoaded) {
        emit(currentState.copyWith(
          outgoingTags: tags,
          outgoingTotal: result.total,
          outgoingPage: result.page,
          outgoingTotalPages: result.totalPages,
        ));
      } else {
        emit(TagPayHomeLoaded(
          outgoingTags: tags,
          outgoingTotal: result.total,
          outgoingPage: result.page,
          outgoingTotalPages: result.totalPages,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(_friendlyMessage(e)));
    }
  }

  /// Status codes whose server message is the ANSWER, not noise: "tag is
  /// already paid", "only the tagger can cancel this tag", "reason is too
  /// long". On cancel/decline that sentence is the entire point of the
  /// response, so it must not be flattened into "Something went wrong".
  static const Set<int> _lifecycleServerMessageCodes = {
    3, // invalidArgument
    5, // notFound
    7, // permissionDenied
    9, // failedPrecondition
  };

  /// Like [_friendlyMessage], but keeps the server's wording for the refusals
  /// cancel/decline are expected to hit. [retryWithBackoff] has already turned
  /// most GrpcErrors into a [GrpcException] by the time we see them, which is
  /// why the plain mapper never reaches the message.
  String _lifecycleMessage(dynamic error) {
    if (error is GrpcError) {
      return GrpcErrorHandler.userFriendlyMessage(error);
    }
    if (error is GrpcException &&
        _lifecycleServerMessageCodes.contains(error.code) &&
        error.message.isNotEmpty) {
      return error.message;
    }
    return _friendlyMessage(error);
  }

  /// Convert any error to a user-friendly message.
  /// Uses [GrpcErrorHandler] for gRPC errors, generic fallback otherwise.
  String _friendlyMessage(dynamic error) {
    if (error is GrpcError) {
      return GrpcErrorHandler.userFriendlyMessage(error);
    }
    return 'Something went wrong. Please try again.';
  }
}
