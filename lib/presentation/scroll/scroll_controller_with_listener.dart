import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class ScrollControllerWithListener extends ScrollController {
  Function? onScrolledTop;
  Function? onScrolledBottom;
  Function? onScrollingTop;
  Function? onScrollingBottom;

  bool _isTopScrolling = false;
  bool _isBottomScrolling = false;

  double _lastVisiblePosition = 0.0;

  ScrollControllerWithListener(
      {this.onScrollingTop, this.onScrollingBottom, this.onScrolledTop, this.onScrolledBottom}) {
    addListener(handleListener);
  }

  void addScrolledBottomListener(Function? onScrolledBottom) {
    this.onScrolledBottom = onScrolledBottom;
  }

  void addScrolledTopListener(Function? onScrolledTop) {
    this.onScrolledTop = onScrolledTop;
  }

  void addScrollingTopListener(Function? onScrollingTop) {
    this.onScrollingTop = onScrollingTop;
  }

  void addScrollingBottomListener(Function? onScrollingBottom) {
    this.onScrollingBottom = onScrollingBottom;
  }

  void scrollToLastVisiblePosition() {
    jumpTo(_lastVisiblePosition);
  }

  @override
  void dispose() {
    removeListener(handleListener);
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
        if (!_isTopScrolling) {
          onScrollingTop?.call();
          _isTopScrolling = true;
          _isBottomScrolling = false;
        }
        break;
      case ScrollDirection.reverse:
        if (!_isBottomScrolling) {
          onScrollingBottom?.call();
          _isTopScrolling = false;
          _isBottomScrolling = true;
        }
        break;
    }
  }
}
