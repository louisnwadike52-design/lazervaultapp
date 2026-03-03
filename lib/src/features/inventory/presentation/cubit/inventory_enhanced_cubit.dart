import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

import '../../domain/entities/purchase_order_entity.dart';
import '../../domain/entities/supplier_entity.dart';
import '../../domain/repositories/inventory_enhanced_repository.dart';
import 'inventory_enhanced_state.dart';

class InventoryEnhancedCubit extends Cubit<InventoryEnhancedState> {
  final InventoryEnhancedRepository _repository;

  InventoryEnhancedCubit({required InventoryEnhancedRepository repository})
      : _repository = repository,
        super(InventoryEnhancedInitial());

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
        return 'Not found.';
      default:
        return e.message ?? 'An error occurred';
    }
  }

  // ---------------------------------------------------------------------------
  // Supplier methods
  // ---------------------------------------------------------------------------

  Future<void> listSuppliers({
    String? search,
    SupplierStatus? status,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final suppliers = await _repository.listSuppliers(
        search: search,
        status: status,
      );
      if (isClosed) return;
      emit(SuppliersLoaded(suppliers: suppliers));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> createSupplier({
    required String name,
    String contactName = '',
    String email = '',
    String phone = '',
    String address = '',
    String notes = '',
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final supplier = await _repository.createSupplier(
        name: name,
        contactName: contactName,
        email: email,
        phone: phone,
        address: address,
        notes: notes,
      );
      if (isClosed) return;
      emit(SupplierCreated(supplier: supplier));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> updateSupplier({
    required String supplierId,
    String? name,
    String? contactName,
    String? email,
    String? phone,
    String? address,
    SupplierStatus? status,
    String? notes,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final supplier = await _repository.updateSupplier(
        supplierId: supplierId,
        name: name,
        contactName: contactName,
        email: email,
        phone: phone,
        address: address,
        status: status,
        notes: notes,
      );
      if (isClosed) return;
      emit(SupplierUpdated(supplier: supplier));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> deleteSupplier(String supplierId) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      await _repository.deleteSupplier(supplierId);
      if (isClosed) return;
      emit(SupplierDeleted());
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Purchase Order methods
  // ---------------------------------------------------------------------------

  Future<void> listPurchaseOrders({
    PurchaseOrderStatus? status,
    String? supplierId,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final orders = await _repository.listPurchaseOrders(
        status: status,
        supplierId: supplierId,
      );
      if (isClosed) return;
      emit(PurchaseOrdersLoaded(orders: orders));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> getPurchaseOrder(String purchaseOrderId) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final order = await _repository.getPurchaseOrder(purchaseOrderId);
      if (isClosed) return;
      emit(PurchaseOrderLoaded(order: order));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> createPurchaseOrder({
    required String supplierId,
    required List<PurchaseOrderItemEntity> items,
    String notes = '',
    String? expectedDate,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final order = await _repository.createPurchaseOrder(
        supplierId: supplierId,
        items: items,
        notes: notes,
        expectedDate: expectedDate,
      );
      if (isClosed) return;
      emit(PurchaseOrderCreated(order: order));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> receivePurchaseOrder({
    required String purchaseOrderId,
    required List<PurchaseOrderItemEntity> receivedItems,
  }) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final order = await _repository.receivePurchaseOrder(
        purchaseOrderId: purchaseOrderId,
        receivedItems: receivedItems,
      );
      if (isClosed) return;
      emit(PurchaseOrderReceived(order: order));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Valuation & Alerts methods
  // ---------------------------------------------------------------------------

  Future<void> getInventoryValuation() async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final data = await _repository.getInventoryValuation();
      if (isClosed) return;
      emit(ValuationLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }

  Future<void> getExpiryAlerts({int daysAhead = 30}) async {
    try {
      if (isClosed) return;
      emit(InventoryEnhancedLoading());
      final alerts = await _repository.getExpiryAlerts(
        daysAhead: daysAhead,
      );
      if (isClosed) return;
      emit(ExpiryAlertsLoaded(alerts: alerts));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(InventoryEnhancedError(message: e.toString()));
    }
  }
}
