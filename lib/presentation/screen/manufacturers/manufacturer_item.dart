import 'package:check_my_bike_flutter/presentation/widgets/autoscroll_text.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/manufacturer_entity.dart';
import '../../../resources/colors_res.dart';
import '../../base/base_screen_state.dart';
import '../../dialogs/yes_no_dialog.dart';

class ManufacturerItem extends StatefulWidget {
  final ManufacturerEntity _manufacturer;
  final Function(ManufacturerEntity) _onFavoritePressed;
  final Function(ManufacturerEntity) _onItemPressed;

  const ManufacturerItem(this._manufacturer, this._onFavoritePressed, this._onItemPressed,
      {Key? key})
      : super(key: key);

  @override
  _ManufacturerItemState createState() => _ManufacturerItemState();
}

class _ManufacturerItemState extends BaseScreenState<ManufacturerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
        decoration: _buildLeftLineDecoration(),
        child: TextButton(
            style: _buildButtonStyle(),
            onPressed: () => widget._onItemPressed.call(widget._manufacturer),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget._manufacturer.name, style: _buildTextStyle(ColorsRes.green, 16)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    AutoScrollText(
                        widget._manufacturer.companyUrl, MediaQuery.of(context).size.width * 0.65,
                        textStyle: _buildTextStyle(Colors.white, 20)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    _buildManufacturerImage(),
                  ])),
              const Spacer(),
              _buildTextButton()
            ])));
  }

  Decoration _buildLeftLineDecoration() {
    return BoxDecoration(
        border: Border.all(width: 0.5, color: ColorsRes.green.withOpacity(0.2)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.02))],
        gradient: LinearGradient(
            stops: const [0.01, 0.01], colors: [ColorsRes.green, Colors.transparent]));
  }

  ButtonStyle _buildButtonStyle() {
    return TextButton.styleFrom(
        padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap);
  }

  TextStyle _buildTextStyle(Color color, double fontSize) {
    return TextStyle(fontFamily: 'Roboto Thin', color: color, fontSize: fontSize);
  }

  Widget _buildManufacturerImage() {
    return widget._manufacturer.imageUrl.isNotEmpty
        ? Icon(Icons.tab, color: ColorsRes.green, size: 125.0)
        : const SizedBox.shrink();
  }

  Widget _buildTextButton() {
    return TextButton(
        child: _buildFavoriteIcon(),
        onPressed: () {
          if (widget._manufacturer.favorite) {
            _showDeleteFavoriteDialog(() => _changeIsFavoriteAndInvokeCallback(false));
          } else {
            _changeIsFavoriteAndInvokeCallback(true);
          }
        });
  }

  Icon _buildFavoriteIcon() {
    return widget._manufacturer.favorite
        ? Icon(Icons.star, size: 30, color: ColorsRes.green)
        : const Icon(Icons.star_outline_sharp, size: 30, color: Colors.white);
  }

  void _showDeleteFavoriteDialog(Function deletePressed) {
    YesNoDialog(() => deletePressed.call(), () => {}).show(
        context, "Are you approve to delete \n\"${widget._manufacturer.name}\"\n from favorites ?");
  }

  void _changeIsFavoriteAndInvokeCallback(bool isFavorite) {
    widget._manufacturer.favorite = isFavorite;
    widget._onFavoritePressed.call(widget._manufacturer);
  }
}
