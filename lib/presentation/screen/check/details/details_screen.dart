import 'package:check_my_bike_flutter/domain/entity/location_entity.dart';
import 'package:check_my_bike_flutter/presentation/router/slide_right_route.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/map/map_screen.dart';
import 'package:check_my_bike_flutter/presentation/screen/check/zoom/zoom_screen.dart';
import 'package:check_my_bike_flutter/presentation/widgets/bordered_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';
import '../../../widgets/autoscroll_text.dart';

class DetailsScreen extends StatelessWidget {
  static void show(BuildContext context, BikeEntity bike) {
    Navigator.push(context, SlideRightRoute(DetailsScreen(bike)).createRoute());
  }

  final BikeEntity _bike;

  const DetailsScreen(this._bike, {Key? key}) : super(key: key);

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
                          _buildRowOrEmpty(context, 'bike_screen.serial'.tr(), "${_bike.serial}",
                              widthFactor: _bike.serial.length > 10 ? 0.38 : 0.65),
                          _buildRowOrEmpty(
                              context, 'bike_screen.manufacturer'.tr(), "${_bike.manufacturerName}",
                              widthFactor: 0.45),
                          _buildRowOrEmpty(context, 'bike_screen.status'.tr(), "${_bike.status}",
                              valueColor: _bike.stolen ? Colors.red : Colors.white),
                          _buildRowOrEmpty(context, 'bike_screen.year'.tr(), "${_bike.year}"),
                          _buildRowOrEmpty(
                              context, 'bike_screen.location'.tr(), "${_bike.stolenLocation}",
                              widthFactor: _bike.stolenLocation.length > 10 ? 0.5 : 0.55),
                          _buildRowOrEmpty(context, 'bike_screen.title'.tr(), "${_bike.title}",
                              widthFactor: _bike.title.length > 10 ? 0.6 : 1),
                          _buildRowOrEmpty(context, 'bike_screen.colors'.tr(),
                              _bike.colors.toString().replaceAll("[", "").replaceAll("]", ""),
                              widthFactor: 0.5),
                          _buildMapButtonOrEmpty(context, _bike.stolenCoordinates),
                          _buildDescriptionOrEmpty(_bike.description),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                        ]))
                  ])))
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
      title: Text('bike_screen.details'.tr()),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(
          fontFamily: 'Roboto Thin',
          color: ColorsRes.green,
          fontSize: 'bike_screen.details'.tr().length > 10 ? 27 : 35),
      leading: _buildToolbarBackButton(context),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    Radius radius = const Radius.circular(30);
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: BorderRadius.only(bottomLeft: radius, bottomRight: radius));
  }

  Widget _buildToolbarBackButton(BuildContext context) {
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

  Widget _buildPhoto(String? imageUrl) {
    if (imageUrl?.isNotEmpty == true) {
      return Image.network(imageUrl!, loadingBuilder: (context, image, progress) {
        if (progress != null) {
          return _buildProgressIndicator(progress);
        }
        return _buildImageContainer(image, () => ZoomScreen.show(context, imageUrl), context);
      }, errorBuilder: (context, exception, stacktrace) {
        return _buildErrorPhotoWidget(context);
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

  Widget _buildImageContainer(Widget image, Function pressedFullScreen, BuildContext context) {
    return TextButton(
        onPressed: () => pressedFullScreen.call(),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                  decoration:
                      _buildContainerDecoration(thinness: 0.4, borderColor: Colors.transparent),
                  child: ClipRRect(child: image, borderRadius: BorderRadius.circular(10))),
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.zoom_in, color: ColorsRes.green, size: 45))
            ])));
  }

  Widget _buildErrorPhotoWidget(BuildContext context) {
    return Container(
        decoration: _buildContainerDecoration(borderColor: ColorsRes.green, thinness: 0.1),
        padding: const EdgeInsets.only(top: 75, bottom: 75),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text('common.error_load_image'.tr(), style: _buildTextStyle(Colors.red))));
  }

  Widget _buildRowOrEmpty(BuildContext context, String title, String? value,
      {Color? valueColor, double? widthFactor}) {
    if (value != null && value.isNotEmpty && value != "null") {
      return Container(
          padding: const EdgeInsets.only(top: 10),
          child: Row(children: [
            _buildTitle(title),
            _buildValue(context, value, textColor: valueColor, widthFactor: widthFactor)
          ]));
    } else {
      return const SizedBox.shrink();
    }
  }

  Text _buildTitle(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Widget _buildValue(BuildContext context, String value, {Color? textColor, double? widthFactor}) {
    Widget widget = Text(value, style: _buildTextStyle(textColor ?? Colors.white));
    if (value.length >= 12) {
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

  Widget _buildMapButtonOrEmpty(BuildContext context, List<double>? coordinates) {
    if (coordinates == null || coordinates.isEmpty) {
      return const SizedBox.shrink();
    }
    LocationEntity location = LocationEntity(coordinates[0], coordinates[1]);
    return Container(
        padding: const EdgeInsets.only(top: 20),
        child: BorderedButton('bike_screen.coordinates_on_map'.tr(), onPressed: () {
          MapScreen.show(context, location, (LocationEntity location, _) {}, MapMode.static,
              zoom: 15);
        }));
  }

  Widget _buildDescriptionOrEmpty(String? description) {
    if (description != null && description.isNotEmpty && description != "null") {
      return Column(children: [
        const Padding(padding: EdgeInsets.only(top: 15)),
        _buildTitle('bike_screen.description'.tr()),
        const Padding(padding: EdgeInsets.only(top: 15)),
        Text(description, style: _buildTextStyle(Colors.white))
      ]);
    } else {
      return const SizedBox.shrink();
    }
  }
}
