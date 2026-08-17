part of 'purchase_order_list_screen.dart';

/// Helper class to hold text controllers for a single PO line item input.
class _PurchaseOrderItemInput {
  final itemIdController = TextEditingController();
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  void dispose() {
    itemIdController.dispose();
    itemNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }
}
