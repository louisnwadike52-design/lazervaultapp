import 'package:flutter/widgets.dart';

/// Where the system share sheet should anchor itself.
///
/// On iPad (and iOS in some presentations) the share sheet is a popover, and
/// UIKit needs a source rectangle to point it at. Given none, the sheet can
/// fail to present at all — the tap does nothing, no error, no dialog. That is
/// the whole symptom of "share is not working": the call succeeds, the sheet
/// never appears.
///
/// This lived as a static on two unrelated service classes (a PDF service and a
/// crowdfund report service), so every new share site either imported something
/// irrelevant or quietly shipped without an origin. It belongs here.
class ShareOrigin {
  ShareOrigin._();

  /// The rect of the widget that was tapped, in global coordinates.
  ///
  /// Must be captured BEFORE any `Navigator.pop` — popping destroys the render
  /// box and this starts returning null, which is exactly how a share button
  /// inside a dismissing sheet loses its anchor.
  static Rect? fromContext(BuildContext context) {
    final obj = context.findRenderObject();
    if (obj is RenderBox && obj.hasSize) {
      return obj.localToGlobal(Offset.zero) & obj.size;
    }
    return null;
  }

  /// A rect that is always safe to hand to the platform.
  ///
  /// Falls back to a 1×1 rect at the origin rather than null or `Rect.zero`: a
  /// degenerate rect anchors the popover in the corner, which looks slightly
  /// odd but still presents. Null does not present at all, and presenting
  /// imperfectly beats a button that appears broken.
  static Rect resolve(Rect? origin) {
    if (origin == null || origin.width <= 0 || origin.height <= 0) {
      return const Rect.fromLTWH(0, 0, 1, 1);
    }
    return origin;
  }

  /// Convenience for the common case: resolve straight from a context.
  static Rect of(BuildContext context) => resolve(fromContext(context));
}
