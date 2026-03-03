import 'package:lazervault/src/features/inventory/domain/entities/inventory_adjustment_entity.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';

abstract class InventoryRepository {
  // Item CRUD
  Future<InventoryItemEntity> createItem({
    required String name,
    String description = '',
    String category = '',
    required int quantity,
    required int unitPrice, // in kobo
    String unit = '',
    String sku = '',
    String location = '',
    int minimumStockLevel = 0,
    String notes = '',
  });

  Future<InventoryItemEntity> updateItem({
    required String itemId,
    String? name,
    String? description,
    String? category,
    int? quantity,
    int? unitPrice, // in kobo
    String? unit,
    String? sku,
    String? location,
    int? minimumStockLevel,
    InventoryItemStatus? status,
    String? notes,
  });

  Future<void> deleteItem(String itemId);

  Future<InventoryItemEntity> getItem(String itemId);

  Future<InventoryItemsPageResult> listItems({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    bool? lowStockOnly,
    InventoryItemStatus? status,
  });

  // Quantity Adjustments
  Future<InventoryItemEntity> adjustQuantity({
    required String itemId,
    required AdjustmentType adjustmentType,
    required int quantity,
    String reason = '',
  });

  // Adjustment History
  Future<InventoryAdjustmentsPageResult> getHistory({
    required String itemId,
    int page = 1,
    int limit = 20,
  });

  // Summary
  Future<Map<String, dynamic>> getSummary();
}
