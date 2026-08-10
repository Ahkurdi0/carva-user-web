import 'dart:async';

typedef AppDebounceCallback = void Function();

class _AppDebounceOperation {
  AppDebounceCallback callback;
  Timer timer;
  _AppDebounceOperation(this.callback, this.timer);
}

class AppDebounce {
  static final Map<String, _AppDebounceOperation> _operations = {};

  static void debounce(
    String tag,
    Duration duration,
    AppDebounceCallback onExecute,
  ) {
    if (duration == Duration.zero) {
      _operations[tag]?.timer.cancel();
      _operations.remove(tag);
      onExecute();
    } else {
      _operations[tag]?.timer.cancel();

      _operations[tag] = _AppDebounceOperation(
        onExecute,
        Timer(duration, () {
          _operations[tag]?.timer.cancel();
          _operations.remove(tag);

          onExecute();
        }),
      );
    }
  }

  static void fire(String tag) {
    _operations[tag]?.callback();
  }

  static void cancel(String tag) {
    _operations[tag]?.timer.cancel();
    _operations.remove(tag);
  }

  static void cancelAll() {
    for (final operation in _operations.values) {
      operation.timer.cancel();
    }
    _operations.clear();
  }

  static int count() {
    return _operations.length;
  }
}
