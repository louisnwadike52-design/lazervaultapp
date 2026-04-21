// This is a generated file - do not edit.
//
// Generated from utility-payments.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'utility-payments.pb.dart' as $2;
import 'utility-payments.pbjson.dart';

export 'utility-payments.pb.dart';

abstract class UtilityPaymentsServiceBase extends $pb.GeneratedService {
  $async.Future<$2.PayElectricityBillResponse> payElectricityBill(
      $pb.ServerContext ctx, $2.PayElectricityBillRequest request);
  $async.Future<$2.PayWaterBillResponse> payWaterBill(
      $pb.ServerContext ctx, $2.PayWaterBillRequest request);
  $async.Future<$2.PayInternetBillResponse> payInternetBill(
      $pb.ServerContext ctx, $2.PayInternetBillRequest request);
  $async.Future<$2.BuyAirtimeResponse> buyAirtime(
      $pb.ServerContext ctx, $2.BuyAirtimeRequest request);
  $async.Future<$2.BuyDataResponse> buyData(
      $pb.ServerContext ctx, $2.BuyDataRequest request);
  $async.Future<$2.GetDataPlansResponse> getDataPlans(
      $pb.ServerContext ctx, $2.GetDataPlansRequest request);
  $async.Future<$2.BarcodePayResponse> barcodePay(
      $pb.ServerContext ctx, $2.BarcodePayRequest request);
  $async.Future<$2.ScanToPayResponse> scanToPay(
      $pb.ServerContext ctx, $2.ScanToPayRequest request);
  $async.Future<$2.GetBillPaymentHistoryResponse> getBillPaymentHistory(
      $pb.ServerContext ctx, $2.GetBillPaymentHistoryRequest request);
  $async.Future<$2.GetBillProvidersResponse> getBillProviders(
      $pb.ServerContext ctx, $2.GetBillProvidersRequest request);
  $async.Future<$2.GetAirtimeProvidersResponse> getAirtimeProviders(
      $pb.ServerContext ctx, $2.GetAirtimeProvidersRequest request);
  $async.Future<$2.VerifyBillResponse> verifyBill(
      $pb.ServerContext ctx, $2.VerifyBillRequest request);
  $async.Future<$2.ValidateSmartCardResponse> validateSmartCard(
      $pb.ServerContext ctx, $2.ValidateSmartCardRequest request);
  $async.Future<$2.GetTVPackagesResponse> getTVPackages(
      $pb.ServerContext ctx, $2.GetTVPackagesRequest request);
  $async.Future<$2.PayCableTVBillResponse> payCableTVBill(
      $pb.ServerContext ctx, $2.PayCableTVBillRequest request);
  $async.Future<$2.GetCableTVProvidersResponse> getCableTVProviders(
      $pb.ServerContext ctx, $2.GetCableTVProvidersRequest request);
  $async.Future<$2.GetInternetProvidersResponse> getInternetProviders(
      $pb.ServerContext ctx, $2.GetInternetProvidersRequest request);
  $async.Future<$2.ValidateInternetAccountResponse> validateInternetAccount(
      $pb.ServerContext ctx, $2.ValidateInternetAccountRequest request);
  $async.Future<$2.GetInternetPackagesResponse> getInternetPackages(
      $pb.ServerContext ctx, $2.GetInternetPackagesRequest request);
  $async.Future<$2.PurchaseEducationPinResponse> purchaseEducationPin(
      $pb.ServerContext ctx, $2.PurchaseEducationPinRequest request);
  $async.Future<$2.GetEducationProvidersResponse> getEducationProviders(
      $pb.ServerContext ctx, $2.GetEducationProvidersRequest request);
  $async.Future<$2.SaveEducationBeneficiaryResponse> saveEducationBeneficiary(
      $pb.ServerContext ctx, $2.SaveEducationBeneficiaryRequest request);
  $async.Future<$2.GetEducationBeneficiariesResponse> getEducationBeneficiaries(
      $pb.ServerContext ctx, $2.GetEducationBeneficiariesRequest request);
  $async.Future<$2.UpdateEducationBeneficiaryResponse>
      updateEducationBeneficiary(
          $pb.ServerContext ctx, $2.UpdateEducationBeneficiaryRequest request);
  $async.Future<$2.DeleteEducationBeneficiaryResponse>
      deleteEducationBeneficiary(
          $pb.ServerContext ctx, $2.DeleteEducationBeneficiaryRequest request);
  $async.Future<$2.CreateEducationReminderResponse> createEducationReminder(
      $pb.ServerContext ctx, $2.CreateEducationReminderRequest request);
  $async.Future<$2.GetEducationRemindersResponse> getEducationReminders(
      $pb.ServerContext ctx, $2.GetEducationRemindersRequest request);
  $async.Future<$2.UpdateEducationReminderResponse> updateEducationReminder(
      $pb.ServerContext ctx, $2.UpdateEducationReminderRequest request);
  $async.Future<$2.DeleteEducationReminderResponse> deleteEducationReminder(
      $pb.ServerContext ctx, $2.DeleteEducationReminderRequest request);
  $async.Future<$2.MarkEducationReminderCompleteResponse>
      markEducationReminderComplete($pb.ServerContext ctx,
          $2.MarkEducationReminderCompleteRequest request);
  $async.Future<$2.GetActiveSubscriptionsResponse> getActiveSubscriptions(
      $pb.ServerContext ctx, $2.GetActiveSubscriptionsRequest request);
  $async.Future<$2.GetSubscriptionSummaryResponse> getSubscriptionSummary(
      $pb.ServerContext ctx, $2.GetSubscriptionSummaryRequest request);
  $async.Future<$2.GetSubscriptionSpendingResponse> getSubscriptionSpending(
      $pb.ServerContext ctx, $2.GetSubscriptionSpendingRequest request);
  $async.Future<$2.EnableAutoRenewResponse> enableAutoRenew(
      $pb.ServerContext ctx, $2.EnableAutoRenewRequest request);
  $async.Future<$2.DisableAutoRenewResponse> disableAutoRenew(
      $pb.ServerContext ctx, $2.DisableAutoRenewRequest request);
  $async.Future<$2.GetAutoRenewSubscriptionsResponse> getAutoRenewSubscriptions(
      $pb.ServerContext ctx, $2.GetAutoRenewSubscriptionsRequest request);
  $async.Future<$2.UpdateAutoRenewPlanResponse> updateAutoRenewPlan(
      $pb.ServerContext ctx, $2.UpdateAutoRenewPlanRequest request);
  $async.Future<$2.GetAirtimeToCashRatesResponse> getAirtimeToCashRates(
      $pb.ServerContext ctx, $2.GetAirtimeToCashRatesRequest request);
  $async.Future<$2.RequestAirtimeToCashOTPResponse> requestAirtimeToCashOTP(
      $pb.ServerContext ctx, $2.RequestAirtimeToCashOTPRequest request);
  $async.Future<$2.VerifyAirtimeToCashOTPResponse> verifyAirtimeToCashOTP(
      $pb.ServerContext ctx, $2.VerifyAirtimeToCashOTPRequest request);
  $async.Future<$2.ConvertAirtimeToCashResponse> convertAirtimeToCash(
      $pb.ServerContext ctx, $2.ConvertAirtimeToCashRequest request);
  $async.Future<$2.GetAirtimeToCashHistoryResponse> getAirtimeToCashHistory(
      $pb.ServerContext ctx, $2.GetAirtimeToCashHistoryRequest request);
  $async.Future<$2.VerifyAirtimeToCashServiceResponse>
      verifyAirtimeToCashService(
          $pb.ServerContext ctx, $2.VerifyAirtimeToCashServiceRequest request);
  $async.Future<$2.GetAirtimeToCashProviderInfoResponse>
      getAirtimeToCashProviderInfo($pb.ServerContext ctx,
          $2.GetAirtimeToCashProviderInfoRequest request);
  $async.Future<$2.CheckAirtimeToCashQuotaResponse> checkAirtimeToCashQuota(
      $pb.ServerContext ctx, $2.CheckAirtimeToCashQuotaRequest request);
  $async.Future<$2.SaveAirtimeBeneficiaryResponse> saveAirtimeBeneficiary(
      $pb.ServerContext ctx, $2.SaveAirtimeBeneficiaryRequest request);
  $async.Future<$2.GetAirtimeBeneficiariesResponse> getAirtimeBeneficiaries(
      $pb.ServerContext ctx, $2.GetAirtimeBeneficiariesRequest request);
  $async.Future<$2.UpdateAirtimeBeneficiaryResponse> updateAirtimeBeneficiary(
      $pb.ServerContext ctx, $2.UpdateAirtimeBeneficiaryRequest request);
  $async.Future<$2.DeleteAirtimeBeneficiaryResponse> deleteAirtimeBeneficiary(
      $pb.ServerContext ctx, $2.DeleteAirtimeBeneficiaryRequest request);
  $async.Future<$2.CreateAirtimeAutoRechargeResponse> createAirtimeAutoRecharge(
      $pb.ServerContext ctx, $2.CreateAirtimeAutoRechargeRequest request);
  $async.Future<$2.GetAirtimeAutoRechargesResponse> getAirtimeAutoRecharges(
      $pb.ServerContext ctx, $2.GetAirtimeAutoRechargesRequest request);
  $async.Future<$2.UpdateAirtimeAutoRechargeResponse> updateAirtimeAutoRecharge(
      $pb.ServerContext ctx, $2.UpdateAirtimeAutoRechargeRequest request);
  $async.Future<$2.DeleteAirtimeAutoRechargeResponse> deleteAirtimeAutoRecharge(
      $pb.ServerContext ctx, $2.DeleteAirtimeAutoRechargeRequest request);
  $async.Future<$2.PauseAirtimeAutoRechargeResponse> pauseAirtimeAutoRecharge(
      $pb.ServerContext ctx, $2.PauseAirtimeAutoRechargeRequest request);
  $async.Future<$2.ResumeAirtimeAutoRechargeResponse> resumeAirtimeAutoRecharge(
      $pb.ServerContext ctx, $2.ResumeAirtimeAutoRechargeRequest request);
  $async.Future<$2.CreateAirtimeReminderResponse> createAirtimeReminder(
      $pb.ServerContext ctx, $2.CreateAirtimeReminderRequest request);
  $async.Future<$2.GetAirtimeRemindersResponse> getAirtimeReminders(
      $pb.ServerContext ctx, $2.GetAirtimeRemindersRequest request);
  $async.Future<$2.UpdateAirtimeReminderResponse> updateAirtimeReminder(
      $pb.ServerContext ctx, $2.UpdateAirtimeReminderRequest request);
  $async.Future<$2.DeleteAirtimeReminderResponse> deleteAirtimeReminder(
      $pb.ServerContext ctx, $2.DeleteAirtimeReminderRequest request);
  $async.Future<$2.MarkAirtimeReminderCompleteResponse>
      markAirtimeReminderComplete(
          $pb.ServerContext ctx, $2.MarkAirtimeReminderCompleteRequest request);
  $async.Future<$2.GetAirtimePaymentReceiptResponse> getAirtimePaymentReceipt(
      $pb.ServerContext ctx, $2.GetAirtimePaymentReceiptRequest request);
  $async.Future<$2.SaveDataBeneficiaryResponse> saveDataBeneficiary(
      $pb.ServerContext ctx, $2.SaveDataBeneficiaryRequest request);
  $async.Future<$2.GetDataBeneficiariesResponse> getDataBeneficiaries(
      $pb.ServerContext ctx, $2.GetDataBeneficiariesRequest request);
  $async.Future<$2.UpdateDataBeneficiaryResponse> updateDataBeneficiary(
      $pb.ServerContext ctx, $2.UpdateDataBeneficiaryRequest request);
  $async.Future<$2.DeleteDataBeneficiaryResponse> deleteDataBeneficiary(
      $pb.ServerContext ctx, $2.DeleteDataBeneficiaryRequest request);
  $async.Future<$2.CreateDataAutoRechargeResponse> createDataAutoRecharge(
      $pb.ServerContext ctx, $2.CreateDataAutoRechargeRequest request);
  $async.Future<$2.GetDataAutoRechargesResponse> getDataAutoRecharges(
      $pb.ServerContext ctx, $2.GetDataAutoRechargesRequest request);
  $async.Future<$2.UpdateDataAutoRechargeResponse> updateDataAutoRecharge(
      $pb.ServerContext ctx, $2.UpdateDataAutoRechargeRequest request);
  $async.Future<$2.DeleteDataAutoRechargeResponse> deleteDataAutoRecharge(
      $pb.ServerContext ctx, $2.DeleteDataAutoRechargeRequest request);
  $async.Future<$2.PauseDataAutoRechargeResponse> pauseDataAutoRecharge(
      $pb.ServerContext ctx, $2.PauseDataAutoRechargeRequest request);
  $async.Future<$2.ResumeDataAutoRechargeResponse> resumeDataAutoRecharge(
      $pb.ServerContext ctx, $2.ResumeDataAutoRechargeRequest request);
  $async.Future<$2.CreateDataReminderResponse> createDataReminder(
      $pb.ServerContext ctx, $2.CreateDataReminderRequest request);
  $async.Future<$2.GetDataRemindersResponse> getDataReminders(
      $pb.ServerContext ctx, $2.GetDataRemindersRequest request);
  $async.Future<$2.UpdateDataReminderResponse> updateDataReminder(
      $pb.ServerContext ctx, $2.UpdateDataReminderRequest request);
  $async.Future<$2.DeleteDataReminderResponse> deleteDataReminder(
      $pb.ServerContext ctx, $2.DeleteDataReminderRequest request);
  $async.Future<$2.MarkDataReminderCompleteResponse> markDataReminderComplete(
      $pb.ServerContext ctx, $2.MarkDataReminderCompleteRequest request);
  $async.Future<$2.SaveCableTVBeneficiaryResponse> saveCableTVBeneficiary(
      $pb.ServerContext ctx, $2.SaveCableTVBeneficiaryRequest request);
  $async.Future<$2.GetCableTVBeneficiariesResponse> getCableTVBeneficiaries(
      $pb.ServerContext ctx, $2.GetCableTVBeneficiariesRequest request);
  $async.Future<$2.UpdateCableTVBeneficiaryResponse> updateCableTVBeneficiary(
      $pb.ServerContext ctx, $2.UpdateCableTVBeneficiaryRequest request);
  $async.Future<$2.DeleteCableTVBeneficiaryResponse> deleteCableTVBeneficiary(
      $pb.ServerContext ctx, $2.DeleteCableTVBeneficiaryRequest request);
  $async.Future<$2.CreateCableTVAutoRechargeResponse> createCableTVAutoRecharge(
      $pb.ServerContext ctx, $2.CreateCableTVAutoRechargeRequest request);
  $async.Future<$2.GetCableTVAutoRechargesResponse> getCableTVAutoRecharges(
      $pb.ServerContext ctx, $2.GetCableTVAutoRechargesRequest request);
  $async.Future<$2.UpdateCableTVAutoRechargeResponse> updateCableTVAutoRecharge(
      $pb.ServerContext ctx, $2.UpdateCableTVAutoRechargeRequest request);
  $async.Future<$2.DeleteCableTVAutoRechargeResponse> deleteCableTVAutoRecharge(
      $pb.ServerContext ctx, $2.DeleteCableTVAutoRechargeRequest request);
  $async.Future<$2.PauseCableTVAutoRechargeResponse> pauseCableTVAutoRecharge(
      $pb.ServerContext ctx, $2.PauseCableTVAutoRechargeRequest request);
  $async.Future<$2.ResumeCableTVAutoRechargeResponse> resumeCableTVAutoRecharge(
      $pb.ServerContext ctx, $2.ResumeCableTVAutoRechargeRequest request);
  $async.Future<$2.CreateCableTVReminderResponse> createCableTVReminder(
      $pb.ServerContext ctx, $2.CreateCableTVReminderRequest request);
  $async.Future<$2.GetCableTVRemindersResponse> getCableTVReminders(
      $pb.ServerContext ctx, $2.GetCableTVRemindersRequest request);
  $async.Future<$2.UpdateCableTVReminderResponse> updateCableTVReminder(
      $pb.ServerContext ctx, $2.UpdateCableTVReminderRequest request);
  $async.Future<$2.DeleteCableTVReminderResponse> deleteCableTVReminder(
      $pb.ServerContext ctx, $2.DeleteCableTVReminderRequest request);
  $async.Future<$2.MarkCableTVReminderCompleteResponse>
      markCableTVReminderComplete(
          $pb.ServerContext ctx, $2.MarkCableTVReminderCompleteRequest request);
  $async.Future<$2.GetWaterProvidersResponse> getWaterProviders(
      $pb.ServerContext ctx, $2.GetWaterProvidersRequest request);
  $async.Future<$2.SaveWaterBeneficiaryResponse> saveWaterBeneficiary(
      $pb.ServerContext ctx, $2.SaveWaterBeneficiaryRequest request);
  $async.Future<$2.GetWaterBeneficiariesResponse> getWaterBeneficiaries(
      $pb.ServerContext ctx, $2.GetWaterBeneficiariesRequest request);
  $async.Future<$2.UpdateWaterBeneficiaryResponse> updateWaterBeneficiary(
      $pb.ServerContext ctx, $2.UpdateWaterBeneficiaryRequest request);
  $async.Future<$2.DeleteWaterBeneficiaryResponse> deleteWaterBeneficiary(
      $pb.ServerContext ctx, $2.DeleteWaterBeneficiaryRequest request);
  $async.Future<$2.CreateWaterAutoRechargeResponse> createWaterAutoRecharge(
      $pb.ServerContext ctx, $2.CreateWaterAutoRechargeRequest request);
  $async.Future<$2.GetWaterAutoRechargesResponse> getWaterAutoRecharges(
      $pb.ServerContext ctx, $2.GetWaterAutoRechargesRequest request);
  $async.Future<$2.UpdateWaterAutoRechargeResponse> updateWaterAutoRecharge(
      $pb.ServerContext ctx, $2.UpdateWaterAutoRechargeRequest request);
  $async.Future<$2.DeleteWaterAutoRechargeResponse> deleteWaterAutoRecharge(
      $pb.ServerContext ctx, $2.DeleteWaterAutoRechargeRequest request);
  $async.Future<$2.PauseWaterAutoRechargeResponse> pauseWaterAutoRecharge(
      $pb.ServerContext ctx, $2.PauseWaterAutoRechargeRequest request);
  $async.Future<$2.ResumeWaterAutoRechargeResponse> resumeWaterAutoRecharge(
      $pb.ServerContext ctx, $2.ResumeWaterAutoRechargeRequest request);
  $async.Future<$2.CreateWaterReminderResponse> createWaterReminder(
      $pb.ServerContext ctx, $2.CreateWaterReminderRequest request);
  $async.Future<$2.GetWaterRemindersResponse> getWaterReminders(
      $pb.ServerContext ctx, $2.GetWaterRemindersRequest request);
  $async.Future<$2.UpdateWaterReminderResponse> updateWaterReminder(
      $pb.ServerContext ctx, $2.UpdateWaterReminderRequest request);
  $async.Future<$2.DeleteWaterReminderResponse> deleteWaterReminder(
      $pb.ServerContext ctx, $2.DeleteWaterReminderRequest request);
  $async.Future<$2.MarkWaterReminderCompleteResponse> markWaterReminderComplete(
      $pb.ServerContext ctx, $2.MarkWaterReminderCompleteRequest request);
  $async.Future<$2.GetAsyncPaymentConfigResponse> getAsyncPaymentConfig(
      $pb.ServerContext ctx, $2.GetAsyncPaymentConfigRequest request);
  $async.Future<$2.UpdateAsyncPaymentConfigResponse> updateAsyncPaymentConfig(
      $pb.ServerContext ctx, $2.UpdateAsyncPaymentConfigRequest request);
  $async.Future<$2.GetIntlAirtimeCountriesResponse> getIntlAirtimeCountries(
      $pb.ServerContext ctx, $2.GetIntlAirtimeCountriesRequest request);
  $async.Future<$2.GetIntlAirtimeOperatorsResponse> getIntlAirtimeOperators(
      $pb.ServerContext ctx, $2.GetIntlAirtimeOperatorsRequest request);
  $async.Future<$2.AutoDetectIntlOperatorResponse> autoDetectIntlOperator(
      $pb.ServerContext ctx, $2.AutoDetectIntlOperatorRequest request);
  $async.Future<$2.BuyIntlAirtimeResponse> buyIntlAirtime(
      $pb.ServerContext ctx, $2.BuyIntlAirtimeRequest request);
  $async.Future<$2.GetIntlDataOperatorsResponse> getIntlDataOperators(
      $pb.ServerContext ctx, $2.GetIntlDataOperatorsRequest request);
  $async.Future<$2.GetIntlDataBundlesResponse> getIntlDataBundles(
      $pb.ServerContext ctx, $2.GetIntlDataBundlesRequest request);
  $async.Future<$2.BuyIntlDataResponse> buyIntlData(
      $pb.ServerContext ctx, $2.BuyIntlDataRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'PayElectricityBill':
        return $2.PayElectricityBillRequest();
      case 'PayWaterBill':
        return $2.PayWaterBillRequest();
      case 'PayInternetBill':
        return $2.PayInternetBillRequest();
      case 'BuyAirtime':
        return $2.BuyAirtimeRequest();
      case 'BuyData':
        return $2.BuyDataRequest();
      case 'GetDataPlans':
        return $2.GetDataPlansRequest();
      case 'BarcodePay':
        return $2.BarcodePayRequest();
      case 'ScanToPay':
        return $2.ScanToPayRequest();
      case 'GetBillPaymentHistory':
        return $2.GetBillPaymentHistoryRequest();
      case 'GetBillProviders':
        return $2.GetBillProvidersRequest();
      case 'GetAirtimeProviders':
        return $2.GetAirtimeProvidersRequest();
      case 'VerifyBill':
        return $2.VerifyBillRequest();
      case 'ValidateSmartCard':
        return $2.ValidateSmartCardRequest();
      case 'GetTVPackages':
        return $2.GetTVPackagesRequest();
      case 'PayCableTVBill':
        return $2.PayCableTVBillRequest();
      case 'GetCableTVProviders':
        return $2.GetCableTVProvidersRequest();
      case 'GetInternetProviders':
        return $2.GetInternetProvidersRequest();
      case 'ValidateInternetAccount':
        return $2.ValidateInternetAccountRequest();
      case 'GetInternetPackages':
        return $2.GetInternetPackagesRequest();
      case 'PurchaseEducationPin':
        return $2.PurchaseEducationPinRequest();
      case 'GetEducationProviders':
        return $2.GetEducationProvidersRequest();
      case 'SaveEducationBeneficiary':
        return $2.SaveEducationBeneficiaryRequest();
      case 'GetEducationBeneficiaries':
        return $2.GetEducationBeneficiariesRequest();
      case 'UpdateEducationBeneficiary':
        return $2.UpdateEducationBeneficiaryRequest();
      case 'DeleteEducationBeneficiary':
        return $2.DeleteEducationBeneficiaryRequest();
      case 'CreateEducationReminder':
        return $2.CreateEducationReminderRequest();
      case 'GetEducationReminders':
        return $2.GetEducationRemindersRequest();
      case 'UpdateEducationReminder':
        return $2.UpdateEducationReminderRequest();
      case 'DeleteEducationReminder':
        return $2.DeleteEducationReminderRequest();
      case 'MarkEducationReminderComplete':
        return $2.MarkEducationReminderCompleteRequest();
      case 'GetActiveSubscriptions':
        return $2.GetActiveSubscriptionsRequest();
      case 'GetSubscriptionSummary':
        return $2.GetSubscriptionSummaryRequest();
      case 'GetSubscriptionSpending':
        return $2.GetSubscriptionSpendingRequest();
      case 'EnableAutoRenew':
        return $2.EnableAutoRenewRequest();
      case 'DisableAutoRenew':
        return $2.DisableAutoRenewRequest();
      case 'GetAutoRenewSubscriptions':
        return $2.GetAutoRenewSubscriptionsRequest();
      case 'UpdateAutoRenewPlan':
        return $2.UpdateAutoRenewPlanRequest();
      case 'GetAirtimeToCashRates':
        return $2.GetAirtimeToCashRatesRequest();
      case 'RequestAirtimeToCashOTP':
        return $2.RequestAirtimeToCashOTPRequest();
      case 'VerifyAirtimeToCashOTP':
        return $2.VerifyAirtimeToCashOTPRequest();
      case 'ConvertAirtimeToCash':
        return $2.ConvertAirtimeToCashRequest();
      case 'GetAirtimeToCashHistory':
        return $2.GetAirtimeToCashHistoryRequest();
      case 'VerifyAirtimeToCashService':
        return $2.VerifyAirtimeToCashServiceRequest();
      case 'GetAirtimeToCashProviderInfo':
        return $2.GetAirtimeToCashProviderInfoRequest();
      case 'CheckAirtimeToCashQuota':
        return $2.CheckAirtimeToCashQuotaRequest();
      case 'SaveAirtimeBeneficiary':
        return $2.SaveAirtimeBeneficiaryRequest();
      case 'GetAirtimeBeneficiaries':
        return $2.GetAirtimeBeneficiariesRequest();
      case 'UpdateAirtimeBeneficiary':
        return $2.UpdateAirtimeBeneficiaryRequest();
      case 'DeleteAirtimeBeneficiary':
        return $2.DeleteAirtimeBeneficiaryRequest();
      case 'CreateAirtimeAutoRecharge':
        return $2.CreateAirtimeAutoRechargeRequest();
      case 'GetAirtimeAutoRecharges':
        return $2.GetAirtimeAutoRechargesRequest();
      case 'UpdateAirtimeAutoRecharge':
        return $2.UpdateAirtimeAutoRechargeRequest();
      case 'DeleteAirtimeAutoRecharge':
        return $2.DeleteAirtimeAutoRechargeRequest();
      case 'PauseAirtimeAutoRecharge':
        return $2.PauseAirtimeAutoRechargeRequest();
      case 'ResumeAirtimeAutoRecharge':
        return $2.ResumeAirtimeAutoRechargeRequest();
      case 'CreateAirtimeReminder':
        return $2.CreateAirtimeReminderRequest();
      case 'GetAirtimeReminders':
        return $2.GetAirtimeRemindersRequest();
      case 'UpdateAirtimeReminder':
        return $2.UpdateAirtimeReminderRequest();
      case 'DeleteAirtimeReminder':
        return $2.DeleteAirtimeReminderRequest();
      case 'MarkAirtimeReminderComplete':
        return $2.MarkAirtimeReminderCompleteRequest();
      case 'GetAirtimePaymentReceipt':
        return $2.GetAirtimePaymentReceiptRequest();
      case 'SaveDataBeneficiary':
        return $2.SaveDataBeneficiaryRequest();
      case 'GetDataBeneficiaries':
        return $2.GetDataBeneficiariesRequest();
      case 'UpdateDataBeneficiary':
        return $2.UpdateDataBeneficiaryRequest();
      case 'DeleteDataBeneficiary':
        return $2.DeleteDataBeneficiaryRequest();
      case 'CreateDataAutoRecharge':
        return $2.CreateDataAutoRechargeRequest();
      case 'GetDataAutoRecharges':
        return $2.GetDataAutoRechargesRequest();
      case 'UpdateDataAutoRecharge':
        return $2.UpdateDataAutoRechargeRequest();
      case 'DeleteDataAutoRecharge':
        return $2.DeleteDataAutoRechargeRequest();
      case 'PauseDataAutoRecharge':
        return $2.PauseDataAutoRechargeRequest();
      case 'ResumeDataAutoRecharge':
        return $2.ResumeDataAutoRechargeRequest();
      case 'CreateDataReminder':
        return $2.CreateDataReminderRequest();
      case 'GetDataReminders':
        return $2.GetDataRemindersRequest();
      case 'UpdateDataReminder':
        return $2.UpdateDataReminderRequest();
      case 'DeleteDataReminder':
        return $2.DeleteDataReminderRequest();
      case 'MarkDataReminderComplete':
        return $2.MarkDataReminderCompleteRequest();
      case 'SaveCableTVBeneficiary':
        return $2.SaveCableTVBeneficiaryRequest();
      case 'GetCableTVBeneficiaries':
        return $2.GetCableTVBeneficiariesRequest();
      case 'UpdateCableTVBeneficiary':
        return $2.UpdateCableTVBeneficiaryRequest();
      case 'DeleteCableTVBeneficiary':
        return $2.DeleteCableTVBeneficiaryRequest();
      case 'CreateCableTVAutoRecharge':
        return $2.CreateCableTVAutoRechargeRequest();
      case 'GetCableTVAutoRecharges':
        return $2.GetCableTVAutoRechargesRequest();
      case 'UpdateCableTVAutoRecharge':
        return $2.UpdateCableTVAutoRechargeRequest();
      case 'DeleteCableTVAutoRecharge':
        return $2.DeleteCableTVAutoRechargeRequest();
      case 'PauseCableTVAutoRecharge':
        return $2.PauseCableTVAutoRechargeRequest();
      case 'ResumeCableTVAutoRecharge':
        return $2.ResumeCableTVAutoRechargeRequest();
      case 'CreateCableTVReminder':
        return $2.CreateCableTVReminderRequest();
      case 'GetCableTVReminders':
        return $2.GetCableTVRemindersRequest();
      case 'UpdateCableTVReminder':
        return $2.UpdateCableTVReminderRequest();
      case 'DeleteCableTVReminder':
        return $2.DeleteCableTVReminderRequest();
      case 'MarkCableTVReminderComplete':
        return $2.MarkCableTVReminderCompleteRequest();
      case 'GetWaterProviders':
        return $2.GetWaterProvidersRequest();
      case 'SaveWaterBeneficiary':
        return $2.SaveWaterBeneficiaryRequest();
      case 'GetWaterBeneficiaries':
        return $2.GetWaterBeneficiariesRequest();
      case 'UpdateWaterBeneficiary':
        return $2.UpdateWaterBeneficiaryRequest();
      case 'DeleteWaterBeneficiary':
        return $2.DeleteWaterBeneficiaryRequest();
      case 'CreateWaterAutoRecharge':
        return $2.CreateWaterAutoRechargeRequest();
      case 'GetWaterAutoRecharges':
        return $2.GetWaterAutoRechargesRequest();
      case 'UpdateWaterAutoRecharge':
        return $2.UpdateWaterAutoRechargeRequest();
      case 'DeleteWaterAutoRecharge':
        return $2.DeleteWaterAutoRechargeRequest();
      case 'PauseWaterAutoRecharge':
        return $2.PauseWaterAutoRechargeRequest();
      case 'ResumeWaterAutoRecharge':
        return $2.ResumeWaterAutoRechargeRequest();
      case 'CreateWaterReminder':
        return $2.CreateWaterReminderRequest();
      case 'GetWaterReminders':
        return $2.GetWaterRemindersRequest();
      case 'UpdateWaterReminder':
        return $2.UpdateWaterReminderRequest();
      case 'DeleteWaterReminder':
        return $2.DeleteWaterReminderRequest();
      case 'MarkWaterReminderComplete':
        return $2.MarkWaterReminderCompleteRequest();
      case 'GetAsyncPaymentConfig':
        return $2.GetAsyncPaymentConfigRequest();
      case 'UpdateAsyncPaymentConfig':
        return $2.UpdateAsyncPaymentConfigRequest();
      case 'GetIntlAirtimeCountries':
        return $2.GetIntlAirtimeCountriesRequest();
      case 'GetIntlAirtimeOperators':
        return $2.GetIntlAirtimeOperatorsRequest();
      case 'AutoDetectIntlOperator':
        return $2.AutoDetectIntlOperatorRequest();
      case 'BuyIntlAirtime':
        return $2.BuyIntlAirtimeRequest();
      case 'GetIntlDataOperators':
        return $2.GetIntlDataOperatorsRequest();
      case 'GetIntlDataBundles':
        return $2.GetIntlDataBundlesRequest();
      case 'BuyIntlData':
        return $2.BuyIntlDataRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'PayElectricityBill':
        return payElectricityBill(ctx, request as $2.PayElectricityBillRequest);
      case 'PayWaterBill':
        return payWaterBill(ctx, request as $2.PayWaterBillRequest);
      case 'PayInternetBill':
        return payInternetBill(ctx, request as $2.PayInternetBillRequest);
      case 'BuyAirtime':
        return buyAirtime(ctx, request as $2.BuyAirtimeRequest);
      case 'BuyData':
        return buyData(ctx, request as $2.BuyDataRequest);
      case 'GetDataPlans':
        return getDataPlans(ctx, request as $2.GetDataPlansRequest);
      case 'BarcodePay':
        return barcodePay(ctx, request as $2.BarcodePayRequest);
      case 'ScanToPay':
        return scanToPay(ctx, request as $2.ScanToPayRequest);
      case 'GetBillPaymentHistory':
        return getBillPaymentHistory(
            ctx, request as $2.GetBillPaymentHistoryRequest);
      case 'GetBillProviders':
        return getBillProviders(ctx, request as $2.GetBillProvidersRequest);
      case 'GetAirtimeProviders':
        return getAirtimeProviders(
            ctx, request as $2.GetAirtimeProvidersRequest);
      case 'VerifyBill':
        return verifyBill(ctx, request as $2.VerifyBillRequest);
      case 'ValidateSmartCard':
        return validateSmartCard(ctx, request as $2.ValidateSmartCardRequest);
      case 'GetTVPackages':
        return getTVPackages(ctx, request as $2.GetTVPackagesRequest);
      case 'PayCableTVBill':
        return payCableTVBill(ctx, request as $2.PayCableTVBillRequest);
      case 'GetCableTVProviders':
        return getCableTVProviders(
            ctx, request as $2.GetCableTVProvidersRequest);
      case 'GetInternetProviders':
        return getInternetProviders(
            ctx, request as $2.GetInternetProvidersRequest);
      case 'ValidateInternetAccount':
        return validateInternetAccount(
            ctx, request as $2.ValidateInternetAccountRequest);
      case 'GetInternetPackages':
        return getInternetPackages(
            ctx, request as $2.GetInternetPackagesRequest);
      case 'PurchaseEducationPin':
        return purchaseEducationPin(
            ctx, request as $2.PurchaseEducationPinRequest);
      case 'GetEducationProviders':
        return getEducationProviders(
            ctx, request as $2.GetEducationProvidersRequest);
      case 'SaveEducationBeneficiary':
        return saveEducationBeneficiary(
            ctx, request as $2.SaveEducationBeneficiaryRequest);
      case 'GetEducationBeneficiaries':
        return getEducationBeneficiaries(
            ctx, request as $2.GetEducationBeneficiariesRequest);
      case 'UpdateEducationBeneficiary':
        return updateEducationBeneficiary(
            ctx, request as $2.UpdateEducationBeneficiaryRequest);
      case 'DeleteEducationBeneficiary':
        return deleteEducationBeneficiary(
            ctx, request as $2.DeleteEducationBeneficiaryRequest);
      case 'CreateEducationReminder':
        return createEducationReminder(
            ctx, request as $2.CreateEducationReminderRequest);
      case 'GetEducationReminders':
        return getEducationReminders(
            ctx, request as $2.GetEducationRemindersRequest);
      case 'UpdateEducationReminder':
        return updateEducationReminder(
            ctx, request as $2.UpdateEducationReminderRequest);
      case 'DeleteEducationReminder':
        return deleteEducationReminder(
            ctx, request as $2.DeleteEducationReminderRequest);
      case 'MarkEducationReminderComplete':
        return markEducationReminderComplete(
            ctx, request as $2.MarkEducationReminderCompleteRequest);
      case 'GetActiveSubscriptions':
        return getActiveSubscriptions(
            ctx, request as $2.GetActiveSubscriptionsRequest);
      case 'GetSubscriptionSummary':
        return getSubscriptionSummary(
            ctx, request as $2.GetSubscriptionSummaryRequest);
      case 'GetSubscriptionSpending':
        return getSubscriptionSpending(
            ctx, request as $2.GetSubscriptionSpendingRequest);
      case 'EnableAutoRenew':
        return enableAutoRenew(ctx, request as $2.EnableAutoRenewRequest);
      case 'DisableAutoRenew':
        return disableAutoRenew(ctx, request as $2.DisableAutoRenewRequest);
      case 'GetAutoRenewSubscriptions':
        return getAutoRenewSubscriptions(
            ctx, request as $2.GetAutoRenewSubscriptionsRequest);
      case 'UpdateAutoRenewPlan':
        return updateAutoRenewPlan(
            ctx, request as $2.UpdateAutoRenewPlanRequest);
      case 'GetAirtimeToCashRates':
        return getAirtimeToCashRates(
            ctx, request as $2.GetAirtimeToCashRatesRequest);
      case 'RequestAirtimeToCashOTP':
        return requestAirtimeToCashOTP(
            ctx, request as $2.RequestAirtimeToCashOTPRequest);
      case 'VerifyAirtimeToCashOTP':
        return verifyAirtimeToCashOTP(
            ctx, request as $2.VerifyAirtimeToCashOTPRequest);
      case 'ConvertAirtimeToCash':
        return convertAirtimeToCash(
            ctx, request as $2.ConvertAirtimeToCashRequest);
      case 'GetAirtimeToCashHistory':
        return getAirtimeToCashHistory(
            ctx, request as $2.GetAirtimeToCashHistoryRequest);
      case 'VerifyAirtimeToCashService':
        return verifyAirtimeToCashService(
            ctx, request as $2.VerifyAirtimeToCashServiceRequest);
      case 'GetAirtimeToCashProviderInfo':
        return getAirtimeToCashProviderInfo(
            ctx, request as $2.GetAirtimeToCashProviderInfoRequest);
      case 'CheckAirtimeToCashQuota':
        return checkAirtimeToCashQuota(
            ctx, request as $2.CheckAirtimeToCashQuotaRequest);
      case 'SaveAirtimeBeneficiary':
        return saveAirtimeBeneficiary(
            ctx, request as $2.SaveAirtimeBeneficiaryRequest);
      case 'GetAirtimeBeneficiaries':
        return getAirtimeBeneficiaries(
            ctx, request as $2.GetAirtimeBeneficiariesRequest);
      case 'UpdateAirtimeBeneficiary':
        return updateAirtimeBeneficiary(
            ctx, request as $2.UpdateAirtimeBeneficiaryRequest);
      case 'DeleteAirtimeBeneficiary':
        return deleteAirtimeBeneficiary(
            ctx, request as $2.DeleteAirtimeBeneficiaryRequest);
      case 'CreateAirtimeAutoRecharge':
        return createAirtimeAutoRecharge(
            ctx, request as $2.CreateAirtimeAutoRechargeRequest);
      case 'GetAirtimeAutoRecharges':
        return getAirtimeAutoRecharges(
            ctx, request as $2.GetAirtimeAutoRechargesRequest);
      case 'UpdateAirtimeAutoRecharge':
        return updateAirtimeAutoRecharge(
            ctx, request as $2.UpdateAirtimeAutoRechargeRequest);
      case 'DeleteAirtimeAutoRecharge':
        return deleteAirtimeAutoRecharge(
            ctx, request as $2.DeleteAirtimeAutoRechargeRequest);
      case 'PauseAirtimeAutoRecharge':
        return pauseAirtimeAutoRecharge(
            ctx, request as $2.PauseAirtimeAutoRechargeRequest);
      case 'ResumeAirtimeAutoRecharge':
        return resumeAirtimeAutoRecharge(
            ctx, request as $2.ResumeAirtimeAutoRechargeRequest);
      case 'CreateAirtimeReminder':
        return createAirtimeReminder(
            ctx, request as $2.CreateAirtimeReminderRequest);
      case 'GetAirtimeReminders':
        return getAirtimeReminders(
            ctx, request as $2.GetAirtimeRemindersRequest);
      case 'UpdateAirtimeReminder':
        return updateAirtimeReminder(
            ctx, request as $2.UpdateAirtimeReminderRequest);
      case 'DeleteAirtimeReminder':
        return deleteAirtimeReminder(
            ctx, request as $2.DeleteAirtimeReminderRequest);
      case 'MarkAirtimeReminderComplete':
        return markAirtimeReminderComplete(
            ctx, request as $2.MarkAirtimeReminderCompleteRequest);
      case 'GetAirtimePaymentReceipt':
        return getAirtimePaymentReceipt(
            ctx, request as $2.GetAirtimePaymentReceiptRequest);
      case 'SaveDataBeneficiary':
        return saveDataBeneficiary(
            ctx, request as $2.SaveDataBeneficiaryRequest);
      case 'GetDataBeneficiaries':
        return getDataBeneficiaries(
            ctx, request as $2.GetDataBeneficiariesRequest);
      case 'UpdateDataBeneficiary':
        return updateDataBeneficiary(
            ctx, request as $2.UpdateDataBeneficiaryRequest);
      case 'DeleteDataBeneficiary':
        return deleteDataBeneficiary(
            ctx, request as $2.DeleteDataBeneficiaryRequest);
      case 'CreateDataAutoRecharge':
        return createDataAutoRecharge(
            ctx, request as $2.CreateDataAutoRechargeRequest);
      case 'GetDataAutoRecharges':
        return getDataAutoRecharges(
            ctx, request as $2.GetDataAutoRechargesRequest);
      case 'UpdateDataAutoRecharge':
        return updateDataAutoRecharge(
            ctx, request as $2.UpdateDataAutoRechargeRequest);
      case 'DeleteDataAutoRecharge':
        return deleteDataAutoRecharge(
            ctx, request as $2.DeleteDataAutoRechargeRequest);
      case 'PauseDataAutoRecharge':
        return pauseDataAutoRecharge(
            ctx, request as $2.PauseDataAutoRechargeRequest);
      case 'ResumeDataAutoRecharge':
        return resumeDataAutoRecharge(
            ctx, request as $2.ResumeDataAutoRechargeRequest);
      case 'CreateDataReminder':
        return createDataReminder(ctx, request as $2.CreateDataReminderRequest);
      case 'GetDataReminders':
        return getDataReminders(ctx, request as $2.GetDataRemindersRequest);
      case 'UpdateDataReminder':
        return updateDataReminder(ctx, request as $2.UpdateDataReminderRequest);
      case 'DeleteDataReminder':
        return deleteDataReminder(ctx, request as $2.DeleteDataReminderRequest);
      case 'MarkDataReminderComplete':
        return markDataReminderComplete(
            ctx, request as $2.MarkDataReminderCompleteRequest);
      case 'SaveCableTVBeneficiary':
        return saveCableTVBeneficiary(
            ctx, request as $2.SaveCableTVBeneficiaryRequest);
      case 'GetCableTVBeneficiaries':
        return getCableTVBeneficiaries(
            ctx, request as $2.GetCableTVBeneficiariesRequest);
      case 'UpdateCableTVBeneficiary':
        return updateCableTVBeneficiary(
            ctx, request as $2.UpdateCableTVBeneficiaryRequest);
      case 'DeleteCableTVBeneficiary':
        return deleteCableTVBeneficiary(
            ctx, request as $2.DeleteCableTVBeneficiaryRequest);
      case 'CreateCableTVAutoRecharge':
        return createCableTVAutoRecharge(
            ctx, request as $2.CreateCableTVAutoRechargeRequest);
      case 'GetCableTVAutoRecharges':
        return getCableTVAutoRecharges(
            ctx, request as $2.GetCableTVAutoRechargesRequest);
      case 'UpdateCableTVAutoRecharge':
        return updateCableTVAutoRecharge(
            ctx, request as $2.UpdateCableTVAutoRechargeRequest);
      case 'DeleteCableTVAutoRecharge':
        return deleteCableTVAutoRecharge(
            ctx, request as $2.DeleteCableTVAutoRechargeRequest);
      case 'PauseCableTVAutoRecharge':
        return pauseCableTVAutoRecharge(
            ctx, request as $2.PauseCableTVAutoRechargeRequest);
      case 'ResumeCableTVAutoRecharge':
        return resumeCableTVAutoRecharge(
            ctx, request as $2.ResumeCableTVAutoRechargeRequest);
      case 'CreateCableTVReminder':
        return createCableTVReminder(
            ctx, request as $2.CreateCableTVReminderRequest);
      case 'GetCableTVReminders':
        return getCableTVReminders(
            ctx, request as $2.GetCableTVRemindersRequest);
      case 'UpdateCableTVReminder':
        return updateCableTVReminder(
            ctx, request as $2.UpdateCableTVReminderRequest);
      case 'DeleteCableTVReminder':
        return deleteCableTVReminder(
            ctx, request as $2.DeleteCableTVReminderRequest);
      case 'MarkCableTVReminderComplete':
        return markCableTVReminderComplete(
            ctx, request as $2.MarkCableTVReminderCompleteRequest);
      case 'GetWaterProviders':
        return getWaterProviders(ctx, request as $2.GetWaterProvidersRequest);
      case 'SaveWaterBeneficiary':
        return saveWaterBeneficiary(
            ctx, request as $2.SaveWaterBeneficiaryRequest);
      case 'GetWaterBeneficiaries':
        return getWaterBeneficiaries(
            ctx, request as $2.GetWaterBeneficiariesRequest);
      case 'UpdateWaterBeneficiary':
        return updateWaterBeneficiary(
            ctx, request as $2.UpdateWaterBeneficiaryRequest);
      case 'DeleteWaterBeneficiary':
        return deleteWaterBeneficiary(
            ctx, request as $2.DeleteWaterBeneficiaryRequest);
      case 'CreateWaterAutoRecharge':
        return createWaterAutoRecharge(
            ctx, request as $2.CreateWaterAutoRechargeRequest);
      case 'GetWaterAutoRecharges':
        return getWaterAutoRecharges(
            ctx, request as $2.GetWaterAutoRechargesRequest);
      case 'UpdateWaterAutoRecharge':
        return updateWaterAutoRecharge(
            ctx, request as $2.UpdateWaterAutoRechargeRequest);
      case 'DeleteWaterAutoRecharge':
        return deleteWaterAutoRecharge(
            ctx, request as $2.DeleteWaterAutoRechargeRequest);
      case 'PauseWaterAutoRecharge':
        return pauseWaterAutoRecharge(
            ctx, request as $2.PauseWaterAutoRechargeRequest);
      case 'ResumeWaterAutoRecharge':
        return resumeWaterAutoRecharge(
            ctx, request as $2.ResumeWaterAutoRechargeRequest);
      case 'CreateWaterReminder':
        return createWaterReminder(
            ctx, request as $2.CreateWaterReminderRequest);
      case 'GetWaterReminders':
        return getWaterReminders(ctx, request as $2.GetWaterRemindersRequest);
      case 'UpdateWaterReminder':
        return updateWaterReminder(
            ctx, request as $2.UpdateWaterReminderRequest);
      case 'DeleteWaterReminder':
        return deleteWaterReminder(
            ctx, request as $2.DeleteWaterReminderRequest);
      case 'MarkWaterReminderComplete':
        return markWaterReminderComplete(
            ctx, request as $2.MarkWaterReminderCompleteRequest);
      case 'GetAsyncPaymentConfig':
        return getAsyncPaymentConfig(
            ctx, request as $2.GetAsyncPaymentConfigRequest);
      case 'UpdateAsyncPaymentConfig':
        return updateAsyncPaymentConfig(
            ctx, request as $2.UpdateAsyncPaymentConfigRequest);
      case 'GetIntlAirtimeCountries':
        return getIntlAirtimeCountries(
            ctx, request as $2.GetIntlAirtimeCountriesRequest);
      case 'GetIntlAirtimeOperators':
        return getIntlAirtimeOperators(
            ctx, request as $2.GetIntlAirtimeOperatorsRequest);
      case 'AutoDetectIntlOperator':
        return autoDetectIntlOperator(
            ctx, request as $2.AutoDetectIntlOperatorRequest);
      case 'BuyIntlAirtime':
        return buyIntlAirtime(ctx, request as $2.BuyIntlAirtimeRequest);
      case 'GetIntlDataOperators':
        return getIntlDataOperators(
            ctx, request as $2.GetIntlDataOperatorsRequest);
      case 'GetIntlDataBundles':
        return getIntlDataBundles(ctx, request as $2.GetIntlDataBundlesRequest);
      case 'BuyIntlData':
        return buyIntlData(ctx, request as $2.BuyIntlDataRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      UtilityPaymentsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => UtilityPaymentsServiceBase$messageJson;
}
