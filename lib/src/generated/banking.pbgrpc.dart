//
//  Generated code. Do not modify.
//  source: banking.proto
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

import 'banking.pb.dart' as $7;

export 'banking.pb.dart';

@$pb.GrpcServiceName('banking.BankingService')
class BankingServiceClient extends $grpc.Client {
  static final _$createVirtualAccount = $grpc.ClientMethod<$7.CreateVirtualAccountRequest, $7.VirtualAccountResponse>(
      '/banking.BankingService/CreateVirtualAccount',
      ($7.CreateVirtualAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.VirtualAccountResponse.fromBuffer(value));
  static final _$getVirtualAccount = $grpc.ClientMethod<$7.GetVirtualAccountRequest, $7.VirtualAccountResponse>(
      '/banking.BankingService/GetVirtualAccount',
      ($7.GetVirtualAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.VirtualAccountResponse.fromBuffer(value));
  static final _$getUserVirtualAccounts = $grpc.ClientMethod<$7.GetUserVirtualAccountsRequest, $7.VirtualAccountsResponse>(
      '/banking.BankingService/GetUserVirtualAccounts',
      ($7.GetUserVirtualAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.VirtualAccountsResponse.fromBuffer(value));
  static final _$initiateDomesticTransfer = $grpc.ClientMethod<$7.DomesticTransferRequest, $7.TransferResponse>(
      '/banking.BankingService/InitiateDomesticTransfer',
      ($7.DomesticTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransferResponse.fromBuffer(value));
  static final _$getTransferStatus = $grpc.ClientMethod<$7.GetTransferStatusRequest, $7.TransferResponse>(
      '/banking.BankingService/GetTransferStatus',
      ($7.GetTransferStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransferResponse.fromBuffer(value));
  static final _$getUserTransfers = $grpc.ClientMethod<$7.GetUserTransfersRequest, $7.TransfersResponse>(
      '/banking.BankingService/GetUserTransfers',
      ($7.GetUserTransfersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransfersResponse.fromBuffer(value));
  static final _$initiateInternalTransfer = $grpc.ClientMethod<$7.InternalTransferRequest, $7.TransferResponse>(
      '/banking.BankingService/InitiateInternalTransfer',
      ($7.InternalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransferResponse.fromBuffer(value));
  static final _$initiateInternationalTransfer = $grpc.ClientMethod<$7.InternationalTransferRequest, $7.TransferResponse>(
      '/banking.BankingService/InitiateInternationalTransfer',
      ($7.InternationalTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransferResponse.fromBuffer(value));
  static final _$getExchangeRate = $grpc.ClientMethod<$7.GetExchangeRateRequest, $7.ExchangeRateResponse>(
      '/banking.BankingService/GetExchangeRate',
      ($7.GetExchangeRateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ExchangeRateResponse.fromBuffer(value));
  static final _$getSupportedCountries = $grpc.ClientMethod<$7.GetSupportedCountriesRequest, $7.SupportedCountriesResponse>(
      '/banking.BankingService/GetSupportedCountries',
      ($7.GetSupportedCountriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.SupportedCountriesResponse.fromBuffer(value));
  static final _$verifyBankAccount = $grpc.ClientMethod<$7.VerifyBankAccountRequest, $7.VerifyBankAccountResponse>(
      '/banking.BankingService/VerifyBankAccount',
      ($7.VerifyBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.VerifyBankAccountResponse.fromBuffer(value));
  static final _$getBanks = $grpc.ClientMethod<$7.GetBanksRequest, $7.BanksResponse>(
      '/banking.BankingService/GetBanks',
      ($7.GetBanksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.BanksResponse.fromBuffer(value));
  static final _$verifyBVN = $grpc.ClientMethod<$7.VerifyBVNRequest, $7.IdentityVerificationResponse>(
      '/banking.BankingService/VerifyBVN',
      ($7.VerifyBVNRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.IdentityVerificationResponse.fromBuffer(value));
  static final _$getVerificationStatus = $grpc.ClientMethod<$7.GetVerificationStatusRequest, $7.IdentityVerificationResponse>(
      '/banking.BankingService/GetVerificationStatus',
      ($7.GetVerificationStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.IdentityVerificationResponse.fromBuffer(value));
  static final _$verifyBVNForSignup = $grpc.ClientMethod<$7.VerifyBVNForSignupRequest, $7.SignupIdentityVerificationResponse>(
      '/banking.BankingService/VerifyBVNForSignup',
      ($7.VerifyBVNForSignupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.SignupIdentityVerificationResponse.fromBuffer(value));
  static final _$verifyNINForSignup = $grpc.ClientMethod<$7.VerifyNINForSignupRequest, $7.SignupIdentityVerificationResponse>(
      '/banking.BankingService/VerifyNINForSignup',
      ($7.VerifyNINForSignupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.SignupIdentityVerificationResponse.fromBuffer(value));
  static final _$createVirtualAccountForUser = $grpc.ClientMethod<$7.CreateVirtualAccountForUserRequest, $7.VirtualAccountResponse>(
      '/banking.BankingService/CreateVirtualAccountForUser',
      ($7.CreateVirtualAccountForUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.VirtualAccountResponse.fromBuffer(value));
  static final _$initiateUsernameTransfer = $grpc.ClientMethod<$7.UsernameTransferRequest, $7.TransferResponse>(
      '/banking.BankingService/InitiateUsernameTransfer',
      ($7.UsernameTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransferResponse.fromBuffer(value));
  static final _$initiatePhoneTransfer = $grpc.ClientMethod<$7.PhoneTransferRequest, $7.TransferResponse>(
      '/banking.BankingService/InitiatePhoneTransfer',
      ($7.PhoneTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransferResponse.fromBuffer(value));
  static final _$searchRecipients = $grpc.ClientMethod<$7.SearchRecipientsRequest, $7.RecipientsResponse>(
      '/banking.BankingService/SearchRecipients',
      ($7.SearchRecipientsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.RecipientsResponse.fromBuffer(value));
  static final _$getRecentRecipients = $grpc.ClientMethod<$7.GetRecentRecipientsRequest, $7.RecipientsResponse>(
      '/banking.BankingService/GetRecentRecipients',
      ($7.GetRecentRecipientsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.RecipientsResponse.fromBuffer(value));
  static final _$getProviderStatus = $grpc.ClientMethod<$7.GetProviderStatusRequest, $7.ProviderStatusResponse>(
      '/banking.BankingService/GetProviderStatus',
      ($7.GetProviderStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ProviderStatusResponse.fromBuffer(value));
  static final _$getActiveProviders = $grpc.ClientMethod<$7.GetActiveProvidersRequest, $7.ActiveProvidersResponse>(
      '/banking.BankingService/GetActiveProviders',
      ($7.GetActiveProvidersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ActiveProvidersResponse.fromBuffer(value));
  static final _$getAccountBalance = $grpc.ClientMethod<$7.GetAccountBalanceRequest, $7.AccountBalanceResponse>(
      '/banking.BankingService/GetAccountBalance',
      ($7.GetAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.AccountBalanceResponse.fromBuffer(value));
  static final _$getAccountTransactions = $grpc.ClientMethod<$7.GetAccountTransactionsRequest, $7.TransactionsResponse>(
      '/banking.BankingService/GetAccountTransactions',
      ($7.GetAccountTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.TransactionsResponse.fromBuffer(value));
  static final _$getPrimaryAccount = $grpc.ClientMethod<$7.GetPrimaryAccountRequest, $7.VirtualAccountResponse>(
      '/banking.BankingService/GetPrimaryAccount',
      ($7.GetPrimaryAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.VirtualAccountResponse.fromBuffer(value));
  static final _$freezeAccount = $grpc.ClientMethod<$7.FreezeAccountRequest, $7.FreezeAccountResponse>(
      '/banking.BankingService/FreezeAccount',
      ($7.FreezeAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.FreezeAccountResponse.fromBuffer(value));
  static final _$unfreezeAccount = $grpc.ClientMethod<$7.UnfreezeAccountRequest, $7.UnfreezeAccountResponse>(
      '/banking.BankingService/UnfreezeAccount',
      ($7.UnfreezeAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.UnfreezeAccountResponse.fromBuffer(value));
  static final _$getDailyUsage = $grpc.ClientMethod<$7.GetDailyUsageRequest, $7.DailyUsageResponse>(
      '/banking.BankingService/GetDailyUsage',
      ($7.GetDailyUsageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.DailyUsageResponse.fromBuffer(value));
  static final _$runReconciliation = $grpc.ClientMethod<$7.RunReconciliationRequest, $7.ReconciliationResponse>(
      '/banking.BankingService/RunReconciliation',
      ($7.RunReconciliationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ReconciliationResponse.fromBuffer(value));
  static final _$getReconciliationHistory = $grpc.ClientMethod<$7.GetReconciliationHistoryRequest, $7.ReconciliationHistoryResponse>(
      '/banking.BankingService/GetReconciliationHistory',
      ($7.GetReconciliationHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ReconciliationHistoryResponse.fromBuffer(value));
  static final _$getDailyReport = $grpc.ClientMethod<$7.GetDailyReportRequest, $7.DailyReportResponse>(
      '/banking.BankingService/GetDailyReport',
      ($7.GetDailyReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.DailyReportResponse.fromBuffer(value));
  static final _$getMonoInstitutions = $grpc.ClientMethod<$7.GetMonoInstitutionsRequest, $7.MonoInstitutionsResponse>(
      '/banking.BankingService/GetMonoInstitutions',
      ($7.GetMonoInstitutionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.MonoInstitutionsResponse.fromBuffer(value));
  static final _$getConnectWidgetConfig = $grpc.ClientMethod<$7.GetConnectWidgetConfigRequest, $7.ConnectWidgetConfigResponse>(
      '/banking.BankingService/GetConnectWidgetConfig',
      ($7.GetConnectWidgetConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ConnectWidgetConfigResponse.fromBuffer(value));
  static final _$linkBankAccount = $grpc.ClientMethod<$7.LinkBankAccountRequest, $7.LinkBankAccountResponse>(
      '/banking.BankingService/LinkBankAccount',
      ($7.LinkBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.LinkBankAccountResponse.fromBuffer(value));
  static final _$getLinkedAccounts = $grpc.ClientMethod<$7.GetLinkedAccountsRequest, $7.LinkedAccountsResponse>(
      '/banking.BankingService/GetLinkedAccounts',
      ($7.GetLinkedAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.LinkedAccountsResponse.fromBuffer(value));
  static final _$getLinkedAccount = $grpc.ClientMethod<$7.GetLinkedAccountRequest, $7.LinkedAccountResponse>(
      '/banking.BankingService/GetLinkedAccount',
      ($7.GetLinkedAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.LinkedAccountResponse.fromBuffer(value));
  static final _$unlinkBankAccount = $grpc.ClientMethod<$7.UnlinkBankAccountRequest, $7.UnlinkBankAccountResponse>(
      '/banking.BankingService/UnlinkBankAccount',
      ($7.UnlinkBankAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.UnlinkBankAccountResponse.fromBuffer(value));
  static final _$setDefaultLinkedAccount = $grpc.ClientMethod<$7.SetDefaultLinkedAccountRequest, $7.SetDefaultLinkedAccountResponse>(
      '/banking.BankingService/SetDefaultLinkedAccount',
      ($7.SetDefaultLinkedAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.SetDefaultLinkedAccountResponse.fromBuffer(value));
  static final _$refreshLinkedAccountBalance = $grpc.ClientMethod<$7.RefreshLinkedAccountBalanceRequest, $7.RefreshLinkedAccountBalanceResponse>(
      '/banking.BankingService/RefreshLinkedAccountBalance',
      ($7.RefreshLinkedAccountBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.RefreshLinkedAccountBalanceResponse.fromBuffer(value));
  static final _$getReauthorizationToken = $grpc.ClientMethod<$7.GetReauthorizationTokenRequest, $7.GetReauthorizationTokenResponse>(
      '/banking.BankingService/GetReauthorizationToken',
      ($7.GetReauthorizationTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.GetReauthorizationTokenResponse.fromBuffer(value));
  static final _$initiateDeposit = $grpc.ClientMethod<$7.InitiateDepositRequest, $7.DepositResponse>(
      '/banking.BankingService/InitiateDeposit',
      ($7.InitiateDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.DepositResponse.fromBuffer(value));
  static final _$getDepositStatus = $grpc.ClientMethod<$7.GetDepositStatusRequest, $7.DepositResponse>(
      '/banking.BankingService/GetDepositStatus',
      ($7.GetDepositStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.DepositResponse.fromBuffer(value));
  static final _$getUserDeposits = $grpc.ClientMethod<$7.GetUserDepositsRequest, $7.DepositsResponse>(
      '/banking.BankingService/GetUserDeposits',
      ($7.GetUserDepositsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.DepositsResponse.fromBuffer(value));
  static final _$cancelDeposit = $grpc.ClientMethod<$7.CancelDepositRequest, $7.CancelDepositResponse>(
      '/banking.BankingService/CancelDeposit',
      ($7.CancelDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.CancelDepositResponse.fromBuffer(value));
  static final _$calculateDepositFee = $grpc.ClientMethod<$7.CalculateDepositFeeRequest, $7.CalculateDepositFeeResponse>(
      '/banking.BankingService/CalculateDepositFee',
      ($7.CalculateDepositFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.CalculateDepositFeeResponse.fromBuffer(value));
  static final _$createMandate = $grpc.ClientMethod<$7.CreateMandateRequest, $7.MandateResponse>(
      '/banking.BankingService/CreateMandate',
      ($7.CreateMandateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.MandateResponse.fromBuffer(value));
  static final _$getMandate = $grpc.ClientMethod<$7.GetMandateRequest, $7.MandateResponse>(
      '/banking.BankingService/GetMandate',
      ($7.GetMandateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.MandateResponse.fromBuffer(value));
  static final _$getUserMandates = $grpc.ClientMethod<$7.GetUserMandatesRequest, $7.MandatesResponse>(
      '/banking.BankingService/GetUserMandates',
      ($7.GetUserMandatesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.MandatesResponse.fromBuffer(value));
  static final _$pauseMandate = $grpc.ClientMethod<$7.PauseMandateRequest, $7.PauseMandateResponse>(
      '/banking.BankingService/PauseMandate',
      ($7.PauseMandateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.PauseMandateResponse.fromBuffer(value));
  static final _$reinstateMandate = $grpc.ClientMethod<$7.ReinstateMandateRequest, $7.ReinstateMandateResponse>(
      '/banking.BankingService/ReinstateMandate',
      ($7.ReinstateMandateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.ReinstateMandateResponse.fromBuffer(value));
  static final _$cancelMandate = $grpc.ClientMethod<$7.CancelMandateRequest, $7.CancelMandateResponse>(
      '/banking.BankingService/CancelMandate',
      ($7.CancelMandateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.CancelMandateResponse.fromBuffer(value));
  static final _$checkMandateBalance = $grpc.ClientMethod<$7.CheckMandateBalanceRequest, $7.CheckMandateBalanceResponse>(
      '/banking.BankingService/CheckMandateBalance',
      ($7.CheckMandateBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.CheckMandateBalanceResponse.fromBuffer(value));
  static final _$initiateWithdrawal = $grpc.ClientMethod<$7.InitiateWithdrawalRequest, $7.WithdrawalResponse>(
      '/banking.BankingService/InitiateWithdrawal',
      ($7.InitiateWithdrawalRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.WithdrawalResponse.fromBuffer(value));
  static final _$getWithdrawalStatus = $grpc.ClientMethod<$7.GetWithdrawalStatusRequest, $7.WithdrawalResponse>(
      '/banking.BankingService/GetWithdrawalStatus',
      ($7.GetWithdrawalStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.WithdrawalResponse.fromBuffer(value));
  static final _$getUserWithdrawals = $grpc.ClientMethod<$7.GetUserWithdrawalsRequest, $7.WithdrawalsResponse>(
      '/banking.BankingService/GetUserWithdrawals',
      ($7.GetUserWithdrawalsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.WithdrawalsResponse.fromBuffer(value));
  static final _$calculateWithdrawalFee = $grpc.ClientMethod<$7.CalculateWithdrawalFeeRequest, $7.CalculateWithdrawalFeeResponse>(
      '/banking.BankingService/CalculateWithdrawalFee',
      ($7.CalculateWithdrawalFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.CalculateWithdrawalFeeResponse.fromBuffer(value));
  static final _$getTransferFee = $grpc.ClientMethod<$7.GetTransferFeeRequest, $7.GetTransferFeeResponse>(
      '/banking.BankingService/GetTransferFee',
      ($7.GetTransferFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $7.GetTransferFeeResponse.fromBuffer(value));

  BankingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$7.VirtualAccountResponse> createVirtualAccount($7.CreateVirtualAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVirtualAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.VirtualAccountResponse> getVirtualAccount($7.GetVirtualAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVirtualAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.VirtualAccountsResponse> getUserVirtualAccounts($7.GetUserVirtualAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserVirtualAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransferResponse> initiateDomesticTransfer($7.DomesticTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDomesticTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransferResponse> getTransferStatus($7.GetTransferStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransfersResponse> getUserTransfers($7.GetUserTransfersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserTransfers, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransferResponse> initiateInternalTransfer($7.InternalTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternalTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransferResponse> initiateInternationalTransfer($7.InternationalTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateInternationalTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$7.ExchangeRateResponse> getExchangeRate($7.GetExchangeRateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$7.SupportedCountriesResponse> getSupportedCountries($7.GetSupportedCountriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getSupportedCountries, request, options: options);
  }

  $grpc.ResponseFuture<$7.VerifyBankAccountResponse> verifyBankAccount($7.VerifyBankAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.BanksResponse> getBanks($7.GetBanksRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBanks, request, options: options);
  }

  $grpc.ResponseFuture<$7.IdentityVerificationResponse> verifyBVN($7.VerifyBVNRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBVN, request, options: options);
  }

  $grpc.ResponseFuture<$7.IdentityVerificationResponse> getVerificationStatus($7.GetVerificationStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVerificationStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.SignupIdentityVerificationResponse> verifyBVNForSignup($7.VerifyBVNForSignupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyBVNForSignup, request, options: options);
  }

  $grpc.ResponseFuture<$7.SignupIdentityVerificationResponse> verifyNINForSignup($7.VerifyNINForSignupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyNINForSignup, request, options: options);
  }

  $grpc.ResponseFuture<$7.VirtualAccountResponse> createVirtualAccountForUser($7.CreateVirtualAccountForUserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVirtualAccountForUser, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransferResponse> initiateUsernameTransfer($7.UsernameTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateUsernameTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransferResponse> initiatePhoneTransfer($7.PhoneTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiatePhoneTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$7.RecipientsResponse> searchRecipients($7.SearchRecipientsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$7.RecipientsResponse> getRecentRecipients($7.GetRecentRecipientsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecentRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$7.ProviderStatusResponse> getProviderStatus($7.GetProviderStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProviderStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.ActiveProvidersResponse> getActiveProviders($7.GetActiveProvidersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getActiveProviders, request, options: options);
  }

  $grpc.ResponseFuture<$7.AccountBalanceResponse> getAccountBalance($7.GetAccountBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$7.TransactionsResponse> getAccountTransactions($7.GetAccountTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$7.VirtualAccountResponse> getPrimaryAccount($7.GetPrimaryAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPrimaryAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.FreezeAccountResponse> freezeAccount($7.FreezeAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.UnfreezeAccountResponse> unfreezeAccount($7.UnfreezeAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.DailyUsageResponse> getDailyUsage($7.GetDailyUsageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDailyUsage, request, options: options);
  }

  $grpc.ResponseFuture<$7.ReconciliationResponse> runReconciliation($7.RunReconciliationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$runReconciliation, request, options: options);
  }

  $grpc.ResponseFuture<$7.ReconciliationHistoryResponse> getReconciliationHistory($7.GetReconciliationHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReconciliationHistory, request, options: options);
  }

  $grpc.ResponseFuture<$7.DailyReportResponse> getDailyReport($7.GetDailyReportRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDailyReport, request, options: options);
  }

  $grpc.ResponseFuture<$7.MonoInstitutionsResponse> getMonoInstitutions($7.GetMonoInstitutionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMonoInstitutions, request, options: options);
  }

  $grpc.ResponseFuture<$7.ConnectWidgetConfigResponse> getConnectWidgetConfig($7.GetConnectWidgetConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConnectWidgetConfig, request, options: options);
  }

  $grpc.ResponseFuture<$7.LinkBankAccountResponse> linkBankAccount($7.LinkBankAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$linkBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.LinkedAccountsResponse> getLinkedAccounts($7.GetLinkedAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLinkedAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$7.LinkedAccountResponse> getLinkedAccount($7.GetLinkedAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLinkedAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.UnlinkBankAccountResponse> unlinkBankAccount($7.UnlinkBankAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlinkBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.SetDefaultLinkedAccountResponse> setDefaultLinkedAccount($7.SetDefaultLinkedAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setDefaultLinkedAccount, request, options: options);
  }

  $grpc.ResponseFuture<$7.RefreshLinkedAccountBalanceResponse> refreshLinkedAccountBalance($7.RefreshLinkedAccountBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshLinkedAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetReauthorizationTokenResponse> getReauthorizationToken($7.GetReauthorizationTokenRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getReauthorizationToken, request, options: options);
  }

  $grpc.ResponseFuture<$7.DepositResponse> initiateDeposit($7.InitiateDepositRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$7.DepositResponse> getDepositStatus($7.GetDepositStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDepositStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.DepositsResponse> getUserDeposits($7.GetUserDepositsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserDeposits, request, options: options);
  }

  $grpc.ResponseFuture<$7.CancelDepositResponse> cancelDeposit($7.CancelDepositRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$7.CalculateDepositFeeResponse> calculateDepositFee($7.CalculateDepositFeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateDepositFee, request, options: options);
  }

  $grpc.ResponseFuture<$7.MandateResponse> createMandate($7.CreateMandateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createMandate, request, options: options);
  }

  $grpc.ResponseFuture<$7.MandateResponse> getMandate($7.GetMandateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMandate, request, options: options);
  }

  $grpc.ResponseFuture<$7.MandatesResponse> getUserMandates($7.GetUserMandatesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserMandates, request, options: options);
  }

  $grpc.ResponseFuture<$7.PauseMandateResponse> pauseMandate($7.PauseMandateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pauseMandate, request, options: options);
  }

  $grpc.ResponseFuture<$7.ReinstateMandateResponse> reinstateMandate($7.ReinstateMandateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reinstateMandate, request, options: options);
  }

  $grpc.ResponseFuture<$7.CancelMandateResponse> cancelMandate($7.CancelMandateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelMandate, request, options: options);
  }

  $grpc.ResponseFuture<$7.CheckMandateBalanceResponse> checkMandateBalance($7.CheckMandateBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkMandateBalance, request, options: options);
  }

  $grpc.ResponseFuture<$7.WithdrawalResponse> initiateWithdrawal($7.InitiateWithdrawalRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  $grpc.ResponseFuture<$7.WithdrawalResponse> getWithdrawalStatus($7.GetWithdrawalStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWithdrawalStatus, request, options: options);
  }

  $grpc.ResponseFuture<$7.WithdrawalsResponse> getUserWithdrawals($7.GetUserWithdrawalsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserWithdrawals, request, options: options);
  }

  $grpc.ResponseFuture<$7.CalculateWithdrawalFeeResponse> calculateWithdrawalFee($7.CalculateWithdrawalFeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$calculateWithdrawalFee, request, options: options);
  }

  $grpc.ResponseFuture<$7.GetTransferFeeResponse> getTransferFee($7.GetTransferFeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransferFee, request, options: options);
  }
}

@$pb.GrpcServiceName('banking.BankingService')
abstract class BankingServiceBase extends $grpc.Service {
  $core.String get $name => 'banking.BankingService';

  BankingServiceBase() {
    $addMethod($grpc.ServiceMethod<$7.CreateVirtualAccountRequest, $7.VirtualAccountResponse>(
        'CreateVirtualAccount',
        createVirtualAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CreateVirtualAccountRequest.fromBuffer(value),
        ($7.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetVirtualAccountRequest, $7.VirtualAccountResponse>(
        'GetVirtualAccount',
        getVirtualAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetVirtualAccountRequest.fromBuffer(value),
        ($7.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetUserVirtualAccountsRequest, $7.VirtualAccountsResponse>(
        'GetUserVirtualAccounts',
        getUserVirtualAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetUserVirtualAccountsRequest.fromBuffer(value),
        ($7.VirtualAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.DomesticTransferRequest, $7.TransferResponse>(
        'InitiateDomesticTransfer',
        initiateDomesticTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.DomesticTransferRequest.fromBuffer(value),
        ($7.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetTransferStatusRequest, $7.TransferResponse>(
        'GetTransferStatus',
        getTransferStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetTransferStatusRequest.fromBuffer(value),
        ($7.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetUserTransfersRequest, $7.TransfersResponse>(
        'GetUserTransfers',
        getUserTransfers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetUserTransfersRequest.fromBuffer(value),
        ($7.TransfersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.InternalTransferRequest, $7.TransferResponse>(
        'InitiateInternalTransfer',
        initiateInternalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.InternalTransferRequest.fromBuffer(value),
        ($7.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.InternationalTransferRequest, $7.TransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.InternationalTransferRequest.fromBuffer(value),
        ($7.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetExchangeRateRequest, $7.ExchangeRateResponse>(
        'GetExchangeRate',
        getExchangeRate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetExchangeRateRequest.fromBuffer(value),
        ($7.ExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetSupportedCountriesRequest, $7.SupportedCountriesResponse>(
        'GetSupportedCountries',
        getSupportedCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetSupportedCountriesRequest.fromBuffer(value),
        ($7.SupportedCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.VerifyBankAccountRequest, $7.VerifyBankAccountResponse>(
        'VerifyBankAccount',
        verifyBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.VerifyBankAccountRequest.fromBuffer(value),
        ($7.VerifyBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetBanksRequest, $7.BanksResponse>(
        'GetBanks',
        getBanks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetBanksRequest.fromBuffer(value),
        ($7.BanksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.VerifyBVNRequest, $7.IdentityVerificationResponse>(
        'VerifyBVN',
        verifyBVN_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.VerifyBVNRequest.fromBuffer(value),
        ($7.IdentityVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetVerificationStatusRequest, $7.IdentityVerificationResponse>(
        'GetVerificationStatus',
        getVerificationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetVerificationStatusRequest.fromBuffer(value),
        ($7.IdentityVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.VerifyBVNForSignupRequest, $7.SignupIdentityVerificationResponse>(
        'VerifyBVNForSignup',
        verifyBVNForSignup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.VerifyBVNForSignupRequest.fromBuffer(value),
        ($7.SignupIdentityVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.VerifyNINForSignupRequest, $7.SignupIdentityVerificationResponse>(
        'VerifyNINForSignup',
        verifyNINForSignup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.VerifyNINForSignupRequest.fromBuffer(value),
        ($7.SignupIdentityVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CreateVirtualAccountForUserRequest, $7.VirtualAccountResponse>(
        'CreateVirtualAccountForUser',
        createVirtualAccountForUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CreateVirtualAccountForUserRequest.fromBuffer(value),
        ($7.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.UsernameTransferRequest, $7.TransferResponse>(
        'InitiateUsernameTransfer',
        initiateUsernameTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.UsernameTransferRequest.fromBuffer(value),
        ($7.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.PhoneTransferRequest, $7.TransferResponse>(
        'InitiatePhoneTransfer',
        initiatePhoneTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.PhoneTransferRequest.fromBuffer(value),
        ($7.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.SearchRecipientsRequest, $7.RecipientsResponse>(
        'SearchRecipients',
        searchRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.SearchRecipientsRequest.fromBuffer(value),
        ($7.RecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetRecentRecipientsRequest, $7.RecipientsResponse>(
        'GetRecentRecipients',
        getRecentRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetRecentRecipientsRequest.fromBuffer(value),
        ($7.RecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetProviderStatusRequest, $7.ProviderStatusResponse>(
        'GetProviderStatus',
        getProviderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetProviderStatusRequest.fromBuffer(value),
        ($7.ProviderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetActiveProvidersRequest, $7.ActiveProvidersResponse>(
        'GetActiveProviders',
        getActiveProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetActiveProvidersRequest.fromBuffer(value),
        ($7.ActiveProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetAccountBalanceRequest, $7.AccountBalanceResponse>(
        'GetAccountBalance',
        getAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetAccountBalanceRequest.fromBuffer(value),
        ($7.AccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetAccountTransactionsRequest, $7.TransactionsResponse>(
        'GetAccountTransactions',
        getAccountTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetAccountTransactionsRequest.fromBuffer(value),
        ($7.TransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetPrimaryAccountRequest, $7.VirtualAccountResponse>(
        'GetPrimaryAccount',
        getPrimaryAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetPrimaryAccountRequest.fromBuffer(value),
        ($7.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.FreezeAccountRequest, $7.FreezeAccountResponse>(
        'FreezeAccount',
        freezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.FreezeAccountRequest.fromBuffer(value),
        ($7.FreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.UnfreezeAccountRequest, $7.UnfreezeAccountResponse>(
        'UnfreezeAccount',
        unfreezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.UnfreezeAccountRequest.fromBuffer(value),
        ($7.UnfreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetDailyUsageRequest, $7.DailyUsageResponse>(
        'GetDailyUsage',
        getDailyUsage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetDailyUsageRequest.fromBuffer(value),
        ($7.DailyUsageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.RunReconciliationRequest, $7.ReconciliationResponse>(
        'RunReconciliation',
        runReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.RunReconciliationRequest.fromBuffer(value),
        ($7.ReconciliationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetReconciliationHistoryRequest, $7.ReconciliationHistoryResponse>(
        'GetReconciliationHistory',
        getReconciliationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetReconciliationHistoryRequest.fromBuffer(value),
        ($7.ReconciliationHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetDailyReportRequest, $7.DailyReportResponse>(
        'GetDailyReport',
        getDailyReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetDailyReportRequest.fromBuffer(value),
        ($7.DailyReportResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetMonoInstitutionsRequest, $7.MonoInstitutionsResponse>(
        'GetMonoInstitutions',
        getMonoInstitutions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetMonoInstitutionsRequest.fromBuffer(value),
        ($7.MonoInstitutionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetConnectWidgetConfigRequest, $7.ConnectWidgetConfigResponse>(
        'GetConnectWidgetConfig',
        getConnectWidgetConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetConnectWidgetConfigRequest.fromBuffer(value),
        ($7.ConnectWidgetConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.LinkBankAccountRequest, $7.LinkBankAccountResponse>(
        'LinkBankAccount',
        linkBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.LinkBankAccountRequest.fromBuffer(value),
        ($7.LinkBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetLinkedAccountsRequest, $7.LinkedAccountsResponse>(
        'GetLinkedAccounts',
        getLinkedAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetLinkedAccountsRequest.fromBuffer(value),
        ($7.LinkedAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetLinkedAccountRequest, $7.LinkedAccountResponse>(
        'GetLinkedAccount',
        getLinkedAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetLinkedAccountRequest.fromBuffer(value),
        ($7.LinkedAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.UnlinkBankAccountRequest, $7.UnlinkBankAccountResponse>(
        'UnlinkBankAccount',
        unlinkBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.UnlinkBankAccountRequest.fromBuffer(value),
        ($7.UnlinkBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.SetDefaultLinkedAccountRequest, $7.SetDefaultLinkedAccountResponse>(
        'SetDefaultLinkedAccount',
        setDefaultLinkedAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.SetDefaultLinkedAccountRequest.fromBuffer(value),
        ($7.SetDefaultLinkedAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.RefreshLinkedAccountBalanceRequest, $7.RefreshLinkedAccountBalanceResponse>(
        'RefreshLinkedAccountBalance',
        refreshLinkedAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.RefreshLinkedAccountBalanceRequest.fromBuffer(value),
        ($7.RefreshLinkedAccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetReauthorizationTokenRequest, $7.GetReauthorizationTokenResponse>(
        'GetReauthorizationToken',
        getReauthorizationToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetReauthorizationTokenRequest.fromBuffer(value),
        ($7.GetReauthorizationTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.InitiateDepositRequest, $7.DepositResponse>(
        'InitiateDeposit',
        initiateDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.InitiateDepositRequest.fromBuffer(value),
        ($7.DepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetDepositStatusRequest, $7.DepositResponse>(
        'GetDepositStatus',
        getDepositStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetDepositStatusRequest.fromBuffer(value),
        ($7.DepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetUserDepositsRequest, $7.DepositsResponse>(
        'GetUserDeposits',
        getUserDeposits_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetUserDepositsRequest.fromBuffer(value),
        ($7.DepositsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CancelDepositRequest, $7.CancelDepositResponse>(
        'CancelDeposit',
        cancelDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CancelDepositRequest.fromBuffer(value),
        ($7.CancelDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CalculateDepositFeeRequest, $7.CalculateDepositFeeResponse>(
        'CalculateDepositFee',
        calculateDepositFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CalculateDepositFeeRequest.fromBuffer(value),
        ($7.CalculateDepositFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CreateMandateRequest, $7.MandateResponse>(
        'CreateMandate',
        createMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CreateMandateRequest.fromBuffer(value),
        ($7.MandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetMandateRequest, $7.MandateResponse>(
        'GetMandate',
        getMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetMandateRequest.fromBuffer(value),
        ($7.MandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetUserMandatesRequest, $7.MandatesResponse>(
        'GetUserMandates',
        getUserMandates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetUserMandatesRequest.fromBuffer(value),
        ($7.MandatesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.PauseMandateRequest, $7.PauseMandateResponse>(
        'PauseMandate',
        pauseMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.PauseMandateRequest.fromBuffer(value),
        ($7.PauseMandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.ReinstateMandateRequest, $7.ReinstateMandateResponse>(
        'ReinstateMandate',
        reinstateMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.ReinstateMandateRequest.fromBuffer(value),
        ($7.ReinstateMandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CancelMandateRequest, $7.CancelMandateResponse>(
        'CancelMandate',
        cancelMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CancelMandateRequest.fromBuffer(value),
        ($7.CancelMandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CheckMandateBalanceRequest, $7.CheckMandateBalanceResponse>(
        'CheckMandateBalance',
        checkMandateBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CheckMandateBalanceRequest.fromBuffer(value),
        ($7.CheckMandateBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.InitiateWithdrawalRequest, $7.WithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.InitiateWithdrawalRequest.fromBuffer(value),
        ($7.WithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetWithdrawalStatusRequest, $7.WithdrawalResponse>(
        'GetWithdrawalStatus',
        getWithdrawalStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetWithdrawalStatusRequest.fromBuffer(value),
        ($7.WithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetUserWithdrawalsRequest, $7.WithdrawalsResponse>(
        'GetUserWithdrawals',
        getUserWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetUserWithdrawalsRequest.fromBuffer(value),
        ($7.WithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.CalculateWithdrawalFeeRequest, $7.CalculateWithdrawalFeeResponse>(
        'CalculateWithdrawalFee',
        calculateWithdrawalFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.CalculateWithdrawalFeeRequest.fromBuffer(value),
        ($7.CalculateWithdrawalFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.GetTransferFeeRequest, $7.GetTransferFeeResponse>(
        'GetTransferFee',
        getTransferFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.GetTransferFeeRequest.fromBuffer(value),
        ($7.GetTransferFeeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$7.VirtualAccountResponse> createVirtualAccount_Pre($grpc.ServiceCall call, $async.Future<$7.CreateVirtualAccountRequest> request) async {
    return createVirtualAccount(call, await request);
  }

  $async.Future<$7.VirtualAccountResponse> getVirtualAccount_Pre($grpc.ServiceCall call, $async.Future<$7.GetVirtualAccountRequest> request) async {
    return getVirtualAccount(call, await request);
  }

  $async.Future<$7.VirtualAccountsResponse> getUserVirtualAccounts_Pre($grpc.ServiceCall call, $async.Future<$7.GetUserVirtualAccountsRequest> request) async {
    return getUserVirtualAccounts(call, await request);
  }

  $async.Future<$7.TransferResponse> initiateDomesticTransfer_Pre($grpc.ServiceCall call, $async.Future<$7.DomesticTransferRequest> request) async {
    return initiateDomesticTransfer(call, await request);
  }

  $async.Future<$7.TransferResponse> getTransferStatus_Pre($grpc.ServiceCall call, $async.Future<$7.GetTransferStatusRequest> request) async {
    return getTransferStatus(call, await request);
  }

  $async.Future<$7.TransfersResponse> getUserTransfers_Pre($grpc.ServiceCall call, $async.Future<$7.GetUserTransfersRequest> request) async {
    return getUserTransfers(call, await request);
  }

  $async.Future<$7.TransferResponse> initiateInternalTransfer_Pre($grpc.ServiceCall call, $async.Future<$7.InternalTransferRequest> request) async {
    return initiateInternalTransfer(call, await request);
  }

  $async.Future<$7.TransferResponse> initiateInternationalTransfer_Pre($grpc.ServiceCall call, $async.Future<$7.InternationalTransferRequest> request) async {
    return initiateInternationalTransfer(call, await request);
  }

  $async.Future<$7.ExchangeRateResponse> getExchangeRate_Pre($grpc.ServiceCall call, $async.Future<$7.GetExchangeRateRequest> request) async {
    return getExchangeRate(call, await request);
  }

  $async.Future<$7.SupportedCountriesResponse> getSupportedCountries_Pre($grpc.ServiceCall call, $async.Future<$7.GetSupportedCountriesRequest> request) async {
    return getSupportedCountries(call, await request);
  }

  $async.Future<$7.VerifyBankAccountResponse> verifyBankAccount_Pre($grpc.ServiceCall call, $async.Future<$7.VerifyBankAccountRequest> request) async {
    return verifyBankAccount(call, await request);
  }

  $async.Future<$7.BanksResponse> getBanks_Pre($grpc.ServiceCall call, $async.Future<$7.GetBanksRequest> request) async {
    return getBanks(call, await request);
  }

  $async.Future<$7.IdentityVerificationResponse> verifyBVN_Pre($grpc.ServiceCall call, $async.Future<$7.VerifyBVNRequest> request) async {
    return verifyBVN(call, await request);
  }

  $async.Future<$7.IdentityVerificationResponse> getVerificationStatus_Pre($grpc.ServiceCall call, $async.Future<$7.GetVerificationStatusRequest> request) async {
    return getVerificationStatus(call, await request);
  }

  $async.Future<$7.SignupIdentityVerificationResponse> verifyBVNForSignup_Pre($grpc.ServiceCall call, $async.Future<$7.VerifyBVNForSignupRequest> request) async {
    return verifyBVNForSignup(call, await request);
  }

  $async.Future<$7.SignupIdentityVerificationResponse> verifyNINForSignup_Pre($grpc.ServiceCall call, $async.Future<$7.VerifyNINForSignupRequest> request) async {
    return verifyNINForSignup(call, await request);
  }

  $async.Future<$7.VirtualAccountResponse> createVirtualAccountForUser_Pre($grpc.ServiceCall call, $async.Future<$7.CreateVirtualAccountForUserRequest> request) async {
    return createVirtualAccountForUser(call, await request);
  }

  $async.Future<$7.TransferResponse> initiateUsernameTransfer_Pre($grpc.ServiceCall call, $async.Future<$7.UsernameTransferRequest> request) async {
    return initiateUsernameTransfer(call, await request);
  }

  $async.Future<$7.TransferResponse> initiatePhoneTransfer_Pre($grpc.ServiceCall call, $async.Future<$7.PhoneTransferRequest> request) async {
    return initiatePhoneTransfer(call, await request);
  }

  $async.Future<$7.RecipientsResponse> searchRecipients_Pre($grpc.ServiceCall call, $async.Future<$7.SearchRecipientsRequest> request) async {
    return searchRecipients(call, await request);
  }

  $async.Future<$7.RecipientsResponse> getRecentRecipients_Pre($grpc.ServiceCall call, $async.Future<$7.GetRecentRecipientsRequest> request) async {
    return getRecentRecipients(call, await request);
  }

  $async.Future<$7.ProviderStatusResponse> getProviderStatus_Pre($grpc.ServiceCall call, $async.Future<$7.GetProviderStatusRequest> request) async {
    return getProviderStatus(call, await request);
  }

  $async.Future<$7.ActiveProvidersResponse> getActiveProviders_Pre($grpc.ServiceCall call, $async.Future<$7.GetActiveProvidersRequest> request) async {
    return getActiveProviders(call, await request);
  }

  $async.Future<$7.AccountBalanceResponse> getAccountBalance_Pre($grpc.ServiceCall call, $async.Future<$7.GetAccountBalanceRequest> request) async {
    return getAccountBalance(call, await request);
  }

  $async.Future<$7.TransactionsResponse> getAccountTransactions_Pre($grpc.ServiceCall call, $async.Future<$7.GetAccountTransactionsRequest> request) async {
    return getAccountTransactions(call, await request);
  }

  $async.Future<$7.VirtualAccountResponse> getPrimaryAccount_Pre($grpc.ServiceCall call, $async.Future<$7.GetPrimaryAccountRequest> request) async {
    return getPrimaryAccount(call, await request);
  }

  $async.Future<$7.FreezeAccountResponse> freezeAccount_Pre($grpc.ServiceCall call, $async.Future<$7.FreezeAccountRequest> request) async {
    return freezeAccount(call, await request);
  }

  $async.Future<$7.UnfreezeAccountResponse> unfreezeAccount_Pre($grpc.ServiceCall call, $async.Future<$7.UnfreezeAccountRequest> request) async {
    return unfreezeAccount(call, await request);
  }

  $async.Future<$7.DailyUsageResponse> getDailyUsage_Pre($grpc.ServiceCall call, $async.Future<$7.GetDailyUsageRequest> request) async {
    return getDailyUsage(call, await request);
  }

  $async.Future<$7.ReconciliationResponse> runReconciliation_Pre($grpc.ServiceCall call, $async.Future<$7.RunReconciliationRequest> request) async {
    return runReconciliation(call, await request);
  }

  $async.Future<$7.ReconciliationHistoryResponse> getReconciliationHistory_Pre($grpc.ServiceCall call, $async.Future<$7.GetReconciliationHistoryRequest> request) async {
    return getReconciliationHistory(call, await request);
  }

  $async.Future<$7.DailyReportResponse> getDailyReport_Pre($grpc.ServiceCall call, $async.Future<$7.GetDailyReportRequest> request) async {
    return getDailyReport(call, await request);
  }

  $async.Future<$7.MonoInstitutionsResponse> getMonoInstitutions_Pre($grpc.ServiceCall call, $async.Future<$7.GetMonoInstitutionsRequest> request) async {
    return getMonoInstitutions(call, await request);
  }

  $async.Future<$7.ConnectWidgetConfigResponse> getConnectWidgetConfig_Pre($grpc.ServiceCall call, $async.Future<$7.GetConnectWidgetConfigRequest> request) async {
    return getConnectWidgetConfig(call, await request);
  }

  $async.Future<$7.LinkBankAccountResponse> linkBankAccount_Pre($grpc.ServiceCall call, $async.Future<$7.LinkBankAccountRequest> request) async {
    return linkBankAccount(call, await request);
  }

  $async.Future<$7.LinkedAccountsResponse> getLinkedAccounts_Pre($grpc.ServiceCall call, $async.Future<$7.GetLinkedAccountsRequest> request) async {
    return getLinkedAccounts(call, await request);
  }

  $async.Future<$7.LinkedAccountResponse> getLinkedAccount_Pre($grpc.ServiceCall call, $async.Future<$7.GetLinkedAccountRequest> request) async {
    return getLinkedAccount(call, await request);
  }

  $async.Future<$7.UnlinkBankAccountResponse> unlinkBankAccount_Pre($grpc.ServiceCall call, $async.Future<$7.UnlinkBankAccountRequest> request) async {
    return unlinkBankAccount(call, await request);
  }

  $async.Future<$7.SetDefaultLinkedAccountResponse> setDefaultLinkedAccount_Pre($grpc.ServiceCall call, $async.Future<$7.SetDefaultLinkedAccountRequest> request) async {
    return setDefaultLinkedAccount(call, await request);
  }

  $async.Future<$7.RefreshLinkedAccountBalanceResponse> refreshLinkedAccountBalance_Pre($grpc.ServiceCall call, $async.Future<$7.RefreshLinkedAccountBalanceRequest> request) async {
    return refreshLinkedAccountBalance(call, await request);
  }

  $async.Future<$7.GetReauthorizationTokenResponse> getReauthorizationToken_Pre($grpc.ServiceCall call, $async.Future<$7.GetReauthorizationTokenRequest> request) async {
    return getReauthorizationToken(call, await request);
  }

  $async.Future<$7.DepositResponse> initiateDeposit_Pre($grpc.ServiceCall call, $async.Future<$7.InitiateDepositRequest> request) async {
    return initiateDeposit(call, await request);
  }

  $async.Future<$7.DepositResponse> getDepositStatus_Pre($grpc.ServiceCall call, $async.Future<$7.GetDepositStatusRequest> request) async {
    return getDepositStatus(call, await request);
  }

  $async.Future<$7.DepositsResponse> getUserDeposits_Pre($grpc.ServiceCall call, $async.Future<$7.GetUserDepositsRequest> request) async {
    return getUserDeposits(call, await request);
  }

  $async.Future<$7.CancelDepositResponse> cancelDeposit_Pre($grpc.ServiceCall call, $async.Future<$7.CancelDepositRequest> request) async {
    return cancelDeposit(call, await request);
  }

  $async.Future<$7.CalculateDepositFeeResponse> calculateDepositFee_Pre($grpc.ServiceCall call, $async.Future<$7.CalculateDepositFeeRequest> request) async {
    return calculateDepositFee(call, await request);
  }

  $async.Future<$7.MandateResponse> createMandate_Pre($grpc.ServiceCall call, $async.Future<$7.CreateMandateRequest> request) async {
    return createMandate(call, await request);
  }

  $async.Future<$7.MandateResponse> getMandate_Pre($grpc.ServiceCall call, $async.Future<$7.GetMandateRequest> request) async {
    return getMandate(call, await request);
  }

  $async.Future<$7.MandatesResponse> getUserMandates_Pre($grpc.ServiceCall call, $async.Future<$7.GetUserMandatesRequest> request) async {
    return getUserMandates(call, await request);
  }

  $async.Future<$7.PauseMandateResponse> pauseMandate_Pre($grpc.ServiceCall call, $async.Future<$7.PauseMandateRequest> request) async {
    return pauseMandate(call, await request);
  }

  $async.Future<$7.ReinstateMandateResponse> reinstateMandate_Pre($grpc.ServiceCall call, $async.Future<$7.ReinstateMandateRequest> request) async {
    return reinstateMandate(call, await request);
  }

  $async.Future<$7.CancelMandateResponse> cancelMandate_Pre($grpc.ServiceCall call, $async.Future<$7.CancelMandateRequest> request) async {
    return cancelMandate(call, await request);
  }

  $async.Future<$7.CheckMandateBalanceResponse> checkMandateBalance_Pre($grpc.ServiceCall call, $async.Future<$7.CheckMandateBalanceRequest> request) async {
    return checkMandateBalance(call, await request);
  }

  $async.Future<$7.WithdrawalResponse> initiateWithdrawal_Pre($grpc.ServiceCall call, $async.Future<$7.InitiateWithdrawalRequest> request) async {
    return initiateWithdrawal(call, await request);
  }

  $async.Future<$7.WithdrawalResponse> getWithdrawalStatus_Pre($grpc.ServiceCall call, $async.Future<$7.GetWithdrawalStatusRequest> request) async {
    return getWithdrawalStatus(call, await request);
  }

  $async.Future<$7.WithdrawalsResponse> getUserWithdrawals_Pre($grpc.ServiceCall call, $async.Future<$7.GetUserWithdrawalsRequest> request) async {
    return getUserWithdrawals(call, await request);
  }

  $async.Future<$7.CalculateWithdrawalFeeResponse> calculateWithdrawalFee_Pre($grpc.ServiceCall call, $async.Future<$7.CalculateWithdrawalFeeRequest> request) async {
    return calculateWithdrawalFee(call, await request);
  }

  $async.Future<$7.GetTransferFeeResponse> getTransferFee_Pre($grpc.ServiceCall call, $async.Future<$7.GetTransferFeeRequest> request) async {
    return getTransferFee(call, await request);
  }

  $async.Future<$7.VirtualAccountResponse> createVirtualAccount($grpc.ServiceCall call, $7.CreateVirtualAccountRequest request);
  $async.Future<$7.VirtualAccountResponse> getVirtualAccount($grpc.ServiceCall call, $7.GetVirtualAccountRequest request);
  $async.Future<$7.VirtualAccountsResponse> getUserVirtualAccounts($grpc.ServiceCall call, $7.GetUserVirtualAccountsRequest request);
  $async.Future<$7.TransferResponse> initiateDomesticTransfer($grpc.ServiceCall call, $7.DomesticTransferRequest request);
  $async.Future<$7.TransferResponse> getTransferStatus($grpc.ServiceCall call, $7.GetTransferStatusRequest request);
  $async.Future<$7.TransfersResponse> getUserTransfers($grpc.ServiceCall call, $7.GetUserTransfersRequest request);
  $async.Future<$7.TransferResponse> initiateInternalTransfer($grpc.ServiceCall call, $7.InternalTransferRequest request);
  $async.Future<$7.TransferResponse> initiateInternationalTransfer($grpc.ServiceCall call, $7.InternationalTransferRequest request);
  $async.Future<$7.ExchangeRateResponse> getExchangeRate($grpc.ServiceCall call, $7.GetExchangeRateRequest request);
  $async.Future<$7.SupportedCountriesResponse> getSupportedCountries($grpc.ServiceCall call, $7.GetSupportedCountriesRequest request);
  $async.Future<$7.VerifyBankAccountResponse> verifyBankAccount($grpc.ServiceCall call, $7.VerifyBankAccountRequest request);
  $async.Future<$7.BanksResponse> getBanks($grpc.ServiceCall call, $7.GetBanksRequest request);
  $async.Future<$7.IdentityVerificationResponse> verifyBVN($grpc.ServiceCall call, $7.VerifyBVNRequest request);
  $async.Future<$7.IdentityVerificationResponse> getVerificationStatus($grpc.ServiceCall call, $7.GetVerificationStatusRequest request);
  $async.Future<$7.SignupIdentityVerificationResponse> verifyBVNForSignup($grpc.ServiceCall call, $7.VerifyBVNForSignupRequest request);
  $async.Future<$7.SignupIdentityVerificationResponse> verifyNINForSignup($grpc.ServiceCall call, $7.VerifyNINForSignupRequest request);
  $async.Future<$7.VirtualAccountResponse> createVirtualAccountForUser($grpc.ServiceCall call, $7.CreateVirtualAccountForUserRequest request);
  $async.Future<$7.TransferResponse> initiateUsernameTransfer($grpc.ServiceCall call, $7.UsernameTransferRequest request);
  $async.Future<$7.TransferResponse> initiatePhoneTransfer($grpc.ServiceCall call, $7.PhoneTransferRequest request);
  $async.Future<$7.RecipientsResponse> searchRecipients($grpc.ServiceCall call, $7.SearchRecipientsRequest request);
  $async.Future<$7.RecipientsResponse> getRecentRecipients($grpc.ServiceCall call, $7.GetRecentRecipientsRequest request);
  $async.Future<$7.ProviderStatusResponse> getProviderStatus($grpc.ServiceCall call, $7.GetProviderStatusRequest request);
  $async.Future<$7.ActiveProvidersResponse> getActiveProviders($grpc.ServiceCall call, $7.GetActiveProvidersRequest request);
  $async.Future<$7.AccountBalanceResponse> getAccountBalance($grpc.ServiceCall call, $7.GetAccountBalanceRequest request);
  $async.Future<$7.TransactionsResponse> getAccountTransactions($grpc.ServiceCall call, $7.GetAccountTransactionsRequest request);
  $async.Future<$7.VirtualAccountResponse> getPrimaryAccount($grpc.ServiceCall call, $7.GetPrimaryAccountRequest request);
  $async.Future<$7.FreezeAccountResponse> freezeAccount($grpc.ServiceCall call, $7.FreezeAccountRequest request);
  $async.Future<$7.UnfreezeAccountResponse> unfreezeAccount($grpc.ServiceCall call, $7.UnfreezeAccountRequest request);
  $async.Future<$7.DailyUsageResponse> getDailyUsage($grpc.ServiceCall call, $7.GetDailyUsageRequest request);
  $async.Future<$7.ReconciliationResponse> runReconciliation($grpc.ServiceCall call, $7.RunReconciliationRequest request);
  $async.Future<$7.ReconciliationHistoryResponse> getReconciliationHistory($grpc.ServiceCall call, $7.GetReconciliationHistoryRequest request);
  $async.Future<$7.DailyReportResponse> getDailyReport($grpc.ServiceCall call, $7.GetDailyReportRequest request);
  $async.Future<$7.MonoInstitutionsResponse> getMonoInstitutions($grpc.ServiceCall call, $7.GetMonoInstitutionsRequest request);
  $async.Future<$7.ConnectWidgetConfigResponse> getConnectWidgetConfig($grpc.ServiceCall call, $7.GetConnectWidgetConfigRequest request);
  $async.Future<$7.LinkBankAccountResponse> linkBankAccount($grpc.ServiceCall call, $7.LinkBankAccountRequest request);
  $async.Future<$7.LinkedAccountsResponse> getLinkedAccounts($grpc.ServiceCall call, $7.GetLinkedAccountsRequest request);
  $async.Future<$7.LinkedAccountResponse> getLinkedAccount($grpc.ServiceCall call, $7.GetLinkedAccountRequest request);
  $async.Future<$7.UnlinkBankAccountResponse> unlinkBankAccount($grpc.ServiceCall call, $7.UnlinkBankAccountRequest request);
  $async.Future<$7.SetDefaultLinkedAccountResponse> setDefaultLinkedAccount($grpc.ServiceCall call, $7.SetDefaultLinkedAccountRequest request);
  $async.Future<$7.RefreshLinkedAccountBalanceResponse> refreshLinkedAccountBalance($grpc.ServiceCall call, $7.RefreshLinkedAccountBalanceRequest request);
  $async.Future<$7.GetReauthorizationTokenResponse> getReauthorizationToken($grpc.ServiceCall call, $7.GetReauthorizationTokenRequest request);
  $async.Future<$7.DepositResponse> initiateDeposit($grpc.ServiceCall call, $7.InitiateDepositRequest request);
  $async.Future<$7.DepositResponse> getDepositStatus($grpc.ServiceCall call, $7.GetDepositStatusRequest request);
  $async.Future<$7.DepositsResponse> getUserDeposits($grpc.ServiceCall call, $7.GetUserDepositsRequest request);
  $async.Future<$7.CancelDepositResponse> cancelDeposit($grpc.ServiceCall call, $7.CancelDepositRequest request);
  $async.Future<$7.CalculateDepositFeeResponse> calculateDepositFee($grpc.ServiceCall call, $7.CalculateDepositFeeRequest request);
  $async.Future<$7.MandateResponse> createMandate($grpc.ServiceCall call, $7.CreateMandateRequest request);
  $async.Future<$7.MandateResponse> getMandate($grpc.ServiceCall call, $7.GetMandateRequest request);
  $async.Future<$7.MandatesResponse> getUserMandates($grpc.ServiceCall call, $7.GetUserMandatesRequest request);
  $async.Future<$7.PauseMandateResponse> pauseMandate($grpc.ServiceCall call, $7.PauseMandateRequest request);
  $async.Future<$7.ReinstateMandateResponse> reinstateMandate($grpc.ServiceCall call, $7.ReinstateMandateRequest request);
  $async.Future<$7.CancelMandateResponse> cancelMandate($grpc.ServiceCall call, $7.CancelMandateRequest request);
  $async.Future<$7.CheckMandateBalanceResponse> checkMandateBalance($grpc.ServiceCall call, $7.CheckMandateBalanceRequest request);
  $async.Future<$7.WithdrawalResponse> initiateWithdrawal($grpc.ServiceCall call, $7.InitiateWithdrawalRequest request);
  $async.Future<$7.WithdrawalResponse> getWithdrawalStatus($grpc.ServiceCall call, $7.GetWithdrawalStatusRequest request);
  $async.Future<$7.WithdrawalsResponse> getUserWithdrawals($grpc.ServiceCall call, $7.GetUserWithdrawalsRequest request);
  $async.Future<$7.CalculateWithdrawalFeeResponse> calculateWithdrawalFee($grpc.ServiceCall call, $7.CalculateWithdrawalFeeRequest request);
  $async.Future<$7.GetTransferFeeResponse> getTransferFee($grpc.ServiceCall call, $7.GetTransferFeeRequest request);
}
