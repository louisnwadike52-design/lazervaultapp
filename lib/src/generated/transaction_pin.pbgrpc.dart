///
//  Generated code. Do not modify.
//  source: transaction_pin.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'transaction_pin.pb.dart' as $38;
export 'transaction_pin.pb.dart';

class TransactionPinServiceClient extends $grpc.Client {
  static final _$createTransactionPin = $grpc.ClientMethod<
          $38.CreateTransactionPinRequest, $38.CreateTransactionPinResponse>(
      '/pb.TransactionPinService/CreateTransactionPin',
      ($38.CreateTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.CreateTransactionPinResponse.fromBuffer(value));
  static final _$verifyTransactionPin = $grpc.ClientMethod<
          $38.VerifyTransactionPinRequest, $38.VerifyTransactionPinResponse>(
      '/pb.TransactionPinService/VerifyTransactionPin',
      ($38.VerifyTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.VerifyTransactionPinResponse.fromBuffer(value));
  static final _$changeTransactionPin = $grpc.ClientMethod<
          $38.ChangeTransactionPinRequest, $38.ChangeTransactionPinResponse>(
      '/pb.TransactionPinService/ChangeTransactionPin',
      ($38.ChangeTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.ChangeTransactionPinResponse.fromBuffer(value));
  static final _$resetTransactionPin = $grpc.ClientMethod<
          $38.ResetTransactionPinRequest, $38.ResetTransactionPinResponse>(
      '/pb.TransactionPinService/ResetTransactionPin',
      ($38.ResetTransactionPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.ResetTransactionPinResponse.fromBuffer(value));
  static final _$checkUserHasPin = $grpc.ClientMethod<
          $38.CheckUserHasPinRequest, $38.CheckUserHasPinResponse>(
      '/pb.TransactionPinService/CheckUserHasPin',
      ($38.CheckUserHasPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.CheckUserHasPinResponse.fromBuffer(value));
  static final _$validateTransactionPinToken = $grpc.ClientMethod<
          $38.ValidateTransactionPinTokenRequest,
          $38.ValidateTransactionPinTokenResponse>(
      '/pb.TransactionPinService/ValidateTransactionPinToken',
      ($38.ValidateTransactionPinTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.ValidateTransactionPinTokenResponse.fromBuffer(value));
  static final _$initiatePinOTP =
      $grpc.ClientMethod<$38.InitiatePinOTPRequest, $38.InitiatePinOTPResponse>(
          '/pb.TransactionPinService/InitiatePinOTP',
          ($38.InitiatePinOTPRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $38.InitiatePinOTPResponse.fromBuffer(value));
  static final _$verifyPinOTP =
      $grpc.ClientMethod<$38.VerifyPinOTPRequest, $38.VerifyPinOTPResponse>(
          '/pb.TransactionPinService/VerifyPinOTP',
          ($38.VerifyPinOTPRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $38.VerifyPinOTPResponse.fromBuffer(value));
  static final _$getPinOTPChannels = $grpc.ClientMethod<
          $38.GetPinOTPChannelsRequest, $38.GetPinOTPChannelsResponse>(
      '/pb.TransactionPinService/GetPinOTPChannels',
      ($38.GetPinOTPChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetPinOTPChannelsResponse.fromBuffer(value));
  static final _$completeForgotPin = $grpc.ClientMethod<
          $38.CompleteForgotPinRequest, $38.CompleteForgotPinResponse>(
      '/pb.TransactionPinService/CompleteForgotPin',
      ($38.CompleteForgotPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.CompleteForgotPinResponse.fromBuffer(value));
  static final _$getUserChannelPins = $grpc.ClientMethod<
          $38.GetUserChannelPinsRequest, $38.GetUserChannelPinsResponse>(
      '/pb.TransactionPinService/GetUserChannelPins',
      ($38.GetUserChannelPinsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetUserChannelPinsResponse.fromBuffer(value));
  static final _$createChannelRegistration = $grpc.ClientMethod<
          $38.CreateChannelRegistrationRequest,
          $38.CreateChannelRegistrationResponse>(
      '/pb.TransactionPinService/CreateChannelRegistration',
      ($38.CreateChannelRegistrationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.CreateChannelRegistrationResponse.fromBuffer(value));
  static final _$verifyChannelOTP = $grpc.ClientMethod<
          $38.VerifyChannelOTPRequest, $38.VerifyChannelOTPResponse>(
      '/pb.TransactionPinService/VerifyChannelOTP',
      ($38.VerifyChannelOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.VerifyChannelOTPResponse.fromBuffer(value));
  static final _$getChannelRegistrations = $grpc.ClientMethod<
          $38.GetChannelRegistrationsRequest,
          $38.GetChannelRegistrationsResponse>(
      '/pb.TransactionPinService/GetChannelRegistrations',
      ($38.GetChannelRegistrationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.GetChannelRegistrationsResponse.fromBuffer(value));
  static final _$deactivateChannel = $grpc.ClientMethod<
          $38.DeactivateChannelRequest, $38.DeactivateChannelResponse>(
      '/pb.TransactionPinService/DeactivateChannel',
      ($38.DeactivateChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.DeactivateChannelResponse.fromBuffer(value));
  static final _$resolvePhoneToUser = $grpc.ClientMethod<
          $38.ResolvePhoneToUserRequest, $38.ResolvePhoneToUserResponse>(
      '/pb.TransactionPinService/ResolvePhoneToUser',
      ($38.ResolvePhoneToUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $38.ResolvePhoneToUserResponse.fromBuffer(value));

  TransactionPinServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$38.CreateTransactionPinResponse> createTransactionPin(
      $38.CreateTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$38.VerifyTransactionPinResponse> verifyTransactionPin(
      $38.VerifyTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$38.ChangeTransactionPinResponse> changeTransactionPin(
      $38.ChangeTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$changeTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$38.ResetTransactionPinResponse> resetTransactionPin(
      $38.ResetTransactionPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetTransactionPin, request, options: options);
  }

  $grpc.ResponseFuture<$38.CheckUserHasPinResponse> checkUserHasPin(
      $38.CheckUserHasPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkUserHasPin, request, options: options);
  }

  $grpc.ResponseFuture<$38.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken(
          $38.ValidateTransactionPinTokenRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateTransactionPinToken, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.InitiatePinOTPResponse> initiatePinOTP(
      $38.InitiatePinOTPRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePinOTP, request, options: options);
  }

  $grpc.ResponseFuture<$38.VerifyPinOTPResponse> verifyPinOTP(
      $38.VerifyPinOTPRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPinOTP, request, options: options);
  }

  $grpc.ResponseFuture<$38.GetPinOTPChannelsResponse> getPinOTPChannels(
      $38.GetPinOTPChannelsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPinOTPChannels, request, options: options);
  }

  $grpc.ResponseFuture<$38.CompleteForgotPinResponse> completeForgotPin(
      $38.CompleteForgotPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$completeForgotPin, request, options: options);
  }

  $grpc.ResponseFuture<$38.GetUserChannelPinsResponse> getUserChannelPins(
      $38.GetUserChannelPinsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserChannelPins, request, options: options);
  }

  $grpc.ResponseFuture<$38.CreateChannelRegistrationResponse>
      createChannelRegistration($38.CreateChannelRegistrationRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createChannelRegistration, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.VerifyChannelOTPResponse> verifyChannelOTP(
      $38.VerifyChannelOTPRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyChannelOTP, request, options: options);
  }

  $grpc.ResponseFuture<$38.GetChannelRegistrationsResponse>
      getChannelRegistrations($38.GetChannelRegistrationsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChannelRegistrations, request,
        options: options);
  }

  $grpc.ResponseFuture<$38.DeactivateChannelResponse> deactivateChannel(
      $38.DeactivateChannelRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deactivateChannel, request, options: options);
  }

  $grpc.ResponseFuture<$38.ResolvePhoneToUserResponse> resolvePhoneToUser(
      $38.ResolvePhoneToUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resolvePhoneToUser, request, options: options);
  }
}

abstract class TransactionPinServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TransactionPinService';

  TransactionPinServiceBase() {
    $addMethod($grpc.ServiceMethod<$38.CreateTransactionPinRequest,
            $38.CreateTransactionPinResponse>(
        'CreateTransactionPin',
        createTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.CreateTransactionPinRequest.fromBuffer(value),
        ($38.CreateTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.VerifyTransactionPinRequest,
            $38.VerifyTransactionPinResponse>(
        'VerifyTransactionPin',
        verifyTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.VerifyTransactionPinRequest.fromBuffer(value),
        ($38.VerifyTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.ChangeTransactionPinRequest,
            $38.ChangeTransactionPinResponse>(
        'ChangeTransactionPin',
        changeTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.ChangeTransactionPinRequest.fromBuffer(value),
        ($38.ChangeTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.ResetTransactionPinRequest,
            $38.ResetTransactionPinResponse>(
        'ResetTransactionPin',
        resetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.ResetTransactionPinRequest.fromBuffer(value),
        ($38.ResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.CheckUserHasPinRequest,
            $38.CheckUserHasPinResponse>(
        'CheckUserHasPin',
        checkUserHasPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.CheckUserHasPinRequest.fromBuffer(value),
        ($38.CheckUserHasPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.ValidateTransactionPinTokenRequest,
            $38.ValidateTransactionPinTokenResponse>(
        'ValidateTransactionPinToken',
        validateTransactionPinToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.ValidateTransactionPinTokenRequest.fromBuffer(value),
        ($38.ValidateTransactionPinTokenResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.InitiatePinOTPRequest,
            $38.InitiatePinOTPResponse>(
        'InitiatePinOTP',
        initiatePinOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.InitiatePinOTPRequest.fromBuffer(value),
        ($38.InitiatePinOTPResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$38.VerifyPinOTPRequest, $38.VerifyPinOTPResponse>(
            'VerifyPinOTP',
            verifyPinOTP_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $38.VerifyPinOTPRequest.fromBuffer(value),
            ($38.VerifyPinOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetPinOTPChannelsRequest,
            $38.GetPinOTPChannelsResponse>(
        'GetPinOTPChannels',
        getPinOTPChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetPinOTPChannelsRequest.fromBuffer(value),
        ($38.GetPinOTPChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.CompleteForgotPinRequest,
            $38.CompleteForgotPinResponse>(
        'CompleteForgotPin',
        completeForgotPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.CompleteForgotPinRequest.fromBuffer(value),
        ($38.CompleteForgotPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetUserChannelPinsRequest,
            $38.GetUserChannelPinsResponse>(
        'GetUserChannelPins',
        getUserChannelPins_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetUserChannelPinsRequest.fromBuffer(value),
        ($38.GetUserChannelPinsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.CreateChannelRegistrationRequest,
            $38.CreateChannelRegistrationResponse>(
        'CreateChannelRegistration',
        createChannelRegistration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.CreateChannelRegistrationRequest.fromBuffer(value),
        ($38.CreateChannelRegistrationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.VerifyChannelOTPRequest,
            $38.VerifyChannelOTPResponse>(
        'VerifyChannelOTP',
        verifyChannelOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.VerifyChannelOTPRequest.fromBuffer(value),
        ($38.VerifyChannelOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.GetChannelRegistrationsRequest,
            $38.GetChannelRegistrationsResponse>(
        'GetChannelRegistrations',
        getChannelRegistrations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.GetChannelRegistrationsRequest.fromBuffer(value),
        ($38.GetChannelRegistrationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.DeactivateChannelRequest,
            $38.DeactivateChannelResponse>(
        'DeactivateChannel',
        deactivateChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.DeactivateChannelRequest.fromBuffer(value),
        ($38.DeactivateChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$38.ResolvePhoneToUserRequest,
            $38.ResolvePhoneToUserResponse>(
        'ResolvePhoneToUser',
        resolvePhoneToUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $38.ResolvePhoneToUserRequest.fromBuffer(value),
        ($38.ResolvePhoneToUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$38.CreateTransactionPinResponse> createTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.CreateTransactionPinRequest> request) async {
    return createTransactionPin(call, await request);
  }

  $async.Future<$38.VerifyTransactionPinResponse> verifyTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.VerifyTransactionPinRequest> request) async {
    return verifyTransactionPin(call, await request);
  }

  $async.Future<$38.ChangeTransactionPinResponse> changeTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.ChangeTransactionPinRequest> request) async {
    return changeTransactionPin(call, await request);
  }

  $async.Future<$38.ResetTransactionPinResponse> resetTransactionPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.ResetTransactionPinRequest> request) async {
    return resetTransactionPin(call, await request);
  }

  $async.Future<$38.CheckUserHasPinResponse> checkUserHasPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.CheckUserHasPinRequest> request) async {
    return checkUserHasPin(call, await request);
  }

  $async.Future<$38.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken_Pre($grpc.ServiceCall call,
          $async.Future<$38.ValidateTransactionPinTokenRequest> request) async {
    return validateTransactionPinToken(call, await request);
  }

  $async.Future<$38.InitiatePinOTPResponse> initiatePinOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.InitiatePinOTPRequest> request) async {
    return initiatePinOTP(call, await request);
  }

  $async.Future<$38.VerifyPinOTPResponse> verifyPinOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.VerifyPinOTPRequest> request) async {
    return verifyPinOTP(call, await request);
  }

  $async.Future<$38.GetPinOTPChannelsResponse> getPinOTPChannels_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.GetPinOTPChannelsRequest> request) async {
    return getPinOTPChannels(call, await request);
  }

  $async.Future<$38.CompleteForgotPinResponse> completeForgotPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.CompleteForgotPinRequest> request) async {
    return completeForgotPin(call, await request);
  }

  $async.Future<$38.GetUserChannelPinsResponse> getUserChannelPins_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.GetUserChannelPinsRequest> request) async {
    return getUserChannelPins(call, await request);
  }

  $async.Future<$38.CreateChannelRegistrationResponse>
      createChannelRegistration_Pre($grpc.ServiceCall call,
          $async.Future<$38.CreateChannelRegistrationRequest> request) async {
    return createChannelRegistration(call, await request);
  }

  $async.Future<$38.VerifyChannelOTPResponse> verifyChannelOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.VerifyChannelOTPRequest> request) async {
    return verifyChannelOTP(call, await request);
  }

  $async.Future<$38.GetChannelRegistrationsResponse>
      getChannelRegistrations_Pre($grpc.ServiceCall call,
          $async.Future<$38.GetChannelRegistrationsRequest> request) async {
    return getChannelRegistrations(call, await request);
  }

  $async.Future<$38.DeactivateChannelResponse> deactivateChannel_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.DeactivateChannelRequest> request) async {
    return deactivateChannel(call, await request);
  }

  $async.Future<$38.ResolvePhoneToUserResponse> resolvePhoneToUser_Pre(
      $grpc.ServiceCall call,
      $async.Future<$38.ResolvePhoneToUserRequest> request) async {
    return resolvePhoneToUser(call, await request);
  }

  $async.Future<$38.CreateTransactionPinResponse> createTransactionPin(
      $grpc.ServiceCall call, $38.CreateTransactionPinRequest request);
  $async.Future<$38.VerifyTransactionPinResponse> verifyTransactionPin(
      $grpc.ServiceCall call, $38.VerifyTransactionPinRequest request);
  $async.Future<$38.ChangeTransactionPinResponse> changeTransactionPin(
      $grpc.ServiceCall call, $38.ChangeTransactionPinRequest request);
  $async.Future<$38.ResetTransactionPinResponse> resetTransactionPin(
      $grpc.ServiceCall call, $38.ResetTransactionPinRequest request);
  $async.Future<$38.CheckUserHasPinResponse> checkUserHasPin(
      $grpc.ServiceCall call, $38.CheckUserHasPinRequest request);
  $async.Future<$38.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken($grpc.ServiceCall call,
          $38.ValidateTransactionPinTokenRequest request);
  $async.Future<$38.InitiatePinOTPResponse> initiatePinOTP(
      $grpc.ServiceCall call, $38.InitiatePinOTPRequest request);
  $async.Future<$38.VerifyPinOTPResponse> verifyPinOTP(
      $grpc.ServiceCall call, $38.VerifyPinOTPRequest request);
  $async.Future<$38.GetPinOTPChannelsResponse> getPinOTPChannels(
      $grpc.ServiceCall call, $38.GetPinOTPChannelsRequest request);
  $async.Future<$38.CompleteForgotPinResponse> completeForgotPin(
      $grpc.ServiceCall call, $38.CompleteForgotPinRequest request);
  $async.Future<$38.GetUserChannelPinsResponse> getUserChannelPins(
      $grpc.ServiceCall call, $38.GetUserChannelPinsRequest request);
  $async.Future<$38.CreateChannelRegistrationResponse>
      createChannelRegistration(
          $grpc.ServiceCall call, $38.CreateChannelRegistrationRequest request);
  $async.Future<$38.VerifyChannelOTPResponse> verifyChannelOTP(
      $grpc.ServiceCall call, $38.VerifyChannelOTPRequest request);
  $async.Future<$38.GetChannelRegistrationsResponse> getChannelRegistrations(
      $grpc.ServiceCall call, $38.GetChannelRegistrationsRequest request);
  $async.Future<$38.DeactivateChannelResponse> deactivateChannel(
      $grpc.ServiceCall call, $38.DeactivateChannelRequest request);
  $async.Future<$38.ResolvePhoneToUserResponse> resolvePhoneToUser(
      $grpc.ServiceCall call, $38.ResolvePhoneToUserRequest request);
}
