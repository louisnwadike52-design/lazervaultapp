///
//  Generated code. Do not modify.
//  source: tx_file.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tx_file.pb.dart' as $21;
export 'tx_file.pb.dart';

class TxFileServiceClient extends $grpc.Client {
  static final _$getUserTxFileUrl = $grpc.ClientMethod<
          $21.GetUserTxFileUrlRequest, $21.GetUserTxFileUrlResponse>(
      '/pb.TxFileService/GetUserTxFileUrl',
      ($21.GetUserTxFileUrlRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $21.GetUserTxFileUrlResponse.fromBuffer(value));

  TxFileServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$21.GetUserTxFileUrlResponse> getUserTxFileUrl(
      $21.GetUserTxFileUrlRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTxFileUrl, request, options: options);
  }
}

abstract class TxFileServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.TxFileService';

  TxFileServiceBase() {
    $addMethod($grpc.ServiceMethod<$21.GetUserTxFileUrlRequest,
            $21.GetUserTxFileUrlResponse>(
        'GetUserTxFileUrl',
        getUserTxFileUrl_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $21.GetUserTxFileUrlRequest.fromBuffer(value),
        ($21.GetUserTxFileUrlResponse value) => value.writeToBuffer()));
  }

  $async.Future<$21.GetUserTxFileUrlResponse> getUserTxFileUrl_Pre(
      $grpc.ServiceCall call,
      $async.Future<$21.GetUserTxFileUrlRequest> request) async {
    return getUserTxFileUrl(call, await request);
  }

  $async.Future<$21.GetUserTxFileUrlResponse> getUserTxFileUrl(
      $grpc.ServiceCall call, $21.GetUserTxFileUrlRequest request);
}
