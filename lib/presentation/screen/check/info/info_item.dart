import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../base/base_screen_state.dart';
import '../../../models/bike.dart';
import '../../../widgets/autoscroll_text.dart';

class InfoItem extends StatefulWidget {
  final Bike _bike;

  Bike get bike => _bike;

  final Function(Bike)? onPressedInfo;
  final Function(Bike)? onPressedFavorite;

  const InfoItem(this._bike, {this.onPressedInfo, this.onPressedFavorite, Key? key})
      : super(key: key);

  @override
  InfoItemState createState() => InfoItemState();
}

class InfoItemState extends BaseScreenState<InfoItem> {
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
            onPressed: () => widget.onPressedInfo?.call(widget._bike),
            child: Column(children: [
              Stack(alignment: Alignment.topCenter, children: [
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () => widget.onPressedFavorite?.call(widget._bike),
                        child: _buildFavoriteIcon(false))),
                _buildBikeImage()
              ]),
              _buildRowContainer("Serial", "${widget._bike.serial}"),
              _buildRowContainer("Manufacturer", "${widget._bike.manufacturerName}"),
              _buildRowContainer("Status", "${widget._bike.status}",
                  colorValue: widget._bike.stolen ? Colors.red : null),
              _buildRowContainer("Year", "${widget._bike.year}"),
              _buildRowContainer("Location", "${widget._bike.stolenLocation}"),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Column(children: getWidgets())
            ])));
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(bottom: 15)));
  }

  Decoration _buildContainerDecoration() {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: ColorsRes.green),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
  }

  Widget _buildBikeImage() {
    return widget._bike.largeImg?.isNotEmpty
        ? Icon(Icons.insert_photo_outlined, color: ColorsRes.green, size: 125)
        : const SizedBox.shrink();
  }

  Icon _buildFavoriteIcon(bool isFavorite) {
    return isFavorite
        ? Icon(Icons.star, size: 30, color: ColorsRes.green)
        : const Icon(Icons.star_outline_sharp, size: 30, color: Colors.white);
  }

  Container _buildRowContainer(String title, String value, {Color? colorValue}) {
    return Container(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Row(children: [_buildTitleText(title), _buildValueText(value, color: colorValue)]));
  }

  Text _buildTitleText(String title) {
    return Text("$title: ", style: _buildTextStyle(color: ColorsRes.green));
  }

  Widget _buildValueText(String value, {Color? color}) {
    Widget widget = Text(value, style: _buildTextStyle(color: color));
    if (value.length > 20) {
      widget = AutoScrollText(value, MediaQuery.of(context).size.width * 0.5);
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
