import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared chrome for the banking-channel screens, in the app's own styling.
///
/// WHY THIS EXISTS
/// ---------------
/// WhatsApp Banking and Phone Banking are two Quick Services, and they were one
/// screen wearing a `channelType` parameter. That is not a separation: the two
/// channels have different rules (a WhatsApp number is changeable, a telephony
/// number is pinned to your profile), different settings, and different failure
/// modes, and a single screen forced them to pretend otherwise.
///
/// They are now two screens. This holds only what is genuinely COMMON — the
/// gradient header, the page ground, the card and section primitives — so that
/// "shared chrome" never quietly grows back into "shared behaviour".
///
/// The vocabulary is lifted from Split Bill / Send Funds rather than invented:
/// same page ground, same brand gradient header with a circular back button,
/// same `0xFF1F1F1F` cards.
class ChannelScreenTheme {
  ChannelScreenTheme._();

  static const Color pageBg = Color(0xFF0A0A0A);
  static const Color card = Color(0xFF1F1F1F);
  static const Color border = Color(0xFF2A2A2A);
  static const Color brand = Color(0xFF4834D4);
  static const Color brandDeep = Color(0xFF2D2B6B);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color success = Color(0xFF10B981);
  static const Color danger = Color(0xFFEF4444);
  static const Color warn = Color(0xFFFB923C);
}

/// The gradient header. [accent] lets each channel carry its own identity
/// colour (WhatsApp green, telephony purple) while the shape stays identical,
/// so the two screens read as siblings rather than as one screen with a
/// different title.
class ChannelHeader extends StatelessWidget {
  const ChannelHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.accent,
    this.onBack,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color? accent;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    final a = accent ?? ChannelScreenTheme.brand;
    return Container(
      padding: EdgeInsets.fromLTRB(16, top + 12, 16, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [a, ChannelScreenTheme.brandDeep],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: a.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Material(
            color: Colors.white.withValues(alpha: 0.12),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
              child: const SizedBox(
                width: 38,
                height: 38,
                child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.82),
                        fontSize: 12)),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// A titled block. Sections carry an optional [caption] because these screens
/// are full of controls whose consequences are not obvious from their label —
/// "who can bank from this number" deserves a sentence, not a guess.
class ChannelSection extends StatelessWidget {
  const ChannelSection({
    super.key,
    required this.title,
    required this.child,
    this.caption,
  });

  final String title;
  final String? caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              if (caption != null) ...[
                const SizedBox(height: 3),
                Text(caption!,
                    style: GoogleFonts.inter(
                        color: ChannelScreenTheme.textMuted,
                        fontSize: 11.5,
                        height: 1.35)),
              ],
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ChannelScreenTheme.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ChannelScreenTheme.border),
          ),
          child: child,
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

/// A settings row with a switch.
///
/// [enabled] false renders the row visibly inert AND explains itself via
/// [disabledReason]. A greyed-out control with no reason is the single most
/// common way a settings screen wastes someone's time.
class ChannelToggleTile extends StatelessWidget {
  const ChannelToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.enabled = true,
    this.disabledReason,
    this.busy = false,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final String? disabledReason;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final off = !enabled;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: off ? ChannelScreenTheme.textMuted : Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600)),
                if (subtitle != null || (off && disabledReason != null)) ...[
                  const SizedBox(height: 3),
                  Text(
                    off && disabledReason != null ? disabledReason! : subtitle!,
                    style: GoogleFonts.inter(
                        color: ChannelScreenTheme.textMuted,
                        fontSize: 11.5,
                        height: 1.35),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (busy)
            const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2))
          else
            Switch.adaptive(
              value: value,
              onChanged: enabled ? onChanged : null,
              activeThumbColor: ChannelScreenTheme.success,
            ),
        ],
      ),
    );
  }
}

/// Status pill for the channel's current state.
class ChannelStatusPill extends StatelessWidget {
  const ChannelStatusPill({super.key, required this.status});

  final String status;

  (Color, String) get _look => switch (status) {
        'active' => (ChannelScreenTheme.success, 'Active'),
        'pending' => (ChannelScreenTheme.warn, 'Awaiting verification'),
        'suspended' => (ChannelScreenTheme.danger, 'Suspended'),
        'deactivated' => (ChannelScreenTheme.textMuted, 'Switched off'),
        _ => (ChannelScreenTheme.textMuted, 'Not set up'),
      };

  @override
  Widget build(BuildContext context) {
    final (c, label) = _look;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.45)),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: c, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}
