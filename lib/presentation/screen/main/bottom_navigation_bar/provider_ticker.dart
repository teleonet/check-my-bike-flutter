import 'package:flutter/scheduler.dart';

class ProviderTicker extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
