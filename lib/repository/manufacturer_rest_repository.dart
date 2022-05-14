import 'dart:convert';

import 'package:check_my_bike_flutter/repository/base_rest_repository.dart';
import 'package:check_my_bike_flutter/repository/models/manufacturer_rest.dart';
import 'package:http/http.dart' as http;

class ManufacturerRestRepository extends BaseRestRepository {
  static const url = "https://bikeindex.org:443/api/v3/manufacturers";
  static const perPage25 = 25;

  Future<List<ManufacturerRest>>? loadAll(int page, {int perPage = perPage25}) async {
    List<ManufacturerRest> manufacturers = [];

    http.Response response = await http.get(Uri.parse(url + "?page=$page&per_page=$perPage"));

    validateResponse(response, () {
      List? items = jsonDecode(response.body)["manufacturers"] as List;
      manufacturers = _parseManufacturers(items);
    });

    return manufacturers;
  }

  Future<ManufacturerRest?> searchByName(String name) async {
    ManufacturerRest? manufacturer;

    http.Response response = await http.get(Uri.parse(url + "/$name"));

    validateResponse(response, () {
      Map<String, dynamic>? item =
          jsonDecode(response.body)["manufacturer"] as Map<String, dynamic>;
      manufacturer = _parseManufacturer(item);
    });

    return manufacturer;
  }

  List<ManufacturerRest> _parseManufacturers(List items) {
    return items.map((item) => _parseManufacturer(item)).toList();
  }

  ManufacturerRest _parseManufacturer(Map<String, dynamic> json) {
    return ManufacturerRest.fromJson(json);
  }
}
