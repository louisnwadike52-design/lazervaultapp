import 'package:flutter/widgets.dart';

/// Computes a non-zero [Rect] in the coordinate space of the root view to anchor
/// the iOS/iPadOS share-sheet popover. Prefer passing the tapped widget's
/// [BuildContext]; falls back to the screen centre when a render box is
/// unavailable (share_plus rejects a zero rect on iOS/iPad).
Rect shareOriginFromContext(BuildContext context) {
  final box = context.findRenderObject();
  if (box is RenderBox && box.hasSize) {
    final topLeft = box.localToGlobal(Offset.zero);
    final rect = topLeft & box.size;
    if (rect.width > 0 && rect.height > 0) {
      return rect;
    }
  }
  final size = MediaQuery.maybeOf(context)?.size ?? const Size(400, 800);
  return Rect.fromCenter(
    center: Offset(size.width / 2, size.height / 2),
    width: 1,
    height: 1,
  );
}
