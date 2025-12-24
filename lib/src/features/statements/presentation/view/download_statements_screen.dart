import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_state.dart';

class DownloadStatementsScreen extends StatefulWidget {
  const DownloadStatementsScreen({super.key});

  @override
  State<DownloadStatementsScreen> createState() => _DownloadStatementsScreenState();
}

class _DownloadStatementsScreenState extends State<DownloadStatementsScreen> {
  String? _selectedAccountId;
  DateTime? _startDate;
  DateTime? _endDate;
  StatementFormat _selectedFormat = StatementFormat.pdf;

  @override
  void initState() {
    super.initState();
    // Load accounts on init - Note: userId will be fetched from secure storage in real implementation
    // For now, using a placeholder userId
    context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
      userId: 'current_user',
      accessToken: null,
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4E03D0),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _downloadStatement() {
    if (_selectedAccountId == null) {
      Get.snackbar(
        'Error',
        'Please select an account',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      Get.snackbar(
        'Error',
        'Please select a date range',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    context.read<StatementCubit>().downloadStatement(
          accountId: _selectedAccountId!,
          startDate: _startDate!,
          endDate: _endDate!,
          format: _selectedFormat,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Download Statements',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StatementCubit, StatementState>(
            listener: (context, state) {
              if (state is StatementDownloadSuccess) {
                Get.snackbar(
                  'Success',
                  state.statement.message,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                );
                // Load statement history after successful download
                if (_selectedAccountId != null) {
                  context.read<StatementCubit>().getStatementHistory(
                        accountId: _selectedAccountId!,
                      );
                }
              } else if (state is StatementDownloadFailure) {
                Get.snackbar(
                  'Error',
                  state.message,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Selection
              Text(
                'Select Account',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
              SizedBox(height: 8.h),
              BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
                builder: (context, state) {
                  if (state is AccountCardsSummaryLoading) {
                    return Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is AccountCardsSummaryLoaded) {
                    final accounts = state.accountSummaries;
                    if (accounts.isEmpty) {
                      return Container(
                        height: 56.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Center(
                          child: Text(
                            'No accounts available',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedAccountId,
                          hint: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'Choose an account',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Color(0xFF4E03D0)),
                          items: accounts.map((account) {
                            return DropdownMenuItem<String>(
                              value: account.id,
                              child: Text(
                                '${account.accountType} (*${account.accountNumberLast4})',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => _selectedAccountId = value);
                            if (value != null) {
                              // Load statement history for selected account
                              context.read<StatementCubit>().getStatementHistory(
                                    accountId: value,
                                  );
                            }
                          },
                        ),
                      ),
                    );
                  }

                  return Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Center(
                      child: Text(
                        'Failed to load accounts',
                        style: GoogleFonts.inter(color: Colors.redAccent),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),

              // Date Range Selection
              Text(
                'Date Range',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _selectDateRange,
                child: Container(
                  height: 56.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range, color: Color(0xFF4E03D0)),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          _startDate != null && _endDate != null
                              ? '${DateFormat('MMM dd, yyyy').format(_startDate!)} - ${DateFormat('MMM dd, yyyy').format(_endDate!)}'
                              : 'Select date range',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: _startDate != null
                                ? const Color(0xFF1F2937)
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Format Selection
              Text(
                'Format',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF374151),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: _FormatButton(
                      label: 'PDF',
                      icon: Icons.picture_as_pdf,
                      isSelected: _selectedFormat == StatementFormat.pdf,
                      onTap: () => setState(() => _selectedFormat = StatementFormat.pdf),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _FormatButton(
                      label: 'CSV',
                      icon: Icons.table_chart,
                      isSelected: _selectedFormat == StatementFormat.csv,
                      onTap: () => setState(() => _selectedFormat = StatementFormat.csv),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _FormatButton(
                      label: 'Excel',
                      icon: Icons.grid_on,
                      isSelected: _selectedFormat == StatementFormat.excel,
                      onTap: () => setState(() => _selectedFormat = StatementFormat.excel),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Download Button
              BlocBuilder<StatementCubit, StatementState>(
                builder: (context, state) {
                  final isDownloading = state is StatementDownloading;

                  return SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: isDownloading ? null : _downloadStatement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: isDownloading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.download, color: Colors.white),
                                SizedBox(width: 8.w),
                                Text(
                                  'Download Statement',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),

              // Statement History
              if (_selectedAccountId != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Statements',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                BlocBuilder<StatementCubit, StatementState>(
                  builder: (context, state) {
                    if (state is StatementHistoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is StatementHistoryLoaded) {
                      final statements = state.statements;

                      if (statements.isEmpty) {
                        return Container(
                          padding: EdgeInsets.all(32.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              'No previous statements',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: statements.map((statement) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    _getFormatIcon(statement.format),
                                    color: const Color(0xFF4E03D0),
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        statement.message,
                                        style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF1F2937),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        '${DateFormat('MMM dd, yyyy').format(statement.startDate)} - ${DateFormat('MMM dd, yyyy').format(statement.endDate)}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          color: const Color(0xFF6B7280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.download,
                                  color: const Color(0xFF4E03D0),
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getFormatIcon(StatementFormat format) {
    switch (format) {
      case StatementFormat.pdf:
        return Icons.picture_as_pdf;
      case StatementFormat.csv:
        return Icons.table_chart;
      case StatementFormat.excel:
        return Icons.grid_on;
    }
  }
}

class _FormatButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FormatButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4E03D0).withValues(alpha: 0.1) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4E03D0) : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4E03D0) : const Color(0xFF6B7280),
              size: 20.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFF4E03D0) : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
