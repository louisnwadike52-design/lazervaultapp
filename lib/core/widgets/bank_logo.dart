import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/bank_logo_lookup.dart';
import '../utilities/bank_logo_manifest.dart';
import '../utilities/banks_data.dart';

/// A widget that displays a bank logo.
///
/// Three sources, in order:
///
///  1. [logoUrl] — served by our backend, cached on device after the first
///     fetch. This is where the breadth is: the store holds ~280 logos against
///     the 38 that ship in the binary, so most of the banks the active rail
///     offers only have a logo through this path.
///  2. A bundled asset (`assets/images/banks/<code>.webp`). Kept as the
///     OFFLINE answer, not as dead weight — a bank picker opened with no
///     network still shows real marks for the most-used banks, which a
///     URL-only design could not.
///  3. The bank's initials on a coloured tile. Better than a broken image or a
///     generic bank glyph, which would make every unknown bank look alike.
///
/// The URL is keyed server-side by normalised bank NAME rather than by code,
/// because codes are per-rail: Kuda is 50211 on Flutterwave and 090267 on
/// Nomba, so a code-keyed logo would disappear the day the payout provider
/// changed.
class BankLogo extends StatelessWidget {
  final String bankName;
  final String? bankCode;
  final String country;
  final double size;
  final double borderRadius;

  /// Backend-served logo URL, when the caller has one (bank lists carry it).
  /// Null simply means "fall through to the bundled asset", so every existing
  /// call site keeps its current behaviour.
  final String? logoUrl;

  const BankLogo({
    super.key,
    required this.bankName,
    this.bankCode,
    this.country = 'NG',
    this.size = 44,
    this.borderRadius = 10,
    this.logoUrl,
  });

  /// The URL to use: the one passed in, else whatever the bank-list index
  /// holds for this bank.
  ///
  /// The index is what gets logos onto the screens that matter — a saved
  /// recipient, transfer history, a confirm sheet — none of which have a `Bank`
  /// object to take a URL from.
  String? get _effectiveUrl {
    final passed = logoUrl?.trim() ?? '';
    if (passed.isNotEmpty) return passed;
    return BankLogoLookup.urlFor(bankName: bankName, bankCode: bankCode);
  }

  /// True when [_effectiveUrl] is a usable absolute http(s) URL.
  ///
  /// Checked rather than assumed: a relative path or a stray placeholder would
  /// make CachedNetworkImage throw during layout, taking the whole bank list
  /// down over a cosmetic field.
  bool get _hasRemoteLogo {
    final u = _effectiveUrl ?? '';
    if (u.isEmpty) return false;
    final parsed = Uri.tryParse(u);
    return parsed != null &&
        parsed.hasScheme &&
        (parsed.scheme == 'https' || parsed.scheme == 'http') &&
        parsed.host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    // The index is usually empty on first paint (the bank list is still
    // loading), so without this a recipient tile would keep its initials for
    // the rest of the session even once the real logo was known.
    return ValueListenableBuilder<int>(
      valueListenable: BankLogoLookup.revision,
      builder: (_, __, ___) => _buildTile(),
    );
  }

