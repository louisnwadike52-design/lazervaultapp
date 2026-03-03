import '../../domain/entities/purchase_order_entity.dart';
import '../../domain/entities/supplier_entity.dart';

sealed class InventoryEnhancedState {}

class InventoryEnhancedInitial extends InventoryEnhancedState {}

class InventoryEnhancedLoading extends InventoryEnhancedState {}

class InventoryEnhancedError extends InventoryEnhancedState {
  final String message;
  InventoryEnhancedError({required this.message});
}

// Supplier states
class SuppliersLoaded extends InventoryEnhancedState {
  final List<SupplierEntity> suppliers;
  SuppliersLoaded({required this.suppliers});
}

class SupplierCreated extends InventoryEnhancedState {
  final SupplierEntity supplier;
  SupplierCreated({required this.supplier});
}

class SupplierUpdated extends InventoryEnhancedState {
  final SupplierEntity supplier;
  SupplierUpdated({required this.supplier});
}

class SupplierDeleted extends InventoryEnhancedState {}

// Purchase Order states
class PurchaseOrdersLoaded extends InventoryEnhancedState {
  final List<PurchaseOrderEntity> orders;
  PurchaseOrdersLoaded({required this.orders});
}

class PurchaseOrderLoaded extends InventoryEnhancedState {
  final PurchaseOrderEntity order;
  PurchaseOrderLoaded({required this.order});
}

class PurchaseOrderCreated extends InventoryEnhancedState {
  final PurchaseOrderEntity order;
  PurchaseOrderCreated({required this.order});
}

class PurchaseOrderReceived extends InventoryEnhancedState {
  final PurchaseOrderEntity order;
  PurchaseOrderReceived({required this.order});
}

// Valuation states
class ValuationLoaded extends InventoryEnhancedState {
  final Map<String, dynamic> data;
  ValuationLoaded({required this.data});
}

// Expiry Alert states
class ExpiryAlertsLoaded extends InventoryEnhancedState {
  final List<Map<String, dynamic>> alerts;
  ExpiryAlertsLoaded({required this.alerts});
}
