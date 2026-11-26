// This is a generated file - do not edit.
//
// Generated from vendor_campaigns.proto.

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

import 'vendor_campaigns.pb.dart' as $0;

export 'vendor_campaigns.pb.dart';

@$pb.GrpcServiceName('financialproducts.VendorCampaignService')
class VendorCampaignServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  VendorCampaignServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Vendor-facing.
  $grpc.ResponseFuture<$0.GetVendorStatusResponse> getVendorStatus(
    $0.GetVendorStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVendorStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListVendorCampaignsResponse> listVendorCampaigns(
    $0.ListVendorCampaignsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listVendorCampaigns, request, options: options);
  }

  $grpc.ResponseFuture<$0.RedeemByQRResponse> redeemByQR(
    $0.RedeemByQRRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$redeemByQR, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListCampaignRedemptionsResponse>
      listCampaignRedemptions(
    $0.ListCampaignRedemptionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listCampaignRedemptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.WithdrawCampaignEarningsResponse>
      withdrawCampaignEarnings(
    $0.WithdrawCampaignEarningsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$withdrawCampaignEarnings, request,
        options: options);
  }

  /// Admin-facing.
  $grpc.ResponseFuture<$0.AdminEnrolVendorResponse> adminEnrolVendor(
    $0.AdminEnrolVendorRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminEnrolVendor, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListVendorsResponse> adminListVendors(
    $0.AdminListVendorsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListVendors, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminSetVendorStatusResponse> adminSetVendorStatus(
    $0.AdminSetVendorStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminSetVendorStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminCreateCampaignResponse> adminCreateCampaign(
    $0.AdminCreateCampaignRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminCreateCampaign, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListCampaignsResponse> adminListCampaigns(
    $0.AdminListCampaignsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminListCampaigns, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminCloseCampaignResponse> adminCloseCampaign(
    $0.AdminCloseCampaignRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminCloseCampaign, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminVendorOverviewResponse> adminVendorOverview(
    $0.AdminVendorOverviewRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$adminVendorOverview, request, options: options);
  }

  // method descriptors

  static final _$getVendorStatus =
      $grpc.ClientMethod<$0.GetVendorStatusRequest, $0.GetVendorStatusResponse>(
          '/financialproducts.VendorCampaignService/GetVendorStatus',
          ($0.GetVendorStatusRequest value) => value.writeToBuffer(),
          $0.GetVendorStatusResponse.fromBuffer);
  static final _$listVendorCampaigns = $grpc.ClientMethod<
          $0.ListVendorCampaignsRequest, $0.ListVendorCampaignsResponse>(
      '/financialproducts.VendorCampaignService/ListVendorCampaigns',
      ($0.ListVendorCampaignsRequest value) => value.writeToBuffer(),
      $0.ListVendorCampaignsResponse.fromBuffer);
  static final _$redeemByQR =
      $grpc.ClientMethod<$0.RedeemByQRRequest, $0.RedeemByQRResponse>(
          '/financialproducts.VendorCampaignService/RedeemByQR',
          ($0.RedeemByQRRequest value) => value.writeToBuffer(),
          $0.RedeemByQRResponse.fromBuffer);
  static final _$listCampaignRedemptions = $grpc.ClientMethod<
          $0.ListCampaignRedemptionsRequest,
          $0.ListCampaignRedemptionsResponse>(
      '/financialproducts.VendorCampaignService/ListCampaignRedemptions',
      ($0.ListCampaignRedemptionsRequest value) => value.writeToBuffer(),
      $0.ListCampaignRedemptionsResponse.fromBuffer);
  static final _$withdrawCampaignEarnings = $grpc.ClientMethod<
          $0.WithdrawCampaignEarningsRequest,
          $0.WithdrawCampaignEarningsResponse>(
      '/financialproducts.VendorCampaignService/WithdrawCampaignEarnings',
      ($0.WithdrawCampaignEarningsRequest value) => value.writeToBuffer(),
      $0.WithdrawCampaignEarningsResponse.fromBuffer);
  static final _$adminEnrolVendor = $grpc.ClientMethod<
          $0.AdminEnrolVendorRequest, $0.AdminEnrolVendorResponse>(
      '/financialproducts.VendorCampaignService/AdminEnrolVendor',
      ($0.AdminEnrolVendorRequest value) => value.writeToBuffer(),
      $0.AdminEnrolVendorResponse.fromBuffer);
  static final _$adminListVendors = $grpc.ClientMethod<
          $0.AdminListVendorsRequest, $0.AdminListVendorsResponse>(
      '/financialproducts.VendorCampaignService/AdminListVendors',
      ($0.AdminListVendorsRequest value) => value.writeToBuffer(),
      $0.AdminListVendorsResponse.fromBuffer);
  static final _$adminSetVendorStatus = $grpc.ClientMethod<
          $0.AdminSetVendorStatusRequest, $0.AdminSetVendorStatusResponse>(
      '/financialproducts.VendorCampaignService/AdminSetVendorStatus',
      ($0.AdminSetVendorStatusRequest value) => value.writeToBuffer(),
      $0.AdminSetVendorStatusResponse.fromBuffer);
  static final _$adminCreateCampaign = $grpc.ClientMethod<
          $0.AdminCreateCampaignRequest, $0.AdminCreateCampaignResponse>(
      '/financialproducts.VendorCampaignService/AdminCreateCampaign',
      ($0.AdminCreateCampaignRequest value) => value.writeToBuffer(),
      $0.AdminCreateCampaignResponse.fromBuffer);
  static final _$adminListCampaigns = $grpc.ClientMethod<
          $0.AdminListCampaignsRequest, $0.AdminListCampaignsResponse>(
      '/financialproducts.VendorCampaignService/AdminListCampaigns',
      ($0.AdminListCampaignsRequest value) => value.writeToBuffer(),
      $0.AdminListCampaignsResponse.fromBuffer);
  static final _$adminCloseCampaign = $grpc.ClientMethod<
          $0.AdminCloseCampaignRequest, $0.AdminCloseCampaignResponse>(
      '/financialproducts.VendorCampaignService/AdminCloseCampaign',
      ($0.AdminCloseCampaignRequest value) => value.writeToBuffer(),
      $0.AdminCloseCampaignResponse.fromBuffer);
  static final _$adminVendorOverview = $grpc.ClientMethod<
          $0.AdminVendorOverviewRequest, $0.AdminVendorOverviewResponse>(
      '/financialproducts.VendorCampaignService/AdminVendorOverview',
      ($0.AdminVendorOverviewRequest value) => value.writeToBuffer(),
      $0.AdminVendorOverviewResponse.fromBuffer);
}

@$pb.GrpcServiceName('financialproducts.VendorCampaignService')
abstract class VendorCampaignServiceBase extends $grpc.Service {
  $core.String get $name => 'financialproducts.VendorCampaignService';

  VendorCampaignServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetVendorStatusRequest,
            $0.GetVendorStatusResponse>(
        'GetVendorStatus',
        getVendorStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVendorStatusRequest.fromBuffer(value),
        ($0.GetVendorStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListVendorCampaignsRequest,
            $0.ListVendorCampaignsResponse>(
        'ListVendorCampaigns',
        listVendorCampaigns_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListVendorCampaignsRequest.fromBuffer(value),
        ($0.ListVendorCampaignsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RedeemByQRRequest, $0.RedeemByQRResponse>(
        'RedeemByQR',
        redeemByQR_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RedeemByQRRequest.fromBuffer(value),
        ($0.RedeemByQRResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListCampaignRedemptionsRequest,
            $0.ListCampaignRedemptionsResponse>(
        'ListCampaignRedemptions',
        listCampaignRedemptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListCampaignRedemptionsRequest.fromBuffer(value),
        ($0.ListCampaignRedemptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WithdrawCampaignEarningsRequest,
            $0.WithdrawCampaignEarningsResponse>(
        'WithdrawCampaignEarnings',
        withdrawCampaignEarnings_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.WithdrawCampaignEarningsRequest.fromBuffer(value),
        ($0.WithdrawCampaignEarningsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminEnrolVendorRequest,
            $0.AdminEnrolVendorResponse>(
        'AdminEnrolVendor',
        adminEnrolVendor_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminEnrolVendorRequest.fromBuffer(value),
        ($0.AdminEnrolVendorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListVendorsRequest,
            $0.AdminListVendorsResponse>(
        'AdminListVendors',
        adminListVendors_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListVendorsRequest.fromBuffer(value),
        ($0.AdminListVendorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminSetVendorStatusRequest,
            $0.AdminSetVendorStatusResponse>(
        'AdminSetVendorStatus',
        adminSetVendorStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminSetVendorStatusRequest.fromBuffer(value),
        ($0.AdminSetVendorStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminCreateCampaignRequest,
            $0.AdminCreateCampaignResponse>(
        'AdminCreateCampaign',
        adminCreateCampaign_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminCreateCampaignRequest.fromBuffer(value),
        ($0.AdminCreateCampaignResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListCampaignsRequest,
            $0.AdminListCampaignsResponse>(
        'AdminListCampaigns',
        adminListCampaigns_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminListCampaignsRequest.fromBuffer(value),
        ($0.AdminListCampaignsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminCloseCampaignRequest,
            $0.AdminCloseCampaignResponse>(
        'AdminCloseCampaign',
        adminCloseCampaign_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminCloseCampaignRequest.fromBuffer(value),
        ($0.AdminCloseCampaignResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminVendorOverviewRequest,
            $0.AdminVendorOverviewResponse>(
        'AdminVendorOverview',
        adminVendorOverview_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.AdminVendorOverviewRequest.fromBuffer(value),
        ($0.AdminVendorOverviewResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetVendorStatusResponse> getVendorStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVendorStatusRequest> $request) async {
    return getVendorStatus($call, await $request);
  }

  $async.Future<$0.GetVendorStatusResponse> getVendorStatus(
      $grpc.ServiceCall call, $0.GetVendorStatusRequest request);

  $async.Future<$0.ListVendorCampaignsResponse> listVendorCampaigns_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListVendorCampaignsRequest> $request) async {
    return listVendorCampaigns($call, await $request);
  }

  $async.Future<$0.ListVendorCampaignsResponse> listVendorCampaigns(
      $grpc.ServiceCall call, $0.ListVendorCampaignsRequest request);

  $async.Future<$0.RedeemByQRResponse> redeemByQR_Pre($grpc.ServiceCall $call,
      $async.Future<$0.RedeemByQRRequest> $request) async {
    return redeemByQR($call, await $request);
  }

  $async.Future<$0.RedeemByQRResponse> redeemByQR(
      $grpc.ServiceCall call, $0.RedeemByQRRequest request);

  $async.Future<$0.ListCampaignRedemptionsResponse> listCampaignRedemptions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListCampaignRedemptionsRequest> $request) async {
    return listCampaignRedemptions($call, await $request);
  }

  $async.Future<$0.ListCampaignRedemptionsResponse> listCampaignRedemptions(
      $grpc.ServiceCall call, $0.ListCampaignRedemptionsRequest request);

  $async.Future<$0.WithdrawCampaignEarningsResponse>
      withdrawCampaignEarnings_Pre($grpc.ServiceCall $call,
          $async.Future<$0.WithdrawCampaignEarningsRequest> $request) async {
    return withdrawCampaignEarnings($call, await $request);
  }

  $async.Future<$0.WithdrawCampaignEarningsResponse> withdrawCampaignEarnings(
      $grpc.ServiceCall call, $0.WithdrawCampaignEarningsRequest request);

  $async.Future<$0.AdminEnrolVendorResponse> adminEnrolVendor_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminEnrolVendorRequest> $request) async {
    return adminEnrolVendor($call, await $request);
  }

  $async.Future<$0.AdminEnrolVendorResponse> adminEnrolVendor(
      $grpc.ServiceCall call, $0.AdminEnrolVendorRequest request);

  $async.Future<$0.AdminListVendorsResponse> adminListVendors_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminListVendorsRequest> $request) async {
    return adminListVendors($call, await $request);
  }

  $async.Future<$0.AdminListVendorsResponse> adminListVendors(
      $grpc.ServiceCall call, $0.AdminListVendorsRequest request);

  $async.Future<$0.AdminSetVendorStatusResponse> adminSetVendorStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminSetVendorStatusRequest> $request) async {
    return adminSetVendorStatus($call, await $request);
  }

  $async.Future<$0.AdminSetVendorStatusResponse> adminSetVendorStatus(
      $grpc.ServiceCall call, $0.AdminSetVendorStatusRequest request);

  $async.Future<$0.AdminCreateCampaignResponse> adminCreateCampaign_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminCreateCampaignRequest> $request) async {
    return adminCreateCampaign($call, await $request);
  }

  $async.Future<$0.AdminCreateCampaignResponse> adminCreateCampaign(
      $grpc.ServiceCall call, $0.AdminCreateCampaignRequest request);

  $async.Future<$0.AdminListCampaignsResponse> adminListCampaigns_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminListCampaignsRequest> $request) async {
    return adminListCampaigns($call, await $request);
  }

  $async.Future<$0.AdminListCampaignsResponse> adminListCampaigns(
      $grpc.ServiceCall call, $0.AdminListCampaignsRequest request);

  $async.Future<$0.AdminCloseCampaignResponse> adminCloseCampaign_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminCloseCampaignRequest> $request) async {
    return adminCloseCampaign($call, await $request);
  }

  $async.Future<$0.AdminCloseCampaignResponse> adminCloseCampaign(
      $grpc.ServiceCall call, $0.AdminCloseCampaignRequest request);

  $async.Future<$0.AdminVendorOverviewResponse> adminVendorOverview_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.AdminVendorOverviewRequest> $request) async {
    return adminVendorOverview($call, await $request);
  }

  $async.Future<$0.AdminVendorOverviewResponse> adminVendorOverview(
      $grpc.ServiceCall call, $0.AdminVendorOverviewRequest request);
}
