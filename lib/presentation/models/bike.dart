class Bike {
  final int _id;

  get id => _id;

  final bool _isStockImg;

  get isStockImg => _isStockImg;

  final String _manufacturerName;

  get manufacturerName => _manufacturerName;

  final String _serial;

  get serial => _serial;

  final String _status;

  get status => _status;

  final String _title;

  get title => _title;

  final int _year;

  get year => _year;

  final bool _stolen;

  get stolen => _stolen;

  String? _frameModel;

  get frameModel => _frameModel;

  String? _largeImg;

  get largeImg => _largeImg;

  bool? _locationFound;

  get locationFound => _locationFound;

  int? _externalId;

  get externalId => _externalId;

  String? _registryName;

  get registryName => _registryName;

  String? _registryUrl;

  get registryUrl => _registryUrl;

  String? _stolenCoordinates;

  get stolenCoordinates => _stolenCoordinates;

  String? _stolenLocation;

  get stolenLocation => _stolenLocation;

  String? _thumb;

  get thumb => _thumb;

  String? _url;

  get url => _url;

  String? _description;

  get description => _description;

  List<String>? _colors;

  get colors => _colors;

  Bike(this._id, this._isStockImg, this._manufacturerName, this._serial, this._status, this._title,
      this._year, this._stolen,
      {String? frameModel,
      String? largeImg,
      bool? locationFound,
      int? externalId,
      String? registryName,
      String? registryUrl,
      String? stolenCoordinates,
      String? stolenLocation,
      String? thumb,
      String? url,
      String? description,
      List<String>? colors}) {
    _frameModel = frameModel;
    _largeImg = largeImg;
    _locationFound = locationFound;
    _externalId = externalId;
    _registryName = registryName;
    _registryUrl = registryName;
    _stolenCoordinates = stolenCoordinates;
    _stolenLocation = stolenLocation;
    _thumb = thumb;
    _url = url;
    _description = description;
    _colors = colors;
  }
}
