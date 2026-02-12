import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../cubit/open_banking_cubit.dart';
import '../../cubit/open_banking_state.dart';
import '../../domain/entities/linked_bank_account.dart';
import '../widgets/linked_account_card.dart';
import '../widgets/link_bank_button.dart';
import 'link_bank_screen.dart';

/// Screen to manage linked bank accounts
class LinkedAccountsScreen extends StatefulWidget {
  final String userId;
  final String accessToken;

  const LinkedAccountsScreen({
    super.key,
    required this.userId,
    required this.accessToken,
  });

  @override
  State<LinkedAccountsScreen> createState() => _LinkedAccountsScreenState();
}

class _LinkedAccountsScreenState extends State<LinkedAccountsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  void _fetchAccounts() {
    context.read<OpenBankingCubit>().fetchLinkedAccounts(
          userId: widget.userId,
          accessToken: widget.accessToken,
        );
  }

  void _navigateToLinkBank() async {
    final result = await Get.to<bool>(
      () => LinkBankScreen(
        userId: widget.userId,
        accessToken: widget.accessToken,
      ),
    );

    if (result == true) {
      _fetchAccounts();
    }
  }

  void _onUnlink(LinkedBankAccount account) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text('Unlink Account', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to unlink ${account.bankName} (${account.displayAccountNumber})?',
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Unlink'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      context.read<OpenBankingCubit>().unlinkAccount(
            accountId: account.id,
            userId: widget.userId,
            accessToken: widget.accessToken,
          );
    }
  }

  void _onSetDefault(LinkedBankAccount account) {
    context.read<OpenBankingCubit>().setDefaultAccount(
          accountId: account.id,
          userId: widget.userId,
          accessToken: widget.accessToken,
        );
  }

  void _onRefreshBalance(LinkedBankAccount account) {
    context.read<OpenBankingCubit>().refreshBalance(
          accountId: account.id,
          userId: widget.userId,
          accessToken: widget.accessToken,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('Linked Banks'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchAccounts,
          ),
        ],
      ),
      body: BlocConsumer<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
          if (state is OpenBankingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AccountUnlinked) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account unlinked successfully'),
                backgroundColor: Colors.green,
              ),
            );
            _fetchAccounts();
          } else if (state is BalanceRefreshed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Balance refreshed'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is OpenBankingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final accounts = context.read<OpenBankingCubit>().linkedAccounts;

          if (accounts.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return LinkedAccountCard(
                      account: account,
                      onUnlink: () => _onUnlink(account),
                      onSetDefault: () => _onSetDefault(account),
                      onRefreshBalance: () => _onRefreshBalance(account),
                    );
                  },
                ),
              ),
              // Add new bank button
              Padding(
                padding: EdgeInsets.all(16.w),
                child: LinkBankButton(
                  onPressed: _navigateToLinkBank,
                  label: 'Link Another Bank',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_outlined,
              size: 80.sp,
              color: const Color(0xFF9CA3AF),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Linked Banks',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Link your bank account to deposit funds directly into your LazerVault wallet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 32.h),
            LinkBankButton(
              onPressed: _navigateToLinkBank,
              label: 'Link Your Bank',
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
