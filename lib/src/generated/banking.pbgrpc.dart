// This is a generated file - do not edit.
//
// Generated from banking.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'banking.pb.dart' as $0;

export 'banking.pb.dart';

@$pb.GrpcServiceName('banking.BankingService')
class BankingServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  BankingServiceClient(super.channel, {super.options, super.interceptors});

  /// Virtual Accounts
  $grpc.ResponseFuture<$0.VirtualAccountResponse> createVirtualAccount(
    $0.CreateVirtualAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createVirtualAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.VirtualAccountResponse> getVirtualAccount(
    $0.GetVirtualAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVirtualAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.VirtualAccountsResponse> getUserVirtualAccounts(
    $0.GetUserVirtualAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserVirtualAccounts, request,
        options: options);
  }

  /// Domestic Transfers
  $grpc.ResponseFuture<$0.TransferResponse> initiateDomesticTransfer(
    $0.DomesticTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateDomesticTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TransferResponse> getTransferStatus(
    $0.GetTransferStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTransferStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransfersResponse> getUserTransfers(
    $0.GetUserTransfersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserTransfers, request, options: options);
  }

  /// Internal C2C Transfers
  $grpc.ResponseFuture<$0.TransferResponse> initiateInternalTransfer(
    $0.InternalTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateInternalTransfer, request,
        options: options);
  }

  /// International Transfers
  $grpc.ResponseFuture<$0.TransferResponse> initiateInternationalTransfer(
    $0.InternationalTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateInternationalTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.ExchangeRateResponse> getExchangeRate(
    $0.GetExchangeRateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getExchangeRate, request, options: options);
  }

  $grpc.ResponseFuture<$0.SupportedCountriesResponse> getSupportedCountries(
    $0.GetSupportedCountriesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSupportedCountries, request, options: options);
  }

  /// Account Verification
  $grpc.ResponseFuture<$0.VerifyBankAccountResponse> verifyBankAccount(
    $0.VerifyBankAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyBankAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.BanksResponse> getBanks(
    $0.GetBanksRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getBanks, request, options: options);
  }

  /// Identity Verification
  $grpc.ResponseFuture<$0.IdentityVerificationResponse> verifyBVN(
    $0.VerifyBVNRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyBVN, request, options: options);
  }

  $grpc.ResponseFuture<$0.IdentityVerificationResponse> getVerificationStatus(
    $0.GetVerificationStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getVerificationStatus, request, options: options);
  }

  /// Identity Verification for Signup (called by Auth Service via internal gRPC)
  $grpc.ResponseFuture<$0.SignupIdentityVerificationResponse>
      verifyBVNForSignup(
    $0.VerifyBVNForSignupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyBVNForSignup, request, options: options);
  }

  $grpc.ResponseFuture<$0.SignupIdentityVerificationResponse>
      verifyNINForSignup(
    $0.VerifyNINForSignupRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$verifyNINForSignup, request, options: options);
  }

  $grpc.ResponseFuture<$0.VirtualAccountResponse> createVirtualAccountForUser(
    $0.CreateVirtualAccountForUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createVirtualAccountForUser, request,
        options: options);
  }

  /// Enhanced Transfers (Username/Phone)
  $grpc.ResponseFuture<$0.TransferResponse> initiateUsernameTransfer(
    $0.UsernameTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateUsernameTransfer, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.TransferResponse> initiatePhoneTransfer(
    $0.PhoneTransferRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiatePhoneTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecipientsResponse> searchRecipients(
    $0.SearchRecipientsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchRecipients, request, options: options);
  }

  $grpc.ResponseFuture<$0.RecipientsResponse> getRecentRecipients(
    $0.GetRecentRecipientsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getRecentRecipients, request, options: options);
  }

  /// Provider Status
  $grpc.ResponseFuture<$0.ProviderStatusResponse> getProviderStatus(
    $0.GetProviderStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProviderStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.ActiveProvidersResponse> getActiveProviders(
    $0.GetActiveProvidersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getActiveProviders, request, options: options);
  }

  /// Account Management
  $grpc.ResponseFuture<$0.AccountBalanceResponse> getAccountBalance(
    $0.GetAccountBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransactionsResponse> getAccountTransactions(
    $0.GetAccountTransactionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getAccountTransactions, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.VirtualAccountResponse> getPrimaryAccount(
    $0.GetPrimaryAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPrimaryAccount, request, options: options);
  }

  /// Account Freeze/Unfreeze (Admin)
  $grpc.ResponseFuture<$0.FreezeAccountResponse> freezeAccount(
    $0.FreezeAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$freezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnfreezeAccountResponse> unfreezeAccount(
    $0.UnfreezeAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unfreezeAccount, request, options: options);
  }

  /// Daily Usage & Limits
  $grpc.ResponseFuture<$0.DailyUsageResponse> getDailyUsage(
    $0.GetDailyUsageRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDailyUsage, request, options: options);
  }

  /// Reconciliation (Admin)
  $grpc.ResponseFuture<$0.ReconciliationResponse> runReconciliation(
    $0.RunReconciliationRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$runReconciliation, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReconciliationHistoryResponse>
      getReconciliationHistory(
    $0.GetReconciliationHistoryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getReconciliationHistory, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.DailyReportResponse> getDailyReport(
    $0.GetDailyReportRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDailyReport, request, options: options);
  }

  /// Get list of Mono-supported institutions (banks) with auth methods
  /// This endpoint returns institutions that can be used with Mono Connect
  $grpc.ResponseFuture<$0.MonoInstitutionsResponse> getMonoInstitutions(
    $0.GetMonoInstitutionsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMonoInstitutions, request, options: options);
  }

  /// Get Mono Connect widget configuration
  $grpc.ResponseFuture<$0.ConnectWidgetConfigResponse> getConnectWidgetConfig(
    $0.GetConnectWidgetConfigRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getConnectWidgetConfig, request,
        options: options);
  }

  /// Link a bank account using Mono Connect authorization code
  $grpc.ResponseFuture<$0.LinkBankAccountResponse> linkBankAccount(
    $0.LinkBankAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$linkBankAccount, request, options: options);
  }

  /// Get all linked bank accounts for a user
  $grpc.ResponseFuture<$0.LinkedAccountsResponse> getLinkedAccounts(
    $0.GetLinkedAccountsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLinkedAccounts, request, options: options);
  }

  /// Get a specific linked bank account
  $grpc.ResponseFuture<$0.LinkedAccountResponse> getLinkedAccount(
    $0.GetLinkedAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getLinkedAccount, request, options: options);
  }

  /// Unlink a bank account
  $grpc.ResponseFuture<$0.UnlinkBankAccountResponse> unlinkBankAccount(
    $0.UnlinkBankAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$unlinkBankAccount, request, options: options);
  }

  /// Set a linked account as default
  $grpc.ResponseFuture<$0.SetDefaultLinkedAccountResponse>
      setDefaultLinkedAccount(
    $0.SetDefaultLinkedAccountRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$setDefaultLinkedAccount, request,
        options: options);
  }

  /// Refresh balance for a linked account
  $grpc.ResponseFuture<$0.RefreshLinkedAccountBalanceResponse>
      refreshLinkedAccountBalance(
    $0.RefreshLinkedAccountBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$refreshLinkedAccountBalance, request,
        options: options);
  }

  /// Get reauthorization token for an account that needs re-linking
  $grpc.ResponseFuture<$0.GetReauthorizationTokenResponse>
      getReauthorizationToken(
    $0.GetReauthorizationTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getReauthorizationToken, request,
        options: options);
  }

  /// Initiate a deposit via direct debit from linked account
  $grpc.ResponseFuture<$0.DepositResponse> initiateDeposit(
    $0.InitiateDepositRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateDeposit, request, options: options);
  }

  /// Get deposit status
  $grpc.ResponseFuture<$0.DepositResponse> getDepositStatus(
    $0.GetDepositStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getDepositStatus, request, options: options);
  }

  /// Get user's deposit history
  $grpc.ResponseFuture<$0.DepositsResponse> getUserDeposits(
    $0.GetUserDepositsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserDeposits, request, options: options);
  }

  /// Cancel a pending deposit
  $grpc.ResponseFuture<$0.CancelDepositResponse> cancelDeposit(
    $0.CancelDepositRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelDeposit, request, options: options);
  }

  /// Calculate deposit fee
  $grpc.ResponseFuture<$0.CalculateDepositFeeResponse> calculateDepositFee(
    $0.CalculateDepositFeeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$calculateDepositFee, request, options: options);
  }

  /// Create a direct debit mandate for a linked account
  $grpc.ResponseFuture<$0.MandateResponse> createMandate(
    $0.CreateMandateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createMandate, request, options: options);
  }

  /// Get mandate status
  $grpc.ResponseFuture<$0.MandateResponse> getMandate(
    $0.GetMandateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getMandate, request, options: options);
  }

  /// Get user's mandates
  $grpc.ResponseFuture<$0.MandatesResponse> getUserMandates(
    $0.GetUserMandatesRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserMandates, request, options: options);
  }

  /// Pause a mandate
  $grpc.ResponseFuture<$0.PauseMandateResponse> pauseMandate(
    $0.PauseMandateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$pauseMandate, request, options: options);
  }

  /// Reinstate a paused mandate
  $grpc.ResponseFuture<$0.ReinstateMandateResponse> reinstateMandate(
    $0.ReinstateMandateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reinstateMandate, request, options: options);
  }

  /// Cancel a mandate
  $grpc.ResponseFuture<$0.CancelMandateResponse> cancelMandate(
    $0.CancelMandateRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$cancelMandate, request, options: options);
  }

  /// Check balance before debit
  $grpc.ResponseFuture<$0.CheckMandateBalanceResponse> checkMandateBalance(
    $0.CheckMandateBalanceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$checkMandateBalance, request, options: options);
  }

  /// Initiate a withdrawal to an external bank
  $grpc.ResponseFuture<$0.WithdrawalResponse> initiateWithdrawal(
    $0.InitiateWithdrawalRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$initiateWithdrawal, request, options: options);
  }

  /// Get withdrawal status
  $grpc.ResponseFuture<$0.WithdrawalResponse> getWithdrawalStatus(
    $0.GetWithdrawalStatusRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getWithdrawalStatus, request, options: options);
  }

  /// Get user's withdrawal history
  $grpc.ResponseFuture<$0.WithdrawalsResponse> getUserWithdrawals(
    $0.GetUserWithdrawalsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUserWithdrawals, request, options: options);
  }

  /// Calculate withdrawal fee
  $grpc.ResponseFuture<$0.CalculateWithdrawalFeeResponse>
      calculateWithdrawalFee(
    $0.CalculateWithdrawalFeeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$calculateWithdrawalFee, request,
        options: options);
  }

  /// Get transfer fee (real-time fee lookup)
  $grpc.ResponseFuture<$0.GetTransferFeeResponse> getTransferFee(
    $0.GetTransferFeeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getTransferFee, request, options: options);
  }

  // method descriptors

  static final _$createVirtualAccount = $grpc.ClientMethod<
          $0.CreateVirtualAccountRequest, $0.VirtualAccountResponse>(
      '/banking.BankingService/CreateVirtualAccount',
      ($0.CreateVirtualAccountRequest value) => value.writeToBuffer(),
      $0.VirtualAccountResponse.fromBuffer);
  static final _$getVirtualAccount = $grpc.ClientMethod<
          $0.GetVirtualAccountRequest, $0.VirtualAccountResponse>(
      '/banking.BankingService/GetVirtualAccount',
      ($0.GetVirtualAccountRequest value) => value.writeToBuffer(),
      $0.VirtualAccountResponse.fromBuffer);
  static final _$getUserVirtualAccounts = $grpc.ClientMethod<
          $0.GetUserVirtualAccountsRequest, $0.VirtualAccountsResponse>(
      '/banking.BankingService/GetUserVirtualAccounts',
      ($0.GetUserVirtualAccountsRequest value) => value.writeToBuffer(),
      $0.VirtualAccountsResponse.fromBuffer);
  static final _$initiateDomesticTransfer =
      $grpc.ClientMethod<$0.DomesticTransferRequest, $0.TransferResponse>(
          '/banking.BankingService/InitiateDomesticTransfer',
          ($0.DomesticTransferRequest value) => value.writeToBuffer(),
          $0.TransferResponse.fromBuffer);
  static final _$getTransferStatus =
      $grpc.ClientMethod<$0.GetTransferStatusRequest, $0.TransferResponse>(
          '/banking.BankingService/GetTransferStatus',
          ($0.GetTransferStatusRequest value) => value.writeToBuffer(),
          $0.TransferResponse.fromBuffer);
  static final _$getUserTransfers =
      $grpc.ClientMethod<$0.GetUserTransfersRequest, $0.TransfersResponse>(
          '/banking.BankingService/GetUserTransfers',
          ($0.GetUserTransfersRequest value) => value.writeToBuffer(),
          $0.TransfersResponse.fromBuffer);
  static final _$initiateInternalTransfer =
      $grpc.ClientMethod<$0.InternalTransferRequest, $0.TransferResponse>(
          '/banking.BankingService/InitiateInternalTransfer',
          ($0.InternalTransferRequest value) => value.writeToBuffer(),
          $0.TransferResponse.fromBuffer);
  static final _$initiateInternationalTransfer =
      $grpc.ClientMethod<$0.InternationalTransferRequest, $0.TransferResponse>(
          '/banking.BankingService/InitiateInternationalTransfer',
          ($0.InternationalTransferRequest value) => value.writeToBuffer(),
          $0.TransferResponse.fromBuffer);
  static final _$getExchangeRate =
      $grpc.ClientMethod<$0.GetExchangeRateRequest, $0.ExchangeRateResponse>(
          '/banking.BankingService/GetExchangeRate',
          ($0.GetExchangeRateRequest value) => value.writeToBuffer(),
          $0.ExchangeRateResponse.fromBuffer);
  static final _$getSupportedCountries = $grpc.ClientMethod<
          $0.GetSupportedCountriesRequest, $0.SupportedCountriesResponse>(
      '/banking.BankingService/GetSupportedCountries',
      ($0.GetSupportedCountriesRequest value) => value.writeToBuffer(),
      $0.SupportedCountriesResponse.fromBuffer);
  static final _$verifyBankAccount = $grpc.ClientMethod<
          $0.VerifyBankAccountRequest, $0.VerifyBankAccountResponse>(
      '/banking.BankingService/VerifyBankAccount',
      ($0.VerifyBankAccountRequest value) => value.writeToBuffer(),
      $0.VerifyBankAccountResponse.fromBuffer);
  static final _$getBanks =
      $grpc.ClientMethod<$0.GetBanksRequest, $0.BanksResponse>(
          '/banking.BankingService/GetBanks',
          ($0.GetBanksRequest value) => value.writeToBuffer(),
          $0.BanksResponse.fromBuffer);
  static final _$verifyBVN =
      $grpc.ClientMethod<$0.VerifyBVNRequest, $0.IdentityVerificationResponse>(
          '/banking.BankingService/VerifyBVN',
          ($0.VerifyBVNRequest value) => value.writeToBuffer(),
          $0.IdentityVerificationResponse.fromBuffer);
  static final _$getVerificationStatus = $grpc.ClientMethod<
          $0.GetVerificationStatusRequest, $0.IdentityVerificationResponse>(
      '/banking.BankingService/GetVerificationStatus',
      ($0.GetVerificationStatusRequest value) => value.writeToBuffer(),
      $0.IdentityVerificationResponse.fromBuffer);
  static final _$verifyBVNForSignup = $grpc.ClientMethod<
          $0.VerifyBVNForSignupRequest, $0.SignupIdentityVerificationResponse>(
      '/banking.BankingService/VerifyBVNForSignup',
      ($0.VerifyBVNForSignupRequest value) => value.writeToBuffer(),
      $0.SignupIdentityVerificationResponse.fromBuffer);
  static final _$verifyNINForSignup = $grpc.ClientMethod<
          $0.VerifyNINForSignupRequest, $0.SignupIdentityVerificationResponse>(
      '/banking.BankingService/VerifyNINForSignup',
      ($0.VerifyNINForSignupRequest value) => value.writeToBuffer(),
      $0.SignupIdentityVerificationResponse.fromBuffer);
  static final _$createVirtualAccountForUser = $grpc.ClientMethod<
          $0.CreateVirtualAccountForUserRequest, $0.VirtualAccountResponse>(
      '/banking.BankingService/CreateVirtualAccountForUser',
      ($0.CreateVirtualAccountForUserRequest value) => value.writeToBuffer(),
      $0.VirtualAccountResponse.fromBuffer);
  static final _$initiateUsernameTransfer =
      $grpc.ClientMethod<$0.UsernameTransferRequest, $0.TransferResponse>(
          '/banking.BankingService/InitiateUsernameTransfer',
          ($0.UsernameTransferRequest value) => value.writeToBuffer(),
          $0.TransferResponse.fromBuffer);
  static final _$initiatePhoneTransfer =
      $grpc.ClientMethod<$0.PhoneTransferRequest, $0.TransferResponse>(
          '/banking.BankingService/InitiatePhoneTransfer',
          ($0.PhoneTransferRequest value) => value.writeToBuffer(),
          $0.TransferResponse.fromBuffer);
  static final _$searchRecipients =
      $grpc.ClientMethod<$0.SearchRecipientsRequest, $0.RecipientsResponse>(
          '/banking.BankingService/SearchRecipients',
          ($0.SearchRecipientsRequest value) => value.writeToBuffer(),
          $0.RecipientsResponse.fromBuffer);
  static final _$getRecentRecipients =
      $grpc.ClientMethod<$0.GetRecentRecipientsRequest, $0.RecipientsResponse>(
          '/banking.BankingService/GetRecentRecipients',
          ($0.GetRecentRecipientsRequest value) => value.writeToBuffer(),
          $0.RecipientsResponse.fromBuffer);
  static final _$getProviderStatus = $grpc.ClientMethod<
          $0.GetProviderStatusRequest, $0.ProviderStatusResponse>(
      '/banking.BankingService/GetProviderStatus',
      ($0.GetProviderStatusRequest value) => value.writeToBuffer(),
      $0.ProviderStatusResponse.fromBuffer);
  static final _$getActiveProviders = $grpc.ClientMethod<
          $0.GetActiveProvidersRequest, $0.ActiveProvidersResponse>(
      '/banking.BankingService/GetActiveProviders',
      ($0.GetActiveProvidersRequest value) => value.writeToBuffer(),
      $0.ActiveProvidersResponse.fromBuffer);
  static final _$getAccountBalance = $grpc.ClientMethod<
          $0.GetAccountBalanceRequest, $0.AccountBalanceResponse>(
      '/banking.BankingService/GetAccountBalance',
      ($0.GetAccountBalanceRequest value) => value.writeToBuffer(),
      $0.AccountBalanceResponse.fromBuffer);
  static final _$getAccountTransactions = $grpc.ClientMethod<
          $0.GetAccountTransactionsRequest, $0.TransactionsResponse>(
      '/banking.BankingService/GetAccountTransactions',
      ($0.GetAccountTransactionsRequest value) => value.writeToBuffer(),
      $0.TransactionsResponse.fromBuffer);
  static final _$getPrimaryAccount = $grpc.ClientMethod<
          $0.GetPrimaryAccountRequest, $0.VirtualAccountResponse>(
      '/banking.BankingService/GetPrimaryAccount',
      ($0.GetPrimaryAccountRequest value) => value.writeToBuffer(),
      $0.VirtualAccountResponse.fromBuffer);
  static final _$freezeAccount =
      $grpc.ClientMethod<$0.FreezeAccountRequest, $0.FreezeAccountResponse>(
          '/banking.BankingService/FreezeAccount',
          ($0.FreezeAccountRequest value) => value.writeToBuffer(),
          $0.FreezeAccountResponse.fromBuffer);
  static final _$unfreezeAccount =
      $grpc.ClientMethod<$0.UnfreezeAccountRequest, $0.UnfreezeAccountResponse>(
          '/banking.BankingService/UnfreezeAccount',
          ($0.UnfreezeAccountRequest value) => value.writeToBuffer(),
          $0.UnfreezeAccountResponse.fromBuffer);
  static final _$getDailyUsage =
      $grpc.ClientMethod<$0.GetDailyUsageRequest, $0.DailyUsageResponse>(
          '/banking.BankingService/GetDailyUsage',
          ($0.GetDailyUsageRequest value) => value.writeToBuffer(),
          $0.DailyUsageResponse.fromBuffer);
  static final _$runReconciliation = $grpc.ClientMethod<
          $0.RunReconciliationRequest, $0.ReconciliationResponse>(
      '/banking.BankingService/RunReconciliation',
      ($0.RunReconciliationRequest value) => value.writeToBuffer(),
      $0.ReconciliationResponse.fromBuffer);
  static final _$getReconciliationHistory = $grpc.ClientMethod<
          $0.GetReconciliationHistoryRequest, $0.ReconciliationHistoryResponse>(
      '/banking.BankingService/GetReconciliationHistory',
      ($0.GetReconciliationHistoryRequest value) => value.writeToBuffer(),
      $0.ReconciliationHistoryResponse.fromBuffer);
  static final _$getDailyReport =
      $grpc.ClientMethod<$0.GetDailyReportRequest, $0.DailyReportResponse>(
          '/banking.BankingService/GetDailyReport',
          ($0.GetDailyReportRequest value) => value.writeToBuffer(),
          $0.DailyReportResponse.fromBuffer);
  static final _$getMonoInstitutions = $grpc.ClientMethod<
          $0.GetMonoInstitutionsRequest, $0.MonoInstitutionsResponse>(
      '/banking.BankingService/GetMonoInstitutions',
      ($0.GetMonoInstitutionsRequest value) => value.writeToBuffer(),
      $0.MonoInstitutionsResponse.fromBuffer);
  static final _$getConnectWidgetConfig = $grpc.ClientMethod<
          $0.GetConnectWidgetConfigRequest, $0.ConnectWidgetConfigResponse>(
      '/banking.BankingService/GetConnectWidgetConfig',
      ($0.GetConnectWidgetConfigRequest value) => value.writeToBuffer(),
      $0.ConnectWidgetConfigResponse.fromBuffer);
  static final _$linkBankAccount =
      $grpc.ClientMethod<$0.LinkBankAccountRequest, $0.LinkBankAccountResponse>(
          '/banking.BankingService/LinkBankAccount',
          ($0.LinkBankAccountRequest value) => value.writeToBuffer(),
          $0.LinkBankAccountResponse.fromBuffer);
  static final _$getLinkedAccounts = $grpc.ClientMethod<
          $0.GetLinkedAccountsRequest, $0.LinkedAccountsResponse>(
      '/banking.BankingService/GetLinkedAccounts',
      ($0.GetLinkedAccountsRequest value) => value.writeToBuffer(),
      $0.LinkedAccountsResponse.fromBuffer);
  static final _$getLinkedAccount =
      $grpc.ClientMethod<$0.GetLinkedAccountRequest, $0.LinkedAccountResponse>(
          '/banking.BankingService/GetLinkedAccount',
          ($0.GetLinkedAccountRequest value) => value.writeToBuffer(),
          $0.LinkedAccountResponse.fromBuffer);
  static final _$unlinkBankAccount = $grpc.ClientMethod<
          $0.UnlinkBankAccountRequest, $0.UnlinkBankAccountResponse>(
      '/banking.BankingService/UnlinkBankAccount',
      ($0.UnlinkBankAccountRequest value) => value.writeToBuffer(),
      $0.UnlinkBankAccountResponse.fromBuffer);
  static final _$setDefaultLinkedAccount = $grpc.ClientMethod<
          $0.SetDefaultLinkedAccountRequest,
          $0.SetDefaultLinkedAccountResponse>(
      '/banking.BankingService/SetDefaultLinkedAccount',
      ($0.SetDefaultLinkedAccountRequest value) => value.writeToBuffer(),
      $0.SetDefaultLinkedAccountResponse.fromBuffer);
  static final _$refreshLinkedAccountBalance = $grpc.ClientMethod<
          $0.RefreshLinkedAccountBalanceRequest,
          $0.RefreshLinkedAccountBalanceResponse>(
      '/banking.BankingService/RefreshLinkedAccountBalance',
      ($0.RefreshLinkedAccountBalanceRequest value) => value.writeToBuffer(),
      $0.RefreshLinkedAccountBalanceResponse.fromBuffer);
  static final _$getReauthorizationToken = $grpc.ClientMethod<
          $0.GetReauthorizationTokenRequest,
          $0.GetReauthorizationTokenResponse>(
      '/banking.BankingService/GetReauthorizationToken',
      ($0.GetReauthorizationTokenRequest value) => value.writeToBuffer(),
      $0.GetReauthorizationTokenResponse.fromBuffer);
  static final _$initiateDeposit =
      $grpc.ClientMethod<$0.InitiateDepositRequest, $0.DepositResponse>(
          '/banking.BankingService/InitiateDeposit',
          ($0.InitiateDepositRequest value) => value.writeToBuffer(),
          $0.DepositResponse.fromBuffer);
  static final _$getDepositStatus =
      $grpc.ClientMethod<$0.GetDepositStatusRequest, $0.DepositResponse>(
          '/banking.BankingService/GetDepositStatus',
          ($0.GetDepositStatusRequest value) => value.writeToBuffer(),
          $0.DepositResponse.fromBuffer);
  static final _$getUserDeposits =
      $grpc.ClientMethod<$0.GetUserDepositsRequest, $0.DepositsResponse>(
          '/banking.BankingService/GetUserDeposits',
          ($0.GetUserDepositsRequest value) => value.writeToBuffer(),
          $0.DepositsResponse.fromBuffer);
  static final _$cancelDeposit =
      $grpc.ClientMethod<$0.CancelDepositRequest, $0.CancelDepositResponse>(
          '/banking.BankingService/CancelDeposit',
          ($0.CancelDepositRequest value) => value.writeToBuffer(),
          $0.CancelDepositResponse.fromBuffer);
  static final _$calculateDepositFee = $grpc.ClientMethod<
          $0.CalculateDepositFeeRequest, $0.CalculateDepositFeeResponse>(
      '/banking.BankingService/CalculateDepositFee',
      ($0.CalculateDepositFeeRequest value) => value.writeToBuffer(),
      $0.CalculateDepositFeeResponse.fromBuffer);
  static final _$createMandate =
      $grpc.ClientMethod<$0.CreateMandateRequest, $0.MandateResponse>(
          '/banking.BankingService/CreateMandate',
          ($0.CreateMandateRequest value) => value.writeToBuffer(),
          $0.MandateResponse.fromBuffer);
  static final _$getMandate =
      $grpc.ClientMethod<$0.GetMandateRequest, $0.MandateResponse>(
          '/banking.BankingService/GetMandate',
          ($0.GetMandateRequest value) => value.writeToBuffer(),
          $0.MandateResponse.fromBuffer);
  static final _$getUserMandates =
      $grpc.ClientMethod<$0.GetUserMandatesRequest, $0.MandatesResponse>(
          '/banking.BankingService/GetUserMandates',
          ($0.GetUserMandatesRequest value) => value.writeToBuffer(),
          $0.MandatesResponse.fromBuffer);
  static final _$pauseMandate =
      $grpc.ClientMethod<$0.PauseMandateRequest, $0.PauseMandateResponse>(
          '/banking.BankingService/PauseMandate',
          ($0.PauseMandateRequest value) => value.writeToBuffer(),
          $0.PauseMandateResponse.fromBuffer);
  static final _$reinstateMandate = $grpc.ClientMethod<
          $0.ReinstateMandateRequest, $0.ReinstateMandateResponse>(
      '/banking.BankingService/ReinstateMandate',
      ($0.ReinstateMandateRequest value) => value.writeToBuffer(),
      $0.ReinstateMandateResponse.fromBuffer);
  static final _$cancelMandate =
      $grpc.ClientMethod<$0.CancelMandateRequest, $0.CancelMandateResponse>(
          '/banking.BankingService/CancelMandate',
          ($0.CancelMandateRequest value) => value.writeToBuffer(),
          $0.CancelMandateResponse.fromBuffer);
  static final _$checkMandateBalance = $grpc.ClientMethod<
          $0.CheckMandateBalanceRequest, $0.CheckMandateBalanceResponse>(
      '/banking.BankingService/CheckMandateBalance',
      ($0.CheckMandateBalanceRequest value) => value.writeToBuffer(),
      $0.CheckMandateBalanceResponse.fromBuffer);
  static final _$initiateWithdrawal =
      $grpc.ClientMethod<$0.InitiateWithdrawalRequest, $0.WithdrawalResponse>(
          '/banking.BankingService/InitiateWithdrawal',
          ($0.InitiateWithdrawalRequest value) => value.writeToBuffer(),
          $0.WithdrawalResponse.fromBuffer);
  static final _$getWithdrawalStatus =
      $grpc.ClientMethod<$0.GetWithdrawalStatusRequest, $0.WithdrawalResponse>(
          '/banking.BankingService/GetWithdrawalStatus',
          ($0.GetWithdrawalStatusRequest value) => value.writeToBuffer(),
          $0.WithdrawalResponse.fromBuffer);
  static final _$getUserWithdrawals =
      $grpc.ClientMethod<$0.GetUserWithdrawalsRequest, $0.WithdrawalsResponse>(
          '/banking.BankingService/GetUserWithdrawals',
          ($0.GetUserWithdrawalsRequest value) => value.writeToBuffer(),
          $0.WithdrawalsResponse.fromBuffer);
  static final _$calculateWithdrawalFee = $grpc.ClientMethod<
          $0.CalculateWithdrawalFeeRequest, $0.CalculateWithdrawalFeeResponse>(
      '/banking.BankingService/CalculateWithdrawalFee',
      ($0.CalculateWithdrawalFeeRequest value) => value.writeToBuffer(),
      $0.CalculateWithdrawalFeeResponse.fromBuffer);
  static final _$getTransferFee =
      $grpc.ClientMethod<$0.GetTransferFeeRequest, $0.GetTransferFeeResponse>(
          '/banking.BankingService/GetTransferFee',
          ($0.GetTransferFeeRequest value) => value.writeToBuffer(),
          $0.GetTransferFeeResponse.fromBuffer);
}

