import 'package:hive/hive.dart';

part '../adapter/bike_dto.g.dart';

@HiveType(typeId: 0)
class BikeDbDTO {
  @HiveField(0)
  int? id;
  @HiveField(1)
  bool? isStockImg;
  @HiveField(2)
  String? manufacturerName;
  @HiveField(3)
  String? serial;
  @HiveField(4)
  String? status;
  @HiveField(5)
  String? title;
  @HiveField(6)
  int? year;
  @HiveField(7)
  bool? stolen;
  @HiveField(8)
  String? frameModel;
  @HiveField(9)
  String? largeImg;
  @HiveField(10)
  String? locationFound;
  @HiveField(11)
  int? externalId;
  @HiveField(12)
  String? registryName;
  @HiveField(13)
  String? registryUrl;
  @HiveField(14)
  List<double>? stolenCoordinates;
  @HiveField(15)
  String? stolenLocation;
  @HiveField(16)
  String? thumb;
  @HiveField(17)
  String? url;
  @HiveField(18)
  String? description;
  @HiveField(19)
  List<String?>? colors;
}
