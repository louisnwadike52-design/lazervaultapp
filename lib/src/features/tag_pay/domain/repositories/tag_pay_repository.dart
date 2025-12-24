import '../entities/tag_pay_entity.dart';
import '../entities/user_tag_entity.dart';
import '../entities/user_search_result_entity.dart';

abstract class TagPayRepository {
  /// Create or update a user's tag pay
  Future<TagPayEntity> createTagPay({
    required String tagPay,
    required String displayName,
    String? avatarUrl,
  });

  /// Get tag pay by username
  Future<TagPayEntity?> getTagPay(String tagPay);

  /// Check if tag pay is available
  Future<Map<String, dynamic>> checkTagPayAvailability(String tagPay);

  /// Search for users by tag pay
  Future<List<TagPayEntity>> searchTagPay(String query, {int limit = 20});

  /// Send money using tag pay
  Future<TagPayTransactionEntity> sendMoney({
    required String receiverTagPay,
    required double amount,
    required String currency,
    String? description,
    required String sourceAccountId,
    required String transactionPin,
  });

  /// Request money using tag pay
  Future<MoneyRequestEntity> requestMoney({
    required String requesteeTagPay,
    required double amount,
    required String currency,
    String? description,
  });

  /// Get tag pay transactions
  Future<List<TagPayTransactionEntity>> getTransactions({
    int page = 1,
    int limit = 20,
  });

  /// Accept money request
  Future<TagPayTransactionEntity> acceptMoneyRequest({
    required String requestId,
    required String sourceAccountId,
    required String transactionPin,
  });

  /// Decline money request
  Future<bool> declineMoneyRequest({
    required String requestId,
    String? reason,
  });

  /// Get pending money requests
  Future<List<MoneyRequestEntity>> getPendingMoneyRequests({
    int page = 1,
    int limit = 20,
    bool incoming = true,
  });

  /// Get user's tag pay (current user)
  Future<TagPayEntity?> getMyTagPay();

  /// Create a tag for another user
  Future<UserTagEntity> createTag({
    required String taggedUserTagPay,
    required double amount,
    required String currency,
    String? description,
  });

  /// Get all my tags (backward compatibility - returns outgoing tags)
  Future<List<UserTagEntity>> getMyTags({
    int page = 1,
    int limit = 20,
  });

  /// Get tags I created (I owe them money)
  Future<List<UserTagEntity>> getMyOutgoingTags({
    int page = 1,
    int limit = 20,
  });

  /// Get tags others created for me (they owe me money)
  Future<List<UserTagEntity>> getMyIncomingTags({
    int page = 1,
    int limit = 20,
  });

  /// Pay a specific tag (no PIN required for quick pay)
  Future<TagPayTransactionEntity> payTag({
    required String tagId,
    required String sourceAccountId,
  });

  /// Search users by username or name for tagging
  Future<List<UserSearchResultEntity>> searchUsers({
    required String query,
    int limit = 10,
  });
}
