import 'package:check_my_bike_flutter/repository/exception/repository_exception.dart';
import 'package:http/http.dart' as http;

abstract class BaseRestRepository {
  static const ok_200 = 200;

  void validateResponse(http.Response response, Function onSuccess) {
    if (response.statusCode == ok_200) {
      onSuccess.call();
    } else {
      throw RepositoryException(response.reasonPhrase ?? "server return error response");
    }
  }
}
