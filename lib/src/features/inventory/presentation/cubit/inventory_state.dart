import 'package:lazervault/src/features/inventory/domain/entities/inventory_adjustment_entity.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';

sealed class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryError extends InventoryState {
  final String message;
  InventoryError({required this.message});
}

// Item states
class ItemsLoaded extends InventoryState {
  final List<InventoryItemEntity> items;
  final int totalPages;
  final bool isStale;
  ItemsLoaded({
    required this.items,
    this.totalPages = 1,
    this.isStale = false,
  });
}

class ItemLoaded extends InventoryState {
  final InventoryItemEntity item;
  ItemLoaded({required this.item});
}

class ItemCreated extends InventoryState {
  final InventoryItemEntity item;
  ItemCreated({required this.item});
}

class ItemUpdated extends InventoryState {
  final InventoryItemEntity item;
  ItemUpdated({required this.item});
}

class ItemDeleted extends InventoryState {}

// Quantity adjustment states
class QuantityAdjusted extends InventoryState {
  final InventoryItemEntity item;
  final InventoryAdjustmentEntity adjustment;
  QuantityAdjusted({required this.item, required this.adjustment});
}

// History states
class HistoryLoaded extends InventoryState {
  final List<InventoryAdjustmentEntity> adjustments;
  final int totalPages;
  HistoryLoaded({required this.adjustments, this.totalPages = 1});
}

// Summary states
class SummaryLoaded extends InventoryState {
  final Map<String, dynamic> data;
  SummaryLoaded({required this.data});
}
