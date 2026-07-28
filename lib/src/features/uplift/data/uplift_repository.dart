import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as pb_ts;
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Thin gRPC wrapper around the products-gateway UpliftService. Every call is
/// authenticated via [GrpcCallOptionsHelper.withAuth] (bearer token metadata).
/// Amounts are KOBO (minor units) on the wire — the same unit used everywhere
/// in the Uplift path, so no conversion happens here.
class UpliftRepository {
  UpliftRepository({
    required up.UpliftServiceClient client,
    required GrpcCallOptionsHelper callOptions,
  })  : _client = client,
        _callOptions = callOptions;

  final up.UpliftServiceClient _client;
  final GrpcCallOptionsHelper _callOptions;

  // ---- Funds ----

  Future<up.UpliftFundMessage> createFund({
    required String title,
    required String description,
    String story = '',
    required String category,
    String currency = 'NGN',
    required int perBusinessCapKobo,
    required int targetCount,
    DateTime? applicationDeadline,
    DateTime? fundingDeadline,
    String coverImageUrl = '',
    List<String> gallery = const [],
    bool publishNow = true,
    String metadata = '',
  }) async {
    final req = up.CreateUpliftFundRequest(
      title: title,
      description: description,
      story: story,
      category: category,
      currency: currency,
      perBusinessCap: Int64(perBusinessCapKobo),
      targetCount: targetCount,
      coverImageUrl: coverImageUrl,
      gallery: gallery,
      publishNow: publishNow,
      metadata: metadata,
    );
    if (applicationDeadline != null) {
      req.applicationDeadline = _tsFrom(applicationDeadline);
    }
    if (fundingDeadline != null) {
      req.fundingDeadline = _tsFrom(fundingDeadline);
    }
    final resp = await _client.createUpliftFund(req, options: await _callOptions.withAuth());
    return resp.fund;
  }

  Future<up.UpliftFundMessage> updateFund({
    required String fundId,
    String title = '',
    String description = '',
    String story = '',
    String category = '',
    int perBusinessCapKobo = 0,
    int targetCount = 0,
    DateTime? applicationDeadline,
    DateTime? fundingDeadline,
    String coverImageUrl = '',
    List<String> gallery = const [],
    String metadata = '',
  }) async {
    final req = up.UpdateUpliftFundRequest(
      fundId: fundId,
      title: title,
      description: description,
      story: story,
      category: category,
      perBusinessCap: Int64(perBusinessCapKobo),
      targetCount: targetCount,
      coverImageUrl: coverImageUrl,
      gallery: gallery,
      metadata: metadata,
    );
    if (applicationDeadline != null) req.applicationDeadline = _tsFrom(applicationDeadline);
    if (fundingDeadline != null) req.fundingDeadline = _tsFrom(fundingDeadline);
    final resp = await _client.updateUpliftFund(req, options: await _callOptions.withAuth());
    return resp.fund;
  }

  Future<up.GetUpliftEscrowBalanceResponse> escrowBalance(String fundId) async {
    return _client.getUpliftEscrowBalance(
      up.GetUpliftEscrowBalanceRequest(fundId: fundId),
      options: await _callOptions.withAuth(),
    );
  }

  Future<List<up.UpliftFundMessage>> listFunds({
    int page = 1,
    int pageSize = 20,
    String status = '',
    String category = '',
    String query = '',
  }) async {
    final resp = await _client.listUpliftFunds(
      up.ListUpliftFundsRequest(page: page, pageSize: pageSize, status: status, category: category, query: query),
      options: await _callOptions.withAuth(),
    );
    return resp.funds;
  }

  Future<List<up.UpliftFundMessage>> myFunds({int page = 1, int pageSize = 50, String status = ''}) async {
    final resp = await _client.getMyUpliftFunds(
      up.GetMyUpliftFundsRequest(page: page, pageSize: pageSize, status: status),
      options: await _callOptions.withAuth(),
    );
    return resp.funds;
  }

  Future<up.UpliftFundMessage> getFund(String fundId) async {
    final resp = await _client.getUpliftFund(up.GetUpliftFundRequest(fundId: fundId), options: await _callOptions.withAuth());
    return resp.fund;
  }

  Future<up.PublishUpliftFundResponse> publishFund(String fundId) =>
      _publish(fundId);
  Future<up.PublishUpliftFundResponse> _publish(String fundId) async =>
      _client.publishUpliftFund(up.PublishUpliftFundRequest(fundId: fundId), options: await _callOptions.withAuth());

