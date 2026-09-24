import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lazervault/core/services/dashboard_adverts_service.dart';

/// A small, async, non-blocking adverts carousel shown just below the quick
/// services on the dashboard (showcase layout only). Images + deep-links come
/// from the admin dashboard (`dashboard_adverts` system setting) so marketing
/// can rotate promos with no redeploy.
///
/// Resilience:
///   * Loads config AFTER first frame — never blocks dashboard boot.
///   * While loading (or when the admin has configured nothing / the backend is
///     unreachable), it shows a single Dart-painted default promo card, so the
///     section is never blank and there is never a broken-image box.
///   * A remote image that fails to load falls back to the same painted card.
///   * A malformed / unknown deep-link is ignored (never throws / crashes).
class DashboardAdvertsCarousel extends StatefulWidget {
  const DashboardAdvertsCarousel({super.key});

  @override
  State<DashboardAdvertsCarousel> createState() =>
      _DashboardAdvertsCarouselState();
}

class _DashboardAdvertsCarouselState extends State<DashboardAdvertsCarousel> {
  List<DashboardAdvert> _adverts = const <DashboardAdvert>[];
  int _current = 0;

  @override
  void initState() {
    super.initState();
    // Seed with whatever is already cached so a return visit paints instantly.
    _adverts = DashboardAdvertsService.instance.adverts;
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final list = await DashboardAdvertsService.instance.ensure();
    if (!mounted) return;
    setState(() => _adverts = list);
  }

  /// Resolve an advert link. Full URLs open the browser; app route paths
  /// (starting with "/") navigate in-app. Anything unexpected is ignored.
  Future<void> _openLink(String link) async {
    final l = link.trim();
    if (l.isEmpty) return;
    try {
      if (l.startsWith('http://') || l.startsWith('https://')) {
        final uri = Uri.tryParse(l);
        if (uri != null) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        return;
      }
      if (l.startsWith('/')) {
        Get.toNamed(l);
      }
    } catch (_) {
      // Bad admin value — never let a promo tap crash the dashboard.
    }
  }

  @override
  Widget build(BuildContext context) {
    // When the admin hasn't configured anything, fall back to the bundled seed
    // adverts (real imagery) so the section launches intentional, not empty. Any
    // seed image that fails to load still degrades to the painted card.
    // Cap the count so the (non-wrapping) page-dot row can't overflow on small
    // screens if an admin configures a long advert list.
    const maxSlides = 12;
    final source = _adverts.isEmpty ? kSeedDashboardAdverts : _adverts;
    final slides =
        source.length > maxSlides ? source.sublist(0, maxSlides) : source;

    // Kept compact so the advert card AND its page indicators clear the fold
    // on the showcase dashboard (they'd otherwise sit behind the bottom nav).
    final height = 104.h;

    return Column(
      children: [
        SizedBox(
          height: height,
          child: CarouselSlider.builder(
            itemCount: slides.length,
            options: CarouselOptions(
              height: height,
              viewportFraction: 0.92,
              enlargeCenterPage: false,
              enableInfiniteScroll: slides.length > 1,
              autoPlay: slides.length > 1,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              onPageChanged: (i, _) => setState(() => _current = i),
            ),
            itemBuilder: (context, index, _) {
              final advert = slides[index];
              return _AdvertCard(
                  advert: advert, onTap: () => _openLink(advert.link));
            },
          ),
        ),
        if (slides.length > 1) ...[
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(slides.length, (i) {
              final active = i == _current;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: active ? 20.w : 6.w,
                height: 6.h,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF3B82F6).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

class _AdvertCard extends StatelessWidget {
  final DashboardAdvert advert;
  final VoidCallback onTap;
  const _AdvertCard({required this.advert, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: advert.imageUrl.isEmpty
            ? _defaultCard(advert.title, advert.subtitle)
            : Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: advert.imageUrl,
                    fit: BoxFit.cover,
                    // Fill the card box in both axes so BoxFit.cover crops to a
                    // clean, centered fill (no letterboxing / intrinsic-size
                    // gaps) against the rounded-clipped card.
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (_, __) =>
                        _defaultCard(advert.title, advert.subtitle),
                    errorWidget: (_, __, ___) =>
                        _defaultCard(advert.title, advert.subtitle),
                  ),
                  // The copy is drawn HERE, over the image, rather than baked
                  // into the artwork. Until now `title` only ever appeared on
                  // the fallback card, so every slide that loaded successfully
                  // showed a picture with no message on it — the one thing a
                  // promo strip exists to do. Drawing it in Flutter also keeps
                  // it crisp at every pixel density and lets marketing reword a
                  // slide from the admin dashboard with no new artwork.
                  if (advert.title.isNotEmpty) _copyOverlay(),
                ],
              ),
      ),
    );
  }

  /// Headline + supporting line over the artwork.
  ///
  /// The scrim is a left-weighted gradient, not a flat wash: the art is authored
  /// with its motif on the right third and its lightest gradient stop there too,
  /// so darkening the whole card would dull the image for no contrast gain. This
  /// darkens only the side the text sits on.
  Widget _copyOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.black.withValues(alpha: 0.45),
            Colors.black.withValues(alpha: 0.12),
            Colors.transparent,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Width-capped and line-capped so a long admin-authored string
            // wraps and ellipsises inside the card instead of overflowing it or
            // running under the motif on the right.
            SizedBox(
              width: 210.w,
              child: Text(
                advert.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (advert.subtitle.isNotEmpty) ...[
              SizedBox(height: 4.h),
              SizedBox(
                width: 210.w,
                child: Text(
                  advert.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// A branded gradient promo used when a slide has no image, and as the image
  /// placeholder/error fallback — so the carousel is never blank or broken.
  Widget _defaultCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4E03D0), Color(0xFF3B82F6)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.isNotEmpty ? title : 'Do more with Lazervault',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  // The slide's own supporting line when it has one, so the
                  // fallback card says the same thing the loaded card would
                  // rather than reverting to generic marketing copy.
                  subtitle.isNotEmpty
                      ? subtitle
                      : 'Bills, savings, transfers and more — all in one place',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
