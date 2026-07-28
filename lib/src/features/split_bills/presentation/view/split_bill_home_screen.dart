import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../widgets/split_bill_card.dart';
import '../widgets/split_bill_shimmer.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class SplitBillHomeScreen extends StatelessWidget {
  const SplitBillHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SplitBillCubit>()..loadIncomingBills(),
      child: const _SplitBillHomeView(),
    );
  }
}

class _SplitBillHomeView extends StatefulWidget {
  const _SplitBillHomeView();

  @override
  State<_SplitBillHomeView> createState() => _SplitBillHomeViewState();
}

class _SplitBillHomeViewState extends State<_SplitBillHomeView>
    with SingleTickerProviderStateMixin {
  // Brand palette — matches the dashboard account-carousel gradient end stop
  // and the Select Recipients banner. Keeping inline constants per existing
  // codebase convention (no global theme refactor in this change).
  static const Color _brandPurple = Color(0xFF4834D4);
  static const Color _brandPurpleDeep = Color(0xFF2D2B6B);
  static const Color _brandOrange = Color(0xFFFB923C);

  late TabController _tabController;
  int _currentTab = 0;

  // Locally-cached tab data. Both tabs share ONE SplitBillCubit whose state is a
  // single stream, so building the tabs directly off a BlocBuilder made every
  // load — including the reload fired on each swipe — flash the shimmer AND
  // blank the OTHER tab (whose Loaded state no longer matched the current
  // state). That is the "refreshes and blinks on every swipe" symptom. We now
  // cache each tab's list here (populated by the BlocListener), build the tabs
  // from the cache, and load each tab only once (pull-to-refresh updates it).
  // A tab keeps showing its cached list across state changes, so it never
  // blinks; the shimmer appears only on the very first load (cache still null).
  List<SplitBillEntity>? _incomingBills;
  List<SplitBillEntity>? _createdBills;
  String? _incomingError;
  String? _createdError;

  String? get _currentUserId =>
      context.read<AuthenticationCubit>().userId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() => _currentTab = _tabController.index);
    // Load a tab's data only the FIRST time it's shown; afterwards it is served
    // from the local cache (pull-to-refresh refreshes it). This removes the
    // reload-on-every-swipe that caused the flicker.
    if (_tabController.index == 0) {
      if (_incomingBills == null) {
        context.read<SplitBillCubit>().loadIncomingBills();
      }
    } else {
      if (_createdBills == null) {
        context.read<SplitBillCubit>().loadCreatedBills();
      }
    }
  }

  Future<void> _refreshData() async {
    if (_currentTab == 0) {
      await context.read<SplitBillCubit>().loadIncomingBills();
    } else {
      await context.read<SplitBillCubit>().loadCreatedBills();
    }
  }

  /// Back should ALWAYS land on the Select Recipients screen. Normally there is a
  /// route to pop to, but a preceding pay flow can reset the stack (the receipt
  /// does offAllNamed), leaving nothing to pop — which read as "stuck". In that
  /// case navigate to Select Recipients explicitly instead of dead-ending.
  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      Get.back();
    } else {
      Get.offNamed(AppRoutes.selectRecipient);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Layout: curved purple banner (back arrow + title + subtitle) flowing
    // into a dark scaffold body. Mirrors the Select Recipients header
    // structure so the navigation between the two screens feels continuous.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreate,
        backgroundColor: _brandPurple,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Split Bill',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocListener<SplitBillCubit, SplitBillState>(
        listener: (context, state) {
          // Fold list results into the per-tab caches. The tabs render from
          // these caches (not the live state), so a load never blanks a tab.
          if (state is IncomingSplitBillsLoaded) {
            setState(() {
              _incomingBills = state.bills;
              _incomingError = null;
            });
          } else if (state is CreatedSplitBillsLoaded) {
            setState(() {
              _createdBills = state.bills;
              _createdError = null;
            });
          } else if (state is SplitBillError) {
            // Surface the failure inline on the affected tab only (the empty
            // error state renders a user-friendly message + Retry). No snackbar:
            // it duplicated the in-tab error AND, because GetX's Get.back()
            // dismisses an open snackbar before popping the route, it made the
            // back button appear to hang until the toast finished.
            setState(() {
              if (_currentTab == 0 && _incomingBills == null) {
                _incomingError = state.message;
              } else if (_currentTab == 1 && _createdBills == null) {
                _createdError = state.message;
              }
            });
          }
        },
        child: Column(
          children: [
            _buildHeaderBanner(),
            SizedBox(height: 12),
            _buildTabBar(),
            SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildIncomingTab(),
                  _buildCreatedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  /// Curved purple banner header — same visual language as Select Recipients
  /// and the dashboard's summary card so transitions read as continuous.
  Widget _buildHeaderBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 8,
        16,
        20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_brandPurple, _brandPurpleDeep],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: _brandPurple.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Material(
            color: Colors.white.withValues(alpha: 0.12),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: _handleBack,
              child: Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Split Bills',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Share an expense — chip in or chase it up.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
          const ServiceVoiceButton(
            serviceName: 'split_bills',
            iconColor: Colors.white,
            backgroundColor: Colors.white,
            buttonSize: 34,
            iconSize: 17,
          ),
          const SizedBox(width: 8),
          const MicroserviceChatIcon(
            serviceName: 'Split Bills',
            sourceContext: 'split_bills',
            iconColor: Colors.white,
            chatAccentColor: _brandPurple,
            size: 34,
            iconSize: 17,
          ),
        ],
      ),
    );
  }

  /// Pill-style segmented tab control. Indicator + label highlights match
  /// the dashboard's account summary purple so the segmented control reads
  /// as actively-selectable, not the disabled-feeling Material default.
  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: _brandPurple,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: _brandPurple.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.65),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor:
            WidgetStateProperty.all(_brandPurple.withValues(alpha: 0.08)),
        tabs: const [
          Tab(text: 'Incoming'),
          Tab(text: 'Created'),
        ],
      ),
    );
  }

  Widget _buildIncomingTab() {
    // Rendered from the local cache (see field docs) so the shared cubit's
    // transient loading state can never blank or blink this tab.
    if (_incomingBills == null) {
      if (_incomingError != null) {
        return _buildErrorState(
          friendlyError(_incomingError!, context: 'load split bills'),
        );
      }
      // First load only — no cached list yet.
      return const SplitBillListShimmer();
    }
    final bills = _incomingBills!;
    if (bills.isEmpty) {
      return _buildEmptyListForRefresh(
        icon: Icons.call_received_rounded,
        title: 'No Incoming Split Bills',
        subtitle: 'Split bills from others will appear here',
      );
    }
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color(0xFF4834D4),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];
          return SplitBillCard(
            bill: bill,
            isIncoming: true,
            currentUserId: _currentUserId,
            onTap: () => _onBillTapped(bill),
          );
        },
      ),
    );
  }

  Widget _buildCreatedTab() {
    // Rendered from the local cache (see field docs) so the shared cubit's
    // transient loading state can never blank or blink this tab.
    if (_createdBills == null) {
      if (_createdError != null) {
        return _buildErrorState(
          friendlyError(_createdError!, context: 'load split bills'),
        );
      }
      // First load only — no cached list yet.
      return const SplitBillListShimmer();
    }
    final bills = _createdBills!;
    if (bills.isEmpty) {
      return _buildEmptyListForRefresh(
        icon: Icons.receipt_long_rounded,
        title: 'No Created Split Bills',
        subtitle: 'Split a bill and we’ll chase up everyone’s share.',
        showCreateCta: true,
      );
    }
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color(0xFF4834D4),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];
          return SplitBillCard(
            bill: bill,
            isIncoming: false,
            currentUserId: _currentUserId,
            onTap: () => _onBillTapped(bill),
          );
        },
      ),
    );
  }

  Future<void> _onBillTapped(SplitBillEntity bill) async {
    // Await the detail screen so a pay / cancel / decline done there is picked
    // up on return. We refresh the current tab in place (the cached list stays
    // visible during the reload, so this doesn't blink) — this replaces the old
    // reload-on-every-swipe as the way mutations get reflected.
    await Get.toNamed(
      AppRoutes.splitBillDetail,
      arguments: {'splitBillId': bill.id},
    );
    if (mounted) {
      _refreshData();
    }
  }

  /// Open the create-split-bill flow, then refresh on return. Shared by the
  /// FAB and the empty-state CTA so both behave identically.
  Future<void> _openCreate() async {
    await Get.toNamed(AppRoutes.createSplitBill);
    if (mounted) {
      _refreshData();
    }
  }

  Widget _buildEmptyListForRefresh({
    required IconData icon,
    required String title,
    required String subtitle,
    bool showCreateCta = false,
  }) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color(0xFF4834D4),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          _buildEmptyState(
            icon: icon,
            title: title,
            subtitle: subtitle,
            showCreateCta: showCreateCta,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    bool showCreateCta = false,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(36),
              ),
              child: Icon(
                icon,
                size: 32,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            if (showCreateCta) ...[
              const SizedBox(height: 20),
              SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: _openCreate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brandPurple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text(
                    'New Split Bill',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: _brandPurple,
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 56),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warm orange-accented illustration instead of the harsh
                  // red error icon — the issue is transient (service warming
                  // up, no network), not a destructive failure.
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _brandOrange.withValues(alpha: 0.14),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.cloud_off_outlined,
                      size: 34,
                      color: _brandOrange,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Hold on a sec",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: _refreshData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _brandPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 22),
                      ),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
