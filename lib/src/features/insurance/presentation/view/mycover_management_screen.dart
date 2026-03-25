import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import 'mycover_customers_screen.dart';
import 'mycover_purchases_screen.dart';
import 'mycover_provider_claims_screen.dart';
import 'mycover_notification_prefs_screen.dart';

class MyCoverManagementScreen extends StatefulWidget {
  const MyCoverManagementScreen({super.key});

  @override
  State<MyCoverManagementScreen> createState() => _MyCoverManagementScreenState();
}

class _MyCoverManagementScreenState extends State<MyCoverManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InsuranceCubit>().loadMyCoverWalletBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Insurance Management', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWalletBalanceCard(),
            const SizedBox(height: 24),
            const Text(
              'MyCover Dashboard',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Manage your insurance customers, purchases, and claims',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 24),
            _buildManagementCard(
              icon: Icons.people_outline,
              title: 'Customers',
              subtitle: 'View and manage insurance customers',
              color: const Color(0xFF3B82F6),
              onTap: () => Get.to(() => BlocProvider(
                create: (_) => serviceLocator<InsuranceCubit>(),
                child: const MyCoverCustomersScreen(),
              )),
            ),
            const SizedBox(height: 12),
            _buildManagementCard(
              icon: Icons.shopping_bag_outlined,
              title: 'Purchases',
              subtitle: 'View all insurance purchases and policies',
              color: const Color(0xFF10B981),
              onTap: () => Get.to(() => BlocProvider(
                create: (_) => serviceLocator<InsuranceCubit>(),
                child: const MyCoverPurchasesScreen(),
              )),
            ),
            const SizedBox(height: 12),
            _buildManagementCard(
              icon: Icons.assignment_outlined,
              title: 'Provider Claims',
              subtitle: 'Track claims submitted to MyCover',
              color: const Color(0xFFFB923C),
              onTap: () => Get.to(() => BlocProvider(
                create: (_) => serviceLocator<InsuranceCubit>(),
                child: const MyCoverProviderClaimsScreen(),
              )),
            ),
            const SizedBox(height: 12),
            _buildManagementCard(
              icon: Icons.notifications_outlined,
              title: 'Notification Preferences',
              subtitle: 'Manage email and SMS notifications',
              color: const Color(0xFF8B5CF6),
              onTap: () => Get.to(() => BlocProvider(
                create: (_) => serviceLocator<InsuranceCubit>(),
                child: const MyCoverNotificationPrefsScreen(),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletBalanceCard() {
    return BlocBuilder<InsuranceCubit, InsuranceState>(
      buildWhen: (_, state) => state is MyCoverWalletBalanceLoaded || state is InsuranceLoading || state is InsuranceError,
      builder: (context, state) {
        double? balance;
        String currency = 'NGN';
        bool isLoading = state is InsuranceLoading;
        bool isError = state is InsuranceError;

        if (state is MyCoverWalletBalanceLoaded) {
          balance = state.walletBalance.balance;
          currency = state.walletBalance.currency;
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E3A5F), Color(0xFF0F2740)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'MyCover Wallet',
                    style: TextStyle(color: Color(0xFF93C5FD), fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () => context.read<InsuranceCubit>().loadMyCoverWalletBalance(),
                    child: Icon(
                      Icons.refresh,
                      color: const Color(0xFF93C5FD),
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (isLoading)
                const SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(color: Color(0xFF93C5FD), strokeWidth: 2),
                )
              else if (balance != null)
                Text(
                  '\u20A6${_formatBalance(balance)}',
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                )
              else if (isError)
                GestureDetector(
                  onTap: () => context.read<InsuranceCubit>().loadMyCoverWalletBalance(),
                  child: Row(
                    children: const [
                      Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Failed to load. Tap to retry.',
                        style: TextStyle(color: Color(0xFFEF4444), fontSize: 14),
                      ),
                    ],
                  ),
                )
              else
                const Text(
                  '--',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 28, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 4),
              Text(
                currency,
                style: const TextStyle(color: Color(0xFF93C5FD), fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatBalance(double balance) {
    if (balance == balance.truncateToDouble()) {
      return balance.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      );
    }
    return balance.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  Widget _buildManagementCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ),
    );
  }
}
