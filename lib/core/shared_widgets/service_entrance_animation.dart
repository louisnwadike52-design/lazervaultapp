import 'package:flutter/material.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// Entrance animation for quick-service landing screens.
///
/// On first mount the wrapped content **slides up from below + fades in** —
/// the same effect the Insurance landing uses. Wrap the CONTENT AREA (the part
/// below the static header/app bar), NOT the header, so the header stays put
/// while the content rises into place.
///
/// Admin-toggleable: when [FeatureFlags.serviceEntranceAnimation] is OFF (or an
/// explicit [enabled] `false` is passed) the child renders immediately with no
/// animation and no controllers created — zero overhead when disabled.
///
/// Defaults match the Insurance landing (`insurance_list_screen`): fade 600ms,
/// slide 800ms from `Offset(0, 0.3)` → `Offset.zero`, both `Curves.easeOut`.
class ServiceEntranceAnimation extends StatefulWidget {
  final Widget child;

  /// Overrides the admin flag when non-null (mainly for tests / one-off screens).
  final bool? enabled;

  final Duration fadeDuration;
  final Duration slideDuration;
  final Offset beginOffset;

  const ServiceEntranceAnimation({
    super.key,
    required this.child,
    this.enabled,
    this.fadeDuration = const Duration(milliseconds: 600),
    this.slideDuration = const Duration(milliseconds: 800),
    this.beginOffset = const Offset(0, 0.3),
  });

  @override
  State<ServiceEntranceAnimation> createState() =>
      _ServiceEntranceAnimationState();
}

class _ServiceEntranceAnimationState extends State<ServiceEntranceAnimation>
    with TickerProviderStateMixin {
  AnimationController? _fadeController;
  AnimationController? _slideController;
  Animation<double>? _fade;
  Animation<Offset>? _slide;
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    _animate = widget.enabled ?? FeatureFlags.serviceEntranceAnimation;
    if (!_animate) return;

    _fadeController =
        AnimationController(duration: widget.fadeDuration, vsync: this);
    _slideController =
        AnimationController(duration: widget.slideDuration, vsync: this);

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController!, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController!, curve: Curves.easeOut),
    );

    _fadeController!.forward();
    _slideController!.forward();
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    _slideController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_animate) return widget.child;
    return SlideTransition(
      position: _slide!,
      child: FadeTransition(opacity: _fade!, child: widget.child),
    );
  }
}
