import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/add_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/favorite/remove_favorite_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/event/load/load_favorites.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/initial_state.dart';
import 'package:check_my_bike_flutter/domain/entity/bike_entity.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/details/details_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/state/loaded_state.dart';
import '../../../../domain/bloc/bike/state/progress/global_progress_state.dart';
import '../../../../domain/bloc/bike/state/progress/progress_state.dart';
import '../../../../resources/colors_res.dart';

class FavoritesScreen extends StatelessWidget {
  static show(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return IsolateBlocProvider<BikeBloc, BikeState>(child: const FavoritesScreen());
    }));
  }

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<BikeBloc, BikeState>(builder: (context, state) {
      state is InitialState ? _loadBikes(context, PaginationEntity()) : null;
      return Container(
          height: MediaQuery.of(context).size.height,
          decoration: _buildGradientDecoration(),
          child: Stack(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: CustomScrollView(slivers: [
                  _buildAppBar(context),
                  (state is GlobalProgressState)
                      ? _buildGlobalProgressIndicator(context)
                      : _buildEmptyWidget(),
                  (state is LoadedState)
                      ? _buildListOrPlaceholder(context, state.bikes)
                      : _buildEmptyWidget(),
                ])),
            _buildBottomContainer()
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
        title: Text('common.favorites'.tr().toLowerCase()),
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
        titleTextStyle: _buildTextStyle(),
        leading: _buildToolbarBackButton(context));
  }

  OutlinedBorder _buildAppBarBorder() {
    Radius radius = const Radius.circular(30);
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius));
  }

  Widget _buildGlobalProgressIndicator(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
            child: Transform.scale(scale: 2, child: _buildProgressIndicator())));
  }

  Widget _buildProgressIndicator() {
    return const Center(child: CircularProgressIndicator(strokeWidth: 0.4));
  }

  Widget _buildEmptyWidget() {
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  Widget _buildListOrPlaceholder(BuildContext context, List<BikeEntity> loaded) {
    return loaded.isNotEmpty ? _buildListView(context, loaded) : _buildPlaceholder(context);
  }

  SliverList _buildListView(BuildContext context, List<BikeEntity> bikes) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return buildListItem(context, bikes[index]);
    }, childCount: bikes.length));
  }

  Widget buildListItem(BuildContext context, BikeEntity bike) {
    return InfoItem(bike, (bike) => DetailsScreen.show(context, bike), (bike) {
      bike.favorite ? _removeFavorite(bike, context) : _addFavorite(bike, context);
    });
  }

  Widget _buildPlaceholder(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text('common.favorites_empty'.tr(), style: _buildTextStyle(size: 25)))));
  }

  TextStyle _buildTextStyle({double? size}) {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        decoration: TextDecoration.none,
        color: ColorsRes.green,
        fontSize: size ?? 35);
  }

  Widget _buildToolbarBackButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
        onPressed: () => Navigator.pop(context));
  }

  Widget _buildBottomContainer() {
    return Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(height: 15, decoration: _buildContainerDecoration()));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        border: Border.all(width: 0.4, color: ColorsRes.green),
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)));
  }

  void _loadBikes(BuildContext context, PaginationEntity pagination) {
    context.isolateBloc<BikeBloc, BikeState>().add(LoadFavoritesEvent(pagination));
  }

  void _addFavorite(BikeEntity bike, BuildContext context) {
    context.isolateBloc<BikeBloc, BikeState>().add(AddFavoriteEvent(bike));
  }

  void _removeFavorite(BikeEntity bike, BuildContext context) {
    context
        .isolateBloc<BikeBloc, BikeState>()
        .add(RemoveFavoriteEvent(bike, deleteFromResult: true));
  }
}
