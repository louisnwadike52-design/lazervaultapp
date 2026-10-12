import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// The avatar for a group or a contribution.
///
/// One widget for both so a goal and the group holding it never render
/// differently in the same list. The initials fallback is not a degraded
/// state — most rows will never have an uploaded image, and six goals in a
/// group previously drew six identical wallet glyphs with nothing to tell
/// them apart at a glance.
///
/// A broken or unreachable URL falls back to the same initials rather than
/// Flutter's grey error box: the image is decoration, and an avatar that
/// fails to load must not make the row look broken.
class GroupFundsAvatar extends StatelessWidget {
  /// Storage-service public URL. Null or empty draws initials.
  final String? imageUrl;

  /// What the initials come from — the group or contribution name.
  final String name;

  final double size;

  /// Tint for the initials background. Defaults to the brand purple that
  /// group cards already use.
  final Color? tint;

  const GroupFundsAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 40,
    this.tint,
  });

  @override
  Widget build(BuildContext context) {
    final side = size.w;
    final radius = BorderRadius.circular(10.r);
    final color = tint ?? const Color.fromARGB(255, 78, 3, 208);
    final url = imageUrl?.trim() ?? '';

    final fallback = Container(
      width: side,
      height: side,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
        ),
        borderRadius: radius,
      ),
      child: Center(
        child: Text(
          _initials(name),
          style: GoogleFonts.inter(
            fontSize: (size * 0.42).sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );

    if (url.isEmpty) return fallback;

    return ClipRRect(
      borderRadius: radius,
      child: Image.network(
        url,
        width: side,
        height: side,
        fit: BoxFit.cover,
        // Initials while the bytes are in flight, so the row never jumps
        // from an empty box to an image.
        loadingBuilder: (_, child, progress) =>
            progress == null ? child : fallback,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }

  /// Up to two letters. A single-word name gives one, which is better than
  /// padding it with a letter the name does not have.
  static String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
