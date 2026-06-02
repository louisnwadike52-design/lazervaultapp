///
//  Hand-authored gRPC client for the saved-batches + batch-receipts RPCs
//  added in core-payments commit e83680f. Matches the wire layout of the
//  service `payments.PaymentsService` so the gateway routes each call to
//  the existing handler. Replace with regen output once the script runs.
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;

import 'payments.pb.dart' as $payments;
import 'payments_saved_batches.pb.dart' as $sb;

export 'payments_saved_batches.pb.dart';

class SavedBatchesClient extends $grpc.Client {
  static final _$saveBatchDraft =
      $grpc.ClientMethod<$sb.SaveBatchDraftRequest, $sb.SavedBatch>(
          '/payments.PaymentsService/SaveBatchDraft',
          ($sb.SaveBatchDraftRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$listSavedBatches = $grpc.ClientMethod<
          $sb.ListSavedBatchesRequest, $sb.ListSavedBatchesResponse>(
      '/payments.PaymentsService/ListSavedBatches',
      ($sb.ListSavedBatchesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $sb.ListSavedBatchesResponse.fromBuffer(value));
  static final _$getSavedBatch =
      $grpc.ClientMethod<$sb.GetSavedBatchRequest, $sb.SavedBatch>(
          '/payments.PaymentsService/GetSavedBatch',
          ($sb.GetSavedBatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$updateSavedBatch =
      $grpc.ClientMethod<$sb.UpdateSavedBatchRequest, $sb.SavedBatch>(
          '/payments.PaymentsService/UpdateSavedBatch',
          ($sb.UpdateSavedBatchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$deleteSavedBatch = $grpc.ClientMethod<
          $sb.DeleteSavedBatchRequest, $sb.DeleteSavedBatchResponse>(
      '/payments.PaymentsService/DeleteSavedBatch',
      ($sb.DeleteSavedBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $sb.DeleteSavedBatchResponse.fromBuffer(value));
  static final _$addSavedBatchItem =
      $grpc.ClientMethod<$sb.AddSavedBatchItemRequest, $sb.SavedBatch>(
          '/payments.PaymentsService/AddSavedBatchItem',
          ($sb.AddSavedBatchItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$removeSavedBatchItem =
      $grpc.ClientMethod<$sb.RemoveSavedBatchItemRequest, $sb.SavedBatch>(
          '/payments.PaymentsService/RemoveSavedBatchItem',
          ($sb.RemoveSavedBatchItemRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$updateSavedBatchItemAmount = $grpc.ClientMethod<
          $sb.UpdateSavedBatchItemAmountRequest, $sb.SavedBatch>(
      '/payments.PaymentsService/UpdateSavedBatchItemAmount',
      ($sb.UpdateSavedBatchItemAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$applyCollectiveAmount = $grpc.ClientMethod<
          $sb.ApplyCollectiveAmountRequest, $sb.SavedBatch>(
      '/payments.PaymentsService/ApplyCollectiveAmount',
      ($sb.ApplyCollectiveAmountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $sb.SavedBatch.fromBuffer(value));
  static final _$executeFromSavedBatch = $grpc.ClientMethod<
          $sb.ExecuteFromSavedBatchRequest, $payments.BatchTransferResponse>(
      '/payments.PaymentsService/ExecuteFromSavedBatch',
      ($sb.ExecuteFromSavedBatchRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $payments.BatchTransferResponse.fromBuffer(value));
  static final _$getBatchReceipt =
      $grpc.ClientMethod<$sb.GetBatchReceiptRequest, $sb.BatchReceipt>(
          '/payments.PaymentsService/GetBatchReceipt',
          ($sb.GetBatchReceiptRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $sb.BatchReceipt.fromBuffer(value));
  static final _$getBatchItemReceipt = $grpc.ClientMethod<
          $sb.GetBatchItemReceiptRequest, $sb.BatchItemReceipt>(
      '/payments.PaymentsService/GetBatchItemReceipt',
      ($sb.GetBatchItemReceiptRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $sb.BatchItemReceipt.fromBuffer(value));

  SavedBatchesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$sb.SavedBatch> saveBatchDraft(
      $sb.SaveBatchDraftRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$saveBatchDraft, request, options: options);

  $grpc.ResponseFuture<$sb.ListSavedBatchesResponse> listSavedBatches(
      $sb.ListSavedBatchesRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$listSavedBatches, request, options: options);

  $grpc.ResponseFuture<$sb.SavedBatch> getSavedBatch(
      $sb.GetSavedBatchRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$getSavedBatch, request, options: options);

  $grpc.ResponseFuture<$sb.SavedBatch> updateSavedBatch(
      $sb.UpdateSavedBatchRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$updateSavedBatch, request, options: options);

  $grpc.ResponseFuture<$sb.DeleteSavedBatchResponse> deleteSavedBatch(
      $sb.DeleteSavedBatchRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$deleteSavedBatch, request, options: options);

  $grpc.ResponseFuture<$sb.SavedBatch> addSavedBatchItem(
      $sb.AddSavedBatchItemRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$addSavedBatchItem, request, options: options);

  $grpc.ResponseFuture<$sb.SavedBatch> removeSavedBatchItem(
      $sb.RemoveSavedBatchItemRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$removeSavedBatchItem, request, options: options);

  $grpc.ResponseFuture<$sb.SavedBatch> updateSavedBatchItemAmount(
      $sb.UpdateSavedBatchItemAmountRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$updateSavedBatchItemAmount, request, options: options);

  $grpc.ResponseFuture<$sb.SavedBatch> applyCollectiveAmount(
      $sb.ApplyCollectiveAmountRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$applyCollectiveAmount, request, options: options);

  $grpc.ResponseFuture<$payments.BatchTransferResponse> executeFromSavedBatch(
      $sb.ExecuteFromSavedBatchRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$executeFromSavedBatch, request, options: options);

  $grpc.ResponseFuture<$sb.BatchReceipt> getBatchReceipt(
      $sb.GetBatchReceiptRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$getBatchReceipt, request, options: options);

  $grpc.ResponseFuture<$sb.BatchItemReceipt> getBatchItemReceipt(
      $sb.GetBatchItemReceiptRequest request,
      {$grpc.CallOptions? options}) =>
      $createUnaryCall(_$getBatchItemReceipt, request, options: options);
}

