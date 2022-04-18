class Manufacturer {
  final String _name;

  get name => _name;

  final String _companyUrl;

  get companyUrl => _companyUrl;

  final String _imageUrl;

  String get imageUrl => _imageUrl;

  bool _favorite;

  get favorite => _favorite;

  set favorite(favorite) => _favorite = favorite;

  Manufacturer(this._name, this._companyUrl, this._favorite, {String imageUrl = ""})
      : _imageUrl = imageUrl;
}
