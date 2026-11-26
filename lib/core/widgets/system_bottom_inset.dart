import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// KEEP A BOTTOM BAR ABOVE THE PHONE'S OWN NAVIGATION BAR — ONCE, NOT TWICE.
///
/// ## The bug this was written for
///
/// Reported on Android: "the bottom navigation is under the system button, so
/// it overlaps" — the app's nav bar drawn beneath Samsung's back / home /
/// recents buttons, labels half-hidden, the first row of a bottom sheet's
/// buttons unreachable.
///
/// It is not a Samsung quirk and not a one-device bug. From Android 15
/// (API 35) the system IGNORES `windowDrawsSystemBarBackgrounds` and lays
/// every app out EDGE TO EDGE: the window now extends under the status bar and
/// under the navigation bar, and it is the app's job to inset its own chrome.
///
/// That is why it looked device-specific: the overlap is exactly the height of
/// whatever navigation the user has chosen. Gesture navigation leaves a ~24dp
/// handle and the damage is a trimmed label; three-button navigation leaves
/// ~48dp and swallows a whole row.
///
/// ## The bug that fixing it caused
///
/// Reported next: the bar sitting too HIGH, with a dead white band under it.
///
/// [MotionTabBar] takes `useSafeArea`, and it DEFAULTS TO TRUE — it wraps its
/// own content in `SafeArea(bottom: true)`. Wrapping it in this widget as well
/// inset the bar twice: once here, once inside the package, so the bar floated
/// a whole navigation-bar height above where it belonged. A `Padding` does not
/// consume what it pads; the child's `MediaQuery` still reported the full
/// bottom inset and the child dutifully applied it again.
///
/// ## The rule
///
/// **This widget is the only thing that insets.** It pads by the real inset,
/// PAINTS the padded strip so the bar reads as one continuous surface, and
/// then REMOVES the bottom padding from the MediaQuery it hands down — so a
/// child that applies a `SafeArea`, a `MediaQuery.padding.bottom`, or a
/// package that does it for you (today MotionTabBar, tomorrow whatever
/// replaces it) adds nothing on top. Correct by construction, for any child,
/// without each call site having to know what its child does internally.
///
/// `MediaQuery.padding.bottom` and not `viewPadding`: padding is viewPadding
/// minus whatever the keyboard has taken, so it collapses to zero when the
/// keyboard is up — which is correct, because the navigation bar is then
/// behind the keyboard and insetting for it would leave a dead band above the
/// keys. Inside a [Scaffold.bottomNavigationBar] the bottom padding is
/// deliberately NOT removed by the Scaffold, so this reads the true value.
///
/// ## The watchdog
///
/// Padding by a number the platform reports is right until a device reports
/// the wrong number — an OEM skin, a new Android, a foldable changing posture.
/// So this does not only trust the number: after layout it MEASURES where the
/// bar actually landed and compares it with where the system bar actually
/// starts. If the bar is overlapping, it pads by the measured difference and
/// says so in the log. See [_BottomInsetWatchdog].
class SystemBottomInset extends StatefulWidget {
  const SystemBottomInset({
    super.key,
    required this.child,
    this.background,
    this.minimum = 0,
    this.debugLabel,
  });

  final Widget child;

  /// Painted behind the bar AND behind the inset strip. Give it the bar's own
  /// colour; a null background leaves the strip transparent, which is right
  /// only when something else already paints there.
  final Color? background;

  /// A floor for devices that report no inset at all — an older Android with
  /// a hardware key row, or an emulator. Rarely needed.
  final double minimum;

  /// Names this bar in the watchdog's log line, so a report says WHICH bar
  /// was overlapping rather than just that one was.
  final String? debugLabel;

  @override
  State<SystemBottomInset> createState() => _SystemBottomInsetState();
}

