// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuotationModelAdapter extends TypeAdapter<QuotationModel> {
  @override
  final int typeId = 0;

  @override
  QuotationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuotationModel(
      id: fields[0] as String,
      customerInfo: fields[1] as CustomerInfoModel,
      title: fields[2] as String,
      description: fields[3] as String,
      lineItems: (fields[4] as List).cast<LineItemModel>(),
      totalPrice: fields[5] as double,
      imageUrls: (fields[6] as List).cast<String>(),
      createdAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, QuotationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.customerInfo)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.lineItems)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.imageUrls)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuotationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
