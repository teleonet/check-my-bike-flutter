class ManufacturerRestDTO {
  String? name;
  String? companyUrl;
  String? imageUrl;

  ManufacturerRestDTO();

  factory ManufacturerRestDTO.fromJson(Map<String, dynamic> json) {
    ManufacturerRestDTO manufacturer = ManufacturerRestDTO();
    manufacturer.name = json['name'];
    manufacturer.companyUrl = json["company_url"];
    manufacturer.imageUrl = json["image"] ?? "";

    return manufacturer;
  }
}
