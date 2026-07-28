import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/statement_export_screen.dart';
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

          // Account Statement — backend-rendered PDF/CSV.
          // Routes to the dedicated StatementExportScreen rather than
          // the legacy inline date-picker dialog so the user sees the
          // full picker + format + recents UX.
          _buildDocumentButton(
            context,
            icon: Icons.receipt_long_outlined,
            title: 'Generate Statement',
            subtitle: 'PDF or CSV for any date range',
            trailing: 'Open →',
            onTap: () => _onGenerateStatement(context),
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
          SizedBox(height: 32.h),

          // Recent statements (in-memory list maintained by
          // StatementExportScreen). Empty on first visit; once the user
          // generates one, this surface mirrors the success card so they
          // can re-open from inside the account-actions sheet.
          if (getRecentStatements().isNotEmpty) ...[
            Text(
              'Recent statements',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            for (final doc in getRecentStatements().take(3)) ...[
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      doc.format == DocumentFormat.csv
                          ? Icons.table_chart_outlined
                          : Icons.picture_as_pdf_outlined,
                      color: const Color(0xFF3B82F6),
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '${doc.format.name.toUpperCase()} • ${doc.transactionCount ?? 0} txns',
                            style: TextStyle(
                                color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16.h),
          ],

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

  void _onGenerateStatement(BuildContext context) {
    final accountId = AccountIdValidator.extractFromArgs(accountArgs);
    if (accountId == null) {
      ValidationDialog.show(
        context,
        title: 'Error',
        message: 'Unable to identify account. Please close and try again.',
      );
      return;
    }
    // Close the account-actions bottom sheet first so the new screen
    // doesn't stack on top of it (Get.back closes the modal, leaving
    // the underlying dashboard route as the parent).
    Get.back();
    Get.toNamed(
      AppRoutes.statementExport,
      arguments: {'accountId': accountId},
    );
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
