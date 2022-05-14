class ManufacturerDTO {
  final String _name;

  get name => _name;

  final String _companyUrl;

  get companyUrl => _companyUrl;

  final String _imageUrl;

  String get imageUrl => _imageUrl;

  ManufacturerDTO(this._name, this._companyUrl, {String imageUrl = ""}) : _imageUrl = imageUrl;

  factory ManufacturerDTO.fromJson(Map<String, dynamic> json) {
    return ManufacturerDTO(json['name'], json["company_url"]);
  }
}
