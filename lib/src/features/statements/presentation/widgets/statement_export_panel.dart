import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/statements/data/services/statement_file_service.dart';
import 'package:lazervault/src/features/statements/data/services/statement_recent_store.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_state.dart';

part 'statement_export_panel_widgets.dart';
part 'statement_export_panel_sheets.dart';

/// The single account-statement export surface.
///
/// Every place a user can ask for a statement renders THIS widget: the
/// settings screen, the statement-export route reached from the dashboard and
/// per-service transaction histories, and the Documents tab inside the
/// account-details bottom sheet.
///
/// Before this there were two full implementations of the same screen —
/// different pickers, different cubits, different recent-statement lists, and
/// only one of them verified the SHA-256 or let the user save, print or share
/// the file. Which of those you got depended on which button you happened to
/// press, and a statement generated in one place never appeared in the other.
///
/// The caller supplies a [StatementCubit] and an [AccountCardsSummaryCubit]
/// above this widget (see `StatementExportHost` for the wrapper that does it).
///
/// [dark] switches the palette for the bottom-sheet host; the layout and every
/// behaviour are identical, which is the point.
class StatementExportPanel extends StatefulWidget {
  /// Pre-selects an account. With [lockAccount] the selector is replaced by a
  /// read-only row — opened from one account's own sheet, offering to export a
  /// different account's statement is a mis-click waiting to happen.
  final String? initialAccountId;
  final bool lockAccount;
  final bool dark;
  final EdgeInsetsGeometry? padding;

  const StatementExportPanel({
    super.key,
    this.initialAccountId,
    this.lockAccount = false,
    this.dark = false,
    this.padding,
  });

  @override
  State<StatementExportPanel> createState() => _StatementExportPanelState();
}

class _StatementExportPanelState extends State<StatementExportPanel> {
  static const Duration _maxWindow = Duration(days: 366);

  String? _selectedAccountId;
  DateTime? _startDate;
  DateTime? _endDate;
  StatementFormat _format = StatementFormat.pdf;
  bool _isPreparingFile = false;

  final StatementFileService _fileService =
      serviceLocator<StatementFileService>();
  final StatementRecentStore _recentStore = StatementRecentStore();
  List<StatementRecentEntry> _recent = const [];

