///
//  Generated code. Do not modify.
//  source: electricity_bill.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'electricity_bill.pb.dart' as $12;
export 'electricity_bill.pb.dart';

class ElectricityBillServiceClient extends $grpc.Client {
  static final _$getProviders =
      $grpc.ClientMethod<$12.GetProvidersRequest, $12.GetProvidersResponse>(
          '/pb.ElectricityBillService/GetProviders',
          ($12.GetProvidersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetProvidersResponse.fromBuffer(value));
  static final _$syncProviders =
      $grpc.ClientMethod<$12.SyncProvidersRequest, $12.SyncProvidersResponse>(
          '/pb.ElectricityBillService/SyncProviders',
          ($12.SyncProvidersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.SyncProvidersResponse.fromBuffer(value));
  static final _$validateMeterNumber =
      $grpc.ClientMethod<$12.ValidateMeterRequest, $12.ValidateMeterResponse>(
          '/pb.ElectricityBillService/ValidateMeterNumber',
          ($12.ValidateMeterRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.ValidateMeterResponse.fromBuffer(value));
  static final _$getBillDetails =
      $grpc.ClientMethod<$12.GetBillDetailsRequest, $12.GetBillDetailsResponse>(
          '/pb.ElectricityBillService/GetBillDetails',
          ($12.GetBillDetailsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetBillDetailsResponse.fromBuffer(value));
  static final _$initiatePayment = $grpc.ClientMethod<
          $12.InitiatePaymentRequest, $12.InitiatePaymentResponse>(
      '/pb.ElectricityBillService/InitiatePayment',
      ($12.InitiatePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.InitiatePaymentResponse.fromBuffer(value));
  static final _$verifyPayment =
      $grpc.ClientMethod<$12.VerifyPaymentRequest, $12.VerifyPaymentResponse>(
          '/pb.ElectricityBillService/VerifyPayment',
          ($12.VerifyPaymentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.VerifyPaymentResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<
          $12.GetPaymentHistoryRequest, $12.GetPaymentHistoryResponse>(
      '/pb.ElectricityBillService/GetPaymentHistory',
      ($12.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getPaymentReceipt = $grpc.ClientMethod<
          $12.GetPaymentReceiptRequest, $12.GetPaymentReceiptResponse>(
      '/pb.ElectricityBillService/GetPaymentReceipt',
      ($12.GetPaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetPaymentReceiptResponse.fromBuffer(value));
  static final _$saveBeneficiary = $grpc.ClientMethod<
          $12.SaveBeneficiaryRequest, $12.SaveBeneficiaryResponse>(
      '/pb.ElectricityBillService/SaveBeneficiary',
      ($12.SaveBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.SaveBeneficiaryResponse.fromBuffer(value));
  static final _$getBeneficiaries = $grpc.ClientMethod<
          $12.GetBeneficiariesRequest, $12.GetBeneficiariesResponse>(
      '/pb.ElectricityBillService/GetBeneficiaries',
      ($12.GetBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetBeneficiariesResponse.fromBuffer(value));
  static final _$updateBeneficiary = $grpc.ClientMethod<
          $12.UpdateBeneficiaryRequest, $12.UpdateBeneficiaryResponse>(
      '/pb.ElectricityBillService/UpdateBeneficiary',
      ($12.UpdateBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdateBeneficiaryResponse.fromBuffer(value));
  static final _$deleteBeneficiary = $grpc.ClientMethod<
          $12.DeleteBeneficiaryRequest, $12.DeleteBeneficiaryResponse>(
      '/pb.ElectricityBillService/DeleteBeneficiary',
      ($12.DeleteBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.DeleteBeneficiaryResponse.fromBuffer(value));
  static final _$createAutoRecharge = $grpc.ClientMethod<
          $12.CreateAutoRechargeRequest, $12.CreateAutoRechargeResponse>(
      '/pb.ElectricityBillService/CreateAutoRecharge',
      ($12.CreateAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.CreateAutoRechargeResponse.fromBuffer(value));
  static final _$getAutoRecharges = $grpc.ClientMethod<
          $12.GetAutoRechargesRequest, $12.GetAutoRechargesResponse>(
      '/pb.ElectricityBillService/GetAutoRecharges',
      ($12.GetAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.GetAutoRechargesResponse.fromBuffer(value));
  static final _$updateAutoRecharge = $grpc.ClientMethod<
          $12.UpdateAutoRechargeRequest, $12.UpdateAutoRechargeResponse>(
      '/pb.ElectricityBillService/UpdateAutoRecharge',
      ($12.UpdateAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.UpdateAutoRechargeResponse.fromBuffer(value));
  static final _$deleteAutoRecharge = $grpc.ClientMethod<
          $12.DeleteAutoRechargeRequest, $12.DeleteAutoRechargeResponse>(
      '/pb.ElectricityBillService/DeleteAutoRecharge',
      ($12.DeleteAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.DeleteAutoRechargeResponse.fromBuffer(value));
  static final _$pauseAutoRecharge = $grpc.ClientMethod<
          $12.PauseAutoRechargeRequest, $12.PauseAutoRechargeResponse>(
      '/pb.ElectricityBillService/PauseAutoRecharge',
      ($12.PauseAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.PauseAutoRechargeResponse.fromBuffer(value));
  static final _$resumeAutoRecharge = $grpc.ClientMethod<
          $12.ResumeAutoRechargeRequest, $12.ResumeAutoRechargeResponse>(
      '/pb.ElectricityBillService/ResumeAutoRecharge',
      ($12.ResumeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.ResumeAutoRechargeResponse.fromBuffer(value));
  static final _$createReminder =
      $grpc.ClientMethod<$12.CreateReminderRequest, $12.CreateReminderResponse>(
          '/pb.ElectricityBillService/CreateReminder',
          ($12.CreateReminderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.CreateReminderResponse.fromBuffer(value));
  static final _$getReminders =
      $grpc.ClientMethod<$12.GetRemindersRequest, $12.GetRemindersResponse>(
          '/pb.ElectricityBillService/GetReminders',
          ($12.GetRemindersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.GetRemindersResponse.fromBuffer(value));
  static final _$updateReminder =
      $grpc.ClientMethod<$12.UpdateReminderRequest, $12.UpdateReminderResponse>(
          '/pb.ElectricityBillService/UpdateReminder',
          ($12.UpdateReminderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.UpdateReminderResponse.fromBuffer(value));
  static final _$deleteReminder =
      $grpc.ClientMethod<$12.DeleteReminderRequest, $12.DeleteReminderResponse>(
          '/pb.ElectricityBillService/DeleteReminder',
          ($12.DeleteReminderRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $12.DeleteReminderResponse.fromBuffer(value));
  static final _$markReminderComplete = $grpc.ClientMethod<
          $12.MarkReminderCompleteRequest, $12.MarkReminderCompleteResponse>(
      '/pb.ElectricityBillService/MarkReminderComplete',
      ($12.MarkReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $12.MarkReminderCompleteResponse.fromBuffer(value));

  ElectricityBillServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$12.GetProvidersResponse> getProviders(
      $12.GetProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProviders, request, options: options);
  }

  $grpc.ResponseFuture<$12.SyncProvidersResponse> syncProviders(
      $12.SyncProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncProviders, request, options: options);
  }

  $grpc.ResponseFuture<$12.ValidateMeterResponse> validateMeterNumber(
      $12.ValidateMeterRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateMeterNumber, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetBillDetailsResponse> getBillDetails(
      $12.GetBillDetailsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillDetails, request, options: options);
  }

  $grpc.ResponseFuture<$12.InitiatePaymentResponse> initiatePayment(
      $12.InitiatePaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePayment, request, options: options);
  }

  $grpc.ResponseFuture<$12.VerifyPaymentResponse> verifyPayment(
      $12.VerifyPaymentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPayment, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetPaymentHistoryResponse> getPaymentHistory(
      $12.GetPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetPaymentReceiptResponse> getPaymentReceipt(
      $12.GetPaymentReceiptRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$12.SaveBeneficiaryResponse> saveBeneficiary(
      $12.SaveBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetBeneficiariesResponse> getBeneficiaries(
      $12.GetBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateBeneficiaryResponse> updateBeneficiary(
      $12.UpdateBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteBeneficiaryResponse> deleteBeneficiary(
      $12.DeleteBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreateAutoRechargeResponse> createAutoRecharge(
      $12.CreateAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetAutoRechargesResponse> getAutoRecharges(
      $12.GetAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateAutoRechargeResponse> updateAutoRecharge(
      $12.UpdateAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteAutoRechargeResponse> deleteAutoRecharge(
      $12.DeleteAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$12.PauseAutoRechargeResponse> pauseAutoRecharge(
      $12.PauseAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$12.ResumeAutoRechargeResponse> resumeAutoRecharge(
      $12.ResumeAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$12.CreateReminderResponse> createReminder(
      $12.CreateReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createReminder, request, options: options);
  }

  $grpc.ResponseFuture<$12.GetRemindersResponse> getReminders(
      $12.GetRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReminders, request, options: options);
  }

  $grpc.ResponseFuture<$12.UpdateReminderResponse> updateReminder(
      $12.UpdateReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateReminder, request, options: options);
  }

  $grpc.ResponseFuture<$12.DeleteReminderResponse> deleteReminder(
      $12.DeleteReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteReminder, request, options: options);
  }

  $grpc.ResponseFuture<$12.MarkReminderCompleteResponse> markReminderComplete(
      $12.MarkReminderCompleteRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markReminderComplete, request, options: options);
  }
}

abstract class ElectricityBillServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ElectricityBillService';

  ElectricityBillServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$12.GetProvidersRequest, $12.GetProvidersResponse>(
            'GetProviders',
            getProviders_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetProvidersRequest.fromBuffer(value),
            ($12.GetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.SyncProvidersRequest,
            $12.SyncProvidersResponse>(
        'SyncProviders',
        syncProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.SyncProvidersRequest.fromBuffer(value),
        ($12.SyncProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ValidateMeterRequest,
            $12.ValidateMeterResponse>(
        'ValidateMeterNumber',
        validateMeterNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ValidateMeterRequest.fromBuffer(value),
        ($12.ValidateMeterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetBillDetailsRequest,
            $12.GetBillDetailsResponse>(
        'GetBillDetails',
        getBillDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetBillDetailsRequest.fromBuffer(value),
        ($12.GetBillDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.InitiatePaymentRequest,
            $12.InitiatePaymentResponse>(
        'InitiatePayment',
        initiatePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.InitiatePaymentRequest.fromBuffer(value),
        ($12.InitiatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.VerifyPaymentRequest,
            $12.VerifyPaymentResponse>(
        'VerifyPayment',
        verifyPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.VerifyPaymentRequest.fromBuffer(value),
        ($12.VerifyPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetPaymentHistoryRequest,
            $12.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetPaymentHistoryRequest.fromBuffer(value),
        ($12.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetPaymentReceiptRequest,
            $12.GetPaymentReceiptResponse>(
        'GetPaymentReceipt',
        getPaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetPaymentReceiptRequest.fromBuffer(value),
        ($12.GetPaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.SaveBeneficiaryRequest,
            $12.SaveBeneficiaryResponse>(
        'SaveBeneficiary',
        saveBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.SaveBeneficiaryRequest.fromBuffer(value),
        ($12.SaveBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetBeneficiariesRequest,
            $12.GetBeneficiariesResponse>(
        'GetBeneficiaries',
        getBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetBeneficiariesRequest.fromBuffer(value),
        ($12.GetBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateBeneficiaryRequest,
            $12.UpdateBeneficiaryResponse>(
        'UpdateBeneficiary',
        updateBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateBeneficiaryRequest.fromBuffer(value),
        ($12.UpdateBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteBeneficiaryRequest,
            $12.DeleteBeneficiaryResponse>(
        'DeleteBeneficiary',
        deleteBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeleteBeneficiaryRequest.fromBuffer(value),
        ($12.DeleteBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.CreateAutoRechargeRequest,
            $12.CreateAutoRechargeResponse>(
        'CreateAutoRecharge',
        createAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.CreateAutoRechargeRequest.fromBuffer(value),
        ($12.CreateAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.GetAutoRechargesRequest,
            $12.GetAutoRechargesResponse>(
        'GetAutoRecharges',
        getAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.GetAutoRechargesRequest.fromBuffer(value),
        ($12.GetAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateAutoRechargeRequest,
            $12.UpdateAutoRechargeResponse>(
        'UpdateAutoRecharge',
        updateAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateAutoRechargeRequest.fromBuffer(value),
        ($12.UpdateAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteAutoRechargeRequest,
            $12.DeleteAutoRechargeResponse>(
        'DeleteAutoRecharge',
        deleteAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeleteAutoRechargeRequest.fromBuffer(value),
        ($12.DeleteAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.PauseAutoRechargeRequest,
            $12.PauseAutoRechargeResponse>(
        'PauseAutoRecharge',
        pauseAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.PauseAutoRechargeRequest.fromBuffer(value),
        ($12.PauseAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.ResumeAutoRechargeRequest,
            $12.ResumeAutoRechargeResponse>(
        'ResumeAutoRecharge',
        resumeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.ResumeAutoRechargeRequest.fromBuffer(value),
        ($12.ResumeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.CreateReminderRequest,
            $12.CreateReminderResponse>(
        'CreateReminder',
        createReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.CreateReminderRequest.fromBuffer(value),
        ($12.CreateReminderResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$12.GetRemindersRequest, $12.GetRemindersResponse>(
            'GetReminders',
            getReminders_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $12.GetRemindersRequest.fromBuffer(value),
            ($12.GetRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.UpdateReminderRequest,
            $12.UpdateReminderResponse>(
        'UpdateReminder',
        updateReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.UpdateReminderRequest.fromBuffer(value),
        ($12.UpdateReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.DeleteReminderRequest,
            $12.DeleteReminderResponse>(
        'DeleteReminder',
        deleteReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.DeleteReminderRequest.fromBuffer(value),
        ($12.DeleteReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$12.MarkReminderCompleteRequest,
            $12.MarkReminderCompleteResponse>(
        'MarkReminderComplete',
        markReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $12.MarkReminderCompleteRequest.fromBuffer(value),
        ($12.MarkReminderCompleteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$12.GetProvidersResponse> getProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetProvidersRequest> request) async {
    return getProviders(call, await request);
  }

  $async.Future<$12.SyncProvidersResponse> syncProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.SyncProvidersRequest> request) async {
    return syncProviders(call, await request);
  }

  $async.Future<$12.ValidateMeterResponse> validateMeterNumber_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ValidateMeterRequest> request) async {
    return validateMeterNumber(call, await request);
  }

  $async.Future<$12.GetBillDetailsResponse> getBillDetails_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetBillDetailsRequest> request) async {
    return getBillDetails(call, await request);
  }

  $async.Future<$12.InitiatePaymentResponse> initiatePayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.InitiatePaymentRequest> request) async {
    return initiatePayment(call, await request);
  }

  $async.Future<$12.VerifyPaymentResponse> verifyPayment_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.VerifyPaymentRequest> request) async {
    return verifyPayment(call, await request);
  }

  $async.Future<$12.GetPaymentHistoryResponse> getPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$12.GetPaymentReceiptResponse> getPaymentReceipt_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetPaymentReceiptRequest> request) async {
    return getPaymentReceipt(call, await request);
  }

  $async.Future<$12.SaveBeneficiaryResponse> saveBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.SaveBeneficiaryRequest> request) async {
    return saveBeneficiary(call, await request);
  }

  $async.Future<$12.GetBeneficiariesResponse> getBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetBeneficiariesRequest> request) async {
    return getBeneficiaries(call, await request);
  }

  $async.Future<$12.UpdateBeneficiaryResponse> updateBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateBeneficiaryRequest> request) async {
    return updateBeneficiary(call, await request);
  }

  $async.Future<$12.DeleteBeneficiaryResponse> deleteBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeleteBeneficiaryRequest> request) async {
    return deleteBeneficiary(call, await request);
  }

  $async.Future<$12.CreateAutoRechargeResponse> createAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreateAutoRechargeRequest> request) async {
    return createAutoRecharge(call, await request);
  }

  $async.Future<$12.GetAutoRechargesResponse> getAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetAutoRechargesRequest> request) async {
    return getAutoRecharges(call, await request);
  }

  $async.Future<$12.UpdateAutoRechargeResponse> updateAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateAutoRechargeRequest> request) async {
    return updateAutoRecharge(call, await request);
  }

  $async.Future<$12.DeleteAutoRechargeResponse> deleteAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeleteAutoRechargeRequest> request) async {
    return deleteAutoRecharge(call, await request);
  }

  $async.Future<$12.PauseAutoRechargeResponse> pauseAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.PauseAutoRechargeRequest> request) async {
    return pauseAutoRecharge(call, await request);
  }

  $async.Future<$12.ResumeAutoRechargeResponse> resumeAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.ResumeAutoRechargeRequest> request) async {
    return resumeAutoRecharge(call, await request);
  }

  $async.Future<$12.CreateReminderResponse> createReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.CreateReminderRequest> request) async {
    return createReminder(call, await request);
  }

  $async.Future<$12.GetRemindersResponse> getReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.GetRemindersRequest> request) async {
    return getReminders(call, await request);
  }

  $async.Future<$12.UpdateReminderResponse> updateReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.UpdateReminderRequest> request) async {
    return updateReminder(call, await request);
  }

  $async.Future<$12.DeleteReminderResponse> deleteReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.DeleteReminderRequest> request) async {
    return deleteReminder(call, await request);
  }

  $async.Future<$12.MarkReminderCompleteResponse> markReminderComplete_Pre(
      $grpc.ServiceCall call,
      $async.Future<$12.MarkReminderCompleteRequest> request) async {
    return markReminderComplete(call, await request);
  }

  $async.Future<$12.GetProvidersResponse> getProviders(
      $grpc.ServiceCall call, $12.GetProvidersRequest request);
  $async.Future<$12.SyncProvidersResponse> syncProviders(
      $grpc.ServiceCall call, $12.SyncProvidersRequest request);
  $async.Future<$12.ValidateMeterResponse> validateMeterNumber(
      $grpc.ServiceCall call, $12.ValidateMeterRequest request);
  $async.Future<$12.GetBillDetailsResponse> getBillDetails(
      $grpc.ServiceCall call, $12.GetBillDetailsRequest request);
  $async.Future<$12.InitiatePaymentResponse> initiatePayment(
      $grpc.ServiceCall call, $12.InitiatePaymentRequest request);
  $async.Future<$12.VerifyPaymentResponse> verifyPayment(
      $grpc.ServiceCall call, $12.VerifyPaymentRequest request);
  $async.Future<$12.GetPaymentHistoryResponse> getPaymentHistory(
      $grpc.ServiceCall call, $12.GetPaymentHistoryRequest request);
  $async.Future<$12.GetPaymentReceiptResponse> getPaymentReceipt(
      $grpc.ServiceCall call, $12.GetPaymentReceiptRequest request);
  $async.Future<$12.SaveBeneficiaryResponse> saveBeneficiary(
      $grpc.ServiceCall call, $12.SaveBeneficiaryRequest request);
  $async.Future<$12.GetBeneficiariesResponse> getBeneficiaries(
      $grpc.ServiceCall call, $12.GetBeneficiariesRequest request);
  $async.Future<$12.UpdateBeneficiaryResponse> updateBeneficiary(
      $grpc.ServiceCall call, $12.UpdateBeneficiaryRequest request);
  $async.Future<$12.DeleteBeneficiaryResponse> deleteBeneficiary(
      $grpc.ServiceCall call, $12.DeleteBeneficiaryRequest request);
  $async.Future<$12.CreateAutoRechargeResponse> createAutoRecharge(
      $grpc.ServiceCall call, $12.CreateAutoRechargeRequest request);
  $async.Future<$12.GetAutoRechargesResponse> getAutoRecharges(
      $grpc.ServiceCall call, $12.GetAutoRechargesRequest request);
  $async.Future<$12.UpdateAutoRechargeResponse> updateAutoRecharge(
      $grpc.ServiceCall call, $12.UpdateAutoRechargeRequest request);
  $async.Future<$12.DeleteAutoRechargeResponse> deleteAutoRecharge(
      $grpc.ServiceCall call, $12.DeleteAutoRechargeRequest request);
  $async.Future<$12.PauseAutoRechargeResponse> pauseAutoRecharge(
      $grpc.ServiceCall call, $12.PauseAutoRechargeRequest request);
  $async.Future<$12.ResumeAutoRechargeResponse> resumeAutoRecharge(
      $grpc.ServiceCall call, $12.ResumeAutoRechargeRequest request);
  $async.Future<$12.CreateReminderResponse> createReminder(
      $grpc.ServiceCall call, $12.CreateReminderRequest request);
  $async.Future<$12.GetRemindersResponse> getReminders(
      $grpc.ServiceCall call, $12.GetRemindersRequest request);
  $async.Future<$12.UpdateReminderResponse> updateReminder(
      $grpc.ServiceCall call, $12.UpdateReminderRequest request);
  $async.Future<$12.DeleteReminderResponse> deleteReminder(
      $grpc.ServiceCall call, $12.DeleteReminderRequest request);
  $async.Future<$12.MarkReminderCompleteResponse> markReminderComplete(
      $grpc.ServiceCall call, $12.MarkReminderCompleteRequest request);
}
