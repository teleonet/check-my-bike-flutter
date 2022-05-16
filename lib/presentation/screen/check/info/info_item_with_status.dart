import 'package:check_my_bike_flutter/presentation/screen/check/info/info_item.dart';
import 'package:flutter/material.dart';

import '../../../../resources/colors_res.dart';
import '../../../../domain/entity/bike_entity.dart';
import '../../../widgets/flashing_text.dart';

class InfoItemWithStatus extends InfoItem {
  const InfoItemWithStatus(BikeEntity bike,
      {Function(BikeEntity)? onPressedInfo, Function(BikeEntity)? onPressedFavorite, Key? key})
      : super(bike, onPressedFavorite: onPressedFavorite, onPressedInfo: onPressedInfo, key: key);

  @override
  _InfoItemWithStatusState createState() => _InfoItemWithStatusState();
}

class _InfoItemWithStatusState extends InfoItemState {
  @override
  List<Widget> getWidgets() {
    return [_buildStatusText(widget.bike)];
  }

  Widget _buildStatusText(BikeEntity bike) {
    return bike.stolen
        ? const FlashingText("Stolen", Colors.red)
        : Text("Not stolen", style: _buildTextStyle(70));
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
