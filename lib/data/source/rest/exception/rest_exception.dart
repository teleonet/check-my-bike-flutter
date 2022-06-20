enum RestExceptionType { wrongResponse, noConnection }

class RestException implements Exception {
  final RestExceptionType _type;

  RestExceptionType get type => _type;

  RestException(this._type);
}
