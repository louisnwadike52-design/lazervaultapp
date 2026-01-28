import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Base card widget for wrapped experience with animated gradient background
class WrappedCardBase extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final String? title;
  final String? subtitle;
  final bool showLogo;
  final VoidCallback? onTap;

  const WrappedCardBase({
    super.key,
    required this.child,
    required this.gradientColors,
    this.title,
    this.subtitle,
    this.showLogo = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLogo) ...[
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Financial Wrapped',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
                if (title != null) ...[
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Card color themes for different wrapped cards
class WrappedColors {
  static const List<Color> summary = [
    Color(0xFF667eea),
    Color(0xFF764ba2),
  ];

  static const List<Color> categories = [
    Color(0xFF11998e),
    Color(0xFF38ef7d),
  ];

  static const List<Color> merchants = [
    Color(0xFFf093fb),
    Color(0xFFf5576c),
  ];

  static const List<Color> trends = [
    Color(0xFF4facfe),
    Color(0xFF00f2fe),
  ];

  static const List<Color> aiInsights = [
    Color(0xFFa8edea),
    Color(0xFFfed6e3),
  ];

  static const List<Color> funFacts = [
    Color(0xFFffecd2),
    Color(0xFFfcb69f),
  ];

  static const List<Color> achievements = [
    Color(0xFFffd700),
    Color(0xFFffa500),
  ];

  static const List<Color> share = [
    Color(0xFF232526),
    Color(0xFF414345),
  ];
}
