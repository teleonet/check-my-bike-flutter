import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entity/bike_entity.dart';
import '../../../../resources/colors_res.dart';
import '../../../widgets/flashing_text.dart';

class InfoItemWithStatus extends InfoItem {
  final BikeEntity _bike;

  const InfoItemWithStatus(this._bike, Function(BikeEntity bike) onPressedInfo,
      Function(BikeEntity bike) onPressedFavorite,
      {Key? key})
      : super(_bike, onPressedInfo, onPressedFavorite, key: key);

  @override
  List<Widget> getWidgets() {
    return [_buildStatusText(_bike)];
  }

  Widget _buildStatusText(BikeEntity bike) {
    return bike.stolen
        ? const FlashingText("Stolen", Colors.red)
        : Text("Not stolen", style: _buildTextStyle(60));
  }

  TextStyle _buildTextStyle(double fontSize) {
    return TextStyle(
        decoration: TextDecoration.none,
        fontWeight: FontWeight.bold,
        color: ColorsRes.green,
        fontFamily: 'Roboto Thin',
        fontSize: fontSize);
  }
}
