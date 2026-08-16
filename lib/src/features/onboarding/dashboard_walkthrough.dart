import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

/// First-run coach-mark walkthrough for the dashboard.
///
/// One focused, brand-purple tooltip per region, shown ONCE PER ACCOUNT (gated
/// by a per-user secure-storage flag), auto-scrolling between regions, with a
/// prominent **Next** and a subtle **Skip**. Replayable from Settings; keeps a
/// running per-account view count.
///
/// Why per-account (not per-install): a brand-new signup — or the first login
/// of any account — must get the tour EVEN on a device another account already
/// toured. Keying "seen" by user id means switching/adding accounts each get
/// their own first-run experience; a returning account never re-sees it.
///
/// Each tooltip carries a directional beak + accent border pointing at its
/// target (above / below / left / right), driven by the [TooltipPosition] passed
/// to [step] — so the card visibly "points" at what it's describing.
///
/// The bottom navigation is toured item-by-item for the high-value items only
/// (see [_navTour]): rather than reaching into the adaptive nav bar (MotionTabBar
/// vs CurvedNavigationBar) for per-item keys, [bottomNavTourTargets] overlays
/// five equal, transparent slots across the bar and highlights each toured item
/// on its own step; the un-toured slots are invisible spacers that keep the
/// toured targets aligned over the right nav items.
///
/// Persistence note (UI ↔ backend): "seen" is intentionally DEVICE-LOCAL
/// (secure storage), not a synced backend field — a walkthrough is a first-run
/// UX and is replayable from Settings. It is keyed by user id, so it is
/// per-account ON THIS DEVICE: the same account signing in on a fresh device
/// gets the tour again there (acceptable — it's a new device, and there is no
/// backend "seen" field to consult).
class DashboardWalkthrough {
  DashboardWalkthrough._();

  // Walkthrough gating uses SharedPreferences (NOT FlutterSecureStorage): the
  // secure store is WIPED by SecureStorageService.clearAll() on logout, which
  // erased the "seen" flag and re-showed the tour after EVERY sign-in. These
  // seen/count flags are non-sensitive first-run UX state that must survive
  // logout, so they live in SharedPreferences.
  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  // Per-account secure-storage keys. Keying "seen"/"count" by user id is what
  // makes the tour show for every new signup / first login even when another
  // account already toured this device. A blank userId is never keyed on (the
  // callers no-op) so we can't create a shared "" bucket that leaks across
  // accounts.
  static String _seenKey(String userId) =>
      'has_seen_dashboard_walkthrough_$userId';
  static String _countKey(String userId) =>
      'dashboard_walkthrough_view_count_$userId';

  /// The account the tour is currently running for. Set by [maybeStart] /
  /// [replay] so the userId-less finish paths — [ShowCaseWidget.onFinish] and
  /// the coach card's Skip/Done — persist "seen" against the RIGHT account.
  static String? _activeUserId;

  // One GlobalKey per dashboard region (attached via [step]).
  static final topIconsKey = GlobalKey();
  static final avatarKey = GlobalKey();
  static final accountsKey = GlobalKey();
  static final servicesKey = GlobalKey();
  static final historyKey = GlobalKey();

  // One key per TOURED bottom-nav item (see [_navTour]). The bar always has 5
  // items, but only the high-value ones are toured — the rest are laid out as
  // transparent spacers so the toured targets still align over the right slots.
  static final navKeys =
      List<GlobalKey>.generate(_navTour.length, (_) => GlobalKey());

  /// Ordered list driving the tour sequence (top → down the body → each toured
  /// nav item left-to-right). Step numbers ("n / total") are DERIVED from this
  /// list, so adding/removing a step never requires renumbering call sites.
  static List<GlobalKey> get _orderedKeys => [
        topIconsKey,
        avatarKey,
        accountsKey,
        servicesKey,
        historyKey,
        ...navKeys,
      ];

  static int get totalSteps => _orderedKeys.length;

