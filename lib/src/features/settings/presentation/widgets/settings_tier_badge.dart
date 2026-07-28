import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';

/// Compact, color-coded KYC tier pill for the settings profile header.
/// On the final tier (Tier 3, approved) it also renders a "Verified" badge.
/// Owns its own [KYCCubit] and loads the status once for [userId].
class SettingsTierBadge extends StatelessWidget {
  final String userId;

  /// Render for a dark/coloured background (e.g. the My Account purple header):
  /// solid white pills with the tier colour as text so they stay legible.
  final bool onDark;

  const SettingsTierBadge({super.key, required this.userId, this.onDark = false});

  @override
  Widget build(BuildContext context) {
    if (userId.isEmpty) return const SizedBox.shrink();
    return BlocProvider(
      create: (_) => serviceLocator<KYCCubit>()..getKYCStatus(userId),
      child: _TierBadgeView(onDark: onDark),
    );
  }
}

class _TierBadgeView extends StatelessWidget {
  final bool onDark;
  const _TierBadgeView({required this.onDark});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KYCCubit, KYCState>(
      builder: (context, state) {
        if (state is! KYCStatusLoaded) {
          // Keep the header stable while loading/erroring — no noisy placeholder.
          return const SizedBox.shrink();
        }
        final tier = state.profile.currentTier;
        final status = state.profile.status;
        if (tier == KYCTier.unknown) return const SizedBox.shrink();

        final spec = _specFor(tier);
        final isFinalVerified =
            tier == KYCTier.tier3 && status == KYCStatus.approved;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _pill(spec.label, spec.color, spec.icon),
            if (isFinalVerified) ...[
              SizedBox(width: 6.w),
              _verifiedBadge(),
            ],
          ],
        );
      },
    );
  }

  Widget _pill(String label, Color color, IconData icon) {
    // On dark: solid white pill, tier colour for icon/text (high contrast on
    // the purple header). On light: faint tinted pill with a coloured border.
    final bgColor = onDark ? Colors.white : color.withValues(alpha: 0.12);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
        border: onDark ? null : Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verifiedBadge() {
    const color = Color(0xFF10B981);
    final bgColor = onDark ? Colors.white : color.withValues(alpha: 0.12);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_rounded, size: 12.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            'Verified',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  _TierSpec _specFor(KYCTier tier) {
    switch (tier) {
      case KYCTier.tier1:
        return const _TierSpec('Tier 1', Color(0xFF3B82F6), Icons.shield_outlined);
      case KYCTier.tier2:
        return const _TierSpec('Tier 2', Color(0xFFFB923C), Icons.verified_user_outlined);
      case KYCTier.tier3:
        return const _TierSpec('Tier 3', Color(0xFF10B981), Icons.workspace_premium_outlined);
      case KYCTier.unknown:
        return const _TierSpec('Unverified', Color(0xFF9CA3AF), Icons.shield_outlined);
    }
  }
}

class _TierSpec {
  final String label;
  final Color color;
  final IconData icon;
  const _TierSpec(this.label, this.color, this.icon);
}
