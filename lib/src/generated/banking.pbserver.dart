///
//  Generated code. Do not modify.
//  source: banking.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'banking.pb.dart' as $1;
import 'banking.pbjson.dart';

export 'banking.pb.dart';

abstract class BankingServiceBase extends $pb.GeneratedService {
  $async.Future<$1.VirtualAccountResponse> createVirtualAccount($pb.ServerContext ctx, $1.CreateVirtualAccountRequest request);
  $async.Future<$1.VirtualAccountResponse> getVirtualAccount($pb.ServerContext ctx, $1.GetVirtualAccountRequest request);
  $async.Future<$1.VirtualAccountsResponse> getUserVirtualAccounts($pb.ServerContext ctx, $1.GetUserVirtualAccountsRequest request);
  $async.Future<$1.TransferResponse> initiateDomesticTransfer($pb.ServerContext ctx, $1.DomesticTransferRequest request);
  $async.Future<$1.TransferResponse> getTransferStatus($pb.ServerContext ctx, $1.GetTransferStatusRequest request);
  $async.Future<$1.TransfersResponse> getUserTransfers($pb.ServerContext ctx, $1.GetUserTransfersRequest request);
  $async.Future<$1.TransferResponse> initiateInternalTransfer($pb.ServerContext ctx, $1.InternalTransferRequest request);
  $async.Future<$1.TransferResponse> initiateInternationalTransfer($pb.ServerContext ctx, $1.InternationalTransferRequest request);
  $async.Future<$1.ExchangeRateResponse> getExchangeRate($pb.ServerContext ctx, $1.GetExchangeRateRequest request);
  $async.Future<$1.SupportedCountriesResponse> getSupportedCountries($pb.ServerContext ctx, $1.GetSupportedCountriesRequest request);
  $async.Future<$1.VerifyBankAccountResponse> verifyBankAccount($pb.ServerContext ctx, $1.VerifyBankAccountRequest request);
  $async.Future<$1.BanksResponse> getBanks($pb.ServerContext ctx, $1.GetBanksRequest request);
  $async.Future<$1.IdentityVerificationResponse> verifyBVN($pb.ServerContext ctx, $1.VerifyBVNRequest request);
  $async.Future<$1.IdentityVerificationResponse> getVerificationStatus($pb.ServerContext ctx, $1.GetVerificationStatusRequest request);
  $async.Future<$1.SignupIdentityVerificationResponse> verifyBVNForSignup($pb.ServerContext ctx, $1.VerifyBVNForSignupRequest request);
  $async.Future<$1.SignupIdentityVerificationResponse> verifyNINForSignup($pb.ServerContext ctx, $1.VerifyNINForSignupRequest request);
  $async.Future<$1.VirtualAccountResponse> createVirtualAccountForUser($pb.ServerContext ctx, $1.CreateVirtualAccountForUserRequest request);
  $async.Future<$1.TransferResponse> initiateUsernameTransfer($pb.ServerContext ctx, $1.UsernameTransferRequest request);
  $async.Future<$1.TransferResponse> initiatePhoneTransfer($pb.ServerContext ctx, $1.PhoneTransferRequest request);
  $async.Future<$1.RecipientsResponse> searchRecipients($pb.ServerContext ctx, $1.SearchRecipientsRequest request);
  $async.Future<$1.RecipientsResponse> getRecentRecipients($pb.ServerContext ctx, $1.GetRecentRecipientsRequest request);
  $async.Future<$1.ProviderStatusResponse> getProviderStatus($pb.ServerContext ctx, $1.GetProviderStatusRequest request);
  $async.Future<$1.ActiveProvidersResponse> getActiveProviders($pb.ServerContext ctx, $1.GetActiveProvidersRequest request);
  $async.Future<$1.AccountBalanceResponse> getAccountBalance($pb.ServerContext ctx, $1.GetAccountBalanceRequest request);
  $async.Future<$1.TransactionsResponse> getAccountTransactions($pb.ServerContext ctx, $1.GetAccountTransactionsRequest request);
  $async.Future<$1.VirtualAccountResponse> getPrimaryAccount($pb.ServerContext ctx, $1.GetPrimaryAccountRequest request);
  $async.Future<$1.FreezeAccountResponse> freezeAccount($pb.ServerContext ctx, $1.FreezeAccountRequest request);
  $async.Future<$1.UnfreezeAccountResponse> unfreezeAccount($pb.ServerContext ctx, $1.UnfreezeAccountRequest request);
  $async.Future<$1.DailyUsageResponse> getDailyUsage($pb.ServerContext ctx, $1.GetDailyUsageRequest request);
  $async.Future<$1.ReconciliationResponse> runReconciliation($pb.ServerContext ctx, $1.RunReconciliationRequest request);
  $async.Future<$1.ReconciliationHistoryResponse> getReconciliationHistory($pb.ServerContext ctx, $1.GetReconciliationHistoryRequest request);
  $async.Future<$1.DailyReportResponse> getDailyReport($pb.ServerContext ctx, $1.GetDailyReportRequest request);
  $async.Future<$1.MonoInstitutionsResponse> getMonoInstitutions($pb.ServerContext ctx, $1.GetMonoInstitutionsRequest request);
  $async.Future<$1.ConnectWidgetConfigResponse> getConnectWidgetConfig($pb.ServerContext ctx, $1.GetConnectWidgetConfigRequest request);
  $async.Future<$1.LinkBankAccountResponse> linkBankAccount($pb.ServerContext ctx, $1.LinkBankAccountRequest request);
  $async.Future<$1.LinkedAccountsResponse> getLinkedAccounts($pb.ServerContext ctx, $1.GetLinkedAccountsRequest request);
  $async.Future<$1.LinkedAccountResponse> getLinkedAccount($pb.ServerContext ctx, $1.GetLinkedAccountRequest request);
  $async.Future<$1.UnlinkBankAccountResponse> unlinkBankAccount($pb.ServerContext ctx, $1.UnlinkBankAccountRequest request);
  $async.Future<$1.SetDefaultLinkedAccountResponse> setDefaultLinkedAccount($pb.ServerContext ctx, $1.SetDefaultLinkedAccountRequest request);
  $async.Future<$1.RefreshLinkedAccountBalanceResponse> refreshLinkedAccountBalance($pb.ServerContext ctx, $1.RefreshLinkedAccountBalanceRequest request);
  $async.Future<$1.GetReauthorizationTokenResponse> getReauthorizationToken($pb.ServerContext ctx, $1.GetReauthorizationTokenRequest request);
  $async.Future<$1.DepositResponse> initiateDeposit($pb.ServerContext ctx, $1.InitiateDepositRequest request);
  $async.Future<$1.DepositResponse> getDepositStatus($pb.ServerContext ctx, $1.GetDepositStatusRequest request);
  $async.Future<$1.DepositsResponse> getUserDeposits($pb.ServerContext ctx, $1.GetUserDepositsRequest request);
  $async.Future<$1.CancelDepositResponse> cancelDeposit($pb.ServerContext ctx, $1.CancelDepositRequest request);
  $async.Future<$1.CalculateDepositFeeResponse> calculateDepositFee($pb.ServerContext ctx, $1.CalculateDepositFeeRequest request);
  $async.Future<$1.MandateResponse> createMandate($pb.ServerContext ctx, $1.CreateMandateRequest request);
  $async.Future<$1.MandateResponse> getMandate($pb.ServerContext ctx, $1.GetMandateRequest request);
  $async.Future<$1.MandatesResponse> getUserMandates($pb.ServerContext ctx, $1.GetUserMandatesRequest request);
  $async.Future<$1.PauseMandateResponse> pauseMandate($pb.ServerContext ctx, $1.PauseMandateRequest request);
  $async.Future<$1.ReinstateMandateResponse> reinstateMandate($pb.ServerContext ctx, $1.ReinstateMandateRequest request);
  $async.Future<$1.CancelMandateResponse> cancelMandate($pb.ServerContext ctx, $1.CancelMandateRequest request);
  $async.Future<$1.CheckMandateBalanceResponse> checkMandateBalance($pb.ServerContext ctx, $1.CheckMandateBalanceRequest request);
  $async.Future<$1.WithdrawalResponse> initiateWithdrawal($pb.ServerContext ctx, $1.InitiateWithdrawalRequest request);
  $async.Future<$1.WithdrawalResponse> getWithdrawalStatus($pb.ServerContext ctx, $1.GetWithdrawalStatusRequest request);
  $async.Future<$1.WithdrawalsResponse> getUserWithdrawals($pb.ServerContext ctx, $1.GetUserWithdrawalsRequest request);
  $async.Future<$1.CalculateWithdrawalFeeResponse> calculateWithdrawalFee($pb.ServerContext ctx, $1.CalculateWithdrawalFeeRequest request);
  $async.Future<$1.GetTransferFeeResponse> getTransferFee($pb.ServerContext ctx, $1.GetTransferFeeRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'CreateVirtualAccount': return $1.CreateVirtualAccountRequest();
      case 'GetVirtualAccount': return $1.GetVirtualAccountRequest();
      case 'GetUserVirtualAccounts': return $1.GetUserVirtualAccountsRequest();
      case 'InitiateDomesticTransfer': return $1.DomesticTransferRequest();
      case 'GetTransferStatus': return $1.GetTransferStatusRequest();
      case 'GetUserTransfers': return $1.GetUserTransfersRequest();
      case 'InitiateInternalTransfer': return $1.InternalTransferRequest();
      case 'InitiateInternationalTransfer': return $1.InternationalTransferRequest();
      case 'GetExchangeRate': return $1.GetExchangeRateRequest();
      case 'GetSupportedCountries': return $1.GetSupportedCountriesRequest();
      case 'VerifyBankAccount': return $1.VerifyBankAccountRequest();
      case 'GetBanks': return $1.GetBanksRequest();
      case 'VerifyBVN': return $1.VerifyBVNRequest();
      case 'GetVerificationStatus': return $1.GetVerificationStatusRequest();
      case 'VerifyBVNForSignup': return $1.VerifyBVNForSignupRequest();
      case 'VerifyNINForSignup': return $1.VerifyNINForSignupRequest();
      case 'CreateVirtualAccountForUser': return $1.CreateVirtualAccountForUserRequest();
      case 'InitiateUsernameTransfer': return $1.UsernameTransferRequest();
      case 'InitiatePhoneTransfer': return $1.PhoneTransferRequest();
      case 'SearchRecipients': return $1.SearchRecipientsRequest();
      case 'GetRecentRecipients': return $1.GetRecentRecipientsRequest();
      case 'GetProviderStatus': return $1.GetProviderStatusRequest();
      case 'GetActiveProviders': return $1.GetActiveProvidersRequest();
      case 'GetAccountBalance': return $1.GetAccountBalanceRequest();
      case 'GetAccountTransactions': return $1.GetAccountTransactionsRequest();
      case 'GetPrimaryAccount': return $1.GetPrimaryAccountRequest();
      case 'FreezeAccount': return $1.FreezeAccountRequest();
      case 'UnfreezeAccount': return $1.UnfreezeAccountRequest();
      case 'GetDailyUsage': return $1.GetDailyUsageRequest();
      case 'RunReconciliation': return $1.RunReconciliationRequest();
      case 'GetReconciliationHistory': return $1.GetReconciliationHistoryRequest();
      case 'GetDailyReport': return $1.GetDailyReportRequest();
      case 'GetMonoInstitutions': return $1.GetMonoInstitutionsRequest();
      case 'GetConnectWidgetConfig': return $1.GetConnectWidgetConfigRequest();
      case 'LinkBankAccount': return $1.LinkBankAccountRequest();
      case 'GetLinkedAccounts': return $1.GetLinkedAccountsRequest();
      case 'GetLinkedAccount': return $1.GetLinkedAccountRequest();
      case 'UnlinkBankAccount': return $1.UnlinkBankAccountRequest();
      case 'SetDefaultLinkedAccount': return $1.SetDefaultLinkedAccountRequest();
      case 'RefreshLinkedAccountBalance': return $1.RefreshLinkedAccountBalanceRequest();
      case 'GetReauthorizationToken': return $1.GetReauthorizationTokenRequest();
      case 'InitiateDeposit': return $1.InitiateDepositRequest();
      case 'GetDepositStatus': return $1.GetDepositStatusRequest();
      case 'GetUserDeposits': return $1.GetUserDepositsRequest();
      case 'CancelDeposit': return $1.CancelDepositRequest();
      case 'CalculateDepositFee': return $1.CalculateDepositFeeRequest();
      case 'CreateMandate': return $1.CreateMandateRequest();
      case 'GetMandate': return $1.GetMandateRequest();
      case 'GetUserMandates': return $1.GetUserMandatesRequest();
      case 'PauseMandate': return $1.PauseMandateRequest();
      case 'ReinstateMandate': return $1.ReinstateMandateRequest();
      case 'CancelMandate': return $1.CancelMandateRequest();
      case 'CheckMandateBalance': return $1.CheckMandateBalanceRequest();
      case 'InitiateWithdrawal': return $1.InitiateWithdrawalRequest();
      case 'GetWithdrawalStatus': return $1.GetWithdrawalStatusRequest();
      case 'GetUserWithdrawals': return $1.GetUserWithdrawalsRequest();
      case 'CalculateWithdrawalFee': return $1.CalculateWithdrawalFeeRequest();
      case 'GetTransferFee': return $1.GetTransferFeeRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'CreateVirtualAccount': return this.createVirtualAccount(ctx, request as $1.CreateVirtualAccountRequest);
      case 'GetVirtualAccount': return this.getVirtualAccount(ctx, request as $1.GetVirtualAccountRequest);
      case 'GetUserVirtualAccounts': return this.getUserVirtualAccounts(ctx, request as $1.GetUserVirtualAccountsRequest);
      case 'InitiateDomesticTransfer': return this.initiateDomesticTransfer(ctx, request as $1.DomesticTransferRequest);
      case 'GetTransferStatus': return this.getTransferStatus(ctx, request as $1.GetTransferStatusRequest);
      case 'GetUserTransfers': return this.getUserTransfers(ctx, request as $1.GetUserTransfersRequest);
      case 'InitiateInternalTransfer': return this.initiateInternalTransfer(ctx, request as $1.InternalTransferRequest);
      case 'InitiateInternationalTransfer': return this.initiateInternationalTransfer(ctx, request as $1.InternationalTransferRequest);
      case 'GetExchangeRate': return this.getExchangeRate(ctx, request as $1.GetExchangeRateRequest);
      case 'GetSupportedCountries': return this.getSupportedCountries(ctx, request as $1.GetSupportedCountriesRequest);
      case 'VerifyBankAccount': return this.verifyBankAccount(ctx, request as $1.VerifyBankAccountRequest);
      case 'GetBanks': return this.getBanks(ctx, request as $1.GetBanksRequest);
      case 'VerifyBVN': return this.verifyBVN(ctx, request as $1.VerifyBVNRequest);
      case 'GetVerificationStatus': return this.getVerificationStatus(ctx, request as $1.GetVerificationStatusRequest);
      case 'VerifyBVNForSignup': return this.verifyBVNForSignup(ctx, request as $1.VerifyBVNForSignupRequest);
      case 'VerifyNINForSignup': return this.verifyNINForSignup(ctx, request as $1.VerifyNINForSignupRequest);
      case 'CreateVirtualAccountForUser': return this.createVirtualAccountForUser(ctx, request as $1.CreateVirtualAccountForUserRequest);
      case 'InitiateUsernameTransfer': return this.initiateUsernameTransfer(ctx, request as $1.UsernameTransferRequest);
      case 'InitiatePhoneTransfer': return this.initiatePhoneTransfer(ctx, request as $1.PhoneTransferRequest);
      case 'SearchRecipients': return this.searchRecipients(ctx, request as $1.SearchRecipientsRequest);
      case 'GetRecentRecipients': return this.getRecentRecipients(ctx, request as $1.GetRecentRecipientsRequest);
      case 'GetProviderStatus': return this.getProviderStatus(ctx, request as $1.GetProviderStatusRequest);
      case 'GetActiveProviders': return this.getActiveProviders(ctx, request as $1.GetActiveProvidersRequest);
      case 'GetAccountBalance': return this.getAccountBalance(ctx, request as $1.GetAccountBalanceRequest);
      case 'GetAccountTransactions': return this.getAccountTransactions(ctx, request as $1.GetAccountTransactionsRequest);
      case 'GetPrimaryAccount': return this.getPrimaryAccount(ctx, request as $1.GetPrimaryAccountRequest);
      case 'FreezeAccount': return this.freezeAccount(ctx, request as $1.FreezeAccountRequest);
      case 'UnfreezeAccount': return this.unfreezeAccount(ctx, request as $1.UnfreezeAccountRequest);
      case 'GetDailyUsage': return this.getDailyUsage(ctx, request as $1.GetDailyUsageRequest);
      case 'RunReconciliation': return this.runReconciliation(ctx, request as $1.RunReconciliationRequest);
      case 'GetReconciliationHistory': return this.getReconciliationHistory(ctx, request as $1.GetReconciliationHistoryRequest);
      case 'GetDailyReport': return this.getDailyReport(ctx, request as $1.GetDailyReportRequest);
      case 'GetMonoInstitutions': return this.getMonoInstitutions(ctx, request as $1.GetMonoInstitutionsRequest);
      case 'GetConnectWidgetConfig': return this.getConnectWidgetConfig(ctx, request as $1.GetConnectWidgetConfigRequest);
      case 'LinkBankAccount': return this.linkBankAccount(ctx, request as $1.LinkBankAccountRequest);
      case 'GetLinkedAccounts': return this.getLinkedAccounts(ctx, request as $1.GetLinkedAccountsRequest);
      case 'GetLinkedAccount': return this.getLinkedAccount(ctx, request as $1.GetLinkedAccountRequest);
      case 'UnlinkBankAccount': return this.unlinkBankAccount(ctx, request as $1.UnlinkBankAccountRequest);
      case 'SetDefaultLinkedAccount': return this.setDefaultLinkedAccount(ctx, request as $1.SetDefaultLinkedAccountRequest);
      case 'RefreshLinkedAccountBalance': return this.refreshLinkedAccountBalance(ctx, request as $1.RefreshLinkedAccountBalanceRequest);
      case 'GetReauthorizationToken': return this.getReauthorizationToken(ctx, request as $1.GetReauthorizationTokenRequest);
      case 'InitiateDeposit': return this.initiateDeposit(ctx, request as $1.InitiateDepositRequest);
      case 'GetDepositStatus': return this.getDepositStatus(ctx, request as $1.GetDepositStatusRequest);
      case 'GetUserDeposits': return this.getUserDeposits(ctx, request as $1.GetUserDepositsRequest);
      case 'CancelDeposit': return this.cancelDeposit(ctx, request as $1.CancelDepositRequest);
      case 'CalculateDepositFee': return this.calculateDepositFee(ctx, request as $1.CalculateDepositFeeRequest);
      case 'CreateMandate': return this.createMandate(ctx, request as $1.CreateMandateRequest);
      case 'GetMandate': return this.getMandate(ctx, request as $1.GetMandateRequest);
      case 'GetUserMandates': return this.getUserMandates(ctx, request as $1.GetUserMandatesRequest);
      case 'PauseMandate': return this.pauseMandate(ctx, request as $1.PauseMandateRequest);
      case 'ReinstateMandate': return this.reinstateMandate(ctx, request as $1.ReinstateMandateRequest);
      case 'CancelMandate': return this.cancelMandate(ctx, request as $1.CancelMandateRequest);
      case 'CheckMandateBalance': return this.checkMandateBalance(ctx, request as $1.CheckMandateBalanceRequest);
      case 'InitiateWithdrawal': return this.initiateWithdrawal(ctx, request as $1.InitiateWithdrawalRequest);
      case 'GetWithdrawalStatus': return this.getWithdrawalStatus(ctx, request as $1.GetWithdrawalStatusRequest);
      case 'GetUserWithdrawals': return this.getUserWithdrawals(ctx, request as $1.GetUserWithdrawalsRequest);
      case 'CalculateWithdrawalFee': return this.calculateWithdrawalFee(ctx, request as $1.CalculateWithdrawalFeeRequest);
      case 'GetTransferFee': return this.getTransferFee(ctx, request as $1.GetTransferFeeRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => BankingServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => BankingServiceBase$messageJson;
}

