import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/balance_websocket_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart'
    show BalanceUpdateEvent;
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/account_carousel.dart';
import 'package:lazervault/src/features/account_actions/presentation/widgets/account_actions_bottom_sheet.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import '../widgets/empty_account_state.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/virtual_account/domain/services/va_provisioning_service.dart';
import 'package:lazervault/src/features/multi_country/cubit/multi_country_cubit.dart';
import 'package:lazervault/src/features/multi_country/cubit/multi_country_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// Wrapper Widget to Provide the Cubit
class DashboardCardSummary extends StatelessWidget {
  /// Compact (Showcase/advert) layout — trims the section height a little so the
  /// adverts carousel + compact services fit above the fold.
  final bool compact;
  const DashboardCardSummary({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return _DashboardCardSummaryView(compact: compact);
  }
}

// Internal View Widget
class _DashboardCardSummaryView extends StatefulWidget {
  final bool compact;
  const _DashboardCardSummaryView({this.compact = false});

  @override
  State<_DashboardCardSummaryView> createState() =>
      _DashboardCardSummaryViewState();
}

class _DashboardCardSummaryViewState extends State<_DashboardCardSummaryView>
    with WidgetsBindingObserver {
  StreamSubscription<void>? _wsReconnectedSub;
  // Removed most state variables - they are now in CardDetailsBottomSheetState
  // Keep _currentIndex if AccountCarousel doesn't manage its own index
  // int _currentIndex = 0; // If needed for indicators outside carousel

  // Dedup guard for the WS money-movement banners. ONE settled deposit/transfer
  // is legitimately re-broadcast by several banking settlement paths (webhook +
  // client-poll + reconciler), each arriving as a DISTINCT BalanceUpdateEvent
  // instance — and listenWhen only compares instances, so without this the user
  // saw "Funds Received" / "Transfer Completed" 2–4× for a single event.
  // Keyed by (eventType, reference, status); bounded so it can't grow unbounded.
  final Set<String> _shownWsSnackbarKeys = <String>{};

  /// True if a banner for this exact WS event was already shown (and records it
  /// so the next duplicate is suppressed).
  bool _wsSnackbarAlreadyShown(BalanceUpdateEvent e) {
    final ref = e.reference ?? e.transactionId ?? e.timestamp.toString();
    final key = '${e.eventType}:$ref:${e.status}';
    if (_shownWsSnackbarKeys.contains(key)) return true;
    _shownWsSnackbarKeys.add(key);
    if (_shownWsSnackbarKeys.length > 40) {
      _shownWsSnackbarKeys.remove(_shownWsSnackbarKeys.first);
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Fetch data here using the globally provided cubit
    _fetchData();
    _setupWebSocketConnection();
    // When the balance socket (re)connects — e.g. after returning from a bank app
    // during an open-banking deposit — pull a fresh balance so any update that was
    // broadcast while we were disconnected is caught up and the flip-counter
    // animates to the new value (the server does not replay dropped broadcasts).
    try {
      _wsReconnectedSub =
          context.read<BalanceWebSocketCubit>().onReconnected.listen((_) {
        if (mounted) _refreshAccountSummaries(silent: true);
      });
    } catch (_) {/* cubit not in scope — resume handler still covers it */}
  }

  /// On returning to the foreground (the exact open-banking deposit case: the app
  /// was backgrounded for the bank-app redirect while the deposit settled), pull a
  /// fresh balance (animates to any change) and reconnect the balance socket for
  /// future real-time updates. Both are silent + best-effort.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (!mounted) return;
      _refreshAccountSummaries(silent: true);
      try {
        context.read<BalanceWebSocketCubit>().reconnectIfNeeded();
      } catch (_) {/* not in scope */}
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _wsReconnectedSub?.cancel();
    super.dispose();
  }

  void _fetchData() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      print("_DashboardCardSummaryView: User not authenticated, cannot fetch summaries.");
      return;
    }

    final userId = authState.profile.user.id;
    final accessToken = authState.profile.session.accessToken;
    final cubit = context.read<AccountCardsSummaryCubit>();

