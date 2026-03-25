// This is a generated file - do not edit.
//
// Generated from generate_tx_data.proto.

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

import 'generate_tx_data.pb.dart' as $0;

export 'generate_tx_data.pb.dart';

/// Service definition
@$pb.GrpcServiceName('pb.GenerateTxDataService')
class GenerateTxDataServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  GenerateTxDataServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GenerateUserTxDataFileResponse>
      generateUserTxDataFile(
    $0.GenerateUserTxDataFileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateUserTxDataFile, request,
        options: options);
  }

  // method descriptors

  static final _$generateUserTxDataFile = $grpc.ClientMethod<
          $0.GenerateUserTxDataFileRequest, $0.GenerateUserTxDataFileResponse>(
      '/pb.GenerateTxDataService/GenerateUserTxDataFile',
      ($0.GenerateUserTxDataFileRequest value) => value.writeToBuffer(),
      $0.GenerateUserTxDataFileResponse.fromBuffer);
}

@$pb.GrpcServiceName('pb.GenerateTxDataService')
abstract class GenerateTxDataServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GenerateTxDataService';

  GenerateTxDataServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GenerateUserTxDataFileRequest,
            $0.GenerateUserTxDataFileResponse>(
        'GenerateUserTxDataFile',
        generateUserTxDataFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GenerateUserTxDataFileRequest.fromBuffer(value),
        ($0.GenerateUserTxDataFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GenerateUserTxDataFileResponse> generateUserTxDataFile_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GenerateUserTxDataFileRequest> $request) async {
    return generateUserTxDataFile($call, await $request);
  }

  $async.Future<$0.GenerateUserTxDataFileResponse> generateUserTxDataFile(
      $grpc.ServiceCall call, $0.GenerateUserTxDataFileRequest request);
}