  Future<up.UpliftFundMessage> pauseFund(String fundId, {required bool resume}) async {
    final resp = await _client.pauseUpliftFund(
      up.PauseUpliftFundRequest(fundId: fundId, resume: resume),
      options: await _callOptions.withAuth(),
    );
    return resp.fund;
  }

  Future<List<up.UpliftMilestoneReleaseRecord>> listReleases({String fundId = '', String status = ''}) async {
    final resp = await _client.listUpliftMilestoneReleases(
      up.ListUpliftMilestoneReleasesRequest(fundId: fundId, status: status, page: 1, pageSize: 100),
      options: await _callOptions.withAuth(),
    );
    return resp.releases;
  }

  Future<List<up.UpliftEscrowRefundRecord>> listRefunds({required String fundId, String status = ''}) async {
    final resp = await _client.listUpliftEscrowRefunds(
      up.ListUpliftEscrowRefundsRequest(fundId: fundId, status: status, page: 1, pageSize: 100),
      options: await _callOptions.withAuth(),
    );
    return resp.refunds;
  }

  Future<up.CommitUpliftPoolResponse> commitPool({
    required String fundId,
    required int amountKobo,
    required String sourceAccountId,
    required String pinToken,
    required String transactionId,
  }) async {
    return _client.commitUpliftPool(
      up.CommitUpliftPoolRequest(
        fundId: fundId,
        amount: Int64(amountKobo),
        sourceAccountId: sourceAccountId,
        transactionPin: pinToken,
        transactionId: transactionId,
      ),
      options: await _callOptions.withAuth(),
    );
  }

  Future<up.CancelUpliftFundResponse> cancelFund({
    required String fundId,
    required String reason,
    required String pinToken,
    required String transactionId,
  }) async {
    return _client.cancelUpliftFund(
      up.CancelUpliftFundRequest(fundId: fundId, reason: reason, transactionPin: pinToken, transactionId: transactionId),
      options: await _callOptions.withAuth(),
    );
  }

  // ---- Applications ----

  Future<up.UpliftApplicationMessage> apply({
    required String fundId,
    required String businessName,
    String businessCategory = '',
    required String pitch,
    required int requestedAmountKobo,
    List<String> images = const [],
    List<String> docUrls = const [],
    String businessAccountId = '',
    int proposedEquityPct = 0,
    String equityNote = '',
  }) async {
    final resp = await _client.applyToUpliftFund(
      up.ApplyToUpliftFundRequest(
        fundId: fundId,
        businessName: businessName,
        businessCategory: businessCategory,
        pitch: pitch,
        requestedAmount: Int64(requestedAmountKobo),
        images: images,
        docUrls: docUrls,
        businessAccountId: businessAccountId,
        proposedEquityPct: proposedEquityPct,
        equityNote: equityNote,
      ),
      options: await _callOptions.withAuth(),
    );
    return resp.application;
  }

  Future<List<up.UpliftApplicationMessage>> listApplications({
    String fundId = '',
    bool mineOnly = false,
    String status = '',
    int page = 1,
    int pageSize = 50,
    String sortBy = '',
  }) async {
    final resp = await _client.listUpliftApplications(
      up.ListUpliftApplicationsRequest(
        fundId: fundId, mineOnly: mineOnly, status: status, page: page, pageSize: pageSize, sortBy: sortBy),
      options: await _callOptions.withAuth(),
    );
    return resp.applications;
  }

  Future<up.UpliftApplicationMessage> getApplication(String id) async {
    final resp = await _client.getUpliftApplication(up.GetUpliftApplicationRequest(applicationId: id), options: await _callOptions.withAuth());
    return resp.application;
  }

  Future<up.EndorseUpliftApplicationResponse> endorse(String applicationId, {bool remove = false}) async {
    return _client.endorseUpliftApplication(
      up.EndorseUpliftApplicationRequest(applicationId: applicationId, remove: remove),
      options: await _callOptions.withAuth(),
    );
  }

  Future<up.UpliftApplicationMessage> withdraw(String applicationId, {String reason = ''}) async {
    final resp = await _client.withdrawUpliftApplication(
      up.WithdrawUpliftApplicationRequest(applicationId: applicationId, reason: reason),
      options: await _callOptions.withAuth(),
    );
    return resp.application;
  }

