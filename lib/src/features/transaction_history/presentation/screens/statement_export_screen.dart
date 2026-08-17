// Statement Export Screen — backend-rendered account statements.
//
// The user picks an account, a date range, and a format (PDF / CSV); the
// app calls accounts-service GenerateStatement, which renders the file
// server-side, uploads it to storage-service, and returns a public URL +
// SHA-256 digest. This file then opens via url_launcher so the OS
// download manager / browser handles persistence + share.
//
// Distinct from the EXISTING local export sheet (`ExportBottomSheet`
// invoked by the AppBar download icon), which serialises whatever
// transactions the in-app feed already has and shares them straight from
// memory. The backend export is the canonical, audit-ready receipt.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
part 'statement_export_screen_widgets.dart';


/// In-memory list of recently exported statements. Kept on the screen
/// because the spec asks for a "Recent statements" surface in the
/// Documents tab; persisting would require schema + sync, which is
/// out-of-scope for this slice. Survives only within a single screen
/// instance; the next slice can promote this to a Hive box.
final List<DocumentEntity> _recentStatements = <DocumentEntity>[];

/// Read-only view of the in-memory recent statements list. Other widgets
/// (DocumentsTab) read this to render the same list without re-fetching.
List<DocumentEntity> getRecentStatements() => List.unmodifiable(_recentStatements);

class StatementExportScreen extends StatefulWidget {
  /// initialAccountId pre-selects the account when the screen is opened
  /// from a per-account surface (e.g. the Documents tab inside the
  /// account-actions sheet). Null = let the user pick.
  final String? initialAccountId;

  const StatementExportScreen({super.key, this.initialAccountId});

  /// Route navigation helper. Goes through the central app router so the
  /// BlocProviders the screen expects are wired in a single place.
  static void open(BuildContext context, {String? initialAccountId}) {
    Get.toNamed(
      '/transactions/statement-export',
      arguments: {'accountId': initialAccountId},
    );
  }

  @override
  State<StatementExportScreen> createState() => _StatementExportScreenState();
}

class _StatementExportScreenState extends State<StatementExportScreen> {
  String? _selectedAccountId;
  _RangePreset _preset = _RangePreset.last30Days;
  DateTime _customStart = DateTime.now().subtract(const Duration(days: 30));
  DateTime _customEnd = DateTime.now();
  DocumentFormat _format = DocumentFormat.pdf;

