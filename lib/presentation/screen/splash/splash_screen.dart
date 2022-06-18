import 'dart:async';
import 'dart:ui';

import 'package:check_my_bike_flutter/domain/bloc/settings/event/settings_event.dart';
import 'package:check_my_bike_flutter/presentation/screen/main/main_screen.dart';
import 'package:check_my_bike_flutter/presentation/widgets/animation/fabric/animation_fabric_impl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../domain/bloc/settings/event/load_event.dart';
import '../../../domain/bloc/settings/event/save_settings_event.dart';
import '../../../domain/bloc/settings/settings_bloc.dart';
import '../../../domain/bloc/settings/state/initial_state.dart';
import '../../../domain/bloc/settings/state/loaded_state.dart';
import '../../../domain/bloc/settings/state/settings_state.dart';
import '../../../domain/entity/distance_entity.dart';
import '../../../domain/entity/language_entity.dart';
import '../../../resources/colors_res.dart';
import '../../dialogs/language/language_dialog.dart';
import '../../widgets/animation/fabric/animation_fabric.dart';

class SplashScreen extends StatefulWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _isFirstLoading = true;
  List<LanguageEntity> _languages = [];
  LanguageEntity? _currentLanguage;
  DistanceEntity? _currentDistance;
  final AnimationFabric _animationFabric = AnimationFabricImpl();
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1250));
    _animationController?.addStatusListener(_animationListener);

    super.initState();
  }

  @override
  void dispose() {
    _animationController?.removeStatusListener(_animationListener);
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IsolateBlocProvider<SettingsBloc, SettingsState>(
        child: IsolateBlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      state is InitialState ? _sendLoadSettingsEvent(context) : null;
      if (state is LoadedState && _currentLanguage == null) {
        _languages = state.languages;
        _currentLanguage = state.currentLanguage;
        _currentDistance = state.currentDistance;
        _isFirstLoading = state.isFirstStart;
        _startAnimation();
      }
      if (state is LoadedState && _currentLanguage?.name != state.currentLanguage.name) {
        _saveSettings(context);
        return const SizedBox.shrink();
      }
      return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(alignment: Alignment.center, children: <Widget>[
            _buildBackgroundImage(),
            _buildBlurFilter(),
            Positioned.fill(
                bottom: 120,
                child: _buildAnimatedText(
                    _animationFabric.createTopBottom(_animationController!), "Check")),
            _buildAnimatedText(_animationFabric.createLeftRight(_animationController!), "my"),
            Positioned.fill(
                top: 150,
                child: _buildAnimatedText(
                    _animationFabric.createBottomTop(_animationController!), "bike"))
          ]));
    }, buildWhen: (prev, next) {
      return prev is InitialState && next is LoadedState;
    }));
  }

  void _sendLoadSettingsEvent(BuildContext context) {
    context.isolateBloc<SettingsBloc, SettingsState>().add(LoadEvent());
  }

  void _startAnimation() {
    Timer(const Duration(milliseconds: 300), () => _animationController?.forward());
  }

  Widget _buildBackgroundImage() {
    return Image.asset('assets/images/splash_bg.jpg',
        height: double.infinity, width: double.infinity, fit: BoxFit.fitHeight);
  }

  Widget _buildBlurFilter() {
    return BackdropFilter(
        child: Container(color: Colors.black12), filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3));
  }

  Widget _buildAnimatedText(Animation<Offset> animation, String text) {
    return SlideTransition(
        position: animation, child: Center(child: Text(text, style: _buildTextStyle())));
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        color: ColorsRes.greenOpacity70,
        fontSize: 80,
        decoration: TextDecoration.none);
  }

  void _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Timer(const Duration(milliseconds: 300), () {
        _isFirstLoading ? _showLanguageDialog(context) : _showMainScreen();
      });
    }
  }

  void _showLanguageDialog(BuildContext context) {
    LanguageDialog(_languages, _currentLanguage!, (language) {
      String languageName = language.name!.replaceAll('ua', 'lo');
      if (_currentLanguage?.name != language.name) {
        context.setLocale(Locale(languageName));
      }
      _currentLanguage = language;
      // _saveSettings(context);
      _showMainScreen();
    }).show(context, 'settings_screen.language'.tr(), dismissTouchOutside: true);
  }

  void _saveSettings(BuildContext context) {
    SettingsEvent event = SaveSettingsEvent(_currentLanguage!, _currentDistance!, false);
    context.isolateBloc<SettingsBloc, SettingsState>().add(event);
  }

  void _showMainScreen() {
    Timer(const Duration(microseconds: 100), () => MainScreen.showAndClearStack(context));
  }
}
