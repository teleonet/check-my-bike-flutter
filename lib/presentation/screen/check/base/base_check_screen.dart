import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/state/loaded_state.dart';
import '../../../../domain/bloc/bike/state/progress_state.dart';
import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';

abstract class BaseCheckScreen extends StatelessWidget {
  final String _title;

  const BaseCheckScreen(this._title, {Key? key}) : super(key: key);

  @protected
  Widget getListView(BuildContext context, List<BikeEntity> bikes);

  @protected
  List<Widget> getWidgets(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<BikeBloc, BikeState>(builder: (context, state) {
      return Container(
          height: MediaQuery.of(context).size.height,
          decoration: _buildGradientDecoration(),
          child: Stack(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: CustomScrollView(slivers: [
                  _buildAppBar(context),
                  ...getWidgets(context),
                  state is LoadedState
                      ? getListView(context, state.bikes)
                      : _buildProgressIndicator(context),
                ])),
            _buildContainer()
          ]));
    }, buildWhen: (prev, next) {
      return next is LoadedState || next is ProgressState;
    });
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
        toolbarHeight: 65,
        floating: true,
        backgroundColor: ColorsRes.startGradient,
        shadowColor: Colors.transparent,
        shape: _buildAppBarBorder(),
        title: Text(_title),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
        titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
            onPressed: () => Navigator.pop(context)));
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: Transform.scale(
                scale: 2,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 0.4)))));
  }

  Widget _buildContainer() {
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(height: 15, decoration: _buildDecoration()));
  }

  Decoration _buildDecoration() {
    return BoxDecoration(
        border: Border.all(width: 0.4, color: ColorsRes.green),
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)));
  }
}
