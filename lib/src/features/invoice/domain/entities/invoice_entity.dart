import 'package:equatable/equatable.dart';

enum InvoiceStatus {
  draft,
  pending,
  paid,
  expired,
  cancelled,
}

enum InvoiceType {
  request,
  invoice,
  quote,
}

enum PaymentMethod {
  bankTransfer,
  crypto,
  paypal,
  card,
  cash,
}

class AddressDetails extends Equatable {
  final String? companyName;
  final String? contactName;
  final String? email;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? bankAccount;
  final String? bicNumber;
  final String? iban;
  final String? routingNumber;
  final String? taxId;
  final String? bankName;
  final String? accountType;
  final String? swiftCode;
  final String? sortCode;
  final String? bankAddress;
  final String? intermediaryBankName;
  final String? intermediaryBankSwift;
  final String? accountHolderName;

  const AddressDetails({
    this.companyName,
    this.contactName,
    this.email,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.bankAccount,
    this.bicNumber,
    this.iban,
    this.routingNumber,
    this.taxId,
    this.bankName,
    this.accountType,
    this.swiftCode,
    this.sortCode,
    this.bankAddress,
    this.intermediaryBankName,
    this.intermediaryBankSwift,
    this.accountHolderName,
  });

  @override
  List<Object?> get props => [
        companyName,
        contactName,
        email,
        phone,
        addressLine1,
        addressLine2,
        city,
        state,
        postcode,
        country,
        bankAccount,
        bicNumber,
        iban,
        routingNumber,
        taxId,
        bankName,
        accountType,
        swiftCode,
        sortCode,
        bankAddress,
        intermediaryBankName,
        intermediaryBankSwift,
        accountHolderName,
      ];

  AddressDetails copyWith({
    String? companyName,
    String? contactName,
    String? email,
    String? phone,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? bankAccount,
    String? bicNumber,
    String? iban,
    String? routingNumber,
    String? taxId,
    String? bankName,
    String? accountType,
    String? swiftCode,
    String? sortCode,
    String? bankAddress,
    String? intermediaryBankName,
    String? intermediaryBankSwift,
    String? accountHolderName,
  }) {
    return AddressDetails(
      companyName: companyName ?? this.companyName,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      bankAccount: bankAccount ?? this.bankAccount,
      bicNumber: bicNumber ?? this.bicNumber,
      iban: iban ?? this.iban,
      routingNumber: routingNumber ?? this.routingNumber,
      taxId: taxId ?? this.taxId,
      bankName: bankName ?? this.bankName,
      accountType: accountType ?? this.accountType,
      swiftCode: swiftCode ?? this.swiftCode,
      sortCode: sortCode ?? this.sortCode,
      bankAddress: bankAddress ?? this.bankAddress,
      intermediaryBankName: intermediaryBankName ?? this.intermediaryBankName,
      intermediaryBankSwift: intermediaryBankSwift ?? this.intermediaryBankSwift,
      accountHolderName: accountHolderName ?? this.accountHolderName,
    );
  }

  bool get isEmpty {
    return companyName == null &&
        contactName == null &&
        email == null &&
        phone == null &&
        addressLine1 == null &&
        addressLine2 == null &&
        city == null &&
        state == null &&
        postcode == null &&
        country == null &&
        bankAccount == null &&
        bicNumber == null &&
        iban == null &&
        routingNumber == null &&
        taxId == null &&
        bankName == null &&
        accountType == null &&
        swiftCode == null &&
        sortCode == null &&
        bankAddress == null &&
        intermediaryBankName == null &&
        intermediaryBankSwift == null &&
        accountHolderName == null;
  }

  String get formattedAddress {
    final parts = <String>[];
    if (addressLine1?.isNotEmpty == true) parts.add(addressLine1!);
    if (addressLine2?.isNotEmpty == true) parts.add(addressLine2!);
    if (city?.isNotEmpty == true) parts.add(city!);
    if (state?.isNotEmpty == true) parts.add(state!);
    if (postcode?.isNotEmpty == true) parts.add(postcode!);
    if (country?.isNotEmpty == true) parts.add(country!);
    return parts.join(', ');
  }
}

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
    );
  }

  bool get isOverdue {
    if (dueDate == null || status == InvoiceStatus.paid) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get canBePaid {
    return status == InvoiceStatus.pending && !isOverdue;
  }

  bool get canBeEdited {
    return status == InvoiceStatus.draft;
  }

  String get statusDisplayName {
    switch (status) {
      case InvoiceStatus.draft:
        return 'Draft';
      case InvoiceStatus.pending:
        return 'Pending';
      case InvoiceStatus.paid:
        return 'Paid';
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
} 