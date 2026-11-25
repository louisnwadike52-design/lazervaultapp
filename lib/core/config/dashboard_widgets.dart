import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';

/// BASIC OR ADVANCED — WHAT A DASHBOARD SHOWS BEFORE ANYONE ASKS FOR IT.
///
/// ## Why
///
/// The dashboard shows every section it has to every user from their first
/// session: recent activity, trending crowdfunds, public groups, the
/// portfolio, exchange rates, the monthly analysis. For someone who opened
/// the app to send money, most of that is scenery — and the services that
/// actually earn (transfers, bills, gift cards, tap-to-pay, contactless, P2P
/// crypto) are competing with it for the same screen.
///
/// So the page has two shapes:
///
///   * **Basic** — the money-intensive services, and nothing below them that
///     the user has not asked for. Each extra section is ADDED deliberately.
///   * **Advanced** — everything, as today, minus anything the user removed.
///
/// The Revolut shape: a section is not missing, it is not yet added, and the
/// place to add one is always on the page.
///
/// ## Who decides what
///
///   * The OPERATOR sets which mode a user starts in, which services make up
///     the basic set, whether the customise affordance exists at all, and can
///     withdraw any single section outright. All from the console, none of it
///     compiled.
///   * The USER moves between the two modes and adds or removes individual
///     sections. Their choice is local to the device, like the existing
///     dashboard-layout pick.
///
/// Advanced is the shipped default, so nothing changes for anyone until an
/// operator chooses otherwise.
///
/// ## The keys
///
/// All in the `feature_` family, which the gateway's bulk read already serves
/// and its write validator already accepts — so none of this needs a gateway
/// allow-list change, which is the step that has been forgotten before and
/// leaves a setting that saves and reaches no phone.
enum DashboardUiMode {
  /// Money services only; sections are opt-in.
  basic,

  /// Everything, minus what the user removed.
  advanced,
}

/// One section of the dashboard that a user may add or remove.
class DashboardWidgetSpec {
  const DashboardWidgetSpec({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
  });

  /// Stable, and part of two setting keys — never rename one in place.
  final String id;
  final String label;
  final String description;
  final IconData icon;

  /// The operator's kill switch for this section, independent of any user's
  /// choice. Generic gate family, so it comes with a whitelist for free.
  String get adminPrefix => FeatureFlags.featurePrefix('dashboardwidget', id);
}

/// The sections, in the order they appear down the page.
///
/// Recent activity is deliberately NOT here. It is the record of the user's
/// own money and the one thing a dashboard cannot sensibly be without; making
/// it removable would let someone hide their own transactions from themselves
/// and then report the app as having lost them.
const List<DashboardWidgetSpec> kDashboardWidgets = [
  DashboardWidgetSpec(
    id: 'crowdfunds',
    label: 'Trending crowdfunds',
    description: 'Campaigns other people are backing right now.',
    icon: Icons.volunteer_activism_rounded,
  ),
  DashboardWidgetSpec(
    id: 'public_groups',
    label: 'Public group funds',
    description: 'Open group pots you can join.',
    icon: Icons.groups_rounded,
  ),
  DashboardWidgetSpec(
    id: 'portfolio',
    label: 'Portfolio',
    description: 'What your investments are worth.',
    icon: Icons.show_chart_rounded,
  ),
  DashboardWidgetSpec(
    id: 'exchange_rates',
    label: 'Exchange rates',
    description: 'Live rates for the currencies you hold.',
    icon: Icons.currency_exchange_rounded,
  ),
  DashboardWidgetSpec(
    id: 'monthly_summary',
    label: 'Monthly analysis',
    description: 'What you spent this month, by category.',
    icon: Icons.insights_rounded,
  ),
];

/// THE SECTIONS THE CUSTOMISE CARD CAN FOLLOW.
///
/// One per section the dashboard renders, in the order they appear, plus
/// `bottom` for the old behaviour. These are what an operator types into
/// `feature_dashboard_customise_position`, so they are deliberately the same
/// words the sections are known by elsewhere rather than a parallel
/// vocabulary that could drift from them.
const List<String> kCustomiseAnchors = [
  'services', // the quick-services grid
  'extras', // adverts, family CTA, invite friends
  'history', // recent activity  ← the default
  'communal', // crowdfunds and public groups
  'portfolio',
  'exchange_rates',
  'monthly_summary',
  'bottom', // the foot of the page, wherever that falls
];

