import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/auth_background.dart';

/// First-launch intro carousel: four skippable, animated slides that introduce
/// Lazervault's core services before the user reaches the auth entry (whose
/// email path begins with country selection). Shown once per install, gated by
/// the `has_seen_onboarding` secure-storage flag (reset by the `force_onboarding`
/// dev trigger). Background is a random image from the shared [AuthBackground]
/// pool — the SAME bundled pool the passcode screens use — under a dark scrim so
/// the foreground stays readable.
class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({super.key});

  @override
  State<OnboardingCarouselScreen> createState() =>
      _OnboardingCarouselScreenState();
}

class _OnboardingSlide {
  final IconData icon;
  final List<IconData> orbit; // small icons that animate around the hero icon
  final String title;
  final String subtitle;
  final Color accent;
  const _OnboardingSlide({
    required this.icon,
    required this.orbit,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen>
    with TickerProviderStateMixin {
  static const Color _bg = Color(0xFF0A0A0A);

  final PageController _page = PageController();
  // Drives the continuous ambient motion (orbiting icons, hero float).
  late final AnimationController _ambient;
  // Drives the per-slide staggered entrance; restarts on each page change.
  late final AnimationController _entrance;

  int _index = 0;
  double _page01 = 0; // live page offset for parallax

  static const List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      icon: Icons.record_voice_over_rounded,
      orbit: [Icons.graphic_eq_rounded, Icons.mic_rounded, Icons.bolt_rounded],
      title: 'Talk to your money',
      subtitle:
          'Just speak. Send money, pay bills and check balances hands-free with your AI voice agent.',
      accent: Color(0xFF6366F1),
    ),
    _OnboardingSlide(
      icon: Icons.smart_toy_rounded,
      orbit: [Icons.chat_bubble_rounded, Icons.auto_awesome_rounded, Icons.bolt_rounded],
      title: 'Chat to get it done',
      subtitle:
          'Your AI assistant handles transfers, bills, insights and answers, all in plain language.',
      accent: Color(0xFF06B6D4),
    ),
    _OnboardingSlide(
      icon: Icons.document_scanner_rounded,
      orbit: [Icons.qr_code_rounded, Icons.receipt_long_rounded, Icons.check_rounded],
      title: 'Scan to pay',
      subtitle:
          'Point your camera at any bill, receipt or account number and pay instantly. AI reads the details for you.',
      accent: Color(0xFFEC4899),
    ),
    _OnboardingSlide(
      icon: Icons.swap_horiz_rounded,
      orbit: [Icons.person_rounded, Icons.bolt_rounded, Icons.check_rounded],
      title: 'Payments & transfers',
      subtitle:
          'Send and receive money in seconds, to any Lazervault user, bank, or tag, at home or across borders.',
      accent: Color(0xFF3B82F6),
    ),
    _OnboardingSlide(
      icon: Icons.receipt_long_rounded,
      orbit: [Icons.wifi_rounded, Icons.tv_rounded, Icons.flash_on_rounded],
      title: 'Bills, airtime & data',
      subtitle:
          'Airtime, data, electricity, cable, water and more. Every bill you pay, handled in one place.',
      accent: Color(0xFFFB923C),
    ),
    _OnboardingSlide(
      icon: Icons.savings_rounded,
      orbit: [Icons.trending_up_rounded, Icons.pie_chart_rounded, Icons.star_rounded],
      title: 'Savings & investments',
      subtitle:
          'Grow your money with automated savings, stocks and high-yield plans built for your goals.',
      accent: Color(0xFF10B981),
    ),
    _OnboardingSlide(
      icon: Icons.currency_bitcoin_rounded,
      orbit: [Icons.credit_card_rounded, Icons.lock_rounded, Icons.public_rounded],
      title: 'Cards & crypto',
      subtitle:
          'Spend with virtual cards and buy, sell or swap crypto securely, all from one wallet.',
      accent: Color(0xFF8B5CF6),
    ),
  ];

  bool get _isLast => _index == _slides.length - 1;

  @override
  void initState() {
    super.initState();
    _ambient = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _page.addListener(() {
      if (mounted) setState(() => _page01 = _page.page ?? 0);
    });
  }

  @override
  void dispose() {
    _ambient.dispose();
    _entrance.dispose();
    _page.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    try {
      final storage = serviceLocator<FlutterSecureStorage>();
      await storage.write(key: 'has_seen_onboarding', value: 'true');
    } catch (_) {/* best-effort — never block entry on a storage hiccup */}
    // Route to the normal brand-new-user entry. Email mode lands on the sign-in
    // screen (whose "Create account" begins with country selection); phone mode
    // starts the phone signup journey.
    Get.offAllNamed(
      FeatureFlags.isPhonePasscodeMode
          ? AppRoutes.phoneEntry
          : AppRoutes.emailSignIn,
    );
  }

  void _next() {
    if (_isLast) {
      _finish();
      return;
    }
    _page.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int i) {
    setState(() => _index = i);
    _entrance
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Shared bundled background (same pool as passcode) + dark scrim.
          Image.asset(AuthBackground.current, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.55),
                  Colors.black.withValues(alpha: 0.82),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Skip (hidden on the last slide, where the CTA becomes primary).
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedOpacity(
                    opacity: _isLast ? 0 : 1,
                    duration: const Duration(milliseconds: 250),
                    child: TextButton(
                      onPressed: _isLast ? null : _finish,
                      child: Text(
                        'Skip',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _page,
                    onPageChanged: _onPageChanged,
                    itemCount: _slides.length,
                    itemBuilder: (_, i) {
                      // Parallax: how far this page is from centred (-1..1).
                      final delta = (i - _page01).clamp(-1.0, 1.0);
                      return _buildSlide(_slides[i], delta, size);
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SmoothPageIndicator(
                  controller: _page,
                  count: _slides.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3.2,
                    spacing: 6,
                    activeDotColor: _slides[_index].accent,
                    dotColor: Colors.white.withValues(alpha: 0.28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _slides[_index].accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Text(
                          _isLast ? 'Get started' : 'Next',
                          key: ValueKey(_isLast),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(_OnboardingSlide slide, double delta, Size size) {
    // Staggered entrance intervals for illustration → title → subtitle.
    Animation<double> curve(double start, double end) => CurvedAnimation(
          parent: _entrance,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        );
    final illo = curve(0.0, 0.6);
    final titleA = curve(0.25, 0.8);
    final subA = curve(0.4, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated illustration: entrance scale/fade + continuous orbit,
          // plus horizontal parallax against the page swipe.
          Transform.translate(
            offset: Offset(delta * -26, 0),
            child: AnimatedBuilder(
              animation: Listenable.merge([_ambient, illo]),
              builder: (_, __) {
                final e = illo.value;
                return Opacity(
                  opacity: e,
                  child: Transform.scale(
                    scale: 0.7 + 0.3 * e,
                    child: _Illustration(
                      slide: slide,
                      t: _ambient.value,
                      size: size.width * 0.52,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: size.height * 0.06),
          AnimatedBuilder(
            animation: titleA,
            builder: (_, child) => Opacity(
              opacity: titleA.value,
              child: Transform.translate(
                offset: Offset(0, 22 * (1 - titleA.value)),
                child: child,
              ),
            ),
            child: Text(
              slide.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
          ),
          const SizedBox(height: 14),
          AnimatedBuilder(
            animation: subA,
            builder: (_, child) => Opacity(
              opacity: subA.value,
              child: Transform.translate(
                offset: Offset(0, 18 * (1 - subA.value)),
                child: child,
              ),
            ),
            child: Text(
              slide.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The animated hero illustration: a glowing rounded tile with the service icon,
/// three small icons orbiting it, and a gentle float — all built with Flutter
/// primitives (no external assets), so it ships in the binary and always works.
class _Illustration extends StatelessWidget {
  final _OnboardingSlide slide;
  final double t; // 0..1 ambient phase
  final double size;
  const _Illustration({required this.slide, required this.t, required this.size});

  @override
  Widget build(BuildContext context) {
    final float = math.sin(t * 2 * math.pi) * 6; // gentle vertical bob
    final orbitR = size * 0.52;
    return SizedBox(
      width: size * 1.6,
      height: size * 1.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft radial glow behind the tile.
          Container(
            width: size * 1.5,
            height: size * 1.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  slide.accent.withValues(alpha: 0.35),
                  slide.accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          // Orbiting mini-icons.
          for (int i = 0; i < slide.orbit.length; i++)
            Transform.translate(
              offset: Offset(
                orbitR * math.cos(t * 2 * math.pi + i * 2 * math.pi / slide.orbit.length),
                orbitR * math.sin(t * 2 * math.pi + i * 2 * math.pi / slide.orbit.length),
              ),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
                ),
                child: Icon(slide.orbit[i], size: size * 0.12, color: Colors.white),
              ),
            ),
          // Hero tile (floats).
          Transform.translate(
            offset: Offset(0, float),
            child: Container(
              width: size * 0.68,
              height: size * 0.68,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [slide.accent, slide.accent.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(size * 0.2),
                boxShadow: [
                  BoxShadow(
                    color: slide.accent.withValues(alpha: 0.45),
                    blurRadius: 34,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(slide.icon, size: size * 0.34, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
