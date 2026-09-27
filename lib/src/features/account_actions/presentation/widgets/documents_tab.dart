import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/statements/data/services/statement_recent_store.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/presentation/widgets/statement_export_host.dart';
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

          // Account Statement — the same export panel the settings screen
          // and the dashboard's export route render, opened as a sheet over
          // this one with THIS account already pinned.
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

          // Recent statements, from the same persisted store the export
          // panel writes. Previously this read an in-memory list owned by the
          // export screen, which was empty the moment that screen was
          // disposed — so this section was permanently blank in practice.
          _RecentStatements(accountId: accountArgs['id']?.toString()),

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
    // Opened OVER this sheet rather than replacing it. Closing the
    // account-actions sheet to push a route meant that finishing an export
    // dropped the user back on the dashboard, several taps from the account
    // they were looking at.
    showStatementExportSheet(context, accountId: accountId);
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

/// The last few statements generated for this account, newest first.
///
/// Tapping one re-opens the export sheet with that request pre-filled rather
/// than silently re-downloading: the signed URL has long expired, and a
/// download starting with no confirmation is the kind of surprise that makes
/// people think they were charged for something.
class _RecentStatements extends StatefulWidget {
  final String? accountId;

  const _RecentStatements({this.accountId});

  @override
  State<_RecentStatements> createState() => _RecentStatementsState();
}

class _RecentStatementsState extends State<_RecentStatements> {
  final StatementRecentStore _store = StatementRecentStore();
  List<StatementRecentEntry> _entries = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await _store.load();
    if (!mounted) return;
    final id = widget.accountId;
    setState(() {
      // Scoped to this account: a statement for a different wallet listed
      // inside this account's sheet reads as this account's history.
      _entries = (id == null || id.isEmpty)
          ? all
          : all.where((e) => e.accountId == id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_entries.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent statements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        for (final entry in _entries.take(3))
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () => showStatementExportSheet(
                  context,
                  accountId: entry.accountId,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      Icon(
                        entry.format == StatementFormat.csv
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
                            Text(
                              'Statement '
                              '(${entry.format == StatementFormat.csv ? 'CSV' : 'PDF'})',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '${DateFormat('MMM dd, yyyy').format(entry.startDate)}'
                              ' - '
                              '${DateFormat('MMM dd, yyyy').format(entry.endDate)}',
                              style: TextStyle(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right,
                          color: const Color(0xFF9CA3AF), size: 18.sp),
                    ],
                  ),
                ),
              ),
            ),
          ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
