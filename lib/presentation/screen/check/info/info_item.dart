import 'package:flutter/material.dart';

import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';
import '../../../widgets/autoscroll_text.dart';

class InfoItem extends StatelessWidget {
  final Function(BikeEntity)? _onPressedInfo;
  final Function(BikeEntity)? _onPressedFavorite;
  final BikeEntity _bike;

  const InfoItem(this._bike, this._onPressedInfo, this._onPressedFavorite, {Key? key})
      : super(key: key);

  @protected
  List<Widget> getWidgets() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: _buildContainerDecoration(),
        margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
        child: TextButton(
            style: _buildButtonStyle(),
            onPressed: () => _onPressedInfo?.call(_bike),
            child: Stack(children: [
              Column(children: [
                const Padding(padding: EdgeInsets.only(top: 15)),
                _buildPhoto(_bike.largeImg),
                _buildRowContainer(context, "Serial", "${_bike.serial}"),
                _buildRowContainer(context, "Manufacturer", "${_bike.manufacturerName}",
                    widthFactor: 0.37),
                _buildRowContainer(context, "Status", "${_bike.status}",
                    colorValue: _bike.stolen ? Colors.red : null),
                _buildRowContainer(context, "Year", "${_bike.year}"),
                _buildRowContainer(context, "Location", "${_bike.stolenLocation}"),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Column(children: getWidgets())
              ]),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: _buildFavoriteButton()))
            ])));
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(bottom: 15)));
  }

  Widget _buildFavoriteButton() {
    return TextButton(
        onPressed: () => _onPressedFavorite?.call(_bike), child: _buildFavoriteIcon(false));
  }

  Icon _buildFavoriteIcon(bool isFavorite) {
    return isFavorite
        ? Icon(Icons.star, size: 30, color: ColorsRes.green)
        : const Icon(Icons.star_outline_sharp, size: 30, color: Colors.white);
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
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: CircularProgressIndicator(value: value, strokeWidth: 0.4));
  }

  Widget _buildImageContainer(Widget image) {
    return Container(
        decoration: _buildContainerDecoration(borderColor: Colors.transparent, thinness: 0.4),
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: ClipRRect(child: image, borderRadius: BorderRadius.circular(10)));
  }

  Decoration _buildContainerDecoration({Color? borderColor, double? thinness}) {
    return BoxDecoration(
        border: Border.all(color: borderColor ?? ColorsRes.green, width: thinness ?? 1),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Container _buildRowContainer(BuildContext context, String title, String value,
      {Color? colorValue, double? widthFactor}) {
    return Container(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Row(children: [
          _buildTitleText(title),
          _buildValueText(context, value, color: colorValue, widthFactor: widthFactor)
        ]));
  }

  Text _buildTitleText(String title) {
    return Text("$title: ", style: _buildTextStyle(color: ColorsRes.green));
  }

  Widget _buildValueText(BuildContext context, String value, {Color? color, double? widthFactor}) {
    Widget widget = Text(value, style: _buildTextStyle(color: color));
    if (value.length > 20) {
      widget = AutoScrollText(value, MediaQuery.of(context).size.width * (widthFactor ?? 0.5));
    }
    return widget;
  }

  TextStyle _buildTextStyle({Color? color}) {
    return TextStyle(
        fontFamily: 'Roboto Thin',
        color: color ?? Colors.white,
        fontSize: 20,
        decoration: TextDecoration.none);
  }
}
