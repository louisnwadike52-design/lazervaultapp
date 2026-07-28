import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_state.dart';
import 'package:lazervault/src/features/statements/data/services/statement_file_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';

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
  final StatementFileService _fileService = serviceLocator<StatementFileService>();
  bool _isPreparingFile = false;

  // Locally-persisted recent statements (no backend history RPC exists). Each
  // entry captures the params needed to re-generate + re-download/share, since
  // the backend download URL is short-lived.
  static const String _recentKey = 'recent_statements_v1';
  List<Map<String, dynamic>> _recent = [];

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthenticationCubit>().userId ?? '';
    context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
      userId: userId,
      accessToken: null,
    );
    _loadRecent();
  }

  Future<void> _loadRecent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_recentKey);
      if (raw != null && raw.isNotEmpty) {
        final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
        if (mounted) setState(() => _recent = list);
      }
    } catch (_) {/* start empty */}
  }

  Future<void> _recordRecent(StatementEntity s) async {
    final entry = {
      'accountId': s.accountId,
      'startMs': s.startDate.millisecondsSinceEpoch,
      'endMs': s.endDate.millisecondsSinceEpoch,
      'format': s.format == StatementFormat.csv ? 'csv' : 'pdf',
      'generatedMs': DateTime.now().millisecondsSinceEpoch,
    };
    // De-dupe identical (account + range + format); newest first; cap at 20.
    _recent.removeWhere((e) =>
        e['accountId'] == entry['accountId'] &&
        e['startMs'] == entry['startMs'] &&
        e['endMs'] == entry['endMs'] &&
        e['format'] == entry['format']);
    _recent.insert(0, entry);
    if (_recent.length > 20) _recent = _recent.sublist(0, 20);
    if (mounted) setState(() {});
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_recentKey, jsonEncode(_recent));
    } catch (_) {/* non-fatal */}
  }

  void _redownloadRecent(Map<String, dynamic> e) {
    setState(() {
      _selectedAccountId = e['accountId'] as String;
      _startDate = DateTime.fromMillisecondsSinceEpoch(e['startMs'] as int);
      _endDate = DateTime.fromMillisecondsSinceEpoch(e['endMs'] as int);
      _selectedFormat =
          e['format'] == 'csv' ? StatementFormat.csv : StatementFormat.pdf;
    });
    // Regenerate — the previous signed URL has expired; the backend's 10-min
    // idempotency cache makes a repeat cheap.
    context.read<StatementCubit>().downloadStatement(
          accountId: _selectedAccountId!,
          startDate: _startDate!,
          endDate: _endDate!,
          format: _selectedFormat,
        );
  }

  static const Color _purple = Color(0xFF4E03D0);

  Future<DateTime?> _pickSingleDate(DateTime? initial, DateTime first, DateTime last) {
    return showDatePicker(
      context: context,
      initialDate: initial ?? last,
      firstDate: first,
      lastDate: last,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: _purple),
        ),
        child: child!,
      ),
    );
  }

  /// Bottom-sheet date-range picker: quick presets + explicit Start / End
  /// fields. Replaces the full-screen Material range dialog.
  Future<void> _selectDateRange() async {
    final now = DateTime.now();
    final firstAllowed = DateTime(2000);
    DateTime? start = _startDate;
    DateTime? end = _endDate;

    final applied = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (sheetCtx, setSheet) {
            Widget dateField(String label, DateTime? value, VoidCallback onTap) {
              return Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label,
                            style: GoogleFonts.inter(
                                fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
                        SizedBox(height: 4.h),
                        Text(
                          value != null
                              ? DateFormat('MMM dd, yyyy').format(value)
                              : 'Select',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: value != null
                                ? const Color(0xFF1F2937)
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            Widget presetChip(String label, VoidCallback onTap) {
              return InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: _purple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: _purple.withValues(alpha: 0.3)),
                  ),
                  child: Text(label,
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _purple)),
                ),
              );
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5E7EB),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text('Select date range',
                        style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F2937))),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        presetChip('Last 30 days', () {
                          setSheet(() {
                            end = now;
                            start = now.subtract(const Duration(days: 30));
                          });
                        }),
                        presetChip('Last 90 days', () {
                          setSheet(() {
                            end = now;
                            start = now.subtract(const Duration(days: 90));
                          });
                        }),
                        presetChip('This year', () {
                          setSheet(() {
                            end = now;
                            start = DateTime(now.year, 1, 1);
                          });
                        }),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        dateField('Start', start, () async {
                          final d = await _pickSingleDate(
                              start, firstAllowed, end ?? now);
                          if (d != null) setSheet(() => start = d);
                        }),
                        SizedBox(width: 12.w),
                        dateField('End', end, () async {
                          final d = await _pickSingleDate(
                              end, start ?? firstAllowed, now);
                          if (d != null) setSheet(() => end = d);
                        }),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                        onPressed: () {
                          if (start == null || end == null) {
                            LVSnackbar.showError(
                              title: 'Incomplete',
                              message: 'Pick both a start and end date.',
                            );
                            return;
                          }
                          if (start!.isAfter(end!)) {
                            LVSnackbar.showError(
                              title: 'Invalid range',
                              message: 'Start date must be before the end date.',
                            );
                            return;
                          }
                          Navigator.pop(sheetCtx, true);
                        },
                        child: Text('Apply',
                            style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (applied == true && start != null && end != null) {
      setState(() {
        _startDate = start;
        _endDate = end;
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

  String _formatExtension(StatementFormat format) {
    switch (format) {
      case StatementFormat.pdf:
        return 'pdf';
      case StatementFormat.csv:
        return 'csv';
      case StatementFormat.excel:
        return 'xlsx';
    }
  }

  /// After the backend has generated the statement, pull the real file to disk
  /// (verifying its sha256 when present) and offer Open / Print / Share.
  Future<void> _handleDownloadSuccess(StatementEntity statement) async {
    final downloadUrl = statement.filePath;
    if (downloadUrl == null || downloadUrl.isEmpty) {
      LVSnackbar.showError(
        title: 'Download failed',
        message: 'The statement is not available to download right now.',
      );
      return;
    }

    setState(() => _isPreparingFile = true);
    try {
      final ext = _formatExtension(statement.format);
      final filename =
          'statement_${statement.accountId}_${statement.startDate.millisecondsSinceEpoch}.$ext';
      final localPath = await _fileService.downloadToFile(
        downloadUrl,
        filename,
        expectedSha256: statement.sha256,
      );

      if (!mounted) return;
      await _recordRecent(statement);
      if (!mounted) return;
      LVSnackbar.showSuccess(
        title: 'Statement ready',
        message: 'Your statement has been downloaded.',
      );
      _showStatementActions(localPath, statement.format);
    } catch (e) {
      if (!mounted) return;
      LVSnackbar.showErrorFor(e, context: 'download your statement');
    } finally {
      if (mounted) setState(() => _isPreparingFile = false);
    }
  }

  void _showStatementActions(String path, StatementFormat format) {
    final isPdf = format == StatementFormat.pdf;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Statement downloaded',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 8.h),
                ListTile(
                  leading: const Icon(Icons.open_in_new, color: Color(0xFF4E03D0)),
                  title: Text(
                    'Open',
                    style: GoogleFonts.inter(color: const Color(0xFF1F2937)),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _openFile(path);
                  },
                ),
                if (isPdf)
                  ListTile(
                    leading: const Icon(Icons.print, color: Color(0xFF4E03D0)),
                    title: Text(
                      'Print',
                      style: GoogleFonts.inter(color: const Color(0xFF1F2937)),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      _printFile(path);
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.ios_share, color: Color(0xFF4E03D0)),
                  title: Text(
                    'Share',
                    style: GoogleFonts.inter(color: const Color(0xFF1F2937)),
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _shareFile(path);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openFile(String path) async {
    try {
      await _fileService.openFile(path);
    } catch (e) {
      if (mounted) LVSnackbar.showErrorFor(e, context: 'open your statement');
    }
  }

  Future<void> _printFile(String path) async {
    try {
      await _fileService.printPdf(path);
    } catch (e) {
      if (mounted) LVSnackbar.showErrorFor(e, context: 'print your statement');
    }
  }

  Future<void> _shareFile(String path) async {
    try {
      await _fileService.shareFile(path);
    } catch (e) {
      if (mounted) LVSnackbar.showErrorFor(e, context: 'share your statement');
    }
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
                _handleDownloadSuccess(state.statement);
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
                      child: const Center(child: LazerVaultLoader.small()),
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
                ],
              ),
              SizedBox(height: 32.h),

              // Download Button
              BlocBuilder<StatementCubit, StatementState>(
                builder: (context, state) {
                  final isDownloading =
                      state is StatementDownloading || _isPreparingFile;

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
                          ? LazerVaultLoader.small()
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

              // Recent statements — locally persisted, tap to re-download/share.
              if (_recent.isNotEmpty) ...[
                Text(
                  'Recent Statements',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(height: 16.h),
                ..._recent.map(_recentTile),
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

  Widget _recentTile(Map<String, dynamic> e) {
    final fmt = e['format'] == 'csv' ? StatementFormat.csv : StatementFormat.pdf;
    final start = DateTime.fromMillisecondsSinceEpoch(e['startMs'] as int);
    final end = DateTime.fromMillisecondsSinceEpoch(e['endMs'] as int);
    final generated = DateTime.fromMillisecondsSinceEpoch(e['generatedMs'] as int);
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _redownloadRecent(e),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(_getFormatIcon(fmt),
                      color: const Color(0xFF4E03D0), size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Statement (${fmt == StatementFormat.csv ? 'CSV' : 'PDF'})',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${DateFormat('MMM dd, yyyy').format(start)} - ${DateFormat('MMM dd, yyyy').format(end)}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Generated ${DateFormat('MMM dd, yyyy').format(generated)}',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.download_rounded,
                    color: const Color(0xFF4E03D0), size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
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
