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
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

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

  String? get _currentUserId =>
      context.read<AuthenticationCubit>().userId;

  /// Convert raw cubit / gRPC error strings into something a human can read.
  /// Same shape as `invoice_home_screen._friendlyErrorMessage`.
  static String _friendlyMessage(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('unknown service')) {
      return "Split Bill isn't available right now. Please try again in a moment.";
    }
    if (lower.contains('unavailable') || lower.contains('connection')) {
      return 'Unable to reach the server. Check your connection and retry.';
    }
    if (lower.contains('unauthenticated') ||
        lower.contains('token') ||
        lower.contains('auth')) {
      return 'Your session has expired. Please sign in again.';
    }
    if (lower.contains('timeout') || lower.contains('deadline')) {
      return 'The request timed out. Please retry.';
    }
    if (lower.contains('permission') || lower.contains('denied')) {
      return "You don't have permission to view these split bills.";
    }
    return 'We hit an issue loading split bills. Please retry.';
  }

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
    if (_tabController.index == 0) {
      context.read<SplitBillCubit>().loadIncomingBills();
    } else {
      context.read<SplitBillCubit>().loadCreatedBills();
    }
  }

  Future<void> _refreshData() async {
    if (_currentTab == 0) {
      await context.read<SplitBillCubit>().loadIncomingBills();
    } else {
      await context.read<SplitBillCubit>().loadCreatedBills();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Layout: curved purple banner (back arrow + title + subtitle) flowing
    // into a dark scaffold body. Mirrors the Select Recipients header
    // structure so the navigation between the two screens feels continuous.
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Get.toNamed(AppRoutes.createSplitBill);
          if (context.mounted) {
            _refreshData();
          }
        },
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
          if (state is SplitBillError) {
            Get.snackbar(
              "Couldn't load",
              _friendlyMessage(state.message),
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
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
              onTap: () => Get.back(),
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
    return BlocBuilder<SplitBillCubit, SplitBillState>(
      builder: (context, state) {
        if (state is SplitBillLoading || state is SplitBillListLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is IncomingSplitBillsLoaded) {
          final bills = state.bills;
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

        if (state is SplitBillError) {
          return _buildErrorState(_friendlyMessage(state.message));
        }

        // Default / initial state
        return _buildEmptyListForRefresh(
          icon: Icons.call_received_rounded,
          title: 'No Incoming Split Bills',
          subtitle: 'Split bills from others will appear here',
        );
      },
    );
  }

  Widget _buildCreatedTab() {
    return BlocBuilder<SplitBillCubit, SplitBillState>(
      builder: (context, state) {
        if (state is SplitBillLoading || state is SplitBillListLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is CreatedSplitBillsLoaded) {
          final bills = state.bills;
          if (bills.isEmpty) {
            return _buildEmptyListForRefresh(
              icon: Icons.receipt_long_rounded,
              title: 'No Created Split Bills',
              subtitle: 'Split bills you create will appear here',
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

        if (state is SplitBillError) {
          return _buildErrorState(_friendlyMessage(state.message));
        }

        // Default / initial state
        return _buildEmptyListForRefresh(
          icon: Icons.receipt_long_rounded,
          title: 'No Created Split Bills',
          subtitle: 'Split bills you create will appear here',
        );
      },
    );
  }

  void _onBillTapped(SplitBillEntity bill) {
    Get.toNamed(
      AppRoutes.splitBillDetail,
      arguments: {'splitBillId': bill.id},
    );
  }

  Widget _buildEmptyListForRefresh({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      color: const Color(0xFF4834D4),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          _buildEmptyState(icon: icon, title: title, subtitle: subtitle),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
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
