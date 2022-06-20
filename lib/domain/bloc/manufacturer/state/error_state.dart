import 'package:check_my_bike_flutter/domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';

class ErrorState extends ManufacturerState {
  final ErrorType _errorType;

  ErrorType get errorType => _errorType;

  ErrorState(this._errorType);
}
