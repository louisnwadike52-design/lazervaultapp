///
//  Generated code. Do not modify.
//  source: tx_file.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tx_file.pb.dart' as $13;
export 'tx_file.pb.dart';

class TxFileServiceClient extends $grpc.Client {
  static final _$getUserTxFileUrl = $grpc.ClientMethod<
          $13.GetUserTxFileUrlRequest, $13.GetUserTxFileUrlResponse>(
      '/pb.TxFileService/GetUserTxFileUrl',
      ($13.GetUserTxFileUrlRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $13.GetUserTxFileUrlResponse.fromBuffer(value));

  TxFileServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$13.GetUserTxFileUrlResponse> getUserTxFileUrl(
      $13.GetUserTxFileUrlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTxFileUrl, request, options: options);
  }
}

abstract class TxFileServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TxFileService';

  TxFileServiceBase() {
    $addMethod($grpc.ServiceMethod<$13.GetUserTxFileUrlRequest,
            $13.GetUserTxFileUrlResponse>(
        'GetUserTxFileUrl',
        getUserTxFileUrl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $13.GetUserTxFileUrlRequest.fromBuffer(value),
        ($13.GetUserTxFileUrlResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.GetUserTxFileUrlResponse> getUserTxFileUrl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$13.GetUserTxFileUrlRequest> request) async {
    return getUserTxFileUrl(call, await request);
  }

  $async.Future<$13.GetUserTxFileUrlResponse> getUserTxFileUrl(
      $grpc.ServiceCall call, $13.GetUserTxFileUrlRequest request);
}
