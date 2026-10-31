import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The fixed "More" tile that ends the FIRST page of the quick-services grid.
///
/// WHY IT EXISTS
/// -------------
/// The services carousel held two or three pages, and the only things saying so
/// were a row of dots under it and the fact that a horizontal swipe worked. A
/// user who never tried the swipe never learned the second page existed, so
/// half the platform's services were effectively undiscoverable from the
/// dashboard. The dots are feedback, not an invitation.
///
/// This tile puts the invitation inside the grid, in the cell the next service
/// would have occupied — the place the user is already looking when they are
/// scanning for a service. Tapping it advances the carousel, so the gesture it
/// teaches is the one it performs.
///
/// WHY IT LOOKS DIFFERENT FROM A SERVICE TILE
/// ------------------------------------------
/// Same geometry — 32.w disc, 10.sp label, same padding and radius — so the
/// grid stays even and nothing shifts. But the disc is FILLED brand rather
/// than the 10%/5% tint the service tiles use, because this is a control, not
/// a destination. A tile that looked exactly like a service would read as a
/// service called "More", and tapping it would feel like a mis-navigation
/// rather than a page turn.
class QuickServicesMoreTile extends StatefulWidget {
  const QuickServicesMoreTile({
    super.key,
    required this.onTap,
    this.label = 'More',
    this.remainingCount,
  });

  /// Advance the carousel. Supplied by the grid so this widget owns no
  /// controller and can be driven by a test with a plain closure.
  final VoidCallback onTap;

  final String label;

  /// How many services sit on the pages after this one.
  ///
  /// Rendered as a small count so the tile promises something specific — "14
  /// more" is a reason to tap, "More" alone is a guess. Null hides it, which
  /// is what happens if the number cannot be known.
  final int? remainingCount;

  @override
  State<QuickServicesMoreTile> createState() => _QuickServicesMoreTileState();
}

class _QuickServicesMoreTileState extends State<QuickServicesMoreTile> {
  static const _brand = Color.fromARGB(255, 78, 3, 208);

  bool _pressed = false;

  void _handleTap() {
    // The same selectionClick the drag-to-edge page flip uses, so a page turn
    // feels identical however it was asked for.
    HapticFeedback.selectionClick();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      // Spelled out for screen readers: "More" on its own does not say what
      // happens, and this is the control that reveals the rest of the grid.
      label: widget.remainingCount != null && widget.remainingCount! > 0
          ? 'Show ${widget.remainingCount} more services'
          : 'Show more services',
      child: GestureDetector(
        onTap: _handleTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 3.w),
          decoration: BoxDecoration(
            color: _pressed ? _brand.withValues(alpha: 0.05) : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: _pressed
                    ? _brand.withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: _pressed ? 12 : 6,
                offset: Offset(0, _pressed ? 6 : 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_brand, Color.fromARGB(255, 57, 2, 111)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  // Forward, not an ellipsis: it matches the "View All →"
                  // chevron in this section's own header, and it says which
                  // direction the carousel will move.
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: _pressed ? _brand : Colors.black87,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
