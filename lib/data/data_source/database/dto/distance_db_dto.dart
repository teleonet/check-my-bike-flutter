import 'package:hive/hive.dart';

part '../adapter/distance_dto.g.dart';

@HiveType(typeId: 3)
class DistanceDbDTO {
  @HiveField(0)
  String? title;
  @HiveField(1, defaultValue: "km")
  String? type;
}