  @override
  void initState() {
    super.initState();
    _selectedAccountId = widget.initialAccountId;
    // Default to the last 30 days rather than an empty picker: it is what
    // almost every export is, and an empty range meant the primary button was
    // dead on arrival with no explanation.
    final now = DateTime.now();
    _endDate = now;
    _startDate = now.subtract(const Duration(days: 30));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final userId = context.read<AuthenticationCubit>().userId;
      if (userId != null && userId.isNotEmpty) {
        context
            .read<AccountCardsSummaryCubit>()
            .fetchAccountSummaries(userId: userId);
      }
      _loadRecent();
    });
  }

  /// Part files drive the same state, and `setState` is protected — calling it
  /// from an extension is a lint warning even though it is the same library.
  /// This is the one seam they use instead.
  void update(VoidCallback fn) {
    if (!mounted) return;
    setState(fn);
  }

  Future<void> _loadRecent() async {
    final list = await _recentStore.load();
    if (!mounted) return;
    setState(() => _recent = list);
  }

  // ── Palette ────────────────────────────────────────────────────────────
  // Two hosts, one layout. Only these getters differ.
  bool get _dark => widget.dark;
  Color get _brand => const Color(0xFF4E03D0);
  Color get _surface =>
      _dark ? const Color(0xFF1F1F1F) : const Color(0xFFF9FAFB);
  Color get _border =>
      _dark ? const Color(0xFF2F2F2F) : const Color(0xFFE5E7EB);
  Color get _primaryText => _dark ? Colors.white : const Color(0xFF1F2937);
  Color get _labelText =>
      _dark ? const Color(0xFFD1D5DB) : const Color(0xFF374151);
  Color get _mutedText => const Color(0xFF9CA3AF);
  Color get _sheetBackground => _dark ? const Color(0xFF151515) : Colors.white;

  // ── Actions ────────────────────────────────────────────────────────────
  void _generate() {
    final accountId = _selectedAccountId;
    if (accountId == null || accountId.isEmpty) {
      LVSnackbar.showError(
        title: 'No account selected',
        message: 'Choose which account the statement is for.',
      );
      return;
    }
    final start = _startDate;
    final end = _endDate;
    if (start == null || end == null) {
      LVSnackbar.showError(
        title: 'No date range',
        message: 'Pick the period the statement should cover.',
      );
      return;
    }
    // Both checks mirror the server's, so the user is told what is wrong here
    // instead of waiting for a round trip to be refused.
    if (end.isBefore(start)) {
      LVSnackbar.showError(
        title: 'Invalid range',
        message: 'The end date must be on or after the start date.',
      );
      return;
    }
    if (end.difference(start) > _maxWindow) {
      LVSnackbar.showError(
        title: 'Range too long',
        message: 'Statements cover up to 366 days. Pick a shorter period.',
      );
      return;
    }
    context.read<StatementCubit>().downloadStatement(
          accountId: accountId,
          startDate: start,
          endDate: end,
          format: _format,
        );
  }

  void _replayRecent(StatementRecentEntry entry) {
    setState(() {
      _selectedAccountId = entry.accountId;
      _startDate = entry.startDate;
      _endDate = entry.endDate;
      _format = entry.format;
    });
    // Regenerate: the previous signed URL has expired by now. The service's
    // 10-minute idempotency cache makes a genuine repeat almost free.
    context.read<StatementCubit>().downloadStatement(
          accountId: entry.accountId,
          startDate: entry.startDate,
          endDate: entry.endDate,
          format: entry.format,
        );
  }

  /// Pull the rendered file to disk (verifying its digest) and offer actions.
  Future<void> _onGenerated(StatementEntity statement) async {
    final url = statement.filePath;
    if (url == null || url.isEmpty) {
      LVSnackbar.showError(
        title: 'Download failed',
        message: 'The statement is not available to download right now.',
      );
      return;
    }

    setState(() => _isPreparingFile = true);
    try {
      final filename = 'statement_${statement.accountId}'
          '_${statement.startDate.millisecondsSinceEpoch}'
          '.${_extensionFor(statement.format)}';
      final localPath = await _fileService.downloadToFile(
        url,
        filename,
        expectedSha256: statement.sha256,
      );
      if (!mounted) return;

      final updated = await _recentStore.record(StatementRecentEntry(
        accountId: statement.accountId,
        startDate: statement.startDate,
        endDate: statement.endDate,
        format: statement.format,
        generatedAt: DateTime.now(),
      ));
      if (!mounted) return;
      setState(() => _recent = updated);

      LVSnackbar.showSuccess(
        title: 'Statement ready',
        message: 'Your statement has been downloaded.',
      );
      _showActions(localPath, statement.format);
    } catch (e) {
      if (!mounted) return;
      LVSnackbar.showErrorFor(e, context: 'download your statement');
    } finally {
      if (mounted) setState(() => _isPreparingFile = false);
    }
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

  static String _extensionFor(StatementFormat format) {
    switch (format) {
      case StatementFormat.pdf:
        return 'pdf';
      case StatementFormat.csv:
        return 'csv';
      case StatementFormat.excel:
        return 'xlsx';
    }
  }

  static IconData _iconFor(StatementFormat format) {
    switch (format) {
      case StatementFormat.pdf:
        return Icons.picture_as_pdf;
      case StatementFormat.csv:
        return Icons.table_chart;
      case StatementFormat.excel:
        return Icons.grid_on;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatementCubit, StatementState>(
      listener: (context, state) {
        if (state is StatementDownloadSuccess) {
          _onGenerated(state.statement);
        } else if (state is StatementDownloadFailure) {
          LVSnackbar.showError(
            title: 'Could not generate statement',
            message: state.message,
          );
        }
      },
      child: SingleChildScrollView(
        padding: widget.padding ?? EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('Account'),
            SizedBox(height: 8.h),
            _accountSelector(),
            SizedBox(height: 24.h),
            _sectionLabel('Date range'),
            SizedBox(height: 8.h),
            _rangeField(),
            SizedBox(height: 24.h),
            _sectionLabel('Format'),
            SizedBox(height: 8.h),
            _formatRow(),
            SizedBox(height: 28.h),
            _generateButton(),
            SizedBox(height: 12.h),
            _whatIsIncludedNote(),
            if (_recent.isNotEmpty) ...[
              SizedBox(height: 28.h),
              _sectionLabel('Recent statements', large: true),
              SizedBox(height: 12.h),
              ..._recent.map(_recentTile),
            ],
          ],
        ),
      ),
    );
  }
}
