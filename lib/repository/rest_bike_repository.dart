import 'dart:convert';

import 'package:check_my_bike_flutter/repository/base_repository.dart';
import 'package:check_my_bike_flutter/repository/models/bike_rest.dart';
import 'package:http/http.dart' as http;

class RestBikeRepository extends BaseRepository {
  static const url = "https://bikeindex.org:443/api/v3/search";
  static const ok = 200;
  static const perPage = 25;

  Future<BikeRest?> searchBySerial(String serial, int page, {int perPage = perPage}) async {
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

  List<BikeRest> _parseBikes(List items) {
    return items.map((item) => _parseBike(item)).toList();
  }

  BikeRest _parseBike(Map<String, dynamic> json) {
    return BikeRest.fromJson(json);
  }
}
