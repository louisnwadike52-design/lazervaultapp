///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_pin.pb.dart' as $39;
export 'transaction_pin.pb.dart';

class TransactionPinServiceClient extends $grpc.Client {
  static final _$createTransactionPin = $grpc.ClientMethod<
          $39.CreateTransactionPinRequest, $39.CreateTransactionPinResponse>(
      '/pb.TransactionPinService/CreateTransactionPin',
      ($39.CreateTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.CreateTransactionPinResponse.fromBuffer(value));
  static final _$verifyTransactionPin = $grpc.ClientMethod<
          $39.VerifyTransactionPinRequest, $39.VerifyTransactionPinResponse>(
      '/pb.TransactionPinService/VerifyTransactionPin',
      ($39.VerifyTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.VerifyTransactionPinResponse.fromBuffer(value));
  static final _$changeTransactionPin = $grpc.ClientMethod<
          $39.ChangeTransactionPinRequest, $39.ChangeTransactionPinResponse>(
      '/pb.TransactionPinService/ChangeTransactionPin',
      ($39.ChangeTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ChangeTransactionPinResponse.fromBuffer(value));
  static final _$resetTransactionPin = $grpc.ClientMethod<
          $39.ResetTransactionPinRequest, $39.ResetTransactionPinResponse>(
      '/pb.TransactionPinService/ResetTransactionPin',
      ($39.ResetTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ResetTransactionPinResponse.fromBuffer(value));
  static final _$checkUserHasPin = $grpc.ClientMethod<
          $39.CheckUserHasPinRequest, $39.CheckUserHasPinResponse>(
      '/pb.TransactionPinService/CheckUserHasPin',
      ($39.CheckUserHasPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.CheckUserHasPinResponse.fromBuffer(value));
  static final _$validateTransactionPinToken = $grpc.ClientMethod<
          $39.ValidateTransactionPinTokenRequest,
          $39.ValidateTransactionPinTokenResponse>(
      '/pb.TransactionPinService/ValidateTransactionPinToken',
      ($39.ValidateTransactionPinTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ValidateTransactionPinTokenResponse.fromBuffer(value));
  static final _$initiatePinOTP =
      $grpc.ClientMethod<$39.InitiatePinOTPRequest, $39.InitiatePinOTPResponse>(
          '/pb.TransactionPinService/InitiatePinOTP',
          ($39.InitiatePinOTPRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $39.InitiatePinOTPResponse.fromBuffer(value));
  static final _$verifyPinOTP =
      $grpc.ClientMethod<$39.VerifyPinOTPRequest, $39.VerifyPinOTPResponse>(
          '/pb.TransactionPinService/VerifyPinOTP',
          ($39.VerifyPinOTPRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $39.VerifyPinOTPResponse.fromBuffer(value));
  static final _$getPinOTPChannels = $grpc.ClientMethod<
          $39.GetPinOTPChannelsRequest, $39.GetPinOTPChannelsResponse>(
      '/pb.TransactionPinService/GetPinOTPChannels',
      ($39.GetPinOTPChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.GetPinOTPChannelsResponse.fromBuffer(value));
  static final _$completeForgotPin = $grpc.ClientMethod<
          $39.CompleteForgotPinRequest, $39.CompleteForgotPinResponse>(
      '/pb.TransactionPinService/CompleteForgotPin',
      ($39.CompleteForgotPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.CompleteForgotPinResponse.fromBuffer(value));
  static final _$getUserChannelPins = $grpc.ClientMethod<
          $39.GetUserChannelPinsRequest, $39.GetUserChannelPinsResponse>(
      '/pb.TransactionPinService/GetUserChannelPins',
      ($39.GetUserChannelPinsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.GetUserChannelPinsResponse.fromBuffer(value));
  static final _$createChannelRegistration = $grpc.ClientMethod<
          $39.CreateChannelRegistrationRequest,
          $39.CreateChannelRegistrationResponse>(
      '/pb.TransactionPinService/CreateChannelRegistration',
      ($39.CreateChannelRegistrationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.CreateChannelRegistrationResponse.fromBuffer(value));
  static final _$verifyChannelOTP = $grpc.ClientMethod<
          $39.VerifyChannelOTPRequest, $39.VerifyChannelOTPResponse>(
      '/pb.TransactionPinService/VerifyChannelOTP',
      ($39.VerifyChannelOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.VerifyChannelOTPResponse.fromBuffer(value));
  static final _$getChannelRegistrations = $grpc.ClientMethod<
          $39.GetChannelRegistrationsRequest,
          $39.GetChannelRegistrationsResponse>(
      '/pb.TransactionPinService/GetChannelRegistrations',
      ($39.GetChannelRegistrationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.GetChannelRegistrationsResponse.fromBuffer(value));
  static final _$deactivateChannel = $grpc.ClientMethod<
          $39.DeactivateChannelRequest, $39.DeactivateChannelResponse>(
      '/pb.TransactionPinService/DeactivateChannel',
      ($39.DeactivateChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.DeactivateChannelResponse.fromBuffer(value));
  static final _$resolvePhoneToUser = $grpc.ClientMethod<
          $39.ResolvePhoneToUserRequest, $39.ResolvePhoneToUserResponse>(
      '/pb.TransactionPinService/ResolvePhoneToUser',
      ($39.ResolvePhoneToUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ResolvePhoneToUserResponse.fromBuffer(value));

  TransactionPinServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$39.CreateTransactionPinResponse> createTransactionPin(
      $39.CreateTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$39.VerifyTransactionPinResponse> verifyTransactionPin(
      $39.VerifyTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$39.ChangeTransactionPinResponse> changeTransactionPin(
      $39.ChangeTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$39.ResetTransactionPinResponse> resetTransactionPin(
      $39.ResetTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$39.CheckUserHasPinResponse> checkUserHasPin(
      $39.CheckUserHasPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkUserHasPin, request, options: options);
  }

  $grpc.ResponseFuture<$39.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken(
          $39.ValidateTransactionPinTokenRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateTransactionPinToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$39.InitiatePinOTPResponse> initiatePinOTP(
      $39.InitiatePinOTPRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePinOTP, request, options: options);
  }

  $grpc.ResponseFuture<$39.VerifyPinOTPResponse> verifyPinOTP(
      $39.VerifyPinOTPRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPinOTP, request, options: options);
  }

  $grpc.ResponseFuture<$39.GetPinOTPChannelsResponse> getPinOTPChannels(
      $39.GetPinOTPChannelsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPinOTPChannels, request, options: options);
  }

  $grpc.ResponseFuture<$39.CompleteForgotPinResponse> completeForgotPin(
      $39.CompleteForgotPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeForgotPin, request, options: options);
  }

  $grpc.ResponseFuture<$39.GetUserChannelPinsResponse> getUserChannelPins(
      $39.GetUserChannelPinsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserChannelPins, request, options: options);
  }

  $grpc.ResponseFuture<$39.CreateChannelRegistrationResponse>
      createChannelRegistration($39.CreateChannelRegistrationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createChannelRegistration, request,
        options: options);
  }

  $grpc.ResponseFuture<$39.VerifyChannelOTPResponse> verifyChannelOTP(
      $39.VerifyChannelOTPRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyChannelOTP, request, options: options);
  }

  $grpc.ResponseFuture<$39.GetChannelRegistrationsResponse>
      getChannelRegistrations($39.GetChannelRegistrationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChannelRegistrations, request,
        options: options);
  }

  $grpc.ResponseFuture<$39.DeactivateChannelResponse> deactivateChannel(
      $39.DeactivateChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deactivateChannel, request, options: options);
  }

  $grpc.ResponseFuture<$39.ResolvePhoneToUserResponse> resolvePhoneToUser(
      $39.ResolvePhoneToUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolvePhoneToUser, request, options: options);
  }
}

abstract class TransactionPinServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransactionPinService';

  TransactionPinServiceBase() {
    $addMethod($grpc.ServiceMethod<$39.CreateTransactionPinRequest,
            $39.CreateTransactionPinResponse>(
        'CreateTransactionPin',
        createTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.CreateTransactionPinRequest.fromBuffer(value),
        ($39.CreateTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.VerifyTransactionPinRequest,
            $39.VerifyTransactionPinResponse>(
        'VerifyTransactionPin',
        verifyTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.VerifyTransactionPinRequest.fromBuffer(value),
        ($39.VerifyTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ChangeTransactionPinRequest,
            $39.ChangeTransactionPinResponse>(
        'ChangeTransactionPin',
        changeTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ChangeTransactionPinRequest.fromBuffer(value),
        ($39.ChangeTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ResetTransactionPinRequest,
            $39.ResetTransactionPinResponse>(
        'ResetTransactionPin',
        resetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ResetTransactionPinRequest.fromBuffer(value),
        ($39.ResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.CheckUserHasPinRequest,
            $39.CheckUserHasPinResponse>(
        'CheckUserHasPin',
        checkUserHasPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.CheckUserHasPinRequest.fromBuffer(value),
        ($39.CheckUserHasPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ValidateTransactionPinTokenRequest,
            $39.ValidateTransactionPinTokenResponse>(
        'ValidateTransactionPinToken',
        validateTransactionPinToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ValidateTransactionPinTokenRequest.fromBuffer(value),
        ($39.ValidateTransactionPinTokenResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.InitiatePinOTPRequest,
            $39.InitiatePinOTPResponse>(
        'InitiatePinOTP',
        initiatePinOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.InitiatePinOTPRequest.fromBuffer(value),
        ($39.InitiatePinOTPResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.VerifyPinOTPRequest, $39.VerifyPinOTPResponse>(
            'VerifyPinOTP',
            verifyPinOTP_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.VerifyPinOTPRequest.fromBuffer(value),
            ($39.VerifyPinOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetPinOTPChannelsRequest,
            $39.GetPinOTPChannelsResponse>(
        'GetPinOTPChannels',
        getPinOTPChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetPinOTPChannelsRequest.fromBuffer(value),
        ($39.GetPinOTPChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.CompleteForgotPinRequest,
            $39.CompleteForgotPinResponse>(
        'CompleteForgotPin',
        completeForgotPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.CompleteForgotPinRequest.fromBuffer(value),
        ($39.CompleteForgotPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetUserChannelPinsRequest,
            $39.GetUserChannelPinsResponse>(
        'GetUserChannelPins',
        getUserChannelPins_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetUserChannelPinsRequest.fromBuffer(value),
        ($39.GetUserChannelPinsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.CreateChannelRegistrationRequest,
            $39.CreateChannelRegistrationResponse>(
        'CreateChannelRegistration',
        createChannelRegistration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.CreateChannelRegistrationRequest.fromBuffer(value),
        ($39.CreateChannelRegistrationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.VerifyChannelOTPRequest,
            $39.VerifyChannelOTPResponse>(
        'VerifyChannelOTP',
        verifyChannelOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.VerifyChannelOTPRequest.fromBuffer(value),
        ($39.VerifyChannelOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetChannelRegistrationsRequest,
            $39.GetChannelRegistrationsResponse>(
        'GetChannelRegistrations',
        getChannelRegistrations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetChannelRegistrationsRequest.fromBuffer(value),
        ($39.GetChannelRegistrationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.DeactivateChannelRequest,
            $39.DeactivateChannelResponse>(
        'DeactivateChannel',
        deactivateChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.DeactivateChannelRequest.fromBuffer(value),
        ($39.DeactivateChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ResolvePhoneToUserRequest,
            $39.ResolvePhoneToUserResponse>(
        'ResolvePhoneToUser',
        resolvePhoneToUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ResolvePhoneToUserRequest.fromBuffer(value),
        ($39.ResolvePhoneToUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$39.CreateTransactionPinResponse> createTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.CreateTransactionPinRequest> request) async {
    return createTransactionPin(call, await request);
  }

  $async.Future<$39.VerifyTransactionPinResponse> verifyTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.VerifyTransactionPinRequest> request) async {
    return verifyTransactionPin(call, await request);
  }

  $async.Future<$39.ChangeTransactionPinResponse> changeTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ChangeTransactionPinRequest> request) async {
    return changeTransactionPin(call, await request);
  }

  $async.Future<$39.ResetTransactionPinResponse> resetTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ResetTransactionPinRequest> request) async {
    return resetTransactionPin(call, await request);
  }

  $async.Future<$39.CheckUserHasPinResponse> checkUserHasPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.CheckUserHasPinRequest> request) async {
    return checkUserHasPin(call, await request);
  }

  $async.Future<$39.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken_Pre($grpc.ServiceCall call,
          $async.Future<$39.ValidateTransactionPinTokenRequest> request) async {
    return validateTransactionPinToken(call, await request);
  }

  $async.Future<$39.InitiatePinOTPResponse> initiatePinOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.InitiatePinOTPRequest> request) async {
    return initiatePinOTP(call, await request);
  }

  $async.Future<$39.VerifyPinOTPResponse> verifyPinOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.VerifyPinOTPRequest> request) async {
    return verifyPinOTP(call, await request);
  }

  $async.Future<$39.GetPinOTPChannelsResponse> getPinOTPChannels_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GetPinOTPChannelsRequest> request) async {
    return getPinOTPChannels(call, await request);
  }

  $async.Future<$39.CompleteForgotPinResponse> completeForgotPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.CompleteForgotPinRequest> request) async {
    return completeForgotPin(call, await request);
  }

  $async.Future<$39.GetUserChannelPinsResponse> getUserChannelPins_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GetUserChannelPinsRequest> request) async {
    return getUserChannelPins(call, await request);
  }

  $async.Future<$39.CreateChannelRegistrationResponse>
      createChannelRegistration_Pre($grpc.ServiceCall call,
          $async.Future<$39.CreateChannelRegistrationRequest> request) async {
    return createChannelRegistration(call, await request);
  }

  $async.Future<$39.VerifyChannelOTPResponse> verifyChannelOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.VerifyChannelOTPRequest> request) async {
    return verifyChannelOTP(call, await request);
  }

  $async.Future<$39.GetChannelRegistrationsResponse>
      getChannelRegistrations_Pre($grpc.ServiceCall call,
          $async.Future<$39.GetChannelRegistrationsRequest> request) async {
    return getChannelRegistrations(call, await request);
  }

  $async.Future<$39.DeactivateChannelResponse> deactivateChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.DeactivateChannelRequest> request) async {
    return deactivateChannel(call, await request);
  }

  $async.Future<$39.ResolvePhoneToUserResponse> resolvePhoneToUser_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ResolvePhoneToUserRequest> request) async {
    return resolvePhoneToUser(call, await request);
  }

  $async.Future<$39.CreateTransactionPinResponse> createTransactionPin(
      $grpc.ServiceCall call, $39.CreateTransactionPinRequest request);
  $async.Future<$39.VerifyTransactionPinResponse> verifyTransactionPin(
      $grpc.ServiceCall call, $39.VerifyTransactionPinRequest request);
  $async.Future<$39.ChangeTransactionPinResponse> changeTransactionPin(
      $grpc.ServiceCall call, $39.ChangeTransactionPinRequest request);
  $async.Future<$39.ResetTransactionPinResponse> resetTransactionPin(
      $grpc.ServiceCall call, $39.ResetTransactionPinRequest request);
  $async.Future<$39.CheckUserHasPinResponse> checkUserHasPin(
      $grpc.ServiceCall call, $39.CheckUserHasPinRequest request);
  $async.Future<$39.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken($grpc.ServiceCall call,
          $39.ValidateTransactionPinTokenRequest request);
  $async.Future<$39.InitiatePinOTPResponse> initiatePinOTP(
      $grpc.ServiceCall call, $39.InitiatePinOTPRequest request);
  $async.Future<$39.VerifyPinOTPResponse> verifyPinOTP(
      $grpc.ServiceCall call, $39.VerifyPinOTPRequest request);
  $async.Future<$39.GetPinOTPChannelsResponse> getPinOTPChannels(
      $grpc.ServiceCall call, $39.GetPinOTPChannelsRequest request);
  $async.Future<$39.CompleteForgotPinResponse> completeForgotPin(
      $grpc.ServiceCall call, $39.CompleteForgotPinRequest request);
  $async.Future<$39.GetUserChannelPinsResponse> getUserChannelPins(
      $grpc.ServiceCall call, $39.GetUserChannelPinsRequest request);
  $async.Future<$39.CreateChannelRegistrationResponse>
      createChannelRegistration(
          $grpc.ServiceCall call, $39.CreateChannelRegistrationRequest request);
  $async.Future<$39.VerifyChannelOTPResponse> verifyChannelOTP(
      $grpc.ServiceCall call, $39.VerifyChannelOTPRequest request);
  $async.Future<$39.GetChannelRegistrationsResponse> getChannelRegistrations(
      $grpc.ServiceCall call, $39.GetChannelRegistrationsRequest request);
  $async.Future<$39.DeactivateChannelResponse> deactivateChannel(
      $grpc.ServiceCall call, $39.DeactivateChannelRequest request);
  $async.Future<$39.ResolvePhoneToUserResponse> resolvePhoneToUser(
      $grpc.ServiceCall call, $39.ResolvePhoneToUserRequest request);
}
