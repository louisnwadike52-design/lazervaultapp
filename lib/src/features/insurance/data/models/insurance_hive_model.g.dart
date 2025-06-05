// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InsuranceHiveModelAdapter extends TypeAdapter<InsuranceHiveModel> {
  @override
  final int typeId = 20;

  @override
  InsuranceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InsuranceHiveModel(
      id: fields[0] as String,
      policyNumber: fields[1] as String,
      policyHolderName: fields[2] as String,
      policyHolderEmail: fields[3] as String,
      policyHolderPhone: fields[4] as String,
      type: fields[5] as String,
      provider: fields[6] as String,
      providerLogo: fields[7] as String,
      premiumAmount: fields[8] as double,
      coverageAmount: fields[9] as double,
      currency: fields[10] as String,
      startDate: fields[11] as DateTime,
      endDate: fields[12] as DateTime,
      nextPaymentDate: fields[13] as DateTime,
      status: fields[14] as String,
      beneficiaries: (fields[15] as List).cast<String>(),
      coverageDetails: (fields[16] as Map).cast<String, dynamic>(),
      description: fields[17] as String?,
      createdAt: fields[18] as DateTime,
      updatedAt: fields[19] as DateTime,
      userId: fields[20] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InsuranceHiveModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.policyNumber)
      ..writeByte(2)
      ..write(obj.policyHolderName)
      ..writeByte(3)
      ..write(obj.policyHolderEmail)
      ..writeByte(4)
      ..write(obj.policyHolderPhone)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.provider)
      ..writeByte(7)
      ..write(obj.providerLogo)
      ..writeByte(8)
      ..write(obj.premiumAmount)
      ..writeByte(9)
      ..write(obj.coverageAmount)
      ..writeByte(10)
      ..write(obj.currency)
      ..writeByte(11)
      ..write(obj.startDate)
      ..writeByte(12)
      ..write(obj.endDate)
      ..writeByte(13)
      ..write(obj.nextPaymentDate)
      ..writeByte(14)
      ..write(obj.status)
      ..writeByte(15)
      ..write(obj.beneficiaries)
      ..writeByte(16)
      ..write(obj.coverageDetails)
      ..writeByte(17)
      ..write(obj.description)
      ..writeByte(18)
      ..write(obj.createdAt)
      ..writeByte(19)
      ..write(obj.updatedAt)
      ..writeByte(20)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsuranceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
