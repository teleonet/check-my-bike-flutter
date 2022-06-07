import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class ScrollControllerWithListener extends ScrollController {
  Function? onScrolledTop;
  Function? onScrolledBottom;
  Function? onScrollTop;
  Function? onScrollBottom;

  bool _isTopScroll = false;
  bool _isBottomScroll = false;

  double _lastVisiblePosition = 0.0;

  ScrollControllerWithListener(
      {this.onScrollTop, this.onScrollBottom, this.onScrolledTop, this.onScrolledBottom}) {
    initListener();
  }

  void addScrolledBottomListener(Function? onScrolledBottom) {
    this.onScrolledBottom = onScrolledBottom;
  }

  void addScrolledTopListener(Function? onScrolledTop) {
    this.onScrolledTop = onScrolledTop;
  }

  void addScrollTopListener(Function? onScrollTop) {
    this.onScrollTop = onScrollTop;
  }

  void addScrollBottomListener(Function? onScrollBottom) {
    this.onScrollBottom = onScrollBottom;
  }

  void initListener() {
    addListener(handleListener);
  }

  void disposeListener() {
    removeListener(handleListener);
  }

  @override
  void dispose() {
    disposeListener();
    super.dispose();
  }

  void handleListener() {
    _lastVisiblePosition = position.pixels;
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

  void scrollToLastVisiblePosition() {
    jumpTo(_lastVisiblePosition);
  }
}
