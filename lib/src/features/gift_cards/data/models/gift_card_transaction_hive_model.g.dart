// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_transaction_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GiftCardTransactionHiveModelAdapter
    extends TypeAdapter<GiftCardTransactionHiveModel> {
  @override
  final int typeId = 32;

  @override
  GiftCardTransactionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GiftCardTransactionHiveModel(
      id: fields[0] as String,
      giftCardId: fields[1] as String,
      userId: fields[2] as String,
      amount: fields[3] as double,
      currency: fields[4] as String,
      transactionDate: fields[5] as DateTime,
      transactionType: fields[6] as String,
      statusIndex: fields[7] as int,
      failureReason: fields[8] as String?,
      cachedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GiftCardTransactionHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.giftCardId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.currency)
      ..writeByte(5)
      ..write(obj.transactionDate)
      ..writeByte(6)
      ..write(obj.transactionType)
      ..writeByte(7)
      ..write(obj.statusIndex)
      ..writeByte(8)
      ..write(obj.failureReason)
      ..writeByte(9)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiftCardTransactionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
