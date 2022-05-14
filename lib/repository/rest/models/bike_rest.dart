class BikeRest {
  final int? _id;

  int? get id => _id;

  final bool? _isStockImg;

  bool? get isStockImg => _isStockImg;

  final String? _manufacturerName;

  String? get manufacturerName => _manufacturerName;

  final String? _serial;

  String? get serial => _serial;

  final String? _status;

  String? get status => _status;

  final String? _title;

  String? get title => _title;

  final int? _year;

  int? get year => _year;

  final bool? _stolen;

  bool? get stolen => _stolen;

  String? _frameModel;

  String? get frameModel => _frameModel;

  String? _largeImg;

  String? get largeImg => _largeImg;

  String? _locationFound;

  String? get locationFound => _locationFound;

  int? _externalId;

  int? get externalId => _externalId;

  String? _registryName;

  String? get registryName => _registryName;

  String? _registryUrl;

  String? get registryUrl => _registryUrl;

  List<double?>? _stolenCoordinates;

  List<double?>? get stolenCoordinates => _stolenCoordinates;

  String? _stolenLocation;

  String? get stolenLocation => _stolenLocation;

  String? _thumb;

  String? get thumb => _thumb;

  String? _url;

  String? get url => _url;

  String? _description;

  String? get description => _description;

  List<String?>? _colors;

  List<String?>? get colors => _colors;

  BikeRest(this._id, this._isStockImg, this._manufacturerName, this._serial, this._status,
      this._title, this._year, this._stolen,
      {String? frameModel,
      String? largeImg,
      String? locationFound,
      int? externalId,
      String? registryName,
      String? registryUrl,
      List<double?>? stolenCoordinates,
      String? stolenLocation,
      String? thumb,
      String? url,
      String? description,
      List<String?>? colors}) {
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

  factory BikeRest.fromJson(Map<String, dynamic> json) {
    return BikeRest(json['id'], json["is_stock_img"], json["manufacturer_name"], json["serial"],
        json["status"], json["title"], json["year"], json["stolen"],
        frameModel: json["frame_model"],
        largeImg: json["large_img"],
        locationFound: json["location_found"],
        externalId: json["external_id"],
        registryName: json["registry_name"],
        registryUrl: json["registry_url"],
        stolenCoordinates: List<double?>.from(json["stolen_coordinates"] ?? []),
        stolenLocation: json["stolen_location"],
        thumb: json["thumb"],
        url: json["url"],
        description: json["description"],
        colors: List<String?>.from(json["frame_colors"] ?? []));
  }
}
