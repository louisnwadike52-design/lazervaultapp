part of 'investments_screen.dart';

class InvestmentOption {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final String? route;
  final Map<String, dynamic>? routeArgs;
  final bool isPopular;
  final String riskBadge;
  final String complianceBadge;
  // When true the option is kept in the list (code/route/config preserved) but
  // NOT displayed anywhere in the investment account — used to temporarily hide
  // a product from the UI without deleting it. See _visibleOptions.
  final bool hidden;

  InvestmentOption({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    this.route,
    this.routeArgs,
    this.isPopular = false,
    required this.riskBadge,
    required this.complianceBadge,
    this.hidden = false,
  });
}
