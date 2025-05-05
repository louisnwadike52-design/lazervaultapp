//
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'generate_tx_data.pb.dart' as $8;

export 'generate_tx_data.pb.dart';

@$pb.GrpcServiceName('pb.GenerateTxDataService')
class GenerateTxDataServiceClient extends $grpc.Client {
  static final _$generateUserTxDataFile = $grpc.ClientMethod<$8.GenerateUserTxDataFileRequest, $8.GenerateUserTxDataFileResponse>(
      '/pb.GenerateTxDataService/GenerateUserTxDataFile',
      ($8.GenerateUserTxDataFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $8.GenerateUserTxDataFileResponse.fromBuffer(value));

  GenerateTxDataServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$8.GenerateUserTxDataFileResponse> generateUserTxDataFile($8.GenerateUserTxDataFileRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateUserTxDataFile, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.GenerateTxDataService')
abstract class GenerateTxDataServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GenerateTxDataService';

  GenerateTxDataServiceBase() {
    $addMethod($grpc.ServiceMethod<$8.GenerateUserTxDataFileRequest, $8.GenerateUserTxDataFileResponse>(
        'GenerateUserTxDataFile',
        generateUserTxDataFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $8.GenerateUserTxDataFileRequest.fromBuffer(value),
        ($8.GenerateUserTxDataFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$8.GenerateUserTxDataFileResponse> generateUserTxDataFile_Pre($grpc.ServiceCall $call, $async.Future<$8.GenerateUserTxDataFileRequest> $request) async {
    return generateUserTxDataFile($call, await $request);
  }

  $async.Future<$8.GenerateUserTxDataFileResponse> generateUserTxDataFile($grpc.ServiceCall call, $8.GenerateUserTxDataFileRequest request);
}
