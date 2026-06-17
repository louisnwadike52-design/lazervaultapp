import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// Generic, user-friendly inline error state for a page/section.
///
/// Use this INSTEAD of a global error snackbar when a screen fails to load or an
/// action fails — the error stays on the page it belongs to (not floating over
/// the dashboard) and never shows raw gRPC/HTTP text. Pair with a Cubit error
/// state:
///
/// ```dart
/// builder: (context, state) => switch (state) {
///   SomethingError(:final error) => AppErrorView(
///       error: error,                 // mapped to a friendly line for you
///       context: 'load your budgets',
///       onRetry: () => cubit.load(),
///     ),
///   ...
/// }
/// ```
class AppErrorView extends StatelessWidget {
  /// The raw caught error — mapped to a friendly message via [friendlyError].
  /// Provide either this or [message].
  final Object? error;

  /// An explicit already-friendly message. Overrides [error] when set.
  final String? message;

  /// Optional verb phrase for the generic line, e.g. "load your transfers".
  final String? context;

  /// Retry callback — when null, the retry button is hidden.
  final VoidCallback? onRetry;

  /// Retry button label.
  final String retryLabel;

  /// Compact variant for small inline sections (smaller icon, no full-height
  /// centering). Defaults to the full centered state.
  final bool compact;

  const AppErrorView({
    super.key,
    this.error,
    this.message,
    this.context,
    this.onRetry,
    this.retryLabel = 'Try again',
    this.compact = false,
  });

  @override
  Widget build(BuildContext buildContext) {
    final text = message ?? friendlyError(error, context: context);

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: compact ? 56.w : 96.w,
          height: compact ? 56.w : 96.w,
          decoration: BoxDecoration(
            color: const Color(0xFFFB923C).withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.error_outline_rounded,
            size: compact ? 28.sp : 44.sp,
            color: const Color(0xFFFB923C),
          ),
        ),
        SizedBox(height: compact ? 12.h : 20.h),
        if (!compact)
          Text(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        if (!compact) SizedBox(height: 8.h),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: compact ? 13.sp : 14.sp,
            height: 1.4,
          ),
        ),
        if (onRetry != null) ...[
          SizedBox(height: compact ? 14.h : 24.h),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded, color: Colors.white, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    retryLabel,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );

    if (compact) {
      return Padding(padding: EdgeInsets.all(16.w), child: content);
    }
    return Center(
      child: Padding(padding: EdgeInsets.all(32.w), child: content),
    );
  }
}
