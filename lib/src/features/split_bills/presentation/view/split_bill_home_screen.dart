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
  late TabController _tabController;
  int _currentTab = 0;

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
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Split Bills',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Get.toNamed(AppRoutes.createSplitBill);
          if (context.mounted) {
            _refreshData();
          }
        },
        backgroundColor: const Color(0xFF3B82F6),
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
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              _buildTabBar(),
              const SizedBox(height: 8),
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

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
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
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
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
            color: const Color(0xFF3B82F6),
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
          return _buildErrorState(state.message);
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
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
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
            color: const Color(0xFF3B82F6),
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
          return _buildErrorState(state.message);
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
      color: const Color(0xFF3B82F6),
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
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 60),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Failed to Load',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
