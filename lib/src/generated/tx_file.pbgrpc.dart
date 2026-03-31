//
//  Generated code. Do not modify.
//  source: tx_file.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'tx_file.pb.dart' as $0;

export 'tx_file.pb.dart';

@$pb.GrpcServiceName('pb.TxFileService')
class TxFileServiceClient extends $grpc.Client {
  static final _$getUserTxFileUrl = $grpc.ClientMethod<$0.GetUserTxFileUrlRequest, $0.GetUserTxFileUrlResponse>(
      '/pb.TxFileService/GetUserTxFileUrl',
      ($0.GetUserTxFileUrlRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserTxFileUrlResponse.fromBuffer(value));

  TxFileServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetUserTxFileUrlResponse> getUserTxFileUrl($0.GetUserTxFileUrlRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTxFileUrl, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.TxFileService')
abstract class TxFileServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TxFileService';

  TxFileServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetUserTxFileUrlRequest, $0.GetUserTxFileUrlResponse>(
        'GetUserTxFileUrl',
        getUserTxFileUrl_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserTxFileUrlRequest.fromBuffer(value),
        ($0.GetUserTxFileUrlResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserTxFileUrlResponse> getUserTxFileUrl_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserTxFileUrlRequest> request) async {
    return getUserTxFileUrl(call, await request);
  }

  $async.Future<$0.GetUserTxFileUrlResponse> getUserTxFileUrl($grpc.ServiceCall call, $0.GetUserTxFileUrlRequest request);
}
