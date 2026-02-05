import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../domain/entities/social_account_entity.dart';
import '../cubit/social_linking_cubit.dart';
import '../cubit/social_linking_state.dart';
import '../widgets/social_account_card.dart';

/// Screen for managing linked social accounts
class LinkedAccountsScreen extends StatefulWidget {
  const LinkedAccountsScreen({super.key});

  @override
  State<LinkedAccountsScreen> createState() => _LinkedAccountsScreenState();
}

class _LinkedAccountsScreenState extends State<LinkedAccountsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SocialLinkingCubit>().loadLinkedAccounts();
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
          'Connected Accounts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showAddAccountSheet(context),
            icon: const Icon(Icons.add, color: Color(0xFF3B82F6)),
          ),
        ],
      ),
      body: BlocConsumer<SocialLinkingCubit, SocialLinkingState>(
        listener: (context, state) {
          if (state is SocialAccountLinked) {
            Get.snackbar(
              'Success',
              '${state.account.provider.displayName} account connected',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            context.read<SocialLinkingCubit>().loadLinkedAccounts();
          } else if (state is SocialAccountUnlinked) {
            Get.snackbar(
              'Success',
              '${state.provider.displayName} account disconnected',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            context.read<SocialLinkingCubit>().loadLinkedAccounts();
          } else if (state is PrimarySocialAccountSet) {
            Get.snackbar(
              'Success',
              '${state.account.provider.displayName} set as primary',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            context.read<SocialLinkingCubit>().loadLinkedAccounts();
          } else if (state is SocialAccountReauthorized) {
            Get.snackbar(
              'Success',
              '${state.account.provider.displayName} reconnected',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            context.read<SocialLinkingCubit>().loadLinkedAccounts();
          } else if (state is SocialLinkingError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          if (state is SocialLinkingLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              ),
            );
          }

          if (state is LinkedSocialAccountsLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<SocialLinkingCubit>().loadLinkedAccounts(),
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: state.accounts.isEmpty
                  ? _buildEmptyState()
                  : _buildAccountsList(state.accounts, state.stats),
            );
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 80),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.link,
                  color: Color(0xFF3B82F6),
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'No Connected Accounts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connect your social accounts for easier login and better security',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _showAddAccountSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Connect Account'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountsList(
    List<LinkedSocialAccountEntity> accounts,
    SocialAccountStats stats,
  ) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatsCard(stats),
        const SizedBox(height: 24),
        const Text(
          'Connected Accounts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...accounts.map((account) => SocialAccountCard(
              account: account,
              onUnlink: () =>
                  context.read<SocialLinkingCubit>().unlinkAccount(account.id),
              onSetPrimary: () =>
                  context.read<SocialLinkingCubit>().setPrimaryAccount(account.id),
              onReauthorize: () =>
                  context.read<SocialLinkingCubit>().reauthorizeAccount(account.id),
            )),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => _showAddAccountSheet(context),
          icon: const Icon(Icons.add, color: Color(0xFF3B82F6)),
          label: const Text(
            'Connect Another Account',
            style: TextStyle(color: Color(0xFF3B82F6)),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(SocialAccountStats stats) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Account Summary',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${stats.totalAccounts} Connected',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem(
                icon: Icons.check_circle,
                label: 'Active',
                value: '${stats.activeAccounts}',
                color: const Color(0xFF10B981),
              ),
              const SizedBox(width: 24),
              if (stats.needsReauth > 0)
                _buildStatItem(
                  icon: Icons.warning,
                  label: 'Needs Action',
                  value: '${stats.needsReauth}',
                  color: const Color(0xFFFB923C),
                ),
            ],
          ),
          if (stats.primaryProvider != null) ...[
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Primary: ${SocialProvider.fromString(stats.primaryProvider!).displayName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddAccountSheet(BuildContext context) {
    final cubit = context.read<SocialLinkingCubit>();
    final linkedProviders =
        cubit.linkedAccounts.map((a) => a.provider).toSet();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Connect Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose a platform to connect',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            // Primary providers (Google, Apple, Facebook)
            for (final provider in [
              SocialProvider.google,
              SocialProvider.apple,
              SocialProvider.facebook,
            ])
              LinkProviderCard(
                provider: provider,
                isLinked: linkedProviders.contains(provider),
                onTap: () {
                  Navigator.pop(context);
                  cubit.linkAccount(provider);
                },
              ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF2D2D2D)),
            const SizedBox(height: 16),
            const Text(
              'Coming Soon',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            // Coming soon providers
            for (final provider in [
              SocialProvider.x,
              SocialProvider.linkedin,
              SocialProvider.instagram,
            ])
              Opacity(
                opacity: 0.5,
                child: LinkProviderCard(
                  provider: provider,
                  isLinked: linkedProviders.contains(provider),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
