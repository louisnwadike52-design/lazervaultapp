import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/tag_pay.pb.dart' as pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_grpc;
import '../../domain/entities/tag_pay_entity.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../../domain/entities/user_search_result_entity.dart';
import '../../domain/repositories/tag_pay_repository.dart';

class TagPayRepositoryGrpcImpl implements TagPayRepository {
  final GrpcClient grpcClient;
  final auth_grpc.AuthServiceClient authServiceClient;
  final GrpcCallOptionsHelper callOptionsHelper;

  TagPayRepositoryGrpcImpl({
    required this.grpcClient,
    required this.authServiceClient,
    required this.callOptionsHelper,
  });

  @override
  Future<TagPayEntity> createTagPay({
    required String tagPay,
    required String displayName,
    String? avatarUrl,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreateTagPayRequest()
          ..tagPay = tagPay
          ..displayName = displayName;

        if (avatarUrl != null) {
          request.avatarUrl = avatarUrl;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.createTagPay(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _tagPayFromProto(response.tagPay);
      },
    );
  }

  @override
  Future<TagPayEntity?> getTagPay(String tagPay) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTagPayRequest()..tagPay = tagPay;
        final options = await grpcClient.callOptions;

        final response = await grpcClient.tagPayClient.getTagPay(
          request,
          options: options,
        );

        if (!response.success) {
          return null;
        }

        return _tagPayFromProto(response.tagPay);
      },
    );
  }

  @override
  Future<Map<String, dynamic>> checkTagPayAvailability(String tagPay) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CheckTagPayAvailabilityRequest()..tagPay = tagPay;
        final options = await grpcClient.callOptions;

        final response =
            await grpcClient.tagPayClient.checkTagPayAvailability(
          request,
          options: options,
        );

        return {
          'available': response.available,
          'message': response.message,
          'suggestions': response.suggestions,
        };
      },
    );
  }

  @override
  Future<List<TagPayEntity>> searchTagPay(String query,
      {int limit = 20}) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SearchTagPayRequest()
          ..query = query
          ..limit = limit;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.searchTagPay(
          request,
          options: options,
        );

        return response.results.map((ct) => _tagPayFromProto(ct)).toList();
      },
    );
  }

  @override
  Future<TagPayTransactionEntity> sendMoney({
    required String receiverTagPay,
    required double amount,
    required String currency,
    String? description,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.SendMoneyTagPayRequest()
          ..receiverTagPay = receiverTagPay
          ..amount = amount
          ..currency = currency
          ..sourceAccountId = sourceAccountId
          ..transactionPin = transactionPin;

        if (description != null) {
          request.description = description;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.sendMoneyTagPay(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _transactionFromProto(response.transaction);
      },
    );
  }

  @override
  Future<MoneyRequestEntity> requestMoney({
    required String requesteeTagPay,
    required double amount,
    required String currency,
    String? description,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.RequestMoneyTagPayRequest()
          ..requesteeTagPay = requesteeTagPay
          ..amount = amount
          ..currency = currency;

        if (description != null) {
          request.description = description;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.requestMoneyTagPay(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _moneyRequestFromProto(response.moneyRequest);
      },
    );
  }

  @override
  Future<List<TagPayTransactionEntity>> getTransactions({
    int page = 1,
    int limit = 20,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetTagPayTransactionsRequest()
          ..page = page
          ..limit = limit;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.getTagPayTransactions(
          request,
          options: options,
        );

        return response.transactions
            .map((txn) => _transactionFromProto(txn))
            .toList();
      },
    );
  }

  @override
  Future<TagPayTransactionEntity> acceptMoneyRequest({
    required String requestId,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.AcceptMoneyRequestRequest()
          ..requestId = requestId
          ..sourceAccountId = sourceAccountId
          ..transactionPin = transactionPin;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.acceptMoneyRequest(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _transactionFromProto(response.transaction);
      },
    );
  }

  @override
  Future<bool> declineMoneyRequest({
    required String requestId,
    String? reason,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.DeclineMoneyRequestRequest()..requestId = requestId;

        if (reason != null) {
          request.reason = reason;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.declineMoneyRequest(
          request,
          options: options,
        );

        return response.success;
      },
    );
  }

  @override
  Future<List<MoneyRequestEntity>> getPendingMoneyRequests({
    int page = 1,
    int limit = 20,
    bool incoming = true,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetPendingMoneyRequestsRequest()
          ..page = page
          ..limit = limit
          ..incoming = incoming;

        final options = await grpcClient.callOptions;
        final response =
            await grpcClient.tagPayClient.getPendingMoneyRequests(
          request,
          options: options,
        );

        return response.requests
            .map((req) => _moneyRequestFromProto(req))
            .toList();
      },
    );
  }

  @override
  Future<TagPayEntity?> getMyTagPay() async {
    // This will be retrieved from user profile or a separate endpoint
    // For now, return null - implement based on your auth system
    return null;
  }

  // Helper methods

  TagPayEntity _tagPayFromProto(pb.TagPay proto) {
    return TagPayEntity(
      id: proto.id,
      userId: proto.userId,
      tagPay: proto.tagPay,
      displayName: proto.displayName,
      avatarUrl: proto.avatarUrl.isNotEmpty ? proto.avatarUrl : null,
      isActive: proto.isActive,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  TagPayTransactionEntity _transactionFromProto(pb.TagPayTransaction proto) {
    return TagPayTransactionEntity(
      id: proto.id,
      senderId: proto.senderId,
      senderTagPay: proto.senderTagPay,
      senderName: proto.senderName,
      receiverId: proto.receiverId,
      receiverTagPay: proto.receiverTagPay,
      receiverName: proto.receiverName,
      amount: proto.amount,
      currency: proto.currency,
      description:
          proto.description.isNotEmpty ? proto.description : null,
      status: _transactionStatusFromProto(proto.status),
      type: _transactionTypeFromProto(proto.type),
      referenceNumber: proto.referenceNumber,
      createdAt: proto.createdAt.toDateTime(),
      completedAt: proto.hasCompletedAt() ? proto.completedAt.toDateTime() : null,
    );
  }

  MoneyRequestEntity _moneyRequestFromProto(pb.MoneyRequest proto) {
    return MoneyRequestEntity(
      id: proto.id,
      requesterId: proto.requesterId,
      requesterTagPay: proto.requesterTagPay,
      requesterName: proto.requesterName,
      requesteeId: proto.requesteeId,
      requesteeTagPay: proto.requesteeTagPay,
      requesteeName: proto.requesteeName,
      amount: proto.amount,
      currency: proto.currency,
      description: proto.description.isNotEmpty ? proto.description : null,
      status: _moneyRequestStatusFromProto(proto.status),
      createdAt: proto.createdAt.toDateTime(),
      respondedAt:
          proto.hasRespondedAt() ? proto.respondedAt.toDateTime() : null,
      expiresAt: proto.expiresAt.toDateTime(),
    );
  }

  TagPayTransactionStatus _transactionStatusFromProto(
      pb.TagPayTransactionStatus status) {
    switch (status) {
      case pb.TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_PENDING:
        return TagPayTransactionStatus.pending;
      case pb.TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_PROCESSING:
        return TagPayTransactionStatus.processing;
      case pb.TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_COMPLETED:
        return TagPayTransactionStatus.completed;
      case pb.TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_FAILED:
        return TagPayTransactionStatus.failed;
      case pb.TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_CANCELLED:
        return TagPayTransactionStatus.cancelled;
      case pb.TagPayTransactionStatus.TAG_PAY_TRANSACTION_STATUS_REFUNDED:
        return TagPayTransactionStatus.refunded;
      default:
        return TagPayTransactionStatus.pending;
    }
  }

  TagPayTransactionType _transactionTypeFromProto(
      pb.TagPayTransactionType type) {
    switch (type) {
      case pb.TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_SEND:
        return TagPayTransactionType.send;
      case pb.TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_RECEIVE:
        return TagPayTransactionType.receive;
      case pb.TagPayTransactionType.TAG_PAY_TRANSACTION_TYPE_REQUEST:
        return TagPayTransactionType.request;
      case pb.TagPayTransactionType
            .TAG_PAY_TRANSACTION_TYPE_REQUEST_FULFILLED:
        return TagPayTransactionType.requestFulfilled;
      default:
        return TagPayTransactionType.send;
    }
  }

  MoneyRequestStatus _moneyRequestStatusFromProto(pb.MoneyRequestStatus status) {
    switch (status) {
      case pb.MoneyRequestStatus.MONEY_REQUEST_STATUS_PENDING:
        return MoneyRequestStatus.pending;
      case pb.MoneyRequestStatus.MONEY_REQUEST_STATUS_ACCEPTED:
        return MoneyRequestStatus.accepted;
      case pb.MoneyRequestStatus.MONEY_REQUEST_STATUS_DECLINED:
        return MoneyRequestStatus.declined;
      case pb.MoneyRequestStatus.MONEY_REQUEST_STATUS_EXPIRED:
        return MoneyRequestStatus.expired;
      case pb.MoneyRequestStatus.MONEY_REQUEST_STATUS_CANCELLED:
        return MoneyRequestStatus.cancelled;
      default:
        return MoneyRequestStatus.pending;
    }
  }

  @override
  Future<UserTagEntity> createTag({
    required String taggedUserTagPay,
    required double amount,
    required String currency,
    String? description,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.CreateTagRequest()
          ..taggedUserTagPay = taggedUserTagPay
          ..amount = amount
          ..currency = currency;

        if (description != null) {
          request.description = description;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.createTag(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _userTagFromProto(response.tag);
      },
    );
  }

  pb.TagStatus? _mapStatusFilter(String? status) {
    switch (status) {
      case 'paid':
        return pb.TagStatus.TAG_STATUS_PAID;
      case 'cancelled':
        return pb.TagStatus.TAG_STATUS_CANCELLED;
      default:
        // null, 'all', 'pending' → don't set (default = all from backend)
        return null;
    }
  }

  @override
  Future<TagsPageResult> getMyTags({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    // Backward compatibility - returns outgoing tags
    return getMyOutgoingTags(page: page, limit: limit, status: status);
  }

  @override
  Future<TagsPageResult> getMyOutgoingTags({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetMyTagsRequest()
          ..page = page
          ..limit = limit;

        final protoStatus = _mapStatusFilter(status);
        if (protoStatus != null) {
          request.status = protoStatus;
        }

        try {
          final options = await grpcClient.callOptions;
          final response = await grpcClient.tagPayClient.getMyOutgoingTags(
            request,
            options: options,
          );

          print('[TagPayRepository] Retrieved ${response.tags.length} outgoing tags');
          return TagsPageResult(
            tags: response.tags.map((tag) => _userTagFromProto(tag)).toList(),
            total: response.total,
            page: response.page,
            totalPages: response.totalPages,
          );
        } on GrpcError catch (e) {
          if (e.code == StatusCode.unauthenticated) {
            print('[TagPayRepository] Token expired in getMyOutgoingTags - triggering refresh');
            rethrow;
          } else if (e.code == StatusCode.notFound) {
            print('[TagPayRepository] User not found: ${e.message}');
            rethrow;
          } else {
            print('[TagPayRepository] Error in getMyOutgoingTags: ${e.code} - ${e.message}');
            rethrow;
          }
        }
      },
    );
  }

  @override
  Future<TagsPageResult> getMyIncomingTags({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.GetMyTagsRequest()
          ..page = page
          ..limit = limit;

        final protoStatus = _mapStatusFilter(status);
        if (protoStatus != null) {
          request.status = protoStatus;
        }

        try {
          final options = await grpcClient.callOptions;
          final response = await grpcClient.tagPayClient.getMyIncomingTags(
            request,
            options: options,
          );

          print('[TagPayRepository] Retrieved ${response.tags.length} incoming tags');
          return TagsPageResult(
            tags: response.tags.map((tag) => _userTagFromProto(tag)).toList(),
            total: response.total,
            page: response.page,
            totalPages: response.totalPages,
          );
        } on GrpcError catch (e) {
          if (e.code == StatusCode.unauthenticated) {
            print('[TagPayRepository] Token expired in getMyIncomingTags - triggering refresh');
            rethrow;
          } else if (e.code == StatusCode.notFound) {
            print('[TagPayRepository] User not found: ${e.message}');
            rethrow;
          } else {
            print('[TagPayRepository] Error in getMyIncomingTags: ${e.code} - ${e.message}');
            rethrow;
          }
        }
      },
    );
  }

  @override
  Future<TagPayTransactionEntity> payTag({
    required String tagId,
    required String sourceAccountId,
    String transactionPin = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        print('🌐 [TagPayRepository] Calling backend payTag - tagId: $tagId, accountId: $sourceAccountId');
        final request = pb.PayTagRequest()
          ..tagId = tagId
          ..sourceAccountId = sourceAccountId
          ..transactionPin = transactionPin;

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.payTag(
          request,
          options: options,
        );

        print('📡 [TagPayRepository] Backend response - success: ${response.success}, message: ${response.message}');

        if (!response.success) {
          print('❌ [TagPayRepository] Backend returned error: ${response.message}');
          throw Exception(response.message);
        }

        final transaction = _transactionFromProto(response.transaction);
        print('✅ [TagPayRepository] Transaction created - ID: ${transaction.id}');
        return transaction;
      },
    );
  }

  @override
  Future<List<UserSearchResultEntity>> searchUsers({
    required String query,
    int limit = 10,
    String searchType = '', // Empty for unified search across username, name, phone, email
  }) async {
    // User search is decoupled from TagPay - use AuthService instead
    // This follows proper architecture where user search is handled by UserService/AuthService
    return retryWithBackoff(
      operation: () async {
        final request = auth_pb.SearchUsersByUsernameRequest()
          ..query = query
          ..limit = limit
          ..searchType = searchType;

        print('[TagPayRepository] searchUsers: query="$query", limit=$limit, searchType="$searchType"');
        final options = await callOptionsHelper.withAuth();
        final response = await authServiceClient.searchUsersByUsername(
          request,
          options: options,
        );

        print('[TagPayRepository] searchUsers response: success=${response.success}, msg="${response.msg}", users=${response.users.length}');
        if (!response.success) {
          print('[TagPayRepository] User search failed: ${response.msg}');
          return [];
        }

        return response.users
            .map((user) => UserSearchResultEntity(
                  userId: user.userId,
                  username: user.username,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  email: user.email,
                  phoneNumber: user.phoneNumber,
                  profilePicture: user.profilePicture,
                ))
            .toList();
      },
    );
  }

  @override
  Future<List<UserTagEntity>> batchCreateTags({
    required List<String> taggedUserTagPays,
    required double amount,
    required String currency,
    String? description,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = pb.BatchCreateTagsRequest()
          ..taggedUserTagPays.addAll(taggedUserTagPays)
          ..amount = amount
          ..currency = currency;

        if (description != null) {
          request.description = description;
        }

        final options = await grpcClient.callOptions;
        final response = await grpcClient.tagPayClient.batchCreateTags(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return response.tags.map((tag) => _userTagFromProto(tag)).toList();
      },
    );
  }

  UserTagEntity _userTagFromProto(pb.UserTag tag) {
    return UserTagEntity(
      id: tag.id,
      taggerId: tag.taggerId,
      taggerTagPay: tag.taggerTagPay,
      taggerName: tag.taggerName,
      taggedUserId: tag.taggedUserId,
      taggedUserTagPay: tag.taggedUserTagPay,
      taggedUserName: tag.taggedUserName,
      amount: tag.amount,
      currency: tag.currency,
      description: tag.description,
      status: _tagStatusFromProto(tag.status),
      createdAt: tag.createdAt.toDateTime(),
      paidAt: tag.hasPaidAt() ? tag.paidAt.toDateTime() : null,
    );
  }

  TagStatus _tagStatusFromProto(pb.TagStatus status) {
    switch (status) {
      case pb.TagStatus.TAG_STATUS_PENDING:
        return TagStatus.pending;
      case pb.TagStatus.TAG_STATUS_PAID:
        return TagStatus.paid;
      case pb.TagStatus.TAG_STATUS_CANCELLED:
        return TagStatus.cancelled;
      default:
        return TagStatus.pending;
    }
  }
}
