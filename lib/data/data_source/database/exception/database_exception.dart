class DatabaseException implements Exception {
  final String _cause;

  get cause => _cause;

  DatabaseException(this._cause);
}
