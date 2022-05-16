import 'dart:math';

import 'package:check_my_bike_flutter/data/data_source/database/dto/bike_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/common_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/distance_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/language_db_dto.dart';
import 'package:check_my_bike_flutter/data/data_source/database/dto/manufacturer_db_dto.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/manufacturer_entity.dart';

class DataUtils {
  DataUtils._();

  static List<ManufacturerEntity> buildManufacturerEntityList({count = 5}) {
    return List<ManufacturerEntity>.generate(count, (index) => buildManufacturerEntity());
  }

  static ManufacturerEntity buildManufacturerEntity() {
    ManufacturerEntity bike = ManufacturerEntity(
      "name: ${DateTime.now()}",
      "https://${DateTime.now()}.com",
      "https://${DateTime.now()}.com",
      true,
    );

    return bike;
  }

  static List<BikeEntity> buildBikeEntityList({count = 5}) {
    return List<BikeEntity>.generate(count, (index) => buildBikeEntity());
  }

  static BikeEntity buildBikeEntity() {
    BikeEntity bike = BikeEntity(
        Random().nextInt(100),
        Random().nextBool(),
        "manufacturer_name: ${DateTime.now()}",
        "serial: ${DateTime.now()}",
        "status: ${DateTime.now()}",
        "title: ${DateTime.now()}",
        2010 + Random().nextInt(9),
        Random().nextBool(),
        "frame_model: ${DateTime.now()}",
        "https://${DateTime.now()}.com",
        "location_found: ${DateTime.now()}",
        Random().nextInt(1000),
        "registry_name: ${DateTime.now()}",
        "registry_url: ${DateTime.now()}",
        [50, 50],
        "stolen_location: ${DateTime.now()}",
        "thumb: ${DateTime.now()}",
        "https://${DateTime.now()}.com",
        "description: ${DateTime.now()}",
        ["yellow", "blue"],
        true);

    return bike;
  }

  static List<BikeDbDTO> buildBikesDb({count = 5}) {
    return List<BikeDbDTO>.generate(count, (index) => buildBikeDB());
  }

  static BikeDbDTO buildBikeDB() {
    BikeDbDTO bike = BikeDbDTO();
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

  static List<ManufacturerDbDTO> buildManufacturersDb({count = 5}) {
    return List<ManufacturerDbDTO>.generate(count, (index) => buildManufacturerDb());
  }

  static ManufacturerDbDTO buildManufacturerDb() {
    ManufacturerDbDTO manufacturer = ManufacturerDbDTO();
    manufacturer.companyUrl = "company_url: https://${DateTime.now()}.com";
    manufacturer.imageUrl = "image_url: https://${DateTime.now()}.com";
    manufacturer.name = "name: ${DateTime.now()}";

    return manufacturer;
  }

  static CommonDbDTO buildCommonDb() {
    CommonDbDTO common = CommonDbDTO();
    common.isFirstStart = false;

    return common;
  }

  static LanguageDbDTO buildLanguageDb() {
    LanguageDbDTO language = LanguageDbDTO();
    language.name = "PL";
    language.iconPath = "//test_path";

    return language;
  }

  static DistanceDbDTO buildDistanceDb() {
    DistanceDbDTO distance = DistanceDbDTO();
    distance.title = "miles";
    distance.type = "ml";

    return distance;
  }
}
