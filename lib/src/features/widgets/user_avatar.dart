import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand colour used as the initials-fallback background when no
/// override is provided. Callers on coloured surfaces (e.g. the
/// dashboard purple top bar) should pass `backgroundColor:` with a
/// surface-matching frosted overlay (`Colors.white.withValues(alpha: 0.15)`)
/// rather than relying on this default — brand purple on brand purple
/// is invisible.
const Color _brandPurple = Color(0xFF4E03D0);

/// What to render when the user has no profilePicture set.
enum UserAvatarFallback {
  /// Render circular initials of [firstName] + [lastName] on a
  /// brand-purple background. Used by the dashboard top-left avatar
  /// (and any inline avatar inside the app).
  initials,

  /// Render the app logo (`assets/images/logo.png`) inside a
  /// brand-purple halo. Used by the passcode sign-in screen (per spec —
  /// initials are not appropriate when the user hasn't logged in yet).
  appLogo,
}

/// Production-grade reusable avatar.
///
/// - If [imageUrl] resolves to a real http(s) URL we render it with
///   CachedNetworkImage (disk cache, fades in, retries on transient
///   network errors).
/// - If it's null / empty / not http(s), we fall back per
///   [fallbackMode].
/// - Asset paths like `assets/images/dp.png` are also rendered (the
///   legacy [AppData.dp] sentinel keeps working until callers migrate).
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.size,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.fallbackMode = UserAvatarFallback.initials,
    this.borderColor,
    this.borderWidth = 0,
    this.backgroundColor,
  });

  /// Network URL OR asset path. Null / empty -> fallback.
  final String? imageUrl;

  /// First name for initials fallback.
  final String? firstName;

  /// Last name for initials fallback.
  final String? lastName;

  /// What to render when [imageUrl] is missing.
  final UserAvatarFallback fallbackMode;

  /// Outer diameter of the avatar in logical pixels (already scaled —
  /// pass `40.r` if you need ScreenUtil scaling).
  final double size;

  /// Optional border colour.
  final Color? borderColor;

  /// Border width (only drawn when [borderColor] is set).
  final double borderWidth;

  /// Override the fallback background colour. Defaults to brand purple.
  final Color? backgroundColor;

  String get _initials {
    final f = (firstName ?? '').trim();
    final l = (lastName ?? '').trim();
    final fc = f.isEmpty ? '' : f.characters.first.toUpperCase();
    final lc = l.isEmpty ? '' : l.characters.first.toUpperCase();
    if (fc.isEmpty && lc.isEmpty) return '';
    return '$fc$lc';
  }

  bool _isNetworkUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    final lower = url.toLowerCase();
    return lower.startsWith('http://') || lower.startsWith('https://');
  }

  bool _isAssetPath(String? url) {
    if (url == null || url.isEmpty) return false;
    return url.startsWith('assets/');
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? _brandPurple;
    // appLogo fallback renders the bare brand mark — no outer disc.
    // For every other path (network image, asset, initials) the disc
    // is intentional. We still allow callers to draw a border on the
    // appLogo path if they want a halo.
    final isNakedLogo = fallbackMode == UserAvatarFallback.appLogo &&
        !_isNetworkUrl(imageUrl) &&
        !_isAssetPath(imageUrl);
    final decoration = isNakedLogo
        ? BoxDecoration(
            shape: BoxShape.circle,
            border: (borderColor != null && borderWidth > 0)
                ? Border.all(color: borderColor!, width: borderWidth)
                : null,
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            border: (borderColor != null && borderWidth > 0)
                ? Border.all(color: borderColor!, width: borderWidth)
                : null,
          );

    Widget child;
    if (_isNetworkUrl(imageUrl)) {
      child = ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (_, __) => _buildFallback(bg),
          errorWidget: (_, __, ___) => _buildFallback(bg),
        ),
      );
    } else if (_isAssetPath(imageUrl)) {
      child = ClipOval(
        child: Image.asset(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallback(bg),
        ),
      );
    } else {
      child = _buildFallback(bg);
    }

    return Container(
      width: size,
      height: size,
      decoration: decoration,
      child: child,
    );
  }

  Widget _buildFallback(Color bg) {
    switch (fallbackMode) {
      case UserAvatarFallback.appLogo:
        return _logoFallback(bg);
      case UserAvatarFallback.initials:
        return _initialsFallback(bg);
    }
  }

  Widget _initialsFallback(Color bg) {
    final initials = _initials;
    if (initials.isEmpty) {
      // No name to derive initials from — use a generic person icon
      // rather than an empty purple disc.
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
        child: Icon(
          Icons.person_outline_rounded,
          color: Colors.white,
          size: size * 0.55,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          // Scale font with avatar size. 0.4 gives a 16px char in a 40px
          // disc — visually centered, still legible at 28px.
          fontSize: size * 0.4,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _logoFallback(Color bg) {
    // Naked brand mark — no circular disc, no tinted backdrop. The
    // ribbon already carries its own visual weight + has a transparent
    // PNG halo, so wrapping it in a disc made it read as a sticker.
    // Used on the passcode sign-in screen where the dim wallpaper
    // already provides the surface; we just need the mark to sit on
    // top at industry-standard sign-in avatar size.
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(
          Icons.account_balance_wallet_rounded,
          color: Colors.white,
          size: size * 0.5,
        ),
      ),
    );
  }
}
