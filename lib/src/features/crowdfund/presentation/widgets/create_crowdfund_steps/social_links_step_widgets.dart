part of 'social_links_step.dart';

class SocialLink {
  final String platform;
  final String label;
  final IconData icon;
  final String placeholder;
  final String prefix;

  const SocialLink({
    required this.platform,
    required this.label,
    required this.icon,
    required this.placeholder,
    required this.prefix,
  });
}