  /// 1-based position of [key] in the tour (0 if not currently in the tour).
  static int stepIndexOf(GlobalKey key) => _orderedKeys.indexOf(key) + 1;

  // The bottom-nav items worth touring for a first-run user, each tagged with
  // the 0-based tab slot (of 5) it sits over so its transparent showcase target
  // lands on the right item. Home (you're already on it), AI Analytics and
  // Lifestyle are intentionally left un-toured to keep the tour focused.
  static const List<({int slot, String title, String body})> _navTour = [
    (
      slot: 2,
      title: 'AI Chat',
      body: 'Ask me to move money, pay bills or check balances — just type.',
    ),
    (
      slot: 3,
      title: 'Move Money',
      body: 'Beam money to your own linked banks and other accounts.',
    ),
  ];

  // Total number of bottom-nav slots the bar lays out (toured or not).
  static const int _navSlotCount = 5;

  // ---- gating + counts ------------------------------------------------------

  static Future<bool> _shouldShow(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await _prefs;
    return prefs.getString(_seenKey(userId)) != 'true';
  }

  /// Mark the tour finished/skipped for the ACTIVE account so it won't auto-show
  /// again for them. No-op if we somehow have no active account (never persist
  /// against a blank key). Called from [ShowCaseWidget.onFinish] and the coach
  /// card's Skip/Done — all userId-less, hence the [_activeUserId] indirection.
  static Future<void> markSeen() async {
    final uid = _activeUserId;
    if (uid == null || uid.isEmpty) return;
    final prefs = await _prefs;
    await prefs.setString(_seenKey(uid), 'true');
  }

  /// Clear a specific account's seen flag so the tour replays on their next
  /// dashboard load (Settings → "Replay app tour").
  static Future<void> reset(String userId) async {
    if (userId.isEmpty) return;
    final prefs = await _prefs;
    await prefs.remove(_seenKey(userId));
  }

  static Future<int> viewCount(String userId) async {
    if (userId.isEmpty) return 0;
    final prefs = await _prefs;
    return prefs.getInt(_countKey(userId)) ?? 0;
  }

  static Future<int> _bumpViewCount(String userId) async {
    if (userId.isEmpty) return 0;
    final next = (await viewCount(userId)) + 1;
    final prefs = await _prefs;
    await prefs.setInt(_countKey(userId), next);
    return next;
  }

  // ---- lifecycle ------------------------------------------------------------

