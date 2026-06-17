import 'package:equatable/equatable.dart';

enum PaymentStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
}

enum InvoicePriority {
  low,
  medium,
  high,
  urgent,
}

class TaggedInvoice extends Equatable {
  final String id;
  final String invoiceNumber;
  final String title;
  final String description;
  final double amount;
  final String currency;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? paidAt;
  final PaymentStatus paymentStatus;
  final InvoicePriority priority;
  
  // Sender info
  final String fromUserId;
  final String fromUserName;
  final String fromUserEmail;
  final String? fromCompanyName;
  final String? fromCompanyLogo;
  
  // Tagged user info (current user)
  final String toUserId;
  final String toUserName;
  final String toUserEmail;
  
  // Payment details
  final List<InvoiceItem> items;
  final double? taxAmount;
  final double? discountAmount;
  final double totalAmount;
  final String? notes;
  final String? paymentReference;
  final String? qrCodeData;
  
  // Additional metadata
  final Map<String, dynamic>? metadata;
  final bool isOverdue;
  final int daysUntilDue;

  const TaggedInvoice({
    required this.id,
    required this.invoiceNumber,
    required this.title,
    required this.description,
    required this.amount,
    required this.currency,
    required this.createdAt,
    this.dueDate,
    this.paidAt,
    required this.paymentStatus,
    required this.priority,
    required this.fromUserId,
    required this.fromUserName,
    required this.fromUserEmail,
    this.fromCompanyName,
    this.fromCompanyLogo,
    required this.toUserId,
    required this.toUserName,
    required this.toUserEmail,
    required this.items,
    this.taxAmount,
    this.discountAmount,
    required this.totalAmount,
    this.notes,
    this.paymentReference,
    this.qrCodeData,
    this.metadata,
    required this.isOverdue,
    required this.daysUntilDue,
  });

  TaggedInvoice copyWith({
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
    return TaggedInvoice(
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

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        title,
        description,
        amount,
        currency,
        createdAt,
        dueDate,
        paidAt,
        paymentStatus,
        priority,
        fromUserId,
        fromUserName,
        fromUserEmail,
        fromCompanyName,
        fromCompanyLogo,
        toUserId,
        toUserName,
        toUserEmail,
        items,
        taxAmount,
        discountAmount,
        totalAmount,
        notes,
        paymentReference,
        qrCodeData,
        metadata,
        isOverdue,
        daysUntilDue,
      ];

  String get statusDisplayName {
    switch (paymentStatus) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get priorityDisplayName {
    switch (priority) {
      case InvoicePriority.low:
        return 'Low';
      case InvoicePriority.medium:
        return 'Medium';
      case InvoicePriority.high:
        return 'High';
      case InvoicePriority.urgent:
        return 'Urgent';
    }
  }

  String get formattedAmount => '$currency ${totalAmount.toStringAsFixed(2)}';
  
  String get formattedDueDate {
    if (dueDate == null) return 'No due date';
    return '${dueDate!.day}/${dueDate!.month}/${dueDate!.year}';
  }

  String get urgencyText {
    if (isOverdue) return 'Overdue by ${-daysUntilDue} days';
    if (daysUntilDue <= 0) return 'Due today';
    if (daysUntilDue == 1) return 'Due tomorrow';
    return 'Due in $daysUntilDue days';
  }
}

class InvoiceItem extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String? category;

  const InvoiceItem({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.category,
  });

  InvoiceItem copyWith({
    String? id,
    String? name,
    String? description,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    String? category,
  }) {
    return InvoiceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        quantity,
        unitPrice,
        totalPrice,
        category,
      ];
} 