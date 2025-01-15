// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LineItemModelAdapter extends TypeAdapter<LineItemModel> {
  @override
  final int typeId = 2;

  @override
  LineItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LineItemModel(
      id: fields[0] as String,
      title: fields[1] as String,
      price: fields[2] as double,
      quantity: fields[3] as int,
      totalPrice: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LineItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.totalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