  // ---- Funder review / select / offer ----

  Future<up.UpliftApplicationMessage> review(String applicationId, String action, {String reason = ''}) async {
    final resp = await _client.reviewUpliftApplication(
      up.ReviewUpliftApplicationRequest(applicationId: applicationId, action: action, reason: reason),
      options: await _callOptions.withAuth(),
    );
    return resp.application;
  }

  Future<up.UpliftApplicationMessage> select({
    required String applicationId,
    required int approvedAmountKobo,
    List<up.UpliftMilestonePlanInput> milestones = const [],
    int offerExpiryHours = 0,
    String note = '',
    int equityPct = 0,
  }) async {
    final resp = await _client.selectUpliftApplication(
      up.SelectUpliftApplicationRequest(
        applicationId: applicationId,
        approvedAmount: Int64(approvedAmountKobo),
        milestones: milestones,
        offerExpiryHours: offerExpiryHours,
        note: note,
        equityPct: equityPct,
      ),
      options: await _callOptions.withAuth(),
    );
    return resp.application;
  }

  Future<up.UpliftApplicationMessage> respondToOffer({
    required String applicationId,
    required bool accept,
    String reason = '',
    String businessAccountId = '',
    bool counter = false,
    int counterAmountKobo = 0,
    int counterEquityPct = 0,
    String counterNote = '',
  }) async {
    final resp = await _client.respondToUpliftOffer(
      up.RespondToUpliftOfferRequest(
        applicationId: applicationId,
        accept: accept,
        reason: reason,
        businessAccountId: businessAccountId,
        counter: counter,
        counterAmount: Int64(counterAmountKobo),
        counterEquityPct: counterEquityPct,
        counterNote: counterNote,
      ),
      options: await _callOptions.withAuth(),
    );
    return resp.application;
  }

  // ---- Milestones ----

  Future<up.UpliftMilestoneMessage> submitEvidence(String milestoneId, List<String> evidence, {String note = ''}) async {
    final resp = await _client.submitMilestoneEvidence(
      up.SubmitMilestoneEvidenceRequest(milestoneId: milestoneId, evidence: evidence, note: note),
      options: await _callOptions.withAuth(),
    );
    return resp.milestone;
  }

  Future<up.ReviewMilestoneResponse> reviewMilestone({
    required String milestoneId,
    required bool approve,
    String reason = '',
    String pinToken = '',
    String transactionId = '',
  }) async {
    return _client.reviewMilestone(
      up.ReviewMilestoneRequest(
        milestoneId: milestoneId, approve: approve, reason: reason, transactionPin: pinToken, transactionId: transactionId),
      options: await _callOptions.withAuth(),
    );
  }

  Future<up.GetUpliftStatisticsResponse> statistics(String fundId) async {
    return _client.getUpliftStatistics(up.GetUpliftStatisticsRequest(fundId: fundId), options: await _callOptions.withAuth());
  }

  /// Platform fee quote for a hypothetical disbursement (kobo). Business
  /// receives `net`; `fee` goes to the platform. Used to show gross/fee/net
  /// before an offer is sent. Fixed takes precedence over percentage server-side.
  Future<up.GetUpliftFeeQuoteResponse> feeQuote(int amountKobo) async {
    return _client.getUpliftFeeQuote(
      up.GetUpliftFeeQuoteRequest(amount: Int64(amountKobo)),
      options: await _callOptions.withAuth(),
    );
  }

  // ---- Receipts ----

  Future<List<up.UpliftReceiptMessage>> listReceipts({int page = 1, int pageSize = 50}) async {
    final resp = await _client.listUpliftReceipts(
      up.ListUpliftReceiptsRequest(page: page, pageSize: pageSize),
      options: await _callOptions.withAuth(),
    );
    return resp.receipts;
  }

  Future<up.UpliftReceiptMessage> getReceipt(String referenceType, String referenceId) async {
    final resp = await _client.getUpliftReceipt(
      up.GetUpliftReceiptRequest(referenceType: referenceType, referenceId: referenceId),
      options: await _callOptions.withAuth(),
    );
    return resp.receipt;
  }

  // Converts a Dart DateTime to a protobuf Timestamp.
  static pb_ts.Timestamp _tsFrom(DateTime d) => pb_ts.Timestamp.fromDateTime(d.toUtc());
}
