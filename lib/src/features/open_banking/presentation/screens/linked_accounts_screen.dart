import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
    final cubit = context.read<OpenBankingCubit>();
    final result = await Get.to<bool>(
      () => BlocProvider.value(
        value: cubit,
        child: LinkBankScreen(
          userId: widget.userId,
          accessToken: widget.accessToken,
        ),
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
                    return GestureDetector(
                      onTap: () => _showAccountDetailSheet(account),
                      child: LinkedAccountCard(
                        account: account,
                        onUnlink: () => _onUnlink(account),
                        onSetDefault: () => _onSetDefault(account),
                        onRefreshBalance: () => _onRefreshBalance(account),
                      ),
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

  // ---------------------------------------------------------------------------
  // Account detail bottom sheet
  // ---------------------------------------------------------------------------

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy HH:mm').format(date);
  }

  Color _getBankColor(String bankName) {
    final name = bankName.toLowerCase();
    if (name.contains('access')) return const Color(0xFFED7D31);
    if (name.contains('gtb') || name.contains('guaranty')) {
      return const Color(0xFFE94C16);
    }
    if (name.contains('zenith')) return const Color(0xFFED1C24);
    if (name.contains('uba')) return const Color(0xFFE4002B);
    if (name.contains('first')) return const Color(0xFF003366);
    if (name.contains('sterling')) return const Color(0xFF003399);
    if (name.contains('fidelity')) return const Color(0xFF009933);
    if (name.contains('fcmb')) return const Color(0xFF800080);
    if (name.contains('ecobank')) return const Color(0xFF003366);
    if (name.contains('union')) return const Color(0xFF009DDC);
    if (name.contains('polaris')) return const Color(0xFF8B0000);
    if (name.contains('stanbic')) return const Color(0xFF0033A0);
    if (name.contains('wema')) return const Color(0xFF800080);
    if (name.contains('keystone')) return const Color(0xFF006400);
    if (name.contains('kuda')) return const Color(0xFF40196D);
    if (name.contains('opay')) return const Color(0xFF1BB066);
    if (name.contains('palmpay')) return const Color(0xFF6F42C1);
    if (name.contains('moniepoint')) return const Color(0xFF2F3292);
    return const Color(0xFF3B82F6);
  }

  void _showAccountDetailSheet(LinkedBankAccount account) {
    final bankColor = _getBankColor(account.bankName);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B7280),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 20.h),

                // Bank icon + name header
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: bankColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.account_balance,
                          color: bankColor, size: 24.sp),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            account.bankName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            account.accountName,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Detail card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Account Number', account.accountNumber),
                      _buildSheetDivider(),
                      _buildDetailRow('Account Type', account.accountType),
                      _buildSheetDivider(),
                      _buildDetailRow('Currency', account.currency),
                      _buildSheetDivider(),
                      _buildDetailRow('Balance', account.formattedBalance),
                      _buildSheetDivider(),
                      _buildDetailRow(
                        'Status',
                        account.isActive ? 'Active' : 'Inactive',
                        valueColor: account.isActive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                      if (account.isDefault) ...[
                        _buildSheetDivider(),
                        _buildDetailRow('Default', 'Yes',
                            valueColor: const Color(0xFF3B82F6)),
                      ],
                      _buildSheetDivider(),
                      _buildDetailRow(
                        'Linked Since',
                        _formatDate(account.linkedAt),
                      ),
                      if (account.lastUsedAt != null) ...[
                        _buildSheetDivider(),
                        _buildDetailRow(
                          'Last Used',
                          _formatDate(account.lastUsedAt!),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Action buttons row
                Row(
                  children: [
                    if (!account.isDefault)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            _onSetDefault(account);
                          },
                          icon: Icon(Icons.star_outline_rounded, size: 18.sp),
                          label: Text(
                            'Set Default',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF3B82F6),
                            side: const BorderSide(color: Color(0xFF3B82F6)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                        ),
                      ),
                    if (!account.isDefault) SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          _onRefreshBalance(account);
                        },
                        icon: Icon(Icons.refresh_rounded, size: 18.sp),
                        label: Text(
                          'Refresh Balance',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF10B981),
                          side: const BorderSide(color: Color(0xFF10B981)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // Unlink button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      _onUnlink(account);
                    },
                    icon: Icon(Icons.link_off_rounded, size: 18.sp),
                    label: Text(
                      'Unlink Account',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFEF4444).withValues(alpha: 0.15),
                      foregroundColor: const Color(0xFFEF4444),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 13.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetDivider() {
    return Divider(
      color: const Color(0xFF2D2D2D),
      height: 1.h,
      thickness: 0.5,
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
