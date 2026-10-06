import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Rounded back button used on the gradient headers.
///
/// THE TAP TARGET USED TO BE THE ICON ITSELF. The GestureDetector sat INSIDE
/// the padded Container and wrapped only an 18px Icon, so the padding around it
/// was dead space and the button answered to roughly an 18×18 area — which is
/// why it took two or three attempts to go back.
///
/// Now the gesture wraps the whole thing, the box is held to the 48×48 minimum
/// a finger can reliably hit, and `HitTestBehavior.opaque` means the transparent
/// padding counts as part of the button rather than letting taps fall through.
/// An InkWell replaces the bare GestureDetector so a press is visibly
/// acknowledged — with no ripple there was no way to tell a missed tap from a
/// slow screen.
class BackNavigator extends StatelessWidget {
  final VoidCallback? onPressed;

  /// Minimum tap target. 48dp is the Material accessibility floor, and the
  /// reason this is in LOGICAL pixels rather than `.w` is that a small screen
  /// must not be allowed to scale it back down below a finger.
  static const double _minTapTarget = 48.0;

  const BackNavigator({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
            return;
          }
          // Only pop when there IS something to pop. Calling Get.back() on the
          // first route does nothing and leaves the button looking broken.
          if (Navigator.of(context).canPop()) {
            Get.back();
          }
        },
        customBorder: const CircleBorder(),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: _minTapTarget,
            minHeight: _minTapTarget,
          ),
          padding: EdgeInsets.all(8.0.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Center(
            child:
                Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }
}