    // Returning user: the cubit already holds cached summaries, so paint them
    // instantly (no spinner) — but STILL fetch fresh balances in the BACKGROUND
    // so landing here (login / re-entry) auto-refreshes without a pull-to-refresh.
    // `silent: true` keeps the current cards on screen, so when a changed balance
    // arrives the CompactAnimatedBalance flip-counter rolls old→new value. This is
    // the "auto-refresh + animate on login" behaviour; WebSocket then keeps it live.
    if (cubit.hasDataForUser(userId)) {
      _refreshAccountSummaries(silent: true);
      return;
    }

    // First load or user changed — no cached data to animate from, so do a normal
    // (visible) fetch; every subsequent landing takes the silent background path.
    final profileState = context.read<ProfileCubit>().state;
    String? activeCountry;
    if (profileState is ProfileLoaded) {
      activeCountry = profileState.preferences.activeCountry.isNotEmpty
          ? profileState.preferences.activeCountry
          : null;
    }

    cubit.fetchAccountSummaries(
      userId: userId,
      accessToken: accessToken,
      country: activeCountry,
    );
  }

  void _setupWebSocketConnection() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final userId = authState.profile.user.id;
      final accessToken = authState.profile.session.accessToken;

      // Get active country from ProfileCubit, fallback to user's country or default
      final profileState = context.read<ProfileCubit>().state;
      String activeCountry = 'NG'; // Default fallback
      if (profileState is ProfileLoaded) {
        activeCountry = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : (authState.profile.user.country?.isNotEmpty == true
                ? authState.profile.user.country!
                : 'NG');
      }

      debugPrint('_setupWebSocketConnection: Connecting with userId=$userId, country=$activeCountry');

      // Connect to WebSocket for real-time balance updates
      context.read<BalanceWebSocketCubit>().connect(
            userId: userId,
            countryCode: activeCountry,
            accessToken: accessToken,
          );
    }
  }

  // Method to show the account actions bottom sheet widget
  Future<void> _showCardDetailsSheet(Map<String, dynamic> accountArgs) async {
    await Get.bottomSheet(
      BlocProvider.value(
        value: serviceLocator<AccountActionsCubit>(),
        child: AccountActionsBottomSheet(accountArgs: accountArgs),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor:
          Colors.transparent, // Let the sheet handle its background
    );

    // The sheet may have frozen/unfrozen this account (or changed its limits).
    // Silently re-fetch the summaries so the dashboard card re-renders its new
    // state — e.g. the frozen "ice" theme — the moment the sheet closes. This
    // is required because the build()-time hasDataForUser guard would otherwise
    // keep serving the stale (pre-freeze) card; a direct cubit fetch bypasses
    // it, and `silent` avoids a loading flicker on the carousel.
    if (!mounted) return;
    _refreshAccountSummaries(silent: true);
  }

  // Re-fetch account summaries for the current user without a loading flicker.
  void _refreshAccountSummaries({bool silent = false}) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final userId = authState.profile.user.id;
    final accessToken = authState.profile.session.accessToken;

    final profileState = context.read<ProfileCubit>().state;
    String? activeCountry;
    if (profileState is ProfileLoaded) {
      activeCountry = profileState.preferences.activeCountry.isNotEmpty
          ? profileState.preferences.activeCountry
          : null;
    }

    context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
          userId: userId,
          accessToken: accessToken,
          country: activeCountry,
          silent: silent,
        );
  }

  // Guards a single provision attempt per mount so state churn never re-fires
  // createVirtualAccount.
  bool _provisionAttempted = false;

  /// If the verified user's active-locale PERSONAL account has no NUBAN yet,
  /// provision it in the background then silently refresh so the deposit account
  /// appears on the dashboard automatically — no manual "activate" step. NUBANs
  /// are minted for NG only today, so this targets the NGN personal account.
  /// Best-effort + guarded; never blocks the UI.
  Future<void> _maybeProvisionMissingVA(
      List<AccountSummaryEntity> summaries) async {
    if (_provisionAttempted || !mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final user = authState.profile.user;

    String activeCurrency = 'NGN';
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded &&
        profileState.preferences.currency.isNotEmpty) {
      activeCurrency = profileState.preferences.currency;
    }
    if (activeCurrency.toUpperCase() != 'NGN') return;

    AccountSummaryEntity? target;
    for (final s in summaries) {
      if (s.isPersonalAccount &&
          s.currency.toUpperCase() == activeCurrency.toUpperCase() &&
          (s.accountNumber == null || s.accountNumber!.trim().isEmpty)) {
        target = s;
        break;
      }
    }
    if (target == null) return; // already provisioned (or no personal account)

    _provisionAttempted = true;
    try {
      final va = await serviceLocator<VaProvisioningService>().ensurePersonalVA(
        currency: activeCurrency,
        locale: 'en-NG',
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber ?? '',
        isPrimary: target.isPrimary,
      );
      if (!mounted) return;
      if (va != null) {
        _refreshAccountSummaries(silent: true);
      }
    } catch (_) {/* best-effort — provisioning is an enhancement */}
  }

  @override
  Widget build(BuildContext context) {
    // Get user for the header
    final authState = context.watch<AuthenticationCubit>().state;
    User? currentUser;
    if (authState is AuthenticationSuccess) {
      currentUser = authState.profile.user;
    }

    return MultiBlocListener(
      listeners: [
        // Listen for multi-country account creation events
        BlocListener<MultiCountryCubit, MultiCountryState>(
          listener: (context, state) {
            if (state is LocaleAccountCreated) {
              LVSnackbar.showSuccess(
                title: 'Account Created',
                message: state.message,
              );
              // Refresh account summaries to show the new account
              _fetchData();
            }
          },
        ),
        // Listen for WebSocket balance updates
        // Note: The AccountCarousel handles real-time balance updates directly
        // via animated counters - NO server refresh needed, WebSocket is the source of truth
        BlocListener<BalanceWebSocketCubit, BalanceWebSocketState>(
          listenWhen: (previous, current) =>
              current.lastUpdate != null && current.lastUpdate != previous.lastUpdate,
          listener: (context, wsState) {
            final event = wsState.lastUpdate!;
            debugPrint('_DashboardCardSummaryView: WebSocket balance update - ${event.eventType}: ${event.newBalance} ${event.currency}');
            // Suppress duplicate banners for the SAME settled event re-broadcast
            // by multiple banking settlement paths (webhook + poll + reconciler).
            // Guard only the user-facing banner here; the carousel's count-up
            // animation is a SEPARATE listener and must still see every event.
            if (_wsSnackbarAlreadyShown(event)) return;
            // Show snackbar for transfer events when user is on dashboard
            if (event.eventType == 'transfer_out' || event.eventType == 'transfer') {
              if (event.status == 'completed') {
                LVSnackbar.showSuccess(
                  title: 'Transfer Completed',
                  message: event.amount != null
                      ? 'Transfer of ${event.currency} ${event.amount!.toStringAsFixed(2)} successful'
                      : 'Your transfer was successful',
                );
              } else if (event.status == 'failed') {
                LVSnackbar.showError(
                  title: 'Transfer Failed',
                  message: 'Transfer could not be completed. Funds returned to your account.',
                  duration: const Duration(seconds: 5),
                );
              }
            } else if (event.eventType == 'transfer_in' || event.eventType == 'deposit') {
              LVSnackbar.showSuccess(
                title: 'Funds Received',
                message: event.amount != null
                    ? '${event.currency} ${event.amount!.toStringAsFixed(2)} received'
                    : 'New funds received',
              );
            }
            // NOTE: intentionally do NOT clearLastUpdate() here.
            //
            // The AccountCarousel (a descendant) ALSO listens to this same
            // cubit to drive the card count-up animation. Clearing the
            // event here (emitting lastUpdate=null) could race ahead of the
            // carousel's listener and make it miss the money-in event — the
            // balance would never animate. Each listener now de-dupes the
            // event by identity on its own side (this one via listenWhen,
            // the carousel via _lastAnimatedEvent), so no shared clear is
            // needed and the carousel reliably animates on EVERY event.
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: widget.compact ? 6.h : 8.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 78, 3, 208),
              Color.fromARGB(255, 95, 20, 225),
            ],
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Use DashboardHeader widget
              DashboardHeader(currentUser: currentUser),
              SizedBox(height: widget.compact ? 12.h : 16.h),
              // Use AccountCarousel widget within BlocConsumer
              BlocConsumer<AccountCardsSummaryCubit, AccountCardsSummaryState>(
                listener: (context, state) {
                  // Add listener to observe state changes received by the UI
                  print(
                      "_DashboardCardSummaryView BlocConsumer Listener: Received state -> $state");
                  // Proactive VA provisioning: the moment the summaries land, if a
                  // verified user's active-locale personal account has no NUBAN yet,
                  // mint it in the background and silently refresh so they simply
                  // SEE their deposit account on the dashboard (no "activate" step).
                  if (state is AccountCardsSummaryLoaded) {
                    _maybeProvisionMissingVA(state.accountSummaries);
                  }
                },
                builder: (context, state) {
                  // Get country code from user profile for empty state handling
                  // Priority: ProfileCubit preferences > User profile country > Default 'NG'
                  String countryCode = 'NG'; // Default fallback

                  // First try to get from ProfileCubit preferences
                  final profileState = context.read<ProfileCubit>().state;
                  if (profileState is ProfileLoaded &&
                      profileState.preferences.activeCountry.isNotEmpty) {
                    countryCode = profileState.preferences.activeCountry;
                  } else {
                    // Fallback to user's profile country from AuthenticationCubit
                    final authState = context.read<AuthenticationCubit>().state;
                    if (authState is AuthenticationSuccess &&
                        authState.profile.user.country != null &&
                        authState.profile.user.country!.isNotEmpty) {
                      countryCode = authState.profile.user.country!;
                    }
                  }

                  if (state is AccountCardsSummaryLoading ||
                      state is AccountCardsSummaryInitial) {
                    // Industry-standard inline card-area loader — 28px
                    // (`.medium()`) reads as the page-level "loading
                    // your accounts" spinner without dominating the
                    // ~196px card slot. Sized inside a SizedBox that
                    // matches the carousel height so the layout doesn't
                    // collapse during load.
                    return SizedBox(
                      height: widget.compact ? 170.h : 190.h,
                      child: const Center(
                        child: LazerVaultLoader.medium(),
                      ),
                    );
                  }
                  if (state is AccountCardsSummaryError) {
                    return SizedBox(
                      height: 228.h,
                      child: Center(
                          child: Text('Error: ${state.message}',
                              style: const TextStyle(color: Colors.red))),
                    );
                  }
                  if (state is AccountCardsSummaryLoaded || state is AccountBalanceUpdated) {
                    final accountSummaries = state is AccountCardsSummaryLoaded
                        ? state.accountSummaries
                        : (state as AccountBalanceUpdated).accountSummaries;
                    // Check if user has no accounts (non-Nigeria or accounts not yet created)
                    if (accountSummaries.isEmpty) {
                      final isSupported = EmptyAccountState.isCountrySupported(countryCode);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 200.h,
                          child: EmptyAccountState(
                            countryCode: countryCode,
                            isVirtualAccountSupported: isSupported,
                            onAccountCreated: () => _fetchData(),
                            onNotifyMe: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'We\'ll notify you when virtual accounts become available in your region!',
                                  ),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }

                    return AccountCarousel(
                      accountSummaries: accountSummaries,
                      onShowDetails: _showCardDetailsSheet,
                      compact: widget.compact,
                    );
                  }
                  return SizedBox(
                      height: 228.h,
                      child: const Text('Unknown state',
                          style: TextStyle(color: Colors.white)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
