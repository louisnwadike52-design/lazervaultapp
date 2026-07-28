// This is a generated file - do not edit.
//
// Generated from uplift.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'uplift.pb.dart' as $0;

export 'uplift.pb.dart';

@$pb.GrpcServiceName('pb.UpliftService')
class UpliftServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UpliftServiceClient(super.channel, {super.options, super.interceptors});

  /// ---- Fund lifecycle (funder) ----
  $grpc.ResponseFuture<$0.CreateUpliftFundResponse> createUpliftFund(
    $0.CreateUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createUpliftFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateUpliftFundResponse> updateUpliftFund(
    $0.UpdateUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateUpliftFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.PublishUpliftFundResponse> publishUpliftFund(
    $0.PublishUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$publishUpliftFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUpliftFundResponse> getUpliftFund(
    $0.GetUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUpliftFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListUpliftFundsResponse> listUpliftFunds(
    $0.ListUpliftFundsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listUpliftFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMyUpliftFundsResponse> getMyUpliftFunds(
    $0.GetMyUpliftFundsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMyUpliftFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.PauseUpliftFundResponse> pauseUpliftFund(
    $0.PauseUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$pauseUpliftFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelUpliftFundResponse> cancelUpliftFund(
    $0.CancelUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelUpliftFund, request, options: options);
  }

  /// ---- Escrow / pool commit (funder) ----
  $grpc.ResponseFuture<$0.CommitUpliftPoolResponse> commitUpliftPool(
    $0.CommitUpliftPoolRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$commitUpliftPool, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUpliftEscrowBalanceResponse>
      getUpliftEscrowBalance(
    $0.GetUpliftEscrowBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUpliftEscrowBalance, request,
        options: options);
  }

  /// ---- Applications (applicant) ----
  $grpc.ResponseFuture<$0.ApplyToUpliftFundResponse> applyToUpliftFund(
    $0.ApplyToUpliftFundRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$applyToUpliftFund, request, options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawUpliftApplicationResponse>
      withdrawUpliftApplication(
    $0.WithdrawUpliftApplicationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawUpliftApplication, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.GetUpliftApplicationResponse> getUpliftApplication(
    $0.GetUpliftApplicationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUpliftApplication, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListUpliftApplicationsResponse>
      listUpliftApplications(
    $0.ListUpliftApplicationsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listUpliftApplications, request,
        options: options);
  }

  /// ---- Endorsements ----
  $grpc.ResponseFuture<$0.EndorseUpliftApplicationResponse>
      endorseUpliftApplication(
    $0.EndorseUpliftApplicationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$endorseUpliftApplication, request,
        options: options);
  }

  /// ---- Review / select / offer (funder) ----
  $grpc.ResponseFuture<$0.ReviewUpliftApplicationResponse>
      reviewUpliftApplication(
    $0.ReviewUpliftApplicationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reviewUpliftApplication, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.SelectUpliftApplicationResponse>
      selectUpliftApplication(
    $0.SelectUpliftApplicationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$selectUpliftApplication, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RespondToUpliftOfferResponse> respondToUpliftOffer(
    $0.RespondToUpliftOfferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$respondToUpliftOffer, request, options: options);
  }

  /// ---- Milestones ----
  $grpc.ResponseFuture<$0.SubmitMilestoneEvidenceResponse>
      submitMilestoneEvidence(
    $0.SubmitMilestoneEvidenceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$submitMilestoneEvidence, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ReviewMilestoneResponse> reviewMilestone(
    $0.ReviewMilestoneRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reviewMilestone, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListUpliftMilestoneReleasesResponse>
      listUpliftMilestoneReleases(
    $0.ListUpliftMilestoneReleasesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listUpliftMilestoneReleases, request,
        options: options);
  }

  /// ---- Escrow refunds (audit) ----
  $grpc.ResponseFuture<$0.ListUpliftEscrowRefundsResponse>
      listUpliftEscrowRefunds(
    $0.ListUpliftEscrowRefundsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listUpliftEscrowRefunds, request,
        options: options);
  }

  /// ---- Receipts ----
  $grpc.ResponseFuture<$0.GetUpliftReceiptResponse> getUpliftReceipt(
    $0.GetUpliftReceiptRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUpliftReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListUpliftReceiptsResponse> listUpliftReceipts(
    $0.ListUpliftReceiptsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listUpliftReceipts, request, options: options);
  }

  /// ---- Statistics ----
  $grpc.ResponseFuture<$0.GetUpliftStatisticsResponse> getUpliftStatistics(
    $0.GetUpliftStatisticsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUpliftStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUpliftFeeQuoteResponse> getUpliftFeeQuote(
    $0.GetUpliftFeeQuoteRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUpliftFeeQuote, request, options: options);
  }

  // method descriptors

  static final _$createUpliftFund = $grpc.ClientMethod<
          $0.CreateUpliftFundRequest, $0.CreateUpliftFundResponse>(
      '/pb.UpliftService/CreateUpliftFund',
      ($0.CreateUpliftFundRequest value) => value.writeToBuffer(),
      $0.CreateUpliftFundResponse.fromBuffer);
  static final _$updateUpliftFund = $grpc.ClientMethod<
          $0.UpdateUpliftFundRequest, $0.UpdateUpliftFundResponse>(
      '/pb.UpliftService/UpdateUpliftFund',
      ($0.UpdateUpliftFundRequest value) => value.writeToBuffer(),
      $0.UpdateUpliftFundResponse.fromBuffer);
  static final _$publishUpliftFund = $grpc.ClientMethod<
          $0.PublishUpliftFundRequest, $0.PublishUpliftFundResponse>(
      '/pb.UpliftService/PublishUpliftFund',
      ($0.PublishUpliftFundRequest value) => value.writeToBuffer(),
      $0.PublishUpliftFundResponse.fromBuffer);
  static final _$getUpliftFund =
      $grpc.ClientMethod<$0.GetUpliftFundRequest, $0.GetUpliftFundResponse>(
          '/pb.UpliftService/GetUpliftFund',
          ($0.GetUpliftFundRequest value) => value.writeToBuffer(),
          $0.GetUpliftFundResponse.fromBuffer);
  static final _$listUpliftFunds =
      $grpc.ClientMethod<$0.ListUpliftFundsRequest, $0.ListUpliftFundsResponse>(
          '/pb.UpliftService/ListUpliftFunds',
          ($0.ListUpliftFundsRequest value) => value.writeToBuffer(),
          $0.ListUpliftFundsResponse.fromBuffer);
  static final _$getMyUpliftFunds = $grpc.ClientMethod<
          $0.GetMyUpliftFundsRequest, $0.GetMyUpliftFundsResponse>(
      '/pb.UpliftService/GetMyUpliftFunds',
      ($0.GetMyUpliftFundsRequest value) => value.writeToBuffer(),
      $0.GetMyUpliftFundsResponse.fromBuffer);
  static final _$pauseUpliftFund =
      $grpc.ClientMethod<$0.PauseUpliftFundRequest, $0.PauseUpliftFundResponse>(
          '/pb.UpliftService/PauseUpliftFund',
          ($0.PauseUpliftFundRequest value) => value.writeToBuffer(),
          $0.PauseUpliftFundResponse.fromBuffer);
  static final _$cancelUpliftFund = $grpc.ClientMethod<
          $0.CancelUpliftFundRequest, $0.CancelUpliftFundResponse>(
      '/pb.UpliftService/CancelUpliftFund',
      ($0.CancelUpliftFundRequest value) => value.writeToBuffer(),
      $0.CancelUpliftFundResponse.fromBuffer);
  static final _$commitUpliftPool = $grpc.ClientMethod<
          $0.CommitUpliftPoolRequest, $0.CommitUpliftPoolResponse>(
      '/pb.UpliftService/CommitUpliftPool',
      ($0.CommitUpliftPoolRequest value) => value.writeToBuffer(),
      $0.CommitUpliftPoolResponse.fromBuffer);
  static final _$getUpliftEscrowBalance = $grpc.ClientMethod<
          $0.GetUpliftEscrowBalanceRequest, $0.GetUpliftEscrowBalanceResponse>(
      '/pb.UpliftService/GetUpliftEscrowBalance',
      ($0.GetUpliftEscrowBalanceRequest value) => value.writeToBuffer(),
      $0.GetUpliftEscrowBalanceResponse.fromBuffer);
  static final _$applyToUpliftFund = $grpc.ClientMethod<
          $0.ApplyToUpliftFundRequest, $0.ApplyToUpliftFundResponse>(
      '/pb.UpliftService/ApplyToUpliftFund',
      ($0.ApplyToUpliftFundRequest value) => value.writeToBuffer(),
      $0.ApplyToUpliftFundResponse.fromBuffer);
  static final _$withdrawUpliftApplication = $grpc.ClientMethod<
          $0.WithdrawUpliftApplicationRequest,
          $0.WithdrawUpliftApplicationResponse>(
      '/pb.UpliftService/WithdrawUpliftApplication',
      ($0.WithdrawUpliftApplicationRequest value) => value.writeToBuffer(),
      $0.WithdrawUpliftApplicationResponse.fromBuffer);
  static final _$getUpliftApplication = $grpc.ClientMethod<
          $0.GetUpliftApplicationRequest, $0.GetUpliftApplicationResponse>(
      '/pb.UpliftService/GetUpliftApplication',
      ($0.GetUpliftApplicationRequest value) => value.writeToBuffer(),
      $0.GetUpliftApplicationResponse.fromBuffer);
  static final _$listUpliftApplications = $grpc.ClientMethod<
          $0.ListUpliftApplicationsRequest, $0.ListUpliftApplicationsResponse>(
      '/pb.UpliftService/ListUpliftApplications',
      ($0.ListUpliftApplicationsRequest value) => value.writeToBuffer(),
      $0.ListUpliftApplicationsResponse.fromBuffer);
  static final _$endorseUpliftApplication = $grpc.ClientMethod<
          $0.EndorseUpliftApplicationRequest,
          $0.EndorseUpliftApplicationResponse>(
      '/pb.UpliftService/EndorseUpliftApplication',
      ($0.EndorseUpliftApplicationRequest value) => value.writeToBuffer(),
      $0.EndorseUpliftApplicationResponse.fromBuffer);
  static final _$reviewUpliftApplication = $grpc.ClientMethod<
          $0.ReviewUpliftApplicationRequest,
          $0.ReviewUpliftApplicationResponse>(
      '/pb.UpliftService/ReviewUpliftApplication',
      ($0.ReviewUpliftApplicationRequest value) => value.writeToBuffer(),
      $0.ReviewUpliftApplicationResponse.fromBuffer);
  static final _$selectUpliftApplication = $grpc.ClientMethod<
          $0.SelectUpliftApplicationRequest,
          $0.SelectUpliftApplicationResponse>(
      '/pb.UpliftService/SelectUpliftApplication',
      ($0.SelectUpliftApplicationRequest value) => value.writeToBuffer(),
      $0.SelectUpliftApplicationResponse.fromBuffer);
  static final _$respondToUpliftOffer = $grpc.ClientMethod<
          $0.RespondToUpliftOfferRequest, $0.RespondToUpliftOfferResponse>(
      '/pb.UpliftService/RespondToUpliftOffer',
      ($0.RespondToUpliftOfferRequest value) => value.writeToBuffer(),
      $0.RespondToUpliftOfferResponse.fromBuffer);
  static final _$submitMilestoneEvidence = $grpc.ClientMethod<
          $0.SubmitMilestoneEvidenceRequest,
          $0.SubmitMilestoneEvidenceResponse>(
      '/pb.UpliftService/SubmitMilestoneEvidence',
      ($0.SubmitMilestoneEvidenceRequest value) => value.writeToBuffer(),
      $0.SubmitMilestoneEvidenceResponse.fromBuffer);
  static final _$reviewMilestone =
      $grpc.ClientMethod<$0.ReviewMilestoneRequest, $0.ReviewMilestoneResponse>(
          '/pb.UpliftService/ReviewMilestone',
          ($0.ReviewMilestoneRequest value) => value.writeToBuffer(),
          $0.ReviewMilestoneResponse.fromBuffer);
  static final _$listUpliftMilestoneReleases = $grpc.ClientMethod<
          $0.ListUpliftMilestoneReleasesRequest,
          $0.ListUpliftMilestoneReleasesResponse>(
      '/pb.UpliftService/ListUpliftMilestoneReleases',
      ($0.ListUpliftMilestoneReleasesRequest value) => value.writeToBuffer(),
      $0.ListUpliftMilestoneReleasesResponse.fromBuffer);
  static final _$listUpliftEscrowRefunds = $grpc.ClientMethod<
          $0.ListUpliftEscrowRefundsRequest,
          $0.ListUpliftEscrowRefundsResponse>(
      '/pb.UpliftService/ListUpliftEscrowRefunds',
      ($0.ListUpliftEscrowRefundsRequest value) => value.writeToBuffer(),
      $0.ListUpliftEscrowRefundsResponse.fromBuffer);
  static final _$getUpliftReceipt = $grpc.ClientMethod<
          $0.GetUpliftReceiptRequest, $0.GetUpliftReceiptResponse>(
      '/pb.UpliftService/GetUpliftReceipt',
      ($0.GetUpliftReceiptRequest value) => value.writeToBuffer(),
      $0.GetUpliftReceiptResponse.fromBuffer);
  static final _$listUpliftReceipts = $grpc.ClientMethod<
          $0.ListUpliftReceiptsRequest, $0.ListUpliftReceiptsResponse>(
      '/pb.UpliftService/ListUpliftReceipts',
      ($0.ListUpliftReceiptsRequest value) => value.writeToBuffer(),
      $0.ListUpliftReceiptsResponse.fromBuffer);
  static final _$getUpliftStatistics = $grpc.ClientMethod<
          $0.GetUpliftStatisticsRequest, $0.GetUpliftStatisticsResponse>(
      '/pb.UpliftService/GetUpliftStatistics',
      ($0.GetUpliftStatisticsRequest value) => value.writeToBuffer(),
      $0.GetUpliftStatisticsResponse.fromBuffer);
  static final _$getUpliftFeeQuote = $grpc.ClientMethod<
          $0.GetUpliftFeeQuoteRequest, $0.GetUpliftFeeQuoteResponse>(
      '/pb.UpliftService/GetUpliftFeeQuote',
      ($0.GetUpliftFeeQuoteRequest value) => value.writeToBuffer(),
      $0.GetUpliftFeeQuoteResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.UpliftService')
abstract class UpliftServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UpliftService';

  UpliftServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateUpliftFundRequest,
            $0.CreateUpliftFundResponse>(
        'CreateUpliftFund',
        createUpliftFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateUpliftFundRequest.fromBuffer(value),
        ($0.CreateUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateUpliftFundRequest,
            $0.UpdateUpliftFundResponse>(
        'UpdateUpliftFund',
        updateUpliftFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateUpliftFundRequest.fromBuffer(value),
        ($0.UpdateUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PublishUpliftFundRequest,
            $0.PublishUpliftFundResponse>(
        'PublishUpliftFund',
        publishUpliftFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PublishUpliftFundRequest.fromBuffer(value),
        ($0.PublishUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUpliftFundRequest, $0.GetUpliftFundResponse>(
            'GetUpliftFund',
            getUpliftFund_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUpliftFundRequest.fromBuffer(value),
            ($0.GetUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUpliftFundsRequest,
            $0.ListUpliftFundsResponse>(
        'ListUpliftFunds',
        listUpliftFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListUpliftFundsRequest.fromBuffer(value),
        ($0.ListUpliftFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMyUpliftFundsRequest,
            $0.GetMyUpliftFundsResponse>(
        'GetMyUpliftFunds',
        getMyUpliftFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMyUpliftFundsRequest.fromBuffer(value),
        ($0.GetMyUpliftFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseUpliftFundRequest,
            $0.PauseUpliftFundResponse>(
        'PauseUpliftFund',
        pauseUpliftFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PauseUpliftFundRequest.fromBuffer(value),
        ($0.PauseUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelUpliftFundRequest,
            $0.CancelUpliftFundResponse>(
        'CancelUpliftFund',
        cancelUpliftFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CancelUpliftFundRequest.fromBuffer(value),
        ($0.CancelUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CommitUpliftPoolRequest,
            $0.CommitUpliftPoolResponse>(
        'CommitUpliftPool',
        commitUpliftPool_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CommitUpliftPoolRequest.fromBuffer(value),
        ($0.CommitUpliftPoolResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpliftEscrowBalanceRequest,
            $0.GetUpliftEscrowBalanceResponse>(
        'GetUpliftEscrowBalance',
        getUpliftEscrowBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUpliftEscrowBalanceRequest.fromBuffer(value),
        ($0.GetUpliftEscrowBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ApplyToUpliftFundRequest,
            $0.ApplyToUpliftFundResponse>(
        'ApplyToUpliftFund',
        applyToUpliftFund_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ApplyToUpliftFundRequest.fromBuffer(value),
        ($0.ApplyToUpliftFundResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawUpliftApplicationRequest,
            $0.WithdrawUpliftApplicationResponse>(
        'WithdrawUpliftApplication',
        withdrawUpliftApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawUpliftApplicationRequest.fromBuffer(value),
        ($0.WithdrawUpliftApplicationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpliftApplicationRequest,
            $0.GetUpliftApplicationResponse>(
        'GetUpliftApplication',
        getUpliftApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUpliftApplicationRequest.fromBuffer(value),
        ($0.GetUpliftApplicationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUpliftApplicationsRequest,
            $0.ListUpliftApplicationsResponse>(
        'ListUpliftApplications',
        listUpliftApplications_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListUpliftApplicationsRequest.fromBuffer(value),
        ($0.ListUpliftApplicationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.EndorseUpliftApplicationRequest,
            $0.EndorseUpliftApplicationResponse>(
        'EndorseUpliftApplication',
        endorseUpliftApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.EndorseUpliftApplicationRequest.fromBuffer(value),
        ($0.EndorseUpliftApplicationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReviewUpliftApplicationRequest,
            $0.ReviewUpliftApplicationResponse>(
        'ReviewUpliftApplication',
        reviewUpliftApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReviewUpliftApplicationRequest.fromBuffer(value),
        ($0.ReviewUpliftApplicationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SelectUpliftApplicationRequest,
            $0.SelectUpliftApplicationResponse>(
        'SelectUpliftApplication',
        selectUpliftApplication_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SelectUpliftApplicationRequest.fromBuffer(value),
        ($0.SelectUpliftApplicationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RespondToUpliftOfferRequest,
            $0.RespondToUpliftOfferResponse>(
        'RespondToUpliftOffer',
        respondToUpliftOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RespondToUpliftOfferRequest.fromBuffer(value),
        ($0.RespondToUpliftOfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubmitMilestoneEvidenceRequest,
            $0.SubmitMilestoneEvidenceResponse>(
        'SubmitMilestoneEvidence',
        submitMilestoneEvidence_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SubmitMilestoneEvidenceRequest.fromBuffer(value),
        ($0.SubmitMilestoneEvidenceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReviewMilestoneRequest,
            $0.ReviewMilestoneResponse>(
        'ReviewMilestone',
        reviewMilestone_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReviewMilestoneRequest.fromBuffer(value),
        ($0.ReviewMilestoneResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUpliftMilestoneReleasesRequest,
            $0.ListUpliftMilestoneReleasesResponse>(
        'ListUpliftMilestoneReleases',
        listUpliftMilestoneReleases_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListUpliftMilestoneReleasesRequest.fromBuffer(value),
        ($0.ListUpliftMilestoneReleasesResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUpliftEscrowRefundsRequest,
            $0.ListUpliftEscrowRefundsResponse>(
        'ListUpliftEscrowRefunds',
        listUpliftEscrowRefunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListUpliftEscrowRefundsRequest.fromBuffer(value),
        ($0.ListUpliftEscrowRefundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpliftReceiptRequest,
            $0.GetUpliftReceiptResponse>(
        'GetUpliftReceipt',
        getUpliftReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUpliftReceiptRequest.fromBuffer(value),
        ($0.GetUpliftReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUpliftReceiptsRequest,
            $0.ListUpliftReceiptsResponse>(
        'ListUpliftReceipts',
        listUpliftReceipts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListUpliftReceiptsRequest.fromBuffer(value),
        ($0.ListUpliftReceiptsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpliftStatisticsRequest,
            $0.GetUpliftStatisticsResponse>(
        'GetUpliftStatistics',
        getUpliftStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUpliftStatisticsRequest.fromBuffer(value),
        ($0.GetUpliftStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUpliftFeeQuoteRequest,
            $0.GetUpliftFeeQuoteResponse>(
        'GetUpliftFeeQuote',
        getUpliftFeeQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUpliftFeeQuoteRequest.fromBuffer(value),
        ($0.GetUpliftFeeQuoteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateUpliftFundResponse> createUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateUpliftFundRequest> $request) async {
    return createUpliftFund($call, await $request);
  }

  $async.Future<$0.CreateUpliftFundResponse> createUpliftFund(
      $grpc.ServiceCall call, $0.CreateUpliftFundRequest request);

  $async.Future<$0.UpdateUpliftFundResponse> updateUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UpdateUpliftFundRequest> $request) async {
    return updateUpliftFund($call, await $request);
  }

  $async.Future<$0.UpdateUpliftFundResponse> updateUpliftFund(
      $grpc.ServiceCall call, $0.UpdateUpliftFundRequest request);

  $async.Future<$0.PublishUpliftFundResponse> publishUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PublishUpliftFundRequest> $request) async {
    return publishUpliftFund($call, await $request);
  }

  $async.Future<$0.PublishUpliftFundResponse> publishUpliftFund(
      $grpc.ServiceCall call, $0.PublishUpliftFundRequest request);

  $async.Future<$0.GetUpliftFundResponse> getUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUpliftFundRequest> $request) async {
    return getUpliftFund($call, await $request);
  }

  $async.Future<$0.GetUpliftFundResponse> getUpliftFund(
      $grpc.ServiceCall call, $0.GetUpliftFundRequest request);

  $async.Future<$0.ListUpliftFundsResponse> listUpliftFunds_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListUpliftFundsRequest> $request) async {
    return listUpliftFunds($call, await $request);
  }

  $async.Future<$0.ListUpliftFundsResponse> listUpliftFunds(
      $grpc.ServiceCall call, $0.ListUpliftFundsRequest request);

  $async.Future<$0.GetMyUpliftFundsResponse> getMyUpliftFunds_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMyUpliftFundsRequest> $request) async {
    return getMyUpliftFunds($call, await $request);
  }

  $async.Future<$0.GetMyUpliftFundsResponse> getMyUpliftFunds(
      $grpc.ServiceCall call, $0.GetMyUpliftFundsRequest request);

  $async.Future<$0.PauseUpliftFundResponse> pauseUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PauseUpliftFundRequest> $request) async {
    return pauseUpliftFund($call, await $request);
  }

  $async.Future<$0.PauseUpliftFundResponse> pauseUpliftFund(
      $grpc.ServiceCall call, $0.PauseUpliftFundRequest request);

  $async.Future<$0.CancelUpliftFundResponse> cancelUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelUpliftFundRequest> $request) async {
    return cancelUpliftFund($call, await $request);
  }

  $async.Future<$0.CancelUpliftFundResponse> cancelUpliftFund(
      $grpc.ServiceCall call, $0.CancelUpliftFundRequest request);

  $async.Future<$0.CommitUpliftPoolResponse> commitUpliftPool_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CommitUpliftPoolRequest> $request) async {
    return commitUpliftPool($call, await $request);
  }

  $async.Future<$0.CommitUpliftPoolResponse> commitUpliftPool(
      $grpc.ServiceCall call, $0.CommitUpliftPoolRequest request);

  $async.Future<$0.GetUpliftEscrowBalanceResponse> getUpliftEscrowBalance_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUpliftEscrowBalanceRequest> $request) async {
    return getUpliftEscrowBalance($call, await $request);
  }

  $async.Future<$0.GetUpliftEscrowBalanceResponse> getUpliftEscrowBalance(
      $grpc.ServiceCall call, $0.GetUpliftEscrowBalanceRequest request);

  $async.Future<$0.ApplyToUpliftFundResponse> applyToUpliftFund_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ApplyToUpliftFundRequest> $request) async {
    return applyToUpliftFund($call, await $request);
  }

  $async.Future<$0.ApplyToUpliftFundResponse> applyToUpliftFund(
      $grpc.ServiceCall call, $0.ApplyToUpliftFundRequest request);

  $async.Future<$0.WithdrawUpliftApplicationResponse>
      withdrawUpliftApplication_Pre($grpc.ServiceCall $call,
          $async.Future<$0.WithdrawUpliftApplicationRequest> $request) async {
    return withdrawUpliftApplication($call, await $request);
  }

  $async.Future<$0.WithdrawUpliftApplicationResponse> withdrawUpliftApplication(
      $grpc.ServiceCall call, $0.WithdrawUpliftApplicationRequest request);

  $async.Future<$0.GetUpliftApplicationResponse> getUpliftApplication_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUpliftApplicationRequest> $request) async {
    return getUpliftApplication($call, await $request);
  }

  $async.Future<$0.GetUpliftApplicationResponse> getUpliftApplication(
      $grpc.ServiceCall call, $0.GetUpliftApplicationRequest request);

  $async.Future<$0.ListUpliftApplicationsResponse> listUpliftApplications_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListUpliftApplicationsRequest> $request) async {
    return listUpliftApplications($call, await $request);
  }

  $async.Future<$0.ListUpliftApplicationsResponse> listUpliftApplications(
      $grpc.ServiceCall call, $0.ListUpliftApplicationsRequest request);

  $async.Future<$0.EndorseUpliftApplicationResponse>
      endorseUpliftApplication_Pre($grpc.ServiceCall $call,
          $async.Future<$0.EndorseUpliftApplicationRequest> $request) async {
    return endorseUpliftApplication($call, await $request);
  }

  $async.Future<$0.EndorseUpliftApplicationResponse> endorseUpliftApplication(
      $grpc.ServiceCall call, $0.EndorseUpliftApplicationRequest request);

  $async.Future<$0.ReviewUpliftApplicationResponse> reviewUpliftApplication_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReviewUpliftApplicationRequest> $request) async {
    return reviewUpliftApplication($call, await $request);
  }

  $async.Future<$0.ReviewUpliftApplicationResponse> reviewUpliftApplication(
      $grpc.ServiceCall call, $0.ReviewUpliftApplicationRequest request);

  $async.Future<$0.SelectUpliftApplicationResponse> selectUpliftApplication_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SelectUpliftApplicationRequest> $request) async {
    return selectUpliftApplication($call, await $request);
  }

  $async.Future<$0.SelectUpliftApplicationResponse> selectUpliftApplication(
      $grpc.ServiceCall call, $0.SelectUpliftApplicationRequest request);

  $async.Future<$0.RespondToUpliftOfferResponse> respondToUpliftOffer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RespondToUpliftOfferRequest> $request) async {
    return respondToUpliftOffer($call, await $request);
  }

  $async.Future<$0.RespondToUpliftOfferResponse> respondToUpliftOffer(
      $grpc.ServiceCall call, $0.RespondToUpliftOfferRequest request);

  $async.Future<$0.SubmitMilestoneEvidenceResponse> submitMilestoneEvidence_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SubmitMilestoneEvidenceRequest> $request) async {
    return submitMilestoneEvidence($call, await $request);
  }

  $async.Future<$0.SubmitMilestoneEvidenceResponse> submitMilestoneEvidence(
      $grpc.ServiceCall call, $0.SubmitMilestoneEvidenceRequest request);

  $async.Future<$0.ReviewMilestoneResponse> reviewMilestone_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReviewMilestoneRequest> $request) async {
    return reviewMilestone($call, await $request);
  }

  $async.Future<$0.ReviewMilestoneResponse> reviewMilestone(
      $grpc.ServiceCall call, $0.ReviewMilestoneRequest request);

  $async.Future<$0.ListUpliftMilestoneReleasesResponse>
      listUpliftMilestoneReleases_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ListUpliftMilestoneReleasesRequest> $request) async {
    return listUpliftMilestoneReleases($call, await $request);
  }

  $async.Future<$0.ListUpliftMilestoneReleasesResponse>
      listUpliftMilestoneReleases($grpc.ServiceCall call,
          $0.ListUpliftMilestoneReleasesRequest request);

  $async.Future<$0.ListUpliftEscrowRefundsResponse> listUpliftEscrowRefunds_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListUpliftEscrowRefundsRequest> $request) async {
    return listUpliftEscrowRefunds($call, await $request);
  }

  $async.Future<$0.ListUpliftEscrowRefundsResponse> listUpliftEscrowRefunds(
      $grpc.ServiceCall call, $0.ListUpliftEscrowRefundsRequest request);

  $async.Future<$0.GetUpliftReceiptResponse> getUpliftReceipt_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUpliftReceiptRequest> $request) async {
    return getUpliftReceipt($call, await $request);
  }

  $async.Future<$0.GetUpliftReceiptResponse> getUpliftReceipt(
      $grpc.ServiceCall call, $0.GetUpliftReceiptRequest request);

  $async.Future<$0.ListUpliftReceiptsResponse> listUpliftReceipts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListUpliftReceiptsRequest> $request) async {
    return listUpliftReceipts($call, await $request);
  }

  $async.Future<$0.ListUpliftReceiptsResponse> listUpliftReceipts(
      $grpc.ServiceCall call, $0.ListUpliftReceiptsRequest request);

  $async.Future<$0.GetUpliftStatisticsResponse> getUpliftStatistics_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUpliftStatisticsRequest> $request) async {
    return getUpliftStatistics($call, await $request);
  }

  $async.Future<$0.GetUpliftStatisticsResponse> getUpliftStatistics(
      $grpc.ServiceCall call, $0.GetUpliftStatisticsRequest request);

  $async.Future<$0.GetUpliftFeeQuoteResponse> getUpliftFeeQuote_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUpliftFeeQuoteRequest> $request) async {
    return getUpliftFeeQuote($call, await $request);
  }

  $async.Future<$0.GetUpliftFeeQuoteResponse> getUpliftFeeQuote(
      $grpc.ServiceCall call, $0.GetUpliftFeeQuoteRequest request);
}
