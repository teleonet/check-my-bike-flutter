import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dto/bike_rest_dto.dart';
import 'dto/manufacturer_rest_dto.dart';
import 'exception/rest_exception.dart';
import 'rest_gateway.dart';

class RestGatewayImpl implements RestGateway {
  static const _manufacturerUrl = "https://bikeindex.org:443/api/v3/manufacturers";
  static const _bikeUrl = "https://bikeindex.org:443/api/v3/search";
  static const _comma = "%2C";

  static const _response_200_ok = 200;

  List<ManufacturerRestDTO> _parseManufacturers(List items) {
    return items.map((item) => _parseManufacturer(item)).toList();
  }

  ManufacturerRestDTO _parseManufacturer(Map<String, dynamic> json) {
    return ManufacturerRestDTO.fromJson(json);
  }

  List<BikeRestDTO> _parseBikes(List items) {
    return items.map((item) => _parseBike(item)).toList();
  }

  BikeRestDTO _parseBike(Map<String, dynamic> json) {
    return BikeRestDTO.fromJson(json);
  }

  @override
  Future<List<ManufacturerRestDTO>> loadAllManufacturers(int page, int perPage) async {
    List<ManufacturerRestDTO> manufacturers = [];

    String url = _manufacturerUrl + "?page=$page&per_page=$perPage";

    List? items = await _executeAsList(url, "manufacturers");
    items != null ? manufacturers.addAll(_parseManufacturers(items)) : [];

    return manufacturers;
  }

  @override
  Future<ManufacturerRestDTO?> loadManufacturerByName(String name) async {
    ManufacturerRestDTO? manufacturer;

    String url = _manufacturerUrl + "/$name";

    Map<String, dynamic>? item = await _executeAsMap(url, "manufacturer");
    manufacturer = item != null ? _parseManufacturer(item) : null;

    return manufacturer;
  }

  @override
  Future<List<BikeRestDTO>> loadBikesByCustomParameter(
      String customParameter, int page, int perPage) async {
    List<BikeRestDTO> bikes = [];

    String url = _bikeUrl +
        "?page=$page&per_page=$perPage&query=${customParameter.trim()}&stolenness=stolen";

    List? items = await _executeAsList(url, "bikes");
    items != null ? bikes.addAll(_parseBikes(items)) : [];

    return bikes;
  }

  @override
  Future<List<BikeRestDTO>> loadBikesByLocation(
      double latitude, double longitude, int distance, int page, int perPage) async {
    List<BikeRestDTO>? bikes = [];

    String url = _bikeUrl +
        "?page=$page&per_page=$perPage&location=$latitude$_comma$longitude&distance=$distance&stolenness=proximity";

    List? items = await _executeAsList(url, "bikes");
    items != null ? bikes.addAll(_parseBikes(items)) : [];

    return bikes;
  }

  @override
  Future<List<BikeRestDTO>> loadBikesByManufacturer(
      String manufacturer, int page, int perPage) async {
    List<BikeRestDTO>? bikes = [];

    String url = _bikeUrl +
        "?page=$page&per_page=$perPage&manufacturer=${manufacturer.trim()}&stolenness=stolen";

    List? items = await _executeAsList(url, "bikes");
    items != null ? bikes.addAll(_parseBikes(items)) : [];

    return bikes;
  }

  @override
  Future<List<BikeRestDTO>> loadBikesBySerial(String serial, int page, int perPage) async {
    List<BikeRestDTO>? bikes = [];

    String url =
        _bikeUrl + "?page=$page&per_page=$perPage&serial=${serial.trim()}&stolenness=stolen";

    List? items = await _executeAsList(url, "bikes");
    items != null ? bikes.addAll(_parseBikes(items)) : [];

    return bikes;
  }

  Future<Map<String, dynamic>?> _executeAsMap(String url, String parseField) async {
    Map<String, dynamic>? type;
    return await _execute<Map<String, dynamic>?>(url, parseField, type);
  }

  Future<List?> _executeAsList(String url, String parseField) async {
    List? type;
    return await _execute<List?>(url, parseField, type);
  }

  Future<T?> _execute<T>(String url, String parseField, T responseType) async {
    http.Response response;

    _logHttp(true, url);

    try {
      response = await http.get(Uri.parse(url));
    } on Exception catch (e) {
      _logHttp(false, "ERROR: " + e.toString());
      throw RestException(RestExceptionType.noConnection);
    }

    if (response.statusCode != _response_200_ok) {
      _logHttp(false, "ERROR: status code: " + response.statusCode.toString());
      throw RestException(RestExceptionType.wrongResponse);
    }

    _logHttp(false, "Success: " + response.body);

    T? items = jsonDecode(response.body)[parseField] as T?;
    return items;
  }

  void _logHttp(bool request, String body) {
    if (kDebugMode) {
      print("\n");
      print(request ? "==========> Request ==========>" : "<========== Response <==========");
      print("\n");
      print(body);
      print("\n");
      print(request ? "==============================>" : "<===============================");
      print("\n");
    }
  }
}
