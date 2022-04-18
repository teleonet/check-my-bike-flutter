import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../../dialogs/yes_no_dialog.dart';
import '../../models/manufacturer.dart';
import '../base/base_screen_state.dart';

class ManufacturerItem extends StatefulWidget {
  final Manufacturer _manufacturer;
  final Function(Manufacturer) _onFavoritePressed;
  final Function(Manufacturer) _onItemPressed;

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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: const [0.01, 0.01], colors: [ColorsRes.green, Colors.transparent]),
            boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.02))],
            border: Border.all(width: 0.5, color: ColorsRes.green.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () => widget._onItemPressed.call(widget._manufacturer),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget._manufacturer.name, style: _buildTextStyle(ColorsRes.green, 16)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Text(widget._manufacturer.companyUrl, style: _buildTextStyle(Colors.white, 20)),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    _buildManufacturerImage(),
                  ])),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    if (widget._manufacturer.isFavorite) {
                      _showDeleteDialog(() => _updateFavoriteAndInvokeCallback(false));
                    } else {
                      _updateFavoriteAndInvokeCallback(true);
                    }
                  },
                  child: Icon(_buildFavoriteIcon(), size: 30, color: ColorsRes.green))
            ])));
  }

  TextStyle _buildTextStyle(Color color, double fontSize) {
    return TextStyle(fontFamily: 'Roboto Thin', color: color, fontSize: fontSize);
  }

  Widget _buildManufacturerImage() {
    return widget._manufacturer.imageUrl.isNotEmpty
        ? Icon(Icons.tab, color: ColorsRes.green, size: 125.0)
        : const SizedBox.shrink();
  }

  IconData _buildFavoriteIcon() {
    return widget._manufacturer.isFavorite ? Icons.star : Icons.star_outline;
  }

  void _showDeleteDialog(Function deletePressed) {
    YesNoDialog(() {
      deletePressed.call();
    }).show(
        context, "Are you approve to delete \n\"${widget._manufacturer.name}\"\n from favorites ?");
  }

  void _updateFavoriteAndInvokeCallback(bool isFavorite) {
    widget._manufacturer.isFavorite = isFavorite;
    widget._onFavoritePressed.call(widget._manufacturer);
    setState(() => {});
  }
}