/// Directly under recent activity — the one section every customer scrolls
/// to, so the control that shapes the page is found rather than hunted for.
const String kCustomiseAnchorDefault = 'history';

class DashboardWidgets {
  const DashboardWidgets._();

  // ── Admin keys ─────────────────────────────────────────────────────────

  /// "true" → a user with no choice of their own starts in BASIC.
  ///
  /// Default OFF, so advanced stays the shipped behaviour and switching this
  /// on is a deliberate act with a visible effect.
  static const String basicDefaultPrefix = 'feature_dashboard_basicdefault';

  /// "false" → no customise affordance anywhere, and the mode is whatever the
  /// operator set. For a deployment that wants one fixed dashboard.
  static const String customisePrefix = 'feature_dashboard_customise';

  /// CSV of quick-service ids that make up the BASIC set — the
  /// money-intensive, revenue-earning services. Empty falls back to
  /// [defaultBasicServices] rather than to an empty grid, because a basic
  /// dashboard with no services is worse than one with the compiled set.
  static const String basicServicesKey = 'feature_dashboard_basicservices_list';

  /// The compiled fallback. Matches the operator's own brief: the services
  /// that are money-intensive, earn revenue, and are not interchangeable with
  /// what another app offers.
  /// The ids are `AppServiceName` enum names, which is what the grid
  /// compares against — not a parallel vocabulary that could drift from it.
  static const List<String> defaultBasicServices = [
    'sendFunds', // transfer
    'batchTransfer', // many payees at once — the same send, at scale
    'payBills', // bill payments
    'giftCards',
    'tagPay', // tap to pay
    'contactlessPay',
    'crypto', // P2P crypto
    'aiScanToPay', // scan a bill or a code and pay it
    'autoSave', // money moved on a rule the customer set
    'idPay', // pay to an identity rather than an account number
  ];

  // ── Per-user keys ──────────────────────────────────────────────────────

  static const String _userMode = 'user_dashboard_ui_mode';

  /// A section the user explicitly added or removed. Absent means "follow the
  /// mode" — which is what makes a mode switch move every section the user
  /// has not personally decided about.
  static String _userSectionKey(String id) => 'user_dashboard_widget_$id';

  static SharedPreferences? get _prefs => FeatureFlags.prefsForDashboard;

  /// Bumped on every change so a live dashboard rebuilds — it is kept alive
  /// inside the TabBarView and will not rebuild on its own.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  /// BOTH NOTIFIERS, ALWAYS TOGETHER.
  ///
  /// The sections below the fold listen to [revision]; the quick-services
  /// grid above them is already wrapped in a listener on
  /// `FeatureFlags.dashboardLayoutRevision`. A mode switch changes both
  /// halves of the page, so bumping only one left the grid showing every
  /// service under a dashboard that had just become basic — half-applied,
  /// which reads as the switch being broken rather than partial.
  static void _bump() {
    revision.value++;
    FeatureFlags.dashboardLayoutRevision.value++;
  }

  // ── Mode ───────────────────────────────────────────────────────────────

  /// Whether the two-mode system is offered to the user at all.
  static bool get customisable => FeatureFlags.gateAvailable(customisePrefix);

  /// The mode a user with no choice of their own lands in.
  static DashboardUiMode get operatorDefaultMode =>
      FeatureFlags.gateAvailable(basicDefaultPrefix, defaultOn: false)
          ? DashboardUiMode.basic
          : DashboardUiMode.advanced;

  /// The mode in force. The user's own pick wins, and only while the operator
  /// is offering the choice — withdrawing it must not strand someone in a
  /// mode they can no longer leave.
  static DashboardUiMode get mode {
    if (!customisable) return operatorDefaultMode;
    final raw = (_prefs?.getString(_userMode) ?? '').trim();
    if (raw == DashboardUiMode.basic.name) return DashboardUiMode.basic;
    if (raw == DashboardUiMode.advanced.name) return DashboardUiMode.advanced;
    return operatorDefaultMode;
  }

  static bool get isBasic => mode == DashboardUiMode.basic;

