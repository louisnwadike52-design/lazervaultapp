import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/shared_widgets/service_unavailable_modal.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/navigation/back_or_home.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/bills/presentation/view/bill_services_catalogue_store.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

part 'bills_hub_screen_tiles.dart';

class BillsHubScreen extends StatefulWidget {
  const BillsHubScreen({super.key});

  @override
  State<BillsHubScreen> createState() => _BillsHubScreenState();
}

class _BillsHubScreenState extends State<BillsHubScreen>
    with WidgetsBindingObserver {
  // THE MENU IS PAINTED FROM WHAT WE ALREADY KNOW, THEN REFRESHED BEHIND IT.
  //
  // The catalogue lives in [BillServicesCatalogue.store] (user-stamped,
  // country-scoped, mirrored to disk). On open: paint the remembered page at
  // once, fetch in the background, `put` the result — the grid listens to the
  // store's revision and repaints ITSELF, not the scaffold, so a tile an
  // admin toggled updates in place with no spinner over the others. The
  // spinner is reserved for a first open with nothing remembered at all.

  /// Who/where this open is for. Resolved once; the store refuses another
  /// user's page anyway, so a mid-screen switch cannot paint the wrong menu.
  late final String _userId = BillServicesCatalogue.currentUserId();
  late final String _scope = BillServicesCatalogue.currentScope();

  /// True only while the FIRST fetch (nothing cached) is in flight.
  bool _loading = false;

  /// A fetch is already running — a resume while one is in flight must not
  /// start a second.
  bool _refreshing = false;

  /// The latest answer for THIS open when the store could not remember it
  /// (no signed-in user id — `put` is then a no-op). Null means "no
  /// catalogue": every tile falls back to its defaultVisible, as before.
  List<BillServiceEntry>? _unstored;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _paintThenRefresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// An app that stays open must still learn about an admin toggle: refresh
  /// quietly whenever it comes back to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) return;
    // `_refreshing` stops two fetches running at once, but not twenty running
    // in sequence off a flapping foreground. See
    // BillServicesCatalogue.shouldRefreshOnResume for why that happens and
    // why the store's staleness window is the right floor.
    if (!BillServicesCatalogue.shouldRefreshOnResume(
      userId: _userId,
      scope: _scope,
    )) {
      return;
    }
    _refreshInBackground();
  }

  Future<void> _paintThenRefresh() async {
    final store = BillServicesCatalogue.store;
    var cached = store.peek(userId: _userId, scope: _scope);
    if (cached == null) {
      // Cold start: the disk mirror, if any. Nothing to paint until it
      // answers, which is synchronous-fast — well before any network reply.
      cached = await store.hydrate(userId: _userId, scope: _scope);
      if (!mounted) return;
    }
    if (cached == null) {
      // GENUINELY nothing remembered: this is the one case that may block.
      setState(() => _loading = true);
    }
    // Either way the fresh answer is fetched; with rows on screen it lands
    // through the store's revision and repaints only the grid.
    await _refreshInBackground();
  }

  Future<void> _refreshInBackground() async {
    if (_refreshing) return;
    _refreshing = true;
    try {
      final fresh = await BillServicesCatalogue.refresh(
        userId: _userId,
        scope: _scope,
      );
      if (!mounted) return;
      // Only reached when the store could not stamp it (empty user id); a
      // stored page repaints the grid via the store's revision instead.
      if (_userId.isEmpty || _loading) {
        setState(() {
          _unstored = fresh;
          _loading = false;
        });
      }
    } catch (_) {
      // Never blank the hub. With a remembered page on screen a failed
      // refresh changes nothing; with none, fall back to the default tile
      // set (every tile's defaultVisible) exactly as before.
      if (!mounted) return;
      if (_loading) setState(() => _loading = false);
    } finally {
      _refreshing = false;
    }
  }

  /// A tile is visible when the catalogue reports its type enabled. Types the
  /// catalogue doesn't govern (ePIN, betting) — and the whole grid when the
  /// catalogue is unavailable — fall back to defaultVisible.
  static bool _catalogueAllows(Map<String, bool>? enabledByType, _BillType b) {
    if (enabledByType != null) {
      final enabled = enabledByType[b.type];
      if (enabled != null) return enabled;
    }
    return b.defaultVisible;
  }

  /// The admin feature gate for this bill type.
  String _gate(_BillType b) => FeatureFlags.featurePrefix('bill', b.type);

  // TWO INDEPENDENT AUTHORITIES, ANSWERING DIFFERENT QUESTIONS.
  //
  //   catalogue    — can the rail actually deliver right now (provider health)
  //   feature gate — do we want to offer this product, and to whom
  //
  // The catalogue HIDES a tile: a dead rail is not a product decision and
  // there is nothing useful to say to the user about it. The gate DIMS one and
  // explains itself, because a control that vanishes during an outage reads as
  // a bug and costs a support ticket.
  //
  // The whitelist overrides the GATE but never the CATALOGUE — a rail that is
  // down cannot be whitelisted into working, and letting a tester through to a
  // dead provider is how you take a payment for something never delivered.
  // Both are applied at the grid below: `_catalogueAllows` filters the list,
  // `gateAllowed` decides each tile's enabled state.

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // OS/Android back button routes to the dashboard, matching the
      // AppBar back button. Without this the system back would pop the
      // last pushed route which, after deep entries, is the wrong target.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        // backOrHome, not offAllNamed. The original comment here said the
        // system back would "pop the last pushed route which, after deep
        // entries, is the wrong target" — but that case is exactly when
        // canPop() is false, which backOrHome already handles by resetting to
        // the fallback. When there IS something beneath, destroying it is the
        // wrong answer: a user who reached the hub from a send-funds refusal
        // lost the whole flow.
        if (!didPop) {
          backOrHome();
        }
      },
      child: Scaffold(
        backgroundColor: InvoiceThemeColors.primaryBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: backOrHome,
            icon: Container(
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          title: Text(
            'Bills Hub',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            // Chat icon — Utility Payments chat microservice (commerce chat agent).
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: MicroserviceChatIcon(
                serviceName: 'Utility Payments',
                sourceContext: 'bills',
                icon: Icons.chat_bubble_outline,
                iconColor: InvoiceThemeColors.primaryPurple,
                iconSize: 20,
                size: 40,
              ),
            ),
            // Voice icon — routes to the 'bills' voice agent.
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: ServiceVoiceButton(
                serviceName: 'bills',
                iconColor: InvoiceThemeColors.primaryPurple,
                backgroundColor: InvoiceThemeColors.primaryPurple,
                buttonSize: 40.w,
                iconSize: 20.sp,
              ),
            ),
          ],
        ),
        body: ServiceEntranceAnimation(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _billsHubHeaderCard(),
                  SizedBox(height: 16.h),
                  // ONLY the menu repaints when the catalogue or an admin
                  // gate changes — the header, app bar and entrance animation
                  // above are untouched by a background refresh.
                  ValueListenableBuilder<int>(
                    valueListenable: BillServicesCatalogue.store.revision,
                    builder: (context, _, __) => ValueListenableBuilder<int>(
                      // Repaint when a fresh admin snapshot lands, so a type
                      // switched off reaches this screen within one poll
                      // instead of at next launch. The flags themselves are
                      // still read synchronously — nothing here awaits a
                      // network call.
                      valueListenable: FeatureFlags.revision,
                      builder: (context, _, __) => _buildMenu(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: const AlwaysStoppedAnimation<Color>(
              InvoiceThemeColors.primaryPurple,
            ),
          ),
        ),
      );
    }
    // The remembered page wins; the un-storable answer for this open is the
    // fallback; null is "catalogue unavailable".
    final catalogue =
        BillServicesCatalogue.store.peek(userId: _userId, scope: _scope) ??
            _unstored;
    final enabledByType =
        catalogue == null ? null : billServicesEnabledByType(catalogue);
    // Everything the RAIL can serve. The admin gate then decides which of
    // these are offered and which explain themselves.
    final bills =
        _allTiles.where((b) => _catalogueAllows(enabledByType, b)).toList();

    // EVERY tile gone. Possible two ways: the catalogue reports nothing
    // enabled, or an admin has switched every type off. Either way a bare
    // screen reads as a broken app, so say what is happening instead of
    // rendering an empty grid.
    if (bills.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 44.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 12.h),
            Text(
              'Bill payments are not available right now',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Please check back shortly.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        // Compact tiles so bill types fit on screen at a glance.
        childAspectRatio: 1.18,
      ),
      itemCount: bills.length,
      itemBuilder: (context, index) {
        final b = bills[index];
        final enabled = FeatureFlags.gateAllowed(_gate(b));
        return _BillTile(
          icon: b.icon,
          title: b.title,
          description: b.description,
          enabled: enabled,
          onTap: () {
            if (!enabled) {
              showServiceUnavailableModal(
                context,
                serviceName: b.title,
                message: FeatureFlags.gateMessage(_gate(b)),
              );
              return;
            }
            Get.toNamed(b.route);
          },
        );
      },
    );
  }
}
