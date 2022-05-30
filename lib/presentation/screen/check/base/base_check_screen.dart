import 'package:check_my_bike_flutter/domain/bloc/bike/bike_bloc.dart';
import 'package:check_my_bike_flutter/domain/bloc/bike/state/bike_state.dart';
import 'package:check_my_bike_flutter/domain/entity/pagination_entity.dart';
import 'package:check_my_bike_flutter/presentation/scroll/scroll_controller_with_listener.dart';
import 'package:flutter/material.dart';
import 'package:isolate_bloc/isolate_bloc.dart';

import '../../../../domain/bloc/bike/state/favorite_state.dart';
import '../../../../domain/bloc/bike/state/loaded_state.dart';
import '../../../../domain/bloc/bike/state/progress/global_progress_state.dart';
import '../../../../domain/bloc/bike/state/progress/list_progress_state.dart';
import '../../../../domain/bloc/bike/state/progress/progress_state.dart';
import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';

abstract class BaseCheckScreen extends StatelessWidget {
  final ScrollControllerWithListener scrollController = ScrollControllerWithListener();
  final String _title;

  BaseCheckScreen(this._title, {Key? key}) : super(key: key);

  @protected
  List<Widget> buildInheritorWidgets(BuildContext context);

  @protected
  Widget buildListItem(BuildContext context, BikeEntity bike);

  @protected
  void loadNextPage(BuildContext context, PaginationEntity pagination);

  @override
  Widget build(BuildContext context) {
    return IsolateBlocBuilder<BikeBloc, BikeState>(builder: (context, state) {
      Future(() {
        scrollController.scrollToLastVisiblePosition();
      });
      return Container(
          height: MediaQuery.of(context).size.height,
          decoration: _buildGradientDecoration(),
          child: Stack(children: [
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: CustomScrollView(
                    controller: scrollController
                      ..addScrolledBottomListener(() {
                        if (state is LoadedState && state.pagination.hasNextPage) {
                          state.pagination.nextPage();
                          loadNextPage(context, state.pagination);
                        }
                      }),
                    slivers: [
                      _buildAppBar(context),
                      ...buildInheritorWidgets(context),
                      (state is LoadedState)
                          ? _buildListOrPlaceholder(
                              context, state.bikes, state.pagination.hasNextPage)
                          : _buildEmptyWidget(),
                      (state is GlobalProgressState)
                          ? _buildGlobalProgressIndicator(context)
                          : _buildEmptyWidget(),
                      (state is ListProgressState)
                          ? _buildListView(context, state.bikes, true)
                          : _buildEmptyWidget()
                    ])),
            _buildBottomContainer()
          ]));
    }, buildWhen: (prev, next) {
      return next is LoadedState || next is ProgressState || next is FavoriteState;
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
        titleTextStyle: _buildTextStyle(),
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

  Widget _buildGlobalProgressIndicator(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: Transform.scale(
                scale: 2,
                child: const Center(child: CircularProgressIndicator(strokeWidth: 0.4)))));
  }

  Widget _buildEmptyWidget() {
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  Widget _buildListOrPlaceholder(BuildContext context, List<BikeEntity> loaded, bool addProgress) {
    return loaded.isNotEmpty
        ? _buildListView(context, loaded, addProgress)
        : _buildPlaceholder(context);
  }

  SliverList _buildListView(BuildContext context, List<BikeEntity> bikes, bool addProgress) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      if (index == bikes.length && addProgress) {
        return _buildListProgressItem();
      }
      return buildListItem(context, bikes[index]);
    }, childCount: bikes.length + (addProgress ? 1 : 0)));
  }

  Widget _buildListProgressItem() {
    return const Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: Center(child: CircularProgressIndicator(strokeWidth: 1.5)));
  }

  Widget _buildPlaceholder(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("Did not find results", style: _buildTextStyle(size: 25)))));
  }

  TextStyle _buildTextStyle({double? size}) {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        decoration: TextDecoration.none,
        color: ColorsRes.green,
        fontSize: size ?? 35);
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
}
