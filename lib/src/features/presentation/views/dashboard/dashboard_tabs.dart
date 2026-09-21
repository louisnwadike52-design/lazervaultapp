import 'package:flutter/material.dart';

/// The five bottom-nav destinations, in index order.
///
/// WHY THIS EXISTS
/// ---------------
/// The same five tabs were previously described in three places, and all three
/// disagreed. Index 1 alone was "AI Analytics" in [BottomNavMenu], "Statistics"
/// in the dashboard's curved nav, and "Budget" in the Lazerspray room's nav —
/// three names for one destination, with three different icons behind them. A
/// user switching tabs saw the label change under their finger.
///
/// Every bottom nav now renders from this list, so a destination is named and
/// drawn the same way no matter which nav is on screen.
///
/// CASING
/// ------
/// Sentence case, not Title Case: only the first word is capitalised, and
/// acronyms keep their capitals ("AI chat", not "AI Chat"). This matches the
/// rest of the product's control labels.
@immutable
class DashboardTab {
  /// The nav label, in sentence case.
  final String label;

  /// The nav icon. One icon per destination, everywhere.
  final IconData icon;

  const DashboardTab({required this.label, required this.icon});
}

/// Indexed by bottom-nav position; the order matches
/// `DashboardScreen.tabItems` and the `TabController` it drives.
const List<DashboardTab> kDashboardTabs = <DashboardTab>[
  DashboardTab(label: 'Dashboard', icon: Icons.dashboard_rounded),
  DashboardTab(label: 'AI analytics', icon: Icons.analytics_rounded),
  DashboardTab(label: 'AI chat', icon: Icons.smart_toy_rounded),
  DashboardTab(label: 'Beam', icon: Icons.swap_horiz_rounded),
  DashboardTab(label: 'Lifestyle', icon: Icons.spa_rounded),
];

/// The label for [index], or an empty string when out of range.
///
/// Out-of-range returns empty rather than throwing: these helpers are called
/// from build methods, and a nav bar that renders a blank label is a far better
/// outcome than one that crashes the whole shell.
String dashboardTabLabel(int index) =>
    (index >= 0 && index < kDashboardTabs.length)
        ? kDashboardTabs[index].label
        : '';

/// The icon for [index], falling back to a neutral glyph when out of range.
IconData dashboardTabIcon(int index) =>
    (index >= 0 && index < kDashboardTabs.length)
        ? kDashboardTabs[index].icon
        : Icons.circle;