  Widget _buildTile() {
    final logoAsset = _resolveLogoAsset();
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: _getBankGradientColors(bankName)[0].withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: _buildImage(logoAsset),
      ),
    );
  }

  /// Resolve the bundled-logo asset, trying (in order): the provided [bankCode]
  /// (direct or via the Flutterwave→logo alias map), [bankName] when it stores a
  /// bare code, and finally a name→code lookup against the static bank list.
  String? _resolveLogoAsset() {
    // Internal Lazervault transfers show OUR logo rather than a bank logo/tile.
    if (bankName.toLowerCase().contains('lazervault') ||
        (bankCode ?? '').toLowerCase().contains('lazervault')) {
      return 'assets/images/logo.png';
    }
    final byCode = bundledBankLogoAsset(bankCode);
    if (byCode != null) return byCode;
    final byNameAsCode = bundledBankLogoAsset(bankName.trim());
    if (byNameAsCode != null) return byNameAsCode;
    return bundledBankLogoAsset(
      BanksData.getBankCodeByName(bankName, country: country),
    );
  }

  Widget _buildImage(String? logoAsset) {
    // Our own logo for internal transfers always wins — it is an asset and
    // there is no remote equivalent.
    final isInternal = logoAsset == 'assets/images/logo.png';
    if (!isInternal && _hasRemoteLogo) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all((size * 0.12).w),
        child: CachedNetworkImage(
          imageUrl: _effectiveUrl!,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
          // No spinner. A bank list renders dozens of these at once and a grid
          // of spinners reads as a broken screen; the bundled asset or the
          // initials is a complete, correct tile to show meanwhile.
          placeholder: (_, __) =>
              logoAsset != null ? _rawAsset(logoAsset) : _buildFallback(),
          // Same answer on failure — offline, a 404, or a logo we no longer
          // hold all land here, and all of them mean "use what we have".
          errorWidget: (_, __, ___) =>
              logoAsset != null ? _rawAsset(logoAsset) : _buildFallback(),
        ),
      );
    }
    return logoAsset != null ? _buildAssetLogo(logoAsset) : _buildFallback();
  }

  /// The asset without the white card/padding wrapper, for use INSIDE one.
  Widget _rawAsset(String asset) {
    return Image.asset(
      asset,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, __, ___) => _buildFallback(),
    );
  }

  Widget _buildAssetLogo(String asset) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all((size * 0.12).w),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, __, ___) => _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getBankGradientColors(bankName),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          _getBankInitials(bankName),
          style: TextStyle(
            color: Colors.white,
            fontSize: (size * 0.35).sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  List<Color> _getBankGradientColors(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access'))
      return [const Color(0xFFFF6600), const Color(0xFFCC5200)];
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust'))
      return [const Color(0xFFFF6600), const Color(0xFFCC4400)];
    if (lowerName.contains('first bank'))
      return [const Color(0xFF003366), const Color(0xFF002244)];
    if (lowerName.contains('uba') ||
        lowerName.contains('united bank for africa'))
      return [const Color(0xFFCC0000), const Color(0xFF990000)];
    if (lowerName.contains('zenith'))
      return [const Color(0xFFCC0000), const Color(0xFF990000)];
    if (lowerName.contains('kuda'))
      return [const Color(0xFF6B47ED), const Color(0xFF5533CC)];
    if (lowerName.contains('opay'))
      return [const Color(0xFF00C853), const Color(0xFF009624)];
    if (lowerName.contains('palmpay'))
      return [const Color(0xFF6C63FF), const Color(0xFF5046E5)];
    if (lowerName.contains('fidelity'))
      return [const Color(0xFF006B3F), const Color(0xFF004D2D)];
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument'))
      return [const Color(0xFF6B2D7B), const Color(0xFF4A1F55)];
    if (lowerName.contains('sterling'))
      return [const Color(0xFFCC0000), const Color(0xFF990000)];
    if (lowerName.contains('stanbic'))
      return [const Color(0xFF0033A1), const Color(0xFF002277)];
    if (lowerName.contains('ecobank'))
      return [const Color(0xFF004C91), const Color(0xFF003366)];
    if (lowerName.contains('union bank'))
      return [const Color(0xFF003087), const Color(0xFF002266)];
    if (lowerName.contains('wema') || lowerName.contains('alat'))
      return [const Color(0xFF6B2D7B), const Color(0xFF4A1F55)];
    if (lowerName.contains('polaris'))
      return [const Color(0xFF003399), const Color(0xFF002266)];
    if (lowerName.contains('keystone'))
      return [const Color(0xFF0066CC), const Color(0xFF004488)];
    if (lowerName.contains('heritage'))
      return [const Color(0xFF006633), const Color(0xFF004422)];
    if (lowerName.contains('moniepoint'))
      return [const Color(0xFF0066FF), const Color(0xFF0044CC)];
    if (lowerName.contains('carbon'))
      return [const Color(0xFF00C9A7), const Color(0xFF00A386)];

    // UK Banks
    if (lowerName.contains('barclays'))
      return [const Color(0xFF0071CE), const Color(0xFF004A8F)];
    if (lowerName.contains('hsbc'))
      return [const Color(0xFFDB0011), const Color(0xFFB8000E)];
    if (lowerName.contains('lloyds'))
      return [const Color(0xFF006A4E), const Color(0xFF004D3A)];
    if (lowerName.contains('natwest'))
      return [const Color(0xFF5D2A8F), const Color(0xFF4A1F75)];
    if (lowerName.contains('santander'))
      return [const Color(0xFFEC0000), const Color(0xFFD10000)];
    if (lowerName.contains('monzo'))
      return [const Color(0xFFFF5A5F), const Color(0xFFE64850)];
    if (lowerName.contains('starling'))
      return [const Color(0xFF6935D3), const Color(0xFF5229A8)];
    if (lowerName.contains('revolut'))
      return [const Color(0xFF0073E6), const Color(0xFF005BB5)];

    // Default gradient
    return [const Color(0xFF78039C), const Color(0xFF5F14E1)];
  }

  String _getBankInitials(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return 'AB';
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust'))
      return 'GT';
    if (lowerName.contains('first bank')) return 'FB';
    if (lowerName.contains('uba') ||
        lowerName.contains('united bank for africa')) return 'UBA';
    if (lowerName.contains('zenith')) return 'ZB';
    if (lowerName.contains('kuda')) return 'KD';
    if (lowerName.contains('opay')) return 'OP';
    if (lowerName.contains('palmpay')) return 'PP';
    if (lowerName.contains('fidelity')) return 'FD';
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument'))
      return 'FC';
    if (lowerName.contains('sterling')) return 'SB';
    if (lowerName.contains('stanbic')) return 'SI';
    if (lowerName.contains('ecobank')) return 'EB';
    if (lowerName.contains('union bank')) return 'UB';
    if (lowerName.contains('wema')) return 'WB';
    if (lowerName.contains('alat')) return 'AL';
    if (lowerName.contains('moniepoint')) return 'MP';
    if (lowerName.contains('carbon')) return 'CB';

    // UK Banks
    if (lowerName.contains('barclays')) return 'BC';
    if (lowerName.contains('hsbc')) return 'HS';
    if (lowerName.contains('lloyds')) return 'LB';
    if (lowerName.contains('natwest')) return 'NW';
    if (lowerName.contains('santander')) return 'SU';
    if (lowerName.contains('monzo')) return 'MZ';
    if (lowerName.contains('starling')) return 'SL';
    if (lowerName.contains('revolut')) return 'RV';

    // Default: first letters of first two words
    if (bankName.isEmpty) return '??';
    final words = bankName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return bankName.length >= 2
        ? bankName.substring(0, 2).toUpperCase()
        : bankName.toUpperCase();
  }
}
