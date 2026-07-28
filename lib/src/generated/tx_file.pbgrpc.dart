// This is a generated file - do not edit.
//
// Generated from tx_file.proto.

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

import 'tx_file.pb.dart' as $0;

export 'tx_file.pb.dart';

/// Defines the service for getting transaction file URLs/Paths.
@$pb.GrpcServiceName('pb.TxFileService')
class TxFileServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  TxFileServiceClient(super.channel, {super.options, super.interceptors});

  /// Retrieves the pre-generated Signed URL for the user's transaction data file.
  $grpc.ResponseFuture<$0.GetUserTxFileUrlResponse> getUserTxFileUrl(
    $0.GetUserTxFileUrlRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserTxFileUrl, request, options: options);
  }

  // method descriptors

  static final _$getUserTxFileUrl = $grpc.ClientMethod<
          $0.GetUserTxFileUrlRequest, $0.GetUserTxFileUrlResponse>(
      '/pb.TxFileService/GetUserTxFileUrl',
      ($0.GetUserTxFileUrlRequest value) => value.writeToBuffer(),
      $0.GetUserTxFileUrlResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.TxFileService')
abstract class TxFileServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TxFileService';

  TxFileServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetUserTxFileUrlRequest,
            $0.GetUserTxFileUrlResponse>(
        'GetUserTxFileUrl',
        getUserTxFileUrl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserTxFileUrlRequest.fromBuffer(value),
        ($0.GetUserTxFileUrlResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserTxFileUrlResponse> getUserTxFileUrl_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserTxFileUrlRequest> $request) async {
    return getUserTxFileUrl($call, await $request);
  }

  $async.Future<$0.GetUserTxFileUrlResponse> getUserTxFileUrl(
      $grpc.ServiceCall call, $0.GetUserTxFileUrlRequest request);
}
