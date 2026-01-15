///
//  Generated code. Do not modify.
//  source: accounts.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'accounts.pb.dart' as $0;
export 'accounts.pb.dart';

class AccountsServiceClient extends $grpc.Client {
  static final _$createAccount =
      $grpc.ClientMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
          '/accounts.AccountsService/CreateAccount',
          ($0.CreateAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateAccountResponse.fromBuffer(value));
  static final _$getAccounts =
      $grpc.ClientMethod<$0.GetAccountsRequest, $0.GetAccountsResponse>(
          '/accounts.AccountsService/GetAccounts',
          ($0.GetAccountsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAccountsResponse.fromBuffer(value));
  static final _$getAccount =
      $grpc.ClientMethod<$0.GetAccountRequest, $0.GetAccountResponse>(
          '/accounts.AccountsService/GetAccount',
          ($0.GetAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAccountResponse.fromBuffer(value));
  static final _$updateAccount =
      $grpc.ClientMethod<$0.UpdateAccountRequest, $0.UpdateAccountResponse>(
          '/accounts.AccountsService/UpdateAccount',
          ($0.UpdateAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateAccountResponse.fromBuffer(value));
  static final _$deleteAccount =
      $grpc.ClientMethod<$0.DeleteAccountRequest, $0.DeleteAccountResponse>(
          '/accounts.AccountsService/DeleteAccount',
          ($0.DeleteAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteAccountResponse.fromBuffer(value));
  static final _$getBalance =
      $grpc.ClientMethod<$0.GetBalanceRequest, $0.GetBalanceResponse>(
          '/accounts.AccountsService/GetBalance',
          ($0.GetBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetBalanceResponse.fromBuffer(value));
  static final _$getTransactions =
      $grpc.ClientMethod<$0.GetTransactionsRequest, $0.GetTransactionsResponse>(
          '/accounts.AccountsService/GetTransactions',
          ($0.GetTransactionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetTransactionsResponse.fromBuffer(value));
  static final _$freezeAccount =
      $grpc.ClientMethod<$0.FreezeAccountRequest, $0.FreezeAccountResponse>(
          '/accounts.AccountsService/FreezeAccount',
          ($0.FreezeAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FreezeAccountResponse.fromBuffer(value));
  static final _$unfreezeAccount =
      $grpc.ClientMethod<$0.UnfreezeAccountRequest, $0.UnfreezeAccountResponse>(
          '/accounts.AccountsService/UnfreezeAccount',
          ($0.UnfreezeAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UnfreezeAccountResponse.fromBuffer(value));
  static final _$updateBalance =
      $grpc.ClientMethod<$0.UpdateBalanceRequest, $0.UpdateBalanceResponse>(
          '/accounts.AccountsService/UpdateBalance',
          ($0.UpdateBalanceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateBalanceResponse.fromBuffer(value));
  static final _$getAccountByNumber = $grpc.ClientMethod<
          $0.GetAccountByNumberRequest, $0.GetAccountByNumberResponse>(
      '/accounts.AccountsService/GetAccountByNumber',
      ($0.GetAccountByNumberRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetAccountByNumberResponse.fromBuffer(value));
  static final _$createTransaction = $grpc.ClientMethod<
          $0.CreateTransactionRequest, $0.CreateTransactionResponse>(
      '/accounts.AccountsService/CreateTransaction',
      ($0.CreateTransactionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateTransactionResponse.fromBuffer(value));
  static final _$getTransactionHistory = $grpc.ClientMethod<
          $0.GetTransactionHistoryRequest, $0.GetTransactionHistoryResponse>(
      '/accounts.AccountsService/GetTransactionHistory',
      ($0.GetTransactionHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTransactionHistoryResponse.fromBuffer(value));
  static final _$getTransactionStatistics = $grpc.ClientMethod<
          $0.GetTransactionStatisticsRequest,
          $0.GetTransactionStatisticsResponse>(
      '/accounts.AccountsService/GetTransactionStatistics',
      ($0.GetTransactionStatisticsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.GetTransactionStatisticsResponse.fromBuffer(value));
  static final _$createAutoSave =
      $grpc.ClientMethod<$0.CreateAutoSaveRequest, $0.CreateAutoSaveResponse>(
          '/accounts.AccountsService/CreateAutoSave',
          ($0.CreateAutoSaveRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateAutoSaveResponse.fromBuffer(value));
  static final _$getAutoSaves =
      $grpc.ClientMethod<$0.GetAutoSavesRequest, $0.GetAutoSavesResponse>(
          '/accounts.AccountsService/GetAutoSaves',
          ($0.GetAutoSavesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetAutoSavesResponse.fromBuffer(value));
  static final _$updateAutoSave =
      $grpc.ClientMethod<$0.UpdateAutoSaveRequest, $0.UpdateAutoSaveResponse>(
          '/accounts.AccountsService/UpdateAutoSave',
          ($0.UpdateAutoSaveRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateAutoSaveResponse.fromBuffer(value));
  static final _$deleteAutoSave =
      $grpc.ClientMethod<$0.DeleteAutoSaveRequest, $0.DeleteAutoSaveResponse>(
          '/accounts.AccountsService/DeleteAutoSave',
          ($0.DeleteAutoSaveRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteAutoSaveResponse.fromBuffer(value));
  static final _$createLockFunds =
      $grpc.ClientMethod<$0.CreateLockFundsRequest, $0.CreateLockFundsResponse>(
          '/accounts.AccountsService/CreateLockFunds',
          ($0.CreateLockFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateLockFundsResponse.fromBuffer(value));
  static final _$getLockFunds =
      $grpc.ClientMethod<$0.GetLockFundsRequest, $0.GetLockFundsResponse>(
          '/accounts.AccountsService/GetLockFunds',
          ($0.GetLockFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GetLockFundsResponse.fromBuffer(value));
  static final _$unlockFunds =
      $grpc.ClientMethod<$0.UnlockFundsRequest, $0.UnlockFundsResponse>(
          '/accounts.AccountsService/UnlockFunds',
          ($0.UnlockFundsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UnlockFundsResponse.fromBuffer(value));

  AccountsServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateAccountResponse> createAccount(
      $0.CreateAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountsResponse> getAccounts(
      $0.GetAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountResponse> getAccount(
      $0.GetAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAccountResponse> updateAccount(
      $0.UpdateAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAccountResponse> deleteAccount(
      $0.DeleteAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBalanceResponse> getBalance(
      $0.GetBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionsResponse> getTransactions(
      $0.GetTransactionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$0.FreezeAccountResponse> freezeAccount(
      $0.FreezeAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$freezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnfreezeAccountResponse> unfreezeAccount(
      $0.UnfreezeAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unfreezeAccount, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateBalanceResponse> updateBalance(
      $0.UpdateBalanceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateBalance, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAccountByNumberResponse> getAccountByNumber(
      $0.GetAccountByNumberRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountByNumber, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateTransactionResponse> createTransaction(
      $0.CreateTransactionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createTransaction, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionHistoryResponse> getTransactionHistory(
      $0.GetTransactionHistoryRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionHistory, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetTransactionStatisticsResponse>
      getTransactionStatistics($0.GetTransactionStatisticsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactionStatistics, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.CreateAutoSaveResponse> createAutoSave(
      $0.CreateAutoSaveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetAutoSavesResponse> getAutoSaves(
      $0.GetAutoSavesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAutoSaves, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateAutoSaveResponse> updateAutoSave(
      $0.UpdateAutoSaveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeleteAutoSaveResponse> deleteAutoSave(
      $0.DeleteAutoSaveRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAutoSave, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateLockFundsResponse> createLockFunds(
      $0.CreateLockFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetLockFundsResponse> getLockFunds(
      $0.GetLockFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLockFunds, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnlockFundsResponse> unlockFunds(
      $0.UnlockFundsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unlockFunds, request, options: options);
  }
}

abstract class AccountsServiceBase extends $grpc.Service {
  $core.String get $name => 'accounts.AccountsService';

  AccountsServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.CreateAccountRequest, $0.CreateAccountResponse>(
            'CreateAccount',
            createAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.CreateAccountRequest.fromBuffer(value),
            ($0.CreateAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetAccountsRequest, $0.GetAccountsResponse>(
            'GetAccounts',
            getAccounts_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetAccountsRequest.fromBuffer(value),
            ($0.GetAccountsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountRequest, $0.GetAccountResponse>(
        'GetAccount',
        getAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetAccountRequest.fromBuffer(value),
        ($0.GetAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UpdateAccountRequest, $0.UpdateAccountResponse>(
            'UpdateAccount',
            updateAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateAccountRequest.fromBuffer(value),
            ($0.UpdateAccountResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DeleteAccountRequest, $0.DeleteAccountResponse>(
            'DeleteAccount',
            deleteAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DeleteAccountRequest.fromBuffer(value),
            ($0.DeleteAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBalanceRequest, $0.GetBalanceResponse>(
        'GetBalance',
        getBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBalanceRequest.fromBuffer(value),
        ($0.GetBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionsRequest,
            $0.GetTransactionsResponse>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionsRequest.fromBuffer(value),
        ($0.GetTransactionsResponse value) => value.writeToBuffer()));
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
        $grpc.ServiceMethod<$0.UpdateBalanceRequest, $0.UpdateBalanceResponse>(
            'UpdateBalance',
            updateBalance_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UpdateBalanceRequest.fromBuffer(value),
            ($0.UpdateBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetAccountByNumberRequest,
            $0.GetAccountByNumberResponse>(
        'GetAccountByNumber',
        getAccountByNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetAccountByNumberRequest.fromBuffer(value),
        ($0.GetAccountByNumberResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateTransactionRequest,
            $0.CreateTransactionResponse>(
        'CreateTransaction',
        createTransaction_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateTransactionRequest.fromBuffer(value),
        ($0.CreateTransactionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionHistoryRequest,
            $0.GetTransactionHistoryResponse>(
        'GetTransactionHistory',
        getTransactionHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionHistoryRequest.fromBuffer(value),
        ($0.GetTransactionHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetTransactionStatisticsRequest,
            $0.GetTransactionStatisticsResponse>(
        'GetTransactionStatistics',
        getTransactionStatistics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetTransactionStatisticsRequest.fromBuffer(value),
        ($0.GetTransactionStatisticsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateAutoSaveRequest,
            $0.CreateAutoSaveResponse>(
        'CreateAutoSave',
        createAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAutoSaveRequest.fromBuffer(value),
        ($0.CreateAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetAutoSavesRequest, $0.GetAutoSavesResponse>(
            'GetAutoSaves',
            getAutoSaves_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetAutoSavesRequest.fromBuffer(value),
            ($0.GetAutoSavesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateAutoSaveRequest,
            $0.UpdateAutoSaveResponse>(
        'UpdateAutoSave',
        updateAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateAutoSaveRequest.fromBuffer(value),
        ($0.UpdateAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteAutoSaveRequest,
            $0.DeleteAutoSaveResponse>(
        'DeleteAutoSave',
        deleteAutoSave_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteAutoSaveRequest.fromBuffer(value),
        ($0.DeleteAutoSaveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateLockFundsRequest,
            $0.CreateLockFundsResponse>(
        'CreateLockFunds',
        createLockFunds_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateLockFundsRequest.fromBuffer(value),
        ($0.CreateLockFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.GetLockFundsRequest, $0.GetLockFundsResponse>(
            'GetLockFunds',
            getLockFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetLockFundsRequest.fromBuffer(value),
            ($0.GetLockFundsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.UnlockFundsRequest, $0.UnlockFundsResponse>(
            'UnlockFunds',
            unlockFunds_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.UnlockFundsRequest.fromBuffer(value),
            ($0.UnlockFundsResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateAccountResponse> createAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateAccountRequest> request) async {
    return createAccount(call, await request);
  }

  $async.Future<$0.GetAccountsResponse> getAccounts_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetAccountsRequest> request) async {
    return getAccounts(call, await request);
  }

  $async.Future<$0.GetAccountResponse> getAccount_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetAccountRequest> request) async {
    return getAccount(call, await request);
  }

  $async.Future<$0.UpdateAccountResponse> updateAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateAccountRequest> request) async {
    return updateAccount(call, await request);
  }

  $async.Future<$0.DeleteAccountResponse> deleteAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteAccountRequest> request) async {
    return deleteAccount(call, await request);
  }

  $async.Future<$0.GetBalanceResponse> getBalance_Pre($grpc.ServiceCall call,
      $async.Future<$0.GetBalanceRequest> request) async {
    return getBalance(call, await request);
  }

  $async.Future<$0.GetTransactionsResponse> getTransactions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransactionsRequest> request) async {
    return getTransactions(call, await request);
  }

  $async.Future<$0.FreezeAccountResponse> freezeAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.FreezeAccountRequest> request) async {
    return freezeAccount(call, await request);
  }

  $async.Future<$0.UnfreezeAccountResponse> unfreezeAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UnfreezeAccountRequest> request) async {
    return unfreezeAccount(call, await request);
  }

  $async.Future<$0.UpdateBalanceResponse> updateBalance_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateBalanceRequest> request) async {
    return updateBalance(call, await request);
  }

  $async.Future<$0.GetAccountByNumberResponse> getAccountByNumber_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAccountByNumberRequest> request) async {
    return getAccountByNumber(call, await request);
  }

  $async.Future<$0.CreateTransactionResponse> createTransaction_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateTransactionRequest> request) async {
    return createTransaction(call, await request);
  }

  $async.Future<$0.GetTransactionHistoryResponse> getTransactionHistory_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetTransactionHistoryRequest> request) async {
    return getTransactionHistory(call, await request);
  }

  $async.Future<$0.GetTransactionStatisticsResponse>
      getTransactionStatistics_Pre($grpc.ServiceCall call,
          $async.Future<$0.GetTransactionStatisticsRequest> request) async {
    return getTransactionStatistics(call, await request);
  }

  $async.Future<$0.CreateAutoSaveResponse> createAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateAutoSaveRequest> request) async {
    return createAutoSave(call, await request);
  }

  $async.Future<$0.GetAutoSavesResponse> getAutoSaves_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetAutoSavesRequest> request) async {
    return getAutoSaves(call, await request);
  }

  $async.Future<$0.UpdateAutoSaveResponse> updateAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.UpdateAutoSaveRequest> request) async {
    return updateAutoSave(call, await request);
  }

  $async.Future<$0.DeleteAutoSaveResponse> deleteAutoSave_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DeleteAutoSaveRequest> request) async {
    return deleteAutoSave(call, await request);
  }

  $async.Future<$0.CreateLockFundsResponse> createLockFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.CreateLockFundsRequest> request) async {
    return createLockFunds(call, await request);
  }

  $async.Future<$0.GetLockFundsResponse> getLockFunds_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.GetLockFundsRequest> request) async {
    return getLockFunds(call, await request);
  }

  $async.Future<$0.UnlockFundsResponse> unlockFunds_Pre($grpc.ServiceCall call,
      $async.Future<$0.UnlockFundsRequest> request) async {
    return unlockFunds(call, await request);
  }

  $async.Future<$0.CreateAccountResponse> createAccount(
      $grpc.ServiceCall call, $0.CreateAccountRequest request);
  $async.Future<$0.GetAccountsResponse> getAccounts(
      $grpc.ServiceCall call, $0.GetAccountsRequest request);
  $async.Future<$0.GetAccountResponse> getAccount(
      $grpc.ServiceCall call, $0.GetAccountRequest request);
  $async.Future<$0.UpdateAccountResponse> updateAccount(
      $grpc.ServiceCall call, $0.UpdateAccountRequest request);
  $async.Future<$0.DeleteAccountResponse> deleteAccount(
      $grpc.ServiceCall call, $0.DeleteAccountRequest request);
  $async.Future<$0.GetBalanceResponse> getBalance(
      $grpc.ServiceCall call, $0.GetBalanceRequest request);
  $async.Future<$0.GetTransactionsResponse> getTransactions(
      $grpc.ServiceCall call, $0.GetTransactionsRequest request);
  $async.Future<$0.FreezeAccountResponse> freezeAccount(
      $grpc.ServiceCall call, $0.FreezeAccountRequest request);
  $async.Future<$0.UnfreezeAccountResponse> unfreezeAccount(
      $grpc.ServiceCall call, $0.UnfreezeAccountRequest request);
  $async.Future<$0.UpdateBalanceResponse> updateBalance(
      $grpc.ServiceCall call, $0.UpdateBalanceRequest request);
  $async.Future<$0.GetAccountByNumberResponse> getAccountByNumber(
      $grpc.ServiceCall call, $0.GetAccountByNumberRequest request);
  $async.Future<$0.CreateTransactionResponse> createTransaction(
      $grpc.ServiceCall call, $0.CreateTransactionRequest request);
  $async.Future<$0.GetTransactionHistoryResponse> getTransactionHistory(
      $grpc.ServiceCall call, $0.GetTransactionHistoryRequest request);
  $async.Future<$0.GetTransactionStatisticsResponse> getTransactionStatistics(
      $grpc.ServiceCall call, $0.GetTransactionStatisticsRequest request);
  $async.Future<$0.CreateAutoSaveResponse> createAutoSave(
      $grpc.ServiceCall call, $0.CreateAutoSaveRequest request);
  $async.Future<$0.GetAutoSavesResponse> getAutoSaves(
      $grpc.ServiceCall call, $0.GetAutoSavesRequest request);
  $async.Future<$0.UpdateAutoSaveResponse> updateAutoSave(
      $grpc.ServiceCall call, $0.UpdateAutoSaveRequest request);
  $async.Future<$0.DeleteAutoSaveResponse> deleteAutoSave(
      $grpc.ServiceCall call, $0.DeleteAutoSaveRequest request);
  $async.Future<$0.CreateLockFundsResponse> createLockFunds(
      $grpc.ServiceCall call, $0.CreateLockFundsRequest request);
  $async.Future<$0.GetLockFundsResponse> getLockFunds(
      $grpc.ServiceCall call, $0.GetLockFundsRequest request);
  $async.Future<$0.UnlockFundsResponse> unlockFunds(
      $grpc.ServiceCall call, $0.UnlockFundsRequest request);
}
