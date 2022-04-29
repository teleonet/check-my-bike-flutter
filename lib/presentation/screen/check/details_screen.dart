import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../../models/bike.dart';
import '../base/base_screen_state.dart';
import '../widgets/autoscroll_text.dart';

class DetailsScreen extends StatefulWidget {
  static void show(BuildContext context, Bike bike) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(bike)));
  }

  final Bike _bike;

  const DetailsScreen(this._bike, {Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends BaseScreenState<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: Column(children: [
          _buildAppBar(),
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
                                  onPressed: () => {}, child: _buildFavoriteIcon(false))),
                          _buildBikeImage()
                        ]),
                        _buildRowContainer("Serial", "${widget._bike.serial}"),
                        _buildRowContainer("Manufacturer", "${widget._bike.manufacturerName}"),
                        _buildRowContainer("Status", "${widget._bike.status}",
                            valueColor: Colors.red),
                        _buildRowContainer("Year", "${widget._bike.year}"),
                        _buildRowContainer("Location", "${widget._bike.stolenLocation}"),
                        _buildRowContainer("Title", "${widget._bike.title}"),
                        _buildRowContainer("Colors",
                            widget._bike.colors.toString().replaceAll("[", "").replaceAll("]", "")),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        _buildTitleText("Description"),
                        const Padding(padding: EdgeInsets.only(top: 15)),
                        Text("${widget._bike.description}", style: _buildTextStyle(Colors.white))
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

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: _buildAppBarBorder(),
      title: const Text("details"),
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorsRes.green, size: 30),
      titleTextStyle: TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 35),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsRes.green, size: 25.0),
          onPressed: () => Navigator.pop(context)),
    );
  }

  OutlinedBorder _buildAppBarBorder() {
    return RoundedRectangleBorder(
        side: BorderSide(width: 0.15, color: ColorsRes.green),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)));
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
    return widget._bike.largeImg?.isNotEmpty
        ? Icon(Icons.insert_photo_outlined, color: ColorsRes.green, size: 250)
        : const SizedBox.shrink();
  }

  Container _buildRowContainer(String title, String value, {Color? valueColor}) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        child:
            Row(children: [_buildTitleText(title), _buildValueText(value, textColor: valueColor)]));
  }

  Text _buildTitleText(String title) {
    return Text("$title: ", style: _buildTextStyle(ColorsRes.green));
  }

  Widget _buildValueText(String value, {Color? textColor}) {
    Widget widget = Text(value, style: _buildTextStyle(textColor ?? Colors.white));
    if (value.length > 20) {
      widget = AutoScrollText(value, MediaQuery.of(context).size.width * 0.65);
    }
    return widget;
  }

  TextStyle _buildTextStyle(Color color) {
    return TextStyle(
        fontFamily: 'Roboto Thin', color: color, fontSize: 20, decoration: TextDecoration.none);
  }
}
