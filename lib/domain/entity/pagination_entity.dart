class PaginationEntity {
  static const int perPage = 20;

  int _currentPage = 1;

  get currentPage => _currentPage;

  bool _hasNextPage = true;

  get hasNextPage => _hasNextPage;

  void nextPage() => ++_currentPage;

  void firstPage() => _currentPage = 1;

  void setEndPage() => _hasNextPage = false;

  PaginationEntity({int currentPage = 1}) {
    _currentPage = currentPage;
  }
}
