import 'package:hive/hive.dart';

part '../adapter/language_dto.g.dart';

@HiveType(typeId: 5)
class LanguageDTO {
  @HiveField(0)
  String? iconPath;
  @HiveField(1, defaultValue: "eng")
  String? name;
}
