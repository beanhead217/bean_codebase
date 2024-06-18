import 'dart:ui';

class IntervalTick {
  late int interval; // in Milliseconds
  final VoidCallback? tick;
  double _currentTime = 0;
  late double _intervalSeconds;
  IntervalTick(this.interval, {this.tick}) {
    _intervalSeconds = interval / 1000;
  }

  bool update(double dt) {
    _currentTime += dt;
    if (_currentTime >= _intervalSeconds) {
      tick?.call();
      _currentTime = 0;
      return true;
    }
    return false;
  }
}

mixin IntervalChecker {
  /// Map available to store times that can be used to control the frequency of any action.
  Map<String, IntervalTick>? _timers;

  /// Returns true if for each time the defined millisecond interval passes.
  /// Like a `Timer.periodic`
  /// Used in flows involved in the [update]
  bool checkInterval(
      String key,
      int intervalInMilli,
      double dt, {
        bool firstCheckIsTrue = true,
      }) {
    _timers ??= {};
    if (_timers![key]?.interval != intervalInMilli) {
      _timers![key] = IntervalTick(intervalInMilli);
      return firstCheckIsTrue;
    } else {
      return _timers![key]?.update(dt) ?? false;
    }
  }
}
