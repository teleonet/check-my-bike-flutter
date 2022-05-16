class ManufacturerEntity {
  final String? _name;

  get name => _name;

  final String? _companyUrl;

  get companyUrl => _companyUrl;

  final String? _imageUrl;

  get imageUrl => _imageUrl;

  bool? _favorite;

  get isFavorite => _favorite;

  set isFavorite(favorite) => _favorite = favorite;

  ManufacturerEntity(this._name, this._companyUrl, this._favorite, this._imageUrl);
}
