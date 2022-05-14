class ManufacturerRest {
  final String _name;

  get name => _name;

  final String _companyUrl;

  get companyUrl => _companyUrl;

  final String _imageUrl;

  String get imageUrl => _imageUrl;

  ManufacturerRest(this._name, this._companyUrl, {String imageUrl = ""}) : _imageUrl = imageUrl;

  factory ManufacturerRest.fromJson(Map<String, dynamic> json) {
    return ManufacturerRest(json['name'], json["company_url"]);
  }
}
