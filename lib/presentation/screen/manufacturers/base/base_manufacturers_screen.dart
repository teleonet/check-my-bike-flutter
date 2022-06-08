import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/clean_cache_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/initial_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/progress/global_progress_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/progress/list_progress_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/bloc/manufacturer/state/initial_state.dart';
import '../../../../domain/bloc/manufacturer/state/progress/progress_state.dart';
import '../../../../domain/entity/manufacturer_entity.dart';
import '../../../../domain/entity/pagination_entity.dart';
import '../manufacturer_item.dart';

abstract class BaseManufacturersScreen extends StatelessWidget {
  PaginationEntity _pagination = PaginationEntity();

  @protected
  List<Widget> buildInheritorWidgets(BuildContext context);

  @protected
  void loadNextPage(BuildContext context, PaginationEntity pagination);

  @protected
  void addFavorite(ManufacturerEntity entity);

  @protected
  void removeFavorite(ManufacturerEntity entity);

  void scrolledBottom(BuildContext context) {
    if (_pagination.hasNextPage) {
      _pagination.nextPage();
      loadNextPage(context, _pagination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<ManufacturerBloc, ManufacturerState>(builder: (context, state) {
      state is InitialState ? loadNextPage(context, _pagination) : null;

      List<Widget> widgets = buildInheritorWidgets(context);
      state is GlobalProgressState ? widgets.add(_buildGlobalProgressIndicator(context)) : null;

      List<ManufacturerEntity> entities = [];
      if (state is LoadedState) {
        _pagination = state.pagination;
        entities = state.entities;
      }

      bool showListProgress = state is ListProgressState;
      showListProgress ? entities = state.manufacturers : null;

      return SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        //todo: need to find more better solution
        if (index == 0) {
          for (Widget item in widgets) {
            return item;
          }
        }
        if (index == entities.length - 1 && showListProgress) {
          return _buildListProgressItem();
        }
        return _buildManufacturerItem(entities[index - widgets.length]);
      }, childCount: widgets.length + entities.length));
    }, buildWhen: (prev, next) {
      return next is ProgressState || next is LoadedState || next is InitialState;
    });
  }

  Widget _buildGlobalProgressIndicator(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: Transform.scale(
            scale: 2, child: const Center(child: CircularProgressIndicator(strokeWidth: 0.4))));
  }

  Widget _buildListProgressItem() {
    return const Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)));
  }

  Widget _buildManufacturerItem(ManufacturerEntity manufacturer) {
    String companyUrl = manufacturer.companyUrl;
    bool isFavorite = manufacturer.favorite;

    return ManufacturerItem(
        manufacturer,
        (manufacturer) => isFavorite ? removeFavorite(manufacturer) : addFavorite(manufacturer),
        (manufacturer) => _openURL(companyUrl));
  }

  void _openURL(String url) async {
    try {
      //todo: need add parameters for Android and IOS => https://pub.dev/packages/url_launcher
      await launch(url);
    } on MissingPluginException catch (e) {
      print("ERROR: $e");
    }
  }

  void cleanCache(BuildContext context) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(CleanCacheEvent());
  }

  void initialize(BuildContext context) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(InitialEvent());
  }
}
