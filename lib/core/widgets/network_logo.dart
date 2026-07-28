import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/network_logo_manifest.dart';

/// A widget that displays a mobile-network-operator logo.
///
/// Prefers a bundled, brand-styled SVG badge
/// (`assets/images/networks/<slug>.svg`) resolved from the operator key; falls
/// back to a rounded tile filled with the operator's brand color showing its
/// initials when no badge is bundled (or the asset fails to decode). Badges
/// ship in the app binary so there are no remote calls — mirrors `BankLogo`.
class NetworkLogo extends StatelessWidget {
  /// Operator key — a network `type` (`mtn`, `airtel`, `glo`, `ninemobile`,
  /// `etisalat`) or a data network code (`mtn-data`, `etisalat-data`, …).
  final String networkType;

  /// Optional additional keys used to resolve the bundled badge (any one that
  /// matches wins). `operatorId` (`MTN`, `9MOBILE`) / `shortName` (`Airtel`).
  final String? operatorId;
  final String? shortName;

  /// Brand color as `#RRGGBB` — used for the fallback tile.
  final String primaryColorHex;

  /// Human-readable name, used only to derive fallback initials when no
  /// [shortName] is supplied.
  final String? name;

  final double size;
  final double borderRadius;

  const NetworkLogo({
    super.key,
    required this.networkType,
    this.operatorId,
    this.shortName,
    this.name,
    this.primaryColorHex = '#4E03D0',
    this.size = 44,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final logoAsset = _resolveLogoAsset();
    final brand = _parseColor(primaryColorHex);
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: brand.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: logoAsset != null
            ? _buildAssetLogo(logoAsset, brand)
            : _buildFallback(brand),
      ),
    );
  }

  /// Resolve the bundled badge, trying (in order) the type, operatorId and
  /// shortName keys against the manifest. Returns `null` when none match.
  String? _resolveLogoAsset() {
    return bundledNetworkLogoAsset(networkType) ??
        bundledNetworkLogoAsset(operatorId) ??
        bundledNetworkLogoAsset(shortName);
  }

  Widget _buildAssetLogo(String asset, Color brand) {
    // The badges are full-bleed (brand color fills the tile), so render on the
    // brand color and let the SVG cover it — no white padding like a bank logo.
    return Container(
      color: brand,
      child: SvgPicture.asset(
        asset,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => _buildFallback(brand),
      ),
    );
  }

  Widget _buildFallback(Color brand) {
    return Container(
      color: brand,
      child: Center(
        child: Text(
          _initials(),
          style: TextStyle(
            color: _readableTextColor(brand),
            fontSize: (size * 0.34).sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  String _initials() {
    final source = (shortName != null && shortName!.trim().isNotEmpty)
        ? shortName!.trim()
        : (name ?? networkType).trim();
    if (source.isEmpty) return '?';
    // Prefer the first three chars of a compact wordmark (MTN, GLO), else the
    // first two letters.
    final letters = source.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (letters.isEmpty) return '?';
    final take = letters.length >= 3 && letters.length <= 4 ? 3 : 2;
    return letters.substring(0, take.clamp(1, letters.length)).toUpperCase();
  }

  /// Parse a `#RRGGBB` (or `RRGGBB`) hex string; falls back to the brand purple.
  Color _parseColor(String hex) {
    try {
      var h = hex.trim().replaceFirst('#', '');
      if (h.length == 6) h = 'FF$h';
      return Color(int.parse(h, radix: 16));
    } catch (_) {
      return const Color(0xFF4E03D0);
    }
  }

  /// Pick black or white text for readable contrast against [bg] (per WCAG
  /// relative-luminance) — MTN yellow needs dark text, red/green need white.
  Color _readableTextColor(Color bg) {
    final luminance = bg.computeLuminance();
    return luminance > 0.55 ? const Color(0xFF1A1A1A) : Colors.white;
  }
}
