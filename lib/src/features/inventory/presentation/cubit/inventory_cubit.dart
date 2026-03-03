import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:lazervault/src/features/inventory/domain/repositories/inventory_repository.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final InventoryRepository _repository;

  InventoryCubit({required InventoryRepository repository})
      : _repository = repository,
        super(InventoryInitial());

  String _friendlyGrpcError(GrpcError e) {
    switch (e.code) {
      case StatusCode.unavailable:
        return 'Unable to reach inventory service. Check your connection.';
      case StatusCode.deadlineExceeded:
        return 'Request timed out. Please try again.';
      case StatusCode.permissionDenied:
        return 'You don\'t have permission for this action.';
      case StatusCode.unauthenticated:
        return 'Session expired. Please log in again.';
      case StatusCode.notFound:
        return 'Item not found.';
      default:
        return e.message ?? 'An error occurred';
    }
  }

  // ---------------------------------------------------------------------------
  // Item methods
  // ---------------------------------------------------------------------------

  Future<void> listItems({
    int page = 1,
    String? category,
    String? search,
    bool? lowStockOnly,
    InventoryItemStatus? status,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      final result = await _repository.listItems(
        page: page,
        category: category,
        search: search,
        lowStockOnly: lowStockOnly,
        status: status,
      );
      if (isClosed) return;
      emit(ItemsLoaded(
        items: result.items,
        totalPages: result.totalPages,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  Future<void> getItem(String itemId) async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      final item = await _repository.getItem(itemId);
      if (isClosed) return;
      emit(ItemLoaded(item: item));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  Future<void> createItem({
    required String name,
    String description = '',
    String category = '',
    required int quantity,
    required int unitPrice,
    String unit = '',
    String sku = '',
    String location = '',
    int minimumStockLevel = 0,
    String notes = '',
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      final item = await _repository.createItem(
        name: name,
        description: description,
        category: category,
        quantity: quantity,
        unitPrice: unitPrice,
        unit: unit,
        sku: sku,
        location: location,
        minimumStockLevel: minimumStockLevel,
        notes: notes,
      );
      if (isClosed) return;
      emit(ItemCreated(item: item));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  Future<void> updateItem({
    required String itemId,
    String? name,
    String? description,
    String? category,
    int? quantity,
    int? unitPrice,
    String? unit,
    String? sku,
    String? location,
    int? minimumStockLevel,
    InventoryItemStatus? status,
    String? notes,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      final item = await _repository.updateItem(
        itemId: itemId,
        name: name,
        description: description,
        category: category,
        quantity: quantity,
        unitPrice: unitPrice,
        unit: unit,
        sku: sku,
        location: location,
        minimumStockLevel: minimumStockLevel,
        status: status,
        notes: notes,
      );
      if (isClosed) return;
      emit(ItemUpdated(item: item));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      await _repository.deleteItem(itemId);
      if (isClosed) return;
      emit(ItemDeleted());
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Quantity Adjustment methods
  // ---------------------------------------------------------------------------

  Future<void> adjustQuantity({
    required String itemId,
    required AdjustmentType adjustmentType,
    required int quantity,
    String reason = '',
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      final item = await _repository.adjustQuantity(
        itemId: itemId,
        adjustmentType: adjustmentType,
        quantity: quantity,
        reason: reason,
      );
      if (isClosed) return;
      // Re-fetch history to get the adjustment record
      final history = await _repository.getHistory(
        itemId: itemId,
        page: 1,
        limit: 1,
      );
      if (isClosed) return;
      if (history.adjustments.isNotEmpty) {
        emit(QuantityAdjusted(
          item: item,
          adjustment: history.adjustments.first,
        ));
      } else {
        emit(ItemUpdated(item: item));
      }
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // History methods
  // ---------------------------------------------------------------------------

  Future<void> getHistory({
    required String itemId,
    int page = 1,
  }) async {
    try {
      if (isClosed) return;
      // Don't emit InventoryLoading — detail screen uses local _historyLoading
      final result = await _repository.getHistory(
        itemId: itemId,
        page: page,
      );
      if (isClosed) return;
      emit(HistoryLoaded(
        adjustments: result.adjustments,
        totalPages: result.totalPages,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Summary methods
  // ---------------------------------------------------------------------------

  Future<void> getSummary() async {
    try {
      if (isClosed) return;
      emit(InventoryLoading());
      final data = await _repository.getSummary();
      if (isClosed) return;
      emit(SummaryLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryError(message: e.toString()));
    }
  }
}
