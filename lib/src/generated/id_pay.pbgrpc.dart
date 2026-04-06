///
//  Generated code. Do not modify.
//  source: id_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'id_pay.pb.dart' as $22;
export 'id_pay.pb.dart';

class IDPayServiceClient extends $grpc.Client {
  static final _$createIDPay =
      $grpc.ClientMethod<$22.CreateIDPayRequest, $22.CreateIDPayResponse>(
          '/id_pay.IDPayService/CreateIDPay',
          ($22.CreateIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.CreateIDPayResponse.fromBuffer(value));
  static final _$lookupIDPay =
      $grpc.ClientMethod<$22.LookupIDPayRequest, $22.LookupIDPayResponse>(
          '/id_pay.IDPayService/LookupIDPay',
          ($22.LookupIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.LookupIDPayResponse.fromBuffer(value));
  static final _$payIDPay =
      $grpc.ClientMethod<$22.PayIDPayRequest, $22.PayIDPayResponse>(
          '/id_pay.IDPayService/PayIDPay',
          ($22.PayIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.PayIDPayResponse.fromBuffer(value));
  static final _$getMyIDPays =
      $grpc.ClientMethod<$22.GetMyIDPaysRequest, $22.GetMyIDPaysResponse>(
          '/id_pay.IDPayService/GetMyIDPays',
          ($22.GetMyIDPaysRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.GetMyIDPaysResponse.fromBuffer(value));
  static final _$getIDPayTransactions = $grpc.ClientMethod<
          $22.GetIDPayTransactionsRequest, $22.GetIDPayTransactionsResponse>(
      '/id_pay.IDPayService/GetIDPayTransactions',
      ($22.GetIDPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetIDPayTransactionsResponse.fromBuffer(value));
  static final _$cancelIDPay =
      $grpc.ClientMethod<$22.CancelIDPayRequest, $22.CancelIDPayResponse>(
          '/id_pay.IDPayService/CancelIDPay',
          ($22.CancelIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $22.CancelIDPayResponse.fromBuffer(value));
  static final _$getIDPayDetails = $grpc.ClientMethod<
          $22.GetIDPayDetailsRequest, $22.GetIDPayDetailsResponse>(
      '/id_pay.IDPayService/GetIDPayDetails',
      ($22.GetIDPayDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetIDPayDetailsResponse.fromBuffer(value));
  static final _$createOrganization = $grpc.ClientMethod<
          $22.CreateOrganizationRequest, $22.CreateOrganizationResponse>(
      '/id_pay.IDPayService/CreateOrganization',
      ($22.CreateOrganizationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.CreateOrganizationResponse.fromBuffer(value));
  static final _$getMyOrganizations = $grpc.ClientMethod<
          $22.GetMyOrganizationsRequest, $22.GetMyOrganizationsResponse>(
      '/id_pay.IDPayService/GetMyOrganizations',
      ($22.GetMyOrganizationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetMyOrganizationsResponse.fromBuffer(value));
  static final _$updateOrganization = $grpc.ClientMethod<
          $22.UpdateOrganizationRequest, $22.UpdateOrganizationResponse>(
      '/id_pay.IDPayService/UpdateOrganization',
      ($22.UpdateOrganizationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.UpdateOrganizationResponse.fromBuffer(value));
  static final _$deleteOrganization = $grpc.ClientMethod<
          $22.DeleteOrganizationRequest, $22.DeleteOrganizationResponse>(
      '/id_pay.IDPayService/DeleteOrganization',
      ($22.DeleteOrganizationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.DeleteOrganizationResponse.fromBuffer(value));
  static final _$getOrganizationDetails = $grpc.ClientMethod<
          $22.GetOrganizationDetailsRequest,
          $22.GetOrganizationDetailsResponse>(
      '/id_pay.IDPayService/GetOrganizationDetails',
      ($22.GetOrganizationDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $22.GetOrganizationDetailsResponse.fromBuffer(value));

  IDPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$22.CreateIDPayResponse> createIDPay(
      $22.CreateIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$22.LookupIDPayResponse> lookupIDPay(
      $22.LookupIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$22.PayIDPayResponse> payIDPay(
      $22.PayIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetMyIDPaysResponse> getMyIDPays(
      $22.GetMyIDPaysRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIDPays, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetIDPayTransactionsResponse> getIDPayTransactions(
      $22.GetIDPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$22.CancelIDPayResponse> cancelIDPay(
      $22.CancelIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetIDPayDetailsResponse> getIDPayDetails(
      $22.GetIDPayDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDPayDetails, request, options: options);
  }

  $grpc.ResponseFuture<$22.CreateOrganizationResponse> createOrganization(
      $22.CreateOrganizationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrganization, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetMyOrganizationsResponse> getMyOrganizations(
      $22.GetMyOrganizationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOrganizations, request, options: options);
  }

  $grpc.ResponseFuture<$22.UpdateOrganizationResponse> updateOrganization(
      $22.UpdateOrganizationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateOrganization, request, options: options);
  }

  $grpc.ResponseFuture<$22.DeleteOrganizationResponse> deleteOrganization(
      $22.DeleteOrganizationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteOrganization, request, options: options);
  }

  $grpc.ResponseFuture<$22.GetOrganizationDetailsResponse>
      getOrganizationDetails($22.GetOrganizationDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrganizationDetails, request,
        options: options);
  }
}

abstract class IDPayServiceBase extends $grpc.Service {
  $core.String get $name => 'id_pay.IDPayService';

  IDPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$22.CreateIDPayRequest, $22.CreateIDPayResponse>(
            'CreateIDPay',
            createIDPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.CreateIDPayRequest.fromBuffer(value),
            ($22.CreateIDPayResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.LookupIDPayRequest, $22.LookupIDPayResponse>(
            'LookupIDPay',
            lookupIDPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.LookupIDPayRequest.fromBuffer(value),
            ($22.LookupIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.PayIDPayRequest, $22.PayIDPayResponse>(
        'PayIDPay',
        payIDPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $22.PayIDPayRequest.fromBuffer(value),
        ($22.PayIDPayResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.GetMyIDPaysRequest, $22.GetMyIDPaysResponse>(
            'GetMyIDPays',
            getMyIDPays_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.GetMyIDPaysRequest.fromBuffer(value),
            ($22.GetMyIDPaysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetIDPayTransactionsRequest,
            $22.GetIDPayTransactionsResponse>(
        'GetIDPayTransactions',
        getIDPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetIDPayTransactionsRequest.fromBuffer(value),
        ($22.GetIDPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$22.CancelIDPayRequest, $22.CancelIDPayResponse>(
            'CancelIDPay',
            cancelIDPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $22.CancelIDPayRequest.fromBuffer(value),
            ($22.CancelIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetIDPayDetailsRequest,
            $22.GetIDPayDetailsResponse>(
        'GetIDPayDetails',
        getIDPayDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetIDPayDetailsRequest.fromBuffer(value),
        ($22.GetIDPayDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.CreateOrganizationRequest,
            $22.CreateOrganizationResponse>(
        'CreateOrganization',
        createOrganization_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.CreateOrganizationRequest.fromBuffer(value),
        ($22.CreateOrganizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetMyOrganizationsRequest,
            $22.GetMyOrganizationsResponse>(
        'GetMyOrganizations',
        getMyOrganizations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetMyOrganizationsRequest.fromBuffer(value),
        ($22.GetMyOrganizationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.UpdateOrganizationRequest,
            $22.UpdateOrganizationResponse>(
        'UpdateOrganization',
        updateOrganization_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.UpdateOrganizationRequest.fromBuffer(value),
        ($22.UpdateOrganizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.DeleteOrganizationRequest,
            $22.DeleteOrganizationResponse>(
        'DeleteOrganization',
        deleteOrganization_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.DeleteOrganizationRequest.fromBuffer(value),
        ($22.DeleteOrganizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$22.GetOrganizationDetailsRequest,
            $22.GetOrganizationDetailsResponse>(
        'GetOrganizationDetails',
        getOrganizationDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $22.GetOrganizationDetailsRequest.fromBuffer(value),
        ($22.GetOrganizationDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$22.CreateIDPayResponse> createIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$22.CreateIDPayRequest> request) async {
    return createIDPay(call, await request);
  }

  $async.Future<$22.LookupIDPayResponse> lookupIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$22.LookupIDPayRequest> request) async {
    return lookupIDPay(call, await request);
  }

  $async.Future<$22.PayIDPayResponse> payIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$22.PayIDPayRequest> request) async {
    return payIDPay(call, await request);
  }

  $async.Future<$22.GetMyIDPaysResponse> getMyIDPays_Pre($grpc.ServiceCall call,
      $async.Future<$22.GetMyIDPaysRequest> request) async {
    return getMyIDPays(call, await request);
  }

  $async.Future<$22.GetIDPayTransactionsResponse> getIDPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetIDPayTransactionsRequest> request) async {
    return getIDPayTransactions(call, await request);
  }

  $async.Future<$22.CancelIDPayResponse> cancelIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$22.CancelIDPayRequest> request) async {
    return cancelIDPay(call, await request);
  }

  $async.Future<$22.GetIDPayDetailsResponse> getIDPayDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetIDPayDetailsRequest> request) async {
    return getIDPayDetails(call, await request);
  }

  $async.Future<$22.CreateOrganizationResponse> createOrganization_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.CreateOrganizationRequest> request) async {
    return createOrganization(call, await request);
  }

  $async.Future<$22.GetMyOrganizationsResponse> getMyOrganizations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetMyOrganizationsRequest> request) async {
    return getMyOrganizations(call, await request);
  }

  $async.Future<$22.UpdateOrganizationResponse> updateOrganization_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.UpdateOrganizationRequest> request) async {
    return updateOrganization(call, await request);
  }

  $async.Future<$22.DeleteOrganizationResponse> deleteOrganization_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.DeleteOrganizationRequest> request) async {
    return deleteOrganization(call, await request);
  }

  $async.Future<$22.GetOrganizationDetailsResponse> getOrganizationDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$22.GetOrganizationDetailsRequest> request) async {
    return getOrganizationDetails(call, await request);
  }

  $async.Future<$22.CreateIDPayResponse> createIDPay(
      $grpc.ServiceCall call, $22.CreateIDPayRequest request);
  $async.Future<$22.LookupIDPayResponse> lookupIDPay(
      $grpc.ServiceCall call, $22.LookupIDPayRequest request);
  $async.Future<$22.PayIDPayResponse> payIDPay(
      $grpc.ServiceCall call, $22.PayIDPayRequest request);
  $async.Future<$22.GetMyIDPaysResponse> getMyIDPays(
      $grpc.ServiceCall call, $22.GetMyIDPaysRequest request);
  $async.Future<$22.GetIDPayTransactionsResponse> getIDPayTransactions(
      $grpc.ServiceCall call, $22.GetIDPayTransactionsRequest request);
  $async.Future<$22.CancelIDPayResponse> cancelIDPay(
      $grpc.ServiceCall call, $22.CancelIDPayRequest request);
  $async.Future<$22.GetIDPayDetailsResponse> getIDPayDetails(
      $grpc.ServiceCall call, $22.GetIDPayDetailsRequest request);
  $async.Future<$22.CreateOrganizationResponse> createOrganization(
      $grpc.ServiceCall call, $22.CreateOrganizationRequest request);
  $async.Future<$22.GetMyOrganizationsResponse> getMyOrganizations(
      $grpc.ServiceCall call, $22.GetMyOrganizationsRequest request);
  $async.Future<$22.UpdateOrganizationResponse> updateOrganization(
      $grpc.ServiceCall call, $22.UpdateOrganizationRequest request);
  $async.Future<$22.DeleteOrganizationResponse> deleteOrganization(
      $grpc.ServiceCall call, $22.DeleteOrganizationRequest request);
  $async.Future<$22.GetOrganizationDetailsResponse> getOrganizationDetails(
      $grpc.ServiceCall call, $22.GetOrganizationDetailsRequest request);
}
