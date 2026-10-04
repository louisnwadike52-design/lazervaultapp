import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'impersonation_session.dart';

/// The always-visible "you are viewing someone else's account" bar.
///
/// Wraps the whole app below the navigator, so it renders over every screen —
/// an admin who forgets they are impersonating will read another person's
/// balance as their own, and this bar is the only thing preventing that.
///
/// Deliberately NOT dismissible. A banner you can close is a banner that is
/// closed exactly when it matters.
class ImpersonationBannerHost extends StatelessWidget {
  const ImpersonationBannerHost({
    super.key,
    required this.session,
    required this.onExit,
    required this.child,
  });

  final ImpersonationSession session;
  final Future<void> Function() onExit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ImpersonationState>(
      valueListenable: session,
      builder: (context, state, _) {
        if (!state.active) return child;
        return Directionality(
          // The host sits above MaterialApp's own Directionality in some
          // shells, so it provides its own rather than throwing.
          textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
          child: Column(
            children: [
              _Bar(state: state, onExit: onExit),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.state, required this.onExit});

  final ImpersonationState state;
  final Future<void> Function() onExit;

  @override
  Widget build(BuildContext context) {
    final minutes = state.minutesRemaining;
    return Material(
      // Amber, not red: red reads as "something is broken". This is a
      // deliberate state the admin chose, and it needs to be unmissable
      // without looking like an error.
      color: const Color(0xFFB45309),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              Icon(Icons.visibility_outlined,
                  size: 16.sp, color: Colors.white),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Viewing ${state.targetLabel}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      // Says READ-ONLY explicitly. The server refuses every
                      // write, so an admin who expects to be able to fix
                      // something needs to know before they try.
                      minutes > 0
                          ? 'Read-only · ends in ${minutes}m'
                          : 'Read-only · ending now',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              TextButton(
                onPressed: onExit,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF7C2D12),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  minimumSize: Size(0, 30.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
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
