import '../navigation_bloc.dart';
import 'navigation_state.dart';

class ShowScreenState extends NavigationState {
  final MainScreenType _screen;

  get screen => _screen;

  ShowScreenState(this._screen);
}
