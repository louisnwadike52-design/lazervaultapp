import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/crowdfund.pbgrpc.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as pb_timestamp;
import 'package:fixnum/fixnum.dart' as fixnum;
import '../models/crowdfund_models.dart';
import '../../domain/entities/crowdfund_entities.dart';

class CrowdfundGrpcDataSource {
  final pb.CrowdfundServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  CrowdfundGrpcDataSource({
    required pb.CrowdfundServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  pb_timestamp.Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return pb_timestamp.Timestamp.fromDateTime(dateTime);
  }

  fixnum.Int64 _amountToInt64(double amount) {
    return fixnum.Int64((amount * 100).toInt());
  }

  pb.CrowdfundVisibility _visibilityToProto(CrowdfundVisibility visibility) {
    switch (visibility) {
      case CrowdfundVisibility.public:
        return pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_PUBLIC;
      case CrowdfundVisibility.private:
        return pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_PRIVATE;
      case CrowdfundVisibility.unlisted:
        return pb.CrowdfundVisibility.CROWDFUND_VISIBILITY_UNLISTED;
    }
  }

  pb.CrowdfundStatus _statusToProto(CrowdfundStatus status) {
    switch (status) {
      case CrowdfundStatus.active:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_ACTIVE;
      case CrowdfundStatus.paused:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_PAUSED;
      case CrowdfundStatus.completed:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_COMPLETED;
      case CrowdfundStatus.cancelled:
        return pb.CrowdfundStatus.CROWDFUND_STATUS_CANCELLED;
    }
  }

  // ============================================================================
  // CROWDFUND MANAGEMENT
  // ============================================================================

  Future<CrowdfundModel> createCrowdfund({
    required String title,
    required String description,
    required String story,
    required double targetAmount,
    required String currency,
    DateTime? deadline,
    required String category,
    String? imageUrl,
    required CrowdfundVisibility visibility,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final request = pb.CreateCrowdfundRequest()
        ..title = title
        ..description = description
        ..story = story
        ..targetAmount = _amountToInt64(targetAmount)
        ..currency = currency
        ..category = category
        ..visibility = _visibilityToProto(visibility);

      if (deadline != null) {
        request.deadline = _dateTimeToTimestamp(deadline);
      }

      if (imageUrl != null) {
        request.imageUrl = imageUrl;
      }

      if (metadata != null) {
        request.metadata = metadata.toString();
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.createCrowdfund(request, options: callOptions);

      return CrowdfundModel.fromProto(response.crowdfund);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to create crowdfund'}');
    }
  }

  Future<CrowdfundModel> getCrowdfund(String crowdfundId) async {
    try {
      final request = pb.GetCrowdfundRequest()..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfund(request, options: callOptions);

      return CrowdfundModel.fromProto(response.crowdfund);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get crowdfund'}');
    }
  }

  Future<List<CrowdfundModel>> listCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
  }) async {
    try {
      final request = pb.ListCrowdfundsRequest()
        ..page = page
        ..pageSize = pageSize
        ..myCrowdfundsOnly = myCrowdfundsOnly;

      if (statusFilter != null) {
        request.status = statusFilter;
      }

      if (categoryFilter != null) {
        request.category = categoryFilter;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.listCrowdfunds(request, options: callOptions);

      return response.crowdfunds
          .map((cf) => CrowdfundModel.fromProto(cf))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to list crowdfunds'}');
    }
  }

  Future<List<CrowdfundModel>> searchCrowdfunds({
    required String query,
    int limit = 10,
  }) async {
    try {
      final request = pb.SearchCrowdfundsRequest()
        ..query = query
        ..limit = limit;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.searchCrowdfunds(request, options: callOptions);

      return response.crowdfunds
          .map((cf) => CrowdfundModel.fromProto(cf))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to search crowdfunds'}');
    }
  }

  Future<CrowdfundModel> updateCrowdfund({
    required String crowdfundId,
    String? title,
    String? description,
    String? story,
    DateTime? deadline,
    CrowdfundStatus? status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final request = pb.UpdateCrowdfundRequest()..crowdfundId = crowdfundId;

      if (title != null) request.title = title;
      if (description != null) request.description = description;
      if (story != null) request.story = story;
      if (deadline != null) request.deadline = _dateTimeToTimestamp(deadline);
      if (status != null) request.status = _statusToProto(status);
      if (imageUrl != null) request.imageUrl = imageUrl;
      if (metadata != null) request.metadata = metadata.toString();

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.updateCrowdfund(request, options: callOptions);

      return CrowdfundModel.fromProto(response.crowdfund);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update crowdfund'}');
    }
  }

  Future<void> deleteCrowdfund(String crowdfundId) async {
    try {
      final request = pb.DeleteCrowdfundRequest()..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.deleteCrowdfund(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to delete crowdfund'}');
    }
  }

  // ============================================================================
  // DONATION OPERATIONS
  // ============================================================================

  Future<CrowdfundDonationModel> makeDonation({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    int? sourceAccountId,
  }) async {
    try {
      final request = pb.MakeDonationRequest()
        ..crowdfundId = crowdfundId
        ..amount = _amountToInt64(amount)
        ..isAnonymous = isAnonymous;

      if (message != null) {
        request.message = message;
      }

      if (sourceAccountId != null) {
        request.sourceAccountId = fixnum.Int64(sourceAccountId);
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.makeDonation(request, options: callOptions);

      return CrowdfundDonationModel.fromProto(response.donation);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to make donation'}');
    }
  }

  Future<List<CrowdfundDonationModel>> getCrowdfundDonations({
    required String crowdfundId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetCrowdfundDonationsRequest()
        ..crowdfundId = crowdfundId
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfundDonations(request, options: callOptions);

      return response.donations
          .map((d) => CrowdfundDonationModel.fromProto(d))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get donations'}');
    }
  }

  Future<List<CrowdfundDonationModel>> getUserDonations({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetUserDonationsRequest()
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getUserDonations(request, options: callOptions);

      return response.donations
          .map((d) => CrowdfundDonationModel.fromProto(d))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get user donations'}');
    }
  }

  // ============================================================================
  // RECEIPT OPERATIONS
  // ============================================================================

  Future<CrowdfundReceiptModel> generateDonationReceipt(
      String donationId) async {
    try {
      final request = pb.GenerateDonationReceiptRequest()
        ..donationId = donationId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.generateDonationReceipt(request, options: callOptions);

      return CrowdfundReceiptModel.fromProto(response.receipt);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to generate receipt'}');
    }
  }

  Future<List<CrowdfundReceiptModel>> getUserReceipts({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetUserCrowdfundReceiptsRequest()
        ..page = page
        ..pageSize = pageSize;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getUserCrowdfundReceipts(request, options: callOptions);

      return response.receipts
          .map((r) => CrowdfundReceiptModel.fromProto(r))
          .toList();
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get receipts'}');
    }
  }

  // ============================================================================
  // STATISTICS
  // ============================================================================

  Future<CrowdfundStatisticsModel> getCrowdfundStatistics(
      String crowdfundId) async {
    try {
      final request = pb.GetCrowdfundStatisticsRequest()
        ..crowdfundId = crowdfundId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _client.getCrowdfundStatistics(request, options: callOptions);

      return CrowdfundStatisticsModel.fromProto(response);
    } on GrpcError catch (e) {
      throw Exception(
          'gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get statistics'}');
    }
  }
}
