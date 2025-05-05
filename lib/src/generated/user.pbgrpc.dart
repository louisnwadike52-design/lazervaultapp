//
//  Generated code. Do not modify.
//  source: user.proto
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

import 'user.pb.dart' as $13;

export 'user.pb.dart';

@$pb.GrpcServiceName('pb.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$createUser = $grpc.ClientMethod<$13.CreateUserRequest, $13.CreateUserResponse>(
      '/pb.UserService/CreateUser',
      ($13.CreateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $13.CreateUserResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$13.CreateUserResponse> createUser($13.CreateUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$13.CreateUserRequest, $13.CreateUserResponse>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $13.CreateUserRequest.fromBuffer(value),
        ($13.CreateUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$13.CreateUserResponse> createUser_Pre($grpc.ServiceCall $call, $async.Future<$13.CreateUserRequest> $request) async {
    return createUser($call, await $request);
  }

  $async.Future<$13.CreateUserResponse> createUser($grpc.ServiceCall call, $13.CreateUserRequest request);
}
