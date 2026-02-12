//
//  Generated code. Do not modify.
//  source: invoice.proto
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

import 'invoice.pb.dart' as $0;

export 'invoice.pb.dart';

@$pb.GrpcServiceName('invoice.InvoiceService')
class InvoiceServiceClient extends $grpc.Client {
  static final _$createInvoice = $grpc.ClientMethod<$0.CreateInvoiceRequest, $0.CreateInvoiceResponse>(
      '/invoice.InvoiceService/CreateInvoice',
      ($0.CreateInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateInvoiceResponse.fromBuffer(value));
  static final _$getInvoices = $grpc.ClientMethod<$0.GetInvoicesRequest, $0.GetInvoicesResponse>(
      '/invoice.InvoiceService/GetInvoices',
      ($0.GetInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvoicesResponse.fromBuffer(value));
  static final _$getInvoice = $grpc.ClientMethod<$0.GetInvoiceRequest, $0.GetInvoiceResponse>(
      '/invoice.InvoiceService/GetInvoice',
      ($0.GetInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvoiceResponse.fromBuffer(value));
  static final _$payInvoice = $grpc.ClientMethod<$0.PayInvoiceRequest, $0.PayInvoiceResponse>(
      '/invoice.InvoiceService/PayInvoice',
      ($0.PayInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayInvoiceResponse.fromBuffer(value));
  static final _$cancelInvoice = $grpc.ClientMethod<$0.CancelInvoiceRequest, $0.CancelInvoiceResponse>(
      '/invoice.InvoiceService/CancelInvoice',
      ($0.CancelInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CancelInvoiceResponse.fromBuffer(value));
  static final _$sendInvoiceReminder = $grpc.ClientMethod<$0.SendInvoiceReminderRequest, $0.SendInvoiceReminderResponse>(
      '/invoice.InvoiceService/SendInvoiceReminder',
      ($0.SendInvoiceReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendInvoiceReminderResponse.fromBuffer(value));
  static final _$updateInvoiceStatus = $grpc.ClientMethod<$0.UpdateInvoiceStatusRequest, $0.UpdateInvoiceStatusResponse>(
      '/invoice.InvoiceService/UpdateInvoiceStatus',
      ($0.UpdateInvoiceStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateInvoiceStatusResponse.fromBuffer(value));
  static final _$tagUsersToInvoice = $grpc.ClientMethod<$0.TagUsersToInvoiceRequest, $0.TagUsersToInvoiceResponse>(
      '/invoice.InvoiceService/TagUsersToInvoice',
      ($0.TagUsersToInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TagUsersToInvoiceResponse.fromBuffer(value));
  static final _$getInvoicesTaggedToUser = $grpc.ClientMethod<$0.GetInvoicesTaggedToUserRequest, $0.GetInvoicesTaggedToUserResponse>(
      '/invoice.InvoiceService/GetInvoicesTaggedToUser',
      ($0.GetInvoicesTaggedToUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvoicesTaggedToUserResponse.fromBuffer(value));
  static final _$getSentInvoices = $grpc.ClientMethod<$0.GetSentInvoicesRequest, $0.GetSentInvoicesResponse>(
      '/invoice.InvoiceService/GetSentInvoices',
      ($0.GetSentInvoicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetSentInvoicesResponse.fromBuffer(value));
  static final _$updateInvoice = $grpc.ClientMethod<$0.UpdateInvoiceRequest, $0.UpdateInvoiceResponse>(
      '/invoice.InvoiceService/UpdateInvoice',
      ($0.UpdateInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateInvoiceResponse.fromBuffer(value));
  static final _$deleteInvoice = $grpc.ClientMethod<$0.DeleteInvoiceRequest, $0.DeleteInvoiceResponse>(
      '/invoice.InvoiceService/DeleteInvoice',
      ($0.DeleteInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteInvoiceResponse.fromBuffer(value));
  static final _$getInvoiceStatistics = $grpc.ClientMethod<$0.GetInvoiceStatisticsRequest, $0.GetInvoiceStatisticsResponse>(
      '/invoice.InvoiceService/GetInvoiceStatistics',
      ($0.GetInvoiceStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvoiceStatisticsResponse.fromBuffer(value));
  static final _$unlockInvoice = $grpc.ClientMethod<$0.UnlockInvoiceRequest, $0.UnlockInvoiceResponse>(
      '/invoice.InvoiceService/UnlockInvoice',
      ($0.UnlockInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnlockInvoiceResponse.fromBuffer(value));
  static final _$uploadInvoiceImage = $grpc.ClientMethod<$0.UploadInvoiceImageRequest, $0.UploadInvoiceImageResponse>(
      '/invoice.InvoiceService/UploadInvoiceImage',
      ($0.UploadInvoiceImageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UploadInvoiceImageResponse.fromBuffer(value));
  static final _$sendInvoiceToEmail = $grpc.ClientMethod<$0.SendInvoiceToEmailRequest, $0.SendInvoiceToEmailResponse>(
      '/invoice.InvoiceService/SendInvoiceToEmail',
      ($0.SendInvoiceToEmailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SendInvoiceToEmailResponse.fromBuffer(value));

  InvoiceServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateInvoiceResponse> createInvoice($0.CreateInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicesResponse> getInvoices($0.GetInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoiceResponse> getInvoice($0.GetInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayInvoiceResponse> payInvoice($0.PayInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.CancelInvoiceResponse> cancelInvoice($0.CancelInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendInvoiceReminderResponse> sendInvoiceReminder($0.SendInvoiceReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoiceReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInvoiceStatusResponse> updateInvoiceStatus($0.UpdateInvoiceStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoiceStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.TagUsersToInvoiceResponse> tagUsersToInvoice($0.TagUsersToInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$tagUsersToInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoicesTaggedToUserResponse> getInvoicesTaggedToUser($0.GetInvoicesTaggedToUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoicesTaggedToUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSentInvoicesResponse> getSentInvoices($0.GetSentInvoicesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSentInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateInvoiceResponse> updateInvoice($0.UpdateInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteInvoiceResponse> deleteInvoice($0.DeleteInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoiceStatisticsResponse> getInvoiceStatistics($0.GetInvoiceStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoiceStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnlockInvoiceResponse> unlockInvoice($0.UnlockInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadInvoiceImageResponse> uploadInvoiceImage($0.UploadInvoiceImageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadInvoiceImage, request, options: options);
  }

  $grpc.ResponseFuture<$0.SendInvoiceToEmailResponse> sendInvoiceToEmail($0.SendInvoiceToEmailRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendInvoiceToEmail, request, options: options);
  }
}

@$pb.GrpcServiceName('invoice.InvoiceService')
abstract class InvoiceServiceBase extends $grpc.Service {
  $core.String get $name => 'invoice.InvoiceService';

  InvoiceServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateInvoiceRequest, $0.CreateInvoiceResponse>(
        'CreateInvoice',
        createInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateInvoiceRequest.fromBuffer(value),
        ($0.CreateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicesRequest, $0.GetInvoicesResponse>(
        'GetInvoices',
        getInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoicesRequest.fromBuffer(value),
        ($0.GetInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoiceRequest, $0.GetInvoiceResponse>(
        'GetInvoice',
        getInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoiceRequest.fromBuffer(value),
        ($0.GetInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayInvoiceRequest, $0.PayInvoiceResponse>(
        'PayInvoice',
        payInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayInvoiceRequest.fromBuffer(value),
        ($0.PayInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CancelInvoiceRequest, $0.CancelInvoiceResponse>(
        'CancelInvoice',
        cancelInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CancelInvoiceRequest.fromBuffer(value),
        ($0.CancelInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendInvoiceReminderRequest, $0.SendInvoiceReminderResponse>(
        'SendInvoiceReminder',
        sendInvoiceReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendInvoiceReminderRequest.fromBuffer(value),
        ($0.SendInvoiceReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInvoiceStatusRequest, $0.UpdateInvoiceStatusResponse>(
        'UpdateInvoiceStatus',
        updateInvoiceStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateInvoiceStatusRequest.fromBuffer(value),
        ($0.UpdateInvoiceStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TagUsersToInvoiceRequest, $0.TagUsersToInvoiceResponse>(
        'TagUsersToInvoice',
        tagUsersToInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TagUsersToInvoiceRequest.fromBuffer(value),
        ($0.TagUsersToInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoicesTaggedToUserRequest, $0.GetInvoicesTaggedToUserResponse>(
        'GetInvoicesTaggedToUser',
        getInvoicesTaggedToUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoicesTaggedToUserRequest.fromBuffer(value),
        ($0.GetInvoicesTaggedToUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSentInvoicesRequest, $0.GetSentInvoicesResponse>(
        'GetSentInvoices',
        getSentInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetSentInvoicesRequest.fromBuffer(value),
        ($0.GetSentInvoicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateInvoiceRequest, $0.UpdateInvoiceResponse>(
        'UpdateInvoice',
        updateInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateInvoiceRequest.fromBuffer(value),
        ($0.UpdateInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteInvoiceRequest, $0.DeleteInvoiceResponse>(
        'DeleteInvoice',
        deleteInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteInvoiceRequest.fromBuffer(value),
        ($0.DeleteInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoiceStatisticsRequest, $0.GetInvoiceStatisticsResponse>(
        'GetInvoiceStatistics',
        getInvoiceStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoiceStatisticsRequest.fromBuffer(value),
        ($0.GetInvoiceStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlockInvoiceRequest, $0.UnlockInvoiceResponse>(
        'UnlockInvoice',
        unlockInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnlockInvoiceRequest.fromBuffer(value),
        ($0.UnlockInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UploadInvoiceImageRequest, $0.UploadInvoiceImageResponse>(
        'UploadInvoiceImage',
        uploadInvoiceImage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UploadInvoiceImageRequest.fromBuffer(value),
        ($0.UploadInvoiceImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SendInvoiceToEmailRequest, $0.SendInvoiceToEmailResponse>(
        'SendInvoiceToEmail',
        sendInvoiceToEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SendInvoiceToEmailRequest.fromBuffer(value),
        ($0.SendInvoiceToEmailResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateInvoiceResponse> createInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.CreateInvoiceRequest> request) async {
    return createInvoice(call, await request);
  }

  $async.Future<$0.GetInvoicesResponse> getInvoices_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvoicesRequest> request) async {
    return getInvoices(call, await request);
  }

  $async.Future<$0.GetInvoiceResponse> getInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvoiceRequest> request) async {
    return getInvoice(call, await request);
  }

  $async.Future<$0.PayInvoiceResponse> payInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.PayInvoiceRequest> request) async {
    return payInvoice(call, await request);
  }

  $async.Future<$0.CancelInvoiceResponse> cancelInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.CancelInvoiceRequest> request) async {
    return cancelInvoice(call, await request);
  }

  $async.Future<$0.SendInvoiceReminderResponse> sendInvoiceReminder_Pre($grpc.ServiceCall call, $async.Future<$0.SendInvoiceReminderRequest> request) async {
    return sendInvoiceReminder(call, await request);
  }

  $async.Future<$0.UpdateInvoiceStatusResponse> updateInvoiceStatus_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateInvoiceStatusRequest> request) async {
    return updateInvoiceStatus(call, await request);
  }

  $async.Future<$0.TagUsersToInvoiceResponse> tagUsersToInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.TagUsersToInvoiceRequest> request) async {
    return tagUsersToInvoice(call, await request);
  }

  $async.Future<$0.GetInvoicesTaggedToUserResponse> getInvoicesTaggedToUser_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvoicesTaggedToUserRequest> request) async {
    return getInvoicesTaggedToUser(call, await request);
  }

  $async.Future<$0.GetSentInvoicesResponse> getSentInvoices_Pre($grpc.ServiceCall call, $async.Future<$0.GetSentInvoicesRequest> request) async {
    return getSentInvoices(call, await request);
  }

  $async.Future<$0.UpdateInvoiceResponse> updateInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateInvoiceRequest> request) async {
    return updateInvoice(call, await request);
  }

  $async.Future<$0.DeleteInvoiceResponse> deleteInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteInvoiceRequest> request) async {
    return deleteInvoice(call, await request);
  }

  $async.Future<$0.GetInvoiceStatisticsResponse> getInvoiceStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetInvoiceStatisticsRequest> request) async {
    return getInvoiceStatistics(call, await request);
  }

  $async.Future<$0.UnlockInvoiceResponse> unlockInvoice_Pre($grpc.ServiceCall call, $async.Future<$0.UnlockInvoiceRequest> request) async {
    return unlockInvoice(call, await request);
  }

  $async.Future<$0.UploadInvoiceImageResponse> uploadInvoiceImage_Pre($grpc.ServiceCall call, $async.Future<$0.UploadInvoiceImageRequest> request) async {
    return uploadInvoiceImage(call, await request);
  }

  $async.Future<$0.SendInvoiceToEmailResponse> sendInvoiceToEmail_Pre($grpc.ServiceCall call, $async.Future<$0.SendInvoiceToEmailRequest> request) async {
    return sendInvoiceToEmail(call, await request);
  }

  $async.Future<$0.CreateInvoiceResponse> createInvoice($grpc.ServiceCall call, $0.CreateInvoiceRequest request);
  $async.Future<$0.GetInvoicesResponse> getInvoices($grpc.ServiceCall call, $0.GetInvoicesRequest request);
  $async.Future<$0.GetInvoiceResponse> getInvoice($grpc.ServiceCall call, $0.GetInvoiceRequest request);
  $async.Future<$0.PayInvoiceResponse> payInvoice($grpc.ServiceCall call, $0.PayInvoiceRequest request);
  $async.Future<$0.CancelInvoiceResponse> cancelInvoice($grpc.ServiceCall call, $0.CancelInvoiceRequest request);
  $async.Future<$0.SendInvoiceReminderResponse> sendInvoiceReminder($grpc.ServiceCall call, $0.SendInvoiceReminderRequest request);
  $async.Future<$0.UpdateInvoiceStatusResponse> updateInvoiceStatus($grpc.ServiceCall call, $0.UpdateInvoiceStatusRequest request);
  $async.Future<$0.TagUsersToInvoiceResponse> tagUsersToInvoice($grpc.ServiceCall call, $0.TagUsersToInvoiceRequest request);
  $async.Future<$0.GetInvoicesTaggedToUserResponse> getInvoicesTaggedToUser($grpc.ServiceCall call, $0.GetInvoicesTaggedToUserRequest request);
  $async.Future<$0.GetSentInvoicesResponse> getSentInvoices($grpc.ServiceCall call, $0.GetSentInvoicesRequest request);
  $async.Future<$0.UpdateInvoiceResponse> updateInvoice($grpc.ServiceCall call, $0.UpdateInvoiceRequest request);
  $async.Future<$0.DeleteInvoiceResponse> deleteInvoice($grpc.ServiceCall call, $0.DeleteInvoiceRequest request);
  $async.Future<$0.GetInvoiceStatisticsResponse> getInvoiceStatistics($grpc.ServiceCall call, $0.GetInvoiceStatisticsRequest request);
  $async.Future<$0.UnlockInvoiceResponse> unlockInvoice($grpc.ServiceCall call, $0.UnlockInvoiceRequest request);
  $async.Future<$0.UploadInvoiceImageResponse> uploadInvoiceImage($grpc.ServiceCall call, $0.UploadInvoiceImageRequest request);
  $async.Future<$0.SendInvoiceToEmailResponse> sendInvoiceToEmail($grpc.ServiceCall call, $0.SendInvoiceToEmailRequest request);
}
