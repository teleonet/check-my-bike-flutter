import 'package:check_my_bike_flutter/presentation/router/slide_right_route.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';
import '../../../widgets/autoscroll_text.dart';

class DetailsScreen extends StatelessWidget {
  final BikeEntity _bike;
  final Function(BikeEntity)? favoriteCallback;

  static void show(BuildContext context, BikeEntity bike,
      {Function(BikeEntity)? favoriteCallback}) {
    Navigator.push(context,
        SlideRightRoute(DetailsScreen(bike, favoriteCallback: favoriteCallback)).createRoute());
  }

  const DetailsScreen(this._bike, {this.favoriteCallback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: Column(children: [
          _buildAppBar(context),
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                      decoration: _buildContainerDecoration(),
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      padding: const EdgeInsets.only(bottom: 15, left: 20),
                      child: Column(children: [
                        Stack(alignment: Alignment.topCenter, children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () => favoriteCallback?.call(_bike),
                                  child: _buildFavoriteIcon(false))),
                          _buildBikeImage()
                        ]),
                        _buildRowContainer(context, "Serial", "${_bike.serial}"),
                        _buildRowContainer(context, "Manufacturer", "${_bike.manufacturerName}"),
                        _buildRowContainer(context, "Status", "${_bike.status}",
                            valueColor: _bike.stolen ? Colors.red : Colors.white),
                        _buildRowContainer(context, "Year", "${_bike.year}"),
                        _buildRowContainer(context, "Location", "${_bike.stolenLocation}"),
                        _buildRowContainer(context, "Title", "${_bike.title}"),
                        _buildRowContainer(context, "Colors",
                            _bike.colors.toString().replaceAll("[", "").replaceAll("]", "")),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        _buildTitle("Description"),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        Text("${_bike.description}", style: _buildTextStyle(Colors.white))
                      ])))),
        ]));
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorsRes.startGradient, ColorsRes.endGradient]));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: _buildAppBarBorder(),
      title: const Text("details"),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
      leading: _buildIconButton(context),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
  }

  Widget _buildIconButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
        onPressed: () => Navigator.pop(context));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Icon _buildFavoriteIcon(bool isFavorite) {
    return isFavorite
        ? Icon(Icons.star, size: 35, color: ColorsRes.green)
        : const Icon(Icons.star_outline_sharp, size: 35, color: Colors.white);
  }

  Widget _buildBikeImage() {
    return _bike.largeImg?.isNotEmpty
        ? Icon(Icons.insert_photo_outlined, color: ColorsRes.green, size: 250)
        : const SizedBox.shrink();
  }

  Container _buildRowContainer(BuildContext context, String title, String value,
      {Color? valueColor}) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
            children: [_buildTitle(title), _buildValue(context, value, textColor: valueColor)]));
  }

  Text _buildTitle(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Widget _buildValue(BuildContext context, String value, {Color? textColor}) {
    Widget widget = Text(value, style: _buildTextStyle(textColor ?? Colors.white));
    if (value.length > 20) {
      widget = _buildAutoScrollText(context, value, textColor: textColor);
    }
    return widget;
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: color, fontSize: 20, decoration: TextDecoration.none);
  }

  Widget _buildAutoScrollText(BuildContext context, String value, {Color? textColor}) {
    return AutoScrollText(value, MediaQuery.of(context).size.width * 0.65, textColor: textColor);
  }
}
