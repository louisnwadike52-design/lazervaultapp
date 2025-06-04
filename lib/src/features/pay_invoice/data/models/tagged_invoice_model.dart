import '../../domain/entities/tagged_invoice_entity.dart';

class TaggedInvoiceModel extends TaggedInvoice {
  const TaggedInvoiceModel({
    required super.id,
    required super.invoiceNumber,
    required super.title,
    required super.description,
    required super.amount,
    required super.currency,
    required super.createdAt,
    super.dueDate,
    super.paidAt,
    required super.paymentStatus,
    required super.priority,
    required super.fromUserId,
    required super.fromUserName,
    required super.fromUserEmail,
    super.fromCompanyName,
    super.fromCompanyLogo,
    required super.toUserId,
    required super.toUserName,
    required super.toUserEmail,
    required super.items,
    super.taxAmount,
    super.discountAmount,
    required super.totalAmount,
    super.notes,
    super.paymentReference,
    super.qrCodeData,
    super.metadata,
    required super.isOverdue,
    required super.daysUntilDue,
  });

  // Factory constructor from JSON (for API integration)
  factory TaggedInvoiceModel.fromJson(Map<String, dynamic> json) {
    return TaggedInvoiceModel(
      id: json['id'] as String,
      invoiceNumber: json['invoice_number'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date'] as String) : null,
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at'] as String) : null,
      paymentStatus: PaymentStatus.values.firstWhere(
        (status) => status.name == json['payment_status'],
        orElse: () => PaymentStatus.pending,
      ),
      priority: InvoicePriority.values.firstWhere(
        (priority) => priority.name == json['priority'],
        orElse: () => InvoicePriority.medium,
      ),
      fromUserId: json['from_user_id'] as String,
      fromUserName: json['from_user_name'] as String,
      fromUserEmail: json['from_user_email'] as String,
      fromCompanyName: json['from_company_name'] as String?,
      fromCompanyLogo: json['from_company_logo'] as String?,
      toUserId: json['to_user_id'] as String,
      toUserName: json['to_user_name'] as String,
      toUserEmail: json['to_user_email'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => InvoiceItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      taxAmount: json['tax_amount'] != null ? (json['tax_amount'] as num).toDouble() : null,
      discountAmount: json['discount_amount'] != null ? (json['discount_amount'] as num).toDouble() : null,
      totalAmount: (json['total_amount'] as num).toDouble(),
      notes: json['notes'] as String?,
      paymentReference: json['payment_reference'] as String?,
      qrCodeData: json['qr_code_data'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      isOverdue: json['is_overdue'] as bool? ?? false,
      daysUntilDue: json['days_until_due'] as int? ?? 0,
    );
  }

  // Convert to JSON (for API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_number': invoiceNumber,
      'title': title,
      'description': description,
      'amount': amount,
      'currency': currency,
      'created_at': createdAt.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'paid_at': paidAt?.toIso8601String(),
      'payment_status': paymentStatus.name,
      'priority': priority.name,
      'from_user_id': fromUserId,
      'from_user_name': fromUserName,
      'from_user_email': fromUserEmail,
      'from_company_name': fromCompanyName,
      'from_company_logo': fromCompanyLogo,
      'to_user_id': toUserId,
      'to_user_name': toUserName,
      'to_user_email': toUserEmail,
      'items': items.map((item) => (item as InvoiceItemModel).toJson()).toList(),
      'tax_amount': taxAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'notes': notes,
      'payment_reference': paymentReference,
      'qr_code_data': qrCodeData,
      'metadata': metadata,
      'is_overdue': isOverdue,
      'days_until_due': daysUntilDue,
    };
  }

  // Factory constructor from entity
  factory TaggedInvoiceModel.fromEntity(TaggedInvoice entity) {
    return TaggedInvoiceModel(
      id: entity.id,
      invoiceNumber: entity.invoiceNumber,
      title: entity.title,
      description: entity.description,
      amount: entity.amount,
      currency: entity.currency,
      createdAt: entity.createdAt,
      dueDate: entity.dueDate,
      paidAt: entity.paidAt,
      paymentStatus: entity.paymentStatus,
      priority: entity.priority,
      fromUserId: entity.fromUserId,
      fromUserName: entity.fromUserName,
      fromUserEmail: entity.fromUserEmail,
      fromCompanyName: entity.fromCompanyName,
      fromCompanyLogo: entity.fromCompanyLogo,
      toUserId: entity.toUserId,
      toUserName: entity.toUserName,
      toUserEmail: entity.toUserEmail,
      items: entity.items.map((item) => InvoiceItemModel.fromEntity(item)).toList(),
      taxAmount: entity.taxAmount,
      discountAmount: entity.discountAmount,
      totalAmount: entity.totalAmount,
      notes: entity.notes,
      paymentReference: entity.paymentReference,
      qrCodeData: entity.qrCodeData,
      metadata: entity.metadata,
      isOverdue: entity.isOverdue,
      daysUntilDue: entity.daysUntilDue,
    );
  }

  // CopyWith method for immutable updates
  @override
  TaggedInvoiceModel copyWith({
    String? id,
    String? invoiceNumber,
    String? title,
    String? description,
    double? amount,
    String? currency,
    DateTime? createdAt,
    DateTime? dueDate,
    DateTime? paidAt,
    PaymentStatus? paymentStatus,
    InvoicePriority? priority,
    String? fromUserId,
    String? fromUserName,
    String? fromUserEmail,
    String? fromCompanyName,
    String? fromCompanyLogo,
    String? toUserId,
    String? toUserName,
    String? toUserEmail,
    List<InvoiceItem>? items,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    String? notes,
    String? paymentReference,
    String? qrCodeData,
    Map<String, dynamic>? metadata,
    bool? isOverdue,
    int? daysUntilDue,
  }) {
    return TaggedInvoiceModel(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      paidAt: paidAt ?? this.paidAt,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      priority: priority ?? this.priority,
      fromUserId: fromUserId ?? this.fromUserId,
      fromUserName: fromUserName ?? this.fromUserName,
      fromUserEmail: fromUserEmail ?? this.fromUserEmail,
      fromCompanyName: fromCompanyName ?? this.fromCompanyName,
      fromCompanyLogo: fromCompanyLogo ?? this.fromCompanyLogo,
      toUserId: toUserId ?? this.toUserId,
      toUserName: toUserName ?? this.toUserName,
      toUserEmail: toUserEmail ?? this.toUserEmail,
      items: items ?? this.items,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      paymentReference: paymentReference ?? this.paymentReference,
      qrCodeData: qrCodeData ?? this.qrCodeData,
      metadata: metadata ?? this.metadata,
      isOverdue: isOverdue ?? this.isOverdue,
      daysUntilDue: daysUntilDue ?? this.daysUntilDue,
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

  // Factory constructor from JSON
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

  // Convert to JSON
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

  // Factory constructor from entity
  factory InvoiceItemModel.fromEntity(InvoiceItem entity) {
    return InvoiceItemModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
      totalPrice: entity.totalPrice,
      category: entity.category,
    );
  }

  // CopyWith method
  @override
  InvoiceItemModel copyWith({
    String? id,
    String? name,
    String? description,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    String? category,
  }) {
    return InvoiceItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      category: category ?? this.category,
    );
  }
} 