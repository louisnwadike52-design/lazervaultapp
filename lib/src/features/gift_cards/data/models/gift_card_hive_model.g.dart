// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GiftCardHiveModelAdapter extends TypeAdapter<GiftCardHiveModel> {
  @override
  final int typeId = 30;

  @override
  GiftCardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GiftCardHiveModel(
      id: fields[0] as String,
      brandId: fields[1] as String,
      brandName: fields[2] as String,
      logoUrl: fields[3] as String,
      amount: fields[4] as double,
      discountPercentage: fields[5] as double,
      finalPrice: fields[6] as double,
      currency: fields[7] as String,
      statusIndex: fields[8] as int,
      typeIndex: fields[9] as int,
      categoryIndex: fields[10] as int,
      description: fields[11] as String,
      termsAndConditions: fields[12] as String,
      expiryDate: fields[13] as DateTime,
      purchaseDate: fields[14] as DateTime,
      recipientEmail: fields[15] as String?,
      recipientName: fields[16] as String?,
      message: fields[17] as String?,
      code: fields[18] as String?,
      pin: fields[19] as String?,
      isRedeemed: fields[20] as bool,
      transactionId: fields[21] as String?,
      availableDenominations: (fields[22] as List).cast<String>(),
      qrCodeUrl: fields[23] as String?,
      barcodeUrl: fields[24] as String?,
      cachedAt: fields[25] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GiftCardHiveModel obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brandId)
      ..writeByte(2)
      ..write(obj.brandName)
      ..writeByte(3)
      ..write(obj.logoUrl)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.discountPercentage)
      ..writeByte(6)
      ..write(obj.finalPrice)
      ..writeByte(7)
      ..write(obj.currency)
      ..writeByte(8)
      ..write(obj.statusIndex)
      ..writeByte(9)
      ..write(obj.typeIndex)
      ..writeByte(10)
      ..write(obj.categoryIndex)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.termsAndConditions)
      ..writeByte(13)
      ..write(obj.expiryDate)
      ..writeByte(14)
      ..write(obj.purchaseDate)
      ..writeByte(15)
      ..write(obj.recipientEmail)
      ..writeByte(16)
      ..write(obj.recipientName)
      ..writeByte(17)
      ..write(obj.message)
      ..writeByte(18)
      ..write(obj.code)
      ..writeByte(19)
      ..write(obj.pin)
      ..writeByte(20)
      ..write(obj.isRedeemed)
      ..writeByte(21)
      ..write(obj.transactionId)
      ..writeByte(22)
      ..write(obj.availableDenominations)
      ..writeByte(23)
      ..write(obj.qrCodeUrl)
      ..writeByte(24)
      ..write(obj.barcodeUrl)
      ..writeByte(25)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiftCardHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
