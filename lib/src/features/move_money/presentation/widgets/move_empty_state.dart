import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Empty state widget for the Move Money feature.
///
/// Displays a centered icon, title, description, and optional CTA button.
/// Used for states like "no accounts linked" or "no transfers found."
class MoveEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onAction;

  const MoveEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionText,
    this.onAction,
  });

  /// Factory for the "no linked accounts" empty state.
  const factory MoveEmptyState.noAccounts({
    Key? key,
    VoidCallback? onLinkAccount,
  }) = _MoveNoAccountsEmptyState;

  /// Factory for the "no transfers found" empty state.
  const factory MoveEmptyState.noTransfers({
    Key? key,
    VoidCallback? onStartTransfer,
  }) = _MoveNoTransfersEmptyState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background circle
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    const Color(0xFF3B82F6).withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 44.sp,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            // Description
            Text(
              description,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            // CTA button
            if (actionText != null && onAction != null) ...[
              SizedBox(height: 28.h),
              GestureDetector(
                onTap: onAction,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    actionText!,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state for when no bank accounts are linked.
class _MoveNoAccountsEmptyState extends MoveEmptyState {
  const _MoveNoAccountsEmptyState({
    super.key,
    VoidCallback? onLinkAccount,
  }) : super(
          icon: Icons.account_balance_outlined,
          title: 'No Accounts Linked',
          description:
              'Link your bank accounts to start moving money between them.',
          actionText: 'Link Bank Account',
          onAction: onLinkAccount,
        );
}

/// Empty state for when no transfers are found.
class _MoveNoTransfersEmptyState extends MoveEmptyState {
  const _MoveNoTransfersEmptyState({
    super.key,
    VoidCallback? onStartTransfer,
  }) : super(
          icon: Icons.swap_horiz_rounded,
          title: 'No Transfers Yet',
          description:
              'Your move money transfer history will appear here once you make your first transfer.',
          actionText: 'Move Money',
          onAction: onStartTransfer,
        );
}
