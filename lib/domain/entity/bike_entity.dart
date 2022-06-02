class BikeEntity {
  final int? _id;

  get id => _id;

  final bool? _isStockImg;

  get isStockImg => _isStockImg;

  final String? _manufacturerName;

  get manufacturerName => _manufacturerName;

  final String? _serial;

  get serial => _serial;

  final String? _status;

  get status => _status;

  final String? _title;

  get title => _title;

  final int? _year;

  get year => _year;

  final bool? _stolen;

  get stolen => _stolen;

  final String? _frameModel;

  get frameModel => _frameModel;

  final String? _largeImg;

  get largeImg => _largeImg;

  final String? _locationFound;

  get locationFound => _locationFound;

  final int? _externalId;

  get externalId => _externalId;

  final String? _registryName;

  get registryName => _registryName;

  final String? _registryUrl;

  get registryUrl => _registryUrl;

  final List<double>? _stolenCoordinates;

  List<double>? get stolenCoordinates => _stolenCoordinates;

  final String? _stolenLocation;

  get stolenLocation => _stolenLocation;

  final String? _thumb;

  get thumb => _thumb;

  final String? _url;

  get url => _url;

  final String? _description;

  get description => _description;

  final List<String?>? _colors;

  get colors => _colors;

  bool? _favorite;

  get favorite => _favorite;

  set(bool favorite) => _favorite = favorite;

  BikeEntity(
      this._id,
      this._isStockImg,
      this._manufacturerName,
      this._serial,
      this._status,
      this._title,
      this._year,
      this._stolen,
      this._frameModel,
      this._largeImg,
      this._locationFound,
      this._externalId,
      this._registryName,
      this._registryUrl,
      this._stolenCoordinates,
      this._stolenLocation,
      this._thumb,
      this._url,
      this._description,
      this._colors,
      this._favorite);
}
