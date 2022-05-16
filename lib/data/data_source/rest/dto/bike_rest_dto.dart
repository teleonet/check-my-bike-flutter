class BikeRestDTO {
  int? id;
  bool? isStockImg;
  String? manufacturerName;
  String? serial;
  String? status;
  String? title;
  int? year;
  bool? stolen;
  String? frameModel;
  String? largeImg;
  String? locationFound;
  int? externalId;
  String? registryName;
  String? registryUrl;
  List<double?>? stolenCoordinates;
  String? stolenLocation;
  String? thumb;
  String? url;
  String? description;
  List<String?>? colors;

  BikeRestDTO();

  factory BikeRestDTO.fromJson(Map<String, dynamic> json) {
    BikeRestDTO bike = BikeRestDTO();
    bike.id = json['id'];
    bike.isStockImg = json["is_stock_img"];
    bike.manufacturerName = json["manufacturer_name"];
    bike.serial = json["serial"];
    bike.status = json["status"];
    bike.title = json["title"];
    bike.year = json["year"];
    bike.stolen = json["stolen"];
    bike.frameModel = json["frame_model"];
    bike.largeImg = json["large_img"];
    bike.locationFound = json["location_found"];
    bike.externalId = json["external_id"];
    bike.registryName = json["registry_name"];
    bike.registryUrl = json["registry_url"];
    bike.stolenCoordinates = List<double?>.from(json["stolen_coordinates"] ?? []);
    bike.stolenLocation = json["stolen_location"];
    bike.thumb = json["thumb"];
    bike.url = json["url"];
    bike.description = json["description"];
    bike.colors = List<String?>.from(json["frame_colors"] ?? []);

    return bike;
  }
}
