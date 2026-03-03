import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_pb;

import '../../domain/entities/purchase_order_entity.dart';
import '../../domain/entities/supplier_entity.dart';
import '../../domain/repositories/inventory_enhanced_repository.dart';

class InventoryEnhancedRepositoryGrpcImpl
    implements InventoryEnhancedRepository {
  final payroll_pb.InventoryEnhancedServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  InventoryEnhancedRepositoryGrpcImpl({
    required payroll_pb.InventoryEnhancedServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ---------------------------------------------------------------------------
  // Suppliers
  // ---------------------------------------------------------------------------

  @override
  Future<SupplierEntity> createSupplier({
    required String name,
    String contactName = '',
    String email = '',
    String phone = '',
    String address = '',
    String notes = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CreateSupplierRequest()
          ..name = name
          ..contactName = contactName
          ..email = email
          ..phone = phone
          ..address = address
          ..notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.createSupplier(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _supplierFromProto(response.supplier);
      },
    );
  }

  @override
  Future<SupplierEntity> updateSupplier({
    required String supplierId,
    String? name,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    SupplierStatus? status,
    String? notes,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.UpdateSupplierRequest()
          ..supplierId = supplierId;

        if (name != null) request.name = name;
        if (contactName != null) request.contactName = contactName;
        if (email != null) request.email = email;
        if (phone != null) request.phone = phone;
        if (address != null) request.address = address;
        if (status != null) {
          request.status = _supplierStatusToProto(status);
        }
        if (notes != null) request.notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.updateSupplier(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _supplierFromProto(response.supplier);
      },
    );
  }

  @override
  Future<void> deleteSupplier(String supplierId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.DeleteSupplierRequest()
          ..supplierId = supplierId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.deleteSupplier(
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
  Future<List<SupplierEntity>> listSuppliers({
    int page = 1,
    int limit = 50,
    String? search,
    SupplierStatus? status,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListSuppliersRequest()
          ..page = page
          ..limit = limit;

        if (search != null && search.isNotEmpty) {
          request.search = search;
        }
        if (status != null) {
          request.status = _supplierStatusToProto(status);
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listSuppliers(
          request,
          options: options,
        );

        return response.suppliers
            .map((s) => _supplierFromProto(s))
            .toList();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Purchase Orders
  // ---------------------------------------------------------------------------

  @override
  Future<PurchaseOrderEntity> createPurchaseOrder({
    required String supplierId,
    required List<PurchaseOrderItemEntity> items,
    String notes = '',
    String? expectedDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CreatePurchaseOrderRequest()
          ..supplierId = supplierId
          ..notes = notes;

        if (expectedDate != null) {
          request.expectedDate = expectedDate;
        }

        for (final item in items) {
          final protoItem = payroll_pb.PurchaseOrderItem()
            ..itemId = item.itemId
            ..itemName = item.itemName
            ..quantityOrdered = item.quantityOrdered
            ..unitPrice = $fixnum.Int64((item.unitPrice * 100).round())
            ..totalPrice = $fixnum.Int64((item.totalPrice * 100).round());
          request.items.add(protoItem);
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.createPurchaseOrder(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _purchaseOrderFromProto(response.purchaseOrder);
      },
    );
  }

  @override
  Future<PurchaseOrderEntity> getPurchaseOrder(String purchaseOrderId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetPurchaseOrderRequest()
          ..purchaseOrderId = purchaseOrderId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getPurchaseOrder(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _purchaseOrderFromProto(response.purchaseOrder);
      },
    );
  }

  @override
  Future<List<PurchaseOrderEntity>> listPurchaseOrders({
    int page = 1,
    int limit = 20,
    PurchaseOrderStatus? status,
    String? supplierId,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListPurchaseOrdersRequest()
          ..page = page
          ..limit = limit;

        if (status != null) {
          request.status = _purchaseOrderStatusToProto(status);
        }
        if (supplierId != null && supplierId.isNotEmpty) {
          request.supplierId = supplierId;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listPurchaseOrders(
          request,
          options: options,
        );

        return response.purchaseOrders
            .map((po) => _purchaseOrderFromProto(po))
            .toList();
      },
    );
  }

  @override
  Future<PurchaseOrderEntity> receivePurchaseOrder({
    required String purchaseOrderId,
    required List<PurchaseOrderItemEntity> receivedItems,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ReceivePurchaseOrderRequest()
          ..purchaseOrderId = purchaseOrderId;

        for (final item in receivedItems) {
          final protoItem = payroll_pb.PurchaseOrderItem()
            ..itemId = item.itemId
            ..itemName = item.itemName
            ..quantityOrdered = item.quantityOrdered
            ..quantityReceived = item.quantityReceived
            ..unitPrice = $fixnum.Int64((item.unitPrice * 100).round())
            ..totalPrice = $fixnum.Int64((item.totalPrice * 100).round());
          request.receivedItems.add(protoItem);
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.receivePurchaseOrder(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _purchaseOrderFromProto(response.purchaseOrder);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Valuation & Alerts
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getInventoryValuation() async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetInventoryValuationRequest();

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getInventoryValuation(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        final valuation = response.valuation;
        return {
          'totalValue': valuation.totalValue.toInt() / 100.0,
          'totalItems': valuation.totalItems,
          'categories': valuation.categories
              .map((c) => {
                    'category': c.category,
                    'itemCount': c.itemCount,
                    'totalValue': c.totalValue.toInt() / 100.0,
                    'percentage': c.percentage,
                  })
              .toList(),
        };
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getExpiryAlerts({
    int daysAhead = 30,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetExpiryAlertsRequest()
          ..daysAhead = daysAhead;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getExpiryAlerts(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return response.alerts
            .map((a) => {
                  'itemId': a.itemId,
                  'itemName': a.itemName,
                  'category': a.category,
                  'quantity': a.quantity,
                  'expiryDate': a.expiryDate.toDateTime(),
                  'daysUntilExpiry': a.daysUntilExpiry,
                })
            .toList();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Mappers
  // ---------------------------------------------------------------------------

  SupplierEntity _supplierFromProto(payroll_pb.Supplier proto) {
    return SupplierEntity(
      id: proto.id,
      businessId: proto.businessId,
      name: proto.name,
      contactName: proto.contactName,
      email: proto.email,
      phone: proto.phone,
      address: proto.address,
      status: _supplierStatusFromProto(proto.status),
      notes: proto.notes,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  PurchaseOrderEntity _purchaseOrderFromProto(payroll_pb.PurchaseOrder proto) {
    return PurchaseOrderEntity(
      id: proto.id,
      businessId: proto.businessId,
      supplierId: proto.supplierId,
      supplierName: proto.supplierName,
      status: _purchaseOrderStatusFromProto(proto.status),
      items: proto.items
          .map((i) => PurchaseOrderItemEntity(
                itemId: i.itemId,
                itemName: i.itemName,
                quantityOrdered: i.quantityOrdered,
                quantityReceived: i.quantityReceived,
                unitPrice: i.unitPrice.toInt() / 100.0,
                totalPrice: i.totalPrice.toInt() / 100.0,
              ))
          .toList(),
      totalAmount: proto.totalAmount.toInt() / 100.0,
      notes: proto.notes,
      reference: proto.reference,
      expectedDate: proto.hasExpectedDate()
          ? proto.expectedDate.toDateTime()
          : null,
      receivedDate: proto.hasReceivedDate()
          ? proto.receivedDate.toDateTime()
          : null,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  // ---------------------------------------------------------------------------
  // Entity <-> Proto Enum Mappers
  // ---------------------------------------------------------------------------

  payroll_pb.SupplierStatus _supplierStatusToProto(SupplierStatus status) {
    switch (status) {
      case SupplierStatus.active:
        return payroll_pb.SupplierStatus.SUPPLIER_STATUS_ACTIVE;
      case SupplierStatus.inactive:
        return payroll_pb.SupplierStatus.SUPPLIER_STATUS_INACTIVE;
    }
  }

  SupplierStatus _supplierStatusFromProto(payroll_pb.SupplierStatus status) {
    switch (status) {
      case payroll_pb.SupplierStatus.SUPPLIER_STATUS_ACTIVE:
        return SupplierStatus.active;
      case payroll_pb.SupplierStatus.SUPPLIER_STATUS_INACTIVE:
        return SupplierStatus.inactive;
      default:
        return SupplierStatus.active;
    }
  }

  payroll_pb.PurchaseOrderStatus _purchaseOrderStatusToProto(
    PurchaseOrderStatus status,
  ) {
    switch (status) {
      case PurchaseOrderStatus.draft:
        return payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_DRAFT;
      case PurchaseOrderStatus.submitted:
        return payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_SUBMITTED;
      case PurchaseOrderStatus.received:
        return payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_RECEIVED;
      case PurchaseOrderStatus.cancelled:
        return payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_CANCELLED;
    }
  }

  PurchaseOrderStatus _purchaseOrderStatusFromProto(
    payroll_pb.PurchaseOrderStatus status,
  ) {
    switch (status) {
      case payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_DRAFT:
        return PurchaseOrderStatus.draft;
      case payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_SUBMITTED:
        return PurchaseOrderStatus.submitted;
      case payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_RECEIVED:
        return PurchaseOrderStatus.received;
      case payroll_pb.PurchaseOrderStatus.PURCHASE_ORDER_STATUS_CANCELLED:
        return PurchaseOrderStatus.cancelled;
      default:
        return PurchaseOrderStatus.draft;
    }
  }
}
