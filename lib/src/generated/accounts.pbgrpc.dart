//
//  Generated code. Do not modify.
//  source: accounts.proto
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

import 'accounts.pb.dart' as $0;

export 'accounts.pb.dart';

@$pb.GrpcServiceName('accounts.AccountsService')
class AccountsServiceClient extends $grpc.Client {
  static final _$createAccount = $grpc.ClientMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
      '/accounts.AccountsService/CreateAccount',
      ($0.CreateAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateAccountResponse.fromBuffer(value));
  static final _$getAccounts = $grpc.ClientMethod<$0.GetAccountsRequest, $0.GetAccountsResponse>(
      '/accounts.AccountsService/GetAccounts',
      ($0.GetAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAccountsResponse.fromBuffer(value));
  static final _$getUserAccounts = $grpc.ClientMethod<$0.GetUserAccountsRequest, $0.GetUserAccountsResponse>(
      '/accounts.AccountsService/GetUserAccounts',
      ($0.GetUserAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserAccountsResponse.fromBuffer(value));
  static final _$getAccount = $grpc.ClientMethod<$0.GetAccountRequest, $0.GetAccountResponse>(
      '/accounts.AccountsService/GetAccount',
      ($0.GetAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAccountResponse.fromBuffer(value));
  static final _$updateAccount = $grpc.ClientMethod<$0.UpdateAccountRequest, $0.UpdateAccountResponse>(
      '/accounts.AccountsService/UpdateAccount',
      ($0.UpdateAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateAccountResponse.fromBuffer(value));
  static final _$deleteAccount = $grpc.ClientMethod<$0.DeleteAccountRequest, $0.DeleteAccountResponse>(
      '/accounts.AccountsService/DeleteAccount',
      ($0.DeleteAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteAccountResponse.fromBuffer(value));
  static final _$getBalance = $grpc.ClientMethod<$0.GetBalanceRequest, $0.GetBalanceResponse>(
      '/accounts.AccountsService/GetBalance',
      ($0.GetBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBalanceResponse.fromBuffer(value));
  static final _$getTransactions = $grpc.ClientMethod<$0.GetTransactionsRequest, $0.GetTransactionsResponse>(
      '/accounts.AccountsService/GetTransactions',
      ($0.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTransactionsResponse.fromBuffer(value));
  static final _$freezeAccount = $grpc.ClientMethod<$0.FreezeAccountRequest, $0.FreezeAccountResponse>(
      '/accounts.AccountsService/FreezeAccount',
      ($0.FreezeAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.FreezeAccountResponse.fromBuffer(value));
  static final _$unfreezeAccount = $grpc.ClientMethod<$0.UnfreezeAccountRequest, $0.UnfreezeAccountResponse>(
      '/accounts.AccountsService/UnfreezeAccount',
      ($0.UnfreezeAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnfreezeAccountResponse.fromBuffer(value));
  static final _$updateBalance = $grpc.ClientMethod<$0.UpdateBalanceRequest, $0.UpdateBalanceResponse>(
      '/accounts.AccountsService/UpdateBalance',
      ($0.UpdateBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateBalanceResponse.fromBuffer(value));
  static final _$creditBalance = $grpc.ClientMethod<$0.CreditBalanceRequest, $0.CreditBalanceResponse>(
      '/accounts.AccountsService/CreditBalance',
      ($0.CreditBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreditBalanceResponse.fromBuffer(value));
  static final _$debitBalance = $grpc.ClientMethod<$0.DebitBalanceRequest, $0.DebitBalanceResponse>(
      '/accounts.AccountsService/DebitBalance',
      ($0.DebitBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DebitBalanceResponse.fromBuffer(value));
  static final _$transferBalance = $grpc.ClientMethod<$0.TransferBalanceRequest, $0.TransferBalanceResponse>(
      '/accounts.AccountsService/TransferBalance',
      ($0.TransferBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TransferBalanceResponse.fromBuffer(value));
  static final _$holdFunds = $grpc.ClientMethod<$0.HoldFundsRequest, $0.HoldFundsResponse>(
      '/accounts.AccountsService/HoldFunds',
      ($0.HoldFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HoldFundsResponse.fromBuffer(value));
  static final _$captureHold = $grpc.ClientMethod<$0.CaptureHoldRequest, $0.CaptureHoldResponse>(
      '/accounts.AccountsService/CaptureHold',
      ($0.CaptureHoldRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CaptureHoldResponse.fromBuffer(value));
  static final _$releaseHold = $grpc.ClientMethod<$0.ReleaseHoldRequest, $0.ReleaseHoldResponse>(
      '/accounts.AccountsService/ReleaseHold',
      ($0.ReleaseHoldRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ReleaseHoldResponse.fromBuffer(value));
  static final _$creditToClearing = $grpc.ClientMethod<$0.CreditToClearingRequest, $0.CreditToClearingResponse>(
      '/accounts.AccountsService/CreditToClearing',
      ($0.CreditToClearingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreditToClearingResponse.fromBuffer(value));
  static final _$clearDeposit = $grpc.ClientMethod<$0.ClearDepositRequest, $0.ClearDepositResponse>(
      '/accounts.AccountsService/ClearDeposit',
      ($0.ClearDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ClearDepositResponse.fromBuffer(value));
  static final _$reverseClearingDeposit = $grpc.ClientMethod<$0.ReverseClearingDepositRequest, $0.ReverseClearingDepositResponse>(
      '/accounts.AccountsService/ReverseClearingDeposit',
      ($0.ReverseClearingDepositRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ReverseClearingDepositResponse.fromBuffer(value));
  static final _$transferToPlatformWallet = $grpc.ClientMethod<$0.TransferToPlatformWalletRequest, $0.TransferToPlatformWalletResponse>(
      '/accounts.AccountsService/TransferToPlatformWallet',
      ($0.TransferToPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TransferToPlatformWalletResponse.fromBuffer(value));
  static final _$transferFromPlatformWallet = $grpc.ClientMethod<$0.TransferFromPlatformWalletRequest, $0.TransferFromPlatformWalletResponse>(
      '/accounts.AccountsService/TransferFromPlatformWallet',
      ($0.TransferFromPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TransferFromPlatformWalletResponse.fromBuffer(value));
  static final _$creditPlatformWallet = $grpc.ClientMethod<$0.CreditPlatformWalletRequest, $0.CreditPlatformWalletResponse>(
      '/accounts.AccountsService/CreditPlatformWallet',
      ($0.CreditPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreditPlatformWalletResponse.fromBuffer(value));
  static final _$debitPlatformWallet = $grpc.ClientMethod<$0.DebitPlatformWalletRequest, $0.DebitPlatformWalletResponse>(
      '/accounts.AccountsService/DebitPlatformWallet',
      ($0.DebitPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DebitPlatformWalletResponse.fromBuffer(value));
  static final _$getPlatformWallet = $grpc.ClientMethod<$0.GetPlatformWalletRequest, $0.GetPlatformWalletResponse>(
      '/accounts.AccountsService/GetPlatformWallet',
      ($0.GetPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPlatformWalletResponse.fromBuffer(value));
  static final _$getPlatformWalletTransactions = $grpc.ClientMethod<$0.GetPlatformWalletTransactionsRequest, $0.GetPlatformWalletTransactionsResponse>(
      '/accounts.AccountsService/GetPlatformWalletTransactions',
      ($0.GetPlatformWalletTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPlatformWalletTransactionsResponse.fromBuffer(value));
  static final _$getAccountByNumber = $grpc.ClientMethod<$0.GetAccountByNumberRequest, $0.GetAccountByNumberResponse>(
      '/accounts.AccountsService/GetAccountByNumber',
      ($0.GetAccountByNumberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAccountByNumberResponse.fromBuffer(value));
  static final _$createTransaction = $grpc.ClientMethod<$0.CreateTransactionRequest, $0.CreateTransactionResponse>(
      '/accounts.AccountsService/CreateTransaction',
      ($0.CreateTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateTransactionResponse.fromBuffer(value));
  static final _$getTransactionHistory = $grpc.ClientMethod<$0.GetTransactionHistoryRequest, $0.GetTransactionHistoryResponse>(
      '/accounts.AccountsService/GetTransactionHistory',
      ($0.GetTransactionHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTransactionHistoryResponse.fromBuffer(value));
  static final _$getTransactionStatistics = $grpc.ClientMethod<$0.GetTransactionStatisticsRequest, $0.GetTransactionStatisticsResponse>(
      '/accounts.AccountsService/GetTransactionStatistics',
      ($0.GetTransactionStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTransactionStatisticsResponse.fromBuffer(value));
  static final _$getFinancialAnalytics = $grpc.ClientMethod<$0.GetFinancialAnalyticsRequest, $0.GetFinancialAnalyticsResponse>(
      '/accounts.AccountsService/GetFinancialAnalytics',
      ($0.GetFinancialAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetFinancialAnalyticsResponse.fromBuffer(value));
  static final _$getCategoryAnalytics = $grpc.ClientMethod<$0.GetCategoryAnalyticsRequest, $0.GetCategoryAnalyticsResponse>(
      '/accounts.AccountsService/GetCategoryAnalytics',
      ($0.GetCategoryAnalyticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetCategoryAnalyticsResponse.fromBuffer(value));
  static final _$getMonthlyTrends = $grpc.ClientMethod<$0.GetMonthlyTrendsRequest, $0.GetMonthlyTrendsResponse>(
      '/accounts.AccountsService/GetMonthlyTrends',
      ($0.GetMonthlyTrendsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMonthlyTrendsResponse.fromBuffer(value));
  static final _$getExpenseTimeSeries = $grpc.ClientMethod<$0.GetExpenseTimeSeriesRequest, $0.GetExpenseTimeSeriesResponse>(
      '/accounts.AccountsService/GetExpenseTimeSeries',
      ($0.GetExpenseTimeSeriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetExpenseTimeSeriesResponse.fromBuffer(value));
  static final _$updateTransactionStatus = $grpc.ClientMethod<$0.UpdateTransactionStatusRequest, $0.UpdateTransactionStatusResponse>(
      '/accounts.AccountsService/UpdateTransactionStatus',
      ($0.UpdateTransactionStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateTransactionStatusResponse.fromBuffer(value));
  static final _$createAutoSave = $grpc.ClientMethod<$0.CreateAutoSaveRequest, $0.CreateAutoSaveResponse>(
      '/accounts.AccountsService/CreateAutoSave',
      ($0.CreateAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateAutoSaveResponse.fromBuffer(value));
  static final _$getAutoSaves = $grpc.ClientMethod<$0.GetAutoSavesRequest, $0.GetAutoSavesResponse>(
      '/accounts.AccountsService/GetAutoSaves',
      ($0.GetAutoSavesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAutoSavesResponse.fromBuffer(value));
  static final _$updateAutoSave = $grpc.ClientMethod<$0.UpdateAutoSaveRequest, $0.UpdateAutoSaveResponse>(
      '/accounts.AccountsService/UpdateAutoSave',
      ($0.UpdateAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateAutoSaveResponse.fromBuffer(value));
  static final _$deleteAutoSave = $grpc.ClientMethod<$0.DeleteAutoSaveRequest, $0.DeleteAutoSaveResponse>(
      '/accounts.AccountsService/DeleteAutoSave',
      ($0.DeleteAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteAutoSaveResponse.fromBuffer(value));
  static final _$createLockFunds = $grpc.ClientMethod<$0.CreateLockFundsRequest, $0.CreateLockFundsResponse>(
      '/accounts.AccountsService/CreateLockFunds',
      ($0.CreateLockFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateLockFundsResponse.fromBuffer(value));
  static final _$getLockFunds = $grpc.ClientMethod<$0.GetLockFundsRequest, $0.GetLockFundsResponse>(
      '/accounts.AccountsService/GetLockFunds',
      ($0.GetLockFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLockFundsResponse.fromBuffer(value));
  static final _$unlockFunds = $grpc.ClientMethod<$0.UnlockFundsRequest, $0.UnlockFundsResponse>(
      '/accounts.AccountsService/UnlockFunds',
      ($0.UnlockFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnlockFundsResponse.fromBuffer(value));
  static final _$topUpLockFunds = $grpc.ClientMethod<$0.TopUpLockFundsRequest, $0.TopUpLockFundsResponse>(
      '/accounts.AccountsService/TopUpLockFunds',
      ($0.TopUpLockFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TopUpLockFundsResponse.fromBuffer(value));
  static final _$getPiggyVaultConfig = $grpc.ClientMethod<$0.GetPiggyVaultConfigRequest, $0.GetPiggyVaultConfigResponse>(
      '/accounts.AccountsService/GetPiggyVaultConfig',
      ($0.GetPiggyVaultConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPiggyVaultConfigResponse.fromBuffer(value));
  static final _$getAllPiggyVaultConfigs = $grpc.ClientMethod<$0.GetAllPiggyVaultConfigsRequest, $0.GetAllPiggyVaultConfigsResponse>(
      '/accounts.AccountsService/GetAllPiggyVaultConfigs',
      ($0.GetAllPiggyVaultConfigsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetAllPiggyVaultConfigsResponse.fromBuffer(value));
  static final _$updatePiggyVaultConfig = $grpc.ClientMethod<$0.UpdatePiggyVaultConfigRequest, $0.UpdatePiggyVaultConfigResponse>(
      '/accounts.AccountsService/UpdatePiggyVaultConfig',
      ($0.UpdatePiggyVaultConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdatePiggyVaultConfigResponse.fromBuffer(value));
  static final _$createLockFundAutoSave = $grpc.ClientMethod<$0.CreateLockFundAutoSaveRequest, $0.CreateLockFundAutoSaveResponse>(
      '/accounts.AccountsService/CreateLockFundAutoSave',
      ($0.CreateLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateLockFundAutoSaveResponse.fromBuffer(value));
  static final _$getLockFundAutoSave = $grpc.ClientMethod<$0.GetLockFundAutoSaveRequest, $0.GetLockFundAutoSaveResponse>(
      '/accounts.AccountsService/GetLockFundAutoSave',
      ($0.GetLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetLockFundAutoSaveResponse.fromBuffer(value));
  static final _$updateLockFundAutoSave = $grpc.ClientMethod<$0.UpdateLockFundAutoSaveRequest, $0.UpdateLockFundAutoSaveResponse>(
      '/accounts.AccountsService/UpdateLockFundAutoSave',
      ($0.UpdateLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateLockFundAutoSaveResponse.fromBuffer(value));
  static final _$deleteLockFundAutoSave = $grpc.ClientMethod<$0.DeleteLockFundAutoSaveRequest, $0.DeleteLockFundAutoSaveResponse>(
      '/accounts.AccountsService/DeleteLockFundAutoSave',
      ($0.DeleteLockFundAutoSaveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DeleteLockFundAutoSaveResponse.fromBuffer(value));
  static final _$createTransfer = $grpc.ClientMethod<$0.CreateTransferRequest, $0.CreateTransferResponse>(
      '/accounts.AccountsService/CreateTransfer',
      ($0.CreateTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateTransferResponse.fromBuffer(value));
  static final _$createVirtualAccount = $grpc.ClientMethod<$0.CreateVirtualAccountRequest, $0.CreateVirtualAccountResponse>(
      '/accounts.AccountsService/CreateVirtualAccount',
      ($0.CreateVirtualAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateVirtualAccountResponse.fromBuffer(value));
  static final _$getTransfer = $grpc.ClientMethod<$0.GetTransferRequest, $0.GetTransferResponse>(
      '/accounts.AccountsService/GetTransfer',
      ($0.GetTransferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetTransferResponse.fromBuffer(value));
  static final _$getUserCategoryMappings = $grpc.ClientMethod<$0.GetUserCategoryMappingsRequest, $0.GetUserCategoryMappingsResponse>(
      '/accounts.AccountsService/GetUserCategoryMappings',
      ($0.GetUserCategoryMappingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetUserCategoryMappingsResponse.fromBuffer(value));
  static final _$updateUserCategoryMapping = $grpc.ClientMethod<$0.UpdateUserCategoryMappingRequest, $0.UpdateUserCategoryMappingResponse>(
      '/accounts.AccountsService/UpdateUserCategoryMapping',
      ($0.UpdateUserCategoryMappingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateUserCategoryMappingResponse.fromBuffer(value));
  static final _$reorderCategories = $grpc.ClientMethod<$0.ReorderCategoriesRequest, $0.ReorderCategoriesResponse>(
      '/accounts.AccountsService/ReorderCategories',
      ($0.ReorderCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ReorderCategoriesResponse.fromBuffer(value));
  static final _$updateSpendingLimits = $grpc.ClientMethod<$0.UpdateSpendingLimitsRequest, $0.UpdateSpendingLimitsResponse>(
      '/accounts.AccountsService/UpdateSpendingLimits',
      ($0.UpdateSpendingLimitsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateSpendingLimitsResponse.fromBuffer(value));
  static final _$revealPIN = $grpc.ClientMethod<$0.RevealPINRequest, $0.RevealPINResponse>(
      '/accounts.AccountsService/RevealPIN',
      ($0.RevealPINRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RevealPINResponse.fromBuffer(value));
  static final _$revealCardDetails = $grpc.ClientMethod<$0.RevealCardDetailsRequest, $0.RevealCardDetailsResponse>(
      '/accounts.AccountsService/RevealCardDetails',
      ($0.RevealCardDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RevealCardDetailsResponse.fromBuffer(value));
  static final _$updateSecuritySettings = $grpc.ClientMethod<$0.UpdateSecuritySettingsRequest, $0.UpdateSecuritySettingsResponse>(
      '/accounts.AccountsService/UpdateSecuritySettings',
      ($0.UpdateSecuritySettingsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateSecuritySettingsResponse.fromBuffer(value));
  static final _$generateStatement = $grpc.ClientMethod<$0.GenerateStatementRequest, $0.GenerateStatementResponse>(
      '/accounts.AccountsService/GenerateStatement',
      ($0.GenerateStatementRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateStatementResponse.fromBuffer(value));
  static final _$generateAccountConfirmation = $grpc.ClientMethod<$0.GenerateAccountConfirmationRequest, $0.GenerateAccountConfirmationResponse>(
      '/accounts.AccountsService/GenerateAccountConfirmation',
      ($0.GenerateAccountConfirmationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateAccountConfirmationResponse.fromBuffer(value));
  static final _$generateProofOfFunds = $grpc.ClientMethod<$0.GenerateProofOfFundsRequest, $0.GenerateProofOfFundsResponse>(
      '/accounts.AccountsService/GenerateProofOfFunds',
      ($0.GenerateProofOfFundsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateProofOfFundsResponse.fromBuffer(value));
  static final _$adminSearchAccounts = $grpc.ClientMethod<$0.AdminSearchAccountsRequest, $0.AdminSearchAccountsResponse>(
      '/accounts.AccountsService/AdminSearchAccounts',
      ($0.AdminSearchAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminSearchAccountsResponse.fromBuffer(value));
  static final _$adminGetAccountDetail = $grpc.ClientMethod<$0.AdminGetAccountDetailRequest, $0.AdminAccountDetailResponse>(
      '/accounts.AccountsService/AdminGetAccountDetail',
      ($0.AdminGetAccountDetailRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminAccountDetailResponse.fromBuffer(value));
  static final _$adminGetAccountTransactions = $grpc.ClientMethod<$0.AdminGetAccountTransactionsRequest, $0.AdminAccountTransactionsResponse>(
      '/accounts.AccountsService/AdminGetAccountTransactions',
      ($0.AdminGetAccountTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminAccountTransactionsResponse.fromBuffer(value));
  static final _$adminGetAccountHolds = $grpc.ClientMethod<$0.AdminGetAccountHoldsRequest, $0.AdminAccountHoldsResponse>(
      '/accounts.AccountsService/AdminGetAccountHolds',
      ($0.AdminGetAccountHoldsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminAccountHoldsResponse.fromBuffer(value));
  static final _$adminGetAccountClearing = $grpc.ClientMethod<$0.AdminGetAccountClearingRequest, $0.AdminAccountClearingResponse>(
      '/accounts.AccountsService/AdminGetAccountClearing',
      ($0.AdminGetAccountClearingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminAccountClearingResponse.fromBuffer(value));
  static final _$adminListAllHolds = $grpc.ClientMethod<$0.AdminListAllHoldsRequest, $0.AdminListAllHoldsResponse>(
      '/accounts.AccountsService/AdminListAllHolds',
      ($0.AdminListAllHoldsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminListAllHoldsResponse.fromBuffer(value));
  static final _$adminGetStaleHolds = $grpc.ClientMethod<$0.AdminGetStaleHoldsRequest, $0.AdminGetStaleHoldsResponse>(
      '/accounts.AccountsService/AdminGetStaleHolds',
      ($0.AdminGetStaleHoldsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminGetStaleHoldsResponse.fromBuffer(value));
  static final _$adminGetAllPlatformWallets = $grpc.ClientMethod<$0.AdminGetAllPlatformWalletsRequest, $0.AdminGetAllPlatformWalletsResponse>(
      '/accounts.AccountsService/AdminGetAllPlatformWallets',
      ($0.AdminGetAllPlatformWalletsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminGetAllPlatformWalletsResponse.fromBuffer(value));
  static final _$adminGetPlatformWalletTransactions = $grpc.ClientMethod<$0.AdminGetPlatformWalletTransactionsRequest, $0.AdminGetPlatformWalletTransactionsResponse>(
      '/accounts.AccountsService/AdminGetPlatformWalletTransactions',
      ($0.AdminGetPlatformWalletTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminGetPlatformWalletTransactionsResponse.fromBuffer(value));
  static final _$adminGetClearingRecords = $grpc.ClientMethod<$0.AdminGetClearingRecordsRequest, $0.AdminGetClearingRecordsResponse>(
      '/accounts.AccountsService/AdminGetClearingRecords',
      ($0.AdminGetClearingRecordsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminGetClearingRecordsResponse.fromBuffer(value));
  static final _$adminGetClearingHealth = $grpc.ClientMethod<$0.AdminGetClearingHealthRequest, $0.AdminGetClearingHealthResponse>(
      '/accounts.AccountsService/AdminGetClearingHealth',
      ($0.AdminGetClearingHealthRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminGetClearingHealthResponse.fromBuffer(value));
  static final _$adminFreezeAccount = $grpc.ClientMethod<$0.AdminFreezeAccountRequest, $0.AdminFreezeAccountResponse>(
      '/accounts.AccountsService/AdminFreezeAccount',
      ($0.AdminFreezeAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminFreezeAccountResponse.fromBuffer(value));
  static final _$adminUnfreezeAccount = $grpc.ClientMethod<$0.AdminUnfreezeAccountRequest, $0.AdminUnfreezeAccountResponse>(
      '/accounts.AccountsService/AdminUnfreezeAccount',
      ($0.AdminUnfreezeAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AdminUnfreezeAccountResponse.fromBuffer(value));

  AccountsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateAccountResponse> createAccount($0.CreateAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountsResponse> getAccounts($0.GetAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserAccountsResponse> getUserAccounts($0.GetUserAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountResponse> getAccount($0.GetAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAccountResponse> updateAccount($0.UpdateAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAccountResponse> deleteAccount($0.DeleteAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBalanceResponse> getBalance($0.GetBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionsResponse> getTransactions($0.GetTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.FreezeAccountResponse> freezeAccount($0.FreezeAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnfreezeAccountResponse> unfreezeAccount($0.UnfreezeAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateBalanceResponse> updateBalance($0.UpdateBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreditBalanceResponse> creditBalance($0.CreditBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.DebitBalanceResponse> debitBalance($0.DebitBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$debitBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransferBalanceResponse> transferBalance($0.TransferBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.HoldFundsResponse> holdFunds($0.HoldFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$holdFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.CaptureHoldResponse> captureHold($0.CaptureHoldRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$captureHold, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReleaseHoldResponse> releaseHold($0.ReleaseHoldRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$releaseHold, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreditToClearingResponse> creditToClearing($0.CreditToClearingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditToClearing, request, options: options);
  }

  $grpc.ResponseFuture<$0.ClearDepositResponse> clearDeposit($0.ClearDepositRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$clearDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReverseClearingDepositResponse> reverseClearingDeposit($0.ReverseClearingDepositRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reverseClearingDeposit, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransferToPlatformWalletResponse> transferToPlatformWallet($0.TransferToPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferToPlatformWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransferFromPlatformWalletResponse> transferFromPlatformWallet($0.TransferFromPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFromPlatformWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreditPlatformWalletResponse> creditPlatformWallet($0.CreditPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$creditPlatformWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.DebitPlatformWalletResponse> debitPlatformWallet($0.DebitPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$debitPlatformWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPlatformWalletResponse> getPlatformWallet($0.GetPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlatformWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPlatformWalletTransactionsResponse> getPlatformWalletTransactions($0.GetPlatformWalletTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPlatformWalletTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountByNumberResponse> getAccountByNumber($0.GetAccountByNumberRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountByNumber, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateTransactionResponse> createTransaction($0.CreateTransactionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionHistoryResponse> getTransactionHistory($0.GetTransactionHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionStatisticsResponse> getTransactionStatistics($0.GetTransactionStatisticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionStatistics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetFinancialAnalyticsResponse> getFinancialAnalytics($0.GetFinancialAnalyticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFinancialAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetCategoryAnalyticsResponse> getCategoryAnalytics($0.GetCategoryAnalyticsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCategoryAnalytics, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetMonthlyTrendsResponse> getMonthlyTrends($0.GetMonthlyTrendsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMonthlyTrends, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetExpenseTimeSeriesResponse> getExpenseTimeSeries($0.GetExpenseTimeSeriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getExpenseTimeSeries, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateTransactionStatusResponse> updateTransactionStatus($0.UpdateTransactionStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateTransactionStatus, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateAutoSaveResponse> createAutoSave($0.CreateAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSavesResponse> getAutoSaves($0.GetAutoSavesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaves, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoSaveResponse> updateAutoSave($0.UpdateAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAutoSaveResponse> deleteAutoSave($0.DeleteAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateLockFundsResponse> createLockFunds($0.CreateLockFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLockFundsResponse> getLockFunds($0.GetLockFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnlockFundsResponse> unlockFunds($0.UnlockFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.TopUpLockFundsResponse> topUpLockFunds($0.TopUpLockFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$topUpLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPiggyVaultConfigResponse> getPiggyVaultConfig($0.GetPiggyVaultConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPiggyVaultConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAllPiggyVaultConfigsResponse> getAllPiggyVaultConfigs($0.GetAllPiggyVaultConfigsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllPiggyVaultConfigs, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdatePiggyVaultConfigResponse> updatePiggyVaultConfig($0.UpdatePiggyVaultConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePiggyVaultConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateLockFundAutoSaveResponse> createLockFundAutoSave($0.CreateLockFundAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFundAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLockFundAutoSaveResponse> getLockFundAutoSave($0.GetLockFundAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFundAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave($0.UpdateLockFundAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLockFundAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave($0.DeleteLockFundAutoSaveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLockFundAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateTransferResponse> createTransfer($0.CreateTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateVirtualAccountResponse> createVirtualAccount($0.CreateVirtualAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVirtualAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransferResponse> getTransfer($0.GetTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetUserCategoryMappingsResponse> getUserCategoryMappings($0.GetUserCategoryMappingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserCategoryMappings, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateUserCategoryMappingResponse> updateUserCategoryMapping($0.UpdateUserCategoryMappingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserCategoryMapping, request, options: options);
  }

  $grpc.ResponseFuture<$0.ReorderCategoriesResponse> reorderCategories($0.ReorderCategoriesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reorderCategories, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSpendingLimitsResponse> updateSpendingLimits($0.UpdateSpendingLimitsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSpendingLimits, request, options: options);
  }

  $grpc.ResponseFuture<$0.RevealPINResponse> revealPIN($0.RevealPINRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$revealPIN, request, options: options);
  }

  $grpc.ResponseFuture<$0.RevealCardDetailsResponse> revealCardDetails($0.RevealCardDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$revealCardDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateSecuritySettingsResponse> updateSecuritySettings($0.UpdateSecuritySettingsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateSecuritySettings, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateStatementResponse> generateStatement($0.GenerateStatementRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateStatement, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateAccountConfirmationResponse> generateAccountConfirmation($0.GenerateAccountConfirmationRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateAccountConfirmation, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateProofOfFundsResponse> generateProofOfFunds($0.GenerateProofOfFundsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateProofOfFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminSearchAccountsResponse> adminSearchAccounts($0.AdminSearchAccountsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminSearchAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminAccountDetailResponse> adminGetAccountDetail($0.AdminGetAccountDetailRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetAccountDetail, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminAccountTransactionsResponse> adminGetAccountTransactions($0.AdminGetAccountTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetAccountTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminAccountHoldsResponse> adminGetAccountHolds($0.AdminGetAccountHoldsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetAccountHolds, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminAccountClearingResponse> adminGetAccountClearing($0.AdminGetAccountClearingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetAccountClearing, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminListAllHoldsResponse> adminListAllHolds($0.AdminListAllHoldsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminListAllHolds, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetStaleHoldsResponse> adminGetStaleHolds($0.AdminGetStaleHoldsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetStaleHolds, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetAllPlatformWalletsResponse> adminGetAllPlatformWallets($0.AdminGetAllPlatformWalletsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetAllPlatformWallets, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetPlatformWalletTransactionsResponse> adminGetPlatformWalletTransactions($0.AdminGetPlatformWalletTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetPlatformWalletTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetClearingRecordsResponse> adminGetClearingRecords($0.AdminGetClearingRecordsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetClearingRecords, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminGetClearingHealthResponse> adminGetClearingHealth($0.AdminGetClearingHealthRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminGetClearingHealth, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminFreezeAccountResponse> adminFreezeAccount($0.AdminFreezeAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminFreezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminUnfreezeAccountResponse> adminUnfreezeAccount($0.AdminUnfreezeAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$adminUnfreezeAccount, request, options: options);
  }
}

@$pb.GrpcServiceName('accounts.AccountsService')
abstract class AccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.AccountsService';

  AccountsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
        'CreateAccount',
        createAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateAccountRequest.fromBuffer(value),
        ($0.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountsRequest, $0.GetAccountsResponse>(
        'GetAccounts',
        getAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAccountsRequest.fromBuffer(value),
        ($0.GetAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserAccountsRequest, $0.GetUserAccountsResponse>(
        'GetUserAccounts',
        getUserAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserAccountsRequest.fromBuffer(value),
        ($0.GetUserAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountRequest, $0.GetAccountResponse>(
        'GetAccount',
        getAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAccountRequest.fromBuffer(value),
        ($0.GetAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAccountRequest, $0.UpdateAccountResponse>(
        'UpdateAccount',
        updateAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateAccountRequest.fromBuffer(value),
        ($0.UpdateAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAccountRequest, $0.DeleteAccountResponse>(
        'DeleteAccount',
        deleteAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteAccountRequest.fromBuffer(value),
        ($0.DeleteAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBalanceRequest, $0.GetBalanceResponse>(
        'GetBalance',
        getBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBalanceRequest.fromBuffer(value),
        ($0.GetBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionsRequest, $0.GetTransactionsResponse>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTransactionsRequest.fromBuffer(value),
        ($0.GetTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.FreezeAccountRequest, $0.FreezeAccountResponse>(
        'FreezeAccount',
        freezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FreezeAccountRequest.fromBuffer(value),
        ($0.FreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnfreezeAccountRequest, $0.UnfreezeAccountResponse>(
        'UnfreezeAccount',
        unfreezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnfreezeAccountRequest.fromBuffer(value),
        ($0.UnfreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBalanceRequest, $0.UpdateBalanceResponse>(
        'UpdateBalance',
        updateBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateBalanceRequest.fromBuffer(value),
        ($0.UpdateBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreditBalanceRequest, $0.CreditBalanceResponse>(
        'CreditBalance',
        creditBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreditBalanceRequest.fromBuffer(value),
        ($0.CreditBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DebitBalanceRequest, $0.DebitBalanceResponse>(
        'DebitBalance',
        debitBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DebitBalanceRequest.fromBuffer(value),
        ($0.DebitBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferBalanceRequest, $0.TransferBalanceResponse>(
        'TransferBalance',
        transferBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TransferBalanceRequest.fromBuffer(value),
        ($0.TransferBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HoldFundsRequest, $0.HoldFundsResponse>(
        'HoldFunds',
        holdFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HoldFundsRequest.fromBuffer(value),
        ($0.HoldFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CaptureHoldRequest, $0.CaptureHoldResponse>(
        'CaptureHold',
        captureHold_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CaptureHoldRequest.fromBuffer(value),
        ($0.CaptureHoldResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReleaseHoldRequest, $0.ReleaseHoldResponse>(
        'ReleaseHold',
        releaseHold_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReleaseHoldRequest.fromBuffer(value),
        ($0.ReleaseHoldResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreditToClearingRequest, $0.CreditToClearingResponse>(
        'CreditToClearing',
        creditToClearing_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreditToClearingRequest.fromBuffer(value),
        ($0.CreditToClearingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ClearDepositRequest, $0.ClearDepositResponse>(
        'ClearDeposit',
        clearDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ClearDepositRequest.fromBuffer(value),
        ($0.ClearDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReverseClearingDepositRequest, $0.ReverseClearingDepositResponse>(
        'ReverseClearingDeposit',
        reverseClearingDeposit_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReverseClearingDepositRequest.fromBuffer(value),
        ($0.ReverseClearingDepositResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferToPlatformWalletRequest, $0.TransferToPlatformWalletResponse>(
        'TransferToPlatformWallet',
        transferToPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TransferToPlatformWalletRequest.fromBuffer(value),
        ($0.TransferToPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TransferFromPlatformWalletRequest, $0.TransferFromPlatformWalletResponse>(
        'TransferFromPlatformWallet',
        transferFromPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TransferFromPlatformWalletRequest.fromBuffer(value),
        ($0.TransferFromPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreditPlatformWalletRequest, $0.CreditPlatformWalletResponse>(
        'CreditPlatformWallet',
        creditPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreditPlatformWalletRequest.fromBuffer(value),
        ($0.CreditPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DebitPlatformWalletRequest, $0.DebitPlatformWalletResponse>(
        'DebitPlatformWallet',
        debitPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DebitPlatformWalletRequest.fromBuffer(value),
        ($0.DebitPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPlatformWalletRequest, $0.GetPlatformWalletResponse>(
        'GetPlatformWallet',
        getPlatformWallet_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPlatformWalletRequest.fromBuffer(value),
        ($0.GetPlatformWalletResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPlatformWalletTransactionsRequest, $0.GetPlatformWalletTransactionsResponse>(
        'GetPlatformWalletTransactions',
        getPlatformWalletTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPlatformWalletTransactionsRequest.fromBuffer(value),
        ($0.GetPlatformWalletTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountByNumberRequest, $0.GetAccountByNumberResponse>(
        'GetAccountByNumber',
        getAccountByNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAccountByNumberRequest.fromBuffer(value),
        ($0.GetAccountByNumberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateTransactionRequest, $0.CreateTransactionResponse>(
        'CreateTransaction',
        createTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateTransactionRequest.fromBuffer(value),
        ($0.CreateTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionHistoryRequest, $0.GetTransactionHistoryResponse>(
        'GetTransactionHistory',
        getTransactionHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTransactionHistoryRequest.fromBuffer(value),
        ($0.GetTransactionHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionStatisticsRequest, $0.GetTransactionStatisticsResponse>(
        'GetTransactionStatistics',
        getTransactionStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTransactionStatisticsRequest.fromBuffer(value),
        ($0.GetTransactionStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFinancialAnalyticsRequest, $0.GetFinancialAnalyticsResponse>(
        'GetFinancialAnalytics',
        getFinancialAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFinancialAnalyticsRequest.fromBuffer(value),
        ($0.GetFinancialAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetCategoryAnalyticsRequest, $0.GetCategoryAnalyticsResponse>(
        'GetCategoryAnalytics',
        getCategoryAnalytics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetCategoryAnalyticsRequest.fromBuffer(value),
        ($0.GetCategoryAnalyticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetMonthlyTrendsRequest, $0.GetMonthlyTrendsResponse>(
        'GetMonthlyTrends',
        getMonthlyTrends_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMonthlyTrendsRequest.fromBuffer(value),
        ($0.GetMonthlyTrendsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetExpenseTimeSeriesRequest, $0.GetExpenseTimeSeriesResponse>(
        'GetExpenseTimeSeries',
        getExpenseTimeSeries_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetExpenseTimeSeriesRequest.fromBuffer(value),
        ($0.GetExpenseTimeSeriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTransactionStatusRequest, $0.UpdateTransactionStatusResponse>(
        'UpdateTransactionStatus',
        updateTransactionStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateTransactionStatusRequest.fromBuffer(value),
        ($0.UpdateTransactionStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAutoSaveRequest, $0.CreateAutoSaveResponse>(
        'CreateAutoSave',
        createAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateAutoSaveRequest.fromBuffer(value),
        ($0.CreateAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAutoSavesRequest, $0.GetAutoSavesResponse>(
        'GetAutoSaves',
        getAutoSaves_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAutoSavesRequest.fromBuffer(value),
        ($0.GetAutoSavesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoSaveRequest, $0.UpdateAutoSaveResponse>(
        'UpdateAutoSave',
        updateAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateAutoSaveRequest.fromBuffer(value),
        ($0.UpdateAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAutoSaveRequest, $0.DeleteAutoSaveResponse>(
        'DeleteAutoSave',
        deleteAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteAutoSaveRequest.fromBuffer(value),
        ($0.DeleteAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateLockFundsRequest, $0.CreateLockFundsResponse>(
        'CreateLockFunds',
        createLockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateLockFundsRequest.fromBuffer(value),
        ($0.CreateLockFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLockFundsRequest, $0.GetLockFundsResponse>(
        'GetLockFunds',
        getLockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLockFundsRequest.fromBuffer(value),
        ($0.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnlockFundsRequest, $0.UnlockFundsResponse>(
        'UnlockFunds',
        unlockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnlockFundsRequest.fromBuffer(value),
        ($0.UnlockFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TopUpLockFundsRequest, $0.TopUpLockFundsResponse>(
        'TopUpLockFunds',
        topUpLockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TopUpLockFundsRequest.fromBuffer(value),
        ($0.TopUpLockFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPiggyVaultConfigRequest, $0.GetPiggyVaultConfigResponse>(
        'GetPiggyVaultConfig',
        getPiggyVaultConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPiggyVaultConfigRequest.fromBuffer(value),
        ($0.GetPiggyVaultConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAllPiggyVaultConfigsRequest, $0.GetAllPiggyVaultConfigsResponse>(
        'GetAllPiggyVaultConfigs',
        getAllPiggyVaultConfigs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAllPiggyVaultConfigsRequest.fromBuffer(value),
        ($0.GetAllPiggyVaultConfigsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdatePiggyVaultConfigRequest, $0.UpdatePiggyVaultConfigResponse>(
        'UpdatePiggyVaultConfig',
        updatePiggyVaultConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdatePiggyVaultConfigRequest.fromBuffer(value),
        ($0.UpdatePiggyVaultConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateLockFundAutoSaveRequest, $0.CreateLockFundAutoSaveResponse>(
        'CreateLockFundAutoSave',
        createLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateLockFundAutoSaveRequest.fromBuffer(value),
        ($0.CreateLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetLockFundAutoSaveRequest, $0.GetLockFundAutoSaveResponse>(
        'GetLockFundAutoSave',
        getLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetLockFundAutoSaveRequest.fromBuffer(value),
        ($0.GetLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateLockFundAutoSaveRequest, $0.UpdateLockFundAutoSaveResponse>(
        'UpdateLockFundAutoSave',
        updateLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateLockFundAutoSaveRequest.fromBuffer(value),
        ($0.UpdateLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteLockFundAutoSaveRequest, $0.DeleteLockFundAutoSaveResponse>(
        'DeleteLockFundAutoSave',
        deleteLockFundAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DeleteLockFundAutoSaveRequest.fromBuffer(value),
        ($0.DeleteLockFundAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateTransferRequest, $0.CreateTransferResponse>(
        'CreateTransfer',
        createTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateTransferRequest.fromBuffer(value),
        ($0.CreateTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateVirtualAccountRequest, $0.CreateVirtualAccountResponse>(
        'CreateVirtualAccount',
        createVirtualAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateVirtualAccountRequest.fromBuffer(value),
        ($0.CreateVirtualAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransferRequest, $0.GetTransferResponse>(
        'GetTransfer',
        getTransfer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetTransferRequest.fromBuffer(value),
        ($0.GetTransferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetUserCategoryMappingsRequest, $0.GetUserCategoryMappingsResponse>(
        'GetUserCategoryMappings',
        getUserCategoryMappings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserCategoryMappingsRequest.fromBuffer(value),
        ($0.GetUserCategoryMappingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateUserCategoryMappingRequest, $0.UpdateUserCategoryMappingResponse>(
        'UpdateUserCategoryMapping',
        updateUserCategoryMapping_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateUserCategoryMappingRequest.fromBuffer(value),
        ($0.UpdateUserCategoryMappingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReorderCategoriesRequest, $0.ReorderCategoriesResponse>(
        'ReorderCategories',
        reorderCategories_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReorderCategoriesRequest.fromBuffer(value),
        ($0.ReorderCategoriesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSpendingLimitsRequest, $0.UpdateSpendingLimitsResponse>(
        'UpdateSpendingLimits',
        updateSpendingLimits_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateSpendingLimitsRequest.fromBuffer(value),
        ($0.UpdateSpendingLimitsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RevealPINRequest, $0.RevealPINResponse>(
        'RevealPIN',
        revealPIN_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RevealPINRequest.fromBuffer(value),
        ($0.RevealPINResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RevealCardDetailsRequest, $0.RevealCardDetailsResponse>(
        'RevealCardDetails',
        revealCardDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RevealCardDetailsRequest.fromBuffer(value),
        ($0.RevealCardDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateSecuritySettingsRequest, $0.UpdateSecuritySettingsResponse>(
        'UpdateSecuritySettings',
        updateSecuritySettings_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateSecuritySettingsRequest.fromBuffer(value),
        ($0.UpdateSecuritySettingsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateStatementRequest, $0.GenerateStatementResponse>(
        'GenerateStatement',
        generateStatement_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GenerateStatementRequest.fromBuffer(value),
        ($0.GenerateStatementResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateAccountConfirmationRequest, $0.GenerateAccountConfirmationResponse>(
        'GenerateAccountConfirmation',
        generateAccountConfirmation_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GenerateAccountConfirmationRequest.fromBuffer(value),
        ($0.GenerateAccountConfirmationResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateProofOfFundsRequest, $0.GenerateProofOfFundsResponse>(
        'GenerateProofOfFunds',
        generateProofOfFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GenerateProofOfFundsRequest.fromBuffer(value),
        ($0.GenerateProofOfFundsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminSearchAccountsRequest, $0.AdminSearchAccountsResponse>(
        'AdminSearchAccounts',
        adminSearchAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminSearchAccountsRequest.fromBuffer(value),
        ($0.AdminSearchAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetAccountDetailRequest, $0.AdminAccountDetailResponse>(
        'AdminGetAccountDetail',
        adminGetAccountDetail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetAccountDetailRequest.fromBuffer(value),
        ($0.AdminAccountDetailResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetAccountTransactionsRequest, $0.AdminAccountTransactionsResponse>(
        'AdminGetAccountTransactions',
        adminGetAccountTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetAccountTransactionsRequest.fromBuffer(value),
        ($0.AdminAccountTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetAccountHoldsRequest, $0.AdminAccountHoldsResponse>(
        'AdminGetAccountHolds',
        adminGetAccountHolds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetAccountHoldsRequest.fromBuffer(value),
        ($0.AdminAccountHoldsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetAccountClearingRequest, $0.AdminAccountClearingResponse>(
        'AdminGetAccountClearing',
        adminGetAccountClearing_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetAccountClearingRequest.fromBuffer(value),
        ($0.AdminAccountClearingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminListAllHoldsRequest, $0.AdminListAllHoldsResponse>(
        'AdminListAllHolds',
        adminListAllHolds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminListAllHoldsRequest.fromBuffer(value),
        ($0.AdminListAllHoldsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetStaleHoldsRequest, $0.AdminGetStaleHoldsResponse>(
        'AdminGetStaleHolds',
        adminGetStaleHolds_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetStaleHoldsRequest.fromBuffer(value),
        ($0.AdminGetStaleHoldsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetAllPlatformWalletsRequest, $0.AdminGetAllPlatformWalletsResponse>(
        'AdminGetAllPlatformWallets',
        adminGetAllPlatformWallets_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetAllPlatformWalletsRequest.fromBuffer(value),
        ($0.AdminGetAllPlatformWalletsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetPlatformWalletTransactionsRequest, $0.AdminGetPlatformWalletTransactionsResponse>(
        'AdminGetPlatformWalletTransactions',
        adminGetPlatformWalletTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetPlatformWalletTransactionsRequest.fromBuffer(value),
        ($0.AdminGetPlatformWalletTransactionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetClearingRecordsRequest, $0.AdminGetClearingRecordsResponse>(
        'AdminGetClearingRecords',
        adminGetClearingRecords_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetClearingRecordsRequest.fromBuffer(value),
        ($0.AdminGetClearingRecordsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminGetClearingHealthRequest, $0.AdminGetClearingHealthResponse>(
        'AdminGetClearingHealth',
        adminGetClearingHealth_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminGetClearingHealthRequest.fromBuffer(value),
        ($0.AdminGetClearingHealthResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminFreezeAccountRequest, $0.AdminFreezeAccountResponse>(
        'AdminFreezeAccount',
        adminFreezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminFreezeAccountRequest.fromBuffer(value),
        ($0.AdminFreezeAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdminUnfreezeAccountRequest, $0.AdminUnfreezeAccountResponse>(
        'AdminUnfreezeAccount',
        adminUnfreezeAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdminUnfreezeAccountRequest.fromBuffer(value),
        ($0.AdminUnfreezeAccountResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateAccountResponse> createAccount_Pre($grpc.ServiceCall call, $async.Future<$0.CreateAccountRequest> request) async {
    return createAccount(call, await request);
  }

  $async.Future<$0.GetAccountsResponse> getAccounts_Pre($grpc.ServiceCall call, $async.Future<$0.GetAccountsRequest> request) async {
    return getAccounts(call, await request);
  }

  $async.Future<$0.GetUserAccountsResponse> getUserAccounts_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserAccountsRequest> request) async {
    return getUserAccounts(call, await request);
  }

  $async.Future<$0.GetAccountResponse> getAccount_Pre($grpc.ServiceCall call, $async.Future<$0.GetAccountRequest> request) async {
    return getAccount(call, await request);
  }

  $async.Future<$0.UpdateAccountResponse> updateAccount_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateAccountRequest> request) async {
    return updateAccount(call, await request);
  }

  $async.Future<$0.DeleteAccountResponse> deleteAccount_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteAccountRequest> request) async {
    return deleteAccount(call, await request);
  }

  $async.Future<$0.GetBalanceResponse> getBalance_Pre($grpc.ServiceCall call, $async.Future<$0.GetBalanceRequest> request) async {
    return getBalance(call, await request);
  }

  $async.Future<$0.GetTransactionsResponse> getTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetTransactionsRequest> request) async {
    return getTransactions(call, await request);
  }

  $async.Future<$0.FreezeAccountResponse> freezeAccount_Pre($grpc.ServiceCall call, $async.Future<$0.FreezeAccountRequest> request) async {
    return freezeAccount(call, await request);
  }

  $async.Future<$0.UnfreezeAccountResponse> unfreezeAccount_Pre($grpc.ServiceCall call, $async.Future<$0.UnfreezeAccountRequest> request) async {
    return unfreezeAccount(call, await request);
  }

  $async.Future<$0.UpdateBalanceResponse> updateBalance_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateBalanceRequest> request) async {
    return updateBalance(call, await request);
  }

  $async.Future<$0.CreditBalanceResponse> creditBalance_Pre($grpc.ServiceCall call, $async.Future<$0.CreditBalanceRequest> request) async {
    return creditBalance(call, await request);
  }

  $async.Future<$0.DebitBalanceResponse> debitBalance_Pre($grpc.ServiceCall call, $async.Future<$0.DebitBalanceRequest> request) async {
    return debitBalance(call, await request);
  }

  $async.Future<$0.TransferBalanceResponse> transferBalance_Pre($grpc.ServiceCall call, $async.Future<$0.TransferBalanceRequest> request) async {
    return transferBalance(call, await request);
  }

  $async.Future<$0.HoldFundsResponse> holdFunds_Pre($grpc.ServiceCall call, $async.Future<$0.HoldFundsRequest> request) async {
    return holdFunds(call, await request);
  }

  $async.Future<$0.CaptureHoldResponse> captureHold_Pre($grpc.ServiceCall call, $async.Future<$0.CaptureHoldRequest> request) async {
    return captureHold(call, await request);
  }

  $async.Future<$0.ReleaseHoldResponse> releaseHold_Pre($grpc.ServiceCall call, $async.Future<$0.ReleaseHoldRequest> request) async {
    return releaseHold(call, await request);
  }

  $async.Future<$0.CreditToClearingResponse> creditToClearing_Pre($grpc.ServiceCall call, $async.Future<$0.CreditToClearingRequest> request) async {
    return creditToClearing(call, await request);
  }

  $async.Future<$0.ClearDepositResponse> clearDeposit_Pre($grpc.ServiceCall call, $async.Future<$0.ClearDepositRequest> request) async {
    return clearDeposit(call, await request);
  }

  $async.Future<$0.ReverseClearingDepositResponse> reverseClearingDeposit_Pre($grpc.ServiceCall call, $async.Future<$0.ReverseClearingDepositRequest> request) async {
    return reverseClearingDeposit(call, await request);
  }

  $async.Future<$0.TransferToPlatformWalletResponse> transferToPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.TransferToPlatformWalletRequest> request) async {
    return transferToPlatformWallet(call, await request);
  }

  $async.Future<$0.TransferFromPlatformWalletResponse> transferFromPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.TransferFromPlatformWalletRequest> request) async {
    return transferFromPlatformWallet(call, await request);
  }

  $async.Future<$0.CreditPlatformWalletResponse> creditPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.CreditPlatformWalletRequest> request) async {
    return creditPlatformWallet(call, await request);
  }

  $async.Future<$0.DebitPlatformWalletResponse> debitPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.DebitPlatformWalletRequest> request) async {
    return debitPlatformWallet(call, await request);
  }

  $async.Future<$0.GetPlatformWalletResponse> getPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.GetPlatformWalletRequest> request) async {
    return getPlatformWallet(call, await request);
  }

  $async.Future<$0.GetPlatformWalletTransactionsResponse> getPlatformWalletTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.GetPlatformWalletTransactionsRequest> request) async {
    return getPlatformWalletTransactions(call, await request);
  }

  $async.Future<$0.GetAccountByNumberResponse> getAccountByNumber_Pre($grpc.ServiceCall call, $async.Future<$0.GetAccountByNumberRequest> request) async {
    return getAccountByNumber(call, await request);
  }

  $async.Future<$0.CreateTransactionResponse> createTransaction_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTransactionRequest> request) async {
    return createTransaction(call, await request);
  }

  $async.Future<$0.GetTransactionHistoryResponse> getTransactionHistory_Pre($grpc.ServiceCall call, $async.Future<$0.GetTransactionHistoryRequest> request) async {
    return getTransactionHistory(call, await request);
  }

  $async.Future<$0.GetTransactionStatisticsResponse> getTransactionStatistics_Pre($grpc.ServiceCall call, $async.Future<$0.GetTransactionStatisticsRequest> request) async {
    return getTransactionStatistics(call, await request);
  }

  $async.Future<$0.GetFinancialAnalyticsResponse> getFinancialAnalytics_Pre($grpc.ServiceCall call, $async.Future<$0.GetFinancialAnalyticsRequest> request) async {
    return getFinancialAnalytics(call, await request);
  }

  $async.Future<$0.GetCategoryAnalyticsResponse> getCategoryAnalytics_Pre($grpc.ServiceCall call, $async.Future<$0.GetCategoryAnalyticsRequest> request) async {
    return getCategoryAnalytics(call, await request);
  }

  $async.Future<$0.GetMonthlyTrendsResponse> getMonthlyTrends_Pre($grpc.ServiceCall call, $async.Future<$0.GetMonthlyTrendsRequest> request) async {
    return getMonthlyTrends(call, await request);
  }

  $async.Future<$0.GetExpenseTimeSeriesResponse> getExpenseTimeSeries_Pre($grpc.ServiceCall call, $async.Future<$0.GetExpenseTimeSeriesRequest> request) async {
    return getExpenseTimeSeries(call, await request);
  }

  $async.Future<$0.UpdateTransactionStatusResponse> updateTransactionStatus_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateTransactionStatusRequest> request) async {
    return updateTransactionStatus(call, await request);
  }

  $async.Future<$0.CreateAutoSaveResponse> createAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.CreateAutoSaveRequest> request) async {
    return createAutoSave(call, await request);
  }

  $async.Future<$0.GetAutoSavesResponse> getAutoSaves_Pre($grpc.ServiceCall call, $async.Future<$0.GetAutoSavesRequest> request) async {
    return getAutoSaves(call, await request);
  }

  $async.Future<$0.UpdateAutoSaveResponse> updateAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateAutoSaveRequest> request) async {
    return updateAutoSave(call, await request);
  }

  $async.Future<$0.DeleteAutoSaveResponse> deleteAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteAutoSaveRequest> request) async {
    return deleteAutoSave(call, await request);
  }

  $async.Future<$0.CreateLockFundsResponse> createLockFunds_Pre($grpc.ServiceCall call, $async.Future<$0.CreateLockFundsRequest> request) async {
    return createLockFunds(call, await request);
  }

  $async.Future<$0.GetLockFundsResponse> getLockFunds_Pre($grpc.ServiceCall call, $async.Future<$0.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$0.UnlockFundsResponse> unlockFunds_Pre($grpc.ServiceCall call, $async.Future<$0.UnlockFundsRequest> request) async {
    return unlockFunds(call, await request);
  }

  $async.Future<$0.TopUpLockFundsResponse> topUpLockFunds_Pre($grpc.ServiceCall call, $async.Future<$0.TopUpLockFundsRequest> request) async {
    return topUpLockFunds(call, await request);
  }

  $async.Future<$0.GetPiggyVaultConfigResponse> getPiggyVaultConfig_Pre($grpc.ServiceCall call, $async.Future<$0.GetPiggyVaultConfigRequest> request) async {
    return getPiggyVaultConfig(call, await request);
  }

  $async.Future<$0.GetAllPiggyVaultConfigsResponse> getAllPiggyVaultConfigs_Pre($grpc.ServiceCall call, $async.Future<$0.GetAllPiggyVaultConfigsRequest> request) async {
    return getAllPiggyVaultConfigs(call, await request);
  }

  $async.Future<$0.UpdatePiggyVaultConfigResponse> updatePiggyVaultConfig_Pre($grpc.ServiceCall call, $async.Future<$0.UpdatePiggyVaultConfigRequest> request) async {
    return updatePiggyVaultConfig(call, await request);
  }

  $async.Future<$0.CreateLockFundAutoSaveResponse> createLockFundAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.CreateLockFundAutoSaveRequest> request) async {
    return createLockFundAutoSave(call, await request);
  }

  $async.Future<$0.GetLockFundAutoSaveResponse> getLockFundAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.GetLockFundAutoSaveRequest> request) async {
    return getLockFundAutoSave(call, await request);
  }

  $async.Future<$0.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateLockFundAutoSaveRequest> request) async {
    return updateLockFundAutoSave(call, await request);
  }

  $async.Future<$0.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave_Pre($grpc.ServiceCall call, $async.Future<$0.DeleteLockFundAutoSaveRequest> request) async {
    return deleteLockFundAutoSave(call, await request);
  }

  $async.Future<$0.CreateTransferResponse> createTransfer_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTransferRequest> request) async {
    return createTransfer(call, await request);
  }

  $async.Future<$0.CreateVirtualAccountResponse> createVirtualAccount_Pre($grpc.ServiceCall call, $async.Future<$0.CreateVirtualAccountRequest> request) async {
    return createVirtualAccount(call, await request);
  }

  $async.Future<$0.GetTransferResponse> getTransfer_Pre($grpc.ServiceCall call, $async.Future<$0.GetTransferRequest> request) async {
    return getTransfer(call, await request);
  }

  $async.Future<$0.GetUserCategoryMappingsResponse> getUserCategoryMappings_Pre($grpc.ServiceCall call, $async.Future<$0.GetUserCategoryMappingsRequest> request) async {
    return getUserCategoryMappings(call, await request);
  }

  $async.Future<$0.UpdateUserCategoryMappingResponse> updateUserCategoryMapping_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateUserCategoryMappingRequest> request) async {
    return updateUserCategoryMapping(call, await request);
  }

  $async.Future<$0.ReorderCategoriesResponse> reorderCategories_Pre($grpc.ServiceCall call, $async.Future<$0.ReorderCategoriesRequest> request) async {
    return reorderCategories(call, await request);
  }

  $async.Future<$0.UpdateSpendingLimitsResponse> updateSpendingLimits_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateSpendingLimitsRequest> request) async {
    return updateSpendingLimits(call, await request);
  }

  $async.Future<$0.RevealPINResponse> revealPIN_Pre($grpc.ServiceCall call, $async.Future<$0.RevealPINRequest> request) async {
    return revealPIN(call, await request);
  }

  $async.Future<$0.RevealCardDetailsResponse> revealCardDetails_Pre($grpc.ServiceCall call, $async.Future<$0.RevealCardDetailsRequest> request) async {
    return revealCardDetails(call, await request);
  }

  $async.Future<$0.UpdateSecuritySettingsResponse> updateSecuritySettings_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateSecuritySettingsRequest> request) async {
    return updateSecuritySettings(call, await request);
  }

  $async.Future<$0.GenerateStatementResponse> generateStatement_Pre($grpc.ServiceCall call, $async.Future<$0.GenerateStatementRequest> request) async {
    return generateStatement(call, await request);
  }

  $async.Future<$0.GenerateAccountConfirmationResponse> generateAccountConfirmation_Pre($grpc.ServiceCall call, $async.Future<$0.GenerateAccountConfirmationRequest> request) async {
    return generateAccountConfirmation(call, await request);
  }

  $async.Future<$0.GenerateProofOfFundsResponse> generateProofOfFunds_Pre($grpc.ServiceCall call, $async.Future<$0.GenerateProofOfFundsRequest> request) async {
    return generateProofOfFunds(call, await request);
  }

  $async.Future<$0.AdminSearchAccountsResponse> adminSearchAccounts_Pre($grpc.ServiceCall call, $async.Future<$0.AdminSearchAccountsRequest> request) async {
    return adminSearchAccounts(call, await request);
  }

  $async.Future<$0.AdminAccountDetailResponse> adminGetAccountDetail_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetAccountDetailRequest> request) async {
    return adminGetAccountDetail(call, await request);
  }

  $async.Future<$0.AdminAccountTransactionsResponse> adminGetAccountTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetAccountTransactionsRequest> request) async {
    return adminGetAccountTransactions(call, await request);
  }

  $async.Future<$0.AdminAccountHoldsResponse> adminGetAccountHolds_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetAccountHoldsRequest> request) async {
    return adminGetAccountHolds(call, await request);
  }

  $async.Future<$0.AdminAccountClearingResponse> adminGetAccountClearing_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetAccountClearingRequest> request) async {
    return adminGetAccountClearing(call, await request);
  }

  $async.Future<$0.AdminListAllHoldsResponse> adminListAllHolds_Pre($grpc.ServiceCall call, $async.Future<$0.AdminListAllHoldsRequest> request) async {
    return adminListAllHolds(call, await request);
  }

  $async.Future<$0.AdminGetStaleHoldsResponse> adminGetStaleHolds_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetStaleHoldsRequest> request) async {
    return adminGetStaleHolds(call, await request);
  }

  $async.Future<$0.AdminGetAllPlatformWalletsResponse> adminGetAllPlatformWallets_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetAllPlatformWalletsRequest> request) async {
    return adminGetAllPlatformWallets(call, await request);
  }

  $async.Future<$0.AdminGetPlatformWalletTransactionsResponse> adminGetPlatformWalletTransactions_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetPlatformWalletTransactionsRequest> request) async {
    return adminGetPlatformWalletTransactions(call, await request);
  }

  $async.Future<$0.AdminGetClearingRecordsResponse> adminGetClearingRecords_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetClearingRecordsRequest> request) async {
    return adminGetClearingRecords(call, await request);
  }

  $async.Future<$0.AdminGetClearingHealthResponse> adminGetClearingHealth_Pre($grpc.ServiceCall call, $async.Future<$0.AdminGetClearingHealthRequest> request) async {
    return adminGetClearingHealth(call, await request);
  }

  $async.Future<$0.AdminFreezeAccountResponse> adminFreezeAccount_Pre($grpc.ServiceCall call, $async.Future<$0.AdminFreezeAccountRequest> request) async {
    return adminFreezeAccount(call, await request);
  }

  $async.Future<$0.AdminUnfreezeAccountResponse> adminUnfreezeAccount_Pre($grpc.ServiceCall call, $async.Future<$0.AdminUnfreezeAccountRequest> request) async {
    return adminUnfreezeAccount(call, await request);
  }

  $async.Future<$0.CreateAccountResponse> createAccount($grpc.ServiceCall call, $0.CreateAccountRequest request);
  $async.Future<$0.GetAccountsResponse> getAccounts($grpc.ServiceCall call, $0.GetAccountsRequest request);
  $async.Future<$0.GetUserAccountsResponse> getUserAccounts($grpc.ServiceCall call, $0.GetUserAccountsRequest request);
  $async.Future<$0.GetAccountResponse> getAccount($grpc.ServiceCall call, $0.GetAccountRequest request);
  $async.Future<$0.UpdateAccountResponse> updateAccount($grpc.ServiceCall call, $0.UpdateAccountRequest request);
  $async.Future<$0.DeleteAccountResponse> deleteAccount($grpc.ServiceCall call, $0.DeleteAccountRequest request);
  $async.Future<$0.GetBalanceResponse> getBalance($grpc.ServiceCall call, $0.GetBalanceRequest request);
  $async.Future<$0.GetTransactionsResponse> getTransactions($grpc.ServiceCall call, $0.GetTransactionsRequest request);
  $async.Future<$0.FreezeAccountResponse> freezeAccount($grpc.ServiceCall call, $0.FreezeAccountRequest request);
  $async.Future<$0.UnfreezeAccountResponse> unfreezeAccount($grpc.ServiceCall call, $0.UnfreezeAccountRequest request);
  $async.Future<$0.UpdateBalanceResponse> updateBalance($grpc.ServiceCall call, $0.UpdateBalanceRequest request);
  $async.Future<$0.CreditBalanceResponse> creditBalance($grpc.ServiceCall call, $0.CreditBalanceRequest request);
  $async.Future<$0.DebitBalanceResponse> debitBalance($grpc.ServiceCall call, $0.DebitBalanceRequest request);
  $async.Future<$0.TransferBalanceResponse> transferBalance($grpc.ServiceCall call, $0.TransferBalanceRequest request);
  $async.Future<$0.HoldFundsResponse> holdFunds($grpc.ServiceCall call, $0.HoldFundsRequest request);
  $async.Future<$0.CaptureHoldResponse> captureHold($grpc.ServiceCall call, $0.CaptureHoldRequest request);
  $async.Future<$0.ReleaseHoldResponse> releaseHold($grpc.ServiceCall call, $0.ReleaseHoldRequest request);
  $async.Future<$0.CreditToClearingResponse> creditToClearing($grpc.ServiceCall call, $0.CreditToClearingRequest request);
  $async.Future<$0.ClearDepositResponse> clearDeposit($grpc.ServiceCall call, $0.ClearDepositRequest request);
  $async.Future<$0.ReverseClearingDepositResponse> reverseClearingDeposit($grpc.ServiceCall call, $0.ReverseClearingDepositRequest request);
  $async.Future<$0.TransferToPlatformWalletResponse> transferToPlatformWallet($grpc.ServiceCall call, $0.TransferToPlatformWalletRequest request);
  $async.Future<$0.TransferFromPlatformWalletResponse> transferFromPlatformWallet($grpc.ServiceCall call, $0.TransferFromPlatformWalletRequest request);
  $async.Future<$0.CreditPlatformWalletResponse> creditPlatformWallet($grpc.ServiceCall call, $0.CreditPlatformWalletRequest request);
  $async.Future<$0.DebitPlatformWalletResponse> debitPlatformWallet($grpc.ServiceCall call, $0.DebitPlatformWalletRequest request);
  $async.Future<$0.GetPlatformWalletResponse> getPlatformWallet($grpc.ServiceCall call, $0.GetPlatformWalletRequest request);
  $async.Future<$0.GetPlatformWalletTransactionsResponse> getPlatformWalletTransactions($grpc.ServiceCall call, $0.GetPlatformWalletTransactionsRequest request);
  $async.Future<$0.GetAccountByNumberResponse> getAccountByNumber($grpc.ServiceCall call, $0.GetAccountByNumberRequest request);
  $async.Future<$0.CreateTransactionResponse> createTransaction($grpc.ServiceCall call, $0.CreateTransactionRequest request);
  $async.Future<$0.GetTransactionHistoryResponse> getTransactionHistory($grpc.ServiceCall call, $0.GetTransactionHistoryRequest request);
  $async.Future<$0.GetTransactionStatisticsResponse> getTransactionStatistics($grpc.ServiceCall call, $0.GetTransactionStatisticsRequest request);
  $async.Future<$0.GetFinancialAnalyticsResponse> getFinancialAnalytics($grpc.ServiceCall call, $0.GetFinancialAnalyticsRequest request);
  $async.Future<$0.GetCategoryAnalyticsResponse> getCategoryAnalytics($grpc.ServiceCall call, $0.GetCategoryAnalyticsRequest request);
  $async.Future<$0.GetMonthlyTrendsResponse> getMonthlyTrends($grpc.ServiceCall call, $0.GetMonthlyTrendsRequest request);
  $async.Future<$0.GetExpenseTimeSeriesResponse> getExpenseTimeSeries($grpc.ServiceCall call, $0.GetExpenseTimeSeriesRequest request);
  $async.Future<$0.UpdateTransactionStatusResponse> updateTransactionStatus($grpc.ServiceCall call, $0.UpdateTransactionStatusRequest request);
  $async.Future<$0.CreateAutoSaveResponse> createAutoSave($grpc.ServiceCall call, $0.CreateAutoSaveRequest request);
  $async.Future<$0.GetAutoSavesResponse> getAutoSaves($grpc.ServiceCall call, $0.GetAutoSavesRequest request);
  $async.Future<$0.UpdateAutoSaveResponse> updateAutoSave($grpc.ServiceCall call, $0.UpdateAutoSaveRequest request);
  $async.Future<$0.DeleteAutoSaveResponse> deleteAutoSave($grpc.ServiceCall call, $0.DeleteAutoSaveRequest request);
  $async.Future<$0.CreateLockFundsResponse> createLockFunds($grpc.ServiceCall call, $0.CreateLockFundsRequest request);
  $async.Future<$0.GetLockFundsResponse> getLockFunds($grpc.ServiceCall call, $0.GetLockFundsRequest request);
  $async.Future<$0.UnlockFundsResponse> unlockFunds($grpc.ServiceCall call, $0.UnlockFundsRequest request);
  $async.Future<$0.TopUpLockFundsResponse> topUpLockFunds($grpc.ServiceCall call, $0.TopUpLockFundsRequest request);
  $async.Future<$0.GetPiggyVaultConfigResponse> getPiggyVaultConfig($grpc.ServiceCall call, $0.GetPiggyVaultConfigRequest request);
  $async.Future<$0.GetAllPiggyVaultConfigsResponse> getAllPiggyVaultConfigs($grpc.ServiceCall call, $0.GetAllPiggyVaultConfigsRequest request);
  $async.Future<$0.UpdatePiggyVaultConfigResponse> updatePiggyVaultConfig($grpc.ServiceCall call, $0.UpdatePiggyVaultConfigRequest request);
  $async.Future<$0.CreateLockFundAutoSaveResponse> createLockFundAutoSave($grpc.ServiceCall call, $0.CreateLockFundAutoSaveRequest request);
  $async.Future<$0.GetLockFundAutoSaveResponse> getLockFundAutoSave($grpc.ServiceCall call, $0.GetLockFundAutoSaveRequest request);
  $async.Future<$0.UpdateLockFundAutoSaveResponse> updateLockFundAutoSave($grpc.ServiceCall call, $0.UpdateLockFundAutoSaveRequest request);
  $async.Future<$0.DeleteLockFundAutoSaveResponse> deleteLockFundAutoSave($grpc.ServiceCall call, $0.DeleteLockFundAutoSaveRequest request);
  $async.Future<$0.CreateTransferResponse> createTransfer($grpc.ServiceCall call, $0.CreateTransferRequest request);
  $async.Future<$0.CreateVirtualAccountResponse> createVirtualAccount($grpc.ServiceCall call, $0.CreateVirtualAccountRequest request);
  $async.Future<$0.GetTransferResponse> getTransfer($grpc.ServiceCall call, $0.GetTransferRequest request);
  $async.Future<$0.GetUserCategoryMappingsResponse> getUserCategoryMappings($grpc.ServiceCall call, $0.GetUserCategoryMappingsRequest request);
  $async.Future<$0.UpdateUserCategoryMappingResponse> updateUserCategoryMapping($grpc.ServiceCall call, $0.UpdateUserCategoryMappingRequest request);
  $async.Future<$0.ReorderCategoriesResponse> reorderCategories($grpc.ServiceCall call, $0.ReorderCategoriesRequest request);
  $async.Future<$0.UpdateSpendingLimitsResponse> updateSpendingLimits($grpc.ServiceCall call, $0.UpdateSpendingLimitsRequest request);
  $async.Future<$0.RevealPINResponse> revealPIN($grpc.ServiceCall call, $0.RevealPINRequest request);
  $async.Future<$0.RevealCardDetailsResponse> revealCardDetails($grpc.ServiceCall call, $0.RevealCardDetailsRequest request);
  $async.Future<$0.UpdateSecuritySettingsResponse> updateSecuritySettings($grpc.ServiceCall call, $0.UpdateSecuritySettingsRequest request);
  $async.Future<$0.GenerateStatementResponse> generateStatement($grpc.ServiceCall call, $0.GenerateStatementRequest request);
  $async.Future<$0.GenerateAccountConfirmationResponse> generateAccountConfirmation($grpc.ServiceCall call, $0.GenerateAccountConfirmationRequest request);
  $async.Future<$0.GenerateProofOfFundsResponse> generateProofOfFunds($grpc.ServiceCall call, $0.GenerateProofOfFundsRequest request);
  $async.Future<$0.AdminSearchAccountsResponse> adminSearchAccounts($grpc.ServiceCall call, $0.AdminSearchAccountsRequest request);
  $async.Future<$0.AdminAccountDetailResponse> adminGetAccountDetail($grpc.ServiceCall call, $0.AdminGetAccountDetailRequest request);
  $async.Future<$0.AdminAccountTransactionsResponse> adminGetAccountTransactions($grpc.ServiceCall call, $0.AdminGetAccountTransactionsRequest request);
  $async.Future<$0.AdminAccountHoldsResponse> adminGetAccountHolds($grpc.ServiceCall call, $0.AdminGetAccountHoldsRequest request);
  $async.Future<$0.AdminAccountClearingResponse> adminGetAccountClearing($grpc.ServiceCall call, $0.AdminGetAccountClearingRequest request);
  $async.Future<$0.AdminListAllHoldsResponse> adminListAllHolds($grpc.ServiceCall call, $0.AdminListAllHoldsRequest request);
  $async.Future<$0.AdminGetStaleHoldsResponse> adminGetStaleHolds($grpc.ServiceCall call, $0.AdminGetStaleHoldsRequest request);
  $async.Future<$0.AdminGetAllPlatformWalletsResponse> adminGetAllPlatformWallets($grpc.ServiceCall call, $0.AdminGetAllPlatformWalletsRequest request);
  $async.Future<$0.AdminGetPlatformWalletTransactionsResponse> adminGetPlatformWalletTransactions($grpc.ServiceCall call, $0.AdminGetPlatformWalletTransactionsRequest request);
  $async.Future<$0.AdminGetClearingRecordsResponse> adminGetClearingRecords($grpc.ServiceCall call, $0.AdminGetClearingRecordsRequest request);
  $async.Future<$0.AdminGetClearingHealthResponse> adminGetClearingHealth($grpc.ServiceCall call, $0.AdminGetClearingHealthRequest request);
  $async.Future<$0.AdminFreezeAccountResponse> adminFreezeAccount($grpc.ServiceCall call, $0.AdminFreezeAccountRequest request);
  $async.Future<$0.AdminUnfreezeAccountResponse> adminUnfreezeAccount($grpc.ServiceCall call, $0.AdminUnfreezeAccountRequest request);
}
