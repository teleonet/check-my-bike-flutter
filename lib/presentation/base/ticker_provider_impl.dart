import 'package:flutter/scheduler.dart';

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return TickerImpl((elapsed) {
        elapsed.toString();
    });
  }
}

class TickerImpl extends Ticker {
  TickerImpl(TickerCallback onTick) : super(onTick);
}
