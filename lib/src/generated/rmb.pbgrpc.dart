///
//  Generated code. Do not modify.
//  source: rmb.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'rmb.pb.dart' as $0;
export 'rmb.pb.dart';

class RmbServiceClient extends $grpc.Client {
  static final _$getProviderConfig = $grpc.ClientMethod<
          $0.GetProviderConfigRequest, $0.ProviderConfigResponse>(
      '/rmb.RmbService/GetProviderConfig',
      ($0.GetProviderConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ProviderConfigResponse.fromBuffer(value));
  static final _$resolveBanks =
      $grpc.ClientMethod<$0.ResolveBanksRequest, $0.ResolveBanksResponse>(
          '/rmb.RmbService/ResolveBanks',
          ($0.ResolveBanksRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ResolveBanksResponse.fromBuffer(value));
  static final _$getQuote =
      $grpc.ClientMethod<$0.GetQuoteRequest, $0.QuoteResponse>(
          '/rmb.RmbService/GetQuote',
          ($0.GetQuoteRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.QuoteResponse.fromBuffer(value));
  static final _$listBeneficiaries = $grpc.ClientMethod<
          $0.ListBeneficiariesRequest, $0.ListBeneficiariesResponse>(
      '/rmb.RmbService/ListBeneficiaries',
      ($0.ListBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.ListBeneficiariesResponse.fromBuffer(value));
  static final _$saveBeneficiary =
      $grpc.ClientMethod<$0.SaveBeneficiaryRequest, $0.SaveBeneficiaryResponse>(
          '/rmb.RmbService/SaveBeneficiary',
          ($0.SaveBeneficiaryRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SaveBeneficiaryResponse.fromBuffer(value));
  static final _$updateBeneficiary = $grpc.ClientMethod<
          $0.UpdateBeneficiaryRequest, $0.UpdateBeneficiaryResponse>(
      '/rmb.RmbService/UpdateBeneficiary',
      ($0.UpdateBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpdateBeneficiaryResponse.fromBuffer(value));
  static final _$deleteBeneficiary = $grpc.ClientMethod<
          $0.DeleteBeneficiaryRequest, $0.DeleteBeneficiaryResponse>(
      '/rmb.RmbService/DeleteBeneficiary',
      ($0.DeleteBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.DeleteBeneficiaryResponse.fromBuffer(value));
  static final _$favouriteBeneficiary = $grpc.ClientMethod<
          $0.FavouriteBeneficiaryRequest, $0.FavouriteBeneficiaryResponse>(
      '/rmb.RmbService/FavouriteBeneficiary',
      ($0.FavouriteBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.FavouriteBeneficiaryResponse.fromBuffer(value));
  static final _$getComplianceProfile = $grpc.ClientMethod<
          $0.GetComplianceProfileRequest, $0.GetComplianceProfileResponse>(
      '/rmb.RmbService/GetComplianceProfile',
      ($0.GetComplianceProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetComplianceProfileResponse.fromBuffer(value));
  static final _$upsertComplianceProfile = $grpc.ClientMethod<
          $0.UpsertComplianceProfileRequest,
          $0.UpsertComplianceProfileResponse>(
      '/rmb.RmbService/UpsertComplianceProfile',
      ($0.UpsertComplianceProfileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.UpsertComplianceProfileResponse.fromBuffer(value));
  static final _$initiateTransfer = $grpc.ClientMethod<
          $0.InitiateTransferRequest, $0.InitiateTransferResponse>(
      '/rmb.RmbService/InitiateTransfer',
      ($0.InitiateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.InitiateTransferResponse.fromBuffer(value));
  static final _$getTransfer =
      $grpc.ClientMethod<$0.GetTransferRequest, $0.GetTransferResponse>(
          '/rmb.RmbService/GetTransfer',
          ($0.GetTransferRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTransferResponse.fromBuffer(value));
  static final _$listTransfers =
      $grpc.ClientMethod<$0.ListTransfersRequest, $0.ListTransfersResponse>(
          '/rmb.RmbService/ListTransfers',
          ($0.ListTransfersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListTransfersResponse.fromBuffer(value));

  RmbServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.ProviderConfigResponse> getProviderConfig(
      $0.GetProviderConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProviderConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResolveBanksResponse> resolveBanks(
      $0.ResolveBanksRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolveBanks, request, options: options);
  }

  $grpc.ResponseFuture<$0.QuoteResponse> getQuote($0.GetQuoteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQuote, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListBeneficiariesResponse> listBeneficiaries(
      $0.ListBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$0.SaveBeneficiaryResponse> saveBeneficiary(
      $0.SaveBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateBeneficiaryResponse> updateBeneficiary(
      $0.UpdateBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteBeneficiaryResponse> deleteBeneficiary(
      $0.DeleteBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.FavouriteBeneficiaryResponse> favouriteBeneficiary(
      $0.FavouriteBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$favouriteBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetComplianceProfileResponse> getComplianceProfile(
      $0.GetComplianceProfileRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getComplianceProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpsertComplianceProfileResponse>
      upsertComplianceProfile($0.UpsertComplianceProfileRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$upsertComplianceProfile, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.InitiateTransferResponse> initiateTransfer(
      $0.InitiateTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransferResponse> getTransfer(
      $0.GetTransferRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListTransfersResponse> listTransfers(
      $0.ListTransfersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listTransfers, request, options: options);
  }
}

abstract class RmbServiceBase extends $grpc.Service {
  $core.String get $name => 'rmb.RmbService';

  RmbServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetProviderConfigRequest,
            $0.ProviderConfigResponse>(
        'GetProviderConfig',
        getProviderConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetProviderConfigRequest.fromBuffer(value),
        ($0.ProviderConfigResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ResolveBanksRequest, $0.ResolveBanksResponse>(
            'ResolveBanks',
            resolveBanks_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ResolveBanksRequest.fromBuffer(value),
            ($0.ResolveBanksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetQuoteRequest, $0.QuoteResponse>(
        'GetQuote',
        getQuote_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetQuoteRequest.fromBuffer(value),
        ($0.QuoteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListBeneficiariesRequest,
            $0.ListBeneficiariesResponse>(
        'ListBeneficiaries',
        listBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListBeneficiariesRequest.fromBuffer(value),
        ($0.ListBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveBeneficiaryRequest,
            $0.SaveBeneficiaryResponse>(
        'SaveBeneficiary',
        saveBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SaveBeneficiaryRequest.fromBuffer(value),
        ($0.SaveBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBeneficiaryRequest,
            $0.UpdateBeneficiaryResponse>(
        'UpdateBeneficiary',
        updateBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteBeneficiaryRequest,
            $0.DeleteBeneficiaryResponse>(
        'DeleteBeneficiary',
        deleteBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FavouriteBeneficiaryRequest,
            $0.FavouriteBeneficiaryResponse>(
        'FavouriteBeneficiary',
        favouriteBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.FavouriteBeneficiaryRequest.fromBuffer(value),
        ($0.FavouriteBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetComplianceProfileRequest,
            $0.GetComplianceProfileResponse>(
        'GetComplianceProfile',
        getComplianceProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetComplianceProfileRequest.fromBuffer(value),
        ($0.GetComplianceProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpsertComplianceProfileRequest,
            $0.UpsertComplianceProfileResponse>(
        'UpsertComplianceProfile',
        upsertComplianceProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpsertComplianceProfileRequest.fromBuffer(value),
        ($0.UpsertComplianceProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateTransferRequest,
            $0.InitiateTransferResponse>(
        'InitiateTransfer',
        initiateTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateTransferRequest.fromBuffer(value),
        ($0.InitiateTransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetTransferRequest, $0.GetTransferResponse>(
            'GetTransfer',
            getTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTransferRequest.fromBuffer(value),
            ($0.GetTransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListTransfersRequest, $0.ListTransfersResponse>(
            'ListTransfers',
            listTransfers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListTransfersRequest.fromBuffer(value),
            ($0.ListTransfersResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ProviderConfigResponse> getProviderConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetProviderConfigRequest> request) async {
    return getProviderConfig(call, await request);
  }

  $async.Future<$0.ResolveBanksResponse> resolveBanks_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ResolveBanksRequest> request) async {
    return resolveBanks(call, await request);
  }

  $async.Future<$0.QuoteResponse> getQuote_Pre(
      $grpc.ServiceCall call, $async.Future<$0.GetQuoteRequest> request) async {
    return getQuote(call, await request);
  }

  $async.Future<$0.ListBeneficiariesResponse> listBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListBeneficiariesRequest> request) async {
    return listBeneficiaries(call, await request);
  }

  $async.Future<$0.SaveBeneficiaryResponse> saveBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SaveBeneficiaryRequest> request) async {
    return saveBeneficiary(call, await request);
  }

  $async.Future<$0.UpdateBeneficiaryResponse> updateBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateBeneficiaryRequest> request) async {
    return updateBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteBeneficiaryResponse> deleteBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteBeneficiaryRequest> request) async {
    return deleteBeneficiary(call, await request);
  }

  $async.Future<$0.FavouriteBeneficiaryResponse> favouriteBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.FavouriteBeneficiaryRequest> request) async {
    return favouriteBeneficiary(call, await request);
  }

  $async.Future<$0.GetComplianceProfileResponse> getComplianceProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetComplianceProfileRequest> request) async {
    return getComplianceProfile(call, await request);
  }

  $async.Future<$0.UpsertComplianceProfileResponse> upsertComplianceProfile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpsertComplianceProfileRequest> request) async {
    return upsertComplianceProfile(call, await request);
  }

  $async.Future<$0.InitiateTransferResponse> initiateTransfer_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.InitiateTransferRequest> request) async {
    return initiateTransfer(call, await request);
  }

  $async.Future<$0.GetTransferResponse> getTransfer_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetTransferRequest> request) async {
    return getTransfer(call, await request);
  }

  $async.Future<$0.ListTransfersResponse> listTransfers_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListTransfersRequest> request) async {
    return listTransfers(call, await request);
  }

  $async.Future<$0.ProviderConfigResponse> getProviderConfig(
      $grpc.ServiceCall call, $0.GetProviderConfigRequest request);
  $async.Future<$0.ResolveBanksResponse> resolveBanks(
      $grpc.ServiceCall call, $0.ResolveBanksRequest request);
  $async.Future<$0.QuoteResponse> getQuote(
      $grpc.ServiceCall call, $0.GetQuoteRequest request);
  $async.Future<$0.ListBeneficiariesResponse> listBeneficiaries(
      $grpc.ServiceCall call, $0.ListBeneficiariesRequest request);
  $async.Future<$0.SaveBeneficiaryResponse> saveBeneficiary(
      $grpc.ServiceCall call, $0.SaveBeneficiaryRequest request);
  $async.Future<$0.UpdateBeneficiaryResponse> updateBeneficiary(
      $grpc.ServiceCall call, $0.UpdateBeneficiaryRequest request);
  $async.Future<$0.DeleteBeneficiaryResponse> deleteBeneficiary(
      $grpc.ServiceCall call, $0.DeleteBeneficiaryRequest request);
  $async.Future<$0.FavouriteBeneficiaryResponse> favouriteBeneficiary(
      $grpc.ServiceCall call, $0.FavouriteBeneficiaryRequest request);
  $async.Future<$0.GetComplianceProfileResponse> getComplianceProfile(
      $grpc.ServiceCall call, $0.GetComplianceProfileRequest request);
  $async.Future<$0.UpsertComplianceProfileResponse> upsertComplianceProfile(
      $grpc.ServiceCall call, $0.UpsertComplianceProfileRequest request);
  $async.Future<$0.InitiateTransferResponse> initiateTransfer(
      $grpc.ServiceCall call, $0.InitiateTransferRequest request);
  $async.Future<$0.GetTransferResponse> getTransfer(
      $grpc.ServiceCall call, $0.GetTransferRequest request);
  $async.Future<$0.ListTransfersResponse> listTransfers(
      $grpc.ServiceCall call, $0.ListTransfersRequest request);
}
