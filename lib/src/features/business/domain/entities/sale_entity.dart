/// A recorded sale (revenue engine). Money in MINOR units (kobo).
class SaleEntity {
  final String id;
  final String customerId;
  final String customerName;
  final String inventoryItemId;
  final String itemName;
  final String description;
  final int quantity;
  final int unitPrice;
  final int amount;
  final String currency;
  final String paymentMethod;
  final String status; // PAID | UNPAID
  final String reference;
  final String createdAt;

  const SaleEntity({
    required this.id,
    this.customerId = '',
    this.customerName = '',
    this.inventoryItemId = '',
    this.itemName = '',
    this.description = '',
    this.quantity = 1,
    this.unitPrice = 0,
    this.amount = 0,
    this.currency = 'NGN',
    this.paymentMethod = 'cash',
    this.status = 'PAID',
    this.reference = '',
    this.createdAt = '',
  });

  double get amountMajor => amount / 100;
  bool get isPaid => status == 'PAID';

  factory SaleEntity.fromJson(Map<String, dynamic> j) {
    int i(dynamic v) => v is num ? v.toInt() : int.tryParse('${v ?? 0}') ?? 0;
    return SaleEntity(
      id: (j['id'] ?? '').toString(),
      customerId: (j['customer_id'] ?? '').toString(),
      customerName: (j['customer_name'] ?? '').toString(),
      inventoryItemId: (j['inventory_item_id'] ?? '').toString(),
      itemName: (j['item_name'] ?? '').toString(),
      description: (j['description'] ?? '').toString(),
      quantity: i(j['quantity']),
      unitPrice: i(j['unit_price']),
      amount: i(j['amount']),
      currency: (j['currency'] ?? 'NGN').toString(),
      paymentMethod: (j['payment_method'] ?? 'cash').toString(),
      status: (j['status'] ?? 'PAID').toString(),
      reference: (j['reference'] ?? '').toString(),
      createdAt: (j['created_at'] ?? '').toString(),
    );
  }
}
