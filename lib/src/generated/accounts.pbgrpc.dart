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
  static final _$transferToPlatformWallet = $grpc.ClientMethod<$0.TransferToPlatformWalletRequest, $0.TransferToPlatformWalletResponse>(
      '/accounts.AccountsService/TransferToPlatformWallet',
      ($0.TransferToPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TransferToPlatformWalletResponse.fromBuffer(value));
  static final _$transferFromPlatformWallet = $grpc.ClientMethod<$0.TransferFromPlatformWalletRequest, $0.TransferFromPlatformWalletResponse>(
      '/accounts.AccountsService/TransferFromPlatformWallet',
      ($0.TransferFromPlatformWalletRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TransferFromPlatformWalletResponse.fromBuffer(value));
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

  $grpc.ResponseFuture<$0.TransferToPlatformWalletResponse> transferToPlatformWallet($0.TransferToPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferToPlatformWallet, request, options: options);
  }

  $grpc.ResponseFuture<$0.TransferFromPlatformWalletResponse> transferFromPlatformWallet($0.TransferFromPlatformWalletRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$transferFromPlatformWallet, request, options: options);
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

  $grpc.ResponseFuture<$0.CreateTransferResponse> createTransfer($0.CreateTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransfer, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateVirtualAccountResponse> createVirtualAccount($0.CreateVirtualAccountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createVirtualAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransferResponse> getTransfer($0.GetTransferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransfer, request, options: options);
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

  $async.Future<$0.TransferToPlatformWalletResponse> transferToPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.TransferToPlatformWalletRequest> request) async {
    return transferToPlatformWallet(call, await request);
  }

  $async.Future<$0.TransferFromPlatformWalletResponse> transferFromPlatformWallet_Pre($grpc.ServiceCall call, $async.Future<$0.TransferFromPlatformWalletRequest> request) async {
    return transferFromPlatformWallet(call, await request);
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

  $async.Future<$0.CreateTransferResponse> createTransfer_Pre($grpc.ServiceCall call, $async.Future<$0.CreateTransferRequest> request) async {
    return createTransfer(call, await request);
  }

  $async.Future<$0.CreateVirtualAccountResponse> createVirtualAccount_Pre($grpc.ServiceCall call, $async.Future<$0.CreateVirtualAccountRequest> request) async {
    return createVirtualAccount(call, await request);
  }

  $async.Future<$0.GetTransferResponse> getTransfer_Pre($grpc.ServiceCall call, $async.Future<$0.GetTransferRequest> request) async {
    return getTransfer(call, await request);
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
  $async.Future<$0.TransferToPlatformWalletResponse> transferToPlatformWallet($grpc.ServiceCall call, $0.TransferToPlatformWalletRequest request);
  $async.Future<$0.TransferFromPlatformWalletResponse> transferFromPlatformWallet($grpc.ServiceCall call, $0.TransferFromPlatformWalletRequest request);
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
  $async.Future<$0.CreateTransferResponse> createTransfer($grpc.ServiceCall call, $0.CreateTransferRequest request);
  $async.Future<$0.CreateVirtualAccountResponse> createVirtualAccount($grpc.ServiceCall call, $0.CreateVirtualAccountRequest request);
  $async.Future<$0.GetTransferResponse> getTransfer($grpc.ServiceCall call, $0.GetTransferRequest request);
}
