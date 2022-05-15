class ManufacturerDTO {
  String? name;
  String? companyUrl;
  String? imageUrl;

  ManufacturerDTO();

  factory ManufacturerDTO.fromJson(Map<String, dynamic> json) {
    ManufacturerDTO manufacturer = ManufacturerDTO();
    manufacturer.name = json['name'];
    manufacturer.companyUrl = json["company_url"];
    manufacturer.imageUrl = json["image"] ?? "";

    return manufacturer;
  }
}
