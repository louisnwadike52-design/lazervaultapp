part of 'modern_onboarding_screen.dart';

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<String> features;
  final LinearGradient gradient;
  // Per-page accent color — drives the icon halo, indicator dots and the
  // primary CTA. Distinguishes slides without abandoning the unified dark
  // base. Tap-points (button + dots) use the accent; surfaces use white.
  final Color accent;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.features,
    required this.gradient,
    required this.accent,
  });
}