class _SystemBottomInsetState extends State<SystemBottomInset>
    with WidgetsBindingObserver {
  /// The child's painted box, measured by the watchdog.
  final GlobalKey _childKey = GlobalKey();

  /// Extra padding the watchdog found necessary beyond the reported inset.
  /// Zero on every device that reports its inset correctly, which is almost
  /// all of them — this is a safety net, not the mechanism.
  double _measuredCorrection = 0;

  /// The metrics the correction was measured against. When the window
  /// changes — rotation, a fold, the user switching from gesture to
  /// three-button navigation — the correction is no longer evidence of
  /// anything and is dropped, so a transient measurement can never become a
  /// permanent gap.
  Size? _correctionEpoch;

  /// A bound on self-correction. Three-button navigation is ~48dp; anything
  /// past this is a measurement fault, and obeying it would push the bar up
  /// the screen rather than fix an overlap.
  static const double _maxCorrection = 64;

  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scheduleCheck();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Rotation, a fold, the keyboard, or the user changing navigation mode in
    // system settings — all arrive here. Re-measure against the new window.
    _scheduleCheck();
  }

  void _scheduleCheck() {
    if (_checkScheduled) return;
    _checkScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      if (mounted) _check();
    });
  }

  /// WHERE THE BAR ACTUALLY LANDED vs WHERE THE SYSTEM BAR ACTUALLY STARTS.
  ///
  /// Only ever INCREASES the correction within one metrics epoch. Relaxing it
  /// in place would oscillate: more padding removes the overlap, no overlap
  /// removes the padding, and the bar flickers for ever. A new epoch resets
  /// it to zero and the measurement starts again from the reported inset.
  void _check() {
    final box = _childKey.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;

    final media = MediaQuery.maybeOf(context);
    if (media == null) return;

    // The keyboard owns the bottom of the screen while it is up, and the
    // Scaffold has already lifted this bar clear of it. Measuring then would
    // compare the bar against a system bar that is not currently visible.
    if (media.viewInsets.bottom > 0) return;

    final screenHeight = media.size.height;
    final systemInset = media.viewPadding.bottom;
    if (screenHeight <= 0) return;

    final childBottom = box.localToGlobal(Offset(0, box.size.height)).dy;
    // Where the system navigation bar begins. Anything painted below this
    // line is under the phone's own buttons.
    final safeLine = screenHeight - systemInset;
    final overlap = childBottom - safeLine;

    // Half a logical pixel of slack: sub-pixel layout rounding is not an
    // overlap, and treating it as one would add a permanent hairline gap.
    if (overlap <= 0.5) return;

    final epoch = media.size;
    final sameEpoch = _correctionEpoch == epoch;
    final target =
        (sameEpoch ? _measuredCorrection : 0) + overlap;
    final bounded = target > _maxCorrection ? _maxCorrection : target;
    if (sameEpoch && bounded <= _measuredCorrection + 0.5) return;

    if (kDebugMode) {
      debugPrint('[system-bottom-inset] ${widget.debugLabel ?? 'bar'} was '
          '${overlap.toStringAsFixed(1)}dp under the system navigation bar '
          '(reported inset ${systemInset.toStringAsFixed(1)}dp, screen '
          '${screenHeight.toStringAsFixed(0)}dp). Correcting.');
    }

    setState(() {
      _measuredCorrection = bounded;
      _correctionEpoch = epoch;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // A new window means the previous measurement describes a layout that no
    // longer exists. Dropped here rather than in didChangeMetrics so it is
    // also dropped when the MediaQuery changes without a platform metrics
    // event (a parent overriding it, a test pumping a new size).
    if (_correctionEpoch != null && _correctionEpoch != media.size) {
      _measuredCorrection = 0;
      _correctionEpoch = null;
      _scheduleCheck();
    }

    final reported = media.padding.bottom;
    final base = reported > widget.minimum ? reported : widget.minimum;
    final bottom = base + _measuredCorrection;

    // The child sees NO bottom padding. This is the whole point: a child that
    // insets itself — SafeArea, a package's useSafeArea, a hand-rolled
    // MediaQuery read — then adds zero instead of a second navigation bar's
    // worth of empty space.
    Widget content = MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: KeyedSubtree(key: _childKey, child: widget.child),
    );

    if (bottom > 0) {
      content = Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: content,
      );
    }
    if (widget.background == null) return content;
    return ColoredBox(color: widget.background!, child: content);
  }
}

/// The same measurement, for a widget that already has a padding of its own to
/// add to — a bottom sheet whose content ends in `EdgeInsets.fromLTRB`.
///
/// Returns 0 while the keyboard is up, for the reason in [SystemBottomInset].
///
/// NOTE: inside a [SystemBottomInset] this returns 0, because that widget
/// removes the padding it has already applied. That is correct — the inset is
/// accounted for exactly once — and is why a nested call is harmless.
double systemBottomInset(BuildContext context) =>
    MediaQuery.paddingOf(context).bottom;
