// This is a generated file - do not edit.
//
// Generated from transaction_pin.proto.

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

import 'transaction_pin.pb.dart' as $0;

export 'transaction_pin.pb.dart';

/// TransactionPinService handles transaction PIN operations
@$pb.GrpcServiceName('auth.TransactionPinService')
class TransactionPinServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TransactionPinServiceClient(super.channel,
      {super.options, super.interceptors});

  /// CreateTransactionPin creates a new transaction PIN for a user
  $grpc.ResponseFuture<$0.CreateTransactionPinResponse> createTransactionPin(
    $0.CreateTransactionPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createTransactionPin, request, options: options);
  }

  /// VerifyTransactionPin verifies a PIN before processing a payment
  $grpc.ResponseFuture<$0.VerifyTransactionPinResponse> verifyTransactionPin(
    $0.VerifyTransactionPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyTransactionPin, request, options: options);
  }

  /// ChangeTransactionPin changes an existing PIN
  $grpc.ResponseFuture<$0.ChangeTransactionPinResponse> changeTransactionPin(
    $0.ChangeTransactionPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$changeTransactionPin, request, options: options);
  }

  /// ResetTransactionPin resets a PIN with proper verification
  $grpc.ResponseFuture<$0.ResetTransactionPinResponse> resetTransactionPin(
    $0.ResetTransactionPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resetTransactionPin, request, options: options);
  }

  /// CheckUserHasPin checks if a user has a transaction PIN set up
  $grpc.ResponseFuture<$0.CheckUserHasPinResponse> checkUserHasPin(
    $0.CheckUserHasPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkUserHasPin, request, options: options);
  }

  /// ValidateTransactionPinToken validates a token issued after PIN verification
  $grpc.ResponseFuture<$0.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken(
    $0.ValidateTransactionPinTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateTransactionPinToken, request,
        options: options);
  }

  /// InitiatePinOTP sends a 6-digit OTP code via email or SMS for PIN operations
  $grpc.ResponseFuture<$0.InitiatePinOTPResponse> initiatePinOTP(
    $0.InitiatePinOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiatePinOTP, request, options: options);
  }

  /// VerifyPinOTP verifies the OTP and executes the PIN operation (create/change)
  $grpc.ResponseFuture<$0.VerifyPinOTPResponse> verifyPinOTP(
    $0.VerifyPinOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyPinOTP, request, options: options);
  }

  /// GetPinOTPChannels returns available OTP delivery channels for the user
  $grpc.ResponseFuture<$0.GetPinOTPChannelsResponse> getPinOTPChannels(
    $0.GetPinOTPChannelsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPinOTPChannels, request, options: options);
  }

  /// CompleteForgotPin verifies OTP and resets the PIN (forgot PIN flow)
  $grpc.ResponseFuture<$0.CompleteForgotPinResponse> completeForgotPin(
    $0.CompleteForgotPinRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$completeForgotPin, request, options: options);
  }

  /// GetUserChannelPins returns PIN setup status for all channels
  $grpc.ResponseFuture<$0.GetUserChannelPinsResponse> getUserChannelPins(
    $0.GetUserChannelPinsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserChannelPins, request, options: options);
  }

  /// CreateChannelRegistration registers a user for a banking channel
  $grpc.ResponseFuture<$0.CreateChannelRegistrationResponse>
      createChannelRegistration(
    $0.CreateChannelRegistrationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createChannelRegistration, request,
        options: options);
  }

  /// VerifyChannelOTP verifies OTP for channel registration
  $grpc.ResponseFuture<$0.VerifyChannelOTPResponse> verifyChannelOTP(
    $0.VerifyChannelOTPRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyChannelOTP, request, options: options);
  }

  /// GetChannelRegistrations gets all channel registrations for a user
  $grpc.ResponseFuture<$0.GetChannelRegistrationsResponse>
      getChannelRegistrations(
    $0.GetChannelRegistrationsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getChannelRegistrations, request,
        options: options);
  }

  /// DeactivateChannel deactivates a banking channel
  $grpc.ResponseFuture<$0.DeactivateChannelResponse> deactivateChannel(
    $0.DeactivateChannelRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deactivateChannel, request, options: options);
  }

  /// ResolvePhoneToUser resolves a phone number to a user ID (service-to-service)
  $grpc.ResponseFuture<$0.ResolvePhoneToUserResponse> resolvePhoneToUser(
    $0.ResolvePhoneToUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$resolvePhoneToUser, request, options: options);
  }

  // method descriptors

  static final _$createTransactionPin = $grpc.ClientMethod<
          $0.CreateTransactionPinRequest, $0.CreateTransactionPinResponse>(
      '/auth.TransactionPinService/CreateTransactionPin',
      ($0.CreateTransactionPinRequest value) => value.writeToBuffer(),
      $0.CreateTransactionPinResponse.fromBuffer);
  static final _$verifyTransactionPin = $grpc.ClientMethod<
          $0.VerifyTransactionPinRequest, $0.VerifyTransactionPinResponse>(
      '/auth.TransactionPinService/VerifyTransactionPin',
      ($0.VerifyTransactionPinRequest value) => value.writeToBuffer(),
      $0.VerifyTransactionPinResponse.fromBuffer);
  static final _$changeTransactionPin = $grpc.ClientMethod<
          $0.ChangeTransactionPinRequest, $0.ChangeTransactionPinResponse>(
      '/auth.TransactionPinService/ChangeTransactionPin',
      ($0.ChangeTransactionPinRequest value) => value.writeToBuffer(),
      $0.ChangeTransactionPinResponse.fromBuffer);
  static final _$resetTransactionPin = $grpc.ClientMethod<
          $0.ResetTransactionPinRequest, $0.ResetTransactionPinResponse>(
      '/auth.TransactionPinService/ResetTransactionPin',
      ($0.ResetTransactionPinRequest value) => value.writeToBuffer(),
      $0.ResetTransactionPinResponse.fromBuffer);
  static final _$checkUserHasPin =
      $grpc.ClientMethod<$0.CheckUserHasPinRequest, $0.CheckUserHasPinResponse>(
          '/auth.TransactionPinService/CheckUserHasPin',
          ($0.CheckUserHasPinRequest value) => value.writeToBuffer(),
          $0.CheckUserHasPinResponse.fromBuffer);
  static final _$validateTransactionPinToken = $grpc.ClientMethod<
          $0.ValidateTransactionPinTokenRequest,
          $0.ValidateTransactionPinTokenResponse>(
      '/auth.TransactionPinService/ValidateTransactionPinToken',
      ($0.ValidateTransactionPinTokenRequest value) => value.writeToBuffer(),
      $0.ValidateTransactionPinTokenResponse.fromBuffer);
  static final _$initiatePinOTP =
      $grpc.ClientMethod<$0.InitiatePinOTPRequest, $0.InitiatePinOTPResponse>(
          '/auth.TransactionPinService/InitiatePinOTP',
          ($0.InitiatePinOTPRequest value) => value.writeToBuffer(),
          $0.InitiatePinOTPResponse.fromBuffer);
  static final _$verifyPinOTP =
      $grpc.ClientMethod<$0.VerifyPinOTPRequest, $0.VerifyPinOTPResponse>(
          '/auth.TransactionPinService/VerifyPinOTP',
          ($0.VerifyPinOTPRequest value) => value.writeToBuffer(),
          $0.VerifyPinOTPResponse.fromBuffer);
  static final _$getPinOTPChannels = $grpc.ClientMethod<
          $0.GetPinOTPChannelsRequest, $0.GetPinOTPChannelsResponse>(
      '/auth.TransactionPinService/GetPinOTPChannels',
      ($0.GetPinOTPChannelsRequest value) => value.writeToBuffer(),
      $0.GetPinOTPChannelsResponse.fromBuffer);
  static final _$completeForgotPin = $grpc.ClientMethod<
          $0.CompleteForgotPinRequest, $0.CompleteForgotPinResponse>(
      '/auth.TransactionPinService/CompleteForgotPin',
      ($0.CompleteForgotPinRequest value) => value.writeToBuffer(),
      $0.CompleteForgotPinResponse.fromBuffer);
  static final _$getUserChannelPins = $grpc.ClientMethod<
          $0.GetUserChannelPinsRequest, $0.GetUserChannelPinsResponse>(
      '/auth.TransactionPinService/GetUserChannelPins',
      ($0.GetUserChannelPinsRequest value) => value.writeToBuffer(),
      $0.GetUserChannelPinsResponse.fromBuffer);
  static final _$createChannelRegistration = $grpc.ClientMethod<
          $0.CreateChannelRegistrationRequest,
          $0.CreateChannelRegistrationResponse>(
      '/auth.TransactionPinService/CreateChannelRegistration',
      ($0.CreateChannelRegistrationRequest value) => value.writeToBuffer(),
      $0.CreateChannelRegistrationResponse.fromBuffer);
  static final _$verifyChannelOTP = $grpc.ClientMethod<
          $0.VerifyChannelOTPRequest, $0.VerifyChannelOTPResponse>(
      '/auth.TransactionPinService/VerifyChannelOTP',
      ($0.VerifyChannelOTPRequest value) => value.writeToBuffer(),
      $0.VerifyChannelOTPResponse.fromBuffer);
  static final _$getChannelRegistrations = $grpc.ClientMethod<
          $0.GetChannelRegistrationsRequest,
          $0.GetChannelRegistrationsResponse>(
      '/auth.TransactionPinService/GetChannelRegistrations',
      ($0.GetChannelRegistrationsRequest value) => value.writeToBuffer(),
      $0.GetChannelRegistrationsResponse.fromBuffer);
  static final _$deactivateChannel = $grpc.ClientMethod<
          $0.DeactivateChannelRequest, $0.DeactivateChannelResponse>(
      '/auth.TransactionPinService/DeactivateChannel',
      ($0.DeactivateChannelRequest value) => value.writeToBuffer(),
      $0.DeactivateChannelResponse.fromBuffer);
  static final _$resolvePhoneToUser = $grpc.ClientMethod<
          $0.ResolvePhoneToUserRequest, $0.ResolvePhoneToUserResponse>(
      '/auth.TransactionPinService/ResolvePhoneToUser',
      ($0.ResolvePhoneToUserRequest value) => value.writeToBuffer(),
      $0.ResolvePhoneToUserResponse.fromBuffer);
}

