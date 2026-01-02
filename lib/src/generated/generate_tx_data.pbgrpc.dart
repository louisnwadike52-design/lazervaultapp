///
//  Generated code. Do not modify.
//  source: generate_tx_data.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'generate_tx_data.pb.dart' as $15;
export 'generate_tx_data.pb.dart';

class GenerateTxDataServiceClient extends $grpc.Client {
  static final _$generateUserTxDataFile = $grpc.ClientMethod<
          $15.GenerateUserTxDataFileRequest,
          $15.GenerateUserTxDataFileResponse>(
      '/pb.GenerateTxDataService/GenerateUserTxDataFile',
      ($15.GenerateUserTxDataFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $15.GenerateUserTxDataFileResponse.fromBuffer(value));

  GenerateTxDataServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$15.GenerateUserTxDataFileResponse>
      generateUserTxDataFile($15.GenerateUserTxDataFileRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateUserTxDataFile, request,
        options: options);
  }
}

abstract class GenerateTxDataServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.GenerateTxDataService';

  GenerateTxDataServiceBase() {
    $addMethod($grpc.ServiceMethod<$15.GenerateUserTxDataFileRequest,
            $15.GenerateUserTxDataFileResponse>(
        'GenerateUserTxDataFile',
        generateUserTxDataFile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $15.GenerateUserTxDataFileRequest.fromBuffer(value),
        ($15.GenerateUserTxDataFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$15.GenerateUserTxDataFileResponse> generateUserTxDataFile_Pre(
      $grpc.ServiceCall call,
      $async.Future<$15.GenerateUserTxDataFileRequest> request) async {
    return generateUserTxDataFile(call, await request);
  }

  $async.Future<$15.GenerateUserTxDataFileResponse> generateUserTxDataFile(
      $grpc.ServiceCall call, $15.GenerateUserTxDataFileRequest request);
}
