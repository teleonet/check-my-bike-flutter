class RestException implements Exception {
  final String _cause;

  get cause => _cause;

  RestException(this._cause);
}
