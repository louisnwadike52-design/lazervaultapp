import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/core/services/service_order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/config/locale_gating.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/dashboard_state_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/core/config/app_environment.dart';
import 'package:lazervault/core/services/service_usage_service.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';
import 'package:lazervault/src/features/widgets/all_services_bottom_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// Quick Services carousel - 3 rows with reduced indicator spacing
// Context-aware: switches between personal and business services based on active account
class AppServicesBuilder extends StatefulWidget {
  /// When true the quick-service tiles render slightly shorter (the showcase
  /// dashboard layout uses this to make room for the adverts carousel below).
  final bool compact;
  const AppServicesBuilder({super.key, this.compact = false});

  /// Tile aspect ratio — higher = shorter tiles. Kept in ONE place so the
  /// carousel height (computed from it) and the grid delegate never drift.
  double get tileAspectRatio => compact ? 0.95 : 0.85;

  /// Every platform service across all account types (deduped) — the corpus the
  /// dashboard swipe-down search filters over. Public forwarder to the State's
  /// static list (same library).
  static List<AppService> getAllServices() =>
      _AppServicesBuilderState.getAllServices();

  /// Whether the ACTIVE account offers a given service. Public forwarder to
  /// the State's implementation (same library), matching getAllServices above.
  ///
  /// The dashboard's discovery sections use this so they can never disagree
  /// with the quick-service grid about what an account can do.
  static bool activeAccountSupports(AppServiceName name) =>
      _AppServicesBuilderState.activeAccountSupports(name);

  /// True only when the active account is the PERSONAL wallet, and only once
  /// that has actually been resolved.
  ///
  /// Distinct from `activeAccountSupports` on purpose. That one answers "does
  /// this account offer the service", and when the account type is not yet
  /// known it resolves against null — which falls to the personal service list
  /// by default. For the quick-grid that default is harmless (the grid rebuilds
  /// the moment the type arrives). For a dashboard SECTION it is not: the lower
  /// sections build before the grid has resolved anything, so a communal rail
  /// would flash onto a business or savings account for a frame or more.
  ///
  /// An unresolved account therefore answers FALSE here. Hiding a section for a
  /// frame and then showing it is correct; showing it on the wrong account and
  /// then taking it away is not.
  static bool activeAccountIsPersonal() =>
      _AppServicesBuilderState.activeAccountIsPersonal();

  /// The curated service list for one account TYPE, before any locale or
  /// feature-flag hiding. Public forwarder, matching the two above.
  ///
  /// Exists so the per-type lists are assertable on their own: which flows a
  /// savings pot or a family pool offers is a product rule about what the
  /// backend will accept for that wallet, and a rule worth a test is worth
  /// being reachable from one.
  static List<AppService> servicesForAccountType(VirtualAccountType? type) =>
      _AppServicesBuilderState.servicesForAccountTypePublic(type);

  @override
  State<AppServicesBuilder> createState() => _AppServicesBuilderState();
}

class _AppServicesBuilderState extends State<AppServicesBuilder> {
  late int _currentIndex;
  final DashboardStateManager _stateManager =
      serviceLocator<DashboardStateManager>();
  final AccountManager _accountManager = serviceLocator<AccountManager>();
  StreamSubscription<String>? _currencySubscription;
  StreamSubscription<String?>? _accountSubscription;
  VirtualAccountType? _activeAccountType;
  bool _isFamilyPendingSetup = false;
  bool _isFamilyProcessing = false;
  String? _activeFamilyAccountId;
  bool _isResolvingFamilyId = false;

  // ── Drag-to-arrange ────────────────────────────────────────────────────────
  // Long-press a tile to pick it up, drop it where you want it. Dropping saves
  // the arrangement and turns adaptive ordering OFF — see ServiceOrderService:
  // an order the user set by hand must not be re-sorted by a later usage tally.
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  /// Global index (across pages) of the tile currently being dragged.
  int? _draggingIndex;

  /// Page count of the last build — needed by the edge auto-advance, which runs
  /// from a drag callback rather than inside build().
  int _pageCount = 1;

  /// Debounces edge auto-advance so a slow drag near the edge doesn't flip
  /// through every page at once.
  DateTime _lastEdgeFlip = DateTime.fromMillisecondsSinceEpoch(0);

  /// Only the PERSONAL grid is arrangeable — the other account types carry a
  /// hand-picked order that isn't the user's to rearrange.
  bool get _reorderEnabled =>
      identical(_rawServicesForActiveAccount(), _personalServices);

  static const int _itemsPerRow = 4;
  static const int _maxRows = 3;
  static const int _itemsPerPage = _itemsPerRow * _maxRows; // 12 items per page

