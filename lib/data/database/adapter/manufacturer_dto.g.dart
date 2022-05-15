// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../dto/manufacturer_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ManufacturerDTOAdapter extends TypeAdapter<ManufacturerDTO> {
  @override
  final int typeId = 6;

  @override
  ManufacturerDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ManufacturerDTO()
      ..name = fields[0] as String?
      ..companyUrl = fields[1] as String?
      ..imageUrl = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, ManufacturerDTO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.companyUrl)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ManufacturerDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
