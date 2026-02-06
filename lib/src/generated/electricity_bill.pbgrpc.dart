//
//  Generated code. Do not modify.
//  source: electricity_bill.proto
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

import 'electricity_bill.pb.dart' as $15;

export 'electricity_bill.pb.dart';

@$pb.GrpcServiceName('pb.ElectricityBillService')
class ElectricityBillServiceClient extends $grpc.Client {
  static final _$getProviders = $grpc.ClientMethod<$15.GetProvidersRequest, $15.GetProvidersResponse>(
      '/pb.ElectricityBillService/GetProviders',
      ($15.GetProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetProvidersResponse.fromBuffer(value));
  static final _$syncProviders = $grpc.ClientMethod<$15.SyncProvidersRequest, $15.SyncProvidersResponse>(
      '/pb.ElectricityBillService/SyncProviders',
      ($15.SyncProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.SyncProvidersResponse.fromBuffer(value));
  static final _$validateMeterNumber = $grpc.ClientMethod<$15.ValidateMeterRequest, $15.ValidateMeterResponse>(
      '/pb.ElectricityBillService/ValidateMeterNumber',
      ($15.ValidateMeterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.ValidateMeterResponse.fromBuffer(value));
  static final _$getBillDetails = $grpc.ClientMethod<$15.GetBillDetailsRequest, $15.GetBillDetailsResponse>(
      '/pb.ElectricityBillService/GetBillDetails',
      ($15.GetBillDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetBillDetailsResponse.fromBuffer(value));
  static final _$initiatePayment = $grpc.ClientMethod<$15.InitiatePaymentRequest, $15.InitiatePaymentResponse>(
      '/pb.ElectricityBillService/InitiatePayment',
      ($15.InitiatePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.InitiatePaymentResponse.fromBuffer(value));
  static final _$verifyPayment = $grpc.ClientMethod<$15.VerifyPaymentRequest, $15.VerifyPaymentResponse>(
      '/pb.ElectricityBillService/VerifyPayment',
      ($15.VerifyPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.VerifyPaymentResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<$15.GetPaymentHistoryRequest, $15.GetPaymentHistoryResponse>(
      '/pb.ElectricityBillService/GetPaymentHistory',
      ($15.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getPaymentReceipt = $grpc.ClientMethod<$15.GetPaymentReceiptRequest, $15.GetPaymentReceiptResponse>(
      '/pb.ElectricityBillService/GetPaymentReceipt',
      ($15.GetPaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetPaymentReceiptResponse.fromBuffer(value));
  static final _$saveBeneficiary = $grpc.ClientMethod<$15.SaveBeneficiaryRequest, $15.SaveBeneficiaryResponse>(
      '/pb.ElectricityBillService/SaveBeneficiary',
      ($15.SaveBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.SaveBeneficiaryResponse.fromBuffer(value));
  static final _$getBeneficiaries = $grpc.ClientMethod<$15.GetBeneficiariesRequest, $15.GetBeneficiariesResponse>(
      '/pb.ElectricityBillService/GetBeneficiaries',
      ($15.GetBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetBeneficiariesResponse.fromBuffer(value));
  static final _$updateBeneficiary = $grpc.ClientMethod<$15.UpdateBeneficiaryRequest, $15.UpdateBeneficiaryResponse>(
      '/pb.ElectricityBillService/UpdateBeneficiary',
      ($15.UpdateBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.UpdateBeneficiaryResponse.fromBuffer(value));
  static final _$deleteBeneficiary = $grpc.ClientMethod<$15.DeleteBeneficiaryRequest, $15.DeleteBeneficiaryResponse>(
      '/pb.ElectricityBillService/DeleteBeneficiary',
      ($15.DeleteBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.DeleteBeneficiaryResponse.fromBuffer(value));
  static final _$createAutoRecharge = $grpc.ClientMethod<$15.CreateAutoRechargeRequest, $15.CreateAutoRechargeResponse>(
      '/pb.ElectricityBillService/CreateAutoRecharge',
      ($15.CreateAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.CreateAutoRechargeResponse.fromBuffer(value));
  static final _$getAutoRecharges = $grpc.ClientMethod<$15.GetAutoRechargesRequest, $15.GetAutoRechargesResponse>(
      '/pb.ElectricityBillService/GetAutoRecharges',
      ($15.GetAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetAutoRechargesResponse.fromBuffer(value));
  static final _$updateAutoRecharge = $grpc.ClientMethod<$15.UpdateAutoRechargeRequest, $15.UpdateAutoRechargeResponse>(
      '/pb.ElectricityBillService/UpdateAutoRecharge',
      ($15.UpdateAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.UpdateAutoRechargeResponse.fromBuffer(value));
  static final _$deleteAutoRecharge = $grpc.ClientMethod<$15.DeleteAutoRechargeRequest, $15.DeleteAutoRechargeResponse>(
      '/pb.ElectricityBillService/DeleteAutoRecharge',
      ($15.DeleteAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.DeleteAutoRechargeResponse.fromBuffer(value));
  static final _$pauseAutoRecharge = $grpc.ClientMethod<$15.PauseAutoRechargeRequest, $15.PauseAutoRechargeResponse>(
      '/pb.ElectricityBillService/PauseAutoRecharge',
      ($15.PauseAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.PauseAutoRechargeResponse.fromBuffer(value));
  static final _$resumeAutoRecharge = $grpc.ClientMethod<$15.ResumeAutoRechargeRequest, $15.ResumeAutoRechargeResponse>(
      '/pb.ElectricityBillService/ResumeAutoRecharge',
      ($15.ResumeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.ResumeAutoRechargeResponse.fromBuffer(value));
  static final _$createReminder = $grpc.ClientMethod<$15.CreateReminderRequest, $15.CreateReminderResponse>(
      '/pb.ElectricityBillService/CreateReminder',
      ($15.CreateReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.CreateReminderResponse.fromBuffer(value));
  static final _$getReminders = $grpc.ClientMethod<$15.GetRemindersRequest, $15.GetRemindersResponse>(
      '/pb.ElectricityBillService/GetReminders',
      ($15.GetRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.GetRemindersResponse.fromBuffer(value));
  static final _$updateReminder = $grpc.ClientMethod<$15.UpdateReminderRequest, $15.UpdateReminderResponse>(
      '/pb.ElectricityBillService/UpdateReminder',
      ($15.UpdateReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.UpdateReminderResponse.fromBuffer(value));
  static final _$deleteReminder = $grpc.ClientMethod<$15.DeleteReminderRequest, $15.DeleteReminderResponse>(
      '/pb.ElectricityBillService/DeleteReminder',
      ($15.DeleteReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.DeleteReminderResponse.fromBuffer(value));
  static final _$markReminderComplete = $grpc.ClientMethod<$15.MarkReminderCompleteRequest, $15.MarkReminderCompleteResponse>(
      '/pb.ElectricityBillService/MarkReminderComplete',
      ($15.MarkReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $15.MarkReminderCompleteResponse.fromBuffer(value));

  ElectricityBillServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$15.GetProvidersResponse> getProviders($15.GetProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProviders, request, options: options);
  }

  $grpc.ResponseFuture<$15.SyncProvidersResponse> syncProviders($15.SyncProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncProviders, request, options: options);
  }

  $grpc.ResponseFuture<$15.ValidateMeterResponse> validateMeterNumber($15.ValidateMeterRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateMeterNumber, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetBillDetailsResponse> getBillDetails($15.GetBillDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillDetails, request, options: options);
  }

  $grpc.ResponseFuture<$15.InitiatePaymentResponse> initiatePayment($15.InitiatePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePayment, request, options: options);
  }

  $grpc.ResponseFuture<$15.VerifyPaymentResponse> verifyPayment($15.VerifyPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPayment, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetPaymentHistoryResponse> getPaymentHistory($15.GetPaymentHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetPaymentReceiptResponse> getPaymentReceipt($15.GetPaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$15.SaveBeneficiaryResponse> saveBeneficiary($15.SaveBeneficiaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetBeneficiariesResponse> getBeneficiaries($15.GetBeneficiariesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdateBeneficiaryResponse> updateBeneficiary($15.UpdateBeneficiaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$15.DeleteBeneficiaryResponse> deleteBeneficiary($15.DeleteBeneficiaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$15.CreateAutoRechargeResponse> createAutoRecharge($15.CreateAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetAutoRechargesResponse> getAutoRecharges($15.GetAutoRechargesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdateAutoRechargeResponse> updateAutoRecharge($15.UpdateAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$15.DeleteAutoRechargeResponse> deleteAutoRecharge($15.DeleteAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$15.PauseAutoRechargeResponse> pauseAutoRecharge($15.PauseAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$15.ResumeAutoRechargeResponse> resumeAutoRecharge($15.ResumeAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$15.CreateReminderResponse> createReminder($15.CreateReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createReminder, request, options: options);
  }

  $grpc.ResponseFuture<$15.GetRemindersResponse> getReminders($15.GetRemindersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReminders, request, options: options);
  }

  $grpc.ResponseFuture<$15.UpdateReminderResponse> updateReminder($15.UpdateReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateReminder, request, options: options);
  }

  $grpc.ResponseFuture<$15.DeleteReminderResponse> deleteReminder($15.DeleteReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteReminder, request, options: options);
  }

  $grpc.ResponseFuture<$15.MarkReminderCompleteResponse> markReminderComplete($15.MarkReminderCompleteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markReminderComplete, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.ElectricityBillService')
abstract class ElectricityBillServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ElectricityBillService';

  ElectricityBillServiceBase() {
    $addMethod($grpc.ServiceMethod<$15.GetProvidersRequest, $15.GetProvidersResponse>(
        'GetProviders',
        getProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetProvidersRequest.fromBuffer(value),
        ($15.GetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.SyncProvidersRequest, $15.SyncProvidersResponse>(
        'SyncProviders',
        syncProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.SyncProvidersRequest.fromBuffer(value),
        ($15.SyncProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ValidateMeterRequest, $15.ValidateMeterResponse>(
        'ValidateMeterNumber',
        validateMeterNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.ValidateMeterRequest.fromBuffer(value),
        ($15.ValidateMeterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetBillDetailsRequest, $15.GetBillDetailsResponse>(
        'GetBillDetails',
        getBillDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetBillDetailsRequest.fromBuffer(value),
        ($15.GetBillDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.InitiatePaymentRequest, $15.InitiatePaymentResponse>(
        'InitiatePayment',
        initiatePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.InitiatePaymentRequest.fromBuffer(value),
        ($15.InitiatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.VerifyPaymentRequest, $15.VerifyPaymentResponse>(
        'VerifyPayment',
        verifyPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.VerifyPaymentRequest.fromBuffer(value),
        ($15.VerifyPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetPaymentHistoryRequest, $15.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetPaymentHistoryRequest.fromBuffer(value),
        ($15.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetPaymentReceiptRequest, $15.GetPaymentReceiptResponse>(
        'GetPaymentReceipt',
        getPaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetPaymentReceiptRequest.fromBuffer(value),
        ($15.GetPaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.SaveBeneficiaryRequest, $15.SaveBeneficiaryResponse>(
        'SaveBeneficiary',
        saveBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.SaveBeneficiaryRequest.fromBuffer(value),
        ($15.SaveBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetBeneficiariesRequest, $15.GetBeneficiariesResponse>(
        'GetBeneficiaries',
        getBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetBeneficiariesRequest.fromBuffer(value),
        ($15.GetBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateBeneficiaryRequest, $15.UpdateBeneficiaryResponse>(
        'UpdateBeneficiary',
        updateBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.UpdateBeneficiaryRequest.fromBuffer(value),
        ($15.UpdateBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.DeleteBeneficiaryRequest, $15.DeleteBeneficiaryResponse>(
        'DeleteBeneficiary',
        deleteBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.DeleteBeneficiaryRequest.fromBuffer(value),
        ($15.DeleteBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.CreateAutoRechargeRequest, $15.CreateAutoRechargeResponse>(
        'CreateAutoRecharge',
        createAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.CreateAutoRechargeRequest.fromBuffer(value),
        ($15.CreateAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetAutoRechargesRequest, $15.GetAutoRechargesResponse>(
        'GetAutoRecharges',
        getAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetAutoRechargesRequest.fromBuffer(value),
        ($15.GetAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateAutoRechargeRequest, $15.UpdateAutoRechargeResponse>(
        'UpdateAutoRecharge',
        updateAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.UpdateAutoRechargeRequest.fromBuffer(value),
        ($15.UpdateAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.DeleteAutoRechargeRequest, $15.DeleteAutoRechargeResponse>(
        'DeleteAutoRecharge',
        deleteAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.DeleteAutoRechargeRequest.fromBuffer(value),
        ($15.DeleteAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.PauseAutoRechargeRequest, $15.PauseAutoRechargeResponse>(
        'PauseAutoRecharge',
        pauseAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.PauseAutoRechargeRequest.fromBuffer(value),
        ($15.PauseAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.ResumeAutoRechargeRequest, $15.ResumeAutoRechargeResponse>(
        'ResumeAutoRecharge',
        resumeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.ResumeAutoRechargeRequest.fromBuffer(value),
        ($15.ResumeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.CreateReminderRequest, $15.CreateReminderResponse>(
        'CreateReminder',
        createReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.CreateReminderRequest.fromBuffer(value),
        ($15.CreateReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.GetRemindersRequest, $15.GetRemindersResponse>(
        'GetReminders',
        getReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.GetRemindersRequest.fromBuffer(value),
        ($15.GetRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.UpdateReminderRequest, $15.UpdateReminderResponse>(
        'UpdateReminder',
        updateReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.UpdateReminderRequest.fromBuffer(value),
        ($15.UpdateReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.DeleteReminderRequest, $15.DeleteReminderResponse>(
        'DeleteReminder',
        deleteReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.DeleteReminderRequest.fromBuffer(value),
        ($15.DeleteReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$15.MarkReminderCompleteRequest, $15.MarkReminderCompleteResponse>(
        'MarkReminderComplete',
        markReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $15.MarkReminderCompleteRequest.fromBuffer(value),
        ($15.MarkReminderCompleteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$15.GetProvidersResponse> getProviders_Pre($grpc.ServiceCall call, $async.Future<$15.GetProvidersRequest> request) async {
    return getProviders(call, await request);
  }

  $async.Future<$15.SyncProvidersResponse> syncProviders_Pre($grpc.ServiceCall call, $async.Future<$15.SyncProvidersRequest> request) async {
    return syncProviders(call, await request);
  }

  $async.Future<$15.ValidateMeterResponse> validateMeterNumber_Pre($grpc.ServiceCall call, $async.Future<$15.ValidateMeterRequest> request) async {
    return validateMeterNumber(call, await request);
  }

  $async.Future<$15.GetBillDetailsResponse> getBillDetails_Pre($grpc.ServiceCall call, $async.Future<$15.GetBillDetailsRequest> request) async {
    return getBillDetails(call, await request);
  }

  $async.Future<$15.InitiatePaymentResponse> initiatePayment_Pre($grpc.ServiceCall call, $async.Future<$15.InitiatePaymentRequest> request) async {
    return initiatePayment(call, await request);
  }

  $async.Future<$15.VerifyPaymentResponse> verifyPayment_Pre($grpc.ServiceCall call, $async.Future<$15.VerifyPaymentRequest> request) async {
    return verifyPayment(call, await request);
  }

  $async.Future<$15.GetPaymentHistoryResponse> getPaymentHistory_Pre($grpc.ServiceCall call, $async.Future<$15.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$15.GetPaymentReceiptResponse> getPaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$15.GetPaymentReceiptRequest> request) async {
    return getPaymentReceipt(call, await request);
  }

  $async.Future<$15.SaveBeneficiaryResponse> saveBeneficiary_Pre($grpc.ServiceCall call, $async.Future<$15.SaveBeneficiaryRequest> request) async {
    return saveBeneficiary(call, await request);
  }

  $async.Future<$15.GetBeneficiariesResponse> getBeneficiaries_Pre($grpc.ServiceCall call, $async.Future<$15.GetBeneficiariesRequest> request) async {
    return getBeneficiaries(call, await request);
  }

  $async.Future<$15.UpdateBeneficiaryResponse> updateBeneficiary_Pre($grpc.ServiceCall call, $async.Future<$15.UpdateBeneficiaryRequest> request) async {
    return updateBeneficiary(call, await request);
  }

  $async.Future<$15.DeleteBeneficiaryResponse> deleteBeneficiary_Pre($grpc.ServiceCall call, $async.Future<$15.DeleteBeneficiaryRequest> request) async {
    return deleteBeneficiary(call, await request);
  }

  $async.Future<$15.CreateAutoRechargeResponse> createAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$15.CreateAutoRechargeRequest> request) async {
    return createAutoRecharge(call, await request);
  }

  $async.Future<$15.GetAutoRechargesResponse> getAutoRecharges_Pre($grpc.ServiceCall call, $async.Future<$15.GetAutoRechargesRequest> request) async {
    return getAutoRecharges(call, await request);
  }

  $async.Future<$15.UpdateAutoRechargeResponse> updateAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$15.UpdateAutoRechargeRequest> request) async {
    return updateAutoRecharge(call, await request);
  }

  $async.Future<$15.DeleteAutoRechargeResponse> deleteAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$15.DeleteAutoRechargeRequest> request) async {
    return deleteAutoRecharge(call, await request);
  }

  $async.Future<$15.PauseAutoRechargeResponse> pauseAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$15.PauseAutoRechargeRequest> request) async {
    return pauseAutoRecharge(call, await request);
  }

  $async.Future<$15.ResumeAutoRechargeResponse> resumeAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$15.ResumeAutoRechargeRequest> request) async {
    return resumeAutoRecharge(call, await request);
  }

  $async.Future<$15.CreateReminderResponse> createReminder_Pre($grpc.ServiceCall call, $async.Future<$15.CreateReminderRequest> request) async {
    return createReminder(call, await request);
  }

  $async.Future<$15.GetRemindersResponse> getReminders_Pre($grpc.ServiceCall call, $async.Future<$15.GetRemindersRequest> request) async {
    return getReminders(call, await request);
  }

  $async.Future<$15.UpdateReminderResponse> updateReminder_Pre($grpc.ServiceCall call, $async.Future<$15.UpdateReminderRequest> request) async {
    return updateReminder(call, await request);
  }

  $async.Future<$15.DeleteReminderResponse> deleteReminder_Pre($grpc.ServiceCall call, $async.Future<$15.DeleteReminderRequest> request) async {
    return deleteReminder(call, await request);
  }

  $async.Future<$15.MarkReminderCompleteResponse> markReminderComplete_Pre($grpc.ServiceCall call, $async.Future<$15.MarkReminderCompleteRequest> request) async {
    return markReminderComplete(call, await request);
  }

  $async.Future<$15.GetProvidersResponse> getProviders($grpc.ServiceCall call, $15.GetProvidersRequest request);
  $async.Future<$15.SyncProvidersResponse> syncProviders($grpc.ServiceCall call, $15.SyncProvidersRequest request);
  $async.Future<$15.ValidateMeterResponse> validateMeterNumber($grpc.ServiceCall call, $15.ValidateMeterRequest request);
  $async.Future<$15.GetBillDetailsResponse> getBillDetails($grpc.ServiceCall call, $15.GetBillDetailsRequest request);
  $async.Future<$15.InitiatePaymentResponse> initiatePayment($grpc.ServiceCall call, $15.InitiatePaymentRequest request);
  $async.Future<$15.VerifyPaymentResponse> verifyPayment($grpc.ServiceCall call, $15.VerifyPaymentRequest request);
  $async.Future<$15.GetPaymentHistoryResponse> getPaymentHistory($grpc.ServiceCall call, $15.GetPaymentHistoryRequest request);
  $async.Future<$15.GetPaymentReceiptResponse> getPaymentReceipt($grpc.ServiceCall call, $15.GetPaymentReceiptRequest request);
  $async.Future<$15.SaveBeneficiaryResponse> saveBeneficiary($grpc.ServiceCall call, $15.SaveBeneficiaryRequest request);
  $async.Future<$15.GetBeneficiariesResponse> getBeneficiaries($grpc.ServiceCall call, $15.GetBeneficiariesRequest request);
  $async.Future<$15.UpdateBeneficiaryResponse> updateBeneficiary($grpc.ServiceCall call, $15.UpdateBeneficiaryRequest request);
  $async.Future<$15.DeleteBeneficiaryResponse> deleteBeneficiary($grpc.ServiceCall call, $15.DeleteBeneficiaryRequest request);
  $async.Future<$15.CreateAutoRechargeResponse> createAutoRecharge($grpc.ServiceCall call, $15.CreateAutoRechargeRequest request);
  $async.Future<$15.GetAutoRechargesResponse> getAutoRecharges($grpc.ServiceCall call, $15.GetAutoRechargesRequest request);
  $async.Future<$15.UpdateAutoRechargeResponse> updateAutoRecharge($grpc.ServiceCall call, $15.UpdateAutoRechargeRequest request);
  $async.Future<$15.DeleteAutoRechargeResponse> deleteAutoRecharge($grpc.ServiceCall call, $15.DeleteAutoRechargeRequest request);
  $async.Future<$15.PauseAutoRechargeResponse> pauseAutoRecharge($grpc.ServiceCall call, $15.PauseAutoRechargeRequest request);
  $async.Future<$15.ResumeAutoRechargeResponse> resumeAutoRecharge($grpc.ServiceCall call, $15.ResumeAutoRechargeRequest request);
  $async.Future<$15.CreateReminderResponse> createReminder($grpc.ServiceCall call, $15.CreateReminderRequest request);
  $async.Future<$15.GetRemindersResponse> getReminders($grpc.ServiceCall call, $15.GetRemindersRequest request);
  $async.Future<$15.UpdateReminderResponse> updateReminder($grpc.ServiceCall call, $15.UpdateReminderRequest request);
  $async.Future<$15.DeleteReminderResponse> deleteReminder($grpc.ServiceCall call, $15.DeleteReminderRequest request);
  $async.Future<$15.MarkReminderCompleteResponse> markReminderComplete($grpc.ServiceCall call, $15.MarkReminderCompleteRequest request);
}
