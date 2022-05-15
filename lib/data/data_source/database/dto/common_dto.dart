import 'package:hive/hive.dart';
part '../adapter/common_dto.g.dart';

@HiveType(typeId: 1)
class CommonDTO {
  @HiveField(0, defaultValue: true)
  bool? isFirstStart;
}
