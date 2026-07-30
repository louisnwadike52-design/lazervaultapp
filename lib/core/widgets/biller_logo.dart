import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/biller_logo_manifest.dart';

/// Brand logo for a non-network biller — electricity DisCos, cable TV, betting
/// platforms, internet providers. Mirrors [NetworkLogo]/`BankLogo` but adds a
/// remote-URL first step (many provider records carry a `logo_url`).
///
/// Resolution order (never a broken image):
///   1. [logoUrl] (non-empty) → cached remote image.
///   2. bundled asset resolved from [code]/[name] via `biller_logo_manifest`.
///   3. rounded tile filled with the biller's brand colour + its initials.
class BillerLogo extends StatelessWidget {
  /// Canonical biller key — `providerCode` (IKEDC), `serviceId` (dstv),
  /// betting `code`, etc. Used to resolve the bundled asset.
  final String? code;

  /// Human-readable name — used for the bundled lookup fallback + initials.
  final String? name;

  /// Optional remote logo URL from the provider record (preferred when set).
  final String? logoUrl;

  /// Brand colour as `#RRGGBB` for the fallback tile.
  final String brandColorHex;

  final double size;
  final double borderRadius;

  const BillerLogo({
    super.key,
    this.code,
    this.name,
    this.logoUrl,
    this.brandColorHex = '#4E03D0',
    this.size = 44,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final brand = _parseColor(brandColorHex);
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: brand.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: _content(brand),
      ),
    );
  }

  Widget _content(Color brand) {
    final url = logoUrl?.trim() ?? '';
    if (url.isNotEmpty) {
      // Remote logo on a white tile (provider logos are usually on transparent/
      // white); fall back to the bundled asset / initials on failure.
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(size * 0.12),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.contain,
          placeholder: (_, __) => _bundledOrFallback(brand),
          errorWidget: (_, __, ___) => _bundledOrFallback(brand),
        ),
      );
    }
    return _bundledOrFallback(brand);
  }

  Widget _bundledOrFallback(Color brand) {
    final asset = bundledBillerLogoAsset(code) ?? bundledBillerLogoAsset(name);
    if (asset == null) return _buildFallback(brand);
    // Logos are on white; contain (don't crop the wordmark).
    final child = asset.endsWith('.svg')
        ? SvgPicture.asset(asset,
            fit: BoxFit.contain,
            placeholderBuilder: (_) => _buildFallback(brand))
        : Image.asset(asset,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => _buildFallback(brand));
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(size * 0.12),
      child: child,
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
    final source = (name != null && name!.trim().isNotEmpty)
        ? name!.trim()
        : (code ?? '').trim();
    final letters = source.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (letters.isEmpty) return '?';
    final take = letters.length >= 3 && letters.length <= 4 ? 3 : 2;
    return letters.substring(0, take.clamp(1, letters.length)).toUpperCase();
  }

  Color _parseColor(String hex) {
    try {
      var h = hex.trim().replaceFirst('#', '');
      if (h.length == 6) h = 'FF$h';
      return Color(int.parse(h, radix: 16));
    } catch (_) {
      return const Color(0xFF4E03D0);
    }
  }

  Color _readableTextColor(Color bg) {
    return bg.computeLuminance() > 0.55 ? const Color(0xFF1A1A1A) : Colors.white;
  }
}
