///
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'generate_tx_data.pb.dart' as $14;
export 'generate_tx_data.pb.dart';

class GenerateTxDataServiceClient extends $grpc.Client {
  static final _$generateUserTxDataFile = $grpc.ClientMethod<
          $14.GenerateUserTxDataFileRequest,
          $14.GenerateUserTxDataFileResponse>(
      '/pb.GenerateTxDataService/GenerateUserTxDataFile',
      ($14.GenerateUserTxDataFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $14.GenerateUserTxDataFileResponse.fromBuffer(value));

  GenerateTxDataServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$14.GenerateUserTxDataFileResponse>
      generateUserTxDataFile($14.GenerateUserTxDataFileRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateUserTxDataFile, request,
        options: options);
  }
}

abstract class GenerateTxDataServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GenerateTxDataService';

  GenerateTxDataServiceBase() {
    $addMethod($grpc.ServiceMethod<$14.GenerateUserTxDataFileRequest,
            $14.GenerateUserTxDataFileResponse>(
        'GenerateUserTxDataFile',
        generateUserTxDataFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $14.GenerateUserTxDataFileRequest.fromBuffer(value),
        ($14.GenerateUserTxDataFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.GenerateUserTxDataFileResponse> generateUserTxDataFile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$14.GenerateUserTxDataFileRequest> request) async {
    return generateUserTxDataFile(call, await request);
  }

  $async.Future<$14.GenerateUserTxDataFileResponse> generateUserTxDataFile(
      $grpc.ServiceCall call, $14.GenerateUserTxDataFileRequest request);
}
