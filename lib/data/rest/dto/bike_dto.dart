class BikeDTO {
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

  BikeDTO(this.id, this.isStockImg, this.manufacturerName, this.serial, this.status, this.title,
      this.year, this.stolen,
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
    this.frameModel;
    this.largeImg;
    this.locationFound;
    this.externalId;
    this.registryName;
    this.registryName;
    this.stolenCoordinates;
    this.stolenLocation;
    this.thumb;
    this.url;
    this.description;
    this.colors;
  }

  factory BikeDTO.fromJson(Map<String, dynamic> json) {
    return BikeDTO(json['id'], json["is_stock_img"], json["manufacturer_name"], json["serial"],
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
