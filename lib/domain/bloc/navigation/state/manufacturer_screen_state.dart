import '../navigation_bloc.dart';
import 'navigation_state.dart';

class ManufacturerScreenState extends NavigationState {
  final ManufacturerScreenType _screen;

  get screen => _screen;

  ManufacturerScreenState(this._screen);
}