  static Future<void> setMode(DashboardUiMode m) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setString(_userMode, m.name);
    _bump();
  }

  // ── Sections ───────────────────────────────────────────────────────────

  /// Whether [id] should be on the page right now.
  ///
  /// Three questions in order, and the order is the whole contract:
  ///
  ///   1. has the OPERATOR withdrawn this section? Then nobody sees it,
  ///      whatever they chose — a product taken off the shelf is off.
  ///   2. has the USER decided about this section? Then their answer stands,
  ///      in either mode.
  ///   3. otherwise the MODE decides: everything in advanced, nothing in
  ///      basic.
  static bool isVisible(String id) {
    if (!FeatureFlags.gateAvailable(
        FeatureFlags.featurePrefix('dashboardwidget', id))) {
      return false;
    }
    final choice = _prefs?.getBool(_userSectionKey(id));
    if (choice != null) return choice;
    return !isBasic;
  }

  /// True when the user has personally decided about this section, rather
  /// than inheriting the mode. Lets the customise sheet show "following
  /// Basic/Advanced" instead of implying a choice nobody made.
  static bool hasUserChoice(String id) =>
      _prefs?.getBool(_userSectionKey(id)) != null;

  static Future<void> setVisible(String id, bool visible) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setBool(_userSectionKey(id), visible);
    _bump();
  }

  /// Drop the per-section overrides so every section follows the mode again.
  /// What "Upgrade the UI" does: switching to advanced with three sections
  /// individually removed would otherwise upgrade into a dashboard still
  /// missing them, which reads as the switch not working.
  static Future<void> followMode() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    for (final w in kDashboardWidgets) {
      await prefs.remove(_userSectionKey(w.id));
    }
    _bump();
  }

  // ── Where the customise control sits ───────────────────────────────────

  /// WHICH SECTION THE CUSTOMISE CARD FOLLOWS.
  ///
  /// It used to be pinned to the very bottom of the page, under the monthly
  /// summary — which in BASIC mode is the foot of a short page, and in
  /// ADVANCED is a long scroll past everything. Either way it sat below the
  /// one section every customer actually scrolls to, their recent activity,
  /// so the control that shapes the page was the last thing on it.
  ///
  /// The operator picks the anchor, because where an invitation belongs
  /// depends on what the deployment wants people to find — and that is a
  /// merchandising decision, not a layout constant. Every section on the page
  /// is addressable; the default is [kCustomiseAnchorDefault], directly under
  /// recent activity.
  ///
  /// An unknown value falls back to the default rather than to "nowhere": a
  /// typo in the console must not make the only way back to a full dashboard
  /// disappear.
  static const String customisePositionKey =
      'feature_dashboard_customise_position';

  static String get customisePosition {
    final raw = (_prefs?.getString(customisePositionKey) ?? '')
        .trim()
        .toLowerCase();
    if (raw.isEmpty) return kCustomiseAnchorDefault;
    return kCustomiseAnchors.contains(raw) ? raw : kCustomiseAnchorDefault;
  }

  /// True when the card belongs directly after [anchor].
  ///
  /// Asked per section rather than resolved into an index, so a section that
  /// is hidden for this customer simply never asks — the card lands under the
  /// next one that renders instead of vanishing with its anchor.
  static bool customiseGoesAfter(String anchor) =>
      customisable && customisePosition == anchor;

  // ── Quick services ─────────────────────────────────────────────────────

  /// The service ids a BASIC dashboard shows. Advanced shows everything, so
  /// this is only consulted in basic mode.
  static List<String> get basicServices {
    final raw = (_prefs?.getString(basicServicesKey) ?? '').trim();
    if (raw.isEmpty) return defaultBasicServices;
    final ids = raw
        .split(',')
        .map((s) => s.trim().toLowerCase())
        .where((s) => s.isNotEmpty)
        .toList(growable: false);
    // A list that parses to nothing is a typo, not a choice. Falling through
    // to the compiled set beats rendering an empty grid.
    return ids.isEmpty ? defaultBasicServices : ids;
  }

  /// Whether a quick service belongs on the grid right now.
  ///
  /// BOTH SIDES ARE CASE-FOLDED. The ids are `AppServiceName` enum names, so
  /// they are camelCase in the app and whatever an operator types in the
  /// console — and comparing a folded console value against an unfolded
  /// compiled default matched nothing, which emptied the basic grid of the
  /// very services it exists to show.
  static bool showsService(String serviceId) {
    if (!isBasic) return true;
    final want = serviceId.trim().toLowerCase();
    return basicServices.any((s) => s.toLowerCase() == want);
  }
}
