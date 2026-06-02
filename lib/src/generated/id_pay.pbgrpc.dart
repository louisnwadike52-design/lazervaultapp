///
//  Generated code. Do not modify.
//  source: id_pay.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'id_pay.pb.dart' as $23;
export 'id_pay.pb.dart';

class IDPayServiceClient extends $grpc.Client {
  static final _$createIDPay =
      $grpc.ClientMethod<$23.CreateIDPayRequest, $23.CreateIDPayResponse>(
          '/id_pay.IDPayService/CreateIDPay',
          ($23.CreateIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.CreateIDPayResponse.fromBuffer(value));
  static final _$lookupIDPay =
      $grpc.ClientMethod<$23.LookupIDPayRequest, $23.LookupIDPayResponse>(
          '/id_pay.IDPayService/LookupIDPay',
          ($23.LookupIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.LookupIDPayResponse.fromBuffer(value));
  static final _$payIDPay =
      $grpc.ClientMethod<$23.PayIDPayRequest, $23.PayIDPayResponse>(
          '/id_pay.IDPayService/PayIDPay',
          ($23.PayIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.PayIDPayResponse.fromBuffer(value));
  static final _$getMyIDPays =
      $grpc.ClientMethod<$23.GetMyIDPaysRequest, $23.GetMyIDPaysResponse>(
          '/id_pay.IDPayService/GetMyIDPays',
          ($23.GetMyIDPaysRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.GetMyIDPaysResponse.fromBuffer(value));
  static final _$getIDPayTransactions = $grpc.ClientMethod<
          $23.GetIDPayTransactionsRequest, $23.GetIDPayTransactionsResponse>(
      '/id_pay.IDPayService/GetIDPayTransactions',
      ($23.GetIDPayTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetIDPayTransactionsResponse.fromBuffer(value));
  static final _$cancelIDPay =
      $grpc.ClientMethod<$23.CancelIDPayRequest, $23.CancelIDPayResponse>(
          '/id_pay.IDPayService/CancelIDPay',
          ($23.CancelIDPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $23.CancelIDPayResponse.fromBuffer(value));
  static final _$getIDPayDetails = $grpc.ClientMethod<
          $23.GetIDPayDetailsRequest, $23.GetIDPayDetailsResponse>(
      '/id_pay.IDPayService/GetIDPayDetails',
      ($23.GetIDPayDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetIDPayDetailsResponse.fromBuffer(value));
  static final _$createOrganization = $grpc.ClientMethod<
          $23.CreateOrganizationRequest, $23.CreateOrganizationResponse>(
      '/id_pay.IDPayService/CreateOrganization',
      ($23.CreateOrganizationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.CreateOrganizationResponse.fromBuffer(value));
  static final _$getMyOrganizations = $grpc.ClientMethod<
          $23.GetMyOrganizationsRequest, $23.GetMyOrganizationsResponse>(
      '/id_pay.IDPayService/GetMyOrganizations',
      ($23.GetMyOrganizationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetMyOrganizationsResponse.fromBuffer(value));
  static final _$updateOrganization = $grpc.ClientMethod<
          $23.UpdateOrganizationRequest, $23.UpdateOrganizationResponse>(
      '/id_pay.IDPayService/UpdateOrganization',
      ($23.UpdateOrganizationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.UpdateOrganizationResponse.fromBuffer(value));
  static final _$deleteOrganization = $grpc.ClientMethod<
          $23.DeleteOrganizationRequest, $23.DeleteOrganizationResponse>(
      '/id_pay.IDPayService/DeleteOrganization',
      ($23.DeleteOrganizationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.DeleteOrganizationResponse.fromBuffer(value));
  static final _$getOrganizationDetails = $grpc.ClientMethod<
          $23.GetOrganizationDetailsRequest,
          $23.GetOrganizationDetailsResponse>(
      '/id_pay.IDPayService/GetOrganizationDetails',
      ($23.GetOrganizationDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $23.GetOrganizationDetailsResponse.fromBuffer(value));

  IDPayServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$23.CreateIDPayResponse> createIDPay(
      $23.CreateIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$23.LookupIDPayResponse> lookupIDPay(
      $23.LookupIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$23.PayIDPayResponse> payIDPay(
      $23.PayIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyIDPaysResponse> getMyIDPays(
      $23.GetMyIDPaysRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyIDPays, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetIDPayTransactionsResponse> getIDPayTransactions(
      $23.GetIDPayTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDPayTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$23.CancelIDPayResponse> cancelIDPay(
      $23.CancelIDPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelIDPay, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetIDPayDetailsResponse> getIDPayDetails(
      $23.GetIDPayDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIDPayDetails, request, options: options);
  }

  $grpc.ResponseFuture<$23.CreateOrganizationResponse> createOrganization(
      $23.CreateOrganizationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOrganization, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetMyOrganizationsResponse> getMyOrganizations(
      $23.GetMyOrganizationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyOrganizations, request, options: options);
  }

  $grpc.ResponseFuture<$23.UpdateOrganizationResponse> updateOrganization(
      $23.UpdateOrganizationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateOrganization, request, options: options);
  }

  $grpc.ResponseFuture<$23.DeleteOrganizationResponse> deleteOrganization(
      $23.DeleteOrganizationRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteOrganization, request, options: options);
  }

  $grpc.ResponseFuture<$23.GetOrganizationDetailsResponse>
      getOrganizationDetails($23.GetOrganizationDetailsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getOrganizationDetails, request,
        options: options);
  }
}

abstract class IDPayServiceBase extends $grpc.Service {
  $core.String get $name => 'id_pay.IDPayService';

  IDPayServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$23.CreateIDPayRequest, $23.CreateIDPayResponse>(
            'CreateIDPay',
            createIDPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.CreateIDPayRequest.fromBuffer(value),
            ($23.CreateIDPayResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.LookupIDPayRequest, $23.LookupIDPayResponse>(
            'LookupIDPay',
            lookupIDPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.LookupIDPayRequest.fromBuffer(value),
            ($23.LookupIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.PayIDPayRequest, $23.PayIDPayResponse>(
        'PayIDPay',
        payIDPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $23.PayIDPayRequest.fromBuffer(value),
        ($23.PayIDPayResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.GetMyIDPaysRequest, $23.GetMyIDPaysResponse>(
            'GetMyIDPays',
            getMyIDPays_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.GetMyIDPaysRequest.fromBuffer(value),
            ($23.GetMyIDPaysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetIDPayTransactionsRequest,
            $23.GetIDPayTransactionsResponse>(
        'GetIDPayTransactions',
        getIDPayTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetIDPayTransactionsRequest.fromBuffer(value),
        ($23.GetIDPayTransactionsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$23.CancelIDPayRequest, $23.CancelIDPayResponse>(
            'CancelIDPay',
            cancelIDPay_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $23.CancelIDPayRequest.fromBuffer(value),
            ($23.CancelIDPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetIDPayDetailsRequest,
            $23.GetIDPayDetailsResponse>(
        'GetIDPayDetails',
        getIDPayDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetIDPayDetailsRequest.fromBuffer(value),
        ($23.GetIDPayDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.CreateOrganizationRequest,
            $23.CreateOrganizationResponse>(
        'CreateOrganization',
        createOrganization_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.CreateOrganizationRequest.fromBuffer(value),
        ($23.CreateOrganizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetMyOrganizationsRequest,
            $23.GetMyOrganizationsResponse>(
        'GetMyOrganizations',
        getMyOrganizations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetMyOrganizationsRequest.fromBuffer(value),
        ($23.GetMyOrganizationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.UpdateOrganizationRequest,
            $23.UpdateOrganizationResponse>(
        'UpdateOrganization',
        updateOrganization_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.UpdateOrganizationRequest.fromBuffer(value),
        ($23.UpdateOrganizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.DeleteOrganizationRequest,
            $23.DeleteOrganizationResponse>(
        'DeleteOrganization',
        deleteOrganization_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.DeleteOrganizationRequest.fromBuffer(value),
        ($23.DeleteOrganizationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$23.GetOrganizationDetailsRequest,
            $23.GetOrganizationDetailsResponse>(
        'GetOrganizationDetails',
        getOrganizationDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $23.GetOrganizationDetailsRequest.fromBuffer(value),
        ($23.GetOrganizationDetailsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$23.CreateIDPayResponse> createIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$23.CreateIDPayRequest> request) async {
    return createIDPay(call, await request);
  }

  $async.Future<$23.LookupIDPayResponse> lookupIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$23.LookupIDPayRequest> request) async {
    return lookupIDPay(call, await request);
  }

  $async.Future<$23.PayIDPayResponse> payIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$23.PayIDPayRequest> request) async {
    return payIDPay(call, await request);
  }

  $async.Future<$23.GetMyIDPaysResponse> getMyIDPays_Pre($grpc.ServiceCall call,
      $async.Future<$23.GetMyIDPaysRequest> request) async {
    return getMyIDPays(call, await request);
  }

  $async.Future<$23.GetIDPayTransactionsResponse> getIDPayTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetIDPayTransactionsRequest> request) async {
    return getIDPayTransactions(call, await request);
  }

  $async.Future<$23.CancelIDPayResponse> cancelIDPay_Pre($grpc.ServiceCall call,
      $async.Future<$23.CancelIDPayRequest> request) async {
    return cancelIDPay(call, await request);
  }

  $async.Future<$23.GetIDPayDetailsResponse> getIDPayDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetIDPayDetailsRequest> request) async {
    return getIDPayDetails(call, await request);
  }

  $async.Future<$23.CreateOrganizationResponse> createOrganization_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.CreateOrganizationRequest> request) async {
    return createOrganization(call, await request);
  }

  $async.Future<$23.GetMyOrganizationsResponse> getMyOrganizations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetMyOrganizationsRequest> request) async {
    return getMyOrganizations(call, await request);
  }

  $async.Future<$23.UpdateOrganizationResponse> updateOrganization_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.UpdateOrganizationRequest> request) async {
    return updateOrganization(call, await request);
  }

  $async.Future<$23.DeleteOrganizationResponse> deleteOrganization_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.DeleteOrganizationRequest> request) async {
    return deleteOrganization(call, await request);
  }

  $async.Future<$23.GetOrganizationDetailsResponse> getOrganizationDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$23.GetOrganizationDetailsRequest> request) async {
    return getOrganizationDetails(call, await request);
  }

  $async.Future<$23.CreateIDPayResponse> createIDPay(
      $grpc.ServiceCall call, $23.CreateIDPayRequest request);
  $async.Future<$23.LookupIDPayResponse> lookupIDPay(
      $grpc.ServiceCall call, $23.LookupIDPayRequest request);
  $async.Future<$23.PayIDPayResponse> payIDPay(
      $grpc.ServiceCall call, $23.PayIDPayRequest request);
  $async.Future<$23.GetMyIDPaysResponse> getMyIDPays(
      $grpc.ServiceCall call, $23.GetMyIDPaysRequest request);
  $async.Future<$23.GetIDPayTransactionsResponse> getIDPayTransactions(
      $grpc.ServiceCall call, $23.GetIDPayTransactionsRequest request);
  $async.Future<$23.CancelIDPayResponse> cancelIDPay(
      $grpc.ServiceCall call, $23.CancelIDPayRequest request);
  $async.Future<$23.GetIDPayDetailsResponse> getIDPayDetails(
      $grpc.ServiceCall call, $23.GetIDPayDetailsRequest request);
  $async.Future<$23.CreateOrganizationResponse> createOrganization(
      $grpc.ServiceCall call, $23.CreateOrganizationRequest request);
  $async.Future<$23.GetMyOrganizationsResponse> getMyOrganizations(
      $grpc.ServiceCall call, $23.GetMyOrganizationsRequest request);
  $async.Future<$23.UpdateOrganizationResponse> updateOrganization(
      $grpc.ServiceCall call, $23.UpdateOrganizationRequest request);
  $async.Future<$23.DeleteOrganizationResponse> deleteOrganization(
      $grpc.ServiceCall call, $23.DeleteOrganizationRequest request);
  $async.Future<$23.GetOrganizationDetailsResponse> getOrganizationDetails(
      $grpc.ServiceCall call, $23.GetOrganizationDetailsRequest request);
}