  /// Auto-start the tour on the dashboard's first frame IF [userId] has never
  /// seen it on this device. No-op on a blank userId (auth not ready) or once
  /// seen. Safe to call every dashboard build. Setting [_activeUserId] up front
  /// binds the finish/skip paths to this account even before the tour starts.
  static void maybeStart(BuildContext context, {required String userId}) {
    if (userId.isEmpty) return;
    _activeUserId = userId;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!await _shouldShow(userId)) return;
      await _bumpViewCount(userId);
      // Persist "seen" the MOMENT the tour actually starts — not only on
      // finish/skip. Rationale: if the coach card can't render its Skip/Next
      // (e.g. a font that failed to load leaves a blank card), the user could
      // never dismiss it, and the tour would re-pop on EVERY dashboard load.
      // Marking seen on a successful start makes it auto-show EXACTLY ONCE per
      // account on this device (still replayable from Settings). Only persist
      // when it truly started so a missing showcase scope doesn't burn the tour.
      if (_start()) {
        final prefs = await _prefs;
        await prefs.setString(_seenKey(userId), 'true');
      }
    });
  }

  /// Force-start for [userId] (Settings "Replay app tour") regardless of the
  /// seen flag.
  static void replay(BuildContext context, {required String userId}) {
    if (userId.isEmpty) return;
    _activeUserId = userId;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _bumpViewCount(userId);
      _start();
    });
  }

  /// Starts the showcase. Returns true only if it actually started (a
  /// ShowCaseWidget scope is registered). Context-free controller: `get()`
  /// THROWS if no scope is registered (e.g. the user navigated away during the
  /// async gating read) — swallowed so the tour never crashes.
  static bool _start() {
    try {
      ShowcaseView.get().startShowCase(_orderedKeys);
      return true;
    } catch (_) {
      // No registered showcase scope — nothing to start. Safe to ignore.
      return false;
    }
  }

  // ---- widget wiring --------------------------------------------------------

  /// Wrap the dashboard subtree so all [step]s below share one showcase scope.
  static Widget wrapShowcase({required WidgetBuilder builder}) {
    return ShowCaseWidget(
      // Auto-scroll body targets (history/portfolio) into view before showing.
      enableAutoScroll: true,
      disableBarrierInteraction: true,
      blurValue: 1,
      onFinish: markSeen, // completing the last step counts as "seen"
      builder: builder,
    );
  }

  /// Wrap a target region with a custom, directional coach-mark tooltip.
  /// [position] controls which side of the target the tooltip sits on AND the
  /// side its beak/accent-border points from. The "n / total" number is derived
  /// from [key]'s position in the tour, so no manual index is needed.
  static Widget step({
    required GlobalKey key,
    required String title,
    required String body,
    required Widget child,
    TooltipPosition position = TooltipPosition.bottom,
    EdgeInsets targetPadding = const EdgeInsets.all(6),
  }) {
    return Showcase.withWidget(
      key: key,
      targetPadding: targetPadding,
      tooltipPosition: position,
      disableDefaultTargetGestures: true,
      container: _CoachCard(
        indexKey: key,
        title: title,
        body: body,
        position: position,
      ),
      child: child,
    );
  }

  /// Five equal, transparent slots laid across the bottom nav so toured items
  /// can be highlighted without reaching into the adaptive nav bar's internals.
  /// Only the slots named in [_navTour] carry a showcase target; the rest are
  /// invisible spacers that keep the toured targets aligned over the right nav
  /// items. Drop into the `bottomNavigationBar`'s Stack as a Positioned.fill
  /// sibling ABOVE the real nav; IgnorePointer keeps real taps flowing to the
  /// nav once the tour is done.
  static Widget bottomNavTourTargets() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Row(
          children: [
            for (int slot = 0; slot < _navSlotCount; slot++)
              Expanded(child: _navSlot(slot)),
          ],
        ),
      ),
    );
  }

  /// A single bottom-nav slot: a showcase target if [slot] is toured, else a
  /// transparent spacer that just holds its share of the row width.
  static Widget _navSlot(int slot) {
    final i = _navTour.indexWhere((t) => t.slot == slot);
    if (i < 0) return const SizedBox.expand();
    return step(
      key: navKeys[i],
      title: _navTour[i].title,
      body: _navTour[i].body,
      // Tooltip sits ABOVE the nav, beak pointing DOWN at the item.
      position: TooltipPosition.top,
      targetPadding: const EdgeInsets.symmetric(vertical: 4),
      child: const SizedBox.expand(),
    );
  }
}

/// Brand-purple coach-mark card with a directional beak + accent border that
/// points at its target. Uses the context-free [ShowcaseView] controller so it
/// never depends on overlay context.
class _CoachCard extends StatelessWidget {
  const _CoachCard({
    required this.indexKey,
    required this.title,
    required this.body,
    required this.position,
  });

  // The target's key — its "n / total" number is derived from its live position
  // in the tour, so a conditional/added step never needs manual renumbering.
  final GlobalKey indexKey;
  final String title;
  final String body;
  final TooltipPosition position;

  // Purplish theme.
  static const _card = Color(0xFF1E1533); // dark purple-tinted card
  static const _accent = Color(0xFF8B5CF6); // vivid purple — pointer/border/step
  static const _button = Color(0xFF6F42C1); // Next button
  static const _textSecondary = Color(0xFFB8A9DC); // soft lavender-grey

