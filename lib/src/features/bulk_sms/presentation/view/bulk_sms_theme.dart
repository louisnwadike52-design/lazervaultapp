import 'package:flutter/material.dart';

/// Shared colour + gradient tokens for the Bulk SMS screens. Mirrors the app's
/// brand purple (`#4E03D0`) on dark surfaces, matching the betting/airtime
/// service themes.
class BulkSmsTheme {
  const BulkSmsTheme._();

  static const Color brand = Color(0xFF4E03D0);
  static const Color primary = Color.fromARGB(255, 78, 3, 208);
  static const Color bg = Color(0xFF0A0A0A);
  static const Color card = Color(0xFF1F1F1F);
  static const Color divider = Color(0xFF2D2D2D);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color textSecondary = Color(0xFF9CA3AF);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4E03D0), Color(0xFF7B3FE4)],
  );
}

/// A rounded card wrapped in the brand gradient — used for hero balance/total
/// panels across the flow.
class BulkSmsGradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const BulkSmsGradientCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: BulkSmsTheme.brandGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
