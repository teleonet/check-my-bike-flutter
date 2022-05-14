enum type { km, ml }

class DistanceEntity {
  final String _title;
  final type _type;

  get distanceType => _type;

  get title => _title;

  DistanceEntity(this._title, this._type);
}
