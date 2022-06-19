import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/clean_cache_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/event/initial_event.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/manufacturer_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/load/loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/load/search_loaded_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/manufacturer_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/progress/global_progress_state.dart';
import 'package:check_my_bike_flutter/domain/bloc/manufacturer/state/progress/list_progress_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/bloc/manufacturer/state/initial_state.dart';
import '../../../../domain/bloc/manufacturer/state/progress/progress_state.dart';
import '../../../../domain/entity/manufacturer_entity.dart';
import '../../../../domain/entity/pagination_entity.dart';
import '../../../../resources/colors_res.dart';
import '../manufacturer_item.dart';

abstract class BaseManufacturerScreen extends StatelessWidget {
  PaginationEntity _pagination = PaginationEntity();

  BaseManufacturerScreen({Key? key}) : super(key: key);

  @protected
  List<Widget> buildInheritorWidgets(BuildContext context);

  @protected
  void loadNextPage(BuildContext context, PaginationEntity pagination);

  @protected
  void addFavorite(BuildContext context, ManufacturerEntity entity);

  @protected
  void removeFavorite(BuildContext context, ManufacturerEntity entity);

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

      if (state is GlobalProgressState) {
        double heightDivider = widgets.isNotEmpty ? widgets.length.toDouble() + 1 : 1.5;
        widgets.add(_buildGlobalProgressIndicator(context, heightDivider));
      }

      List<ManufacturerEntity> entities = [];
      if (state is LoadedState) {
        _pagination = state.pagination;
        entities = state.entities;
      }

      if (state is SearchLoadedState && entities.isEmpty) {
        widgets.add(_buildPlaceholder(context));
      }

      bool showListProgress = state is ListProgressState;
      showListProgress ? entities = state.manufacturers : null;

      return SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        //todo: need to find more better solution
        if (widgets.length > index) {
          return widgets[index];
        }
        if (index == entities.length - 1 && showListProgress) {
          return _buildListProgressItem();
        }
        return entities.isNotEmpty
            ? _buildManufacturerItem(context, entities[index - widgets.length])
            : const SizedBox.shrink();
      }, childCount: widgets.length + entities.length));
    }, buildWhen: (prev, next) {
      return next is ProgressState || next is LoadedState || next is InitialState;
    });
  }

  Widget _buildGlobalProgressIndicator(BuildContext context, double heightDivider) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / heightDivider,
        width: MediaQuery.of(context).size.width,
        child: Transform.scale(
            scale: 2, child: const Center(child: CircularProgressIndicator(strokeWidth: 0.4))));
  }

  Widget _buildListProgressItem() {
    return const Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)));
  }

  Widget _buildPlaceholder(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child:
            Center(child: Text('common.not_found_results'.tr(), style: _buildTextStyle(size: 25))));
  }

  TextStyle _buildTextStyle({double? size}) {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        decoration: TextDecoration.none,
        color: ColorsRes.green,
        fontSize: size ?? 35);
  }

  Widget _buildManufacturerItem(BuildContext context, ManufacturerEntity manufacturer) {
    String companyUrl = manufacturer.companyUrl;
    bool isFavorite = manufacturer.favorite;

    return ManufacturerItem(manufacturer, (manufacturer) {
      isFavorite ? removeFavorite(context, manufacturer) : addFavorite(context, manufacturer);
    }, (manufacturer) => _openURL(companyUrl));
  }

  void _openURL(String url) async {
    try {
      await launch(url);
    } on MissingPluginException catch (e) {
      print("ERROR open manufacturer URL: $e");
    }
  }

  void cleanCache(BuildContext context) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(CleanCacheEvent());
  }

  void initialize(BuildContext context) {
    context.isolateBloc<ManufacturerBloc, ManufacturerState>().add(InitialEvent());
  }
}