@$pb.GrpcServiceName('banking.BankingService')
abstract class BankingServiceBase extends $grpc.Service {
  $core.String get $name => 'banking.BankingService';

  BankingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateVirtualAccountRequest,
            $0.VirtualAccountResponse>(
        'CreateVirtualAccount',
        createVirtualAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateVirtualAccountRequest.fromBuffer(value),
        ($0.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVirtualAccountRequest,
            $0.VirtualAccountResponse>(
        'GetVirtualAccount',
        getVirtualAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVirtualAccountRequest.fromBuffer(value),
        ($0.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserVirtualAccountsRequest,
            $0.VirtualAccountsResponse>(
        'GetUserVirtualAccounts',
        getUserVirtualAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserVirtualAccountsRequest.fromBuffer(value),
        ($0.VirtualAccountsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DomesticTransferRequest, $0.TransferResponse>(
            'InitiateDomesticTransfer',
            initiateDomesticTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DomesticTransferRequest.fromBuffer(value),
            ($0.TransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetTransferStatusRequest, $0.TransferResponse>(
            'GetTransferStatus',
            getTransferStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetTransferStatusRequest.fromBuffer(value),
            ($0.TransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserTransfersRequest, $0.TransfersResponse>(
            'GetUserTransfers',
            getUserTransfers_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserTransfersRequest.fromBuffer(value),
            ($0.TransfersResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.InternalTransferRequest, $0.TransferResponse>(
            'InitiateInternalTransfer',
            initiateInternalTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.InternalTransferRequest.fromBuffer(value),
            ($0.TransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InternationalTransferRequest,
            $0.TransferResponse>(
        'InitiateInternationalTransfer',
        initiateInternationalTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InternationalTransferRequest.fromBuffer(value),
        ($0.TransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetExchangeRateRequest, $0.ExchangeRateResponse>(
            'GetExchangeRate',
            getExchangeRate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetExchangeRateRequest.fromBuffer(value),
            ($0.ExchangeRateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSupportedCountriesRequest,
            $0.SupportedCountriesResponse>(
        'GetSupportedCountries',
        getSupportedCountries_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSupportedCountriesRequest.fromBuffer(value),
        ($0.SupportedCountriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBankAccountRequest,
            $0.VerifyBankAccountResponse>(
        'VerifyBankAccount',
        verifyBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyBankAccountRequest.fromBuffer(value),
        ($0.VerifyBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBanksRequest, $0.BanksResponse>(
        'GetBanks',
        getBanks_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBanksRequest.fromBuffer(value),
        ($0.BanksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBVNRequest,
            $0.IdentityVerificationResponse>(
        'VerifyBVN',
        verifyBVN_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifyBVNRequest.fromBuffer(value),
        ($0.IdentityVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVerificationStatusRequest,
            $0.IdentityVerificationResponse>(
        'GetVerificationStatus',
        getVerificationStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetVerificationStatusRequest.fromBuffer(value),
        ($0.IdentityVerificationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyBVNForSignupRequest,
            $0.SignupIdentityVerificationResponse>(
        'VerifyBVNForSignup',
        verifyBVNForSignup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyBVNForSignupRequest.fromBuffer(value),
        ($0.SignupIdentityVerificationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifyNINForSignupRequest,
            $0.SignupIdentityVerificationResponse>(
        'VerifyNINForSignup',
        verifyNINForSignup_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.VerifyNINForSignupRequest.fromBuffer(value),
        ($0.SignupIdentityVerificationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateVirtualAccountForUserRequest,
            $0.VirtualAccountResponse>(
        'CreateVirtualAccountForUser',
        createVirtualAccountForUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateVirtualAccountForUserRequest.fromBuffer(value),
        ($0.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UsernameTransferRequest, $0.TransferResponse>(
            'InitiateUsernameTransfer',
            initiateUsernameTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UsernameTransferRequest.fromBuffer(value),
            ($0.TransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PhoneTransferRequest, $0.TransferResponse>(
            'InitiatePhoneTransfer',
            initiatePhoneTransfer_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PhoneTransferRequest.fromBuffer(value),
            ($0.TransferResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.SearchRecipientsRequest, $0.RecipientsResponse>(
            'SearchRecipients',
            searchRecipients_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.SearchRecipientsRequest.fromBuffer(value),
            ($0.RecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetRecentRecipientsRequest,
            $0.RecipientsResponse>(
        'GetRecentRecipients',
        getRecentRecipients_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetRecentRecipientsRequest.fromBuffer(value),
        ($0.RecipientsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProviderStatusRequest,
            $0.ProviderStatusResponse>(
        'GetProviderStatus',
        getProviderStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetProviderStatusRequest.fromBuffer(value),
        ($0.ProviderStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetActiveProvidersRequest,
            $0.ActiveProvidersResponse>(
        'GetActiveProviders',
        getActiveProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetActiveProvidersRequest.fromBuffer(value),
        ($0.ActiveProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountBalanceRequest,
            $0.AccountBalanceResponse>(
        'GetAccountBalance',
        getAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountBalanceRequest.fromBuffer(value),
        ($0.AccountBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountTransactionsRequest,
            $0.TransactionsResponse>(
        'GetAccountTransactions',
        getAccountTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountTransactionsRequest.fromBuffer(value),
        ($0.TransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPrimaryAccountRequest,
            $0.VirtualAccountResponse>(
        'GetPrimaryAccount',
        getPrimaryAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetPrimaryAccountRequest.fromBuffer(value),
        ($0.VirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.FreezeAccountRequest, $0.FreezeAccountResponse>(
            'FreezeAccount',
            freezeAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.FreezeAccountRequest.fromBuffer(value),
            ($0.FreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnfreezeAccountRequest,
            $0.UnfreezeAccountResponse>(
        'UnfreezeAccount',
        unfreezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnfreezeAccountRequest.fromBuffer(value),
        ($0.UnfreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetDailyUsageRequest, $0.DailyUsageResponse>(
            'GetDailyUsage',
            getDailyUsage_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetDailyUsageRequest.fromBuffer(value),
            ($0.DailyUsageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RunReconciliationRequest,
            $0.ReconciliationResponse>(
        'RunReconciliation',
        runReconciliation_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RunReconciliationRequest.fromBuffer(value),
        ($0.ReconciliationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReconciliationHistoryRequest,
            $0.ReconciliationHistoryResponse>(
        'GetReconciliationHistory',
        getReconciliationHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetReconciliationHistoryRequest.fromBuffer(value),
        ($0.ReconciliationHistoryResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetDailyReportRequest, $0.DailyReportResponse>(
            'GetDailyReport',
            getDailyReport_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetDailyReportRequest.fromBuffer(value),
            ($0.DailyReportResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMonoInstitutionsRequest,
            $0.MonoInstitutionsResponse>(
        'GetMonoInstitutions',
        getMonoInstitutions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetMonoInstitutionsRequest.fromBuffer(value),
        ($0.MonoInstitutionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetConnectWidgetConfigRequest,
            $0.ConnectWidgetConfigResponse>(
        'GetConnectWidgetConfig',
        getConnectWidgetConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetConnectWidgetConfigRequest.fromBuffer(value),
        ($0.ConnectWidgetConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LinkBankAccountRequest,
            $0.LinkBankAccountResponse>(
        'LinkBankAccount',
        linkBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LinkBankAccountRequest.fromBuffer(value),
        ($0.LinkBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLinkedAccountsRequest,
            $0.LinkedAccountsResponse>(
        'GetLinkedAccounts',
        getLinkedAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLinkedAccountsRequest.fromBuffer(value),
        ($0.LinkedAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLinkedAccountRequest,
            $0.LinkedAccountResponse>(
        'GetLinkedAccount',
        getLinkedAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetLinkedAccountRequest.fromBuffer(value),
        ($0.LinkedAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlinkBankAccountRequest,
            $0.UnlinkBankAccountResponse>(
        'UnlinkBankAccount',
        unlinkBankAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UnlinkBankAccountRequest.fromBuffer(value),
        ($0.UnlinkBankAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetDefaultLinkedAccountRequest,
            $0.SetDefaultLinkedAccountResponse>(
        'SetDefaultLinkedAccount',
        setDefaultLinkedAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetDefaultLinkedAccountRequest.fromBuffer(value),
        ($0.SetDefaultLinkedAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RefreshLinkedAccountBalanceRequest,
            $0.RefreshLinkedAccountBalanceResponse>(
        'RefreshLinkedAccountBalance',
        refreshLinkedAccountBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RefreshLinkedAccountBalanceRequest.fromBuffer(value),
        ($0.RefreshLinkedAccountBalanceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetReauthorizationTokenRequest,
            $0.GetReauthorizationTokenResponse>(
        'GetReauthorizationToken',
        getReauthorizationToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetReauthorizationTokenRequest.fromBuffer(value),
        ($0.GetReauthorizationTokenResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.InitiateDepositRequest, $0.DepositResponse>(
            'InitiateDeposit',
            initiateDeposit_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.InitiateDepositRequest.fromBuffer(value),
            ($0.DepositResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetDepositStatusRequest, $0.DepositResponse>(
            'GetDepositStatus',
            getDepositStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetDepositStatusRequest.fromBuffer(value),
            ($0.DepositResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserDepositsRequest, $0.DepositsResponse>(
            'GetUserDeposits',
            getUserDeposits_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserDepositsRequest.fromBuffer(value),
            ($0.DepositsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CancelDepositRequest, $0.CancelDepositResponse>(
            'CancelDeposit',
            cancelDeposit_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CancelDepositRequest.fromBuffer(value),
            ($0.CancelDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CalculateDepositFeeRequest,
            $0.CalculateDepositFeeResponse>(
        'CalculateDepositFee',
        calculateDepositFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CalculateDepositFeeRequest.fromBuffer(value),
        ($0.CalculateDepositFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateMandateRequest, $0.MandateResponse>(
        'CreateMandate',
        createMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateMandateRequest.fromBuffer(value),
        ($0.MandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMandateRequest, $0.MandateResponse>(
        'GetMandate',
        getMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMandateRequest.fromBuffer(value),
        ($0.MandateResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetUserMandatesRequest, $0.MandatesResponse>(
            'GetUserMandates',
            getUserMandates_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetUserMandatesRequest.fromBuffer(value),
            ($0.MandatesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PauseMandateRequest, $0.PauseMandateResponse>(
            'PauseMandate',
            pauseMandate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PauseMandateRequest.fromBuffer(value),
            ($0.PauseMandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReinstateMandateRequest,
            $0.ReinstateMandateResponse>(
        'ReinstateMandate',
        reinstateMandate_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReinstateMandateRequest.fromBuffer(value),
        ($0.ReinstateMandateResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.CancelMandateRequest, $0.CancelMandateResponse>(
            'CancelMandate',
            cancelMandate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CancelMandateRequest.fromBuffer(value),
            ($0.CancelMandateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CheckMandateBalanceRequest,
            $0.CheckMandateBalanceResponse>(
        'CheckMandateBalance',
        checkMandateBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CheckMandateBalanceRequest.fromBuffer(value),
        ($0.CheckMandateBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.InitiateWithdrawalRequest,
            $0.WithdrawalResponse>(
        'InitiateWithdrawal',
        initiateWithdrawal_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.InitiateWithdrawalRequest.fromBuffer(value),
        ($0.WithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetWithdrawalStatusRequest,
            $0.WithdrawalResponse>(
        'GetWithdrawalStatus',
        getWithdrawalStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetWithdrawalStatusRequest.fromBuffer(value),
        ($0.WithdrawalResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserWithdrawalsRequest,
            $0.WithdrawalsResponse>(
        'GetUserWithdrawals',
        getUserWithdrawals_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetUserWithdrawalsRequest.fromBuffer(value),
        ($0.WithdrawalsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CalculateWithdrawalFeeRequest,
            $0.CalculateWithdrawalFeeResponse>(
        'CalculateWithdrawalFee',
        calculateWithdrawalFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CalculateWithdrawalFeeRequest.fromBuffer(value),
        ($0.CalculateWithdrawalFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferFeeRequest,
            $0.GetTransferFeeResponse>(
        'GetTransferFee',
        getTransferFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransferFeeRequest.fromBuffer(value),
        ($0.GetTransferFeeResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.VirtualAccountResponse> createVirtualAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateVirtualAccountRequest> $request) async {
    return createVirtualAccount($call, await $request);
  }

  $async.Future<$0.VirtualAccountResponse> createVirtualAccount(
      $grpc.ServiceCall call, $0.CreateVirtualAccountRequest request);

  $async.Future<$0.VirtualAccountResponse> getVirtualAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVirtualAccountRequest> $request) async {
    return getVirtualAccount($call, await $request);
  }

  $async.Future<$0.VirtualAccountResponse> getVirtualAccount(
      $grpc.ServiceCall call, $0.GetVirtualAccountRequest request);

  $async.Future<$0.VirtualAccountsResponse> getUserVirtualAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserVirtualAccountsRequest> $request) async {
    return getUserVirtualAccounts($call, await $request);
  }

  $async.Future<$0.VirtualAccountsResponse> getUserVirtualAccounts(
      $grpc.ServiceCall call, $0.GetUserVirtualAccountsRequest request);

  $async.Future<$0.TransferResponse> initiateDomesticTransfer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.DomesticTransferRequest> $request) async {
    return initiateDomesticTransfer($call, await $request);
  }

  $async.Future<$0.TransferResponse> initiateDomesticTransfer(
      $grpc.ServiceCall call, $0.DomesticTransferRequest request);

  $async.Future<$0.TransferResponse> getTransferStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTransferStatusRequest> $request) async {
    return getTransferStatus($call, await $request);
  }

  $async.Future<$0.TransferResponse> getTransferStatus(
      $grpc.ServiceCall call, $0.GetTransferStatusRequest request);

  $async.Future<$0.TransfersResponse> getUserTransfers_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserTransfersRequest> $request) async {
    return getUserTransfers($call, await $request);
  }

  $async.Future<$0.TransfersResponse> getUserTransfers(
      $grpc.ServiceCall call, $0.GetUserTransfersRequest request);

  $async.Future<$0.TransferResponse> initiateInternalTransfer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InternalTransferRequest> $request) async {
    return initiateInternalTransfer($call, await $request);
  }

  $async.Future<$0.TransferResponse> initiateInternalTransfer(
      $grpc.ServiceCall call, $0.InternalTransferRequest request);

  $async.Future<$0.TransferResponse> initiateInternationalTransfer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InternationalTransferRequest> $request) async {
    return initiateInternationalTransfer($call, await $request);
  }

  $async.Future<$0.TransferResponse> initiateInternationalTransfer(
      $grpc.ServiceCall call, $0.InternationalTransferRequest request);

  $async.Future<$0.ExchangeRateResponse> getExchangeRate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetExchangeRateRequest> $request) async {
    return getExchangeRate($call, await $request);
  }

  $async.Future<$0.ExchangeRateResponse> getExchangeRate(
      $grpc.ServiceCall call, $0.GetExchangeRateRequest request);

  $async.Future<$0.SupportedCountriesResponse> getSupportedCountries_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSupportedCountriesRequest> $request) async {
    return getSupportedCountries($call, await $request);
  }

  $async.Future<$0.SupportedCountriesResponse> getSupportedCountries(
      $grpc.ServiceCall call, $0.GetSupportedCountriesRequest request);

  $async.Future<$0.VerifyBankAccountResponse> verifyBankAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyBankAccountRequest> $request) async {
    return verifyBankAccount($call, await $request);
  }

  $async.Future<$0.VerifyBankAccountResponse> verifyBankAccount(
      $grpc.ServiceCall call, $0.VerifyBankAccountRequest request);

  $async.Future<$0.BanksResponse> getBanks_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetBanksRequest> $request) async {
    return getBanks($call, await $request);
  }

  $async.Future<$0.BanksResponse> getBanks(
      $grpc.ServiceCall call, $0.GetBanksRequest request);

  $async.Future<$0.IdentityVerificationResponse> verifyBVN_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyBVNRequest> $request) async {
    return verifyBVN($call, await $request);
  }

  $async.Future<$0.IdentityVerificationResponse> verifyBVN(
      $grpc.ServiceCall call, $0.VerifyBVNRequest request);

  $async.Future<$0.IdentityVerificationResponse> getVerificationStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetVerificationStatusRequest> $request) async {
    return getVerificationStatus($call, await $request);
  }

  $async.Future<$0.IdentityVerificationResponse> getVerificationStatus(
      $grpc.ServiceCall call, $0.GetVerificationStatusRequest request);

  $async.Future<$0.SignupIdentityVerificationResponse> verifyBVNForSignup_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyBVNForSignupRequest> $request) async {
    return verifyBVNForSignup($call, await $request);
  }

  $async.Future<$0.SignupIdentityVerificationResponse> verifyBVNForSignup(
      $grpc.ServiceCall call, $0.VerifyBVNForSignupRequest request);

  $async.Future<$0.SignupIdentityVerificationResponse> verifyNINForSignup_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.VerifyNINForSignupRequest> $request) async {
    return verifyNINForSignup($call, await $request);
  }

  $async.Future<$0.SignupIdentityVerificationResponse> verifyNINForSignup(
      $grpc.ServiceCall call, $0.VerifyNINForSignupRequest request);

  $async.Future<$0.VirtualAccountResponse> createVirtualAccountForUser_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CreateVirtualAccountForUserRequest> $request) async {
    return createVirtualAccountForUser($call, await $request);
  }

  $async.Future<$0.VirtualAccountResponse> createVirtualAccountForUser(
      $grpc.ServiceCall call, $0.CreateVirtualAccountForUserRequest request);

  $async.Future<$0.TransferResponse> initiateUsernameTransfer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UsernameTransferRequest> $request) async {
    return initiateUsernameTransfer($call, await $request);
  }

  $async.Future<$0.TransferResponse> initiateUsernameTransfer(
      $grpc.ServiceCall call, $0.UsernameTransferRequest request);

  $async.Future<$0.TransferResponse> initiatePhoneTransfer_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PhoneTransferRequest> $request) async {
    return initiatePhoneTransfer($call, await $request);
  }

  $async.Future<$0.TransferResponse> initiatePhoneTransfer(
      $grpc.ServiceCall call, $0.PhoneTransferRequest request);

  $async.Future<$0.RecipientsResponse> searchRecipients_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SearchRecipientsRequest> $request) async {
    return searchRecipients($call, await $request);
  }

  $async.Future<$0.RecipientsResponse> searchRecipients(
      $grpc.ServiceCall call, $0.SearchRecipientsRequest request);

  $async.Future<$0.RecipientsResponse> getRecentRecipients_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetRecentRecipientsRequest> $request) async {
    return getRecentRecipients($call, await $request);
  }

  $async.Future<$0.RecipientsResponse> getRecentRecipients(
      $grpc.ServiceCall call, $0.GetRecentRecipientsRequest request);

  $async.Future<$0.ProviderStatusResponse> getProviderStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetProviderStatusRequest> $request) async {
    return getProviderStatus($call, await $request);
  }

  $async.Future<$0.ProviderStatusResponse> getProviderStatus(
      $grpc.ServiceCall call, $0.GetProviderStatusRequest request);

  $async.Future<$0.ActiveProvidersResponse> getActiveProviders_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetActiveProvidersRequest> $request) async {
    return getActiveProviders($call, await $request);
  }

  $async.Future<$0.ActiveProvidersResponse> getActiveProviders(
      $grpc.ServiceCall call, $0.GetActiveProvidersRequest request);

  $async.Future<$0.AccountBalanceResponse> getAccountBalance_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountBalanceRequest> $request) async {
    return getAccountBalance($call, await $request);
  }

  $async.Future<$0.AccountBalanceResponse> getAccountBalance(
      $grpc.ServiceCall call, $0.GetAccountBalanceRequest request);

  $async.Future<$0.TransactionsResponse> getAccountTransactions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetAccountTransactionsRequest> $request) async {
    return getAccountTransactions($call, await $request);
  }

  $async.Future<$0.TransactionsResponse> getAccountTransactions(
      $grpc.ServiceCall call, $0.GetAccountTransactionsRequest request);

  $async.Future<$0.VirtualAccountResponse> getPrimaryAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetPrimaryAccountRequest> $request) async {
    return getPrimaryAccount($call, await $request);
  }

  $async.Future<$0.VirtualAccountResponse> getPrimaryAccount(
      $grpc.ServiceCall call, $0.GetPrimaryAccountRequest request);

  $async.Future<$0.FreezeAccountResponse> freezeAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.FreezeAccountRequest> $request) async {
    return freezeAccount($call, await $request);
  }

  $async.Future<$0.FreezeAccountResponse> freezeAccount(
      $grpc.ServiceCall call, $0.FreezeAccountRequest request);

  $async.Future<$0.UnfreezeAccountResponse> unfreezeAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UnfreezeAccountRequest> $request) async {
    return unfreezeAccount($call, await $request);
  }

  $async.Future<$0.UnfreezeAccountResponse> unfreezeAccount(
      $grpc.ServiceCall call, $0.UnfreezeAccountRequest request);

  $async.Future<$0.DailyUsageResponse> getDailyUsage_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDailyUsageRequest> $request) async {
    return getDailyUsage($call, await $request);
  }

  $async.Future<$0.DailyUsageResponse> getDailyUsage(
      $grpc.ServiceCall call, $0.GetDailyUsageRequest request);

  $async.Future<$0.ReconciliationResponse> runReconciliation_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RunReconciliationRequest> $request) async {
    return runReconciliation($call, await $request);
  }

  $async.Future<$0.ReconciliationResponse> runReconciliation(
      $grpc.ServiceCall call, $0.RunReconciliationRequest request);

  $async.Future<$0.ReconciliationHistoryResponse> getReconciliationHistory_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetReconciliationHistoryRequest> $request) async {
    return getReconciliationHistory($call, await $request);
  }

  $async.Future<$0.ReconciliationHistoryResponse> getReconciliationHistory(
      $grpc.ServiceCall call, $0.GetReconciliationHistoryRequest request);

  $async.Future<$0.DailyReportResponse> getDailyReport_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDailyReportRequest> $request) async {
    return getDailyReport($call, await $request);
  }

  $async.Future<$0.DailyReportResponse> getDailyReport(
      $grpc.ServiceCall call, $0.GetDailyReportRequest request);

  $async.Future<$0.MonoInstitutionsResponse> getMonoInstitutions_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetMonoInstitutionsRequest> $request) async {
    return getMonoInstitutions($call, await $request);
  }

  $async.Future<$0.MonoInstitutionsResponse> getMonoInstitutions(
      $grpc.ServiceCall call, $0.GetMonoInstitutionsRequest request);

  $async.Future<$0.ConnectWidgetConfigResponse> getConnectWidgetConfig_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetConnectWidgetConfigRequest> $request) async {
    return getConnectWidgetConfig($call, await $request);
  }

  $async.Future<$0.ConnectWidgetConfigResponse> getConnectWidgetConfig(
      $grpc.ServiceCall call, $0.GetConnectWidgetConfigRequest request);

  $async.Future<$0.LinkBankAccountResponse> linkBankAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.LinkBankAccountRequest> $request) async {
    return linkBankAccount($call, await $request);
  }

  $async.Future<$0.LinkBankAccountResponse> linkBankAccount(
      $grpc.ServiceCall call, $0.LinkBankAccountRequest request);

  $async.Future<$0.LinkedAccountsResponse> getLinkedAccounts_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLinkedAccountsRequest> $request) async {
    return getLinkedAccounts($call, await $request);
  }

  $async.Future<$0.LinkedAccountsResponse> getLinkedAccounts(
      $grpc.ServiceCall call, $0.GetLinkedAccountsRequest request);

  $async.Future<$0.LinkedAccountResponse> getLinkedAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetLinkedAccountRequest> $request) async {
    return getLinkedAccount($call, await $request);
  }

  $async.Future<$0.LinkedAccountResponse> getLinkedAccount(
      $grpc.ServiceCall call, $0.GetLinkedAccountRequest request);

  $async.Future<$0.UnlinkBankAccountResponse> unlinkBankAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.UnlinkBankAccountRequest> $request) async {
    return unlinkBankAccount($call, await $request);
  }

  $async.Future<$0.UnlinkBankAccountResponse> unlinkBankAccount(
      $grpc.ServiceCall call, $0.UnlinkBankAccountRequest request);

  $async.Future<$0.SetDefaultLinkedAccountResponse> setDefaultLinkedAccount_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SetDefaultLinkedAccountRequest> $request) async {
    return setDefaultLinkedAccount($call, await $request);
  }

  $async.Future<$0.SetDefaultLinkedAccountResponse> setDefaultLinkedAccount(
      $grpc.ServiceCall call, $0.SetDefaultLinkedAccountRequest request);

  $async.Future<$0.RefreshLinkedAccountBalanceResponse>
      refreshLinkedAccountBalance_Pre($grpc.ServiceCall $call,
          $async.Future<$0.RefreshLinkedAccountBalanceRequest> $request) async {
    return refreshLinkedAccountBalance($call, await $request);
  }

  $async.Future<$0.RefreshLinkedAccountBalanceResponse>
      refreshLinkedAccountBalance($grpc.ServiceCall call,
          $0.RefreshLinkedAccountBalanceRequest request);

  $async.Future<$0.GetReauthorizationTokenResponse> getReauthorizationToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetReauthorizationTokenRequest> $request) async {
    return getReauthorizationToken($call, await $request);
  }

  $async.Future<$0.GetReauthorizationTokenResponse> getReauthorizationToken(
      $grpc.ServiceCall call, $0.GetReauthorizationTokenRequest request);

  $async.Future<$0.DepositResponse> initiateDeposit_Pre($grpc.ServiceCall $call,
      $async.Future<$0.InitiateDepositRequest> $request) async {
    return initiateDeposit($call, await $request);
  }

  $async.Future<$0.DepositResponse> initiateDeposit(
      $grpc.ServiceCall call, $0.InitiateDepositRequest request);

  $async.Future<$0.DepositResponse> getDepositStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetDepositStatusRequest> $request) async {
    return getDepositStatus($call, await $request);
  }

  $async.Future<$0.DepositResponse> getDepositStatus(
      $grpc.ServiceCall call, $0.GetDepositStatusRequest request);

  $async.Future<$0.DepositsResponse> getUserDeposits_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserDepositsRequest> $request) async {
    return getUserDeposits($call, await $request);
  }

  $async.Future<$0.DepositsResponse> getUserDeposits(
      $grpc.ServiceCall call, $0.GetUserDepositsRequest request);

  $async.Future<$0.CancelDepositResponse> cancelDeposit_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelDepositRequest> $request) async {
    return cancelDeposit($call, await $request);
  }

  $async.Future<$0.CancelDepositResponse> cancelDeposit(
      $grpc.ServiceCall call, $0.CancelDepositRequest request);

  $async.Future<$0.CalculateDepositFeeResponse> calculateDepositFee_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CalculateDepositFeeRequest> $request) async {
    return calculateDepositFee($call, await $request);
  }

  $async.Future<$0.CalculateDepositFeeResponse> calculateDepositFee(
      $grpc.ServiceCall call, $0.CalculateDepositFeeRequest request);

  $async.Future<$0.MandateResponse> createMandate_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateMandateRequest> $request) async {
    return createMandate($call, await $request);
  }

  $async.Future<$0.MandateResponse> createMandate(
      $grpc.ServiceCall call, $0.CreateMandateRequest request);

  $async.Future<$0.MandateResponse> getMandate_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetMandateRequest> $request) async {
    return getMandate($call, await $request);
  }

  $async.Future<$0.MandateResponse> getMandate(
      $grpc.ServiceCall call, $0.GetMandateRequest request);

  $async.Future<$0.MandatesResponse> getUserMandates_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserMandatesRequest> $request) async {
    return getUserMandates($call, await $request);
  }

  $async.Future<$0.MandatesResponse> getUserMandates(
      $grpc.ServiceCall call, $0.GetUserMandatesRequest request);

  $async.Future<$0.PauseMandateResponse> pauseMandate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PauseMandateRequest> $request) async {
    return pauseMandate($call, await $request);
  }

  $async.Future<$0.PauseMandateResponse> pauseMandate(
      $grpc.ServiceCall call, $0.PauseMandateRequest request);

  $async.Future<$0.ReinstateMandateResponse> reinstateMandate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReinstateMandateRequest> $request) async {
    return reinstateMandate($call, await $request);
  }

  $async.Future<$0.ReinstateMandateResponse> reinstateMandate(
      $grpc.ServiceCall call, $0.ReinstateMandateRequest request);

  $async.Future<$0.CancelMandateResponse> cancelMandate_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CancelMandateRequest> $request) async {
    return cancelMandate($call, await $request);
  }

  $async.Future<$0.CancelMandateResponse> cancelMandate(
      $grpc.ServiceCall call, $0.CancelMandateRequest request);

  $async.Future<$0.CheckMandateBalanceResponse> checkMandateBalance_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CheckMandateBalanceRequest> $request) async {
    return checkMandateBalance($call, await $request);
  }

  $async.Future<$0.CheckMandateBalanceResponse> checkMandateBalance(
      $grpc.ServiceCall call, $0.CheckMandateBalanceRequest request);

  $async.Future<$0.WithdrawalResponse> initiateWithdrawal_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.InitiateWithdrawalRequest> $request) async {
    return initiateWithdrawal($call, await $request);
  }

  $async.Future<$0.WithdrawalResponse> initiateWithdrawal(
      $grpc.ServiceCall call, $0.InitiateWithdrawalRequest request);

  $async.Future<$0.WithdrawalResponse> getWithdrawalStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetWithdrawalStatusRequest> $request) async {
    return getWithdrawalStatus($call, await $request);
  }

  $async.Future<$0.WithdrawalResponse> getWithdrawalStatus(
      $grpc.ServiceCall call, $0.GetWithdrawalStatusRequest request);

  $async.Future<$0.WithdrawalsResponse> getUserWithdrawals_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetUserWithdrawalsRequest> $request) async {
    return getUserWithdrawals($call, await $request);
  }

  $async.Future<$0.WithdrawalsResponse> getUserWithdrawals(
      $grpc.ServiceCall call, $0.GetUserWithdrawalsRequest request);

  $async.Future<$0.CalculateWithdrawalFeeResponse> calculateWithdrawalFee_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.CalculateWithdrawalFeeRequest> $request) async {
    return calculateWithdrawalFee($call, await $request);
  }

  $async.Future<$0.CalculateWithdrawalFeeResponse> calculateWithdrawalFee(
      $grpc.ServiceCall call, $0.CalculateWithdrawalFeeRequest request);

  $async.Future<$0.GetTransferFeeResponse> getTransferFee_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetTransferFeeRequest> $request) async {
    return getTransferFee($call, await $request);
  }

  $async.Future<$0.GetTransferFeeResponse> getTransferFee(
      $grpc.ServiceCall call, $0.GetTransferFeeRequest request);
}
