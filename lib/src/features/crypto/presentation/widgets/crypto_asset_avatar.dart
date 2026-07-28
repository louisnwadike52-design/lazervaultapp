import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// CryptoAssetAvatar renders the REAL per-asset logo for a crypto asset with
/// graceful, per-asset fallbacks — so every asset shows its own identity and
/// no asset ever borrows the Bitcoin logo.
///
/// Rendering order:
///  1. The asset's real logo image ([imageUrl], typically the CoinGecko/Quidax
///     `image` URL carried on the [Crypto] entity) via [Image.network].
///  2. When there is no URL, or the network image fails / is still loading,
///     a deterministic colored circular chip showing the asset's INITIALS
///     (first 1-2 letters of the [symbol], e.g. "US" for USDT, "BT" for BTC).
///
/// This intentionally NEVER falls back to a Bitcoin icon or a single shared
/// asset image. The initials chip is the terminal fallback.
class CryptoAssetAvatar extends StatelessWidget {
  /// Ticker symbol (e.g. "BTC", "USDT"). Drives the initials + chip color.
  final String symbol;

  /// Real logo URL. When null/empty the initials chip is shown instead.
  final String? imageUrl;

  /// Diameter of the avatar in logical pixels (already screenutil-scaled by
  /// the caller if desired — this widget applies `.w` internally when given a
  /// raw design-size value, so pass a design size like `42`).
  final double size;

  const CryptoAssetAvatar({
    super.key,
    required this.symbol,
    this.imageUrl,
    this.size = 42,
  });

  // Dark-theme-friendly palette (aligned with the app's crypto surfaces).
  static const List<Color> _palette = [
    Color(0xFF3B82F6), // blue (primary)
    Color(0xFF10B981), // green (success)
    Color(0xFFFB923C), // orange (warning)
    Color(0xFF8B5CF6), // violet
    Color(0xFFEC4899), // pink
    Color(0xFF06B6D4), // cyan
    Color(0xFFF59E0B), // amber
    Color(0xFF6366F1), // indigo
    Color(0xFF14B8A6), // teal
    Color(0xFFA855F7), // purple
  ];

  String get _initials {
    final s = symbol.trim().toUpperCase();
    if (s.isEmpty) return '?';
    return s.length >= 2 ? s.substring(0, 2) : s.substring(0, 1);
  }

  Color get _chipColor {
    final s = symbol.trim().toUpperCase();
    if (s.isEmpty) return _palette.first;
    // Deterministic hash → stable color per symbol.
    var hash = 0;
    for (final code in s.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    return _palette[hash % _palette.length];
  }

  @override
  Widget build(BuildContext context) {
    final dim = size.w;
    final url = imageUrl?.trim() ?? '';

    if (url.isEmpty) {
      return _initialsChip(dim);
    }

    return ClipOval(
      // CachedNetworkImage persists logos to disk + memory so they don't
      // re-download on every rebuild / screen re-entry (Image.network kept
      // re-fetching, adding jank + bandwidth to the landing scroll).
      child: CachedNetworkImage(
        imageUrl: url,
        width: dim,
        height: dim,
        fit: BoxFit.cover,
        // Keep the initials chip as the placeholder while the logo loads so
        // there's never a blank/Bitcoin flash.
        placeholder: (_, __) => _initialsChip(dim),
        errorWidget: (_, __, ___) => _initialsChip(dim),
      ),
    );
  }

  Widget _initialsChip(double dim) {
    final color = _chipColor;
    return Container(
      width: dim,
      height: dim,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
      ),
      child: Text(
        _initials,
        style: GoogleFonts.inter(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: (dim * 0.34),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