@$pb.GrpcServiceName('auth.TransactionPinService')
abstract class TransactionPinServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.TransactionPinService';

  TransactionPinServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateTransactionPinRequest,
            $0.CreateTransactionPinResponse>(
        'CreateTransactionPin',
        createTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateTransactionPinRequest.fromBuffer(value),
        ($0.CreateTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyTransactionPinRequest,
            $0.VerifyTransactionPinResponse>(
        'VerifyTransactionPin',
        verifyTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyTransactionPinRequest.fromBuffer(value),
        ($0.VerifyTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ChangeTransactionPinRequest,
            $0.ChangeTransactionPinResponse>(
        'ChangeTransactionPin',
        changeTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ChangeTransactionPinRequest.fromBuffer(value),
        ($0.ChangeTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResetTransactionPinRequest,
            $0.ResetTransactionPinResponse>(
        'ResetTransactionPin',
        resetTransactionPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResetTransactionPinRequest.fromBuffer(value),
        ($0.ResetTransactionPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckUserHasPinRequest,
            $0.CheckUserHasPinResponse>(
        'CheckUserHasPin',
        checkUserHasPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CheckUserHasPinRequest.fromBuffer(value),
        ($0.CheckUserHasPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateTransactionPinTokenRequest,
            $0.ValidateTransactionPinTokenResponse>(
        'ValidateTransactionPinToken',
        validateTransactionPinToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateTransactionPinTokenRequest.fromBuffer(value),
        ($0.ValidateTransactionPinTokenResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiatePinOTPRequest,
            $0.InitiatePinOTPResponse>(
        'InitiatePinOTP',
        initiatePinOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiatePinOTPRequest.fromBuffer(value),
        ($0.InitiatePinOTPResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.VerifyPinOTPRequest, $0.VerifyPinOTPResponse>(
            'VerifyPinOTP',
            verifyPinOTP_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.VerifyPinOTPRequest.fromBuffer(value),
            ($0.VerifyPinOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPinOTPChannelsRequest,
            $0.GetPinOTPChannelsResponse>(
        'GetPinOTPChannels',
        getPinOTPChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPinOTPChannelsRequest.fromBuffer(value),
        ($0.GetPinOTPChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CompleteForgotPinRequest,
            $0.CompleteForgotPinResponse>(
        'CompleteForgotPin',
        completeForgotPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CompleteForgotPinRequest.fromBuffer(value),
        ($0.CompleteForgotPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserChannelPinsRequest,
            $0.GetUserChannelPinsResponse>(
        'GetUserChannelPins',
        getUserChannelPins_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserChannelPinsRequest.fromBuffer(value),
        ($0.GetUserChannelPinsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateChannelRegistrationRequest,
            $0.CreateChannelRegistrationResponse>(
        'CreateChannelRegistration',
        createChannelRegistration_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateChannelRegistrationRequest.fromBuffer(value),
        ($0.CreateChannelRegistrationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyChannelOTPRequest,
            $0.VerifyChannelOTPResponse>(
        'VerifyChannelOTP',
        verifyChannelOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyChannelOTPRequest.fromBuffer(value),
        ($0.VerifyChannelOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetChannelRegistrationsRequest,
            $0.GetChannelRegistrationsResponse>(
        'GetChannelRegistrations',
        getChannelRegistrations_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetChannelRegistrationsRequest.fromBuffer(value),
        ($0.GetChannelRegistrationsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeactivateChannelRequest,
            $0.DeactivateChannelResponse>(
        'DeactivateChannel',
        deactivateChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeactivateChannelRequest.fromBuffer(value),
        ($0.DeactivateChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResolvePhoneToUserRequest,
            $0.ResolvePhoneToUserResponse>(
        'ResolvePhoneToUser',
        resolvePhoneToUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ResolvePhoneToUserRequest.fromBuffer(value),
        ($0.ResolvePhoneToUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateTransactionPinResponse> createTransactionPin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateTransactionPinRequest> $request) async {
    return createTransactionPin($call, await $request);
  }

  $async.Future<$0.CreateTransactionPinResponse> createTransactionPin(
      $grpc.ServiceCall call, $0.CreateTransactionPinRequest request);

  $async.Future<$0.VerifyTransactionPinResponse> verifyTransactionPin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyTransactionPinRequest> $request) async {
    return verifyTransactionPin($call, await $request);
  }

  $async.Future<$0.VerifyTransactionPinResponse> verifyTransactionPin(
      $grpc.ServiceCall call, $0.VerifyTransactionPinRequest request);

  $async.Future<$0.ChangeTransactionPinResponse> changeTransactionPin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ChangeTransactionPinRequest> $request) async {
    return changeTransactionPin($call, await $request);
  }

  $async.Future<$0.ChangeTransactionPinResponse> changeTransactionPin(
      $grpc.ServiceCall call, $0.ChangeTransactionPinRequest request);

  $async.Future<$0.ResetTransactionPinResponse> resetTransactionPin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResetTransactionPinRequest> $request) async {
    return resetTransactionPin($call, await $request);
  }

  $async.Future<$0.ResetTransactionPinResponse> resetTransactionPin(
      $grpc.ServiceCall call, $0.ResetTransactionPinRequest request);

  $async.Future<$0.CheckUserHasPinResponse> checkUserHasPin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckUserHasPinRequest> $request) async {
    return checkUserHasPin($call, await $request);
  }

  $async.Future<$0.CheckUserHasPinResponse> checkUserHasPin(
      $grpc.ServiceCall call, $0.CheckUserHasPinRequest request);

  $async.Future<$0.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken_Pre($grpc.ServiceCall $call,
          $async.Future<$0.ValidateTransactionPinTokenRequest> $request) async {
    return validateTransactionPinToken($call, await $request);
  }

  $async.Future<$0.ValidateTransactionPinTokenResponse>
      validateTransactionPinToken($grpc.ServiceCall call,
          $0.ValidateTransactionPinTokenRequest request);

  $async.Future<$0.InitiatePinOTPResponse> initiatePinOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InitiatePinOTPRequest> $request) async {
    return initiatePinOTP($call, await $request);
  }

  $async.Future<$0.InitiatePinOTPResponse> initiatePinOTP(
      $grpc.ServiceCall call, $0.InitiatePinOTPRequest request);

  $async.Future<$0.VerifyPinOTPResponse> verifyPinOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyPinOTPRequest> $request) async {
    return verifyPinOTP($call, await $request);
  }

  $async.Future<$0.VerifyPinOTPResponse> verifyPinOTP(
      $grpc.ServiceCall call, $0.VerifyPinOTPRequest request);

  $async.Future<$0.GetPinOTPChannelsResponse> getPinOTPChannels_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPinOTPChannelsRequest> $request) async {
    return getPinOTPChannels($call, await $request);
  }

  $async.Future<$0.GetPinOTPChannelsResponse> getPinOTPChannels(
      $grpc.ServiceCall call, $0.GetPinOTPChannelsRequest request);

  $async.Future<$0.CompleteForgotPinResponse> completeForgotPin_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CompleteForgotPinRequest> $request) async {
    return completeForgotPin($call, await $request);
  }

  $async.Future<$0.CompleteForgotPinResponse> completeForgotPin(
      $grpc.ServiceCall call, $0.CompleteForgotPinRequest request);

  $async.Future<$0.GetUserChannelPinsResponse> getUserChannelPins_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserChannelPinsRequest> $request) async {
    return getUserChannelPins($call, await $request);
  }

  $async.Future<$0.GetUserChannelPinsResponse> getUserChannelPins(
      $grpc.ServiceCall call, $0.GetUserChannelPinsRequest request);

  $async.Future<$0.CreateChannelRegistrationResponse>
      createChannelRegistration_Pre($grpc.ServiceCall $call,
          $async.Future<$0.CreateChannelRegistrationRequest> $request) async {
    return createChannelRegistration($call, await $request);
  }

  $async.Future<$0.CreateChannelRegistrationResponse> createChannelRegistration(
      $grpc.ServiceCall call, $0.CreateChannelRegistrationRequest request);

  $async.Future<$0.VerifyChannelOTPResponse> verifyChannelOTP_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyChannelOTPRequest> $request) async {
    return verifyChannelOTP($call, await $request);
  }

  $async.Future<$0.VerifyChannelOTPResponse> verifyChannelOTP(
      $grpc.ServiceCall call, $0.VerifyChannelOTPRequest request);

  $async.Future<$0.GetChannelRegistrationsResponse> getChannelRegistrations_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetChannelRegistrationsRequest> $request) async {
    return getChannelRegistrations($call, await $request);
  }

  $async.Future<$0.GetChannelRegistrationsResponse> getChannelRegistrations(
      $grpc.ServiceCall call, $0.GetChannelRegistrationsRequest request);

  $async.Future<$0.DeactivateChannelResponse> deactivateChannel_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DeactivateChannelRequest> $request) async {
    return deactivateChannel($call, await $request);
  }

  $async.Future<$0.DeactivateChannelResponse> deactivateChannel(
      $grpc.ServiceCall call, $0.DeactivateChannelRequest request);

  $async.Future<$0.ResolvePhoneToUserResponse> resolvePhoneToUser_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ResolvePhoneToUserRequest> $request) async {
    return resolvePhoneToUser($call, await $request);
  }

  $async.Future<$0.ResolvePhoneToUserResponse> resolvePhoneToUser(
      $grpc.ServiceCall call, $0.ResolvePhoneToUserRequest request);
}
