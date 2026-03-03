import 'package:equatable/equatable.dart';

class InventoryItemsPageResult {
  final List<InventoryItemEntity> items;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const InventoryItemsPageResult({
    required this.items,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

enum InventoryItemStatus { active, inactive, discontinued }

enum AdjustmentType { add, remove, set }

class InventoryItemEntity extends Equatable {
  final String id;
  final String businessId;
  final String name;
  final String description;
  final String category;
  final int quantity;
  final double unitPrice; // Major units (Naira)
  final String unit;
  final String sku;
  final String location;
  final int minimumStockLevel;
  final InventoryItemStatus status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InventoryItemEntity({
    required this.id,
    required this.businessId,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.unitPrice,
    required this.unit,
    required this.sku,
    required this.location,
    required this.minimumStockLevel,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isLowStock => quantity <= minimumStockLevel;

  String get formattedUnitPrice => '\u20A6${unitPrice.toStringAsFixed(2)}';

  double get totalValue => quantity * unitPrice;

  String get statusDisplay {
    switch (status) {
      case InventoryItemStatus.active:
        return 'Active';
      case InventoryItemStatus.inactive:
        return 'Inactive';
      case InventoryItemStatus.discontinued:
        return 'Discontinued';
    }
  }

  @override
  List<Object?> get props => [id, name, sku, quantity, unitPrice, status];
}
