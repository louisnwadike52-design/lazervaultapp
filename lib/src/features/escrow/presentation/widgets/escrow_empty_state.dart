import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/escrow_theme.dart';

/// Empty / error state widget for the Escrow feature.
///
/// Displays a centered gradient-circle icon, title, description, and an
/// optional CTA button. Mirrors MoveEmptyState styling but uses the escrow
/// violet accent.
class EscrowEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onAction;

  const EscrowEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionText,
    this.onAction,
  });

  /// "No deals yet" — first-run / all tab empty.
  const factory EscrowEmptyState.noDeals({Key? key, VoidCallback? onAction}) =
      _EscrowNoDealsEmptyState;

  /// "Nothing you're buying" — buyer tab empty.
  const factory EscrowEmptyState.noBuying({Key? key, VoidCallback? onAction}) =
      _EscrowNoBuyingEmptyState;

  /// "Nothing you're selling" — seller tab empty.
  const factory EscrowEmptyState.noSelling({Key? key, VoidCallback? onAction}) =
      _EscrowNoSellingEmptyState;

  /// Error / load failure with a Retry CTA.
  const factory EscrowEmptyState.error({Key? key, required VoidCallback onRetry}) =
      _EscrowErrorEmptyState;

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
                    EscrowTheme.primary.withValues(alpha: 0.18),
                    EscrowTheme.primary.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: EscrowTheme.primary.withValues(alpha: 0.25),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 44.sp,
                  color: EscrowTheme.primary,
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
                    color: EscrowTheme.primary,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: EscrowTheme.primary.withValues(alpha: 0.3),
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

class _EscrowNoDealsEmptyState extends EscrowEmptyState {
  const _EscrowNoDealsEmptyState({super.key, super.onAction})
      : super(
          icon: Icons.handshake_outlined,
          title: 'No Escrow Deals Yet',
          description:
              'Buy or sell safely — funds are held in escrow and only released when both sides are happy. Start your first deal.',
          actionText: 'Create a Deal',
        );
}

class _EscrowNoBuyingEmptyState extends EscrowEmptyState {
  const _EscrowNoBuyingEmptyState({super.key, super.onAction})
      : super(
          icon: Icons.shopping_bag_outlined,
          title: 'Nothing You\'re Buying',
          description:
              'Deals where you pay and funds are held until you confirm delivery will appear here.',
          actionText: 'Start a Purchase',
        );
}

class _EscrowNoSellingEmptyState extends EscrowEmptyState {
  const _EscrowNoSellingEmptyState({super.key, super.onAction})
      : super(
          icon: Icons.sell_outlined,
          title: 'Nothing You\'re Selling',
          description:
              'Deals where a buyer pays into escrow and you deliver to get paid will appear here.',
          actionText: 'Create a Deal',
        );
}

class _EscrowErrorEmptyState extends EscrowEmptyState {
  const _EscrowErrorEmptyState({super.key, required VoidCallback onRetry})
      : super(
          icon: Icons.error_outline,
          title: 'Couldn\'t Load Deals',
          description:
              'Something went wrong while fetching your escrow deals. Please try again.',
          actionText: 'Retry',
          onAction: onRetry,
        );
}
