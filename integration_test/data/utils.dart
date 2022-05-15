import 'dart:math';

import 'package:check_my_bike_flutter/data/database/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/common_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/distance_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/language_dto.dart';
import 'package:check_my_bike_flutter/data/database/dto/manufacturer_dto.dart';

class Utils {
  Utils._();

  static List<BikeDTO> buildBikes({count = 5}) {
    return List<BikeDTO>.generate(count, (index) => buildBike());
  }

  static BikeDTO buildBike() {
    BikeDTO bike = BikeDTO();
    bike.id = Random().nextInt(100);
    bike.externalId = Random().nextInt(100);
    bike.isStockImg = Random().nextBool();
    bike.largeImg = "https://${DateTime.now()}.com";
    bike.locationFound = "UA_${DateTime.now()}";
    bike.manufacturerName = "manufacturer_name: ${DateTime.now()}";
    bike.registryName = "registry_name: ${DateTime.now()}";
    bike.registryUrl = "https://${DateTime.now()}.com";
    bike.serial = "serial: ${DateTime.now()}";
    bike.status = "status: ${DateTime.now()}";
    bike.stolen = Random().nextBool();
    bike.stolenCoordinates = [Random().nextDouble(), Random().nextDouble()];
    bike.thumb = "thumb: ${DateTime.now()}";
    bike.title = "title: ${DateTime.now()}";
    bike.year = 2010 + Random().nextInt(9);

    return bike;
  }

  static List<ManufacturerDTO> buildManufacturers({count = 5}) {
    return List<ManufacturerDTO>.generate(count, (index) => buildManufacturer());
  }

  static ManufacturerDTO buildManufacturer() {
    ManufacturerDTO manufacturer = ManufacturerDTO();
    manufacturer.companyUrl = "company_url: https://${DateTime.now()}.com";
    manufacturer.imageUrl = "image_url: https://${DateTime.now()}.com";
    manufacturer.name = "name: ${DateTime.now()}";

    return manufacturer;
  }

  static CommonDTO buildCommon() {
    CommonDTO common = CommonDTO();
    common.isFirstStart = false;

    return common;
  }

  static LanguageDTO buildLanguage() {
    LanguageDTO language = LanguageDTO();
    language.name = "PL";
    language.iconPath = "//test_path";

    return language;
  }

  static DistanceDTO buildDistance() {
    DistanceDTO distance = DistanceDTO();
    distance.title = "miles";
    distance.type = "ml";

    return distance;
  }
}
