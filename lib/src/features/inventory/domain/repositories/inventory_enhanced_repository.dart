import '../entities/purchase_order_entity.dart';
import '../entities/supplier_entity.dart';

abstract class InventoryEnhancedRepository {
  // ---------------------------------------------------------------------------
  // Suppliers
  // ---------------------------------------------------------------------------

  Future<SupplierEntity> createSupplier({
    required String name,
    String contactName = '',
    String email = '',
    String phone = '',
    String address = '',
    String notes = '',
  });

  Future<SupplierEntity> updateSupplier({
    required String supplierId,
    String? name,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    SupplierStatus? status,
    String? notes,
  });

  Future<void> deleteSupplier(String supplierId);

  Future<List<SupplierEntity>> listSuppliers({
    int page = 1,
    int limit = 50,
    String? search,
    SupplierStatus? status,
  });

  // ---------------------------------------------------------------------------
  // Purchase Orders
  // ---------------------------------------------------------------------------

  Future<PurchaseOrderEntity> createPurchaseOrder({
    required String supplierId,
    required List<PurchaseOrderItemEntity> items,
    String notes = '',
    String? expectedDate, // ISO 8601 date string
  });

  Future<PurchaseOrderEntity> getPurchaseOrder(String purchaseOrderId);

  Future<List<PurchaseOrderEntity>> listPurchaseOrders({
    int page = 1,
    int limit = 20,
    PurchaseOrderStatus? status,
    String? supplierId,
  });

  Future<PurchaseOrderEntity> receivePurchaseOrder({
    required String purchaseOrderId,
    required List<PurchaseOrderItemEntity> receivedItems,
  });

  // ---------------------------------------------------------------------------
  // Valuation & Alerts
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>> getInventoryValuation();

  Future<List<Map<String, dynamic>>> getExpiryAlerts({
    int daysAhead = 30,
  });
}
