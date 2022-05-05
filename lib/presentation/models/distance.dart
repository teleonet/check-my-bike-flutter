enum type { km, ml }

class DistanceType {
  final String _title;
  final type _type;

  get distanceType => _type;

  get title => _title;

  DistanceType(this._title, this._type);
}
