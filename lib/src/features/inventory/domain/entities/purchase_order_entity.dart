import 'dart:ui';

import 'package:equatable/equatable.dart';

enum PurchaseOrderStatus { draft, submitted, received, cancelled }

class PurchaseOrderItemEntity {
  final String itemId;
  final String itemName;
  final int quantityOrdered;
  final int quantityReceived;
  final double unitPrice; // Major units (Naira)
  final double totalPrice; // Major units (Naira)

  const PurchaseOrderItemEntity({
    required this.itemId,
    required this.itemName,
    required this.quantityOrdered,
    required this.quantityReceived,
    required this.unitPrice,
    required this.totalPrice,
  });

  String get formattedUnitPrice => '\u20A6${unitPrice.toStringAsFixed(2)}';
  String get formattedTotalPrice => '\u20A6${totalPrice.toStringAsFixed(2)}';
}

class PurchaseOrderEntity extends Equatable {
  final String id;
  final String businessId;
  final String supplierId;
  final String supplierName;
  final PurchaseOrderStatus status;
  final List<PurchaseOrderItemEntity> items;
  final double totalAmount; // Major units (Naira)
  final String notes;
  final String reference;
  final DateTime? expectedDate;
  final DateTime? receivedDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PurchaseOrderEntity({
    required this.id,
    required this.businessId,
    required this.supplierId,
    required this.supplierName,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.notes,
    required this.reference,
    this.expectedDate,
    this.receivedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  String get statusDisplay {
    switch (status) {
      case PurchaseOrderStatus.draft:
        return 'Draft';
      case PurchaseOrderStatus.submitted:
        return 'Submitted';
      case PurchaseOrderStatus.received:
        return 'Received';
      case PurchaseOrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case PurchaseOrderStatus.draft:
        return const Color(0xFF9CA3AF);
      case PurchaseOrderStatus.submitted:
        return const Color(0xFF3B82F6);
      case PurchaseOrderStatus.received:
        return const Color(0xFF10B981);
      case PurchaseOrderStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  String get formattedTotal => '\u20A6${totalAmount.toStringAsFixed(2)}';

  int get totalItemCount =>
      items.fold(0, (sum, item) => sum + item.quantityOrdered);

  @override
  List<Object?> get props => [id, reference, status];
}
