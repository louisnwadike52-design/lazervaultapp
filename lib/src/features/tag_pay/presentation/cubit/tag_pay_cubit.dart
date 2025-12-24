import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(TagPayLoading());
      final result = await repository.createTagPay(
        tagPay: tagPay,
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
      emit(TagPayLoaded(result));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getTagPay(String tagPay) async {
    try {
      emit(TagPayLoading());
      final result = await repository.getTagPay(tagPay);
      if (result != null) {
        emit(TagPayLoaded(result));
      } else {
        emit(const TagPayError('Tag pay not found'));
      }
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> checkAvailability(String tagPay) async {
    try {
      emit(TagPayLoading());
      final result = await repository.checkTagPayAvailability(tagPay);
      emit(TagPayAvailabilityChecked(
        available: result['available'] as bool,
        message: result['message'] as String,
        suggestions: (result['suggestions'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
      ));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> searchTagPay(String query, {int limit = 20}) async {
    try {
      emit(TagPayLoading());
      final results = await repository.searchTagPay(query, limit: limit);
      emit(TagPaySearchResults(results));
    } catch (e) {
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
      emit(TagPayLoading());
      final transaction = await repository.sendMoney(
        receiverTagPay: receiverTagPay,
        amount: amount,
        currency: currency,
        description: description,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
      );
      emit(MoneyTransferSuccess(
        transaction: transaction,
        message: 'Money sent successfully',
      ));
    } catch (e) {
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
      emit(TagPayLoading());
      final request = await repository.requestMoney(
        requesteeTagPay: requesteeTagPay,
        amount: amount,
        currency: currency,
        description: description,
      );
      emit(MoneyRequestSuccess(
        request: request,
        message: 'Money request sent successfully',
      ));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getTransactions({int page = 1, int limit = 20}) async {
    try {
      emit(TagPayLoading());
      final transactions = await repository.getTransactions(
        page: page,
        limit: limit,
      );
      emit(TagPayTransactionsLoaded(transactions));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getPendingRequests({
    int page = 1,
    int limit = 20,
    bool incoming = true,
  }) async {
    try {
      emit(TagPayLoading());
      final requests = await repository.getPendingMoneyRequests(
        page: page,
        limit: limit,
        incoming: incoming,
      );
      emit(MoneyRequestsLoaded(requests));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> acceptMoneyRequest({
    required String requestId,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    try {
      emit(TagPayLoading());
      final transaction = await repository.acceptMoneyRequest(
        requestId: requestId,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
      );
      emit(MoneyTransferSuccess(
        transaction: transaction,
        message: 'Money request accepted',
      ));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> declineMoneyRequest({
    required String requestId,
    String? reason,
  }) async {
    try {
      emit(TagPayLoading());
      await repository.declineMoneyRequest(
        requestId: requestId,
        reason: reason,
      );
      // Refresh pending requests after declining
      await getPendingRequests();
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyTagPay({String? username}) async {
    try {
      emit(TagPayLoading());

      // If username is provided, fetch the tag pay from backend by username
      if (username != null && username.isNotEmpty) {
        final tagPay = await repository.getTagPay(username);
        if (tagPay != null) {
          emit(TagPayLoaded(tagPay));
        } else {
          emit(const TagPayError('No username set. Please set a username in your profile.'));
        }
      } else {
        emit(const TagPayError('No username set. Please set a username in your profile.'));
      }
    } catch (e) {
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
      emit(TagPayLoading());
      final tag = await repository.createTag(
        taggedUserTagPay: taggedUserTagPay,
        amount: amount,
        currency: currency,
        description: description,
      );
      emit(TagCreatedSuccess(
        tag: tag,
        message: 'Tagged ${tag.taggedUserName} with $currency ${amount.toStringAsFixed(2)}',
      ));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyTags({int page = 1, int limit = 20}) async {
    try {
      emit(TagPayLoading());
      final tags = await repository.getMyTags(page: page, limit: limit);
      emit(MyTagsLoaded(tags));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyOutgoingTags({int page = 1, int limit = 20}) async {
    try {
      emit(TagPayLoading());
      final tags = await repository.getMyOutgoingTags(page: page, limit: limit);
      emit(MyOutgoingTagsLoaded(tags));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> getMyIncomingTags({int page = 1, int limit = 20}) async {
    try {
      emit(TagPayLoading());
      final tags = await repository.getMyIncomingTags(page: page, limit: limit);
      emit(MyIncomingTagsLoaded(tags));
    } catch (e) {
      emit(TagPayError(e.toString()));
    }
  }

  Future<void> payTag({
    required String tagId,
    required String sourceAccountId,
  }) async {
    try {
      print('🏷️ [TagPayCubit] Starting payTag - tagId: $tagId, accountId: $sourceAccountId');
      emit(TagPayLoading());
      final transaction = await repository.payTag(
        tagId: tagId,
        sourceAccountId: sourceAccountId,
      );
      print('✅ [TagPayCubit] Tag payment successful - transaction ID: ${transaction.id}');
      emit(TagPaidSuccess(
        transaction: transaction,
        message: 'Tag paid successfully!',
      ));
    } catch (e) {
      print('❌ [TagPayCubit] Tag payment failed: $e');
      emit(TagPayError(e.toString()));
    }
  }

  Future<List<UserSearchResultEntity>> searchUsers(String query, {int limit = 10}) async {
    return await repository.searchUsers(query: query, limit: limit);
  }
}
