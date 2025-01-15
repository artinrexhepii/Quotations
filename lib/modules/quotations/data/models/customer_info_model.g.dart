// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerInfoModelAdapter extends TypeAdapter<CustomerInfoModel> {
  @override
  final int typeId = 1;

  @override
  CustomerInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerInfoModel(
      companyName: fields[0] as String,
      companyAddress: fields[1] as String,
      emailAddress: fields[2] as String,
      vatNumber: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerInfoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.companyAddress)
      ..writeByte(2)
      ..write(obj.emailAddress)
      ..writeByte(3)
      ..write(obj.vatNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
