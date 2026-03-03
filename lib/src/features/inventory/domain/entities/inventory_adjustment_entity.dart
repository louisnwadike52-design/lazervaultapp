import 'package:equatable/equatable.dart';

import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';

class InventoryAdjustmentsPageResult {
  final List<InventoryAdjustmentEntity> adjustments;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  const InventoryAdjustmentsPageResult({
    required this.adjustments,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
  });
}

class InventoryAdjustmentEntity extends Equatable {
  final String id;
  final String itemId;
  final String businessId;
  final AdjustmentType adjustmentType;
  final int quantityChange;
  final int quantityBefore;
  final int quantityAfter;
  final String reason;
  final String adjustedBy;
  final DateTime createdAt;

  const InventoryAdjustmentEntity({
    required this.id,
    required this.itemId,
    required this.businessId,
    required this.adjustmentType,
    required this.quantityChange,
    required this.quantityBefore,
    required this.quantityAfter,
    required this.reason,
    required this.adjustedBy,
    required this.createdAt,
  });

  String get adjustmentTypeDisplay {
    switch (adjustmentType) {
      case AdjustmentType.add:
        return 'Added';
      case AdjustmentType.remove:
        return 'Removed';
      case AdjustmentType.set:
        return 'Set';
    }
  }

  @override
  List<Object?> get props => [id, itemId, adjustmentType, quantityChange];
}
