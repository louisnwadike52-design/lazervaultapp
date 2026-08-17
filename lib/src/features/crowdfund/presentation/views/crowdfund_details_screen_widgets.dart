part of 'crowdfund_details_screen.dart';

/// Hero header image for the campaign details page. Routes through a
/// fallback URL when the primary is missing or fails — the screen
/// always shows a real photo at the configured 180.h slot, never an
/// `image_not_supported` icon.
class _CampaignHeroImage extends StatefulWidget {
  final String? imageUrl;

  const _CampaignHeroImage({required this.imageUrl});

  @override
  State<_CampaignHeroImage> createState() => _CampaignHeroImageState();
}

class _CampaignHeroImageState extends State<_CampaignHeroImage> {
  // Tracks whether the primary URL has thrown an errorWidget. Once
  // it has, we lock onto the fallback URL so we don't keep retrying
  // a known-broken source on every rebuild.
  bool _primaryFailed = false;

  bool get _hasPrimary {
    final u = widget.imageUrl;
    return u != null && u.trim().isNotEmpty && !_primaryFailed;
  }

  String get _activeUrl {
    if (_hasPrimary) {
      return rewriteHostForEmulator(widget.imageUrl!);
    }
    return _campaignFallbackImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary parks the decoded image bitmap on its own
    // layer so the surrounding scroll view never has to repaint it
    // when sibling widgets (status pill, donor list) mutate. Pair
    // with memCacheWidth = 800 (matches the URL ?w=800 query) so we
    // don't pay to decode a multi-megapixel source at 800×180 dp.
    return RepaintBoundary(
      child: CachedNetworkImage(
        // Re-key on which URL is active so cached_network_image rebuilds
        // its internal stream when we swap from primary → fallback.
        key: ValueKey(_activeUrl),
        imageUrl: _activeUrl,
        fit: BoxFit.cover,
        memCacheWidth: 800,
        fadeInDuration: const Duration(milliseconds: 180),
        placeholder: (context, _) => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)]),
          ),
        ),
        errorWidget: (context, error, stackTrace) {
          if (_hasPrimary) {
            // Primary just blew up — flip the flag on next frame so the
            // widget rebuilds with the fallback URL instead of looping
            // on this same broken source. We can't setState inside
            // build directly.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              setState(() => _primaryFailed = true);
            });
          }
          // Last-resort gradient + icon when even the fallback is
          // unreachable (e.g. user is fully offline). Bare gradient
          // — no icon, since the user already knows there's no image.
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)]),
            ),
          );
        },
      ),
    );
  }
}

/// Robust avatar that mirrors the donor + recipient avatar pattern:
/// purple-gradient circle with initials, network image overlaid only
/// when it loads successfully. Network failures fall back to the
/// initials so the user never sees a blank circle / broken icon.
class _CreatorAvatar extends StatelessWidget {
  final String initials;
  final String? profilePicture;
  final double radius;
  final double fontSize;

  const _CreatorAvatar({
    required this.initials,
    required this.profilePicture,
    required this.radius,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final initialWidget = Text(
      initials.isEmpty ? 'U' : initials,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
    final url = profilePicture;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: (url == null || url.isEmpty)
          ? Center(child: initialWidget)
          : RepaintBoundary(
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: rewriteHostForEmulator(url),
                  fit: BoxFit.cover,
                  width: radius * 2,
                  height: radius * 2,
                  // Cap the decode size at ~3× the pixel diameter so
                  // we don't pay to decode a multi-megapixel profile
                  // photo for a 32-pixel circle. Disk-cached across
                  // sessions via cached_network_image.
                  memCacheWidth: (radius * 2 * 3).round(),
                  fadeInDuration: const Duration(milliseconds: 120),
                  placeholder: (_, __) => Center(child: initialWidget),
                  errorWidget: (_, __, ___) => Center(child: initialWidget),
                ),
              ),
            ),
    );
  }
}
