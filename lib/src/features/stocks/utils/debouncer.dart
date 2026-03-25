import 'dart:async';
import 'package:flutter/foundation.dart';

/// Debouncer utility for delaying function execution until a pause in calls
/// Useful for search input to avoid excessive API calls
class Debouncer {
  final Duration delay;
  Timer? _timer;
  VoidCallback? _lastCallback;

  Debouncer({required this.delay});

  /// Call this with the action to debounce
  /// If called multiple times within the delay period, only the last action is executed
  void call(VoidCallback action) {
    _lastCallback = action;
    _timer?.cancel();
    _timer = Timer(delay, () {
      if (_lastCallback != null) {
        _lastCallback!.call();
        _lastCallback = null;
      }
    });
  }

  /// Cancel any pending debounced action
  void cancel() {
    _timer?.cancel();
    _timer = null;
    _lastCallback = null;
  }

  /// Dispose the debouncer
  void dispose() {
    cancel();
  }
}

/// Factory for creating common debouncers
class Debouncers {
  /// 300ms debounce for search input - fast enough for responsive UI,
  /// slow enough to avoid excessive API calls
  static final search = Debouncer(delay: const Duration(milliseconds: 300));

  /// 500ms debounce for form validation and auto-save
  static final form = Debouncer(delay: const Duration(milliseconds: 500));

  /// 100ms debounce for button clicks (prevent double-tap)
  static final button = Debouncer(delay: const Duration(milliseconds: 100));
}
