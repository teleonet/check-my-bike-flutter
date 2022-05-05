import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class ScrollControllerWithListener extends ScrollController {
  final Function() _onScrolledFullTop;
  final Function() _onScrollTop;
  final Function() _onScrollBottom;

  bool _isTopScroll = false;
  bool _isBottomScroll = false;

  ScrollControllerWithListener(this._onScrollTop, this._onScrollBottom, this._onScrolledFullTop);

  void initListener() {
    addListener(handleListener);
  }

  void disposeListener() {
    removeListener(handleListener);
  }

  void handleListener() {
    if (position.pixels == position.minScrollExtent) {
      _onScrolledFullTop.call();
    }

    switch (position.userScrollDirection) {
      case ScrollDirection.idle:
        break;
      case ScrollDirection.forward:
        if (!_isTopScroll) {
          _onScrollTop.call();
          _isTopScroll = true;
          _isBottomScroll = false;
        }
        break;
      case ScrollDirection.reverse:
        if (!_isBottomScroll) {
          _onScrollBottom.call();
          _isTopScroll = false;
          _isBottomScroll = true;
        }
        break;
    }
  }
}
