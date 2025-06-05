// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_payment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InsurancePaymentHiveModelAdapter
    extends TypeAdapter<InsurancePaymentHiveModel> {
  @override
  final int typeId = 21;

  @override
  InsurancePaymentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InsurancePaymentHiveModel(
      id: fields[0] as String,
      insuranceId: fields[1] as String,
      policyNumber: fields[2] as String,
      amount: fields[3] as double,
      currency: fields[4] as String,
      paymentMethod: fields[5] as String,
      status: fields[6] as String,
      transactionId: fields[7] as String?,
      referenceNumber: fields[8] as String?,
      paymentDate: fields[9] as DateTime,
      dueDate: fields[10] as DateTime,
      processedAt: fields[11] as DateTime?,
      paymentDetails: (fields[12] as Map?)?.cast<String, dynamic>(),
      failureReason: fields[13] as String?,
      receiptUrl: fields[14] as String?,
      createdAt: fields[15] as DateTime,
      updatedAt: fields[16] as DateTime,
      userId: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InsurancePaymentHiveModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.insuranceId)
      ..writeByte(2)
      ..write(obj.policyNumber)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.currency)
      ..writeByte(5)
      ..write(obj.paymentMethod)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.transactionId)
      ..writeByte(8)
      ..write(obj.referenceNumber)
      ..writeByte(9)
      ..write(obj.paymentDate)
      ..writeByte(10)
      ..write(obj.dueDate)
      ..writeByte(11)
      ..write(obj.processedAt)
      ..writeByte(12)
      ..write(obj.paymentDetails)
      ..writeByte(13)
      ..write(obj.failureReason)
      ..writeByte(14)
      ..write(obj.receiptUrl)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsurancePaymentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
