import 'dart:convert';

import 'package:check_my_bike_flutter/data/rest/dto/bike_dto.dart';
import 'package:check_my_bike_flutter/data/rest/dto/manufacturer_dto.dart';
import 'package:check_my_bike_flutter/data/rest/exception/rest_exception.dart';
import 'package:check_my_bike_flutter/data/rest/rest_gateway.dart';
import 'package:http/http.dart' as http;

class RestGatewayImpl implements RestGateway {
  static const manufacturersUrl = "https://bikeindex.org:443/api/v3/manufacturers";
  static const bikeUrl = "https://bikeindex.org:443/api/v3/search";
  static const comma = "%2C";

  static const response_200_ok = 200;

  static const perPage25 = 25;

  void _validateResponse(http.Response response, Function onSuccess) {
    if (response.statusCode == response_200_ok) {
      onSuccess.call();
    } else {
      throw RestException(response.reasonPhrase ?? "server return error response");
    }
  }

  List<ManufacturerDTO> _parseManufacturers(List items) {
    return items.map((item) => _parseManufacturer(item)).toList();
  }

  ManufacturerDTO _parseManufacturer(Map<String, dynamic> json) {
    return ManufacturerDTO.fromJson(json);
  }

  List<BikeDTO> _parseBikes(List items) {
    return items.map((item) => _parseBike(item)).toList();
  }

  BikeDTO _parseBike(Map<String, dynamic> json) {
    return BikeDTO.fromJson(json);
  }

  @override
  Future<List<ManufacturerDTO>> loadAllManufacturers(int page, {int perPage = perPage25}) async {
    List<ManufacturerDTO> manufacturers = [];

    http.Response response =
        await http.get(Uri.parse(manufacturersUrl + "?page=$page&per_page=$perPage"));

    _validateResponse(response, () {
      List? items = jsonDecode(response.body)["manufacturers"] as List?;
      manufacturers.addAll(items != null ? _parseManufacturers(items) : []);
    });

    return manufacturers;
  }

  @override
  Future<ManufacturerDTO?> loadManufacturerByName(String name) async {
    ManufacturerDTO? manufacturer;

    http.Response response = await http.get(Uri.parse(manufacturersUrl + "/$name"));

    _validateResponse(response, () {
      Map<String, dynamic>? item =
          jsonDecode(response.body)["manufacturer"] as Map<String, dynamic>?;
      manufacturer = item != null ? _parseManufacturer(item) : null;
    });

    return manufacturer;
  }

  @override
  Future<List<BikeDTO>> loadBikesByCustomParameter(String customParameter, int page,
      {int perPage = perPage25}) async {
    List<BikeDTO> bikes = [];

    http.Response response = await http.get(Uri.parse(
        bikeUrl + "?page=$page&perPage=$perPage&query=$customParameter&stolenness=stolen"));

    _validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List?;
      items != null ? bikes.addAll(_parseBikes(items)) : [];
    });

    return bikes;
  }

  @override
  Future<List<BikeDTO>> loadBikesByLocation(
      double latitude, double longitude, int distance, int page,
      {int perPage = perPage25}) async {
    List<BikeDTO>? bikes = [];

    http.Response response = await http.get(Uri.parse(bikeUrl +
        "?page=$page&perPage=$perPage&location=$latitude$comma$longitude&distance=$distance&stolenness=proximity"));

    _validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List?;
      items != null ? bikes.addAll(_parseBikes(items)) : [];
    });

    return bikes;
  }

  @override
  Future<List<BikeDTO>> loadBikesByManufacturer(String manufacturer, int page,
      {int perPage = perPage25}) async {
    List<BikeDTO>? bikes = [];

    http.Response response = await http.get(Uri.parse(
        bikeUrl + "?page=$page&perPage=$perPage&manufacturer=$manufacturer&stolenness=stolen"));

    _validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List?;
      items != null ? bikes.addAll(_parseBikes(items)) : [];
    });

    return bikes;
  }

  @override
  Future<List<BikeDTO>> loadBikesBySerial(String serial, int page,
      {int perPage = perPage25}) async {
    List<BikeDTO>? bikes = [];

    http.Response response = await http
        .get(Uri.parse(bikeUrl + "?page=$page&perPage=$perPage&serial=$serial&stolenness=stolen"));

    _validateResponse(response, () {
      List? items = jsonDecode(response.body)["bikes"] as List?;
      items != null ? bikes.addAll(_parseBikes(items)) : [];
    });

    return bikes;
  }
}
