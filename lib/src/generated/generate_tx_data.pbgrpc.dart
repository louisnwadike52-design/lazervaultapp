///
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'generate_tx_data.pb.dart' as $13;
export 'generate_tx_data.pb.dart';

class GenerateTxDataServiceClient extends $grpc.Client {
  static final _$generateUserTxDataFile = $grpc.ClientMethod<
          $13.GenerateUserTxDataFileRequest,
          $13.GenerateUserTxDataFileResponse>(
      '/pb.GenerateTxDataService/GenerateUserTxDataFile',
      ($13.GenerateUserTxDataFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GenerateUserTxDataFileResponse.fromBuffer(value));

  GenerateTxDataServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$13.GenerateUserTxDataFileResponse>
      generateUserTxDataFile($13.GenerateUserTxDataFileRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateUserTxDataFile, request,
        options: options);
  }
}

abstract class GenerateTxDataServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GenerateTxDataService';

  GenerateTxDataServiceBase() {
    $addMethod($grpc.ServiceMethod<$13.GenerateUserTxDataFileRequest,
            $13.GenerateUserTxDataFileResponse>(
        'GenerateUserTxDataFile',
        generateUserTxDataFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GenerateUserTxDataFileRequest.fromBuffer(value),
        ($13.GenerateUserTxDataFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.GenerateUserTxDataFileResponse> generateUserTxDataFile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GenerateUserTxDataFileRequest> request) async {
    return generateUserTxDataFile(call, await request);
  }

  $async.Future<$13.GenerateUserTxDataFileResponse> generateUserTxDataFile(
      $grpc.ServiceCall call, $13.GenerateUserTxDataFileRequest request);
}
