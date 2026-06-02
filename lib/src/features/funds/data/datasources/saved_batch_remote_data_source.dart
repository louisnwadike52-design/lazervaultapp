import 'package:grpc/grpc.dart';

import 'package:lazervault/core/exceptions/server_exception.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/funds/data/models/batch_transfer_model.dart';
import 'package:lazervault/src/features/funds/data/models/saved_batch_model.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/generated/payments_saved_batches.pbgrpc.dart'
    as sb_grpc;
import 'package:lazervault/src/generated/payments_saved_batches.pb.dart'
    as sb_proto;

abstract class ISavedBatchRemoteDataSource {
  Future<SavedBatchEntity> saveBatchDraft({
    required String name,
    required String currency,
    required String sourceAccountId,
    required List<SavedBatchItemInputEntity> items,
  });

  Future<(List<SavedBatchEntity>, int)> listSavedBatches({
    int limit = 20,
    int offset = 0,
  });

  Future<SavedBatchEntity> getSavedBatch(String id);
  Future<SavedBatchEntity> updateSavedBatch(
      {required String id, required String name});
  Future<bool> deleteSavedBatch(String id);

  Future<SavedBatchEntity> addItem({
    required String savedBatchId,
    required SavedBatchItemInputEntity item,
  });
  Future<SavedBatchEntity> removeItem(
      {required String savedBatchId, required String itemId});
  Future<SavedBatchEntity> updateItemAmount({
    required String savedBatchId,
    required String itemId,
    required double amount,
  });
  Future<SavedBatchEntity> applyCollectiveAmount({
    required String savedBatchId,
    double? multiplier,
    double? amountPerItem,
  });
  Future<BatchTransferEntity> executeFromSavedBatch({
    required String savedBatchId,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    Map<String, double> perItemOverrides = const {},
    String? sourceAccountId,
  });
  Future<BatchReceiptEntity> getBatchReceipt(String batchId);
  Future<BatchItemReceiptEntity> getBatchItemReceipt(String itemId);
}

class SavedBatchRemoteDataSourceImpl implements ISavedBatchRemoteDataSource {
  final sb_grpc.SavedBatchesClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  SavedBatchRemoteDataSourceImpl(this._client, this._callOptionsHelper);

  ServerException _toServerException(Object e, String op) {
    if (e is GrpcError) {
      return ServerException(
        message: 'Failed to $op: ${e.message ?? e.codeName}',
      );
    }
    return ServerException(
      message: 'Unexpected error during $op: ${e.toString()}',
    );
  }

  Future<T> _call<T>(String op, Future<T> Function() body) async {
    try {
      return await _callOptionsHelper.executeWithTokenRotation(body);
    } catch (e) {
      throw _toServerException(e, op);
    }
  }

  sb_proto.SavedBatchItemInput _itemToProto(SavedBatchItemInputEntity e) {
    return sb_proto.SavedBatchItemInput(
      recipientType:
          e.recipientType.isEmpty ? 'external_bank' : e.recipientType,
      recipientUserId: e.recipientUserId,
      bankCode: e.bankCode,
      accountNumber: e.accountNumber,
      beneficiaryName: e.beneficiaryName,
      amount: e.amount,
      narration: e.narration,
      sortOrder: e.sortOrder,
    );
  }

