import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/core/utils/edge_case_validator.dart';

/// Documents Tab - Download statements and other documents
class DocumentsTab extends StatelessWidget {
  final Map<String, dynamic> accountArgs;
  final bool isLoading;

  const DocumentsTab({
    super.key,
    required this.accountArgs,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  color: const Color(0xFF10B981),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Download official documents for your records. Statements are generated in PDF format.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Text(
            'Official Documents',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          // Account Statement
          _buildDocumentButton(
            context,
            icon: Icons.receipt_long_outlined,
            title: 'Account Statement',
            subtitle: 'View your transaction history',
            trailing: 'View & Download →',
            onTap: () => _onDownloadStatement(context),
          ),
          SizedBox(height: 12.h),

          // Account Confirmation
          _buildDocumentButton(
            context,
            icon: Icons.verified_outlined,
            title: 'Account Confirmation',
            subtitle: 'Proof of account letter',
            trailing: 'Download →',
            onTap: () => _onDownloadConfirmation(context),
          ),
          SizedBox(height: 12.h),

          // Proof of Funds
          _buildDocumentButton(
            context,
            icon: Icons.account_balance_wallet_outlined,
            title: 'Proof of Funds',
            subtitle: 'Official balance confirmation',
            trailing: 'Request →',
            onTap: () => _onRequestProofOfFunds(context),
          ),
          SizedBox(height: 24.h),

          // Transaction History
          _buildDocumentButton(
            context,
            icon: Icons.history_outlined,
            title: 'Transaction History',
            subtitle: 'View all transactions',
            trailing: 'View →',
            onTap: () => _onViewTransactionHistory(context),
          ),
          SizedBox(height: 32.h),

          // Help text
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF3B82F6),
                  size: 16.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Statements are available for the last 12 months. For older statements, please contact support.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                trailing,
                style: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDownloadStatement(BuildContext context) {
    // Validate account ID first
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }

    // Show date range picker dialog
    final now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month - 1, 1);
    DateTime endDate = now;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Text(
              'Generate Statement',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select date range for your statement (max 12 months):',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildDateRangeRow(
                  'Start Date',
                  _formatDate(startDate),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: now.subtract(const Duration(days: 365)),
                      lastDate: now,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF3B82F6),
                              onPrimary: Colors.white,
                              surface: Color(0xFF1E1E1E),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setDialogState(() => startDate = picked);
                    }
                  },
                ),
                SizedBox(height: 12.h),
                _buildDateRangeRow(
                  'End Date',
                  _formatDate(endDate),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: startDate,
                      lastDate: now,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF3B82F6),
                              onPrimary: Colors.white,
                              surface: Color(0xFF1E1E1E),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setDialogState(() => endDate = picked);
                    }
                  },
                ),
                SizedBox(height: 16.h),
                _buildDateRangeRow('Format', 'PDF'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Validate date range
                  final validation = DateRangeValidator.validateRange(
                    startDate,
                    endDate,
                    maxDaysBack: 365,
                    maxDaysAhead: 0,
                  );

                  if (!validation.isValid) {
                    // Show error, don't close dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(validation.errorMessage ?? 'Invalid date range'),
                        backgroundColor: const Color(0xFFEF4444),
                      ),
                    );
                    return;
                  }

                  Get.back();
                  context.read<AccountActionsCubit>().downloadAccountStatement(
                    accountId: accountId,
                    startDate: startDate,
                    endDate: endDate,
                    format: DocumentFormat.pdf,
                  );
                },
                child: Text(
                  'Download',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _onDownloadConfirmation(BuildContext context) {
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }
    context.read<AccountActionsCubit>().downloadAccountConfirmation(
      accountId: accountId,
    );
  }

  void _onRequestProofOfFunds(BuildContext context) {
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Proof of Funds',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This document confirms your current account balance. It\'s valid for 30 days from the date of issue.',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            _buildDateRangeRow('Valid for', '30 days'),
            SizedBox(height: 16.h),
            _buildDateRangeRow('Format', 'PDF'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              context.read<AccountActionsCubit>().requestProofOfFunds(
                accountId: accountId,
              );
            },
            child: Text(
              'Request',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onViewTransactionHistory(BuildContext context) {
    // Navigate to transaction history screen
    Get.back(); // Close bottom sheet first
    Get.toNamed('/transactions');
  }

  Widget _buildDateRangeRow(String label, String value, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: onTap != null ? const Color(0xFF3B82F6) : Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (onTap != null) ...[
                SizedBox(width: 4.w),
                Icon(
                  Icons.calendar_today_outlined,
                  color: const Color(0xFF3B82F6),
                  size: 14.sp,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
