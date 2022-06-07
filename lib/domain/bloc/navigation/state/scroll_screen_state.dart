import '../navigation_bloc.dart';
import 'navigation_state.dart';

class ScrollScreenState extends NavigationState {
  final ScrollDirectionType _direction;

  get direction => _direction;

  ScrollScreenState(this._direction);
}
