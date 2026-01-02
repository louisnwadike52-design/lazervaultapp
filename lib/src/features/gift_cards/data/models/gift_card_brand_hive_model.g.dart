// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_brand_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GiftCardBrandHiveModelAdapter
    extends TypeAdapter<GiftCardBrandHiveModel> {
  @override
  final int typeId = 31;

  @override
  GiftCardBrandHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GiftCardBrandHiveModel(
      id: fields[0] as String,
      name: fields[1] as String,
      logoUrl: fields[2] as String,
      description: fields[3] as String,
      categoryIndex: fields[4] as int,
      discountPercentage: fields[5] as double?,
      isPopular: fields[6] as bool,
      cachedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GiftCardBrandHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logoUrl)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.categoryIndex)
      ..writeByte(5)
      ..write(obj.discountPercentage)
      ..writeByte(6)
      ..write(obj.isPopular)
      ..writeByte(7)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GiftCardBrandHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