  @override
  void initState() {
    super.initState();
    _selectedAccountId = widget.initialAccountId;
    // Fetch the user's accounts so the selector populates. Pulled at
    // initState rather than build because fetchAccountSummaries requires
    // a userId we resolve from AuthenticationCubit (a context-coupled
    // singleton). The fetch is a no-op if the cubit already has data.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final auth = context.read<AuthenticationCubit>();
      final userId = auth.userId;
      if (userId != null && userId.isNotEmpty) {
        context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(userId: userId);
      }
    });
  }

  // ── Date-range resolution ──────────────────────────────────────────
  ({DateTime from, DateTime to}) _resolveRange() {
    final now = DateTime.now();
    switch (_preset) {
      case _RangePreset.last30Days:
        return (from: now.subtract(const Duration(days: 30)), to: now);
      case _RangePreset.last90Days:
        return (from: now.subtract(const Duration(days: 90)), to: now);
      case _RangePreset.thisYear:
        return (from: DateTime(now.year, 1, 1), to: now);
      case _RangePreset.custom:
        return (from: _customStart, to: _customEnd);
    }
  }

  // ── Submit / generate ──────────────────────────────────────────────
  void _onGenerate() {
    if (_selectedAccountId == null || _selectedAccountId!.isEmpty) {
      _snack('Choose an account first.', isError: true);
      return;
    }
    final range = _resolveRange();
    if (range.to.isBefore(range.from)) {
      _snack('End date must be on or after start date.', isError: true);
      return;
    }
    final spanDays = range.to.difference(range.from).inDays;
    if (spanDays > 366) {
      _snack('Pick a window of 366 days or fewer.', isError: true);
      return;
    }
    context.read<AccountActionsCubit>().downloadAccountStatement(
          accountId: _selectedAccountId!,
          startDate: range.from,
          endDate: range.to,
          format: _format,
        );
  }

  Future<void> _openDocument(DocumentEntity doc) async {
    final url = doc.downloadUrl;
    if (url == null || url.isEmpty) {
      _snack('No download URL on this document.', isError: true);
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      _snack('Invalid download URL.', isError: true);
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      _snack('Could not open the statement. Copy the URL from the receipt.', isError: true);
    }
  }

  void _snack(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: TextStyle(fontSize: 13.sp)),
      backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // ── Build ──────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Export Statement',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<AccountActionsCubit, AccountActionsState>(
        listener: (context, state) {
          if (state is DocumentDownloaded) {
            // Capture, prepend, render success card.
            setState(() {
              _recentStatements.insert(0, state.document);
              // Trim the in-memory list — never more than 10.
              if (_recentStatements.length > 10) {
                _recentStatements.removeRange(10, _recentStatements.length);
              }
            });
            _showSuccessSheet(state.document);
          }
        },
        builder: (context, state) {
          final isBusy = state is DocumentDownloading;
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccountSelector(),
                    SizedBox(height: 24.h),
                    _buildDateRangeSection(),
                    SizedBox(height: 24.h),
                    _buildFormatSection(),
                    SizedBox(height: 24.h),
                    if (state is AccountActionsError) _buildInlineError(state),
                    SizedBox(height: 24.h),
                    _buildCTA(isBusy),
                    SizedBox(height: 32.h),
                    if (_recentStatements.isNotEmpty) _buildRecentList(),
                  ],
                ),
              ),
              if (isBusy)
                Container(
                  color: Colors.black.withValues(alpha: 0.55),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const LazerVaultLoader.medium(),
                        SizedBox(height: 16.h),
                        Text(
                          'Generating your statement…',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // ── Account selector ───────────────────────────────────────────────
  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading || state is AccountCardsSummaryInitial) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Row(
              children: [
                LazerVaultLoader.small(),
                SizedBox(width: 12),
                Text('Loading accounts…',
                    style: TextStyle(color: Color(0xFF9CA3AF))),
              ],
            ),
          );
        }
        final accounts = state is AccountCardsSummaryLoaded
            ? state.accountSummaries
            : (state is AccountBalanceUpdated ? state.accountSummaries : <AccountSummaryEntity>[]);
        // Default to the primary / first account if nothing pre-selected.
        if (_selectedAccountId == null && accounts.isNotEmpty) {
          final primary = accounts.firstWhere(
            (a) => a.isPrimary,
            orElse: () => accounts.first,
          );
          _selectedAccountId = primary.id;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('Account'),
            SizedBox(height: 10.h),
            if (accounts.isEmpty)
              _emptyHint('No accounts found. Add an account first.')
            else
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < accounts.length; i++) ...[
                      _accountRow(accounts[i]),
                      if (i != accounts.length - 1)
                        const Divider(height: 1, color: Color(0xFF2D2D2D)),
                    ],
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _accountRow(AccountSummaryEntity a) {
    final selected = a.id == _selectedAccountId;
    return InkWell(
      onTap: () => setState(() => _selectedAccountId = a.id),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? const Color(0xFF3B82F6) : const Color(0xFF4B5563),
                  width: 2,
                ),
                color: selected ? const Color(0xFF3B82F6) : Colors.transparent,
              ),
              child: selected
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a.displayName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${a.currency} •••• ${a.accountNumberLast4}',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Date range section ─────────────────────────────────────────────
  Widget _buildDateRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Date range'),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _RangePreset.values.map((p) {
            final selected = p == _preset;
            return ChoiceChip(
              label: Text(p.label, style: TextStyle(fontSize: 12.sp)),
              selected: selected,
              onSelected: (_) => setState(() => _preset = p),
              backgroundColor: const Color(0xFF1F1F1F),
              selectedColor: const Color(0xFF3B82F6),
              labelStyle: TextStyle(
                color: selected ? Colors.white : const Color(0xFF9CA3AF),
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: BorderSide(
                  color: selected ? Colors.transparent : const Color(0xFF2D2D2D),
                ),
              ),
            );
          }).toList(),
        ),
        if (_preset == _RangePreset.custom) ...[
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(child: _dateField('From', _customStart, (d) => setState(() => _customStart = d))),
              SizedBox(width: 12.w),
              Expanded(child: _dateField('To', _customEnd, (d) => setState(() => _customEnd = d))),
            ],
          ),
        ],
        SizedBox(height: 8.h),
        Builder(builder: (_) {
          final r = _resolveRange();
          return Text(
            'Window: ${_fmtShortDate(r.from)} → ${_fmtShortDate(r.to)} (${r.to.difference(r.from).inDays} days)',
            style: TextStyle(color: const Color(0xFF6B7280), fontSize: 11.sp),
          );
        }),
      ],
    );
  }

  Widget _dateField(String label, DateTime value, ValueChanged<DateTime> onChange) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime.now().subtract(const Duration(days: 366 * 3)),
          lastDate: DateTime.now(),
          builder: (context, child) => Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color(0xFF3B82F6),
                onPrimary: Colors.white,
                surface: Color(0xFF1E1E1E),
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onChange(picked);
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
            SizedBox(height: 4.h),
            Text(_fmtShortDate(value),
                style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ── Format section ─────────────────────────────────────────────────
  Widget _buildFormatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Format'),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(child: _formatTile(DocumentFormat.pdf, 'PDF', Icons.picture_as_pdf_outlined,
                'Branded, printable receipt')),
            SizedBox(width: 12.w),
            Expanded(child: _formatTile(DocumentFormat.csv, 'CSV', Icons.table_chart_outlined,
                'Spreadsheet-friendly, RFC-4180')),
          ],
        ),
      ],
    );
  }

  Widget _formatTile(DocumentFormat f, String label, IconData icon, String hint) {
    final selected = f == _format;
    return InkWell(
      onTap: () => setState(() => _format = f),
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? const Color(0xFF3B82F6) : const Color(0xFF9CA3AF), size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(hint,
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── CTA ────────────────────────────────────────────────────────────
  Widget _buildCTA(bool isBusy) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isBusy ? null : _onGenerate,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        child: isBusy
            ? const LazerVaultLoader.small()
            : Text('Generate Statement',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // ── Error inline + retry ───────────────────────────────────────────
  Widget _buildInlineError(AccountActionsError err) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Statement failed',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Text(err.message,
                    style: TextStyle(color: const Color(0xFFFCA5A5), fontSize: 12.sp)),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    ),
                    onPressed: _onGenerate,
                    icon: Icon(Icons.refresh, size: 16.sp),
                    label: Text('Retry', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Recent list ────────────────────────────────────────────────────
  Widget _buildRecentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Recent statements'),
        SizedBox(height: 10.h),
        for (final doc in _recentStatements) ...[
          _recentTile(doc),
          SizedBox(height: 8.h),
        ],
      ],
    );
  }

  Widget _recentTile(DocumentEntity doc) {
    return InkWell(
      onTap: () => _openDocument(doc),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
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
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doc.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(
                    '${doc.format.name.toUpperCase()} • ${doc.transactionCount ?? 0} txns'
                    '${doc.cached ? ' • cached' : ''}',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: 18.sp, color: const Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }

  // ── Success bottom sheet ───────────────────────────────────────────
  void _showSuccessSheet(DocumentEntity doc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF374151),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle_outline,
                      color: const Color(0xFF10B981), size: 22.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    doc.cached ? 'Statement ready (cached)' : 'Statement ready',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _kv('Format', doc.format.name.toUpperCase()),
            _kv('Transactions', '${doc.transactionCount ?? 0}'),
            if (doc.generatedAt != null)
              _kv('Generated', _fmtShortDateTime(doc.generatedAt!)),
            if (doc.sha256 != null && doc.sha256!.isNotEmpty)
              _kv('Integrity (SHA-256)', _shortSha(doc.sha256!), copy: doc.sha256),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(sheetCtx).pop();
                  _openDocument(doc);
                },
                icon: const Icon(Icons.download_outlined),
                label: Text('Open / Download',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v, {String? copy}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: Text(k,
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          ),
          Expanded(
            child: Text(
              v,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontFamily: copy != null ? 'monospace' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Misc helpers ───────────────────────────────────────────────────
  Widget _sectionLabel(String s) => Text(
        s,
        style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      );

  Widget _emptyHint(String s) => Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(s,
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
      );

  String _fmtShortDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _fmtShortDateTime(DateTime d) =>
      '${_fmtShortDate(d)} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  String _shortSha(String s) =>
      s.length <= 16 ? s : '${s.substring(0, 8)}…${s.substring(s.length - 8)}';
}
