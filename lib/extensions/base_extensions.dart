extension ObjectExtenstion<T> on T {
  isNotNull<R>(Function(R value) function, {Function? otherwise}) {
    if (this != null) {
      function.call(this as R);
    } else {
      otherwise?.call();
    }
  }
}