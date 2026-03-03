import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_pb;
import '../../domain/entities/inventory_adjustment_entity.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/repositories/inventory_repository.dart';

class InventoryRepositoryGrpcImpl implements InventoryRepository {
  final payroll_pb.InventoryServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  InventoryRepositoryGrpcImpl({
    required payroll_pb.InventoryServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ---------------------------------------------------------------------------
  // Item CRUD
  // ---------------------------------------------------------------------------

  @override
  Future<InventoryItemEntity> createItem({
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
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CreateInventoryItemRequest()
          ..name = name
          ..description = description
          ..category = category
          ..quantity = quantity
          ..unitPrice = $fixnum.Int64(unitPrice)
          ..unit = unit
          ..sku = sku
          ..location = location
          ..minimumStockLevel = minimumStockLevel
          ..notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.createInventoryItem(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _itemFromProto(response.item);
      },
    );
  }

  @override
  Future<InventoryItemEntity> updateItem({
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
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.UpdateInventoryItemRequest()
          ..itemId = itemId;

        if (name != null) request.name = name;
        if (description != null) request.description = description;
        if (category != null) request.category = category;
        if (unitPrice != null) {
          request.unitPrice = $fixnum.Int64(unitPrice);
        }
        if (unit != null) request.unit = unit;
        if (sku != null) request.sku = sku;
        if (location != null) request.location = location;
        if (minimumStockLevel != null) {
          request.minimumStockLevel = minimumStockLevel;
        }
        if (status != null) {
          request.status = _itemStatusToProto(status);
        }
        if (notes != null) request.notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.updateInventoryItem(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _itemFromProto(response.item);
      },
    );
  }

  @override
  Future<void> deleteItem(String itemId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.DeleteInventoryItemRequest()
          ..itemId = itemId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.deleteInventoryItem(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }
      },
    );
  }

