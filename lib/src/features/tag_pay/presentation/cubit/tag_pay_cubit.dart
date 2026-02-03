import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../domain/repositories/tag_pay_repository.dart';
import '../../domain/entities/user_search_result_entity.dart';
import 'tag_pay_state.dart';

class TagPayCubit extends Cubit<TagPayState> {
  final TagPayRepository repository;

  TagPayCubit({required this.repository}) : super(TagPayInitial());

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
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
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
          emit(const TagPayError('No username set. Please set a username in your profile.'));
        }
      } else {
        if (isClosed) return;
        emit(const TagPayError('No username set. Please set a username in your profile.'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
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
        message: 'Tagged ${tag.taggedUserName} with $currency ${amount.toStringAsFixed(2)}',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyTags({int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.getMyTags(page: page, limit: limit, status: status);
      if (isClosed) return;
      emit(MyTagsLoaded(result.tags));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyOutgoingTags({int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.getMyOutgoingTags(page: page, limit: limit, status: status);
      if (isClosed) return;
      emit(MyOutgoingTagsLoaded(result.tags, total: result.total, page: result.page, totalPages: result.totalPages));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyIncomingTags({int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());
      final result = await repository.getMyIncomingTags(page: page, limit: limit, status: status);
      if (isClosed) return;
      emit(MyIncomingTagsLoaded(result.tags, total: result.total, page: result.page, totalPages: result.totalPages));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> payTag({
    required String tagId,
    required String sourceAccountId,
    String? transactionPin,
  }) async {
    try {
      print('🏷️ [TagPayCubit] Starting payTag - tagId: $tagId, accountId: $sourceAccountId');
      if (isClosed) return;
      emit(TagPayLoading());
      final transaction = await repository.payTag(
        tagId: tagId,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin ?? '',
      );
      print('✅ [TagPayCubit] Tag payment successful - transaction ID: ${transaction.id}');
      if (isClosed) return;
      emit(TagPaidSuccess(
        transaction: transaction,
        message: 'Tag paid successfully!',
      ));
    } catch (e) {
      print('❌ [TagPayCubit] Tag payment failed: $e');
      if (isClosed) return;
      emit(TagPayError(e.toString()));
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
      emit(TagPayError(e.toString()));
    }
  }

  Future<List<UserSearchResultEntity>> searchUsers(String query, {int limit = 10}) async {
    return await repository.searchUsers(query: query, limit: limit);
  }

  /// Load home screen data: incoming tags for default tab.
  /// Profile badge is read directly from ProfileCubit in the UI.
  Future<void> loadHomeData({int page = 1, int limit = 20, String? status}) async {
    try {
      if (isClosed) return;
      emit(TagPayLoading());

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
      emit(TagPayHomeLoaded(
        incomingTags: tags,
        incomingTotal: result.total,
        incomingPage: result.page,
        incomingTotalPages: result.totalPages,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(TagPayError(e.toString()));
    }
  }

  /// Load incoming tags page (Received tab)
  Future<void> loadIncomingTagsPage({int page = 1, int limit = 20, String? status}) async {
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
      emit(TagPayError(e.toString()));
    }
  }

  /// Load outgoing tags page (Created tab)
  Future<void> loadOutgoingTagsPage({int page = 1, int limit = 20, String? status}) async {
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
      emit(TagPayError(e.toString()));
    }
  }
}
