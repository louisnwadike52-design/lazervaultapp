import 'dart:async';
import 'dart:ui';

/// A utility class for debouncing actions.
///
/// Debouncing ensures that a function is only executed after a specified
/// delay has passed since the last invocation. This is useful for search
/// inputs, form validation, and other scenarios where you want to avoid
/// excessive API calls or computations.
///
/// Example usage:
/// ```dart
/// final debouncer = Debouncer.search();
///
/// void onSearchChanged(String query) {
///   debouncer.run(() => performSearch(query));
/// }
///
/// @override
/// void dispose() {
///   debouncer.dispose();
///   super.dispose();
/// }
/// ```
class Debouncer {
  /// The delay in milliseconds before the action is executed.
  final int milliseconds;

  Timer? _timer;

  /// Creates a debouncer with the specified delay.
  ///
  /// [milliseconds] - The delay in milliseconds (default: 500ms)
  Debouncer({this.milliseconds = 500});

  /// Creates a debouncer optimized for search inputs (500ms delay).
  ///
  /// This delay provides a good balance between responsiveness and
  /// reducing unnecessary API calls on slow networks.
  factory Debouncer.search() => Debouncer(milliseconds: 500);

  /// Creates a debouncer optimized for typing/form validation (300ms delay).
  ///
  /// This shorter delay is suitable for quick feedback scenarios
  /// like character count updates or local validation.
  factory Debouncer.typing() => Debouncer(milliseconds: 300);

  /// Creates a debouncer optimized for real-time updates (100ms delay).
  ///
  /// Use sparingly - only for scenarios requiring near-immediate feedback.
  factory Debouncer.realtime() => Debouncer(milliseconds: 100);

  /// Creates a debouncer for network-sensitive operations (800ms delay).
  ///
  /// Use this for operations on slow networks where you want to minimize
  /// redundant requests even more aggressively.
  factory Debouncer.slowNetwork() => Debouncer(milliseconds: 800);

  /// Schedules an action to be executed after the debounce delay.
  ///
  /// If this method is called again before the delay expires,
  /// the previous scheduled action is cancelled and a new timer starts.
  ///
  /// [action] - The callback to execute after the delay.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Schedules an async action to be executed after the debounce delay.
  ///
  /// Similar to [run], but for async operations. Note that this doesn't
  /// await the async action - use [runAsync] with proper handling.
  void runAsync(Future<void> Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), () {
      action();
    });
  }

  /// Cancels any pending action.
  ///
  /// Call this when you want to stop a scheduled action from executing,
  /// for example when the user clears a search field.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Disposes of the debouncer and cancels any pending actions.
  ///
  /// Always call this in your widget's dispose method to prevent
  /// memory leaks and callbacks firing after widget disposal.
  void dispose() {
    cancel();
  }

  /// Whether there is a pending action scheduled.
  bool get isPending => _timer?.isActive ?? false;
}
