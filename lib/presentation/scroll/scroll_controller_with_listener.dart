import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class ScrollControllerWithListener extends ScrollController {
  final Function? onScrolledTop;
  final Function? onScrolledBottom;
  final Function? onScrollTop;
  final Function? onScrollBottom;

  bool _isTopScroll = false;
  bool _isBottomScroll = false;

  ScrollControllerWithListener(
      {this.onScrollTop, this.onScrollBottom, this.onScrolledTop, this.onScrolledBottom});

  void initListener() {
    addListener(handleListener);
  }

  void disposeListener() {
    removeListener(handleListener);
  }

  void handleListener() {
    if (position.pixels == position.minScrollExtent) {
      onScrolledTop?.call();
    }

    if (position.pixels == position.maxScrollExtent) {
      onScrolledBottom?.call();
    }

    switch (position.userScrollDirection) {
      case ScrollDirection.idle:
        break;
      case ScrollDirection.forward:
        if (!_isTopScroll) {
          onScrollTop?.call();
          _isTopScroll = true;
          _isBottomScroll = false;
        }
        break;
      case ScrollDirection.reverse:
        if (!_isBottomScroll) {
          onScrollBottom?.call();
          _isTopScroll = false;
          _isBottomScroll = true;
        }
        break;
    }
  }
}
