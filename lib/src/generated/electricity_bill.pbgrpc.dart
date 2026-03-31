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

import 'electricity_bill.pb.dart' as $0;

export 'electricity_bill.pb.dart';

@$pb.GrpcServiceName('pb.ElectricityBillService')
class ElectricityBillServiceClient extends $grpc.Client {
  static final _$getProviders = $grpc.ClientMethod<$0.GetProvidersRequest, $0.GetProvidersResponse>(
      '/pb.ElectricityBillService/GetProviders',
      ($0.GetProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetProvidersResponse.fromBuffer(value));
  static final _$syncProviders = $grpc.ClientMethod<$0.SyncProvidersRequest, $0.SyncProvidersResponse>(
      '/pb.ElectricityBillService/SyncProviders',
      ($0.SyncProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SyncProvidersResponse.fromBuffer(value));
  static final _$validateMeterNumber = $grpc.ClientMethod<$0.ValidateMeterRequest, $0.ValidateMeterResponse>(
      '/pb.ElectricityBillService/ValidateMeterNumber',
      ($0.ValidateMeterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ValidateMeterResponse.fromBuffer(value));
  static final _$smartValidateMeter = $grpc.ClientMethod<$0.SmartValidateMeterRequest, $0.SmartValidateMeterResponse>(
      '/pb.ElectricityBillService/SmartValidateMeter',
      ($0.SmartValidateMeterRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SmartValidateMeterResponse.fromBuffer(value));
  static final _$getBillDetails = $grpc.ClientMethod<$0.GetBillDetailsRequest, $0.GetBillDetailsResponse>(
      '/pb.ElectricityBillService/GetBillDetails',
      ($0.GetBillDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBillDetailsResponse.fromBuffer(value));
  static final _$initiatePayment = $grpc.ClientMethod<$0.InitiatePaymentRequest, $0.InitiatePaymentResponse>(
      '/pb.ElectricityBillService/InitiatePayment',
      ($0.InitiatePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.InitiatePaymentResponse.fromBuffer(value));
  static final _$verifyPayment = $grpc.ClientMethod<$0.VerifyPaymentRequest, $0.VerifyPaymentResponse>(
      '/pb.ElectricityBillService/VerifyPayment',
      ($0.VerifyPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifyPaymentResponse.fromBuffer(value));
  static final _$getPaymentHistory = $grpc.ClientMethod<$0.GetPaymentHistoryRequest, $0.GetPaymentHistoryResponse>(
      '/pb.ElectricityBillService/GetPaymentHistory',
      ($0.GetPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPaymentHistoryResponse.fromBuffer(value));
  static final _$getPaymentReceipt = $grpc.ClientMethod<$0.GetPaymentReceiptRequest, $0.GetPaymentReceiptResponse>(
      '/pb.ElectricityBillService/GetPaymentReceipt',
      ($0.GetPaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPaymentReceiptResponse.fromBuffer(value));
  static final _$saveBeneficiary = $grpc.ClientMethod<$0.SaveBeneficiaryRequest, $0.SaveBeneficiaryResponse>(
      '/pb.ElectricityBillService/SaveBeneficiary',
      ($0.SaveBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SaveBeneficiaryResponse.fromBuffer(value));
  static final _$getBeneficiaries = $grpc.ClientMethod<$0.GetBeneficiariesRequest, $0.GetBeneficiariesResponse>(
      '/pb.ElectricityBillService/GetBeneficiaries',
      ($0.GetBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBeneficiariesResponse.fromBuffer(value));
  static final _$updateBeneficiary = $grpc.ClientMethod<$0.UpdateBeneficiaryRequest, $0.UpdateBeneficiaryResponse>(
      '/pb.ElectricityBillService/UpdateBeneficiary',
      ($0.UpdateBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateBeneficiaryResponse.fromBuffer(value));
  static final _$deleteBeneficiary = $grpc.ClientMethod<$0.DeleteBeneficiaryRequest, $0.DeleteBeneficiaryResponse>(
      '/pb.ElectricityBillService/DeleteBeneficiary',
      ($0.DeleteBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteBeneficiaryResponse.fromBuffer(value));
  static final _$createAutoRecharge = $grpc.ClientMethod<$0.CreateAutoRechargeRequest, $0.CreateAutoRechargeResponse>(
      '/pb.ElectricityBillService/CreateAutoRecharge',
      ($0.CreateAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateAutoRechargeResponse.fromBuffer(value));
  static final _$getAutoRecharges = $grpc.ClientMethod<$0.GetAutoRechargesRequest, $0.GetAutoRechargesResponse>(
      '/pb.ElectricityBillService/GetAutoRecharges',
      ($0.GetAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAutoRechargesResponse.fromBuffer(value));
  static final _$updateAutoRecharge = $grpc.ClientMethod<$0.UpdateAutoRechargeRequest, $0.UpdateAutoRechargeResponse>(
      '/pb.ElectricityBillService/UpdateAutoRecharge',
      ($0.UpdateAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateAutoRechargeResponse.fromBuffer(value));
  static final _$deleteAutoRecharge = $grpc.ClientMethod<$0.DeleteAutoRechargeRequest, $0.DeleteAutoRechargeResponse>(
      '/pb.ElectricityBillService/DeleteAutoRecharge',
      ($0.DeleteAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteAutoRechargeResponse.fromBuffer(value));
  static final _$pauseAutoRecharge = $grpc.ClientMethod<$0.PauseAutoRechargeRequest, $0.PauseAutoRechargeResponse>(
      '/pb.ElectricityBillService/PauseAutoRecharge',
      ($0.PauseAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PauseAutoRechargeResponse.fromBuffer(value));
  static final _$resumeAutoRecharge = $grpc.ClientMethod<$0.ResumeAutoRechargeRequest, $0.ResumeAutoRechargeResponse>(
      '/pb.ElectricityBillService/ResumeAutoRecharge',
      ($0.ResumeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResumeAutoRechargeResponse.fromBuffer(value));
  static final _$createReminder = $grpc.ClientMethod<$0.CreateReminderRequest, $0.CreateReminderResponse>(
      '/pb.ElectricityBillService/CreateReminder',
      ($0.CreateReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateReminderResponse.fromBuffer(value));
  static final _$getReminders = $grpc.ClientMethod<$0.GetRemindersRequest, $0.GetRemindersResponse>(
      '/pb.ElectricityBillService/GetReminders',
      ($0.GetRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetRemindersResponse.fromBuffer(value));
  static final _$updateReminder = $grpc.ClientMethod<$0.UpdateReminderRequest, $0.UpdateReminderResponse>(
      '/pb.ElectricityBillService/UpdateReminder',
      ($0.UpdateReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateReminderResponse.fromBuffer(value));
  static final _$deleteReminder = $grpc.ClientMethod<$0.DeleteReminderRequest, $0.DeleteReminderResponse>(
      '/pb.ElectricityBillService/DeleteReminder',
      ($0.DeleteReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteReminderResponse.fromBuffer(value));
  static final _$markReminderComplete = $grpc.ClientMethod<$0.MarkReminderCompleteRequest, $0.MarkReminderCompleteResponse>(
      '/pb.ElectricityBillService/MarkReminderComplete',
      ($0.MarkReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MarkReminderCompleteResponse.fromBuffer(value));

  ElectricityBillServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetProvidersResponse> getProviders($0.GetProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.SyncProvidersResponse> syncProviders($0.SyncProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$syncProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateMeterResponse> validateMeterNumber($0.ValidateMeterRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateMeterNumber, request, options: options);
  }

  $grpc.ResponseFuture<$0.SmartValidateMeterResponse> smartValidateMeter($0.SmartValidateMeterRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$smartValidateMeter, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBillDetailsResponse> getBillDetails($0.GetBillDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.InitiatePaymentResponse> initiatePayment($0.InitiatePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifyPaymentResponse> verifyPayment($0.VerifyPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyPayment, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentHistoryResponse> getPaymentHistory($0.GetPaymentHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentReceiptResponse> getPaymentReceipt($0.GetPaymentReceiptRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentReceipt, request, options: options);
  }

  $grpc.ResponseFuture<$0.SaveBeneficiaryResponse> saveBeneficiary($0.SaveBeneficiaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBeneficiariesResponse> getBeneficiaries($0.GetBeneficiariesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateBeneficiaryResponse> updateBeneficiary($0.UpdateBeneficiaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteBeneficiaryResponse> deleteBeneficiary($0.DeleteBeneficiaryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateAutoRechargeResponse> createAutoRecharge($0.CreateAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoRechargesResponse> getAutoRecharges($0.GetAutoRechargesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoRechargeResponse> updateAutoRecharge($0.UpdateAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAutoRechargeResponse> deleteAutoRecharge($0.DeleteAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$0.PauseAutoRechargeResponse> pauseAutoRecharge($0.PauseAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResumeAutoRechargeResponse> resumeAutoRecharge($0.ResumeAutoRechargeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateReminderResponse> createReminder($0.CreateReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetRemindersResponse> getReminders($0.GetRemindersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReminders, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateReminderResponse> updateReminder($0.UpdateReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteReminderResponse> deleteReminder($0.DeleteReminderRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteReminder, request, options: options);
  }

  $grpc.ResponseFuture<$0.MarkReminderCompleteResponse> markReminderComplete($0.MarkReminderCompleteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markReminderComplete, request, options: options);
  }
}

@$pb.GrpcServiceName('pb.ElectricityBillService')
abstract class ElectricityBillServiceBase extends $grpc.Service {
  $core.String get $name => 'pb.ElectricityBillService';

  ElectricityBillServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetProvidersRequest, $0.GetProvidersResponse>(
        'GetProviders',
        getProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProvidersRequest.fromBuffer(value),
        ($0.GetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SyncProvidersRequest, $0.SyncProvidersResponse>(
        'SyncProviders',
        syncProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SyncProvidersRequest.fromBuffer(value),
        ($0.SyncProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateMeterRequest, $0.ValidateMeterResponse>(
        'ValidateMeterNumber',
        validateMeterNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ValidateMeterRequest.fromBuffer(value),
        ($0.ValidateMeterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SmartValidateMeterRequest, $0.SmartValidateMeterResponse>(
        'SmartValidateMeter',
        smartValidateMeter_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SmartValidateMeterRequest.fromBuffer(value),
        ($0.SmartValidateMeterResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBillDetailsRequest, $0.GetBillDetailsResponse>(
        'GetBillDetails',
        getBillDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBillDetailsRequest.fromBuffer(value),
        ($0.GetBillDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiatePaymentRequest, $0.InitiatePaymentResponse>(
        'InitiatePayment',
        initiatePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.InitiatePaymentRequest.fromBuffer(value),
        ($0.InitiatePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyPaymentRequest, $0.VerifyPaymentResponse>(
        'VerifyPayment',
        verifyPayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyPaymentRequest.fromBuffer(value),
        ($0.VerifyPaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentHistoryRequest, $0.GetPaymentHistoryResponse>(
        'GetPaymentHistory',
        getPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPaymentHistoryRequest.fromBuffer(value),
        ($0.GetPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentReceiptRequest, $0.GetPaymentReceiptResponse>(
        'GetPaymentReceipt',
        getPaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPaymentReceiptRequest.fromBuffer(value),
        ($0.GetPaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SaveBeneficiaryRequest, $0.SaveBeneficiaryResponse>(
        'SaveBeneficiary',
        saveBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SaveBeneficiaryRequest.fromBuffer(value),
        ($0.SaveBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBeneficiariesRequest, $0.GetBeneficiariesResponse>(
        'GetBeneficiaries',
        getBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBeneficiariesRequest.fromBuffer(value),
        ($0.GetBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBeneficiaryRequest, $0.UpdateBeneficiaryResponse>(
        'UpdateBeneficiary',
        updateBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateBeneficiaryRequest.fromBuffer(value),
        ($0.UpdateBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteBeneficiaryRequest, $0.DeleteBeneficiaryResponse>(
        'DeleteBeneficiary',
        deleteBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteBeneficiaryRequest.fromBuffer(value),
        ($0.DeleteBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAutoRechargeRequest, $0.CreateAutoRechargeResponse>(
        'CreateAutoRecharge',
        createAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateAutoRechargeRequest.fromBuffer(value),
        ($0.CreateAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoRechargesRequest, $0.GetAutoRechargesResponse>(
        'GetAutoRecharges',
        getAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAutoRechargesRequest.fromBuffer(value),
        ($0.GetAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoRechargeRequest, $0.UpdateAutoRechargeResponse>(
        'UpdateAutoRecharge',
        updateAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateAutoRechargeRequest.fromBuffer(value),
        ($0.UpdateAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAutoRechargeRequest, $0.DeleteAutoRechargeResponse>(
        'DeleteAutoRecharge',
        deleteAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteAutoRechargeRequest.fromBuffer(value),
        ($0.DeleteAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PauseAutoRechargeRequest, $0.PauseAutoRechargeResponse>(
        'PauseAutoRecharge',
        pauseAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PauseAutoRechargeRequest.fromBuffer(value),
        ($0.PauseAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ResumeAutoRechargeRequest, $0.ResumeAutoRechargeResponse>(
        'ResumeAutoRecharge',
        resumeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ResumeAutoRechargeRequest.fromBuffer(value),
        ($0.ResumeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateReminderRequest, $0.CreateReminderResponse>(
        'CreateReminder',
        createReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateReminderRequest.fromBuffer(value),
        ($0.CreateReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRemindersRequest, $0.GetRemindersResponse>(
        'GetReminders',
        getReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetRemindersRequest.fromBuffer(value),
        ($0.GetRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateReminderRequest, $0.UpdateReminderResponse>(
        'UpdateReminder',
        updateReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateReminderRequest.fromBuffer(value),
        ($0.UpdateReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteReminderRequest, $0.DeleteReminderResponse>(
        'DeleteReminder',
        deleteReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteReminderRequest.fromBuffer(value),
        ($0.DeleteReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MarkReminderCompleteRequest, $0.MarkReminderCompleteResponse>(
        'MarkReminderComplete',
        markReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MarkReminderCompleteRequest.fromBuffer(value),
        ($0.MarkReminderCompleteResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetProvidersResponse> getProviders_Pre($grpc.ServiceCall call, $async.Future<$0.GetProvidersRequest> request) async {
    return getProviders(call, await request);
  }

  $async.Future<$0.SyncProvidersResponse> syncProviders_Pre($grpc.ServiceCall call, $async.Future<$0.SyncProvidersRequest> request) async {
    return syncProviders(call, await request);
  }

  $async.Future<$0.ValidateMeterResponse> validateMeterNumber_Pre($grpc.ServiceCall call, $async.Future<$0.ValidateMeterRequest> request) async {
    return validateMeterNumber(call, await request);
  }

  $async.Future<$0.SmartValidateMeterResponse> smartValidateMeter_Pre($grpc.ServiceCall call, $async.Future<$0.SmartValidateMeterRequest> request) async {
    return smartValidateMeter(call, await request);
  }

  $async.Future<$0.GetBillDetailsResponse> getBillDetails_Pre($grpc.ServiceCall call, $async.Future<$0.GetBillDetailsRequest> request) async {
    return getBillDetails(call, await request);
  }

  $async.Future<$0.InitiatePaymentResponse> initiatePayment_Pre($grpc.ServiceCall call, $async.Future<$0.InitiatePaymentRequest> request) async {
    return initiatePayment(call, await request);
  }

  $async.Future<$0.VerifyPaymentResponse> verifyPayment_Pre($grpc.ServiceCall call, $async.Future<$0.VerifyPaymentRequest> request) async {
    return verifyPayment(call, await request);
  }

  $async.Future<$0.GetPaymentHistoryResponse> getPaymentHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetPaymentHistoryRequest> request) async {
    return getPaymentHistory(call, await request);
  }

  $async.Future<$0.GetPaymentReceiptResponse> getPaymentReceipt_Pre($grpc.ServiceCall call, $async.Future<$0.GetPaymentReceiptRequest> request) async {
    return getPaymentReceipt(call, await request);
  }

  $async.Future<$0.SaveBeneficiaryResponse> saveBeneficiary_Pre($grpc.ServiceCall call, $async.Future<$0.SaveBeneficiaryRequest> request) async {
    return saveBeneficiary(call, await request);
  }

  $async.Future<$0.GetBeneficiariesResponse> getBeneficiaries_Pre($grpc.ServiceCall call, $async.Future<$0.GetBeneficiariesRequest> request) async {
    return getBeneficiaries(call, await request);
  }

  $async.Future<$0.UpdateBeneficiaryResponse> updateBeneficiary_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateBeneficiaryRequest> request) async {
    return updateBeneficiary(call, await request);
  }

  $async.Future<$0.DeleteBeneficiaryResponse> deleteBeneficiary_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteBeneficiaryRequest> request) async {
    return deleteBeneficiary(call, await request);
  }

  $async.Future<$0.CreateAutoRechargeResponse> createAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$0.CreateAutoRechargeRequest> request) async {
    return createAutoRecharge(call, await request);
  }

  $async.Future<$0.GetAutoRechargesResponse> getAutoRecharges_Pre($grpc.ServiceCall call, $async.Future<$0.GetAutoRechargesRequest> request) async {
    return getAutoRecharges(call, await request);
  }

  $async.Future<$0.UpdateAutoRechargeResponse> updateAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateAutoRechargeRequest> request) async {
    return updateAutoRecharge(call, await request);
  }

  $async.Future<$0.DeleteAutoRechargeResponse> deleteAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteAutoRechargeRequest> request) async {
    return deleteAutoRecharge(call, await request);
  }

  $async.Future<$0.PauseAutoRechargeResponse> pauseAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$0.PauseAutoRechargeRequest> request) async {
    return pauseAutoRecharge(call, await request);
  }

  $async.Future<$0.ResumeAutoRechargeResponse> resumeAutoRecharge_Pre($grpc.ServiceCall call, $async.Future<$0.ResumeAutoRechargeRequest> request) async {
    return resumeAutoRecharge(call, await request);
  }

  $async.Future<$0.CreateReminderResponse> createReminder_Pre($grpc.ServiceCall call, $async.Future<$0.CreateReminderRequest> request) async {
    return createReminder(call, await request);
  }

  $async.Future<$0.GetRemindersResponse> getReminders_Pre($grpc.ServiceCall call, $async.Future<$0.GetRemindersRequest> request) async {
    return getReminders(call, await request);
  }

  $async.Future<$0.UpdateReminderResponse> updateReminder_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateReminderRequest> request) async {
    return updateReminder(call, await request);
  }

  $async.Future<$0.DeleteReminderResponse> deleteReminder_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteReminderRequest> request) async {
    return deleteReminder(call, await request);
  }

  $async.Future<$0.MarkReminderCompleteResponse> markReminderComplete_Pre($grpc.ServiceCall call, $async.Future<$0.MarkReminderCompleteRequest> request) async {
    return markReminderComplete(call, await request);
  }

  $async.Future<$0.GetProvidersResponse> getProviders($grpc.ServiceCall call, $0.GetProvidersRequest request);
  $async.Future<$0.SyncProvidersResponse> syncProviders($grpc.ServiceCall call, $0.SyncProvidersRequest request);
  $async.Future<$0.ValidateMeterResponse> validateMeterNumber($grpc.ServiceCall call, $0.ValidateMeterRequest request);
  $async.Future<$0.SmartValidateMeterResponse> smartValidateMeter($grpc.ServiceCall call, $0.SmartValidateMeterRequest request);
  $async.Future<$0.GetBillDetailsResponse> getBillDetails($grpc.ServiceCall call, $0.GetBillDetailsRequest request);
  $async.Future<$0.InitiatePaymentResponse> initiatePayment($grpc.ServiceCall call, $0.InitiatePaymentRequest request);
  $async.Future<$0.VerifyPaymentResponse> verifyPayment($grpc.ServiceCall call, $0.VerifyPaymentRequest request);
  $async.Future<$0.GetPaymentHistoryResponse> getPaymentHistory($grpc.ServiceCall call, $0.GetPaymentHistoryRequest request);
  $async.Future<$0.GetPaymentReceiptResponse> getPaymentReceipt($grpc.ServiceCall call, $0.GetPaymentReceiptRequest request);
  $async.Future<$0.SaveBeneficiaryResponse> saveBeneficiary($grpc.ServiceCall call, $0.SaveBeneficiaryRequest request);
  $async.Future<$0.GetBeneficiariesResponse> getBeneficiaries($grpc.ServiceCall call, $0.GetBeneficiariesRequest request);
  $async.Future<$0.UpdateBeneficiaryResponse> updateBeneficiary($grpc.ServiceCall call, $0.UpdateBeneficiaryRequest request);
  $async.Future<$0.DeleteBeneficiaryResponse> deleteBeneficiary($grpc.ServiceCall call, $0.DeleteBeneficiaryRequest request);
  $async.Future<$0.CreateAutoRechargeResponse> createAutoRecharge($grpc.ServiceCall call, $0.CreateAutoRechargeRequest request);
  $async.Future<$0.GetAutoRechargesResponse> getAutoRecharges($grpc.ServiceCall call, $0.GetAutoRechargesRequest request);
  $async.Future<$0.UpdateAutoRechargeResponse> updateAutoRecharge($grpc.ServiceCall call, $0.UpdateAutoRechargeRequest request);
  $async.Future<$0.DeleteAutoRechargeResponse> deleteAutoRecharge($grpc.ServiceCall call, $0.DeleteAutoRechargeRequest request);
  $async.Future<$0.PauseAutoRechargeResponse> pauseAutoRecharge($grpc.ServiceCall call, $0.PauseAutoRechargeRequest request);
  $async.Future<$0.ResumeAutoRechargeResponse> resumeAutoRecharge($grpc.ServiceCall call, $0.ResumeAutoRechargeRequest request);
  $async.Future<$0.CreateReminderResponse> createReminder($grpc.ServiceCall call, $0.CreateReminderRequest request);
  $async.Future<$0.GetRemindersResponse> getReminders($grpc.ServiceCall call, $0.GetRemindersRequest request);
  $async.Future<$0.UpdateReminderResponse> updateReminder($grpc.ServiceCall call, $0.UpdateReminderRequest request);
  $async.Future<$0.DeleteReminderResponse> deleteReminder($grpc.ServiceCall call, $0.DeleteReminderRequest request);
  $async.Future<$0.MarkReminderCompleteResponse> markReminderComplete($grpc.ServiceCall call, $0.MarkReminderCompleteRequest request);
}
