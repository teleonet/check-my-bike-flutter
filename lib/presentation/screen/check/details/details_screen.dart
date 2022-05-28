import 'package:check_my_bike_flutter/presentation/router/slide_right_route.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';
import '../../../widgets/autoscroll_text.dart';

class DetailsScreen extends StatelessWidget {
  final BikeEntity _bike;
  final Function(BikeEntity)? onPressedFavorite;

  static void show(BuildContext context, BikeEntity bike,
      {Function(BikeEntity)? onPressedFavorite}) {
    Navigator.push(context,
        SlideRightRoute(DetailsScreen(bike, onPressedFavorite: onPressedFavorite)).createRoute());
  }

  const DetailsScreen(this._bike, {this.onPressedFavorite, Key? key}) : super(key: key);

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
                  child: Stack(children: [
                    Container(
                        decoration: _buildContainerDecoration(),
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                        child: Column(children: [
                          _buildPhoto(_bike.largeImg),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          _buildRowContainer(context, "Serial", "${_bike.serial}"),
                          _buildRowContainer(context, "Manufacturer", "${_bike.manufacturerName}"),
                          _buildRowContainer(context, "Status", "${_bike.status}",
                              valueColor: _bike.stolen ? Colors.red : Colors.white),
                          _buildRowContainer(context, "Year", "${_bike.year}"),
                          _buildRowContainer(context, "Location", "${_bike.stolenLocation}",
                              widthFactor: 0.55),
                          _buildRowContainer(context, "Title", "${_bike.title}"),
                          _buildRowContainer(context, "Colors",
                              _bike.colors.toString().replaceAll("[", "").replaceAll("]", "")),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          _buildDescriptionOrEmpty(_bike.description)
                        ])),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 25, top: 25),
                            child: _buildFavoriteButton(_bike.favorite)))
                  ]))),
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

  Decoration _buildContainerDecoration({Color? borderColor, double? thinness}) {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: borderColor ?? ColorsRes.green, width: thinness ?? 1),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Widget _buildFavoriteButton(bool isFavorite) {
    return TextButton(
        onPressed: () => onPressedFavorite?.call(_bike), child: _buildFavoriteIcon(isFavorite));
  }

  Icon _buildFavoriteIcon(bool isFavorite) {
    return isFavorite
        ? Icon(Icons.star, size: 35, color: ColorsRes.green)
        : const Icon(Icons.star_outline_sharp, size: 35, color: Colors.white);
  }

  Widget _buildPhoto(String? imgUrl) {
    if (imgUrl?.isNotEmpty == true) {
      return Image.network(imgUrl!, loadingBuilder: (context, image, progress) {
        if (progress != null) {
          return _buildProgressIndicator(progress);
        }
        return _buildImageContainer(image);
      });
    }
    return Icon(Icons.no_photography_outlined, color: ColorsRes.green, size: 100);
  }

  Widget _buildProgressIndicator(ImageChunkEvent progress) {
    double? value = progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1);
    return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: CircularProgressIndicator(value: value, strokeWidth: 0.4));
  }

  Widget _buildImageContainer(Widget image) {
    return Container(
        decoration: _buildContainerDecoration(thinness: 0.4),
        child: ClipRRect(child: image, borderRadius: BorderRadius.circular(10)));
  }

  Container _buildRowContainer(BuildContext context, String title, String value,
      {Color? valueColor, double? widthFactor}) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(children: [
          _buildTitle(title),
          _buildValue(context, value, textColor: valueColor, widthFactor: widthFactor)
        ]));
  }

  Text _buildTitle(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Widget _buildValue(BuildContext context, String value, {Color? textColor, double? widthFactor}) {
    Widget widget = Text(value, style: _buildTextStyle(textColor ?? Colors.white));
    if (value.length > 20) {
      widget = _buildAutoScrollText(context, value, textColor: textColor, widthFactor: widthFactor);
    }
    return widget;
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: color, fontSize: 20, decoration: TextDecoration.none);
  }

  Widget _buildAutoScrollText(BuildContext context, String value,
      {Color? textColor, double? widthFactor}) {
    return AutoScrollText(value, MediaQuery.of(context).size.width * (widthFactor ?? 0.65),
        textColor: textColor);
  }

  Widget _buildDescriptionOrEmpty(String? description) {
    if (description != null && description.isNotEmpty) {
      return Column(children: [
        _buildTitle("Description"),
        const Padding(padding: EdgeInsets.only(top: 15)),
        Text("${_bike.description}", style: _buildTextStyle(Colors.white))
      ]);
    } else {
      return const SizedBox.shrink();
    }
  }
}
