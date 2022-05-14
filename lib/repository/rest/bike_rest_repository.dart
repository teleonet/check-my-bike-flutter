import 'dart:convert';

import 'package:check_my_bike_flutter/repository/rest/base_rest_repository.dart';
import 'package:http/http.dart' as http;

import 'models/bike_rest.dart';

class BikeRestRepository extends BaseRestRepository {
  static const url = "https://bikeindex.org:443/api/v3/search";
  static const comma = "%2C";
  static const ok = 200;
  static const perPage = 25;

  Future<List<BikeRest>?> searchBySerial(String serial, int page, {int perPage = perPage}) async {
    List<BikeRest>? bikes;

    http.Response response = await http
        .get(Uri.parse(url + "?page=$page&perPage=$perPage&serial=$serial&stolenness=stolen"));

    validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List;
      bikes = _parseBikes(items);
    });

    return bikes;
  }

  Future<BikeRest?> searchByManufacturer(String serial, int page, {int perPage = perPage}) async {
    BikeRest? bike;

    http.Response response = await http
        .get(Uri.parse(url + "?page=$page&perPage=$perPage&serial=$serial&stolenness=stolen"));

    validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List;
      if (items.isNotEmpty) {
        bike = _parseBike(items[0]);
      }
    });

    return bike;
  }

  Future<List<BikeRest>?> searchByCustom(String customParameter, int page,
      {int perPage = perPage}) async {
    List<BikeRest>? bikes;

    http.Response response = await http.get(
        Uri.parse(url + "?page=$page&perPage=$perPage&query=$customParameter&stolenness=stolen"));

    validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List;
      bikes = _parseBikes(items);
    });

    return bikes;
  }

  Future<List<BikeRest>?> searchByLocation(
      double latitude, double longitude, int distance, int page,
      {int perPage = perPage}) async {
    List<BikeRest>? bikes;

    http.Response response = await http.get(Uri.parse(url +
        "?page=$page&perPage=$perPage&location=$latitude$comma$longitude&distance=$distance&stolenness=proximity"));

    validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List;
      bikes = _parseBikes(items);
    });

    return bikes;
  }

  List<BikeRest> _parseBikes(List items) {
    return items.map((item) => _parseBike(item)).toList();
  }

  BikeRest _parseBike(Map<String, dynamic> json) {
    return BikeRest.fromJson(json);
  }
}
