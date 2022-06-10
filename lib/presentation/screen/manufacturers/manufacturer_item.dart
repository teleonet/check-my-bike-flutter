import 'package:check_my_bike_flutter/presentation/widgets/autoscroll_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/manufacturer_entity.dart';
import '../../../resources/colors_res.dart';
import '../../dialogs/yes_no_dialog.dart';
import '../check/zoom/zoom_screen.dart';

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

class _ManufacturerItemState extends State<ManufacturerItem> {
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
                    _buildPhoto(widget._manufacturer.imageUrl)
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
    return const SizedBox.shrink();
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
        child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
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
            child: Text('common.error_load_image'.tr(), style: _buildTextStyle(Colors.red, 14))));
  }

  Decoration _buildContainerDecoration({Color? borderColor, double? thinness}) {
    return BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: borderColor ?? ColorsRes.green, width: thinness ?? 1),
        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)));
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
        context, 'manufacturer_screen.ask_delete_item'.tr(args: ["${widget._manufacturer.name}"]));
  }

  void _changeIsFavoriteAndInvokeCallback(bool isFavorite) {
    widget._manufacturer.favorite = isFavorite;
    widget._onFavoritePressed.call(widget._manufacturer);
  }
}