  @override
  Future<SavedBatchEntity> saveBatchDraft({
    required String name,
    required String currency,
    required String sourceAccountId,
    required List<SavedBatchItemInputEntity> items,
  }) async {
    return _call('save batch draft', () async {
      final req = sb_proto.SaveBatchDraftRequest(
        name: name,
        currency: currency,
        sourceAccountId: sourceAccountId,
        items: items.map(_itemToProto).toList(),
      );
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.saveBatchDraft(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<(List<SavedBatchEntity>, int)> listSavedBatches({
    int limit = 20,
    int offset = 0,
  }) async {
    return _call('list saved batches', () async {
      final req =
          sb_proto.ListSavedBatchesRequest(limit: limit, offset: offset);
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.listSavedBatches(req, options: opts);
      final batches = res.batches
          .map<SavedBatchEntity>((b) => SavedBatchModel.fromProto(b))
          .toList(growable: false);
      return (batches, res.total.toInt());
    });
  }

  @override
  Future<SavedBatchEntity> getSavedBatch(String id) async {
    return _call('get saved batch', () async {
      final req = sb_proto.GetSavedBatchRequest(id: id);
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.getSavedBatch(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<SavedBatchEntity> updateSavedBatch(
      {required String id, required String name}) async {
    return _call('update saved batch', () async {
      final req = sb_proto.UpdateSavedBatchRequest(id: id, name: name);
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.updateSavedBatch(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<bool> deleteSavedBatch(String id) async {
    return _call('delete saved batch', () async {
      final req = sb_proto.DeleteSavedBatchRequest(id: id);
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.deleteSavedBatch(req, options: opts);
      return res.success;
    });
  }

  @override
  Future<SavedBatchEntity> addItem({
    required String savedBatchId,
    required SavedBatchItemInputEntity item,
  }) async {
    return _call('add item', () async {
      final req = sb_proto.AddSavedBatchItemRequest(
        savedBatchId: savedBatchId,
        item: _itemToProto(item),
      );
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.addSavedBatchItem(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<SavedBatchEntity> removeItem(
      {required String savedBatchId, required String itemId}) async {
    return _call('remove item', () async {
      final req = sb_proto.RemoveSavedBatchItemRequest(
        savedBatchId: savedBatchId,
        itemId: itemId,
      );
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.removeSavedBatchItem(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<SavedBatchEntity> updateItemAmount({
    required String savedBatchId,
    required String itemId,
    required double amount,
  }) async {
    return _call('update item amount', () async {
      final req = sb_proto.UpdateSavedBatchItemAmountRequest(
        savedBatchId: savedBatchId,
        itemId: itemId,
        amount: amount,
      );
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res =
          await _client.updateSavedBatchItemAmount(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<SavedBatchEntity> applyCollectiveAmount({
    required String savedBatchId,
    double? multiplier,
    double? amountPerItem,
  }) async {
    return _call('apply collective amount', () async {
      final req = sb_proto.ApplyCollectiveAmountRequest(
        savedBatchId: savedBatchId,
        multiplier: multiplier,
        amountPerItem: amountPerItem,
      );
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.applyCollectiveAmount(req, options: opts);
      return SavedBatchModel.fromProto(res);
    });
  }

  @override
  Future<BatchTransferEntity> executeFromSavedBatch({
    required String savedBatchId,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    Map<String, double> perItemOverrides = const {},
    String? sourceAccountId,
  }) async {
    return _call('execute saved batch', () async {
      final req = sb_proto.ExecuteFromSavedBatchRequest(
        savedBatchId: savedBatchId,
        idempotencyKey: idempotencyKey,
        transactionId: transactionId,
        verificationToken: verificationToken,
        perItemOverrides: perItemOverrides,
        sourceAccountId: sourceAccountId ?? '',
      );
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(
          timeout: const Duration(seconds: 90),
          metadata: <String, String>{
            'x-idempotency-key': idempotencyKey,
          },
        ),
      );
      final res = await _client.executeFromSavedBatch(req, options: opts);
      return InitiateBatchTransferResponseModel.fromPaymentsProto(res);
    });
  }

  @override
  Future<BatchReceiptEntity> getBatchReceipt(String batchId) async {
    return _call('get batch receipt', () async {
      final req = sb_proto.GetBatchReceiptRequest(batchId: batchId);
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.getBatchReceipt(req, options: opts);
      return BatchReceiptModel.fromProto(res);
    });
  }

  @override
  Future<BatchItemReceiptEntity> getBatchItemReceipt(String itemId) async {
    return _call('get batch item receipt', () async {
      final req = sb_proto.GetBatchItemReceiptRequest(itemId: itemId);
      final opts = (await _callOptionsHelper.withAuth()).mergedWith(
        CallOptions(timeout: const Duration(seconds: 30)),
      );
      final res = await _client.getBatchItemReceipt(req, options: opts);
      return BatchItemReceiptModel.fromProto(res);
    });
  }
}
