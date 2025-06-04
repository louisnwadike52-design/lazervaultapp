import 'package:hive/hive.dart';
import '../../domain/entities/invoice_entity.dart';

part 'invoice_model.g.dart';

// Custom Type Adapters for Domain Enums
class InvoiceStatusAdapter extends TypeAdapter<InvoiceStatus> {
  @override
  final int typeId = 3;

  @override
  InvoiceStatus read(BinaryReader reader) {
    final index = reader.readByte();
    return InvoiceStatus.values[index];
  }

  @override
  void write(BinaryWriter writer, InvoiceStatus obj) {
    writer.writeByte(obj.index);
  }
}

class InvoiceTypeAdapter extends TypeAdapter<InvoiceType> {
  @override
  final int typeId = 4;

  @override
  InvoiceType read(BinaryReader reader) {
    final index = reader.readByte();
    return InvoiceType.values[index];
  }

  @override
  void write(BinaryWriter writer, InvoiceType obj) {
    writer.writeByte(obj.index);
  }
}

class PaymentMethodAdapter extends TypeAdapter<PaymentMethod> {
  @override
  final int typeId = 5;

  @override
  PaymentMethod read(BinaryReader reader) {
    final index = reader.readByte();
    return PaymentMethod.values[index];
  }

  @override
  void write(BinaryWriter writer, PaymentMethod obj) {
    writer.writeByte(obj.index);
  }
}

@HiveType(typeId: 0)
class InvoiceModel extends Invoice {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final String currency;
  @HiveField(5)
  final InvoiceStatus status;
  @HiveField(6)
  final InvoiceType type;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final DateTime? dueDate;
  @HiveField(9)
  final DateTime? paidAt;
  @HiveField(10)
  final String fromUserId;
  @HiveField(11)
  final String? toUserId;
  @HiveField(12)
  final String? toEmail;
  @HiveField(13)
  final String? toName;
  @HiveField(14)
  final List<InvoiceItemModel> items;
  @HiveField(15)
  final double? taxAmount;
  @HiveField(16)
  final double? discountAmount;
  @HiveField(17)
  final double totalAmount;
  @HiveField(18)
  final String? notes;
  @HiveField(19)
  final PaymentMethod? paymentMethod;
  @HiveField(20)
  final String? paymentReference;
  @HiveField(21)
  final String? qrCodeData;
  @HiveField(22)
  final List<String>? attachments;
  @HiveField(23)
  final Map<String, dynamic>? metadata;
  @HiveField(24)
  final AddressDetailsModel? recipientDetails;
  @HiveField(25)
  final AddressDetailsModel? payerDetails;

  const InvoiceModel({
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
  }) : super(
    id: id,
    title: title,
    description: description,
    amount: amount,
    currency: currency,
    status: status,
    type: type,
    createdAt: createdAt,
    dueDate: dueDate,
    paidAt: paidAt,
    fromUserId: fromUserId,
    toUserId: toUserId,
    toEmail: toEmail,
    toName: toName,
    items: items,
    taxAmount: taxAmount,
    discountAmount: discountAmount,
    totalAmount: totalAmount,
    notes: notes,
    paymentMethod: paymentMethod,
    paymentReference: paymentReference,
    qrCodeData: qrCodeData,
    attachments: attachments,
    metadata: metadata,
    recipientDetails: recipientDetails,
    payerDetails: payerDetails,
  );

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
      recipientDetails: json['recipient_details'] != null
          ? AddressDetailsModel.fromJson(json['recipient_details'] as Map<String, dynamic>)
          : null,
      payerDetails: json['payer_details'] != null
          ? AddressDetailsModel.fromJson(json['payer_details'] as Map<String, dynamic>)
          : null,
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
      'items': items.map((item) => item.toJson()).toList(),
      'tax_amount': taxAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'notes': notes,
      'payment_method': paymentMethod?.name,
      'payment_reference': paymentReference,
      'qr_code_data': qrCodeData,
      'attachments': attachments,
      'metadata': metadata,
      'recipient_details': recipientDetails?.toJson(),
      'payer_details': payerDetails?.toJson(),
    };
  }

  factory InvoiceModel.fromEntity(Invoice entity) {
    return InvoiceModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      amount: entity.amount,
      currency: entity.currency,
      status: entity.status,
      type: entity.type,
      createdAt: entity.createdAt,
      dueDate: entity.dueDate,
      paidAt: entity.paidAt,
      fromUserId: entity.fromUserId,
      toUserId: entity.toUserId,
      toEmail: entity.toEmail,
      toName: entity.toName,
      items: entity.items.map((item) => InvoiceItemModel.fromInvoiceItem(item)).toList(),
      taxAmount: entity.taxAmount,
      discountAmount: entity.discountAmount,
      totalAmount: entity.totalAmount,
      notes: entity.notes,
      paymentMethod: entity.paymentMethod,
      paymentReference: entity.paymentReference,
      qrCodeData: entity.qrCodeData,
      attachments: entity.attachments,
      metadata: entity.metadata,
      recipientDetails: entity.recipientDetails != null 
          ? AddressDetailsModel.fromEntity(entity.recipientDetails!)
          : null,
      payerDetails: entity.payerDetails != null 
          ? AddressDetailsModel.fromEntity(entity.payerDetails!)
          : null,
    );
  }
}

@HiveType(typeId: 1)
class InvoiceItemModel extends InvoiceItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final double quantity;
  @HiveField(4)
  final double unitPrice;
  @HiveField(5)
  final double totalPrice;
  @HiveField(6)
  final String? category;

  const InvoiceItemModel({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.category,
  }) : super(
    id: id,
    name: name,
    description: description,
    quantity: quantity,
    unitPrice: unitPrice,
    totalPrice: totalPrice,
    category: category,
  );

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

@HiveType(typeId: 2)
class AddressDetailsModel extends AddressDetails {
  @HiveField(0)
  final String? companyName;
  @HiveField(1)
  final String? contactName;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? addressLine1;
  @HiveField(5)
  final String? addressLine2;
  @HiveField(6)
  final String? city;
  @HiveField(7)
  final String? state;
  @HiveField(8)
  final String? postcode;
  @HiveField(9)
  final String? country;

  const AddressDetailsModel({
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
  }) : super(
    companyName: companyName,
    contactName: contactName,
    email: email,
    phone: phone,
    addressLine1: addressLine1,
    addressLine2: addressLine2,
    city: city,
    state: state,
    postcode: postcode,
    country: country,
  );

  factory AddressDetailsModel.fromJson(Map<String, dynamic> json) {
    return AddressDetailsModel(
      companyName: json['company_name'] as String?,
      contactName: json['contact_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      addressLine1: json['address_line1'] as String?,
      addressLine2: json['address_line2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'contact_name': contactName,
      'email': email,
      'phone': phone,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'city': city,
      'state': state,
      'postcode': postcode,
      'country': country,
    };
  }

  factory AddressDetailsModel.fromEntity(AddressDetails entity) {
    return AddressDetailsModel(
      companyName: entity.companyName,
      contactName: entity.contactName,
      email: entity.email,
      phone: entity.phone,
      addressLine1: entity.addressLine1,
      addressLine2: entity.addressLine2,
      city: entity.city,
      state: entity.state,
      postcode: entity.postcode,
      country: entity.country,
    );
  }
} 