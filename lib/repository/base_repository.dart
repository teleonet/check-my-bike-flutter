import 'package:check_my_bike_flutter/repository/exception/repository_exception.dart';
import 'package:http/http.dart' as http;

abstract class BaseRepository {
  static const ok = 200;
  static const baseUrl = "https://bikeindex.org:443/api/v3/manufacturers";

  void validateResponse(http.Response response, Function onSuccess) {
    if (response.statusCode == ok) {
      onSuccess.call();
    } else {
      throw RepositoryException(response.reasonPhrase ?? "server return error response");
    }
  }
}
