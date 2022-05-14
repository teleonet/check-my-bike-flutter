class ManufacturerDTO {
  String name;
  String companyUrl;
  String imageUrl;

  ManufacturerDTO(this.name, this.companyUrl, {this.imageUrl = ""});

  factory ManufacturerDTO.fromJson(Map<String, dynamic> json) {
    return ManufacturerDTO(json['name'], json["company_url"]);
  }
}