  int get index => DashboardWalkthrough.stepIndexOf(indexKey);
  bool get _isLast => index >= DashboardWalkthrough.totalSteps;

  /// Which edge of the card faces (points at) the target.
  AxisDirection get _pointDirection {
    switch (position) {
      case TooltipPosition.bottom: // tooltip below target → point UP
        return AxisDirection.up;
      case TooltipPosition.top: // tooltip above target → point DOWN
        return AxisDirection.down;
      case TooltipPosition.left: // tooltip left of target → point RIGHT
        return AxisDirection.right;
      case TooltipPosition.right: // tooltip right of target → point LEFT
        return AxisDirection.left;
    }
  }

  @override
  Widget build(BuildContext context) {
    final beak = _Beak(direction: _pointDirection, color: _accent);
    final card = _buildCard();

    // Arrange [beak · card] so the beak sits on the target-facing edge.
    switch (_pointDirection) {
      case AxisDirection.up:
        return _wrap(Column(mainAxisSize: MainAxisSize.min, children: [beak, card]));
      case AxisDirection.down:
        return _wrap(Column(mainAxisSize: MainAxisSize.min, children: [card, beak]));
      case AxisDirection.left:
        return _wrap(Row(mainAxisSize: MainAxisSize.min, children: [beak, card]));
      case AxisDirection.right:
        return _wrap(Row(mainAxisSize: MainAxisSize.min, children: [card, beak]));
    }
  }

  Widget _wrap(Widget child) => Material(color: Colors.transparent, child: child);

  Widget _buildCard() {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.w),
      padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        // UNIFORM border only — Flutter forbids a borderRadius with a
        // non-uniform (per-side colored) Border and throws during paint,
        // which aborts painting the card's text children (blank card). The
        // directional beak already points at the target.
        border: Border.all(color: _accent.withValues(alpha: 0.55), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: 0.25),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index / ${DashboardWalkthrough.totalSteps}',
            style: TextStyle(
              color: _accent,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            body,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12.5.sp,
              height: 1.35,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Subtle Skip — always available, low emphasis.
              TextButton(
                onPressed: () {
                  ShowcaseView.get().dismiss();
                  DashboardWalkthrough.markSeen();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Prominent Next / Done — draws the user through the tour.
              ElevatedButton(
                onPressed: () {
                  if (_isLast) {
                    ShowcaseView.get().dismiss();
                    DashboardWalkthrough.markSeen();
                  } else {
                    ShowcaseView.get().next();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _button,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _isLast ? 'Done' : 'Next',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small solid triangle "beak" pointing in [direction], drawn in [color] so
/// the coach card visibly points at its target. For up/down it's a wide-based
/// horizontal triangle; for left/right a tall vertical one.
class _Beak extends StatelessWidget {
  const _Beak({required this.direction, required this.color});

  final AxisDirection direction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool vertical =
        direction == AxisDirection.up || direction == AxisDirection.down;
    final double w = vertical ? 18.w : 9.w;
    final double h = vertical ? 9.h : 18.h;
    return CustomPaint(
      size: Size(w, h),
      painter: _BeakPainter(direction: direction, color: color),
    );
  }
}

class _BeakPainter extends CustomPainter {
  _BeakPainter({required this.direction, required this.color});

  final AxisDirection direction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    switch (direction) {
      case AxisDirection.up: // apex at top-center, base along the bottom
        path
          ..moveTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        break;
      case AxisDirection.down: // apex at bottom-center, base along the top
        path
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width / 2, size.height)
          ..close();
        break;
      case AxisDirection.left: // apex at left-center, base along the right
        path
          ..moveTo(0, size.height / 2)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..close();
        break;
      case AxisDirection.right: // apex at right-center, base along the left
        path
          ..moveTo(size.width, size.height / 2)
          ..lineTo(0, 0)
          ..lineTo(0, size.height)
          ..close();
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BeakPainter oldDelegate) =>
      oldDelegate.direction != direction || oldDelegate.color != color;
}
