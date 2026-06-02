///
//  Generated code. Do not modify.
//  source: utility-payments.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'utility-payments.pb.dart' as $1;
export 'utility-payments.pb.dart';

class UtilityPaymentsServiceClient extends $grpc.Client {
  static final _$payElectricityBill = $grpc.ClientMethod<
          $1.PayElectricityBillRequest, $1.PayElectricityBillResponse>(
      '/utilitypayments.UtilityPaymentsService/PayElectricityBill',
      ($1.PayElectricityBillRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PayElectricityBillResponse.fromBuffer(value));
  static final _$payWaterBill =
      $grpc.ClientMethod<$1.PayWaterBillRequest, $1.PayWaterBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayWaterBill',
          ($1.PayWaterBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.PayWaterBillResponse.fromBuffer(value));
  static final _$payInternetBill =
      $grpc.ClientMethod<$1.PayInternetBillRequest, $1.PayInternetBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayInternetBill',
          ($1.PayInternetBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.PayInternetBillResponse.fromBuffer(value));
  static final _$buyAirtime =
      $grpc.ClientMethod<$1.BuyAirtimeRequest, $1.BuyAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyAirtime',
          ($1.BuyAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.BuyAirtimeResponse.fromBuffer(value));
  static final _$buyData =
      $grpc.ClientMethod<$1.BuyDataRequest, $1.BuyDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyData',
          ($1.BuyDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.BuyDataResponse.fromBuffer(value));
  static final _$getDataPlans =
      $grpc.ClientMethod<$1.GetDataPlansRequest, $1.GetDataPlansResponse>(
          '/utilitypayments.UtilityPaymentsService/GetDataPlans',
          ($1.GetDataPlansRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetDataPlansResponse.fromBuffer(value));
  static final _$barcodePay =
      $grpc.ClientMethod<$1.BarcodePayRequest, $1.BarcodePayResponse>(
          '/utilitypayments.UtilityPaymentsService/BarcodePay',
          ($1.BarcodePayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.BarcodePayResponse.fromBuffer(value));
  static final _$scanToPay =
      $grpc.ClientMethod<$1.ScanToPayRequest, $1.ScanToPayResponse>(
          '/utilitypayments.UtilityPaymentsService/ScanToPay',
          ($1.ScanToPayRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.ScanToPayResponse.fromBuffer(value));
  static final _$getBillPaymentHistory = $grpc.ClientMethod<
          $1.GetBillPaymentHistoryRequest, $1.GetBillPaymentHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillPaymentHistory',
      ($1.GetBillPaymentHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetBillPaymentHistoryResponse.fromBuffer(value));
  static final _$getBillProviders = $grpc.ClientMethod<
          $1.GetBillProvidersRequest, $1.GetBillProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetBillProviders',
      ($1.GetBillProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetBillProvidersResponse.fromBuffer(value));
  static final _$getAirtimeProviders = $grpc.ClientMethod<
          $1.GetAirtimeProvidersRequest, $1.GetAirtimeProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeProviders',
      ($1.GetAirtimeProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeProvidersResponse.fromBuffer(value));
  static final _$verifyBill =
      $grpc.ClientMethod<$1.VerifyBillRequest, $1.VerifyBillResponse>(
          '/utilitypayments.UtilityPaymentsService/VerifyBill',
          ($1.VerifyBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.VerifyBillResponse.fromBuffer(value));
  static final _$validateSmartCard = $grpc.ClientMethod<
          $1.ValidateSmartCardRequest, $1.ValidateSmartCardResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateSmartCard',
      ($1.ValidateSmartCardRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ValidateSmartCardResponse.fromBuffer(value));
  static final _$getTVPackages =
      $grpc.ClientMethod<$1.GetTVPackagesRequest, $1.GetTVPackagesResponse>(
          '/utilitypayments.UtilityPaymentsService/GetTVPackages',
          ($1.GetTVPackagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.GetTVPackagesResponse.fromBuffer(value));
  static final _$payCableTVBill =
      $grpc.ClientMethod<$1.PayCableTVBillRequest, $1.PayCableTVBillResponse>(
          '/utilitypayments.UtilityPaymentsService/PayCableTVBill',
          ($1.PayCableTVBillRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.PayCableTVBillResponse.fromBuffer(value));
  static final _$getCableTVProviders = $grpc.ClientMethod<
          $1.GetCableTVProvidersRequest, $1.GetCableTVProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVProviders',
      ($1.GetCableTVProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCableTVProvidersResponse.fromBuffer(value));
  static final _$getInternetProviders = $grpc.ClientMethod<
          $1.GetInternetProvidersRequest, $1.GetInternetProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetProviders',
      ($1.GetInternetProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInternetProvidersResponse.fromBuffer(value));
  static final _$validateInternetAccount = $grpc.ClientMethod<
          $1.ValidateInternetAccountRequest,
          $1.ValidateInternetAccountResponse>(
      '/utilitypayments.UtilityPaymentsService/ValidateInternetAccount',
      ($1.ValidateInternetAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ValidateInternetAccountResponse.fromBuffer(value));
  static final _$getInternetPackages = $grpc.ClientMethod<
          $1.GetInternetPackagesRequest, $1.GetInternetPackagesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetPackages',
      ($1.GetInternetPackagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInternetPackagesResponse.fromBuffer(value));
  static final _$purchaseEducationPin = $grpc.ClientMethod<
          $1.PurchaseEducationPinRequest, $1.PurchaseEducationPinResponse>(
      '/utilitypayments.UtilityPaymentsService/PurchaseEducationPin',
      ($1.PurchaseEducationPinRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PurchaseEducationPinResponse.fromBuffer(value));
  static final _$getEducationProviders = $grpc.ClientMethod<
          $1.GetEducationProvidersRequest, $1.GetEducationProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationProviders',
      ($1.GetEducationProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetEducationProvidersResponse.fromBuffer(value));
  static final _$saveEducationBeneficiary = $grpc.ClientMethod<
          $1.SaveEducationBeneficiaryRequest,
          $1.SaveEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveEducationBeneficiary',
      ($1.SaveEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SaveEducationBeneficiaryResponse.fromBuffer(value));
  static final _$getEducationBeneficiaries = $grpc.ClientMethod<
          $1.GetEducationBeneficiariesRequest,
          $1.GetEducationBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationBeneficiaries',
      ($1.GetEducationBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetEducationBeneficiariesResponse.fromBuffer(value));
  static final _$updateEducationBeneficiary = $grpc.ClientMethod<
          $1.UpdateEducationBeneficiaryRequest,
          $1.UpdateEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateEducationBeneficiary',
      ($1.UpdateEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateEducationBeneficiaryResponse.fromBuffer(value));
  static final _$deleteEducationBeneficiary = $grpc.ClientMethod<
          $1.DeleteEducationBeneficiaryRequest,
          $1.DeleteEducationBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteEducationBeneficiary',
      ($1.DeleteEducationBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteEducationBeneficiaryResponse.fromBuffer(value));
  static final _$createEducationReminder = $grpc.ClientMethod<
          $1.CreateEducationReminderRequest,
          $1.CreateEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateEducationReminder',
      ($1.CreateEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateEducationReminderResponse.fromBuffer(value));
  static final _$getEducationReminders = $grpc.ClientMethod<
          $1.GetEducationRemindersRequest, $1.GetEducationRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetEducationReminders',
      ($1.GetEducationRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetEducationRemindersResponse.fromBuffer(value));
  static final _$updateEducationReminder = $grpc.ClientMethod<
          $1.UpdateEducationReminderRequest,
          $1.UpdateEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateEducationReminder',
      ($1.UpdateEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateEducationReminderResponse.fromBuffer(value));
  static final _$deleteEducationReminder = $grpc.ClientMethod<
          $1.DeleteEducationReminderRequest,
          $1.DeleteEducationReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteEducationReminder',
      ($1.DeleteEducationReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteEducationReminderResponse.fromBuffer(value));
  static final _$markEducationReminderComplete = $grpc.ClientMethod<
          $1.MarkEducationReminderCompleteRequest,
          $1.MarkEducationReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkEducationReminderComplete',
      ($1.MarkEducationReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MarkEducationReminderCompleteResponse.fromBuffer(value));
  static final _$getActiveSubscriptions = $grpc.ClientMethod<
          $1.GetActiveSubscriptionsRequest, $1.GetActiveSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetActiveSubscriptions',
      ($1.GetActiveSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetActiveSubscriptionsResponse.fromBuffer(value));
  static final _$getSubscriptionSummary = $grpc.ClientMethod<
          $1.GetSubscriptionSummaryRequest, $1.GetSubscriptionSummaryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSummary',
      ($1.GetSubscriptionSummaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetSubscriptionSummaryResponse.fromBuffer(value));
  static final _$getSubscriptionSpending = $grpc.ClientMethod<
          $1.GetSubscriptionSpendingRequest,
          $1.GetSubscriptionSpendingResponse>(
      '/utilitypayments.UtilityPaymentsService/GetSubscriptionSpending',
      ($1.GetSubscriptionSpendingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetSubscriptionSpendingResponse.fromBuffer(value));
  static final _$enableAutoRenew =
      $grpc.ClientMethod<$1.EnableAutoRenewRequest, $1.EnableAutoRenewResponse>(
          '/utilitypayments.UtilityPaymentsService/EnableAutoRenew',
          ($1.EnableAutoRenewRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.EnableAutoRenewResponse.fromBuffer(value));
  static final _$disableAutoRenew = $grpc.ClientMethod<
          $1.DisableAutoRenewRequest, $1.DisableAutoRenewResponse>(
      '/utilitypayments.UtilityPaymentsService/DisableAutoRenew',
      ($1.DisableAutoRenewRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DisableAutoRenewResponse.fromBuffer(value));
  static final _$getAutoRenewSubscriptions = $grpc.ClientMethod<
          $1.GetAutoRenewSubscriptionsRequest,
          $1.GetAutoRenewSubscriptionsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAutoRenewSubscriptions',
      ($1.GetAutoRenewSubscriptionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAutoRenewSubscriptionsResponse.fromBuffer(value));
  static final _$updateAutoRenewPlan = $grpc.ClientMethod<
          $1.UpdateAutoRenewPlanRequest, $1.UpdateAutoRenewPlanResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAutoRenewPlan',
      ($1.UpdateAutoRenewPlanRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateAutoRenewPlanResponse.fromBuffer(value));
  static final _$getAirtimeToCashRates = $grpc.ClientMethod<
          $1.GetAirtimeToCashRatesRequest, $1.GetAirtimeToCashRatesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashRates',
      ($1.GetAirtimeToCashRatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeToCashRatesResponse.fromBuffer(value));
  static final _$requestAirtimeToCashOTP = $grpc.ClientMethod<
          $1.RequestAirtimeToCashOTPRequest,
          $1.RequestAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/RequestAirtimeToCashOTP',
      ($1.RequestAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.RequestAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashOTP = $grpc.ClientMethod<
          $1.VerifyAirtimeToCashOTPRequest, $1.VerifyAirtimeToCashOTPResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashOTP',
      ($1.VerifyAirtimeToCashOTPRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.VerifyAirtimeToCashOTPResponse.fromBuffer(value));
  static final _$convertAirtimeToCash = $grpc.ClientMethod<
          $1.ConvertAirtimeToCashRequest, $1.ConvertAirtimeToCashResponse>(
      '/utilitypayments.UtilityPaymentsService/ConvertAirtimeToCash',
      ($1.ConvertAirtimeToCashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ConvertAirtimeToCashResponse.fromBuffer(value));
  static final _$getAirtimeToCashHistory = $grpc.ClientMethod<
          $1.GetAirtimeToCashHistoryRequest,
          $1.GetAirtimeToCashHistoryResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashHistory',
      ($1.GetAirtimeToCashHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeToCashHistoryResponse.fromBuffer(value));
  static final _$verifyAirtimeToCashService = $grpc.ClientMethod<
          $1.VerifyAirtimeToCashServiceRequest,
          $1.VerifyAirtimeToCashServiceResponse>(
      '/utilitypayments.UtilityPaymentsService/VerifyAirtimeToCashService',
      ($1.VerifyAirtimeToCashServiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.VerifyAirtimeToCashServiceResponse.fromBuffer(value));
  static final _$getAirtimeToCashProviderInfo = $grpc.ClientMethod<
          $1.GetAirtimeToCashProviderInfoRequest,
          $1.GetAirtimeToCashProviderInfoResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeToCashProviderInfo',
      ($1.GetAirtimeToCashProviderInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeToCashProviderInfoResponse.fromBuffer(value));
  static final _$checkAirtimeToCashQuota = $grpc.ClientMethod<
          $1.CheckAirtimeToCashQuotaRequest,
          $1.CheckAirtimeToCashQuotaResponse>(
      '/utilitypayments.UtilityPaymentsService/CheckAirtimeToCashQuota',
      ($1.CheckAirtimeToCashQuotaRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CheckAirtimeToCashQuotaResponse.fromBuffer(value));
  static final _$saveAirtimeBeneficiary = $grpc.ClientMethod<
          $1.SaveAirtimeBeneficiaryRequest, $1.SaveAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveAirtimeBeneficiary',
      ($1.SaveAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SaveAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$getAirtimeBeneficiaries = $grpc.ClientMethod<
          $1.GetAirtimeBeneficiariesRequest,
          $1.GetAirtimeBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeBeneficiaries',
      ($1.GetAirtimeBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeBeneficiariesResponse.fromBuffer(value));
  static final _$updateAirtimeBeneficiary = $grpc.ClientMethod<
          $1.UpdateAirtimeBeneficiaryRequest,
          $1.UpdateAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeBeneficiary',
      ($1.UpdateAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$deleteAirtimeBeneficiary = $grpc.ClientMethod<
          $1.DeleteAirtimeBeneficiaryRequest,
          $1.DeleteAirtimeBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeBeneficiary',
      ($1.DeleteAirtimeBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteAirtimeBeneficiaryResponse.fromBuffer(value));
  static final _$createAirtimeAutoRecharge = $grpc.ClientMethod<
          $1.CreateAirtimeAutoRechargeRequest,
          $1.CreateAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateAirtimeAutoRecharge',
      ($1.CreateAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$getAirtimeAutoRecharges = $grpc.ClientMethod<
          $1.GetAirtimeAutoRechargesRequest,
          $1.GetAirtimeAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeAutoRecharges',
      ($1.GetAirtimeAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeAutoRechargesResponse.fromBuffer(value));
  static final _$updateAirtimeAutoRecharge = $grpc.ClientMethod<
          $1.UpdateAirtimeAutoRechargeRequest,
          $1.UpdateAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeAutoRecharge',
      ($1.UpdateAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$deleteAirtimeAutoRecharge = $grpc.ClientMethod<
          $1.DeleteAirtimeAutoRechargeRequest,
          $1.DeleteAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeAutoRecharge',
      ($1.DeleteAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$pauseAirtimeAutoRecharge = $grpc.ClientMethod<
          $1.PauseAirtimeAutoRechargeRequest,
          $1.PauseAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseAirtimeAutoRecharge',
      ($1.PauseAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PauseAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$resumeAirtimeAutoRecharge = $grpc.ClientMethod<
          $1.ResumeAirtimeAutoRechargeRequest,
          $1.ResumeAirtimeAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeAirtimeAutoRecharge',
      ($1.ResumeAirtimeAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ResumeAirtimeAutoRechargeResponse.fromBuffer(value));
  static final _$createAirtimeReminder = $grpc.ClientMethod<
          $1.CreateAirtimeReminderRequest, $1.CreateAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateAirtimeReminder',
      ($1.CreateAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateAirtimeReminderResponse.fromBuffer(value));
  static final _$getAirtimeReminders = $grpc.ClientMethod<
          $1.GetAirtimeRemindersRequest, $1.GetAirtimeRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimeReminders',
      ($1.GetAirtimeRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimeRemindersResponse.fromBuffer(value));
  static final _$updateAirtimeReminder = $grpc.ClientMethod<
          $1.UpdateAirtimeReminderRequest, $1.UpdateAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAirtimeReminder',
      ($1.UpdateAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateAirtimeReminderResponse.fromBuffer(value));
  static final _$deleteAirtimeReminder = $grpc.ClientMethod<
          $1.DeleteAirtimeReminderRequest, $1.DeleteAirtimeReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteAirtimeReminder',
      ($1.DeleteAirtimeReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteAirtimeReminderResponse.fromBuffer(value));
  static final _$markAirtimeReminderComplete = $grpc.ClientMethod<
          $1.MarkAirtimeReminderCompleteRequest,
          $1.MarkAirtimeReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkAirtimeReminderComplete',
      ($1.MarkAirtimeReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MarkAirtimeReminderCompleteResponse.fromBuffer(value));
  static final _$getAirtimePaymentReceipt = $grpc.ClientMethod<
          $1.GetAirtimePaymentReceiptRequest,
          $1.GetAirtimePaymentReceiptResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAirtimePaymentReceipt',
      ($1.GetAirtimePaymentReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAirtimePaymentReceiptResponse.fromBuffer(value));
  static final _$saveDataBeneficiary = $grpc.ClientMethod<
          $1.SaveDataBeneficiaryRequest, $1.SaveDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveDataBeneficiary',
      ($1.SaveDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SaveDataBeneficiaryResponse.fromBuffer(value));
  static final _$getDataBeneficiaries = $grpc.ClientMethod<
          $1.GetDataBeneficiariesRequest, $1.GetDataBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataBeneficiaries',
      ($1.GetDataBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetDataBeneficiariesResponse.fromBuffer(value));
  static final _$updateDataBeneficiary = $grpc.ClientMethod<
          $1.UpdateDataBeneficiaryRequest, $1.UpdateDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataBeneficiary',
      ($1.UpdateDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateDataBeneficiaryResponse.fromBuffer(value));
  static final _$deleteDataBeneficiary = $grpc.ClientMethod<
          $1.DeleteDataBeneficiaryRequest, $1.DeleteDataBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataBeneficiary',
      ($1.DeleteDataBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteDataBeneficiaryResponse.fromBuffer(value));
  static final _$createDataAutoRecharge = $grpc.ClientMethod<
          $1.CreateDataAutoRechargeRequest, $1.CreateDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateDataAutoRecharge',
      ($1.CreateDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateDataAutoRechargeResponse.fromBuffer(value));
  static final _$getDataAutoRecharges = $grpc.ClientMethod<
          $1.GetDataAutoRechargesRequest, $1.GetDataAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataAutoRecharges',
      ($1.GetDataAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetDataAutoRechargesResponse.fromBuffer(value));
  static final _$updateDataAutoRecharge = $grpc.ClientMethod<
          $1.UpdateDataAutoRechargeRequest, $1.UpdateDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataAutoRecharge',
      ($1.UpdateDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateDataAutoRechargeResponse.fromBuffer(value));
  static final _$deleteDataAutoRecharge = $grpc.ClientMethod<
          $1.DeleteDataAutoRechargeRequest, $1.DeleteDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataAutoRecharge',
      ($1.DeleteDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteDataAutoRechargeResponse.fromBuffer(value));
  static final _$pauseDataAutoRecharge = $grpc.ClientMethod<
          $1.PauseDataAutoRechargeRequest, $1.PauseDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseDataAutoRecharge',
      ($1.PauseDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PauseDataAutoRechargeResponse.fromBuffer(value));
  static final _$resumeDataAutoRecharge = $grpc.ClientMethod<
          $1.ResumeDataAutoRechargeRequest, $1.ResumeDataAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeDataAutoRecharge',
      ($1.ResumeDataAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ResumeDataAutoRechargeResponse.fromBuffer(value));
  static final _$createDataReminder = $grpc.ClientMethod<
          $1.CreateDataReminderRequest, $1.CreateDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateDataReminder',
      ($1.CreateDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateDataReminderResponse.fromBuffer(value));
  static final _$getDataReminders = $grpc.ClientMethod<
          $1.GetDataRemindersRequest, $1.GetDataRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetDataReminders',
      ($1.GetDataRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetDataRemindersResponse.fromBuffer(value));
  static final _$updateDataReminder = $grpc.ClientMethod<
          $1.UpdateDataReminderRequest, $1.UpdateDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateDataReminder',
      ($1.UpdateDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateDataReminderResponse.fromBuffer(value));
  static final _$deleteDataReminder = $grpc.ClientMethod<
          $1.DeleteDataReminderRequest, $1.DeleteDataReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteDataReminder',
      ($1.DeleteDataReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteDataReminderResponse.fromBuffer(value));
  static final _$markDataReminderComplete = $grpc.ClientMethod<
          $1.MarkDataReminderCompleteRequest,
          $1.MarkDataReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkDataReminderComplete',
      ($1.MarkDataReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MarkDataReminderCompleteResponse.fromBuffer(value));
  static final _$saveCableTVBeneficiary = $grpc.ClientMethod<
          $1.SaveCableTVBeneficiaryRequest, $1.SaveCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveCableTVBeneficiary',
      ($1.SaveCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SaveCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$getCableTVBeneficiaries = $grpc.ClientMethod<
          $1.GetCableTVBeneficiariesRequest,
          $1.GetCableTVBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVBeneficiaries',
      ($1.GetCableTVBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCableTVBeneficiariesResponse.fromBuffer(value));
  static final _$updateCableTVBeneficiary = $grpc.ClientMethod<
          $1.UpdateCableTVBeneficiaryRequest,
          $1.UpdateCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVBeneficiary',
      ($1.UpdateCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$deleteCableTVBeneficiary = $grpc.ClientMethod<
          $1.DeleteCableTVBeneficiaryRequest,
          $1.DeleteCableTVBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVBeneficiary',
      ($1.DeleteCableTVBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteCableTVBeneficiaryResponse.fromBuffer(value));
  static final _$createCableTVAutoRecharge = $grpc.ClientMethod<
          $1.CreateCableTVAutoRechargeRequest,
          $1.CreateCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateCableTVAutoRecharge',
      ($1.CreateCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$getCableTVAutoRecharges = $grpc.ClientMethod<
          $1.GetCableTVAutoRechargesRequest,
          $1.GetCableTVAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVAutoRecharges',
      ($1.GetCableTVAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCableTVAutoRechargesResponse.fromBuffer(value));
  static final _$updateCableTVAutoRecharge = $grpc.ClientMethod<
          $1.UpdateCableTVAutoRechargeRequest,
          $1.UpdateCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVAutoRecharge',
      ($1.UpdateCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$deleteCableTVAutoRecharge = $grpc.ClientMethod<
          $1.DeleteCableTVAutoRechargeRequest,
          $1.DeleteCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVAutoRecharge',
      ($1.DeleteCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$pauseCableTVAutoRecharge = $grpc.ClientMethod<
          $1.PauseCableTVAutoRechargeRequest,
          $1.PauseCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseCableTVAutoRecharge',
      ($1.PauseCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PauseCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$resumeCableTVAutoRecharge = $grpc.ClientMethod<
          $1.ResumeCableTVAutoRechargeRequest,
          $1.ResumeCableTVAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeCableTVAutoRecharge',
      ($1.ResumeCableTVAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ResumeCableTVAutoRechargeResponse.fromBuffer(value));
  static final _$createCableTVReminder = $grpc.ClientMethod<
          $1.CreateCableTVReminderRequest, $1.CreateCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateCableTVReminder',
      ($1.CreateCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateCableTVReminderResponse.fromBuffer(value));
  static final _$getCableTVReminders = $grpc.ClientMethod<
          $1.GetCableTVRemindersRequest, $1.GetCableTVRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetCableTVReminders',
      ($1.GetCableTVRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetCableTVRemindersResponse.fromBuffer(value));
  static final _$updateCableTVReminder = $grpc.ClientMethod<
          $1.UpdateCableTVReminderRequest, $1.UpdateCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateCableTVReminder',
      ($1.UpdateCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateCableTVReminderResponse.fromBuffer(value));
  static final _$deleteCableTVReminder = $grpc.ClientMethod<
          $1.DeleteCableTVReminderRequest, $1.DeleteCableTVReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteCableTVReminder',
      ($1.DeleteCableTVReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteCableTVReminderResponse.fromBuffer(value));
  static final _$markCableTVReminderComplete = $grpc.ClientMethod<
          $1.MarkCableTVReminderCompleteRequest,
          $1.MarkCableTVReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkCableTVReminderComplete',
      ($1.MarkCableTVReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MarkCableTVReminderCompleteResponse.fromBuffer(value));
  static final _$getWaterProviders = $grpc.ClientMethod<
          $1.GetWaterProvidersRequest, $1.GetWaterProvidersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterProviders',
      ($1.GetWaterProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetWaterProvidersResponse.fromBuffer(value));
  static final _$saveWaterBeneficiary = $grpc.ClientMethod<
          $1.SaveWaterBeneficiaryRequest, $1.SaveWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveWaterBeneficiary',
      ($1.SaveWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SaveWaterBeneficiaryResponse.fromBuffer(value));
  static final _$getWaterBeneficiaries = $grpc.ClientMethod<
          $1.GetWaterBeneficiariesRequest, $1.GetWaterBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterBeneficiaries',
      ($1.GetWaterBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetWaterBeneficiariesResponse.fromBuffer(value));
  static final _$updateWaterBeneficiary = $grpc.ClientMethod<
          $1.UpdateWaterBeneficiaryRequest, $1.UpdateWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterBeneficiary',
      ($1.UpdateWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateWaterBeneficiaryResponse.fromBuffer(value));
  static final _$deleteWaterBeneficiary = $grpc.ClientMethod<
          $1.DeleteWaterBeneficiaryRequest, $1.DeleteWaterBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterBeneficiary',
      ($1.DeleteWaterBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteWaterBeneficiaryResponse.fromBuffer(value));
  static final _$createWaterAutoRecharge = $grpc.ClientMethod<
          $1.CreateWaterAutoRechargeRequest,
          $1.CreateWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateWaterAutoRecharge',
      ($1.CreateWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateWaterAutoRechargeResponse.fromBuffer(value));
  static final _$getWaterAutoRecharges = $grpc.ClientMethod<
          $1.GetWaterAutoRechargesRequest, $1.GetWaterAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterAutoRecharges',
      ($1.GetWaterAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetWaterAutoRechargesResponse.fromBuffer(value));
  static final _$updateWaterAutoRecharge = $grpc.ClientMethod<
          $1.UpdateWaterAutoRechargeRequest,
          $1.UpdateWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterAutoRecharge',
      ($1.UpdateWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateWaterAutoRechargeResponse.fromBuffer(value));
  static final _$deleteWaterAutoRecharge = $grpc.ClientMethod<
          $1.DeleteWaterAutoRechargeRequest,
          $1.DeleteWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterAutoRecharge',
      ($1.DeleteWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteWaterAutoRechargeResponse.fromBuffer(value));
  static final _$pauseWaterAutoRecharge = $grpc.ClientMethod<
          $1.PauseWaterAutoRechargeRequest, $1.PauseWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseWaterAutoRecharge',
      ($1.PauseWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PauseWaterAutoRechargeResponse.fromBuffer(value));
  static final _$resumeWaterAutoRecharge = $grpc.ClientMethod<
          $1.ResumeWaterAutoRechargeRequest,
          $1.ResumeWaterAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeWaterAutoRecharge',
      ($1.ResumeWaterAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ResumeWaterAutoRechargeResponse.fromBuffer(value));
  static final _$createWaterReminder = $grpc.ClientMethod<
          $1.CreateWaterReminderRequest, $1.CreateWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateWaterReminder',
      ($1.CreateWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateWaterReminderResponse.fromBuffer(value));
  static final _$getWaterReminders = $grpc.ClientMethod<
          $1.GetWaterRemindersRequest, $1.GetWaterRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetWaterReminders',
      ($1.GetWaterRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetWaterRemindersResponse.fromBuffer(value));
  static final _$updateWaterReminder = $grpc.ClientMethod<
          $1.UpdateWaterReminderRequest, $1.UpdateWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateWaterReminder',
      ($1.UpdateWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateWaterReminderResponse.fromBuffer(value));
  static final _$deleteWaterReminder = $grpc.ClientMethod<
          $1.DeleteWaterReminderRequest, $1.DeleteWaterReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteWaterReminder',
      ($1.DeleteWaterReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteWaterReminderResponse.fromBuffer(value));
  static final _$markWaterReminderComplete = $grpc.ClientMethod<
          $1.MarkWaterReminderCompleteRequest,
          $1.MarkWaterReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkWaterReminderComplete',
      ($1.MarkWaterReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MarkWaterReminderCompleteResponse.fromBuffer(value));
  static final _$getAsyncPaymentConfig = $grpc.ClientMethod<
          $1.GetAsyncPaymentConfigRequest, $1.GetAsyncPaymentConfigResponse>(
      '/utilitypayments.UtilityPaymentsService/GetAsyncPaymentConfig',
      ($1.GetAsyncPaymentConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetAsyncPaymentConfigResponse.fromBuffer(value));
  static final _$updateAsyncPaymentConfig = $grpc.ClientMethod<
          $1.UpdateAsyncPaymentConfigRequest,
          $1.UpdateAsyncPaymentConfigResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateAsyncPaymentConfig',
      ($1.UpdateAsyncPaymentConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateAsyncPaymentConfigResponse.fromBuffer(value));
  static final _$getIntlAirtimeCountries = $grpc.ClientMethod<
          $1.GetIntlAirtimeCountriesRequest,
          $1.GetIntlAirtimeCountriesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlAirtimeCountries',
      ($1.GetIntlAirtimeCountriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetIntlAirtimeCountriesResponse.fromBuffer(value));
  static final _$getIntlAirtimeOperators = $grpc.ClientMethod<
          $1.GetIntlAirtimeOperatorsRequest,
          $1.GetIntlAirtimeOperatorsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlAirtimeOperators',
      ($1.GetIntlAirtimeOperatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetIntlAirtimeOperatorsResponse.fromBuffer(value));
  static final _$autoDetectIntlOperator = $grpc.ClientMethod<
          $1.AutoDetectIntlOperatorRequest, $1.AutoDetectIntlOperatorResponse>(
      '/utilitypayments.UtilityPaymentsService/AutoDetectIntlOperator',
      ($1.AutoDetectIntlOperatorRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.AutoDetectIntlOperatorResponse.fromBuffer(value));
  static final _$buyIntlAirtime =
      $grpc.ClientMethod<$1.BuyIntlAirtimeRequest, $1.BuyIntlAirtimeResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyIntlAirtime',
          ($1.BuyIntlAirtimeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.BuyIntlAirtimeResponse.fromBuffer(value));
  static final _$getIntlDataOperators = $grpc.ClientMethod<
          $1.GetIntlDataOperatorsRequest, $1.GetIntlDataOperatorsResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlDataOperators',
      ($1.GetIntlDataOperatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetIntlDataOperatorsResponse.fromBuffer(value));
  static final _$getIntlDataBundles = $grpc.ClientMethod<
          $1.GetIntlDataBundlesRequest, $1.GetIntlDataBundlesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetIntlDataBundles',
      ($1.GetIntlDataBundlesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetIntlDataBundlesResponse.fromBuffer(value));
  static final _$buyIntlData =
      $grpc.ClientMethod<$1.BuyIntlDataRequest, $1.BuyIntlDataResponse>(
          '/utilitypayments.UtilityPaymentsService/BuyIntlData',
          ($1.BuyIntlDataRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $1.BuyIntlDataResponse.fromBuffer(value));
  static final _$saveInternetBeneficiary = $grpc.ClientMethod<
          $1.SaveInternetBeneficiaryRequest,
          $1.SaveInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/SaveInternetBeneficiary',
      ($1.SaveInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.SaveInternetBeneficiaryResponse.fromBuffer(value));
  static final _$getInternetBeneficiaries = $grpc.ClientMethod<
          $1.GetInternetBeneficiariesRequest,
          $1.GetInternetBeneficiariesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetBeneficiaries',
      ($1.GetInternetBeneficiariesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInternetBeneficiariesResponse.fromBuffer(value));
  static final _$updateInternetBeneficiary = $grpc.ClientMethod<
          $1.UpdateInternetBeneficiaryRequest,
          $1.UpdateInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetBeneficiary',
      ($1.UpdateInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateInternetBeneficiaryResponse.fromBuffer(value));
  static final _$deleteInternetBeneficiary = $grpc.ClientMethod<
          $1.DeleteInternetBeneficiaryRequest,
          $1.DeleteInternetBeneficiaryResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetBeneficiary',
      ($1.DeleteInternetBeneficiaryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteInternetBeneficiaryResponse.fromBuffer(value));
  static final _$createInternetAutoRecharge = $grpc.ClientMethod<
          $1.CreateInternetAutoRechargeRequest,
          $1.CreateInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateInternetAutoRecharge',
      ($1.CreateInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateInternetAutoRechargeResponse.fromBuffer(value));
  static final _$getInternetAutoRecharges = $grpc.ClientMethod<
          $1.GetInternetAutoRechargesRequest,
          $1.GetInternetAutoRechargesResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetAutoRecharges',
      ($1.GetInternetAutoRechargesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInternetAutoRechargesResponse.fromBuffer(value));
  static final _$updateInternetAutoRecharge = $grpc.ClientMethod<
          $1.UpdateInternetAutoRechargeRequest,
          $1.UpdateInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetAutoRecharge',
      ($1.UpdateInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateInternetAutoRechargeResponse.fromBuffer(value));
  static final _$deleteInternetAutoRecharge = $grpc.ClientMethod<
          $1.DeleteInternetAutoRechargeRequest,
          $1.DeleteInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetAutoRecharge',
      ($1.DeleteInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteInternetAutoRechargeResponse.fromBuffer(value));
  static final _$pauseInternetAutoRecharge = $grpc.ClientMethod<
          $1.PauseInternetAutoRechargeRequest,
          $1.PauseInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/PauseInternetAutoRecharge',
      ($1.PauseInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.PauseInternetAutoRechargeResponse.fromBuffer(value));
  static final _$resumeInternetAutoRecharge = $grpc.ClientMethod<
          $1.ResumeInternetAutoRechargeRequest,
          $1.ResumeInternetAutoRechargeResponse>(
      '/utilitypayments.UtilityPaymentsService/ResumeInternetAutoRecharge',
      ($1.ResumeInternetAutoRechargeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.ResumeInternetAutoRechargeResponse.fromBuffer(value));
  static final _$createInternetReminder = $grpc.ClientMethod<
          $1.CreateInternetReminderRequest, $1.CreateInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/CreateInternetReminder',
      ($1.CreateInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateInternetReminderResponse.fromBuffer(value));
  static final _$getInternetReminders = $grpc.ClientMethod<
          $1.GetInternetRemindersRequest, $1.GetInternetRemindersResponse>(
      '/utilitypayments.UtilityPaymentsService/GetInternetReminders',
      ($1.GetInternetRemindersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.GetInternetRemindersResponse.fromBuffer(value));
  static final _$updateInternetReminder = $grpc.ClientMethod<
          $1.UpdateInternetReminderRequest, $1.UpdateInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/UpdateInternetReminder',
      ($1.UpdateInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.UpdateInternetReminderResponse.fromBuffer(value));
  static final _$deleteInternetReminder = $grpc.ClientMethod<
          $1.DeleteInternetReminderRequest, $1.DeleteInternetReminderResponse>(
      '/utilitypayments.UtilityPaymentsService/DeleteInternetReminder',
      ($1.DeleteInternetReminderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.DeleteInternetReminderResponse.fromBuffer(value));
  static final _$markInternetReminderComplete = $grpc.ClientMethod<
          $1.MarkInternetReminderCompleteRequest,
          $1.MarkInternetReminderCompleteResponse>(
      '/utilitypayments.UtilityPaymentsService/MarkInternetReminderComplete',
      ($1.MarkInternetReminderCompleteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.MarkInternetReminderCompleteResponse.fromBuffer(value));

  UtilityPaymentsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.PayElectricityBillResponse> payElectricityBill(
      $1.PayElectricityBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payElectricityBill, request, options: options);
  }

  $grpc.ResponseFuture<$1.PayWaterBillResponse> payWaterBill(
      $1.PayWaterBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payWaterBill, request, options: options);
  }

  $grpc.ResponseFuture<$1.PayInternetBillResponse> payInternetBill(
      $1.PayInternetBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInternetBill, request, options: options);
  }

  $grpc.ResponseFuture<$1.BuyAirtimeResponse> buyAirtime(
      $1.BuyAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$1.BuyDataResponse> buyData($1.BuyDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyData, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetDataPlansResponse> getDataPlans(
      $1.GetDataPlansRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataPlans, request, options: options);
  }

  $grpc.ResponseFuture<$1.BarcodePayResponse> barcodePay(
      $1.BarcodePayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$barcodePay, request, options: options);
  }

  $grpc.ResponseFuture<$1.ScanToPayResponse> scanToPay(
      $1.ScanToPayRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$scanToPay, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $1.GetBillPaymentHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillPaymentHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetBillProvidersResponse> getBillProviders(
      $1.GetBillProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBillProviders, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeProvidersResponse> getAirtimeProviders(
      $1.GetAirtimeProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeProviders, request, options: options);
  }

  $grpc.ResponseFuture<$1.VerifyBillResponse> verifyBill(
      $1.VerifyBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBill, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateSmartCardResponse> validateSmartCard(
      $1.ValidateSmartCardRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateSmartCard, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetTVPackagesResponse> getTVPackages(
      $1.GetTVPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTVPackages, request, options: options);
  }

  $grpc.ResponseFuture<$1.PayCableTVBillResponse> payCableTVBill(
      $1.PayCableTVBillRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payCableTVBill, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCableTVProvidersResponse> getCableTVProviders(
      $1.GetCableTVProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVProviders, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetInternetProvidersResponse> getInternetProviders(
      $1.GetInternetProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetProviders, request, options: options);
  }

  $grpc.ResponseFuture<$1.ValidateInternetAccountResponse>
      validateInternetAccount($1.ValidateInternetAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$validateInternetAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInternetPackagesResponse> getInternetPackages(
      $1.GetInternetPackagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetPackages, request, options: options);
  }

  $grpc.ResponseFuture<$1.PurchaseEducationPinResponse> purchaseEducationPin(
      $1.PurchaseEducationPinRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$purchaseEducationPin, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetEducationProvidersResponse> getEducationProviders(
      $1.GetEducationProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationProviders, request, options: options);
  }

  $grpc.ResponseFuture<$1.SaveEducationBeneficiaryResponse>
      saveEducationBeneficiary($1.SaveEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries($1.GetEducationBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary($1.UpdateEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary($1.DeleteEducationBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEducationBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateEducationReminderResponse>
      createEducationReminder($1.CreateEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetEducationRemindersResponse> getEducationReminders(
      $1.GetEducationRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getEducationReminders, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateEducationReminderResponse>
      updateEducationReminder($1.UpdateEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteEducationReminderResponse>
      deleteEducationReminder($1.DeleteEducationReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteEducationReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete(
          $1.MarkEducationReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markEducationReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetActiveSubscriptionsResponse>
      getActiveSubscriptions($1.GetActiveSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getActiveSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetSubscriptionSummaryResponse>
      getSubscriptionSummary($1.GetSubscriptionSummaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSummary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetSubscriptionSpendingResponse>
      getSubscriptionSpending($1.GetSubscriptionSpendingRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSubscriptionSpending, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.EnableAutoRenewResponse> enableAutoRenew(
      $1.EnableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$1.DisableAutoRenewResponse> disableAutoRenew(
      $1.DisableAutoRenewRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableAutoRenew, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions($1.GetAutoRenewSubscriptionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoRenewSubscriptions, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $1.UpdateAutoRenewPlanRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoRenewPlan, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $1.GetAirtimeToCashRatesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashRates, request, options: options);
  }

  $grpc.ResponseFuture<$1.RequestAirtimeToCashOTPResponse>
      requestAirtimeToCashOTP($1.RequestAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.VerifyAirtimeToCashOTPResponse>
      verifyAirtimeToCashOTP($1.VerifyAirtimeToCashOTPRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashOTP, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $1.ConvertAirtimeToCashRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$convertAirtimeToCash, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeToCashHistoryResponse>
      getAirtimeToCashHistory($1.GetAirtimeToCashHistoryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService($1.VerifyAirtimeToCashServiceRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyAirtimeToCashService, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo(
          $1.GetAirtimeToCashProviderInfoRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeToCashProviderInfo, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CheckAirtimeToCashQuotaResponse>
      checkAirtimeToCashQuota($1.CheckAirtimeToCashQuotaRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkAirtimeToCashQuota, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.SaveAirtimeBeneficiaryResponse>
      saveAirtimeBeneficiary($1.SaveAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeBeneficiariesResponse>
      getAirtimeBeneficiaries($1.GetAirtimeBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateAirtimeBeneficiaryResponse>
      updateAirtimeBeneficiary($1.UpdateAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteAirtimeBeneficiaryResponse>
      deleteAirtimeBeneficiary($1.DeleteAirtimeBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge($1.CreateAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeAutoRechargesResponse>
      getAirtimeAutoRecharges($1.GetAirtimeAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge($1.UpdateAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge($1.DeleteAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.PauseAirtimeAutoRechargeResponse>
      pauseAirtimeAutoRecharge($1.PauseAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge($1.ResumeAirtimeAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeAirtimeAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateAirtimeReminderResponse> createAirtimeReminder(
      $1.CreateAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimeRemindersResponse> getAirtimeReminders(
      $1.GetAirtimeRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimeReminders, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $1.UpdateAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $1.DeleteAirtimeReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAirtimeReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete($1.MarkAirtimeReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markAirtimeReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAirtimePaymentReceiptResponse>
      getAirtimePaymentReceipt($1.GetAirtimePaymentReceiptRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAirtimePaymentReceipt, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $1.SaveDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $1.GetDataBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $1.UpdateDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $1.DeleteDataBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$1.CreateDataAutoRechargeResponse>
      createDataAutoRecharge($1.CreateDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $1.GetDataAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateDataAutoRechargeResponse>
      updateDataAutoRecharge($1.UpdateDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteDataAutoRechargeResponse>
      deleteDataAutoRecharge($1.DeleteDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $1.PauseDataAutoRechargeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseDataAutoRecharge, request, options: options);
  }

  $grpc.ResponseFuture<$1.ResumeDataAutoRechargeResponse>
      resumeDataAutoRecharge($1.ResumeDataAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeDataAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateDataReminderResponse> createDataReminder(
      $1.CreateDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetDataRemindersResponse> getDataReminders(
      $1.GetDataRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDataReminders, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateDataReminderResponse> updateDataReminder(
      $1.UpdateDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteDataReminderResponse> deleteDataReminder(
      $1.DeleteDataReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteDataReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.MarkDataReminderCompleteResponse>
      markDataReminderComplete($1.MarkDataReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markDataReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.SaveCableTVBeneficiaryResponse>
      saveCableTVBeneficiary($1.SaveCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetCableTVBeneficiariesResponse>
      getCableTVBeneficiaries($1.GetCableTVBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateCableTVBeneficiaryResponse>
      updateCableTVBeneficiary($1.UpdateCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteCableTVBeneficiaryResponse>
      deleteCableTVBeneficiary($1.DeleteCableTVBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge($1.CreateCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetCableTVAutoRechargesResponse>
      getCableTVAutoRecharges($1.GetCableTVAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge($1.UpdateCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge($1.DeleteCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.PauseCableTVAutoRechargeResponse>
      pauseCableTVAutoRecharge($1.PauseCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge($1.ResumeCableTVAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeCableTVAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateCableTVReminderResponse> createCableTVReminder(
      $1.CreateCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetCableTVRemindersResponse> getCableTVReminders(
      $1.GetCableTVRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCableTVReminders, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateCableTVReminderResponse> updateCableTVReminder(
      $1.UpdateCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $1.DeleteCableTVReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteCableTVReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete($1.MarkCableTVReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markCableTVReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetWaterProvidersResponse> getWaterProviders(
      $1.GetWaterProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterProviders, request, options: options);
  }

  $grpc.ResponseFuture<$1.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $1.SaveWaterBeneficiaryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveWaterBeneficiary, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $1.GetWaterBeneficiariesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterBeneficiaries, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateWaterBeneficiaryResponse>
      updateWaterBeneficiary($1.UpdateWaterBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteWaterBeneficiaryResponse>
      deleteWaterBeneficiary($1.DeleteWaterBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateWaterAutoRechargeResponse>
      createWaterAutoRecharge($1.CreateWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $1.GetWaterAutoRechargesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterAutoRecharges, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateWaterAutoRechargeResponse>
      updateWaterAutoRecharge($1.UpdateWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteWaterAutoRechargeResponse>
      deleteWaterAutoRecharge($1.DeleteWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.PauseWaterAutoRechargeResponse>
      pauseWaterAutoRecharge($1.PauseWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ResumeWaterAutoRechargeResponse>
      resumeWaterAutoRecharge($1.ResumeWaterAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeWaterAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateWaterReminderResponse> createWaterReminder(
      $1.CreateWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetWaterRemindersResponse> getWaterReminders(
      $1.GetWaterRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWaterReminders, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateWaterReminderResponse> updateWaterReminder(
      $1.UpdateWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteWaterReminderResponse> deleteWaterReminder(
      $1.DeleteWaterReminderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWaterReminder, request, options: options);
  }

  $grpc.ResponseFuture<$1.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete($1.MarkWaterReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markWaterReminderComplete, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $1.GetAsyncPaymentConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAsyncPaymentConfig, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateAsyncPaymentConfigResponse>
      updateAsyncPaymentConfig($1.UpdateAsyncPaymentConfigRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAsyncPaymentConfig, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetIntlAirtimeCountriesResponse>
      getIntlAirtimeCountries($1.GetIntlAirtimeCountriesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlAirtimeCountries, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetIntlAirtimeOperatorsResponse>
      getIntlAirtimeOperators($1.GetIntlAirtimeOperatorsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlAirtimeOperators, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.AutoDetectIntlOperatorResponse>
      autoDetectIntlOperator($1.AutoDetectIntlOperatorRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$autoDetectIntlOperator, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.BuyIntlAirtimeResponse> buyIntlAirtime(
      $1.BuyIntlAirtimeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyIntlAirtime, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $1.GetIntlDataOperatorsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlDataOperators, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetIntlDataBundlesResponse> getIntlDataBundles(
      $1.GetIntlDataBundlesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIntlDataBundles, request, options: options);
  }

  $grpc.ResponseFuture<$1.BuyIntlDataResponse> buyIntlData(
      $1.BuyIntlDataRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buyIntlData, request, options: options);
  }

  $grpc.ResponseFuture<$1.SaveInternetBeneficiaryResponse>
      saveInternetBeneficiary($1.SaveInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$saveInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInternetBeneficiariesResponse>
      getInternetBeneficiaries($1.GetInternetBeneficiariesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetBeneficiaries, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary($1.UpdateInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary($1.DeleteInternetBeneficiaryRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetBeneficiary, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge($1.CreateInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInternetAutoRechargesResponse>
      getInternetAutoRecharges($1.GetInternetAutoRechargesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetAutoRecharges, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge($1.UpdateInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge($1.DeleteInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge($1.PauseInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge($1.ResumeInternetAutoRechargeRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resumeInternetAutoRecharge, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.CreateInternetReminderResponse>
      createInternetReminder($1.CreateInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.GetInternetRemindersResponse> getInternetReminders(
      $1.GetInternetRemindersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInternetReminders, request, options: options);
  }

  $grpc.ResponseFuture<$1.UpdateInternetReminderResponse>
      updateInternetReminder($1.UpdateInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.DeleteInternetReminderResponse>
      deleteInternetReminder($1.DeleteInternetReminderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteInternetReminder, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete(
          $1.MarkInternetReminderCompleteRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$markInternetReminderComplete, request,
        options: options);
  }
}

abstract class UtilityPaymentsServiceBase extends $grpc.Service {
  $core.String get $name => 'utilitypayments.UtilityPaymentsService';

  UtilityPaymentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.PayElectricityBillRequest,
            $1.PayElectricityBillResponse>(
        'PayElectricityBill',
        payElectricityBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PayElectricityBillRequest.fromBuffer(value),
        ($1.PayElectricityBillResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.PayWaterBillRequest, $1.PayWaterBillResponse>(
            'PayWaterBill',
            payWaterBill_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.PayWaterBillRequest.fromBuffer(value),
            ($1.PayWaterBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PayInternetBillRequest,
            $1.PayInternetBillResponse>(
        'PayInternetBill',
        payInternetBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PayInternetBillRequest.fromBuffer(value),
        ($1.PayInternetBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BuyAirtimeRequest, $1.BuyAirtimeResponse>(
        'BuyAirtime',
        buyAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BuyAirtimeRequest.fromBuffer(value),
        ($1.BuyAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BuyDataRequest, $1.BuyDataResponse>(
        'BuyData',
        buyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BuyDataRequest.fromBuffer(value),
        ($1.BuyDataResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetDataPlansRequest, $1.GetDataPlansResponse>(
            'GetDataPlans',
            getDataPlans_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetDataPlansRequest.fromBuffer(value),
            ($1.GetDataPlansResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BarcodePayRequest, $1.BarcodePayResponse>(
        'BarcodePay',
        barcodePay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BarcodePayRequest.fromBuffer(value),
        ($1.BarcodePayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ScanToPayRequest, $1.ScanToPayResponse>(
        'ScanToPay',
        scanToPay_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ScanToPayRequest.fromBuffer(value),
        ($1.ScanToPayResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetBillPaymentHistoryRequest,
            $1.GetBillPaymentHistoryResponse>(
        'GetBillPaymentHistory',
        getBillPaymentHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetBillPaymentHistoryRequest.fromBuffer(value),
        ($1.GetBillPaymentHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetBillProvidersRequest,
            $1.GetBillProvidersResponse>(
        'GetBillProviders',
        getBillProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetBillProvidersRequest.fromBuffer(value),
        ($1.GetBillProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeProvidersRequest,
            $1.GetAirtimeProvidersResponse>(
        'GetAirtimeProviders',
        getAirtimeProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeProvidersRequest.fromBuffer(value),
        ($1.GetAirtimeProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyBillRequest, $1.VerifyBillResponse>(
        'VerifyBill',
        verifyBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.VerifyBillRequest.fromBuffer(value),
        ($1.VerifyBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateSmartCardRequest,
            $1.ValidateSmartCardResponse>(
        'ValidateSmartCard',
        validateSmartCard_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ValidateSmartCardRequest.fromBuffer(value),
        ($1.ValidateSmartCardResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.GetTVPackagesRequest, $1.GetTVPackagesResponse>(
            'GetTVPackages',
            getTVPackages_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.GetTVPackagesRequest.fromBuffer(value),
            ($1.GetTVPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PayCableTVBillRequest,
            $1.PayCableTVBillResponse>(
        'PayCableTVBill',
        payCableTVBill_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PayCableTVBillRequest.fromBuffer(value),
        ($1.PayCableTVBillResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCableTVProvidersRequest,
            $1.GetCableTVProvidersResponse>(
        'GetCableTVProviders',
        getCableTVProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCableTVProvidersRequest.fromBuffer(value),
        ($1.GetCableTVProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInternetProvidersRequest,
            $1.GetInternetProvidersResponse>(
        'GetInternetProviders',
        getInternetProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInternetProvidersRequest.fromBuffer(value),
        ($1.GetInternetProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ValidateInternetAccountRequest,
            $1.ValidateInternetAccountResponse>(
        'ValidateInternetAccount',
        validateInternetAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ValidateInternetAccountRequest.fromBuffer(value),
        ($1.ValidateInternetAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInternetPackagesRequest,
            $1.GetInternetPackagesResponse>(
        'GetInternetPackages',
        getInternetPackages_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInternetPackagesRequest.fromBuffer(value),
        ($1.GetInternetPackagesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PurchaseEducationPinRequest,
            $1.PurchaseEducationPinResponse>(
        'PurchaseEducationPin',
        purchaseEducationPin_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PurchaseEducationPinRequest.fromBuffer(value),
        ($1.PurchaseEducationPinResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetEducationProvidersRequest,
            $1.GetEducationProvidersResponse>(
        'GetEducationProviders',
        getEducationProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetEducationProvidersRequest.fromBuffer(value),
        ($1.GetEducationProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SaveEducationBeneficiaryRequest,
            $1.SaveEducationBeneficiaryResponse>(
        'SaveEducationBeneficiary',
        saveEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SaveEducationBeneficiaryRequest.fromBuffer(value),
        ($1.SaveEducationBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetEducationBeneficiariesRequest,
            $1.GetEducationBeneficiariesResponse>(
        'GetEducationBeneficiaries',
        getEducationBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetEducationBeneficiariesRequest.fromBuffer(value),
        ($1.GetEducationBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateEducationBeneficiaryRequest,
            $1.UpdateEducationBeneficiaryResponse>(
        'UpdateEducationBeneficiary',
        updateEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateEducationBeneficiaryRequest.fromBuffer(value),
        ($1.UpdateEducationBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteEducationBeneficiaryRequest,
            $1.DeleteEducationBeneficiaryResponse>(
        'DeleteEducationBeneficiary',
        deleteEducationBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteEducationBeneficiaryRequest.fromBuffer(value),
        ($1.DeleteEducationBeneficiaryResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateEducationReminderRequest,
            $1.CreateEducationReminderResponse>(
        'CreateEducationReminder',
        createEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateEducationReminderRequest.fromBuffer(value),
        ($1.CreateEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetEducationRemindersRequest,
            $1.GetEducationRemindersResponse>(
        'GetEducationReminders',
        getEducationReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetEducationRemindersRequest.fromBuffer(value),
        ($1.GetEducationRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateEducationReminderRequest,
            $1.UpdateEducationReminderResponse>(
        'UpdateEducationReminder',
        updateEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateEducationReminderRequest.fromBuffer(value),
        ($1.UpdateEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteEducationReminderRequest,
            $1.DeleteEducationReminderResponse>(
        'DeleteEducationReminder',
        deleteEducationReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteEducationReminderRequest.fromBuffer(value),
        ($1.DeleteEducationReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MarkEducationReminderCompleteRequest,
            $1.MarkEducationReminderCompleteResponse>(
        'MarkEducationReminderComplete',
        markEducationReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MarkEducationReminderCompleteRequest.fromBuffer(value),
        ($1.MarkEducationReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetActiveSubscriptionsRequest,
            $1.GetActiveSubscriptionsResponse>(
        'GetActiveSubscriptions',
        getActiveSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetActiveSubscriptionsRequest.fromBuffer(value),
        ($1.GetActiveSubscriptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetSubscriptionSummaryRequest,
            $1.GetSubscriptionSummaryResponse>(
        'GetSubscriptionSummary',
        getSubscriptionSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetSubscriptionSummaryRequest.fromBuffer(value),
        ($1.GetSubscriptionSummaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetSubscriptionSpendingRequest,
            $1.GetSubscriptionSpendingResponse>(
        'GetSubscriptionSpending',
        getSubscriptionSpending_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetSubscriptionSpendingRequest.fromBuffer(value),
        ($1.GetSubscriptionSpendingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EnableAutoRenewRequest,
            $1.EnableAutoRenewResponse>(
        'EnableAutoRenew',
        enableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.EnableAutoRenewRequest.fromBuffer(value),
        ($1.EnableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DisableAutoRenewRequest,
            $1.DisableAutoRenewResponse>(
        'DisableAutoRenew',
        disableAutoRenew_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DisableAutoRenewRequest.fromBuffer(value),
        ($1.DisableAutoRenewResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAutoRenewSubscriptionsRequest,
            $1.GetAutoRenewSubscriptionsResponse>(
        'GetAutoRenewSubscriptions',
        getAutoRenewSubscriptions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAutoRenewSubscriptionsRequest.fromBuffer(value),
        ($1.GetAutoRenewSubscriptionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateAutoRenewPlanRequest,
            $1.UpdateAutoRenewPlanResponse>(
        'UpdateAutoRenewPlan',
        updateAutoRenewPlan_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateAutoRenewPlanRequest.fromBuffer(value),
        ($1.UpdateAutoRenewPlanResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeToCashRatesRequest,
            $1.GetAirtimeToCashRatesResponse>(
        'GetAirtimeToCashRates',
        getAirtimeToCashRates_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeToCashRatesRequest.fromBuffer(value),
        ($1.GetAirtimeToCashRatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RequestAirtimeToCashOTPRequest,
            $1.RequestAirtimeToCashOTPResponse>(
        'RequestAirtimeToCashOTP',
        requestAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.RequestAirtimeToCashOTPRequest.fromBuffer(value),
        ($1.RequestAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyAirtimeToCashOTPRequest,
            $1.VerifyAirtimeToCashOTPResponse>(
        'VerifyAirtimeToCashOTP',
        verifyAirtimeToCashOTP_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.VerifyAirtimeToCashOTPRequest.fromBuffer(value),
        ($1.VerifyAirtimeToCashOTPResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ConvertAirtimeToCashRequest,
            $1.ConvertAirtimeToCashResponse>(
        'ConvertAirtimeToCash',
        convertAirtimeToCash_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ConvertAirtimeToCashRequest.fromBuffer(value),
        ($1.ConvertAirtimeToCashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeToCashHistoryRequest,
            $1.GetAirtimeToCashHistoryResponse>(
        'GetAirtimeToCashHistory',
        getAirtimeToCashHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeToCashHistoryRequest.fromBuffer(value),
        ($1.GetAirtimeToCashHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyAirtimeToCashServiceRequest,
            $1.VerifyAirtimeToCashServiceResponse>(
        'VerifyAirtimeToCashService',
        verifyAirtimeToCashService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.VerifyAirtimeToCashServiceRequest.fromBuffer(value),
        ($1.VerifyAirtimeToCashServiceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeToCashProviderInfoRequest,
            $1.GetAirtimeToCashProviderInfoResponse>(
        'GetAirtimeToCashProviderInfo',
        getAirtimeToCashProviderInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeToCashProviderInfoRequest.fromBuffer(value),
        ($1.GetAirtimeToCashProviderInfoResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CheckAirtimeToCashQuotaRequest,
            $1.CheckAirtimeToCashQuotaResponse>(
        'CheckAirtimeToCashQuota',
        checkAirtimeToCashQuota_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CheckAirtimeToCashQuotaRequest.fromBuffer(value),
        ($1.CheckAirtimeToCashQuotaResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SaveAirtimeBeneficiaryRequest,
            $1.SaveAirtimeBeneficiaryResponse>(
        'SaveAirtimeBeneficiary',
        saveAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SaveAirtimeBeneficiaryRequest.fromBuffer(value),
        ($1.SaveAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeBeneficiariesRequest,
            $1.GetAirtimeBeneficiariesResponse>(
        'GetAirtimeBeneficiaries',
        getAirtimeBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeBeneficiariesRequest.fromBuffer(value),
        ($1.GetAirtimeBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateAirtimeBeneficiaryRequest,
            $1.UpdateAirtimeBeneficiaryResponse>(
        'UpdateAirtimeBeneficiary',
        updateAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateAirtimeBeneficiaryRequest.fromBuffer(value),
        ($1.UpdateAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteAirtimeBeneficiaryRequest,
            $1.DeleteAirtimeBeneficiaryResponse>(
        'DeleteAirtimeBeneficiary',
        deleteAirtimeBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteAirtimeBeneficiaryRequest.fromBuffer(value),
        ($1.DeleteAirtimeBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateAirtimeAutoRechargeRequest,
            $1.CreateAirtimeAutoRechargeResponse>(
        'CreateAirtimeAutoRecharge',
        createAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateAirtimeAutoRechargeRequest.fromBuffer(value),
        ($1.CreateAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeAutoRechargesRequest,
            $1.GetAirtimeAutoRechargesResponse>(
        'GetAirtimeAutoRecharges',
        getAirtimeAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeAutoRechargesRequest.fromBuffer(value),
        ($1.GetAirtimeAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateAirtimeAutoRechargeRequest,
            $1.UpdateAirtimeAutoRechargeResponse>(
        'UpdateAirtimeAutoRecharge',
        updateAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateAirtimeAutoRechargeRequest.fromBuffer(value),
        ($1.UpdateAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteAirtimeAutoRechargeRequest,
            $1.DeleteAirtimeAutoRechargeResponse>(
        'DeleteAirtimeAutoRecharge',
        deleteAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteAirtimeAutoRechargeRequest.fromBuffer(value),
        ($1.DeleteAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PauseAirtimeAutoRechargeRequest,
            $1.PauseAirtimeAutoRechargeResponse>(
        'PauseAirtimeAutoRecharge',
        pauseAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PauseAirtimeAutoRechargeRequest.fromBuffer(value),
        ($1.PauseAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResumeAirtimeAutoRechargeRequest,
            $1.ResumeAirtimeAutoRechargeResponse>(
        'ResumeAirtimeAutoRecharge',
        resumeAirtimeAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ResumeAirtimeAutoRechargeRequest.fromBuffer(value),
        ($1.ResumeAirtimeAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateAirtimeReminderRequest,
            $1.CreateAirtimeReminderResponse>(
        'CreateAirtimeReminder',
        createAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateAirtimeReminderRequest.fromBuffer(value),
        ($1.CreateAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimeRemindersRequest,
            $1.GetAirtimeRemindersResponse>(
        'GetAirtimeReminders',
        getAirtimeReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimeRemindersRequest.fromBuffer(value),
        ($1.GetAirtimeRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateAirtimeReminderRequest,
            $1.UpdateAirtimeReminderResponse>(
        'UpdateAirtimeReminder',
        updateAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateAirtimeReminderRequest.fromBuffer(value),
        ($1.UpdateAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteAirtimeReminderRequest,
            $1.DeleteAirtimeReminderResponse>(
        'DeleteAirtimeReminder',
        deleteAirtimeReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteAirtimeReminderRequest.fromBuffer(value),
        ($1.DeleteAirtimeReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MarkAirtimeReminderCompleteRequest,
            $1.MarkAirtimeReminderCompleteResponse>(
        'MarkAirtimeReminderComplete',
        markAirtimeReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MarkAirtimeReminderCompleteRequest.fromBuffer(value),
        ($1.MarkAirtimeReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAirtimePaymentReceiptRequest,
            $1.GetAirtimePaymentReceiptResponse>(
        'GetAirtimePaymentReceipt',
        getAirtimePaymentReceipt_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAirtimePaymentReceiptRequest.fromBuffer(value),
        ($1.GetAirtimePaymentReceiptResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SaveDataBeneficiaryRequest,
            $1.SaveDataBeneficiaryResponse>(
        'SaveDataBeneficiary',
        saveDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SaveDataBeneficiaryRequest.fromBuffer(value),
        ($1.SaveDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetDataBeneficiariesRequest,
            $1.GetDataBeneficiariesResponse>(
        'GetDataBeneficiaries',
        getDataBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetDataBeneficiariesRequest.fromBuffer(value),
        ($1.GetDataBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateDataBeneficiaryRequest,
            $1.UpdateDataBeneficiaryResponse>(
        'UpdateDataBeneficiary',
        updateDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateDataBeneficiaryRequest.fromBuffer(value),
        ($1.UpdateDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteDataBeneficiaryRequest,
            $1.DeleteDataBeneficiaryResponse>(
        'DeleteDataBeneficiary',
        deleteDataBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteDataBeneficiaryRequest.fromBuffer(value),
        ($1.DeleteDataBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateDataAutoRechargeRequest,
            $1.CreateDataAutoRechargeResponse>(
        'CreateDataAutoRecharge',
        createDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateDataAutoRechargeRequest.fromBuffer(value),
        ($1.CreateDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetDataAutoRechargesRequest,
            $1.GetDataAutoRechargesResponse>(
        'GetDataAutoRecharges',
        getDataAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetDataAutoRechargesRequest.fromBuffer(value),
        ($1.GetDataAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateDataAutoRechargeRequest,
            $1.UpdateDataAutoRechargeResponse>(
        'UpdateDataAutoRecharge',
        updateDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateDataAutoRechargeRequest.fromBuffer(value),
        ($1.UpdateDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteDataAutoRechargeRequest,
            $1.DeleteDataAutoRechargeResponse>(
        'DeleteDataAutoRecharge',
        deleteDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteDataAutoRechargeRequest.fromBuffer(value),
        ($1.DeleteDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PauseDataAutoRechargeRequest,
            $1.PauseDataAutoRechargeResponse>(
        'PauseDataAutoRecharge',
        pauseDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PauseDataAutoRechargeRequest.fromBuffer(value),
        ($1.PauseDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResumeDataAutoRechargeRequest,
            $1.ResumeDataAutoRechargeResponse>(
        'ResumeDataAutoRecharge',
        resumeDataAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ResumeDataAutoRechargeRequest.fromBuffer(value),
        ($1.ResumeDataAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateDataReminderRequest,
            $1.CreateDataReminderResponse>(
        'CreateDataReminder',
        createDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateDataReminderRequest.fromBuffer(value),
        ($1.CreateDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetDataRemindersRequest,
            $1.GetDataRemindersResponse>(
        'GetDataReminders',
        getDataReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetDataRemindersRequest.fromBuffer(value),
        ($1.GetDataRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateDataReminderRequest,
            $1.UpdateDataReminderResponse>(
        'UpdateDataReminder',
        updateDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateDataReminderRequest.fromBuffer(value),
        ($1.UpdateDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteDataReminderRequest,
            $1.DeleteDataReminderResponse>(
        'DeleteDataReminder',
        deleteDataReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteDataReminderRequest.fromBuffer(value),
        ($1.DeleteDataReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MarkDataReminderCompleteRequest,
            $1.MarkDataReminderCompleteResponse>(
        'MarkDataReminderComplete',
        markDataReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MarkDataReminderCompleteRequest.fromBuffer(value),
        ($1.MarkDataReminderCompleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SaveCableTVBeneficiaryRequest,
            $1.SaveCableTVBeneficiaryResponse>(
        'SaveCableTVBeneficiary',
        saveCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SaveCableTVBeneficiaryRequest.fromBuffer(value),
        ($1.SaveCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCableTVBeneficiariesRequest,
            $1.GetCableTVBeneficiariesResponse>(
        'GetCableTVBeneficiaries',
        getCableTVBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCableTVBeneficiariesRequest.fromBuffer(value),
        ($1.GetCableTVBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCableTVBeneficiaryRequest,
            $1.UpdateCableTVBeneficiaryResponse>(
        'UpdateCableTVBeneficiary',
        updateCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCableTVBeneficiaryRequest.fromBuffer(value),
        ($1.UpdateCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteCableTVBeneficiaryRequest,
            $1.DeleteCableTVBeneficiaryResponse>(
        'DeleteCableTVBeneficiary',
        deleteCableTVBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteCableTVBeneficiaryRequest.fromBuffer(value),
        ($1.DeleteCableTVBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateCableTVAutoRechargeRequest,
            $1.CreateCableTVAutoRechargeResponse>(
        'CreateCableTVAutoRecharge',
        createCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateCableTVAutoRechargeRequest.fromBuffer(value),
        ($1.CreateCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCableTVAutoRechargesRequest,
            $1.GetCableTVAutoRechargesResponse>(
        'GetCableTVAutoRecharges',
        getCableTVAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCableTVAutoRechargesRequest.fromBuffer(value),
        ($1.GetCableTVAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCableTVAutoRechargeRequest,
            $1.UpdateCableTVAutoRechargeResponse>(
        'UpdateCableTVAutoRecharge',
        updateCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCableTVAutoRechargeRequest.fromBuffer(value),
        ($1.UpdateCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteCableTVAutoRechargeRequest,
            $1.DeleteCableTVAutoRechargeResponse>(
        'DeleteCableTVAutoRecharge',
        deleteCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteCableTVAutoRechargeRequest.fromBuffer(value),
        ($1.DeleteCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PauseCableTVAutoRechargeRequest,
            $1.PauseCableTVAutoRechargeResponse>(
        'PauseCableTVAutoRecharge',
        pauseCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PauseCableTVAutoRechargeRequest.fromBuffer(value),
        ($1.PauseCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResumeCableTVAutoRechargeRequest,
            $1.ResumeCableTVAutoRechargeResponse>(
        'ResumeCableTVAutoRecharge',
        resumeCableTVAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ResumeCableTVAutoRechargeRequest.fromBuffer(value),
        ($1.ResumeCableTVAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateCableTVReminderRequest,
            $1.CreateCableTVReminderResponse>(
        'CreateCableTVReminder',
        createCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateCableTVReminderRequest.fromBuffer(value),
        ($1.CreateCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetCableTVRemindersRequest,
            $1.GetCableTVRemindersResponse>(
        'GetCableTVReminders',
        getCableTVReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetCableTVRemindersRequest.fromBuffer(value),
        ($1.GetCableTVRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCableTVReminderRequest,
            $1.UpdateCableTVReminderResponse>(
        'UpdateCableTVReminder',
        updateCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCableTVReminderRequest.fromBuffer(value),
        ($1.UpdateCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteCableTVReminderRequest,
            $1.DeleteCableTVReminderResponse>(
        'DeleteCableTVReminder',
        deleteCableTVReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteCableTVReminderRequest.fromBuffer(value),
        ($1.DeleteCableTVReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MarkCableTVReminderCompleteRequest,
            $1.MarkCableTVReminderCompleteResponse>(
        'MarkCableTVReminderComplete',
        markCableTVReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MarkCableTVReminderCompleteRequest.fromBuffer(value),
        ($1.MarkCableTVReminderCompleteResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetWaterProvidersRequest,
            $1.GetWaterProvidersResponse>(
        'GetWaterProviders',
        getWaterProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetWaterProvidersRequest.fromBuffer(value),
        ($1.GetWaterProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SaveWaterBeneficiaryRequest,
            $1.SaveWaterBeneficiaryResponse>(
        'SaveWaterBeneficiary',
        saveWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SaveWaterBeneficiaryRequest.fromBuffer(value),
        ($1.SaveWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetWaterBeneficiariesRequest,
            $1.GetWaterBeneficiariesResponse>(
        'GetWaterBeneficiaries',
        getWaterBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetWaterBeneficiariesRequest.fromBuffer(value),
        ($1.GetWaterBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateWaterBeneficiaryRequest,
            $1.UpdateWaterBeneficiaryResponse>(
        'UpdateWaterBeneficiary',
        updateWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateWaterBeneficiaryRequest.fromBuffer(value),
        ($1.UpdateWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteWaterBeneficiaryRequest,
            $1.DeleteWaterBeneficiaryResponse>(
        'DeleteWaterBeneficiary',
        deleteWaterBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteWaterBeneficiaryRequest.fromBuffer(value),
        ($1.DeleteWaterBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateWaterAutoRechargeRequest,
            $1.CreateWaterAutoRechargeResponse>(
        'CreateWaterAutoRecharge',
        createWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateWaterAutoRechargeRequest.fromBuffer(value),
        ($1.CreateWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetWaterAutoRechargesRequest,
            $1.GetWaterAutoRechargesResponse>(
        'GetWaterAutoRecharges',
        getWaterAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetWaterAutoRechargesRequest.fromBuffer(value),
        ($1.GetWaterAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateWaterAutoRechargeRequest,
            $1.UpdateWaterAutoRechargeResponse>(
        'UpdateWaterAutoRecharge',
        updateWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateWaterAutoRechargeRequest.fromBuffer(value),
        ($1.UpdateWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteWaterAutoRechargeRequest,
            $1.DeleteWaterAutoRechargeResponse>(
        'DeleteWaterAutoRecharge',
        deleteWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteWaterAutoRechargeRequest.fromBuffer(value),
        ($1.DeleteWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PauseWaterAutoRechargeRequest,
            $1.PauseWaterAutoRechargeResponse>(
        'PauseWaterAutoRecharge',
        pauseWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PauseWaterAutoRechargeRequest.fromBuffer(value),
        ($1.PauseWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResumeWaterAutoRechargeRequest,
            $1.ResumeWaterAutoRechargeResponse>(
        'ResumeWaterAutoRecharge',
        resumeWaterAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ResumeWaterAutoRechargeRequest.fromBuffer(value),
        ($1.ResumeWaterAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateWaterReminderRequest,
            $1.CreateWaterReminderResponse>(
        'CreateWaterReminder',
        createWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateWaterReminderRequest.fromBuffer(value),
        ($1.CreateWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetWaterRemindersRequest,
            $1.GetWaterRemindersResponse>(
        'GetWaterReminders',
        getWaterReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetWaterRemindersRequest.fromBuffer(value),
        ($1.GetWaterRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateWaterReminderRequest,
            $1.UpdateWaterReminderResponse>(
        'UpdateWaterReminder',
        updateWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateWaterReminderRequest.fromBuffer(value),
        ($1.UpdateWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteWaterReminderRequest,
            $1.DeleteWaterReminderResponse>(
        'DeleteWaterReminder',
        deleteWaterReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteWaterReminderRequest.fromBuffer(value),
        ($1.DeleteWaterReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MarkWaterReminderCompleteRequest,
            $1.MarkWaterReminderCompleteResponse>(
        'MarkWaterReminderComplete',
        markWaterReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MarkWaterReminderCompleteRequest.fromBuffer(value),
        ($1.MarkWaterReminderCompleteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetAsyncPaymentConfigRequest,
            $1.GetAsyncPaymentConfigResponse>(
        'GetAsyncPaymentConfig',
        getAsyncPaymentConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetAsyncPaymentConfigRequest.fromBuffer(value),
        ($1.GetAsyncPaymentConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateAsyncPaymentConfigRequest,
            $1.UpdateAsyncPaymentConfigResponse>(
        'UpdateAsyncPaymentConfig',
        updateAsyncPaymentConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateAsyncPaymentConfigRequest.fromBuffer(value),
        ($1.UpdateAsyncPaymentConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetIntlAirtimeCountriesRequest,
            $1.GetIntlAirtimeCountriesResponse>(
        'GetIntlAirtimeCountries',
        getIntlAirtimeCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetIntlAirtimeCountriesRequest.fromBuffer(value),
        ($1.GetIntlAirtimeCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetIntlAirtimeOperatorsRequest,
            $1.GetIntlAirtimeOperatorsResponse>(
        'GetIntlAirtimeOperators',
        getIntlAirtimeOperators_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetIntlAirtimeOperatorsRequest.fromBuffer(value),
        ($1.GetIntlAirtimeOperatorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AutoDetectIntlOperatorRequest,
            $1.AutoDetectIntlOperatorResponse>(
        'AutoDetectIntlOperator',
        autoDetectIntlOperator_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.AutoDetectIntlOperatorRequest.fromBuffer(value),
        ($1.AutoDetectIntlOperatorResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BuyIntlAirtimeRequest,
            $1.BuyIntlAirtimeResponse>(
        'BuyIntlAirtime',
        buyIntlAirtime_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.BuyIntlAirtimeRequest.fromBuffer(value),
        ($1.BuyIntlAirtimeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetIntlDataOperatorsRequest,
            $1.GetIntlDataOperatorsResponse>(
        'GetIntlDataOperators',
        getIntlDataOperators_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetIntlDataOperatorsRequest.fromBuffer(value),
        ($1.GetIntlDataOperatorsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetIntlDataBundlesRequest,
            $1.GetIntlDataBundlesResponse>(
        'GetIntlDataBundles',
        getIntlDataBundles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetIntlDataBundlesRequest.fromBuffer(value),
        ($1.GetIntlDataBundlesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.BuyIntlDataRequest, $1.BuyIntlDataResponse>(
            'BuyIntlData',
            buyIntlData_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $1.BuyIntlDataRequest.fromBuffer(value),
            ($1.BuyIntlDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SaveInternetBeneficiaryRequest,
            $1.SaveInternetBeneficiaryResponse>(
        'SaveInternetBeneficiary',
        saveInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.SaveInternetBeneficiaryRequest.fromBuffer(value),
        ($1.SaveInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInternetBeneficiariesRequest,
            $1.GetInternetBeneficiariesResponse>(
        'GetInternetBeneficiaries',
        getInternetBeneficiaries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInternetBeneficiariesRequest.fromBuffer(value),
        ($1.GetInternetBeneficiariesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateInternetBeneficiaryRequest,
            $1.UpdateInternetBeneficiaryResponse>(
        'UpdateInternetBeneficiary',
        updateInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateInternetBeneficiaryRequest.fromBuffer(value),
        ($1.UpdateInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteInternetBeneficiaryRequest,
            $1.DeleteInternetBeneficiaryResponse>(
        'DeleteInternetBeneficiary',
        deleteInternetBeneficiary_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteInternetBeneficiaryRequest.fromBuffer(value),
        ($1.DeleteInternetBeneficiaryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateInternetAutoRechargeRequest,
            $1.CreateInternetAutoRechargeResponse>(
        'CreateInternetAutoRecharge',
        createInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateInternetAutoRechargeRequest.fromBuffer(value),
        ($1.CreateInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInternetAutoRechargesRequest,
            $1.GetInternetAutoRechargesResponse>(
        'GetInternetAutoRecharges',
        getInternetAutoRecharges_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInternetAutoRechargesRequest.fromBuffer(value),
        ($1.GetInternetAutoRechargesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateInternetAutoRechargeRequest,
            $1.UpdateInternetAutoRechargeResponse>(
        'UpdateInternetAutoRecharge',
        updateInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateInternetAutoRechargeRequest.fromBuffer(value),
        ($1.UpdateInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteInternetAutoRechargeRequest,
            $1.DeleteInternetAutoRechargeResponse>(
        'DeleteInternetAutoRecharge',
        deleteInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteInternetAutoRechargeRequest.fromBuffer(value),
        ($1.DeleteInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PauseInternetAutoRechargeRequest,
            $1.PauseInternetAutoRechargeResponse>(
        'PauseInternetAutoRecharge',
        pauseInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.PauseInternetAutoRechargeRequest.fromBuffer(value),
        ($1.PauseInternetAutoRechargeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ResumeInternetAutoRechargeRequest,
            $1.ResumeInternetAutoRechargeResponse>(
        'ResumeInternetAutoRecharge',
        resumeInternetAutoRecharge_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.ResumeInternetAutoRechargeRequest.fromBuffer(value),
        ($1.ResumeInternetAutoRechargeResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateInternetReminderRequest,
            $1.CreateInternetReminderResponse>(
        'CreateInternetReminder',
        createInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateInternetReminderRequest.fromBuffer(value),
        ($1.CreateInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInternetRemindersRequest,
            $1.GetInternetRemindersResponse>(
        'GetInternetReminders',
        getInternetReminders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.GetInternetRemindersRequest.fromBuffer(value),
        ($1.GetInternetRemindersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateInternetReminderRequest,
            $1.UpdateInternetReminderResponse>(
        'UpdateInternetReminder',
        updateInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateInternetReminderRequest.fromBuffer(value),
        ($1.UpdateInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteInternetReminderRequest,
            $1.DeleteInternetReminderResponse>(
        'DeleteInternetReminder',
        deleteInternetReminder_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.DeleteInternetReminderRequest.fromBuffer(value),
        ($1.DeleteInternetReminderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.MarkInternetReminderCompleteRequest,
            $1.MarkInternetReminderCompleteResponse>(
        'MarkInternetReminderComplete',
        markInternetReminderComplete_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.MarkInternetReminderCompleteRequest.fromBuffer(value),
        ($1.MarkInternetReminderCompleteResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$1.PayElectricityBillResponse> payElectricityBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PayElectricityBillRequest> request) async {
    return payElectricityBill(call, await request);
  }

  $async.Future<$1.PayWaterBillResponse> payWaterBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PayWaterBillRequest> request) async {
    return payWaterBill(call, await request);
  }

  $async.Future<$1.PayInternetBillResponse> payInternetBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PayInternetBillRequest> request) async {
    return payInternetBill(call, await request);
  }

  $async.Future<$1.BuyAirtimeResponse> buyAirtime_Pre($grpc.ServiceCall call,
      $async.Future<$1.BuyAirtimeRequest> request) async {
    return buyAirtime(call, await request);
  }

  $async.Future<$1.BuyDataResponse> buyData_Pre(
      $grpc.ServiceCall call, $async.Future<$1.BuyDataRequest> request) async {
    return buyData(call, await request);
  }

  $async.Future<$1.GetDataPlansResponse> getDataPlans_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetDataPlansRequest> request) async {
    return getDataPlans(call, await request);
  }

  $async.Future<$1.BarcodePayResponse> barcodePay_Pre($grpc.ServiceCall call,
      $async.Future<$1.BarcodePayRequest> request) async {
    return barcodePay(call, await request);
  }

  $async.Future<$1.ScanToPayResponse> scanToPay_Pre($grpc.ServiceCall call,
      $async.Future<$1.ScanToPayRequest> request) async {
    return scanToPay(call, await request);
  }

  $async.Future<$1.GetBillPaymentHistoryResponse> getBillPaymentHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetBillPaymentHistoryRequest> request) async {
    return getBillPaymentHistory(call, await request);
  }

  $async.Future<$1.GetBillProvidersResponse> getBillProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetBillProvidersRequest> request) async {
    return getBillProviders(call, await request);
  }

  $async.Future<$1.GetAirtimeProvidersResponse> getAirtimeProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAirtimeProvidersRequest> request) async {
    return getAirtimeProviders(call, await request);
  }

  $async.Future<$1.VerifyBillResponse> verifyBill_Pre($grpc.ServiceCall call,
      $async.Future<$1.VerifyBillRequest> request) async {
    return verifyBill(call, await request);
  }

  $async.Future<$1.ValidateSmartCardResponse> validateSmartCard_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ValidateSmartCardRequest> request) async {
    return validateSmartCard(call, await request);
  }

  $async.Future<$1.GetTVPackagesResponse> getTVPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetTVPackagesRequest> request) async {
    return getTVPackages(call, await request);
  }

  $async.Future<$1.PayCableTVBillResponse> payCableTVBill_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PayCableTVBillRequest> request) async {
    return payCableTVBill(call, await request);
  }

  $async.Future<$1.GetCableTVProvidersResponse> getCableTVProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCableTVProvidersRequest> request) async {
    return getCableTVProviders(call, await request);
  }

  $async.Future<$1.GetInternetProvidersResponse> getInternetProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInternetProvidersRequest> request) async {
    return getInternetProviders(call, await request);
  }

  $async.Future<$1.ValidateInternetAccountResponse> validateInternetAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ValidateInternetAccountRequest> request) async {
    return validateInternetAccount(call, await request);
  }

  $async.Future<$1.GetInternetPackagesResponse> getInternetPackages_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInternetPackagesRequest> request) async {
    return getInternetPackages(call, await request);
  }

  $async.Future<$1.PurchaseEducationPinResponse> purchaseEducationPin_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PurchaseEducationPinRequest> request) async {
    return purchaseEducationPin(call, await request);
  }

  $async.Future<$1.GetEducationProvidersResponse> getEducationProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetEducationProvidersRequest> request) async {
    return getEducationProviders(call, await request);
  }

  $async.Future<$1.SaveEducationBeneficiaryResponse>
      saveEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.SaveEducationBeneficiaryRequest> request) async {
    return saveEducationBeneficiary(call, await request);
  }

  $async.Future<$1.GetEducationBeneficiariesResponse>
      getEducationBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetEducationBeneficiariesRequest> request) async {
    return getEducationBeneficiaries(call, await request);
  }

  $async.Future<$1.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateEducationBeneficiaryRequest> request) async {
    return updateEducationBeneficiary(call, await request);
  }

  $async.Future<$1.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteEducationBeneficiaryRequest> request) async {
    return deleteEducationBeneficiary(call, await request);
  }

  $async.Future<$1.CreateEducationReminderResponse> createEducationReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateEducationReminderRequest> request) async {
    return createEducationReminder(call, await request);
  }

  $async.Future<$1.GetEducationRemindersResponse> getEducationReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetEducationRemindersRequest> request) async {
    return getEducationReminders(call, await request);
  }

  $async.Future<$1.UpdateEducationReminderResponse> updateEducationReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateEducationReminderRequest> request) async {
    return updateEducationReminder(call, await request);
  }

  $async.Future<$1.DeleteEducationReminderResponse> deleteEducationReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteEducationReminderRequest> request) async {
    return deleteEducationReminder(call, await request);
  }

  $async.Future<$1.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete_Pre(
          $grpc.ServiceCall call,
          $async.Future<$1.MarkEducationReminderCompleteRequest>
              request) async {
    return markEducationReminderComplete(call, await request);
  }

  $async.Future<$1.GetActiveSubscriptionsResponse> getActiveSubscriptions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetActiveSubscriptionsRequest> request) async {
    return getActiveSubscriptions(call, await request);
  }

  $async.Future<$1.GetSubscriptionSummaryResponse> getSubscriptionSummary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetSubscriptionSummaryRequest> request) async {
    return getSubscriptionSummary(call, await request);
  }

  $async.Future<$1.GetSubscriptionSpendingResponse> getSubscriptionSpending_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetSubscriptionSpendingRequest> request) async {
    return getSubscriptionSpending(call, await request);
  }

  $async.Future<$1.EnableAutoRenewResponse> enableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.EnableAutoRenewRequest> request) async {
    return enableAutoRenew(call, await request);
  }

  $async.Future<$1.DisableAutoRenewResponse> disableAutoRenew_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DisableAutoRenewRequest> request) async {
    return disableAutoRenew(call, await request);
  }

  $async.Future<$1.GetAutoRenewSubscriptionsResponse>
      getAutoRenewSubscriptions_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetAutoRenewSubscriptionsRequest> request) async {
    return getAutoRenewSubscriptions(call, await request);
  }

  $async.Future<$1.UpdateAutoRenewPlanResponse> updateAutoRenewPlan_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateAutoRenewPlanRequest> request) async {
    return updateAutoRenewPlan(call, await request);
  }

  $async.Future<$1.GetAirtimeToCashRatesResponse> getAirtimeToCashRates_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAirtimeToCashRatesRequest> request) async {
    return getAirtimeToCashRates(call, await request);
  }

  $async.Future<$1.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.RequestAirtimeToCashOTPRequest> request) async {
    return requestAirtimeToCashOTP(call, await request);
  }

  $async.Future<$1.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.VerifyAirtimeToCashOTPRequest> request) async {
    return verifyAirtimeToCashOTP(call, await request);
  }

  $async.Future<$1.ConvertAirtimeToCashResponse> convertAirtimeToCash_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ConvertAirtimeToCashRequest> request) async {
    return convertAirtimeToCash(call, await request);
  }

  $async.Future<$1.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAirtimeToCashHistoryRequest> request) async {
    return getAirtimeToCashHistory(call, await request);
  }

  $async.Future<$1.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService_Pre($grpc.ServiceCall call,
          $async.Future<$1.VerifyAirtimeToCashServiceRequest> request) async {
    return verifyAirtimeToCashService(call, await request);
  }

  $async.Future<$1.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetAirtimeToCashProviderInfoRequest> request) async {
    return getAirtimeToCashProviderInfo(call, await request);
  }

  $async.Future<$1.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CheckAirtimeToCashQuotaRequest> request) async {
    return checkAirtimeToCashQuota(call, await request);
  }

  $async.Future<$1.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SaveAirtimeBeneficiaryRequest> request) async {
    return saveAirtimeBeneficiary(call, await request);
  }

  $async.Future<$1.GetAirtimeBeneficiariesResponse> getAirtimeBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAirtimeBeneficiariesRequest> request) async {
    return getAirtimeBeneficiaries(call, await request);
  }

  $async.Future<$1.UpdateAirtimeBeneficiaryResponse>
      updateAirtimeBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateAirtimeBeneficiaryRequest> request) async {
    return updateAirtimeBeneficiary(call, await request);
  }

  $async.Future<$1.DeleteAirtimeBeneficiaryResponse>
      deleteAirtimeBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteAirtimeBeneficiaryRequest> request) async {
    return deleteAirtimeBeneficiary(call, await request);
  }

  $async.Future<$1.CreateAirtimeAutoRechargeResponse>
      createAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.CreateAirtimeAutoRechargeRequest> request) async {
    return createAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$1.GetAirtimeAutoRechargesResponse> getAirtimeAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAirtimeAutoRechargesRequest> request) async {
    return getAirtimeAutoRecharges(call, await request);
  }

  $async.Future<$1.UpdateAirtimeAutoRechargeResponse>
      updateAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateAirtimeAutoRechargeRequest> request) async {
    return updateAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$1.DeleteAirtimeAutoRechargeResponse>
      deleteAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteAirtimeAutoRechargeRequest> request) async {
    return deleteAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$1.PauseAirtimeAutoRechargeResponse>
      pauseAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.PauseAirtimeAutoRechargeRequest> request) async {
    return pauseAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$1.ResumeAirtimeAutoRechargeResponse>
      resumeAirtimeAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.ResumeAirtimeAutoRechargeRequest> request) async {
    return resumeAirtimeAutoRecharge(call, await request);
  }

  $async.Future<$1.CreateAirtimeReminderResponse> createAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateAirtimeReminderRequest> request) async {
    return createAirtimeReminder(call, await request);
  }

  $async.Future<$1.GetAirtimeRemindersResponse> getAirtimeReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAirtimeRemindersRequest> request) async {
    return getAirtimeReminders(call, await request);
  }

  $async.Future<$1.UpdateAirtimeReminderResponse> updateAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateAirtimeReminderRequest> request) async {
    return updateAirtimeReminder(call, await request);
  }

  $async.Future<$1.DeleteAirtimeReminderResponse> deleteAirtimeReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteAirtimeReminderRequest> request) async {
    return deleteAirtimeReminder(call, await request);
  }

  $async.Future<$1.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$1.MarkAirtimeReminderCompleteRequest> request) async {
    return markAirtimeReminderComplete(call, await request);
  }

  $async.Future<$1.GetAirtimePaymentReceiptResponse>
      getAirtimePaymentReceipt_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetAirtimePaymentReceiptRequest> request) async {
    return getAirtimePaymentReceipt(call, await request);
  }

  $async.Future<$1.SaveDataBeneficiaryResponse> saveDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SaveDataBeneficiaryRequest> request) async {
    return saveDataBeneficiary(call, await request);
  }

  $async.Future<$1.GetDataBeneficiariesResponse> getDataBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetDataBeneficiariesRequest> request) async {
    return getDataBeneficiaries(call, await request);
  }

  $async.Future<$1.UpdateDataBeneficiaryResponse> updateDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateDataBeneficiaryRequest> request) async {
    return updateDataBeneficiary(call, await request);
  }

  $async.Future<$1.DeleteDataBeneficiaryResponse> deleteDataBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteDataBeneficiaryRequest> request) async {
    return deleteDataBeneficiary(call, await request);
  }

  $async.Future<$1.CreateDataAutoRechargeResponse> createDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateDataAutoRechargeRequest> request) async {
    return createDataAutoRecharge(call, await request);
  }

  $async.Future<$1.GetDataAutoRechargesResponse> getDataAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetDataAutoRechargesRequest> request) async {
    return getDataAutoRecharges(call, await request);
  }

  $async.Future<$1.UpdateDataAutoRechargeResponse> updateDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateDataAutoRechargeRequest> request) async {
    return updateDataAutoRecharge(call, await request);
  }

  $async.Future<$1.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteDataAutoRechargeRequest> request) async {
    return deleteDataAutoRecharge(call, await request);
  }

  $async.Future<$1.PauseDataAutoRechargeResponse> pauseDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PauseDataAutoRechargeRequest> request) async {
    return pauseDataAutoRecharge(call, await request);
  }

  $async.Future<$1.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ResumeDataAutoRechargeRequest> request) async {
    return resumeDataAutoRecharge(call, await request);
  }

  $async.Future<$1.CreateDataReminderResponse> createDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateDataReminderRequest> request) async {
    return createDataReminder(call, await request);
  }

  $async.Future<$1.GetDataRemindersResponse> getDataReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetDataRemindersRequest> request) async {
    return getDataReminders(call, await request);
  }

  $async.Future<$1.UpdateDataReminderResponse> updateDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateDataReminderRequest> request) async {
    return updateDataReminder(call, await request);
  }

  $async.Future<$1.DeleteDataReminderResponse> deleteDataReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteDataReminderRequest> request) async {
    return deleteDataReminder(call, await request);
  }

  $async.Future<$1.MarkDataReminderCompleteResponse>
      markDataReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$1.MarkDataReminderCompleteRequest> request) async {
    return markDataReminderComplete(call, await request);
  }

  $async.Future<$1.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SaveCableTVBeneficiaryRequest> request) async {
    return saveCableTVBeneficiary(call, await request);
  }

  $async.Future<$1.GetCableTVBeneficiariesResponse> getCableTVBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCableTVBeneficiariesRequest> request) async {
    return getCableTVBeneficiaries(call, await request);
  }

  $async.Future<$1.UpdateCableTVBeneficiaryResponse>
      updateCableTVBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateCableTVBeneficiaryRequest> request) async {
    return updateCableTVBeneficiary(call, await request);
  }

  $async.Future<$1.DeleteCableTVBeneficiaryResponse>
      deleteCableTVBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteCableTVBeneficiaryRequest> request) async {
    return deleteCableTVBeneficiary(call, await request);
  }

  $async.Future<$1.CreateCableTVAutoRechargeResponse>
      createCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.CreateCableTVAutoRechargeRequest> request) async {
    return createCableTVAutoRecharge(call, await request);
  }

  $async.Future<$1.GetCableTVAutoRechargesResponse> getCableTVAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCableTVAutoRechargesRequest> request) async {
    return getCableTVAutoRecharges(call, await request);
  }

  $async.Future<$1.UpdateCableTVAutoRechargeResponse>
      updateCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateCableTVAutoRechargeRequest> request) async {
    return updateCableTVAutoRecharge(call, await request);
  }

  $async.Future<$1.DeleteCableTVAutoRechargeResponse>
      deleteCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteCableTVAutoRechargeRequest> request) async {
    return deleteCableTVAutoRecharge(call, await request);
  }

  $async.Future<$1.PauseCableTVAutoRechargeResponse>
      pauseCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.PauseCableTVAutoRechargeRequest> request) async {
    return pauseCableTVAutoRecharge(call, await request);
  }

  $async.Future<$1.ResumeCableTVAutoRechargeResponse>
      resumeCableTVAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.ResumeCableTVAutoRechargeRequest> request) async {
    return resumeCableTVAutoRecharge(call, await request);
  }

  $async.Future<$1.CreateCableTVReminderResponse> createCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateCableTVReminderRequest> request) async {
    return createCableTVReminder(call, await request);
  }

  $async.Future<$1.GetCableTVRemindersResponse> getCableTVReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetCableTVRemindersRequest> request) async {
    return getCableTVReminders(call, await request);
  }

  $async.Future<$1.UpdateCableTVReminderResponse> updateCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateCableTVReminderRequest> request) async {
    return updateCableTVReminder(call, await request);
  }

  $async.Future<$1.DeleteCableTVReminderResponse> deleteCableTVReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteCableTVReminderRequest> request) async {
    return deleteCableTVReminder(call, await request);
  }

  $async.Future<$1.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$1.MarkCableTVReminderCompleteRequest> request) async {
    return markCableTVReminderComplete(call, await request);
  }

  $async.Future<$1.GetWaterProvidersResponse> getWaterProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetWaterProvidersRequest> request) async {
    return getWaterProviders(call, await request);
  }

  $async.Future<$1.SaveWaterBeneficiaryResponse> saveWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SaveWaterBeneficiaryRequest> request) async {
    return saveWaterBeneficiary(call, await request);
  }

  $async.Future<$1.GetWaterBeneficiariesResponse> getWaterBeneficiaries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetWaterBeneficiariesRequest> request) async {
    return getWaterBeneficiaries(call, await request);
  }

  $async.Future<$1.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateWaterBeneficiaryRequest> request) async {
    return updateWaterBeneficiary(call, await request);
  }

  $async.Future<$1.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteWaterBeneficiaryRequest> request) async {
    return deleteWaterBeneficiary(call, await request);
  }

  $async.Future<$1.CreateWaterAutoRechargeResponse> createWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateWaterAutoRechargeRequest> request) async {
    return createWaterAutoRecharge(call, await request);
  }

  $async.Future<$1.GetWaterAutoRechargesResponse> getWaterAutoRecharges_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetWaterAutoRechargesRequest> request) async {
    return getWaterAutoRecharges(call, await request);
  }

  $async.Future<$1.UpdateWaterAutoRechargeResponse> updateWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateWaterAutoRechargeRequest> request) async {
    return updateWaterAutoRecharge(call, await request);
  }

  $async.Future<$1.DeleteWaterAutoRechargeResponse> deleteWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteWaterAutoRechargeRequest> request) async {
    return deleteWaterAutoRecharge(call, await request);
  }

  $async.Future<$1.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.PauseWaterAutoRechargeRequest> request) async {
    return pauseWaterAutoRecharge(call, await request);
  }

  $async.Future<$1.ResumeWaterAutoRechargeResponse> resumeWaterAutoRecharge_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.ResumeWaterAutoRechargeRequest> request) async {
    return resumeWaterAutoRecharge(call, await request);
  }

  $async.Future<$1.CreateWaterReminderResponse> createWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateWaterReminderRequest> request) async {
    return createWaterReminder(call, await request);
  }

  $async.Future<$1.GetWaterRemindersResponse> getWaterReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetWaterRemindersRequest> request) async {
    return getWaterReminders(call, await request);
  }

  $async.Future<$1.UpdateWaterReminderResponse> updateWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateWaterReminderRequest> request) async {
    return updateWaterReminder(call, await request);
  }

  $async.Future<$1.DeleteWaterReminderResponse> deleteWaterReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteWaterReminderRequest> request) async {
    return deleteWaterReminder(call, await request);
  }

  $async.Future<$1.MarkWaterReminderCompleteResponse>
      markWaterReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$1.MarkWaterReminderCompleteRequest> request) async {
    return markWaterReminderComplete(call, await request);
  }

  $async.Future<$1.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetAsyncPaymentConfigRequest> request) async {
    return getAsyncPaymentConfig(call, await request);
  }

  $async.Future<$1.UpdateAsyncPaymentConfigResponse>
      updateAsyncPaymentConfig_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateAsyncPaymentConfigRequest> request) async {
    return updateAsyncPaymentConfig(call, await request);
  }

  $async.Future<$1.GetIntlAirtimeCountriesResponse> getIntlAirtimeCountries_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetIntlAirtimeCountriesRequest> request) async {
    return getIntlAirtimeCountries(call, await request);
  }

  $async.Future<$1.GetIntlAirtimeOperatorsResponse> getIntlAirtimeOperators_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetIntlAirtimeOperatorsRequest> request) async {
    return getIntlAirtimeOperators(call, await request);
  }

  $async.Future<$1.AutoDetectIntlOperatorResponse> autoDetectIntlOperator_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.AutoDetectIntlOperatorRequest> request) async {
    return autoDetectIntlOperator(call, await request);
  }

  $async.Future<$1.BuyIntlAirtimeResponse> buyIntlAirtime_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.BuyIntlAirtimeRequest> request) async {
    return buyIntlAirtime(call, await request);
  }

  $async.Future<$1.GetIntlDataOperatorsResponse> getIntlDataOperators_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetIntlDataOperatorsRequest> request) async {
    return getIntlDataOperators(call, await request);
  }

  $async.Future<$1.GetIntlDataBundlesResponse> getIntlDataBundles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetIntlDataBundlesRequest> request) async {
    return getIntlDataBundles(call, await request);
  }

  $async.Future<$1.BuyIntlDataResponse> buyIntlData_Pre($grpc.ServiceCall call,
      $async.Future<$1.BuyIntlDataRequest> request) async {
    return buyIntlData(call, await request);
  }

  $async.Future<$1.SaveInternetBeneficiaryResponse> saveInternetBeneficiary_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.SaveInternetBeneficiaryRequest> request) async {
    return saveInternetBeneficiary(call, await request);
  }

  $async.Future<$1.GetInternetBeneficiariesResponse>
      getInternetBeneficiaries_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInternetBeneficiariesRequest> request) async {
    return getInternetBeneficiaries(call, await request);
  }

  $async.Future<$1.UpdateInternetBeneficiaryResponse>
      updateInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateInternetBeneficiaryRequest> request) async {
    return updateInternetBeneficiary(call, await request);
  }

  $async.Future<$1.DeleteInternetBeneficiaryResponse>
      deleteInternetBeneficiary_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteInternetBeneficiaryRequest> request) async {
    return deleteInternetBeneficiary(call, await request);
  }

  $async.Future<$1.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.CreateInternetAutoRechargeRequest> request) async {
    return createInternetAutoRecharge(call, await request);
  }

  $async.Future<$1.GetInternetAutoRechargesResponse>
      getInternetAutoRecharges_Pre($grpc.ServiceCall call,
          $async.Future<$1.GetInternetAutoRechargesRequest> request) async {
    return getInternetAutoRecharges(call, await request);
  }

  $async.Future<$1.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.UpdateInternetAutoRechargeRequest> request) async {
    return updateInternetAutoRecharge(call, await request);
  }

  $async.Future<$1.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.DeleteInternetAutoRechargeRequest> request) async {
    return deleteInternetAutoRecharge(call, await request);
  }

  $async.Future<$1.PauseInternetAutoRechargeResponse>
      pauseInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.PauseInternetAutoRechargeRequest> request) async {
    return pauseInternetAutoRecharge(call, await request);
  }

  $async.Future<$1.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge_Pre($grpc.ServiceCall call,
          $async.Future<$1.ResumeInternetAutoRechargeRequest> request) async {
    return resumeInternetAutoRecharge(call, await request);
  }

  $async.Future<$1.CreateInternetReminderResponse> createInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.CreateInternetReminderRequest> request) async {
    return createInternetReminder(call, await request);
  }

  $async.Future<$1.GetInternetRemindersResponse> getInternetReminders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.GetInternetRemindersRequest> request) async {
    return getInternetReminders(call, await request);
  }

  $async.Future<$1.UpdateInternetReminderResponse> updateInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.UpdateInternetReminderRequest> request) async {
    return updateInternetReminder(call, await request);
  }

  $async.Future<$1.DeleteInternetReminderResponse> deleteInternetReminder_Pre(
      $grpc.ServiceCall call,
      $async.Future<$1.DeleteInternetReminderRequest> request) async {
    return deleteInternetReminder(call, await request);
  }

  $async.Future<$1.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete_Pre($grpc.ServiceCall call,
          $async.Future<$1.MarkInternetReminderCompleteRequest> request) async {
    return markInternetReminderComplete(call, await request);
  }

  $async.Future<$1.PayElectricityBillResponse> payElectricityBill(
      $grpc.ServiceCall call, $1.PayElectricityBillRequest request);
  $async.Future<$1.PayWaterBillResponse> payWaterBill(
      $grpc.ServiceCall call, $1.PayWaterBillRequest request);
  $async.Future<$1.PayInternetBillResponse> payInternetBill(
      $grpc.ServiceCall call, $1.PayInternetBillRequest request);
  $async.Future<$1.BuyAirtimeResponse> buyAirtime(
      $grpc.ServiceCall call, $1.BuyAirtimeRequest request);
  $async.Future<$1.BuyDataResponse> buyData(
      $grpc.ServiceCall call, $1.BuyDataRequest request);
  $async.Future<$1.GetDataPlansResponse> getDataPlans(
      $grpc.ServiceCall call, $1.GetDataPlansRequest request);
  $async.Future<$1.BarcodePayResponse> barcodePay(
      $grpc.ServiceCall call, $1.BarcodePayRequest request);
  $async.Future<$1.ScanToPayResponse> scanToPay(
      $grpc.ServiceCall call, $1.ScanToPayRequest request);
  $async.Future<$1.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $grpc.ServiceCall call, $1.GetBillPaymentHistoryRequest request);
  $async.Future<$1.GetBillProvidersResponse> getBillProviders(
      $grpc.ServiceCall call, $1.GetBillProvidersRequest request);
  $async.Future<$1.GetAirtimeProvidersResponse> getAirtimeProviders(
      $grpc.ServiceCall call, $1.GetAirtimeProvidersRequest request);
  $async.Future<$1.VerifyBillResponse> verifyBill(
      $grpc.ServiceCall call, $1.VerifyBillRequest request);
  $async.Future<$1.ValidateSmartCardResponse> validateSmartCard(
      $grpc.ServiceCall call, $1.ValidateSmartCardRequest request);
  $async.Future<$1.GetTVPackagesResponse> getTVPackages(
      $grpc.ServiceCall call, $1.GetTVPackagesRequest request);
  $async.Future<$1.PayCableTVBillResponse> payCableTVBill(
      $grpc.ServiceCall call, $1.PayCableTVBillRequest request);
  $async.Future<$1.GetCableTVProvidersResponse> getCableTVProviders(
      $grpc.ServiceCall call, $1.GetCableTVProvidersRequest request);
  $async.Future<$1.GetInternetProvidersResponse> getInternetProviders(
      $grpc.ServiceCall call, $1.GetInternetProvidersRequest request);
  $async.Future<$1.ValidateInternetAccountResponse> validateInternetAccount(
      $grpc.ServiceCall call, $1.ValidateInternetAccountRequest request);
  $async.Future<$1.GetInternetPackagesResponse> getInternetPackages(
      $grpc.ServiceCall call, $1.GetInternetPackagesRequest request);
  $async.Future<$1.PurchaseEducationPinResponse> purchaseEducationPin(
      $grpc.ServiceCall call, $1.PurchaseEducationPinRequest request);
  $async.Future<$1.GetEducationProvidersResponse> getEducationProviders(
      $grpc.ServiceCall call, $1.GetEducationProvidersRequest request);
  $async.Future<$1.SaveEducationBeneficiaryResponse> saveEducationBeneficiary(
      $grpc.ServiceCall call, $1.SaveEducationBeneficiaryRequest request);
  $async.Future<$1.GetEducationBeneficiariesResponse> getEducationBeneficiaries(
      $grpc.ServiceCall call, $1.GetEducationBeneficiariesRequest request);
  $async.Future<$1.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary(
          $grpc.ServiceCall call, $1.UpdateEducationBeneficiaryRequest request);
  $async.Future<$1.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary(
          $grpc.ServiceCall call, $1.DeleteEducationBeneficiaryRequest request);
  $async.Future<$1.CreateEducationReminderResponse> createEducationReminder(
      $grpc.ServiceCall call, $1.CreateEducationReminderRequest request);
  $async.Future<$1.GetEducationRemindersResponse> getEducationReminders(
      $grpc.ServiceCall call, $1.GetEducationRemindersRequest request);
  $async.Future<$1.UpdateEducationReminderResponse> updateEducationReminder(
      $grpc.ServiceCall call, $1.UpdateEducationReminderRequest request);
  $async.Future<$1.DeleteEducationReminderResponse> deleteEducationReminder(
      $grpc.ServiceCall call, $1.DeleteEducationReminderRequest request);
  $async.Future<$1.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete($grpc.ServiceCall call,
          $1.MarkEducationReminderCompleteRequest request);
  $async.Future<$1.GetActiveSubscriptionsResponse> getActiveSubscriptions(
      $grpc.ServiceCall call, $1.GetActiveSubscriptionsRequest request);
  $async.Future<$1.GetSubscriptionSummaryResponse> getSubscriptionSummary(
      $grpc.ServiceCall call, $1.GetSubscriptionSummaryRequest request);
  $async.Future<$1.GetSubscriptionSpendingResponse> getSubscriptionSpending(
      $grpc.ServiceCall call, $1.GetSubscriptionSpendingRequest request);
  $async.Future<$1.EnableAutoRenewResponse> enableAutoRenew(
      $grpc.ServiceCall call, $1.EnableAutoRenewRequest request);
  $async.Future<$1.DisableAutoRenewResponse> disableAutoRenew(
      $grpc.ServiceCall call, $1.DisableAutoRenewRequest request);
  $async.Future<$1.GetAutoRenewSubscriptionsResponse> getAutoRenewSubscriptions(
      $grpc.ServiceCall call, $1.GetAutoRenewSubscriptionsRequest request);
  $async.Future<$1.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $grpc.ServiceCall call, $1.UpdateAutoRenewPlanRequest request);
  $async.Future<$1.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $grpc.ServiceCall call, $1.GetAirtimeToCashRatesRequest request);
  $async.Future<$1.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP(
      $grpc.ServiceCall call, $1.RequestAirtimeToCashOTPRequest request);
  $async.Future<$1.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP(
      $grpc.ServiceCall call, $1.VerifyAirtimeToCashOTPRequest request);
  $async.Future<$1.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $grpc.ServiceCall call, $1.ConvertAirtimeToCashRequest request);
  $async.Future<$1.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory(
      $grpc.ServiceCall call, $1.GetAirtimeToCashHistoryRequest request);
  $async.Future<$1.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService(
          $grpc.ServiceCall call, $1.VerifyAirtimeToCashServiceRequest request);
  $async.Future<$1.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo($grpc.ServiceCall call,
          $1.GetAirtimeToCashProviderInfoRequest request);
  $async.Future<$1.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota(
      $grpc.ServiceCall call, $1.CheckAirtimeToCashQuotaRequest request);
  $async.Future<$1.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary(
      $grpc.ServiceCall call, $1.SaveAirtimeBeneficiaryRequest request);
  $async.Future<$1.GetAirtimeBeneficiariesResponse> getAirtimeBeneficiaries(
      $grpc.ServiceCall call, $1.GetAirtimeBeneficiariesRequest request);
  $async.Future<$1.UpdateAirtimeBeneficiaryResponse> updateAirtimeBeneficiary(
      $grpc.ServiceCall call, $1.UpdateAirtimeBeneficiaryRequest request);
  $async.Future<$1.DeleteAirtimeBeneficiaryResponse> deleteAirtimeBeneficiary(
      $grpc.ServiceCall call, $1.DeleteAirtimeBeneficiaryRequest request);
  $async.Future<$1.CreateAirtimeAutoRechargeResponse> createAirtimeAutoRecharge(
      $grpc.ServiceCall call, $1.CreateAirtimeAutoRechargeRequest request);
  $async.Future<$1.GetAirtimeAutoRechargesResponse> getAirtimeAutoRecharges(
      $grpc.ServiceCall call, $1.GetAirtimeAutoRechargesRequest request);
  $async.Future<$1.UpdateAirtimeAutoRechargeResponse> updateAirtimeAutoRecharge(
      $grpc.ServiceCall call, $1.UpdateAirtimeAutoRechargeRequest request);
  $async.Future<$1.DeleteAirtimeAutoRechargeResponse> deleteAirtimeAutoRecharge(
      $grpc.ServiceCall call, $1.DeleteAirtimeAutoRechargeRequest request);
  $async.Future<$1.PauseAirtimeAutoRechargeResponse> pauseAirtimeAutoRecharge(
      $grpc.ServiceCall call, $1.PauseAirtimeAutoRechargeRequest request);
  $async.Future<$1.ResumeAirtimeAutoRechargeResponse> resumeAirtimeAutoRecharge(
      $grpc.ServiceCall call, $1.ResumeAirtimeAutoRechargeRequest request);
  $async.Future<$1.CreateAirtimeReminderResponse> createAirtimeReminder(
      $grpc.ServiceCall call, $1.CreateAirtimeReminderRequest request);
  $async.Future<$1.GetAirtimeRemindersResponse> getAirtimeReminders(
      $grpc.ServiceCall call, $1.GetAirtimeRemindersRequest request);
  $async.Future<$1.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $grpc.ServiceCall call, $1.UpdateAirtimeReminderRequest request);
  $async.Future<$1.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $grpc.ServiceCall call, $1.DeleteAirtimeReminderRequest request);
  $async.Future<$1.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete($grpc.ServiceCall call,
          $1.MarkAirtimeReminderCompleteRequest request);
  $async.Future<$1.GetAirtimePaymentReceiptResponse> getAirtimePaymentReceipt(
      $grpc.ServiceCall call, $1.GetAirtimePaymentReceiptRequest request);
  $async.Future<$1.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $grpc.ServiceCall call, $1.SaveDataBeneficiaryRequest request);
  $async.Future<$1.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $grpc.ServiceCall call, $1.GetDataBeneficiariesRequest request);
  $async.Future<$1.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $grpc.ServiceCall call, $1.UpdateDataBeneficiaryRequest request);
  $async.Future<$1.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $grpc.ServiceCall call, $1.DeleteDataBeneficiaryRequest request);
  $async.Future<$1.CreateDataAutoRechargeResponse> createDataAutoRecharge(
      $grpc.ServiceCall call, $1.CreateDataAutoRechargeRequest request);
  $async.Future<$1.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $grpc.ServiceCall call, $1.GetDataAutoRechargesRequest request);
  $async.Future<$1.UpdateDataAutoRechargeResponse> updateDataAutoRecharge(
      $grpc.ServiceCall call, $1.UpdateDataAutoRechargeRequest request);
  $async.Future<$1.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge(
      $grpc.ServiceCall call, $1.DeleteDataAutoRechargeRequest request);
  $async.Future<$1.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $grpc.ServiceCall call, $1.PauseDataAutoRechargeRequest request);
  $async.Future<$1.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge(
      $grpc.ServiceCall call, $1.ResumeDataAutoRechargeRequest request);
  $async.Future<$1.CreateDataReminderResponse> createDataReminder(
      $grpc.ServiceCall call, $1.CreateDataReminderRequest request);
  $async.Future<$1.GetDataRemindersResponse> getDataReminders(
      $grpc.ServiceCall call, $1.GetDataRemindersRequest request);
  $async.Future<$1.UpdateDataReminderResponse> updateDataReminder(
      $grpc.ServiceCall call, $1.UpdateDataReminderRequest request);
  $async.Future<$1.DeleteDataReminderResponse> deleteDataReminder(
      $grpc.ServiceCall call, $1.DeleteDataReminderRequest request);
  $async.Future<$1.MarkDataReminderCompleteResponse> markDataReminderComplete(
      $grpc.ServiceCall call, $1.MarkDataReminderCompleteRequest request);
  $async.Future<$1.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary(
      $grpc.ServiceCall call, $1.SaveCableTVBeneficiaryRequest request);
  $async.Future<$1.GetCableTVBeneficiariesResponse> getCableTVBeneficiaries(
      $grpc.ServiceCall call, $1.GetCableTVBeneficiariesRequest request);
  $async.Future<$1.UpdateCableTVBeneficiaryResponse> updateCableTVBeneficiary(
      $grpc.ServiceCall call, $1.UpdateCableTVBeneficiaryRequest request);
  $async.Future<$1.DeleteCableTVBeneficiaryResponse> deleteCableTVBeneficiary(
      $grpc.ServiceCall call, $1.DeleteCableTVBeneficiaryRequest request);
  $async.Future<$1.CreateCableTVAutoRechargeResponse> createCableTVAutoRecharge(
      $grpc.ServiceCall call, $1.CreateCableTVAutoRechargeRequest request);
  $async.Future<$1.GetCableTVAutoRechargesResponse> getCableTVAutoRecharges(
      $grpc.ServiceCall call, $1.GetCableTVAutoRechargesRequest request);
  $async.Future<$1.UpdateCableTVAutoRechargeResponse> updateCableTVAutoRecharge(
      $grpc.ServiceCall call, $1.UpdateCableTVAutoRechargeRequest request);
  $async.Future<$1.DeleteCableTVAutoRechargeResponse> deleteCableTVAutoRecharge(
      $grpc.ServiceCall call, $1.DeleteCableTVAutoRechargeRequest request);
  $async.Future<$1.PauseCableTVAutoRechargeResponse> pauseCableTVAutoRecharge(
      $grpc.ServiceCall call, $1.PauseCableTVAutoRechargeRequest request);
  $async.Future<$1.ResumeCableTVAutoRechargeResponse> resumeCableTVAutoRecharge(
      $grpc.ServiceCall call, $1.ResumeCableTVAutoRechargeRequest request);
  $async.Future<$1.CreateCableTVReminderResponse> createCableTVReminder(
      $grpc.ServiceCall call, $1.CreateCableTVReminderRequest request);
  $async.Future<$1.GetCableTVRemindersResponse> getCableTVReminders(
      $grpc.ServiceCall call, $1.GetCableTVRemindersRequest request);
  $async.Future<$1.UpdateCableTVReminderResponse> updateCableTVReminder(
      $grpc.ServiceCall call, $1.UpdateCableTVReminderRequest request);
  $async.Future<$1.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $grpc.ServiceCall call, $1.DeleteCableTVReminderRequest request);
  $async.Future<$1.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete($grpc.ServiceCall call,
          $1.MarkCableTVReminderCompleteRequest request);
  $async.Future<$1.GetWaterProvidersResponse> getWaterProviders(
      $grpc.ServiceCall call, $1.GetWaterProvidersRequest request);
  $async.Future<$1.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $grpc.ServiceCall call, $1.SaveWaterBeneficiaryRequest request);
  $async.Future<$1.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $grpc.ServiceCall call, $1.GetWaterBeneficiariesRequest request);
  $async.Future<$1.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary(
      $grpc.ServiceCall call, $1.UpdateWaterBeneficiaryRequest request);
  $async.Future<$1.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary(
      $grpc.ServiceCall call, $1.DeleteWaterBeneficiaryRequest request);
  $async.Future<$1.CreateWaterAutoRechargeResponse> createWaterAutoRecharge(
      $grpc.ServiceCall call, $1.CreateWaterAutoRechargeRequest request);
  $async.Future<$1.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $grpc.ServiceCall call, $1.GetWaterAutoRechargesRequest request);
  $async.Future<$1.UpdateWaterAutoRechargeResponse> updateWaterAutoRecharge(
      $grpc.ServiceCall call, $1.UpdateWaterAutoRechargeRequest request);
  $async.Future<$1.DeleteWaterAutoRechargeResponse> deleteWaterAutoRecharge(
      $grpc.ServiceCall call, $1.DeleteWaterAutoRechargeRequest request);
  $async.Future<$1.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge(
      $grpc.ServiceCall call, $1.PauseWaterAutoRechargeRequest request);
  $async.Future<$1.ResumeWaterAutoRechargeResponse> resumeWaterAutoRecharge(
      $grpc.ServiceCall call, $1.ResumeWaterAutoRechargeRequest request);
  $async.Future<$1.CreateWaterReminderResponse> createWaterReminder(
      $grpc.ServiceCall call, $1.CreateWaterReminderRequest request);
  $async.Future<$1.GetWaterRemindersResponse> getWaterReminders(
      $grpc.ServiceCall call, $1.GetWaterRemindersRequest request);
  $async.Future<$1.UpdateWaterReminderResponse> updateWaterReminder(
      $grpc.ServiceCall call, $1.UpdateWaterReminderRequest request);
  $async.Future<$1.DeleteWaterReminderResponse> deleteWaterReminder(
      $grpc.ServiceCall call, $1.DeleteWaterReminderRequest request);
  $async.Future<$1.MarkWaterReminderCompleteResponse> markWaterReminderComplete(
      $grpc.ServiceCall call, $1.MarkWaterReminderCompleteRequest request);
  $async.Future<$1.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $grpc.ServiceCall call, $1.GetAsyncPaymentConfigRequest request);
  $async.Future<$1.UpdateAsyncPaymentConfigResponse> updateAsyncPaymentConfig(
      $grpc.ServiceCall call, $1.UpdateAsyncPaymentConfigRequest request);
  $async.Future<$1.GetIntlAirtimeCountriesResponse> getIntlAirtimeCountries(
      $grpc.ServiceCall call, $1.GetIntlAirtimeCountriesRequest request);
  $async.Future<$1.GetIntlAirtimeOperatorsResponse> getIntlAirtimeOperators(
      $grpc.ServiceCall call, $1.GetIntlAirtimeOperatorsRequest request);
  $async.Future<$1.AutoDetectIntlOperatorResponse> autoDetectIntlOperator(
      $grpc.ServiceCall call, $1.AutoDetectIntlOperatorRequest request);
  $async.Future<$1.BuyIntlAirtimeResponse> buyIntlAirtime(
      $grpc.ServiceCall call, $1.BuyIntlAirtimeRequest request);
  $async.Future<$1.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $grpc.ServiceCall call, $1.GetIntlDataOperatorsRequest request);
  $async.Future<$1.GetIntlDataBundlesResponse> getIntlDataBundles(
      $grpc.ServiceCall call, $1.GetIntlDataBundlesRequest request);
  $async.Future<$1.BuyIntlDataResponse> buyIntlData(
      $grpc.ServiceCall call, $1.BuyIntlDataRequest request);
  $async.Future<$1.SaveInternetBeneficiaryResponse> saveInternetBeneficiary(
      $grpc.ServiceCall call, $1.SaveInternetBeneficiaryRequest request);
  $async.Future<$1.GetInternetBeneficiariesResponse> getInternetBeneficiaries(
      $grpc.ServiceCall call, $1.GetInternetBeneficiariesRequest request);
  $async.Future<$1.UpdateInternetBeneficiaryResponse> updateInternetBeneficiary(
      $grpc.ServiceCall call, $1.UpdateInternetBeneficiaryRequest request);
  $async.Future<$1.DeleteInternetBeneficiaryResponse> deleteInternetBeneficiary(
      $grpc.ServiceCall call, $1.DeleteInternetBeneficiaryRequest request);
  $async.Future<$1.CreateInternetAutoRechargeResponse>
      createInternetAutoRecharge(
          $grpc.ServiceCall call, $1.CreateInternetAutoRechargeRequest request);
  $async.Future<$1.GetInternetAutoRechargesResponse> getInternetAutoRecharges(
      $grpc.ServiceCall call, $1.GetInternetAutoRechargesRequest request);
  $async.Future<$1.UpdateInternetAutoRechargeResponse>
      updateInternetAutoRecharge(
          $grpc.ServiceCall call, $1.UpdateInternetAutoRechargeRequest request);
  $async.Future<$1.DeleteInternetAutoRechargeResponse>
      deleteInternetAutoRecharge(
          $grpc.ServiceCall call, $1.DeleteInternetAutoRechargeRequest request);
  $async.Future<$1.PauseInternetAutoRechargeResponse> pauseInternetAutoRecharge(
      $grpc.ServiceCall call, $1.PauseInternetAutoRechargeRequest request);
  $async.Future<$1.ResumeInternetAutoRechargeResponse>
      resumeInternetAutoRecharge(
          $grpc.ServiceCall call, $1.ResumeInternetAutoRechargeRequest request);
  $async.Future<$1.CreateInternetReminderResponse> createInternetReminder(
      $grpc.ServiceCall call, $1.CreateInternetReminderRequest request);
  $async.Future<$1.GetInternetRemindersResponse> getInternetReminders(
      $grpc.ServiceCall call, $1.GetInternetRemindersRequest request);
  $async.Future<$1.UpdateInternetReminderResponse> updateInternetReminder(
      $grpc.ServiceCall call, $1.UpdateInternetReminderRequest request);
  $async.Future<$1.DeleteInternetReminderResponse> deleteInternetReminder(
      $grpc.ServiceCall call, $1.DeleteInternetReminderRequest request);
  $async.Future<$1.MarkInternetReminderCompleteResponse>
      markInternetReminderComplete($grpc.ServiceCall call,
          $1.MarkInternetReminderCompleteRequest request);
}