  // Personal services (existing 19 services)
  static const List<AppService> _personalServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.tagPay, serviceImg: AppServiceImg.tagPay),
    // Split Bills used to be reachable only from inside the Move Money hub,
    // which buried a service people use constantly. It sits beside Tag Pay
    // because they're the same idea — asking other people for money.
    AppService(
        serviceName: AppServiceName.splitBills,
        serviceImg: AppServiceImg.splitBills),
    AppService(
        serviceName: AppServiceName.escrow, serviceImg: AppServiceImg.escrow),
    AppService(
        serviceName: AppServiceName.invoice, serviceImg: AppServiceImg.invoice),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
    AppService(
        serviceName: AppServiceName.invest, serviceImg: AppServiceImg.invest),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.crypto, serviceImg: AppServiceImg.crypto),
    AppService(serviceName: AppServiceName.rmb, serviceImg: AppServiceImg.rmb),
    AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
    AppService(
        serviceName: AppServiceName.aiScanToPay,
        serviceImg: AppServiceImg.aiScanToPay),
    AppService(
        serviceName: AppServiceName.qrPay, serviceImg: AppServiceImg.qrPay),
    AppService(
        serviceName: AppServiceName.contactlessPay,
        serviceImg: AppServiceImg.contactlessPay),
    AppService(
        serviceName: AppServiceName.groupAccount,
        serviceImg: AppServiceImg.groupAccount),
    AppService(
        serviceName: AppServiceName.insurance,
        serviceImg: AppServiceImg.insurance),
    AppService(
        serviceName: AppServiceName.airtime, serviceImg: AppServiceImg.airtime),
    AppService(
        serviceName: AppServiceName.autoSave,
        serviceImg: AppServiceImg.autoSave),
    AppService(
        serviceName: AppServiceName.crowdfund,
        serviceImg: AppServiceImg.crowdfund),
    AppService(
        serviceName: AppServiceName.uplift, serviceImg: AppServiceImg.uplift),
    AppService(
        serviceName: AppServiceName.lockFunds,
        serviceImg: AppServiceImg.lockFunds),
    AppService(
        serviceName: AppServiceName.whatsappIntegration,
        serviceImg: AppServiceImg.whatsappIntegration),
    AppService(
        serviceName: AppServiceName.phoneBanking,
        serviceImg: AppServiceImg.phoneBanking),
    AppService(
        serviceName: AppServiceName.idPay, serviceImg: AppServiceImg.idPay),
    AppService(
        serviceName: AppServiceName.bulkSms, serviceImg: AppServiceImg.bulkSms),
  ];

  // Business services (shown when Business card is active).
  // NOTE: the "Dashboard" tile was removed — it duplicated services already on
  // this grid. The Business card's CTA now opens the account-details sheet.
  static const List<AppService> _businessServices = [
    AppService(
        serviceName: AppServiceName.businessAnalytics,
        serviceImg: AppServiceImg.businessAnalytics),
    // Sell — the revenue engine (record a sale → credits the business balance,
    // decrements stock, optionally links a customer + issues an invoice). Also
    // reachable from the business dashboard quick actions; surfaced here so the
    // core money-in action is one tap from the Business card.
    AppService(
        serviceName: AppServiceName.sales, serviceImg: AppServiceImg.sales),
    AppService(
        serviceName: AppServiceName.payroll, serviceImg: AppServiceImg.payroll),
    AppService(
        serviceName: AppServiceName.invoice, serviceImg: AppServiceImg.invoice),
    AppService(
        serviceName: AppServiceName.customers,
        serviceImg: AppServiceImg.customers),
    AppService(
        serviceName: AppServiceName.expenses,
        serviceImg: AppServiceImg.expenses),
    AppService(
        serviceName: AppServiceName.inventory,
        serviceImg: AppServiceImg.inventory),
    AppService(serviceName: AppServiceName.tax, serviceImg: AppServiceImg.tax),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
  ];

  // Savings account services — money OUT of a savings pot, and nothing else.
  //
  // Send funds, batch transfer and the bills hub. All three debit the savings
  // wallet directly and every one of them carries the active account id as the
  // funding source, so what the grid offers is exactly what the backend will
  // accept for this wallet.
  //
  // Deliberately narrow. The list used to carry auto-save, lock funds,
  // insurance, exchange, crowdfund and airtime, which put a savings pot at the
  // head of flows it is the wrong instrument for: auto-save and lock funds
  // SAVE INTO a pot rather than out of one (offering them on the pot itself
  // invites saving from savings), and exchange, crowdfund and insurance are
  // wealth flows that belong to a personal wallet. Airtime is reachable through
  // the bills hub, so listing it separately only spent a tile.
  static const List<AppService> _savingsServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
  ];

  // Investment account services (7 services — 1 page)
  static const List<AppService> _investmentServices = [
    AppService(
        serviceName: AppServiceName.invest, serviceImg: AppServiceImg.invest),
    AppService(
        serviceName: AppServiceName.stocks, serviceImg: AppServiceImg.stocks),
    AppService(
        serviceName: AppServiceName.crypto, serviceImg: AppServiceImg.crypto),
    AppService(serviceName: AppServiceName.rmb, serviceImg: AppServiceImg.rmb),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.autoSave,
        serviceImg: AppServiceImg.autoSave),
    AppService(
        serviceName: AppServiceName.lockFunds,
        serviceImg: AppServiceImg.lockFunds),
  ];

  // Multi-currency wallet services — USD/GBP/EUR (8 services — 1 page)
  static const List<AppService> _multiCurrencyServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
    AppService(
        serviceName: AppServiceName.invoice, serviceImg: AppServiceImg.invoice),
    AppService(
        serviceName: AppServiceName.qrPay, serviceImg: AppServiceImg.qrPay),
    AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
    AppService(
        serviceName: AppServiceName.tagPay, serviceImg: AppServiceImg.tagPay),
  ];

  // Family account services — a household-spending pool. Only surfaces the
  // flows that are ALSO permitted server-side for a family virtual account:
  //   - Transfers (Send funds, TagPay) via core-payments' family-gated spend path
  //     (AuthorizeFamilySpend → RecordFamilySpend enforces per-member limits).
  //   - Household bills (Utilities hub → utility-payments-service), which now route
  //     through the same family reserve→capture gate.
  // Wealth/speculative flows (crypto, investments, exchange, gift cards, loans,
  // auto-save, insurance) stay OFF here AND are rejected server-side by
  // accounts-service's family spend gate — so hiding them isn't just cosmetic.
  static const List<AppService> _familyServices = [
    AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    AppService(
        serviceName: AppServiceName.tagPay, serviceImg: AppServiceImg.tagPay),
    AppService(
        serviceName: AppServiceName.payBills,
        serviceImg: AppServiceImg.payBills),
  ];

  // Service entries to HIDE from rendering. The list constants above
  // still carry the entry so routes/handlers + analytics keep resolving,
  // but the user-facing grid skips them. Add a name here to hide it from
  // both Quick Services AND the All Services bottom sheet (which reads
  // the same source list via getAllServices()).
  static const Set<AppServiceName> _hiddenServices = {
    AppServiceName.invest,
    // Airtime lives inside the Utilities hub now; the standalone Quick
    // Services tile is duplicate surface area.
    AppServiceName.airtime,
    // Consolidated into the "WhatsApp/Phone Banking" tile (2026-09-07): the
    // Banking Channels hub manages BOTH channels and links out to the
    // WhatsApp account-linking flow. Route + deep links stay registered.
    AppServiceName.whatsappIntegration,
  };

  /// Hidden set for the CURRENT environment. Stocks (DriveWealth US equities) is
  /// not yet cleared for production, so it's hidden on prod builds only — most
  /// visibly on the Investment-account swipe grid — while staying available in
  /// dev/staging for testing. The route/handler stays registered so deep links
  /// and analytics keep resolving.
  static Set<AppServiceName> get _effectiveHiddenServices {
    final hidden = <AppServiceName>{..._hiddenServices};
    if (currentAppEnvironment.isProduction) {
      hidden.add(AppServiceName.stocks);
    }
    // Insurance is admin-gated and hidden by DEFAULT — see
    // FeatureFlags.insuranceVisible. The screens and routes stay compiled in;
    // only the entry points are withheld, so an admin can restore it from the
    // dashboard without a release. Reading the flag here (rather than editing
    // the service lists) keeps every account type and the All-Services search
    // consistent by construction.
    if (!FeatureFlags.insuranceVisible) {
      hidden.add(AppServiceName.insurance);
    }
    // Bulk SMS is admin-gated and hidden by DEFAULT (product decision
    // 2026-09-07) — same mechanics as Insurance: routes/handlers stay
    // compiled in, only the entry points are withheld.
    if (!FeatureFlags.bulkSmsVisible) {
      hidden.add(AppServiceName.bulkSms);
    }
    // Card acceptance is admin-gated and hidden by DEFAULT. Same mechanics as
    // Insurance and Bulk SMS — and doubly warranted here, because the backend
    // ALSO refuses a charge in a market with no certified rail. The toggle
    // controls the entry point; the server controls whether money can move.
    if (!FeatureFlags.cardAcceptanceVisible) {
      hidden.add(AppServiceName.cardAcceptance);
    }
    // Outside NGN, hide every service the region cannot actually complete.
    //
    // This is an allow-list rather than a deny-list on purpose: a service
    // added later is unavailable in a new region until someone deliberately
    // says otherwise, which is the safe direction. A deny-list would expose
    // each new service everywhere by default and only fail when a user in
    // another region tapped into a flow with no rail behind it.
    //
    // Doing it HERE rather than by editing the per-account service lists keeps
    // the grid and the swipe-down search corpus consistent by construction —
    // the same reason the insurance and bulk-SMS gates live here.
    if (LocaleGating.restricted) {
      final allowed = FeatureFlags.localeNonNgnServiceNames;
      for (final s in getAllServicesUnfiltered()) {
        if (!allowed.contains(s.serviceName.name.toLowerCase())) {
          hidden.add(s.serviceName);
        }
      }
    }
    return hidden;
  }

  /// Every declared service, with NO visibility filtering applied.
  ///
  /// Separate from [getAllServices] because that one filters by
  /// [_effectiveHiddenServices], and the locale gate inside that getter needs
  /// the full corpus to decide what to hide. Calling the filtered version from
  /// there would recurse.
  static List<AppService> getAllServicesUnfiltered() {
    final seen = <AppServiceName>{};
    final out = <AppService>[];
    for (final s in [
      ..._personalServices,
      ..._businessServices,
      ..._savingsServices,
      ..._investmentServices,
      ..._multiCurrencyServices,
      ..._familyServices,
    ]) {
      if (seen.add(s.serviceName)) out.add(s);
    }
    return out;
  }

  /// Every service across all account types, deduped by name — the corpus the
  /// dashboard swipe-down search filters over so the user can find ANY platform
  /// service (not just the current account's quick tiles).
  /// Whether the ACTIVE account offers a given service.
  ///
  /// The dashboard's discovery sections (Trending crowdfunds, Public groups,
  /// Portfolio, Exchange rates) are not universal: a crowdfund or a public
  /// group belongs to a personal wallet, not to a business or savings pot, and
  /// showing them there offers an action the account cannot take. Rather than
  /// hand-maintain a second per-account mapping for the sections, they ask the
  /// SAME per-account-type service lists the quick-service grid is built from,
  /// so the two can never disagree and a service added to a list is offered in
  /// both places at once.
  ///
  /// Honours the hidden-service gates too (admin flags, locale), so a section
  /// disappears wherever its own service does.
  static bool activeAccountSupports(AppServiceName name) {
    final raw = _servicesForAccountType(_lastResolvedAccountType);
    if (!raw.any((s) => s.serviceName == name)) return false;
    return !_effectiveHiddenServices.contains(name);
  }

  /// See [AppServicesBuilder.activeAccountIsPersonal].
  ///
  /// `main` counts with `personal`: the two share one service list and are the
  /// same wallet to a customer. NULL does NOT — an unresolved account is not
  /// yet known to be personal, and the switch above would otherwise default it
  /// into the personal list.
  static bool activeAccountIsPersonal() =>
      _lastResolvedAccountType == VirtualAccountType.personal ||
      _lastResolvedAccountType == VirtualAccountType.main;

  /// The account type the grid most recently resolved.
  ///
  /// Static because the dashboard's sections are built outside this widget and
  /// must not each re-resolve the active account — that would mean several
  /// independent lookups disagreeing mid-switch.
  static VirtualAccountType? _lastResolvedAccountType;

  /// Public entry point for [AppServicesBuilder.servicesForAccountType].
  static List<AppService> servicesForAccountTypePublic(VirtualAccountType? t) =>
      _servicesForAccountType(t);

  static List<AppService> _servicesForAccountType(VirtualAccountType? t) {
    return switch (t) {
      VirtualAccountType.business => _businessServices,
      VirtualAccountType.savings => _savingsServices,
      VirtualAccountType.investment => _investmentServices,
      VirtualAccountType.usd ||
      VirtualAccountType.gbp ||
      VirtualAccountType.eur =>
        _multiCurrencyServices,
      VirtualAccountType.family => _familyServices,
      _ => _personalServices,
    };
  }

  static List<AppService> getAllServices() {
    final seen = <AppServiceName>{};
    final out = <AppService>[];
    for (final s in [
      ..._personalServices,
      ..._businessServices,
      ..._savingsServices,
      ..._investmentServices,
      ..._multiCurrencyServices,
      ..._familyServices,
    ]) {
      // Keep the search corpus consistent with the grid: a service hidden from
      // the tiles must not be reachable by searching for it either, or the
      // toggle only half-works.
      if (_effectiveHiddenServices.contains(s.serviceName)) {
        continue;
      }
      if (currentAppEnvironment.isProduction &&
          s.serviceName == AppServiceName.stocks) {
        continue;
      }
      if (seen.add(s.serviceName)) out.add(s);
    }
    return out;
  }

  /// The per-account-type source list, BEFORE hiding/ordering. Pulled out so
  /// the reorder gate can ask "is this the personal grid?" without duplicating
  /// the switch (a second copy would drift and silently enable dragging on a
  /// curated list).
  // ── Drag-to-arrange implementation ─────────────────────────────────────────

  /// One draggable + droppable tile.
  ///
  /// Carries its GLOBAL index (page * itemsPerPage + slot) rather than its slot,
  /// so a drop is meaningful across pages — the whole point of the feature is
  /// moving a service to a different slide, and a per-page index could not
  /// express that.
  Widget _buildReorderableTile(AppService service, int globalIndex) {
    final tile = AppServiceBuilder(appService: service);

    return DragTarget<int>(
      // Never accept a drop onto itself: it is a no-op that would still write a
      // "new" order and disable adaptive ordering for nothing.
      onWillAcceptWithDetails: (d) => d.data != globalIndex,
      onAcceptWithDetails: (d) => _moveService(d.data, globalIndex),
      builder: (context, candidate, rejected) {
        final isTarget = candidate.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            // A drop target has to be visible while the finger covers the tile
            // under it, hence a ring rather than a fill.
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isTarget ? _accentColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: LongPressDraggable<int>(
            data: globalIndex,
            // Long-press (not pan) so the carousel keeps its horizontal swipe —
            // a plain drag would fight the pager on every sideways gesture.
            delay: const Duration(milliseconds: 220),
            onDragStarted: () {
              HapticFeedback.mediumImpact();
              setState(() => _draggingIndex = globalIndex);
            },
            onDragEnd: (_) => setState(() => _draggingIndex = null),
            onDraggableCanceled: (_, __) =>
                setState(() => _draggingIndex = null),
            onDragUpdate: _maybeFlipPage,
            feedback: Material(
              color: Colors.transparent,
              child: Opacity(
                opacity: 0.9,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / _itemsPerRow,
                  child: tile,
                ),
              ),
            ),
            // The vacated slot stays laid out (just faded) so the grid does not
            // reflow under the finger mid-drag.
            childWhenDragging: Opacity(opacity: 0.25, child: tile),
            child: tile,
          ),
        );
      },
    );
  }

  /// Auto-advance the carousel when a drag hovers near either edge.
  ///
  /// This is what makes the arrangement work ACROSS slides: without it a tile
  /// could only ever be dropped on the page it started from, and a user would
  /// have to guess that the feature is page-local. Debounced so holding near an
  /// edge steps one page at a time instead of racing to the end.
  void _maybeFlipPage(DragUpdateDetails details) {
    if (_pageCount <= 1) return;
    final width = MediaQuery.of(context).size.width;
    const edge = 56.0; // generous enough to hit with a fingertip
    final x = details.globalPosition.dx;
    final goLeft = x < edge;
    final goRight = x > width - edge;
    if (!goLeft && !goRight) return;
    if (DateTime.now().difference(_lastEdgeFlip) <
        const Duration(milliseconds: 700)) {
      return;
    }
    final next = goLeft ? _currentIndex - 1 : _currentIndex + 1;
    if (next < 0 || next >= _pageCount) return;
    _lastEdgeFlip = DateTime.now();
    HapticFeedback.selectionClick();
    _carouselController.animateToPage(next);
  }

  /// Apply a move and persist it.
  ///
  /// Works on the FULL ordered list (not the page) so a cross-page move lands
  /// exactly where it was dropped.
  Future<void> _moveService(int from, int to) async {
    final services = _activeServices;
    if (from < 0 || from >= services.length) return;
    if (to < 0 || to >= services.length) return;
    final reordered = [...services];
    final moved = reordered.removeAt(from);
    reordered.insert(to, moved);
    HapticFeedback.lightImpact();
    // saveOrder bumps dashboardLayoutRevision (and turns adaptive off), which
    // is what re-renders the grid — no local setState of the list needed.
    await serviceLocator<ServiceOrderService>()
        .saveOrder(reordered.map((s) => s.serviceName).toList());
    if (!mounted) return;
    if (FeatureFlags.adaptiveQuickServices) return; // defensive; already off
  }

  List<AppService> _rawServicesForActiveAccount() {
    _lastResolvedAccountType = _activeAccountType;
    return _servicesForAccountType(_activeAccountType);
  }

  List<AppService> get _activeServices {
    final raw = _rawServicesForActiveAccount();
    final hidden = _effectiveHiddenServices;
    final filtered = raw.where((s) => !hidden.contains(s.serviceName)).toList();
    // Only the crowded personal grid is re-ordered; the curated per-type lists
    // (business/savings/investment/multi-currency/family) keep their hand-picked
    // order. `_getServicePages` inherits whatever order we return here.
    if (!identical(raw, _personalServices)) return filtered;
    return _orderPersonalServices(filtered);
  }

  /// Order the personal quick-services grid: Send Funds is ALWAYS first; then
  /// revenue-bearing services lead (by [revenuePriority]). When the user has
  /// turned on adaptive quick services, their most-used services float ahead
  /// (usage count desc) so a frequently-used service lands on the first slide,
  /// with [revenuePriority] as the (unique) tiebreak. Default OFF → pure
  /// revenue-priority order.
  List<AppService> _orderPersonalServices(List<AppService> services) {
    // A HAND-PLACED order outranks everything below it. Usage ordering is a
    // guess the app makes; this is an instruction the user gave by dragging a
    // tile, so it wins — including over the Send Funds pin, because a user who
    // deliberately moved Send Funds meant it.
    //
    // Services with no rank (added since the arrangement, or never dragged)
    // keep their relative default order and sit AFTER the arranged ones, so a
    // new service appears without disturbing anything already placed.
    final ranks = serviceLocator<ServiceOrderService>().ranks();
    if (ranks.isNotEmpty) {
      final ordered = [...services];
      ordered.sort((a, b) {
        final ar = ranks[a.serviceName];
        final br = ranks[b.serviceName];
        if (ar != null && br != null) return ar.compareTo(br);
        if (ar != null) return -1; // arranged before unarranged
        if (br != null) return 1;
        return a.serviceName.revenuePriority
            .compareTo(b.serviceName.revenuePriority);
      });
      return ordered;
    }

    final adaptive = FeatureFlags.adaptiveQuickServices;
    final usage = adaptive
        ? serviceLocator<ServiceUsageService>().counts()
        : const <AppServiceName, int>{};
    final ordered = [...services];
    ordered.sort((a, b) {
      // 1) Send Funds pinned to the very front.
      final aSend = a.serviceName == AppServiceName.sendFunds;
      final bSend = b.serviceName == AppServiceName.sendFunds;
      if (aSend != bSend) return aSend ? -1 : 1;
      // 2) Adaptive: most-used first (only when the toggle is on).
      if (adaptive) {
        final au = usage[a.serviceName] ?? 0;
        final bu = usage[b.serviceName] ?? 0;
        if (au != bu) return bu.compareTo(au);
      }
      // 3) Revenue priority (unique per service → deterministic order).
      return a.serviceName.revenuePriority
          .compareTo(b.serviceName.revenuePriority);
    });
    return ordered;
  }

  /// Default-account header — replaces the generic "Quick Services" with
  /// a personalised "Hi {firstname} 👋" greeting. The wave emoji is
  /// concatenated here (rather than as a separate widget) so the chip
  /// row layout doesn't change. Falls back to "Hi there 👋" when the
  /// auth cubit doesn't have a profile yet so the carousel never shows
  /// an empty header.
  String _personalGreeting() {
    try {
      final profile = context.read<AuthenticationCubit>().currentProfile;
      final first = profile?.user.firstName.trim() ?? '';
      if (first.isEmpty) return 'Hi there 👋';
      return 'Hi $first 👋';
    } catch (_) {
      return 'Hi there 👋';
    }
  }

  String get _headerTitle => switch (_activeAccountType) {
        VirtualAccountType.business => "Business Services",
        VirtualAccountType.savings => "Savings Services",
        VirtualAccountType.investment => "Investment Services",
        VirtualAccountType.usd ||
        VirtualAccountType.gbp ||
        VirtualAccountType.eur =>
          "Wallet Services",
        VirtualAccountType.family => "Family Services",
        _ => _personalGreeting(),
      };

  Color get _accentColor => switch (_activeAccountType) {
        VirtualAccountType.business => const Color(0xFF3B82F6),
        VirtualAccountType.savings => const Color(0xFF10B981),
        VirtualAccountType.investment => const Color(0xFFF59E0B),
        VirtualAccountType.usd ||
        VirtualAccountType.gbp ||
        VirtualAccountType.eur =>
          const Color(0xFF14B8A6),
        VirtualAccountType.family => const Color(0xFF2D2B6B),
        _ => const Color.fromARGB(255, 78, 3, 208),
      };

  @override
  void initState() {
    super.initState();
    _currentIndex = _stateManager.servicesCarouselIndex;
    _checkActiveAccountType();
    _accountSubscription = _accountManager.accountIdStream.listen((_) {
      _checkActiveAccountType();
    });
    // Re-resolve the grid when the region changes.
    //
    // Which services exist now depends on the active currency (see
    // LocaleGating), and switching region does NOT change the active account
    // id — so without this the user switches to a USD region and keeps looking
    // at the full Naira grid until something else happens to rebuild it.
    try {
      _currencySubscription =
          serviceLocator<LocaleManager>().currencyStream.listen((_) {
        if (mounted) setState(() {});
      });
    } catch (_) {
      // Locale service unavailable (early startup, widget test): the grid
      // simply does not react to a region change, which is the pre-existing
      // behaviour and never worth failing a dashboard build over.
    }
    // Adaptive ordering: load THIS user's local tally (also re-loads after a
    // user switch) and re-sort the grid once it's ready, then merge the
    // server's cross-device counts. Best-effort; never blocks the dashboard.
    if (FeatureFlags.adaptiveQuickServices) {
      final usage = serviceLocator<ServiceUsageService>();
      usage.ensureLoaded().then((_) {
        if (mounted) FeatureFlags.dashboardLayoutRevision.value++;
      });
      usage.syncFromBackend();
    }
    // A hand-placed arrangement is loaded UNCONDITIONALLY — unlike the adaptive
    // tally it is not behind a toggle, and it outranks the default order, so
    // the grid must know about it on the very first build after a fresh install
    // or a user switch. The backend seed only fills in when nothing local
    // exists (see ServiceOrderService.syncFromBackend).
    final order = serviceLocator<ServiceOrderService>();
    order.ensureLoaded().then((_) {
      if (mounted) FeatureFlags.dashboardLayoutRevision.value++;
    });
    order.syncFromBackend();
  }

  @override
  void dispose() {
    _accountSubscription?.cancel();
    _currencySubscription?.cancel();
    super.dispose();
  }

  /// Currency of the active family wallet, used when the canonical resolver has
  /// to CREATE the family_accounts record. Falls back to NGN (the currency of
  /// the auto-provisioned family wallet) if the summary isn't available.
  String _activeFamilyCurrency() {
    try {
      final st = context.read<AccountCardsSummaryCubit>().state;
      if (st is AccountCardsSummaryLoaded) {
        final activeId = _accountManager.activeAccountId;
        final acct = st.accountSummaries.firstWhere(
          (a) => a.spendingAccountId == activeId || a.id == activeId,
          orElse: () => st.accountSummaries.first,
        );
        return acct.currency;
      }
    } catch (_) {}
    return 'NGN';
  }

  void _checkActiveAccountType() {
    if (!mounted) return;
    final activeId = _accountManager.activeAccountId;
    if (activeId == null) return;

    // Look up the account type from the AccountCardsSummaryCubit state
    try {
      final cubitState = context.read<AccountCardsSummaryCubit>().state;
      if (cubitState is AccountCardsSummaryLoaded) {
        final summaries = cubitState.accountSummaries;
        if (summaries.isEmpty) return;

        // Match on spendingAccountId first: a Family & Friends card is
        // activated by its shared virtual-account id (spendingAccountId), not
        // its group id. For every other account type spendingAccountId == id,
        // so the id fallback keeps them working.
        final activeAccount = summaries.firstWhere(
          (a) => a.spendingAccountId == activeId,
          orElse: () => summaries.firstWhere(
            (a) => a.id == activeId,
            orElse: () => summaries.first,
          ),
        );
        final accountType = activeAccount.accountTypeEnum;
        final isFamily = accountType == VirtualAccountType.family;
        final isFamilyPending = isFamily &&
            (activeAccount.isFamilyPendingSetup ||
                !activeAccount.isFamilyAccount);
        // Pool VA still minting its NUBAN → spend tiles must not be offered.
        final isFamilyProcessing = isFamily && activeAccount.isFamilyProcessing;
        final familyId = isFamily ? activeAccount.familyAccountId : null;

        if (accountType != _activeAccountType ||
            isFamilyPending != _isFamilyPendingSetup ||
            isFamilyProcessing != _isFamilyProcessing) {
          // Reset the services carousel to the first page ONLY on a real
          // account-type SWITCH (one known type → a different one). On the
          // INITIAL resolution (_activeAccountType == null — e.g. this widget
          // was rebuilt when returning from a service's landing page such as
          // Joint Funds) we must PRESERVE the persisted carousel index so
          // "back" lands on the slide the user launched the service from,
          // instead of snapping to the first slide.
          final isInitialResolution = _activeAccountType == null;
          setState(() {
            _activeAccountType = accountType;
            _isFamilyPendingSetup = isFamilyPending;
            _isFamilyProcessing = isFamilyProcessing;
            _activeFamilyAccountId = familyId;
            if (!isInitialResolution) {
              _currentIndex =
                  0; // Reset carousel position on account type switch
              _stateManager.setServicesCarouselIndex(0);
            }
          });
        }
      }
    } catch (_) {
      // BlocProvider not available yet, keep current state
    }
  }

  // Split services into pages
  List<List<AppService>> _getServicePages() {
    final services = _activeServices;
    List<List<AppService>> pages = [];
    for (int i = 0; i < services.length; i += _itemsPerPage) {
      int end = (i + _itemsPerPage < services.length)
          ? i + _itemsPerPage
          : services.length;
      pages.add(services.sublist(i, end));
    }
    return pages;
  }

  // Calculate carousel height based on grid content
  double _calculateCarouselHeight(BuildContext context) {
    final services = _activeServices;
    final screenWidth = MediaQuery.of(context).size.width;
    final containerHorizontalPadding = 16.w * 2;
    final availableWidth = screenWidth - containerHorizontalPadding;

    const crossAxisSpacing = 8.0;
    const mainAxisSpacing = 8.0;
    final childAspectRatio = widget.tileAspectRatio;

    final itemWidth =
        (availableWidth - (crossAxisSpacing.w * (_itemsPerRow - 1))) /
            _itemsPerRow;
    final itemHeight = itemWidth / childAspectRatio;

    // Calculate actual rows needed (may be less than _maxRows for business services)
    final itemsOnFirstPage =
        services.length > _itemsPerPage ? _itemsPerPage : services.length;
    final actualRows =
        (itemsOnFirstPage / _itemsPerRow).ceil().clamp(1, _maxRows);

    final totalHeight =
        (itemHeight * actualRows) + (mainAxisSpacing.h * (actualRows - 1));
    return totalHeight;
  }

  /// The dashboard's service area in a region the platform does not fully
  /// serve yet: whatever still works, plus one line explaining the rest.
  Widget _buildRegionRestrictedServices() {
    final available = _activeServices;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.public_rounded,
                  size: 16.sp, color: const Color(0xFF8E8E93)),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Limited in ${LocaleGating.currentCurrency}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            available.isEmpty
                ? 'No services are available for ${LocaleGating.currentCurrency} '
                    'accounts yet. Switch to your Naira account to continue.'
                : 'Only the services below work with a '
                    '${LocaleGating.currentCurrency} account for now. Switch to '
                    'your Naira account for everything else.',
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.45,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
          if (available.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                for (final service in available)
                  SizedBox(
                    width: 72.w,
                    child: AppServiceBuilder(appService: service),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show family setup CTA when active account is a pending family account
    if (_activeAccountType == VirtualAccountType.family &&
        _isFamilyPendingSetup) {
      return _buildFamilySetupCTA();
    }

    // Pool VA still provisioning its NUBAN → don't offer spend tiles (the debit is
    // blocked server-side until active). Show a clear "setting up" notice instead.
    if (_activeAccountType == VirtualAccountType.family &&
        _isFamilyProcessing) {
      return _buildFamilyProcessingNotice();
    }

    // Regional restriction: say WHY the grid is short.
    //
    // Without this the user in a non-Naira region just sees a near-empty
    // dashboard and no reason for it, which reads as the app failing to load
    // rather than as a deliberate limit they can act on. Also covers the case
    // where an admin clears the allow-list entirely and NOTHING is available —
    // an empty grid with no words is the worst possible version of that.
    if (LocaleGating.restricted) {
      return _buildRegionRestrictedServices();
    }

    final servicePages = _getServicePages();
    // Captured for the edge auto-advance, which runs from a drag callback and
    // therefore cannot read build-local state.
    _pageCount = servicePages.length;
    final carouselHeight = _calculateCarouselHeight(context);
    final activeServices = _activeServices;
    final accentColor = _accentColor;

    // Clamp index to valid range in case page count changed
    final maxIndex = servicePages.length - 1;
    if (_currentIndex > maxIndex) {
      _currentIndex = maxIndex.clamp(0, maxIndex);
      _stateManager.setServicesCarouselIndex(_currentIndex);
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    _headerTitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (_activeAccountType == VirtualAccountType.business) ...[
                    SizedBox(width: 6.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (_activeAccountType != VirtualAccountType.business)
                GestureDetector(
                  onTap: () =>
                      showAllServicesBottomSheet(context, activeServices),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14.sp,
                          color: accentColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Services Carousel
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: servicePages.length,
            options: CarouselOptions(
              height: carouselHeight, // Dynamic height based on content
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              initialPage: _currentIndex,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
                // Persist carousel position for navigation restoration
                _stateManager.setServicesCarouselIndex(index);
              },
            ),
            itemBuilder: (context, pageIndex, realIndex) {
              final servicesOnPage = servicePages[pageIndex];

              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _itemsPerRow,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  childAspectRatio: widget.tileAspectRatio,
                ),
                itemCount: servicesOnPage.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final service = servicesOnPage[index];
                  // Reorder is only offered on the PERSONAL grid — the other
                  // account types carry a hand-picked order that is not the
                  // user's to rearrange.
                  if (!_reorderEnabled) {
                    return AppServiceBuilder(appService: service);
                  }
                  final globalIndex = pageIndex * _itemsPerPage + index;
                  return _buildReorderableTile(service, globalIndex);
                },
              );
            },
          ),

          // Drag hint. The ability to move a tile to ANOTHER slide is invisible
          // otherwise — a user would reasonably assume the arrangement is
          // page-local and never try. Shown only while actually dragging, and
          // only when there IS another page to reach.
          if (_draggingIndex != null && servicePages.length > 1) ...[
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.swipe_outlined,
                    size: 13.sp, color: accentColor.withValues(alpha: 0.75)),
                SizedBox(width: 5.w),
                Text(
                  'Hold near the edge to move it to another page',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: accentColor.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ],

          // Carousel Indicators (only show if more than 1 page).
          if (servicePages.length > 1) ...[
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                servicePages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: _currentIndex == index ? 24.w : 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? accentColor
                        : accentColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFamilyProcessingNotice() {
    const accent = Color(0xFF2D2B6B);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22.w,
            height: 22.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Setting up your account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  'We\'re creating your account details. You\'ll be able to send money and pay bills once it\'s ready.',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilySetupCTA() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A3E), Color(0xFF2D2B6B)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A1A3E).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.family_restroom,
            color: Colors.white.withValues(alpha: 0.9),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Complete Your Family Account Setup',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Add members and configure how funds are distributed among your family.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13.sp,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _isResolvingFamilyId
                  ? null
                  : () async {
                      if (_activeFamilyAccountId != null) {
                        Get.toNamed(AppRoutes.familyActivationSetup,
                            arguments: {'familyId': _activeFamilyAccountId});
                      } else {
                        // familyAccountId unknown — resolve-or-create through the SAME
                        // canonical path the account-card "Get Started" uses, so this
                        // "Setup Now" card converges on the same activation-setup screen
                        // instead of dead-ending into the separate "create another"
                        // carousel (the flow/backend divergence this consolidates).
                        setState(() => _isResolvingFamilyId = true);
                        try {
                          final familyCubit =
                              serviceLocator<FamilyAccountCubit>();
                          final familyId =
                              await familyCubit.resolveOrCreatePendingFamilyId(
                            currency: _activeFamilyCurrency(),
                          );
                          if (familyId != null) {
                            Get.toNamed(AppRoutes.familyActivationSetup,
                                arguments: {'familyId': familyId});
                          } else {
                            final s = familyCubit.state;
                            Get.snackbar(
                              'Error',
                              s is FamilyAccountError
                                  ? s.message
                                  : 'Could not set up your family account. Please try again.',
                              backgroundColor: const Color(0xFFEF4444)
                                  .withValues(alpha: 0.9),
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        } catch (_) {
                          Get.snackbar(
                            'Error',
                            'Failed to load family account. Please try again.',
                            backgroundColor:
                                const Color(0xFFEF4444).withValues(alpha: 0.9),
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                        } finally {
                          if (mounted) {
                            setState(() => _isResolvingFamilyId = false);
                          }
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A1A3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                elevation: 0,
              ),
              child: _isResolvingFamilyId
                  ? LazerVaultLoader.small()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings_rounded, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Setup Now',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
