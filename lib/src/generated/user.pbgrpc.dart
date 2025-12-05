///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $14;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser =
      $grpc.ClientMethod<$14.CreateUserRequest, $14.CreateUserResponse>(
          '/pb.UserService/CreateUser',
          ($14.CreateUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $14.CreateUserResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$14.CreateUserResponse> createUser(
      $14.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.UserService';

  UserServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$14.CreateUserRequest, $14.CreateUserResponse>(
            'CreateUser',
            createUser_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $14.CreateUserRequest.fromBuffer(value),
            ($14.CreateUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$14.CreateUserResponse> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$14.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$14.CreateUserResponse> createUser(
      $grpc.ServiceCall call, $14.CreateUserRequest request);
}
