class RepositoryException implements Exception {
  final String _cause;

  get cause => _cause;

  RepositoryException(this._cause);
}
