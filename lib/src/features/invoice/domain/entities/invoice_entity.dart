import 'package:equatable/equatable.dart';
part 'invoice_entity_widgets.dart';


class Invoice extends Equatable {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String currency;
  final InvoiceStatus status;
  final InvoiceType type;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? paidAt;
  final String fromUserId;
  final String? toUserId;
  final String? toEmail;
  final String? toName;
  final List<InvoiceItem> items;
  final double? taxAmount;
  final double? discountAmount;
  final double totalAmount;
  final String? notes;
  final PaymentMethod? paymentMethod;
  final String? paymentReference;
  final String? qrCodeData;
  final List<String>? attachments;
  final Map<String, dynamic>? metadata;
  final AddressDetails? recipientDetails;
  final AddressDetails? payerDetails;
  final bool isUnlocked;
  final String? unlockPaymentRef;
  final List<TaggedUserInfo>? taggedUsers;
  final String? payerLogoUrl;
  final String? recipientLogoUrl;

  const Invoice({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.currency,
    required this.status,
    required this.type,
    required this.createdAt,
    this.dueDate,
    this.paidAt,
    required this.fromUserId,
    this.toUserId,
    this.toEmail,
    this.toName,
    required this.items,
    this.taxAmount,
    this.discountAmount,
    required this.totalAmount,
    this.notes,
    this.paymentMethod,
    this.paymentReference,
    this.qrCodeData,
    this.attachments,
    this.metadata,
    this.recipientDetails,
    this.payerDetails,
    this.isUnlocked = false,
    this.unlockPaymentRef,
    this.taggedUsers,
    this.payerLogoUrl,
    this.recipientLogoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        amount,
        currency,
        status,
        type,
        createdAt,
        dueDate,
        paidAt,
        fromUserId,
        toUserId,
        toEmail,
        toName,
        items,
        taxAmount,
        discountAmount,
        totalAmount,
        notes,
        paymentMethod,
        paymentReference,
        qrCodeData,
        attachments,
        metadata,
        recipientDetails,
        payerDetails,
        isUnlocked,
        unlockPaymentRef,
        taggedUsers,
        payerLogoUrl,
        recipientLogoUrl,
      ];

  Invoice copyWith({
    String? id,
    String? title,
    String? description,
    double? amount,
    String? currency,
    InvoiceStatus? status,
    InvoiceType? type,
    DateTime? createdAt,
    DateTime? dueDate,
    DateTime? paidAt,
    String? fromUserId,
    String? toUserId,
    String? toEmail,
    String? toName,
    List<InvoiceItem>? items,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    String? notes,
    PaymentMethod? paymentMethod,
    String? paymentReference,
    String? qrCodeData,
    List<String>? attachments,
    Map<String, dynamic>? metadata,
    AddressDetails? recipientDetails,
    AddressDetails? payerDetails,
    bool? isUnlocked,
    String? unlockPaymentRef,
    List<TaggedUserInfo>? taggedUsers,
    String? payerLogoUrl,
    String? recipientLogoUrl,
  }) {
    return Invoice(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      paidAt: paidAt ?? this.paidAt,
      fromUserId: fromUserId ?? this.fromUserId,
      toUserId: toUserId ?? this.toUserId,
      toEmail: toEmail ?? this.toEmail,
      toName: toName ?? this.toName,
      items: items ?? this.items,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentReference: paymentReference ?? this.paymentReference,
      qrCodeData: qrCodeData ?? this.qrCodeData,
      attachments: attachments ?? this.attachments,
      metadata: metadata ?? this.metadata,
      recipientDetails: recipientDetails ?? this.recipientDetails,
      payerDetails: payerDetails ?? this.payerDetails,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockPaymentRef: unlockPaymentRef ?? this.unlockPaymentRef,
      taggedUsers: taggedUsers ?? this.taggedUsers,
      payerLogoUrl: payerLogoUrl ?? this.payerLogoUrl,
      recipientLogoUrl: recipientLogoUrl ?? this.recipientLogoUrl,
    );
  }

  bool get isOverdue {
    if (dueDate == null || status == InvoiceStatus.paid || status == InvoiceStatus.partiallyPaid) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get isPartiallyPaid => status == InvoiceStatus.partiallyPaid;

  int get paidUsersCount =>
      taggedUsers?.where((u) => u.status == 'paid').length ?? 0;

  int get unpaidUsersCount =>
      (taggedUsers?.length ?? 0) - paidUsersCount;

  double get paidAmount =>
      taggedUsers
          ?.where((u) => u.status == 'paid')
          .fold<double>(0.0, (sum, _) => sum + (totalAmount / (taggedUsers?.length ?? 1))) ??
      0.0;

  double get unpaidAmount => totalAmount - paidAmount;

  bool get canBePaid {
    return status == InvoiceStatus.pending && !isOverdue;
  }

  bool get canBeEdited {
    return status == InvoiceStatus.draft;
  }

  String get statusDisplayName {
    // If invoice is unlocked (service fee paid), show Pending instead of Draft
    if (status == InvoiceStatus.draft && isUnlocked) {
      return 'Pending';
    }
    switch (status) {
      case InvoiceStatus.draft:
        return 'Draft';
      case InvoiceStatus.pending:
        return 'Pending';
      case InvoiceStatus.paid:
        return 'Paid';
      case InvoiceStatus.partiallyPaid:
        return 'Partially Paid';
      case InvoiceStatus.expired:
        return 'Expired';
      case InvoiceStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get typeDisplayName {
    switch (type) {
      case InvoiceType.request:
        return 'Payment Request';
      case InvoiceType.invoice:
        return 'Invoice';
      case InvoiceType.quote:
        return 'Quote';
    }
  }
} 