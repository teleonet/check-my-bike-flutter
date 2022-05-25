class PaginationEntity {
  int _currentPage = 1;

  get currentPage => _currentPage;

  bool _hasNextPage = true;

  get hasNextPage => _hasNextPage;

  void nextPage() => ++_currentPage;

  void firstPage() => _currentPage = 1;

  void setEndPage() => _hasNextPage = false;
}