  @override
  Future<InventoryItemEntity> getItem(String itemId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetInventoryItemRequest()
          ..itemId = itemId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getInventoryItem(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _itemFromProto(response.item);
      },
    );
  }

  @override
  Future<InventoryItemsPageResult> listItems({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    bool? lowStockOnly,
    InventoryItemStatus? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListInventoryItemsRequest()
          ..page = page
          ..limit = limit;

        if (category != null && category.isNotEmpty) {
          request.category = category;
        }
        if (search != null && search.isNotEmpty) {
          request.search = search;
        }
        if (lowStockOnly != null && lowStockOnly) {
          request.lowStockOnly = lowStockOnly;
        }
        if (status != null) {
          request.status = _itemStatusToProto(status);
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listInventoryItems(
          request,
          options: options,
        );

        return InventoryItemsPageResult(
          items:
              response.items.map((i) => _itemFromProto(i)).toList(),
          totalItems: response.pagination.totalItems,
          currentPage: response.pagination.currentPage,
          totalPages: response.pagination.totalPages,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Quantity Adjustments
  // ---------------------------------------------------------------------------

  @override
  Future<InventoryItemEntity> adjustQuantity({
    required String itemId,
    required AdjustmentType adjustmentType,
    required int quantity,
    String reason = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.AdjustInventoryQuantityRequest()
          ..itemId = itemId
          ..adjustmentType = _adjustmentTypeToProto(adjustmentType)
          ..quantity = quantity
          ..reason = reason;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.adjustInventoryQuantity(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _itemFromProto(response.item);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Adjustment History
  // ---------------------------------------------------------------------------

  @override
  Future<InventoryAdjustmentsPageResult> getHistory({
    required String itemId,
    int page = 1,
    int limit = 20,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetInventoryHistoryRequest()
          ..itemId = itemId
          ..page = page
          ..limit = limit;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getInventoryHistory(
          request,
          options: options,
        );

        return InventoryAdjustmentsPageResult(
          adjustments: response.adjustments
              .map((a) => _adjustmentFromProto(a))
              .toList(),
          totalItems: response.pagination.totalItems,
          currentPage: response.pagination.currentPage,
          totalPages: response.pagination.totalPages,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Summary
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getSummary() async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetInventorySummaryRequest();

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getInventorySummary(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return {
          'totalItems': response.totalItems,
          'lowStockItems': response.lowStockItems,
          'totalInventoryValue':
              response.totalInventoryValue.toInt() / 100.0,
          'categories': response.categories
              .map((c) => {
                    'category': c.category,
                    'itemCount': c.itemCount,
                    'totalValue': c.totalValue.toInt() / 100.0,
                    'lowStockCount': c.lowStockCount,
                  })
              .toList(),
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Mappers
  // ---------------------------------------------------------------------------

  InventoryItemEntity _itemFromProto(payroll_pb.InventoryItem proto) {
    return InventoryItemEntity(
      id: proto.id,
      businessId: proto.businessId,
      name: proto.name,
      description: proto.description,
      category: proto.category,
      quantity: proto.quantity,
      unitPrice: proto.unitPrice.toInt() / 100.0,
      unit: proto.unit,
      sku: proto.sku,
      location: proto.location,
      minimumStockLevel: proto.minimumStockLevel,
      status: _itemStatusFromProto(proto.status),
      notes: proto.notes,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  InventoryAdjustmentEntity _adjustmentFromProto(
    payroll_pb.InventoryAdjustment proto,
  ) {
    return InventoryAdjustmentEntity(
      id: proto.id,
      itemId: proto.itemId,
      businessId: proto.businessId,
      adjustmentType: _adjustmentTypeFromProto(proto.adjustmentType),
      quantityChange: proto.quantityChange,
      quantityBefore: proto.quantityBefore,
      quantityAfter: proto.quantityAfter,
      reason: proto.reason,
      adjustedBy: proto.adjustedBy,
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  // ---------------------------------------------------------------------------
  // Entity -> Proto Enum Mappers
  // ---------------------------------------------------------------------------

  payroll_pb.InventoryItemStatus _itemStatusToProto(
    InventoryItemStatus status,
  ) {
    switch (status) {
      case InventoryItemStatus.active:
        return payroll_pb
            .InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE;
      case InventoryItemStatus.inactive:
        return payroll_pb
            .InventoryItemStatus.INVENTORY_ITEM_STATUS_INACTIVE;
      case InventoryItemStatus.discontinued:
        return payroll_pb
            .InventoryItemStatus.INVENTORY_ITEM_STATUS_DISCONTINUED;
    }
  }

  payroll_pb.AdjustmentType _adjustmentTypeToProto(
    AdjustmentType type,
  ) {
    switch (type) {
      case AdjustmentType.add:
        return payroll_pb.AdjustmentType.ADJUSTMENT_TYPE_ADD;
      case AdjustmentType.remove:
        return payroll_pb.AdjustmentType.ADJUSTMENT_TYPE_REMOVE;
      case AdjustmentType.set:
        return payroll_pb.AdjustmentType.ADJUSTMENT_TYPE_SET;
    }
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Enum Mappers
  // ---------------------------------------------------------------------------

  InventoryItemStatus _itemStatusFromProto(
    payroll_pb.InventoryItemStatus status,
  ) {
    switch (status) {
      case payroll_pb
            .InventoryItemStatus.INVENTORY_ITEM_STATUS_ACTIVE:
        return InventoryItemStatus.active;
      case payroll_pb
            .InventoryItemStatus.INVENTORY_ITEM_STATUS_INACTIVE:
        return InventoryItemStatus.inactive;
      case payroll_pb
            .InventoryItemStatus.INVENTORY_ITEM_STATUS_DISCONTINUED:
        return InventoryItemStatus.discontinued;
      default:
        return InventoryItemStatus.active;
    }
  }

  AdjustmentType _adjustmentTypeFromProto(
    payroll_pb.AdjustmentType type,
  ) {
    switch (type) {
      case payroll_pb.AdjustmentType.ADJUSTMENT_TYPE_ADD:
        return AdjustmentType.add;
      case payroll_pb.AdjustmentType.ADJUSTMENT_TYPE_REMOVE:
        return AdjustmentType.remove;
      case payroll_pb.AdjustmentType.ADJUSTMENT_TYPE_SET:
        return AdjustmentType.set;
      default:
        return AdjustmentType.add;
    }
  }
}
