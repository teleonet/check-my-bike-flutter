import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';

import 'bike_state.dart';

class ErrorState extends BikeState {
  final ErrorType _errorType;

  ErrorType get errorType => _errorType;

  ErrorState(this._errorType);
}
