part of 'voice_transfer_hud.dart';

/// Dark glassy frame with thin neon borders + outer glow + a top scanline.
class _HudFrame extends StatelessWidget {
  final Color accent;
  final Widget child;
  const _HudFrame({required this.accent, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF14111F),
            Color(0xFF0C0B12),
          ],
        ),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.22),
            blurRadius: 24,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Scanline accent — a faint gradient line across the top edge.
          Positioned(
            top: 0,
            left: 8.w,
            right: 8.w,
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accent.withValues(alpha: 0.0),
                    accent.withValues(alpha: 0.7),
                    accent.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Faint blue corner accent (second neon colour) bottom-right.
          if (accent != VoiceTransferHud._blue)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40.w,
                height: 1.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      VoiceTransferHud._blue.withValues(alpha: 0.0),
                      VoiceTransferHud._blue.withValues(alpha: 0.55),
                    ],
                  ),
                ),
              ),
            ),
          Padding(padding: EdgeInsets.only(top: 4.h), child: child),
        ],
      ),
    );
  }
}

/// Recipient panel — circular profile picture (or initials disc) + name/@user.
class _RecipientPanel extends StatelessWidget {
  final VoiceTransferContext context;
  final Color accent;
  const _RecipientPanel({required this.context, required this.accent});

  @override
  Widget build(BuildContext ctx) {
    final c = context;
    final avatarUrl = c.recipientAvatarUrl;
    return Row(
      children: [
        // Avatar — animate in with a scale/fade.
        TweenAnimationBuilder<double>(
          key: ValueKey('avatar_${c.recipientName}_${c.recipientUsername}'),
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutBack,
          builder: (context, t, child) => Transform.scale(
            scale: 0.6 + (t.clamp(0.0, 1.0) * 0.4),
            child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
          ),
          child: Container(
            width: 46.w,
            height: 46.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: VoiceTransferHud._purple.withValues(alpha: 0.18),
              border: Border.all(
                color: VoiceTransferHud._purple.withValues(alpha: 0.55),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: VoiceTransferHud._purple.withValues(alpha: 0.30),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: ClipOval(
              child: (avatarUrl != null && avatarUrl.isNotEmpty)
                  ? Image.network(
                      avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _initials(c),
                    )
                  : _initials(c),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                c.recipientName ?? c.recipientUsername ?? 'Recipient',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              if ((c.recipientUsername ?? '').isNotEmpty) ...[
                SizedBox(height: 2.h),
                Text(
                  '@${c.recipientUsername}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoMono(
                    color: VoiceTransferHud._purple.withValues(alpha: 0.85),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _initials(VoiceTransferContext c) {
    return Container(
      alignment: Alignment.center,
      color: VoiceTransferHud._purple.withValues(alpha: 0.12),
      child: Text(
        c.recipientInitials,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// A single glowing "data row" inside the HUD box.
class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasized;
  final bool mono;
  const _DataRow({
    required this.label,
    required this.value,
    this.emphasized = false,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: emphasized
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.03),
        border: Border.all(
          color: emphasized
              ? VoiceTransferHud._blue.withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.07),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: Colors.white.withValues(alpha: 0.40),
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: (mono ? GoogleFonts.robotoMono : GoogleFonts.inter)(
                color: emphasized
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.88),
                fontSize: emphasized ? 14.sp : 12.5.sp,
                fontWeight: emphasized ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated count-up Naira value. Animates from the previously-shown value to
/// the new one whenever [value] changes (e.g. amount appears / updates).
class _AnimatedNaira extends StatelessWidget {
  final double value;
  final String currency;
  final Color color;
  final double fontSize;
  const _AnimatedNaira({
    required this.value,
    required this.currency,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = currency == 'NGN' ? '₦' : '$currency ';
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            '$symbol${NumberFormat('#,##0.00').format(v)}',
            maxLines: 1,
            style: GoogleFonts.inter(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
        );
      },
    );
  }
}
