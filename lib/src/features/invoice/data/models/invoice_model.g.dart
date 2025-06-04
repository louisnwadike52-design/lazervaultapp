// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceModelAdapter extends TypeAdapter<InvoiceModel> {
  @override
  final int typeId = 0;

  @override
  InvoiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      amount: fields[3] as double,
      currency: fields[4] as String,
      status: fields[5] as InvoiceStatus,
      type: fields[6] as InvoiceType,
      createdAt: fields[7] as DateTime,
      dueDate: fields[8] as DateTime?,
      paidAt: fields[9] as DateTime?,
      fromUserId: fields[10] as String,
      toUserId: fields[11] as String?,
      toEmail: fields[12] as String?,
      toName: fields[13] as String?,
      items: (fields[14] as List).cast<InvoiceItemModel>(),
      taxAmount: fields[15] as double?,
      discountAmount: fields[16] as double?,
      totalAmount: fields[17] as double,
      notes: fields[18] as String?,
      paymentMethod: fields[19] as PaymentMethod?,
      paymentReference: fields[20] as String?,
      qrCodeData: fields[21] as String?,
      attachments: (fields[22] as List?)?.cast<String>(),
      metadata: (fields[23] as Map?)?.cast<String, dynamic>(),
      recipientDetails: fields[24] as AddressDetailsModel?,
      payerDetails: fields[25] as AddressDetailsModel?,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceModel obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.currency)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.dueDate)
      ..writeByte(9)
      ..write(obj.paidAt)
      ..writeByte(10)
      ..write(obj.fromUserId)
      ..writeByte(11)
      ..write(obj.toUserId)
      ..writeByte(12)
      ..write(obj.toEmail)
      ..writeByte(13)
      ..write(obj.toName)
      ..writeByte(14)
      ..write(obj.items)
      ..writeByte(15)
      ..write(obj.taxAmount)
      ..writeByte(16)
      ..write(obj.discountAmount)
      ..writeByte(17)
      ..write(obj.totalAmount)
      ..writeByte(18)
      ..write(obj.notes)
      ..writeByte(19)
      ..write(obj.paymentMethod)
      ..writeByte(20)
      ..write(obj.paymentReference)
      ..writeByte(21)
      ..write(obj.qrCodeData)
      ..writeByte(22)
      ..write(obj.attachments)
      ..writeByte(23)
      ..write(obj.metadata)
      ..writeByte(24)
      ..write(obj.recipientDetails)
      ..writeByte(25)
      ..write(obj.payerDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InvoiceItemModelAdapter extends TypeAdapter<InvoiceItemModel> {
  @override
  final int typeId = 1;

  @override
  InvoiceItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceItemModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String?,
      quantity: fields[3] as double,
      unitPrice: fields[4] as double,
      totalPrice: fields[5] as double,
      category: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.unitPrice)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AddressDetailsModelAdapter extends TypeAdapter<AddressDetailsModel> {
  @override
  final int typeId = 2;

  @override
  AddressDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressDetailsModel(
      companyName: fields[0] as String?,
      contactName: fields[1] as String?,
      email: fields[2] as String?,
      phone: fields[3] as String?,
      addressLine1: fields[4] as String?,
      addressLine2: fields[5] as String?,
      city: fields[6] as String?,
      state: fields[7] as String?,
      postcode: fields[8] as String?,
      country: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressDetailsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.contactName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.addressLine1)
      ..writeByte(5)
      ..write(obj.addressLine2)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.state)
      ..writeByte(8)
      ..write(obj.postcode)
      ..writeByte(9)
      ..write(obj.country);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
