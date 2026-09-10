import 'package:shake/shake.dart';

/// Fires [onDoubleShake] when the phone is shaken TWICE inside [window].
///
/// A single shake is not a gesture — phones get jolted in pockets, cars and
/// hands, and a one-shake trigger would fire on all of them. Requiring a second
/// shake inside a short window is what makes it deliberate. Panic Balance on the
/// dashboard established this pattern; this class exists so the counting lives
/// in one place instead of being re-derived per call site.
///
/// [enabled] is consulted on every shake rather than at construction, so the
/// caller can flip the feature off without tearing the detector down. A partial
/// sequence is dropped whenever it reports false, so a first shake taken while
/// the feature was on cannot combine with a later one to fire after it was
/// turned off.
class DoubleShakeDetector {
  static const Duration defaultWindow = Duration(milliseconds: 1500);

  final bool Function() enabled;
  final void Function() onDoubleShake;
  final Duration window;

  ShakeDetector? _detector;
  int _count = 0;
  int _firstMs = 0;

  DoubleShakeDetector({
    required this.enabled,
    required this.onDoubleShake,
    this.window = defaultWindow,
  });

  /// Begin listening. Safe to call more than once; later calls are no-ops, so a
  /// rebuild cannot stack two accelerometer subscriptions.
  void start() {
    if (_detector != null) return;
    _detector = ShakeDetector.autoStart(onPhoneShake: (_) => _onShake());
  }

  void _onShake() {
    if (!enabled()) {
      _reset(); // never carry a stale first shake across a disable
      return;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    // Start, or restart, the sequence: either this is the first shake or the
    // window since the first one has already elapsed.
    if (_count == 0 || now - _firstMs > window.inMilliseconds) {
      _count = 1;
      _firstMs = now;
      return;
    }
    // Second qualifying shake — fire once, then reset so the next trigger
    // needs two fresh shakes rather than one more.
    _reset();
    onDoubleShake();
  }

  void _reset() {
    _count = 0;
    _firstMs = 0;
  }

  /// Stop listening and release the accelerometer stream. Idempotent, so a
  /// dispose after an early return in initState cannot throw.
  void dispose() {
    _detector?.stopListening();
    _detector = null;
    _reset();
  }
}
