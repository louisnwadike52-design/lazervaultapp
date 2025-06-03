import '../../domain/entities/invoice_entity.dart';

class InvoiceModel extends Invoice {
  const InvoiceModel({
    required super.id,
    required super.title,
    required super.description,
    required super.amount,
    required super.currency,
    required super.status,
    required super.type,
    required super.createdAt,
    super.dueDate,
    super.paidAt,
    required super.fromUserId,
    super.toUserId,
    super.toEmail,
    super.toName,
    required super.items,
    super.taxAmount,
    super.discountAmount,
    required super.totalAmount,
    super.notes,
    super.paymentMethod,
    super.paymentReference,
    super.qrCodeData,
    super.attachments,
    super.metadata,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: InvoiceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => InvoiceStatus.draft,
      ),
      type: InvoiceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => InvoiceType.request,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date'] as String) : null,
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at'] as String) : null,
      fromUserId: json['from_user_id'] as String,
      toUserId: json['to_user_id'] as String?,
      toEmail: json['to_email'] as String?,
      toName: json['to_name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => InvoiceItemModel.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
      taxAmount: json['tax_amount'] != null ? (json['tax_amount'] as num).toDouble() : null,
      discountAmount: json['discount_amount'] != null ? (json['discount_amount'] as num).toDouble() : null,
      totalAmount: (json['total_amount'] as num).toDouble(),
      notes: json['notes'] as String?,
      paymentMethod: json['payment_method'] != null
          ? PaymentMethod.values.firstWhere(
              (e) => e.name == json['payment_method'],
              orElse: () => PaymentMethod.bank_transfer,
            )
          : null,
      paymentReference: json['payment_reference'] as String?,
      qrCodeData: json['qr_code_data'] as String?,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'] as List)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'currency': currency,
      'status': status.name,
      'type': type.name,
      'created_at': createdAt.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'paid_at': paidAt?.toIso8601String(),
      'from_user_id': fromUserId,
      'to_user_id': toUserId,
      'to_email': toEmail,
      'to_name': toName,
      'items': items.map((item) => InvoiceItemModel.fromInvoiceItem(item).toJson()).toList(),
      'tax_amount': taxAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'notes': notes,
      'payment_method': paymentMethod?.name,
      'payment_reference': paymentReference,
      'qr_code_data': qrCodeData,
      'attachments': attachments,
      'metadata': metadata,
    };
  }

  factory InvoiceModel.fromEntity(Invoice invoice) {
    return InvoiceModel(
      id: invoice.id,
      title: invoice.title,
      description: invoice.description,
      amount: invoice.amount,
      currency: invoice.currency,
      status: invoice.status,
      type: invoice.type,
      createdAt: invoice.createdAt,
      dueDate: invoice.dueDate,
      paidAt: invoice.paidAt,
      fromUserId: invoice.fromUserId,
      toUserId: invoice.toUserId,
      toEmail: invoice.toEmail,
      toName: invoice.toName,
      items: invoice.items,
      taxAmount: invoice.taxAmount,
      discountAmount: invoice.discountAmount,
      totalAmount: invoice.totalAmount,
      notes: invoice.notes,
      paymentMethod: invoice.paymentMethod,
      paymentReference: invoice.paymentReference,
      qrCodeData: invoice.qrCodeData,
      attachments: invoice.attachments,
      metadata: invoice.metadata,
    );
  }
}

class InvoiceItemModel extends InvoiceItem {
  const InvoiceItemModel({
    required super.id,
    required super.name,
    super.description,
    required super.quantity,
    required super.unitPrice,
    required super.totalPrice,
    super.category,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'category': category,
    };
  }

  factory InvoiceItemModel.fromInvoiceItem(InvoiceItem item) {
    return InvoiceItemModel(
      id: item.id,
      name: item.name,
      description: item.description,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      totalPrice: item.totalPrice,
      category: item.category,
    );
  }
} 