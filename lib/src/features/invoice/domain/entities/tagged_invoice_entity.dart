import 'package:equatable/equatable.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';
import 'package:lazervault/src/features/invoice/domain/entities/invoice_entity.dart';

// Using InvoicePriority from common.pbenum.dart

class TaggedInvoice extends Equatable {
  final String id;
  final String invoiceId;
  final String userId;
  final InvoicePaymentStatus paymentStatus;
  final InvoicePriority priority;
  final bool isViewed;
  final DateTime taggedAt;
  final DateTime? viewedAt;
  final DateTime? reminderDate;
  final bool reminderSent;
  final String? notes;

  // Related invoice data (joined from invoice table)
  final Invoice? invoice;

  // Tagger information (for incoming invoices)
  final String? taggerName;
  final String? taggerUsername;
  final String? taggerEmail;
  final String? taggerProfilePicture;

  // Tagged user information (for outgoing invoices)
  final String? taggedUserName;
  final String? taggedUserUsername;
  final String? taggedUserEmail;
  final String? taggedUserProfilePicture;

  const TaggedInvoice({
    required this.id,
    required this.invoiceId,
    required this.userId,
    required this.paymentStatus,
    required this.priority,
    required this.isViewed,
    required this.taggedAt,
    this.viewedAt,
    this.reminderDate,
    this.reminderSent = false,
    this.notes,
    this.invoice,
    this.taggerName,
    this.taggerUsername,
    this.taggerEmail,
    this.taggerProfilePicture,
    this.taggedUserName,
    this.taggedUserUsername,
    this.taggedUserEmail,
    this.taggedUserProfilePicture,
  });

  @override
  List<Object?> get props => [
        id,
        invoiceId,
        userId,
        paymentStatus,
        priority,
        isViewed,
        taggedAt,
        viewedAt,
        reminderDate,
        reminderSent,
        notes,
        invoice,
        taggerName,
        taggerUsername,
        taggerEmail,
        taggerProfilePicture,
        taggedUserName,
        taggedUserUsername,
        taggedUserEmail,
        taggedUserProfilePicture,
      ];

  // Helper methods
  bool get isPending => paymentStatus == InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING;
  bool get isPaid => paymentStatus == InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED;
  bool get isOverdue {
    if (invoice?.dueDate == null) return false;
    return invoice!.dueDate!.isBefore(DateTime.now()) && isPending;
  }

  String get displayName => taggerName ?? taggedUserName ?? 'Unknown';
  String get displayUsername => taggerUsername ?? taggedUserUsername ?? '';
  String? get displayProfilePicture => taggerProfilePicture ?? taggedUserProfilePicture;

  double get amount => invoice?.totalAmount ?? 0.0;
  String get currency => invoice?.currency ?? 'USD';
  String get title => invoice?.title ?? 'Untitled Invoice';
  String get description => invoice?.description ?? '';

  String get formattedAmount {
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  String get statusText {
    switch (paymentStatus) {
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING:
        return isOverdue ? 'Overdue' : 'Pending';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED:
        return 'Paid';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PROCESSING:
        return 'Processing';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_FAILED:
        return 'Failed';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_CANCELLED:
        return 'Cancelled';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PARTIALLY_PAID:
        return 'Partially Paid';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_REFUNDED:
        return 'Refunded';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_DISPUTED:
        return 'Disputed';
      case InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE:
        return 'Overdue';
      default:
        return 'Unknown';
    }
  }

  String get priorityText {
    switch (priority) {
      case InvoicePriority.INVOICE_PRIORITY_LOW:
        return 'Low';
      case InvoicePriority.INVOICE_PRIORITY_MEDIUM:
        return 'Medium';
      case InvoicePriority.INVOICE_PRIORITY_HIGH:
        return 'High';
      case InvoicePriority.INVOICE_PRIORITY_URGENT:
        return 'Urgent';
      default:
        return 'Unknown';
    }
  }

  TaggedInvoice copyWith({
    String? id,
    String? invoiceId,
    String? userId,
    InvoicePaymentStatus? paymentStatus,
    InvoicePriority? priority,
    bool? isViewed,
    DateTime? taggedAt,
    DateTime? viewedAt,
    DateTime? reminderDate,
    bool? reminderSent,
    String? notes,
    Invoice? invoice,
    String? taggerName,
    String? taggerUsername,
    String? taggerEmail,
    String? taggerProfilePicture,
    String? taggedUserName,
    String? taggedUserUsername,
    String? taggedUserEmail,
    String? taggedUserProfilePicture,
  }) {
    return TaggedInvoice(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      userId: userId ?? this.userId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      priority: priority ?? this.priority,
      isViewed: isViewed ?? this.isViewed,
      taggedAt: taggedAt ?? this.taggedAt,
      viewedAt: viewedAt ?? this.viewedAt,
      reminderDate: reminderDate ?? this.reminderDate,
      reminderSent: reminderSent ?? this.reminderSent,
      notes: notes ?? this.notes,
      invoice: invoice ?? this.invoice,
      taggerName: taggerName ?? this.taggerName,
      taggerUsername: taggerUsername ?? this.taggerUsername,
      taggerEmail: taggerEmail ?? this.taggerEmail,
      taggerProfilePicture: taggerProfilePicture ?? this.taggerProfilePicture,
      taggedUserName: taggedUserName ?? this.taggedUserName,
      taggedUserUsername: taggedUserUsername ?? this.taggedUserUsername,
      taggedUserEmail: taggedUserEmail ?? this.taggedUserEmail,
      taggedUserProfilePicture: taggedUserProfilePicture ?? this.taggedUserProfilePicture,
    );
  }
}

class TaggedInvoiceStatistics extends Equatable {
  final int totalInvoices;
  final int pendingInvoices;
  final int overdueInvoices;
  final int paidInvoices;
  final double totalAmount;
  final double pendingAmount;
  final double overdueAmount;
  final double paidAmount;

  const TaggedInvoiceStatistics({
    required this.totalInvoices,
    required this.pendingInvoices,
    required this.overdueInvoices,
    required this.paidInvoices,
    required this.totalAmount,
    required this.pendingAmount,
    required this.overdueAmount,
    required this.paidAmount,
  });

  @override
  List<Object?> get props => [
        totalInvoices,
        pendingInvoices,
        overdueInvoices,
        paidInvoices,
        totalAmount,
        pendingAmount,
        overdueAmount,
        paidAmount,
      ];

  String formattedTotal(String currency) {
    return '$currency ${totalAmount.toStringAsFixed(2)}';
  }

  String formattedPending(String currency) {
    return '$currency ${pendingAmount.toStringAsFixed(2)}';
  }

  String formattedOverdue(String currency) {
    return '$currency ${overdueAmount.toStringAsFixed(2)}';
  }

  String formattedPaid(String currency) {
    return '$currency ${paidAmount.toStringAsFixed(2)}';
  }

  static const TaggedInvoiceStatistics empty = TaggedInvoiceStatistics(
    totalInvoices: 0,
    pendingInvoices: 0,
    overdueInvoices: 0,
    paidInvoices: 0,
    totalAmount: 0.0,
    pendingAmount: 0.0,
    overdueAmount: 0.0,
    paidAmount: 0.0,
  );
}
