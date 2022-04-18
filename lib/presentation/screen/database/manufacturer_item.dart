import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../resources/colors_res.dart';
import '../../models/manufacturer.dart';
import '../base/base_screen_state.dart';

class ManufacturerItem extends StatefulWidget {
  final Manufacturer _manufacturer;
  final Function(Manufacturer) _onFavoritePressed;
  final Function(Manufacturer) _onUrlPressed;

  const ManufacturerItem(this._manufacturer, this._onFavoritePressed, this._onUrlPressed,
      {Key? key})
      : super(key: key);

  @override
  _ManufacturerItemState createState() => _ManufacturerItemState();
}

class _ManufacturerItemState extends BaseScreenState<ManufacturerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: const [0.01, 0.01], colors: [ColorsRes.green, Colors.transparent]),
            border: Border.all(width: 0.5, color: ColorsRes.green.withOpacity(0.1)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget._manufacturer.name,
                    style:
                        TextStyle(fontFamily: 'Roboto Thin', color: ColorsRes.green, fontSize: 16)),
                const Padding(padding: EdgeInsets.only(top: 10)),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    onPressed: () {
                      widget._onUrlPressed.call(widget._manufacturer);
                    },
                    child: Text(widget._manufacturer.companyUrl,
                        style: const TextStyle(
                            fontFamily: 'Roboto Thin', color: Colors.white, fontSize: 20))),
                const Padding(padding: EdgeInsets.only(top: 10)),
                _buildImage(),
              ])),
          const Spacer(),
          TextButton(
              onPressed: () {
                widget._manufacturer.favorite = !widget._manufacturer.favorite;
                widget._onFavoritePressed.call(widget._manufacturer);
                setState(() => {});
              },
              child: Icon(_buildFavoriteIcon(), size: 30, color: ColorsRes.green))
        ]));
  }

  Widget _buildImage() {
    return widget._manufacturer.imageUrl.isNotEmpty
        ? Icon(Icons.tab, color: ColorsRes.green, size: 125.0)
        : const SizedBox.shrink();
  }

  IconData _buildFavoriteIcon() {
    return widget._manufacturer.favorite ? Icons.star : Icons.star_outline;
  }
}
