class SettingsEntity {
  final String? _distanceTitle;

  get distanceTitle => _distanceTitle;

  final String? _distanceType;

  get distanceType => _distanceType;

  final bool? _isFirsStart;

  get isFirstStart => _isFirsStart;

  final String? _languageIconPath;

  get languageIconPath => _languageIconPath;

  final String? _languageName;

  get languageName => _languageName;

  SettingsEntity(this._distanceTitle, this._distanceType, this._isFirsStart, this._languageIconPath,
      this._languageName);
}
