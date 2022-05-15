import 'package:hive/hive.dart';

part '../adapter/manufacturer_dto.g.dart';

@HiveType(typeId: 6)
class ManufacturerDTO {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? companyUrl;
  @HiveField(2)
  String? imageUrl;
}
