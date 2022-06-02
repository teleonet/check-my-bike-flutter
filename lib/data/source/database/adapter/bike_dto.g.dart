// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../dto/bike_db_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BikeDTOAdapter extends TypeAdapter<BikeDbDTO> {
  @override
  final int typeId = 0;

  @override
  BikeDbDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BikeDbDTO()
      ..id = fields[0] as int?
      ..isStockImg = fields[1] as bool?
      ..manufacturerName = fields[2] as String?
      ..serial = fields[3] as String?
      ..status = fields[4] as String?
      ..title = fields[5] as String?
      ..year = fields[6] as int?
      ..stolen = fields[7] as bool?
      ..frameModel = fields[8] as String?
      ..largeImg = fields[9] as String?
      ..locationFound = fields[10] as String?
      ..externalId = fields[11] as int?
      ..registryName = fields[12] as String?
      ..registryUrl = fields[13] as String?
      ..stolenCoordinates = (fields[14] as List?)?.cast<double>()
      ..stolenLocation = fields[15] as String?
      ..thumb = fields[16] as String?
      ..url = fields[17] as String?
      ..description = fields[18] as String?
      ..colors = (fields[19] as List?)?.cast<String?>();
  }

  @override
  void write(BinaryWriter writer, BikeDbDTO obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isStockImg)
      ..writeByte(2)
      ..write(obj.manufacturerName)
      ..writeByte(3)
      ..write(obj.serial)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.stolen)
      ..writeByte(8)
      ..write(obj.frameModel)
      ..writeByte(9)
      ..write(obj.largeImg)
      ..writeByte(10)
      ..write(obj.locationFound)
      ..writeByte(11)
      ..write(obj.externalId)
      ..writeByte(12)
      ..write(obj.registryName)
      ..writeByte(13)
      ..write(obj.registryUrl)
      ..writeByte(14)
      ..write(obj.stolenCoordinates)
      ..writeByte(15)
      ..write(obj.stolenLocation)
      ..writeByte(16)
      ..write(obj.thumb)
      ..writeByte(17)
      ..write(obj.url)
      ..writeByte(18)
      ..write(obj.description)
      ..writeByte(19)
      ..write(obj.colors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BikeDTOAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
