import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as cur;
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

/// Lists every autosave transaction the user has executed across all
/// rules — manual triggers, scheduled fires, on-deposit fires,
/// round-up fires. Distinct from the All Rules screen (which lists
/// rules); a rule can fire many times, each row here is one fire.
///
/// Filters and search run **client-side**: the existing
/// GetAutoSaveTransactions RPC returns the full set; users typically
/// have at most a few hundred transactions, so an in-memory filter
/// pass is faster than a round-trip per filter change. Pagination /
/// server-side filtering can be layered on later without changing
/// the cubit's emit shape.
class AutoSaveTransactionsScreen extends StatefulWidget {
  const AutoSaveTransactionsScreen({super.key});

  @override
  State<AutoSaveTransactionsScreen> createState() =>
      _AutoSaveTransactionsScreenState();
}

class _AutoSaveTransactionsScreenState
    extends State<AutoSaveTransactionsScreen> {
  /// Outcome filter. null = all.
  bool? _successFilter;
  TriggerType? _triggerFilter;
  String _query = '';
  late final TextEditingController _searchController;

  // Debounce flag for the dropdown buttons. Without this, a rapid
  // double-tap on a dropdown stacks two bottom sheets — Android's
  // back press would have to close them one at a time and the
  // second sheet's Navigator.pop would clobber the first sheet's
  // result. Held true while a picker is open.
  bool _pickerOpen = false;

  // Resolved rule names — keyed by rule id. We pull the rule list
  // once on screen open so the row + bottom sheet can show "Rule X"
  // instead of a UUID. Nothing mutating; just a lookup table.
  final Map<String, AutoSaveRuleEntity> _rulesById = {};

  // Last-good cache for transactions. The cubit only stores ONE
  // sealed state at a time, so when the parallel rules-fetch emits
  // AutoSaveRulesLoadedState the BlocBuilder rebuilds with a
  // non-transactions state and would otherwise drop the rendered
  // list back to the spinner. Caching locally keeps the rendered
  // roster stable across sibling-state emits — same pattern the
  // past-contributions screens use.
  List<AutoSaveTransactionEntity>? _lastTxs;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<AutoSaveCubit>();
      // Fire both fetches; the cubit's state machine emits a single
      // AutoSaveTransactionsLoaded for the txn fetch, and the rules
      // fetch updates _cachedRules silently. We grab the cached rules
      // off the cubit lazily in build().
      cubit.getTransactions();
      // Rules: only fetch when we don't already have them on the
      // cubit. The All Rules screen / dashboard often pre-warm this.
      cubit.getRulesWithCache();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _populateRuleLookup(BuildContext context) {
    final cubitState = context.read<AutoSaveCubit>().state;
    if (cubitState is AutoSaveRulesLoadedState) {
      _rulesById
        ..clear()
        ..addEntries(cubitState.rules.map((r) => MapEntry(r.id, r)));
    } else if (cubitState is AutoSaveDashboardLoaded) {
      _rulesById
        ..clear()
        ..addEntries(cubitState.rules.map((r) => MapEntry(r.id, r)));
    }
  }

  List<AutoSaveTransactionEntity> _applyFilters(
    List<AutoSaveTransactionEntity> input,
  ) {
    // Defensive: trim whitespace + cap query length so a runaway
    // paste doesn't trigger a 100k-character substring scan per row.
    final raw = _query.trim();
    final q = (raw.length > 120 ? raw.substring(0, 120) : raw).toLowerCase();
    return input.where((t) {
      if (_successFilter != null && t.success != _successFilter) {
        return false;
      }
      if (_triggerFilter != null && t.triggerType != _triggerFilter) {
        return false;
      }
      if (q.isNotEmpty) {
        final ruleName = _rulesById[t.ruleId]?.name.toLowerCase() ?? '';
        final reason = t.triggerReason.toLowerCase();
        final amount = t.amount.toString();
        if (!ruleName.contains(q) &&
            !reason.contains(q) &&
            !amount.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Transactions History',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<AutoSaveCubit, AutoSaveState>(
        buildWhen: (a, b) =>
            b is AutoSaveLoading ||
            b is AutoSaveError ||
            b is AutoSaveTransactionsLoaded ||
            b is AutoSaveRulesLoadedState ||
            b is AutoSaveDashboardLoaded,
        builder: (context, state) {
          // Refresh the rule lookup whenever the cubit emits a
          // rules-bearing state — keeps row labels current without
          // a separate listener.
          _populateRuleLookup(context);

          // Refresh the cache when the cubit emits a fresh
          // transactions list; otherwise hold whatever we had so a
          // sibling-state rebuild (rules / dashboard) doesn't blank
          // the screen.
          if (state is AutoSaveTransactionsLoaded) {
            _lastTxs = state.transactions;
          }
          final txs = _lastTxs;
          if (txs == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final filtered = _applyFilters(txs);
          return Column(
            children: [
              _buildSearchBar(),
              _buildFilterRow(),
              SizedBox(height: 4.h),
              if (filtered.isEmpty)
                Expanded(
                  child: _empty(
                    txs.isEmpty
                        ? 'No autosave transactions yet.'
                        : 'No transactions match the current filters.',
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
                    backgroundColor: const Color(0xFF1F1F1F),
                    color: const Color.fromARGB(255, 78, 3, 208),
                    onRefresh: () async {
                      await context
                          .read<AutoSaveCubit>()
                          .getTransactions();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                          16.w, 4.h, 16.w, 24.h),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _TransactionTile(
                          tx: filtered[i],
                          rule: _rulesById[filtered[i].ruleId],
                          onTap: () => _showDetailsSheet(
                              filtered[i],
                              _rulesById[filtered[i].ruleId]),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
        cursorColor: const Color.fromARGB(255, 78, 3, 208),
        onChanged: (v) => setState(() => _query = v),
        decoration: InputDecoration(
          hintText: 'Search by rule name, reason, amount…',
          hintStyle: GoogleFonts.inter(
              color: Colors.grey[500], fontSize: 13.sp),
          prefixIcon:
              Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
          suffixIcon: _query.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close,
                      color: Colors.grey[500], size: 18.sp),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _query = '');
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Outcome / trigger filters used to scroll horizontally as pill /
  // chip rows. They've been replaced with a two-button dropdown row
  // — each button shows the active selection + a chevron, and tapping
  // it pops a styled bottom-sheet picker. Cuts visual noise to two
  // controls while still surfacing the active filter inline.
  Widget _buildFilterRow() {
    final outcomeOptions = <_FilterOption<bool?>>[
      const _FilterOption(label: 'All outcomes', value: null),
      const _FilterOption(
        label: 'Successful',
        value: true,
        icon: Icons.check_circle_outline,
        accent: Color(0xFF10B981),
      ),
      const _FilterOption(
        label: 'Failed',
        value: false,
        icon: Icons.error_outline,
        accent: Color(0xFFEF4444),
      ),
    ];
    final triggerOptions = <_FilterOption<TriggerType?>>[
      const _FilterOption(label: 'All triggers', value: null),
      const _FilterOption(
        label: 'On deposit',
        value: TriggerType.onDeposit,
        icon: Icons.south_west,
        accent: Color(0xFF10B981),
      ),
      const _FilterOption(
        label: 'Scheduled',
        value: TriggerType.scheduled,
        icon: Icons.schedule,
        accent: Color(0xFF3B82F6),
      ),
      const _FilterOption(
        label: 'Round-up',
        value: TriggerType.roundUp,
        icon: Icons.unfold_more,
        accent: Color(0xFFFB923C),
      ),
    ];
    final outcomeSelected = outcomeOptions.firstWhere(
      (o) => o.value == _successFilter,
      orElse: () => outcomeOptions.first,
    );
    final triggerSelected = triggerOptions.firstWhere(
      (o) => o.value == _triggerFilter,
      orElse: () => triggerOptions.first,
    );

    final anyActive = _successFilter != null || _triggerFilter != null;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _DropdownButton(
                  icon: Icons.flag_outlined,
                  label: 'Outcome',
                  valueLabel: outcomeSelected.label,
                  valueAccent: outcomeSelected.accent,
                  isFiltered: _successFilter != null,
                  onTap: () async {
                    final result = await _pickFilter<bool?>(
                      title: 'Filter by outcome',
                      options: outcomeOptions,
                      current: _successFilter,
                    );
                    if (!mounted || result.cancelled) return;
                    setState(() => _successFilter = result.value);
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _DropdownButton(
                  icon: Icons.bolt_outlined,
                  label: 'Trigger',
                  valueLabel: triggerSelected.label,
                  valueAccent: triggerSelected.accent,
                  isFiltered: _triggerFilter != null,
                  onTap: () async {
                    final result = await _pickFilter<TriggerType?>(
                      title: 'Filter by trigger',
                      options: triggerOptions,
                      current: _triggerFilter,
                    );
                    if (!mounted || result.cancelled) return;
                    setState(() => _triggerFilter = result.value);
                  },
                ),
              ),
            ],
          ),
          // One-tap reset for both filters at once. Opt-in via a
          // hairline secondary button so it doesn't compete with the
          // dropdowns visually — only appears when at least one
          // filter is active.
          if (anyActive) ...[
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _successFilter = null;
                    _triggerFilter = null;
                  });
                },
                icon: Icon(Icons.close,
                    size: 14.sp, color: Colors.grey[400]),
                label: Text(
                  'Clear filters',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 4.h),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Opens a styled bottom-sheet picker. Returns a non-null
  /// [_PickResult] wrapper so the caller can disambiguate "user
  /// dismissed without choosing" (`cancelled = true`) from "user
  /// chose the explicit All option" (which carries `null` as the
  /// payload — a legal selection for nullable filters).
  ///
  /// Guarded by `_pickerOpen` so a quick double-tap can't open two
  /// sheets at once.
  ///
  /// Previous implementation conflated `null` (the All option) with
  /// the sheet's dismissal Future, so picking "All …" looked like a
  /// cancel and the filter never reset. The tagged wrapper fixes that.
  Future<_PickResult<T>> _pickFilter<T>({
    required String title,
    required List<_FilterOption<T>> options,
    required T current,
  }) async {
    if (_pickerOpen) return const _PickResult.cancelled();
    _pickerOpen = true;
    try {
      final picked = await showModalBottomSheet<_PickResult<T>>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (sheetCtx) => _FilterPickerSheet<T>(
          title: title,
          options: options,
          current: current,
        ),
      );
      return picked ?? const _PickResult.cancelled();
    } finally {
      if (mounted) _pickerOpen = false;
    }
  }

  Widget _empty(String label) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 64.sp, color: Colors.grey[600]),
            SizedBox(height: 16.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsSheet(
      AutoSaveTransactionEntity tx, AutoSaveRuleEntity? rule) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => _TransactionDetailsSheet(
        tx: tx,
        rule: rule,
        onOpenRule: rule == null
            ? null
            : () {
                Navigator.of(sheetCtx).pop();
                Get.toNamed(
                  AppRoutes.autoSaveDetails,
                  arguments: rule,
                );
              },
      ),
    );
  }
}

/// One row on the list. Elevated dark surface, no border — matches the
/// All Rules card visual treatment so the two screens feel like one
/// feature. Status pill on the right, trigger badge under the title.
/// Wrapper returned by `_pickFilter` so callers can disambiguate
/// "user dismissed the sheet" from "user picked an option whose value
/// happens to be null" (the All option). `cancelled = true` is the
/// dismiss case; `value` carries the chosen payload otherwise.
class _PickResult<T> {
  final bool cancelled;
  final T? value;
  const _PickResult.cancelled()
      : cancelled = true,
        value = null;
  const _PickResult.value(this.value) : cancelled = false;
}

class _FilterOption<T> {
  final String label;
  final T value;
  final IconData? icon;
  final Color? accent;
  const _FilterOption({
    required this.label,
    required this.value,
    this.icon,
    this.accent,
  });
}

/// Pill-shaped dropdown trigger used in the transactions filter row.
/// Displays the active selection's label inline with a chevron and a
/// purple dot when a non-default filter is active so the user sees
/// at a glance which controls are constraining the list.
class _DropdownButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valueLabel;
  final Color? valueAccent;
  final bool isFiltered;
  final VoidCallback onTap;

  const _DropdownButton({
    required this.icon,
    required this.label,
    required this.valueLabel,
    required this.valueAccent,
    required this.isFiltered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Screen readers hear "Outcome filter, currently Successful,
      // double-tap to change" instead of just the label text.
      label: '$label filter, currently $valueLabel',
      button: true,
      child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: isFiltered
                    ? const Color.fromARGB(255, 78, 3, 208)
                        .withValues(alpha: 0.18)
                    : Colors.black.withValues(alpha: 0.25),
                blurRadius: isFiltered ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: valueAccent ?? Colors.grey[400],
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 9.sp,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      valueLabel,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.expand_more,
                size: 18.sp,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

/// Modal bottom sheet picker. Each row shows the option's icon (if
/// any) with its label; the currently-selected row gets a check-mark
/// and accent colour. Tapping a row pops with that value; the sheet's
/// dismiss returns null so the caller can preserve the existing
/// filter.
class _FilterPickerSheet<T> extends StatelessWidget {
  final String title;
  final List<_FilterOption<T>> options;
  final T current;

  const _FilterPickerSheet({
    required this.title,
    required this.options,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            for (final opt in options)
              _buildRow(context, opt, opt.value == current),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, _FilterOption<T> opt, bool selected) {
    final accent = opt.accent ?? const Color.fromARGB(255, 78, 3, 208);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // Pop with a tagged wrapper instead of the raw value so the
        // caller can tell "user picked the All option (value=null)"
        // apart from "sheet dismissed (popped with null)". Without
        // this, picking "All triggers" / "All outcomes" looked like
        // a cancel and the filter never updated.
        onTap: () => Navigator.of(context).pop(_PickResult.value(opt.value)),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: selected
                ? accent.withValues(alpha: 0.10)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  opt.icon ?? Icons.tune,
                  size: 16.sp,
                  color: accent,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  opt.label,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  // Future trigger types or longer outcome labels
                  // shouldn't overflow the row — clip with ellipsis
                  // and rely on the leading icon + accent for context.
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (selected)
                Icon(Icons.check_circle,
                    color: accent, size: 18.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final AutoSaveTransactionEntity tx;
  final AutoSaveRuleEntity? rule;
  final VoidCallback onTap;

  const _TransactionTile({
    required this.tx,
    required this.rule,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final triggerColor = _triggerColor(tx.triggerType);
    final amountText =
        cur.CurrencySymbols.formatAmountWithCurrency(tx.amount, tx.currency);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: triggerColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _triggerIcon(tx.triggerType),
                    color: triggerColor,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rule?.name ??
                            'Rule ${tx.ruleId.substring(0, 6)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        DateFormat('MMM d, yyyy • HH:mm')
                            .format(tx.createdAt),
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountText,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: tx.success
                            ? const Color(0xFF10B981)
                                .withValues(alpha: 0.15)
                            : const Color(0xFFEF4444)
                                .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        tx.success ? 'SUCCESS' : 'FAILED',
                        style: GoogleFonts.inter(
                          color: tx.success
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: triggerColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    _triggerLabel(tx.triggerType),
                    style: GoogleFonts.inter(
                      color: triggerColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (tx.triggerReason.isNotEmpty) ...[
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      tx.triggerReason,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 11.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _triggerColor(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return const Color(0xFF3B82F6);
      case TriggerType.onDeposit:
        return const Color(0xFF10B981);
      case TriggerType.roundUp:
        return const Color(0xFFFB923C);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _triggerIcon(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return Icons.schedule;
      case TriggerType.onDeposit:
        return Icons.south_west;
      case TriggerType.roundUp:
        return Icons.unfold_more;
      default:
        return Icons.help_outline;
    }
  }

  String _triggerLabel(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return 'SCHEDULED';
      case TriggerType.onDeposit:
        return 'ON DEPOSIT';
      case TriggerType.roundUp:
        return 'ROUND-UP';
      default:
        return 'OTHER';
    }
  }
}

/// Bottom sheet shown when a row is tapped. Same layout pattern as the
/// past-contribution / cycle-history sheets so the surfaces feel
/// consistent. Surfaces every captured field on the transaction +
/// links back to the parent rule so investigative drills are one tap
/// away.
class _TransactionDetailsSheet extends StatelessWidget {
  final AutoSaveTransactionEntity tx;
  final AutoSaveRuleEntity? rule;
  final VoidCallback? onOpenRule;

  const _TransactionDetailsSheet({
    required this.tx,
    required this.rule,
    required this.onOpenRule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transaction details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            Flexible(
              child: ListView(
                padding: EdgeInsets.all(16.w),
                children: [
                  _amountBanner(),
                  SizedBox(height: 14.h),
                  _section(
                    title: 'Trigger',
                    rows: [
                      _row('Type', _triggerName(tx.triggerType)),
                      _row('Reason',
                          tx.triggerReason.isEmpty ? '—' : tx.triggerReason),
                      _row(
                        'Outcome',
                        tx.success ? 'Success' : 'Failed',
                        valueColor: tx.success
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                      if (tx.errorMessage != null &&
                          tx.errorMessage!.isNotEmpty)
                        _row('Error', tx.errorMessage!,
                            valueColor: const Color(0xFFFCA5A5)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _section(
                    title: 'Money movement',
                    rows: [
                      _row(
                          'Amount',
                          cur.CurrencySymbols.formatAmountWithCurrency(
                              tx.amount, tx.currency)),
                      _row('Source account', tx.sourceAccountId),
                      _row('Destination account', tx.destinationAccountId),
                      _row('Currency', tx.currency),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _section(
                    title: 'Identifiers',
                    rows: [
                      _row('Transaction ID', tx.id),
                      _row('Rule ID', tx.ruleId),
                      _row(
                          'Captured at',
                          DateFormat('MMM d, yyyy • HH:mm:ss')
                              .format(tx.createdAt)),
                    ],
                  ),
                  if (rule != null) ...[
                    SizedBox(height: 14.h),
                    _ruleSummary(),
                  ],
                  SizedBox(height: 16.h),
                  if (onOpenRule != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onOpenRule,
                        icon: Icon(Icons.open_in_new, size: 18.sp),
                        label: Text(
                          'Open rule',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 78, 3, 208),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountBanner() {
    final colour = tx.success
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: colour.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              tx.success ? Icons.check_circle : Icons.error_outline,
              color: colour,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cur.CurrencySymbols.formatAmountWithCurrency(
                      tx.amount, tx.currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  tx.success ? 'Saved successfully' : 'Did not save',
                  style: GoogleFonts.inter(
                    color: colour,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ruleSummary() {
    final r = rule!;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parent rule',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 10.sp,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            r.name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (r.description.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              r.description,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 11.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required List<Widget> rows,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color.fromARGB(255, 178, 137, 255),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6.h),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 11.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _triggerName(TriggerType t) {
    switch (t) {
      case TriggerType.scheduled:
        return 'Scheduled';
      case TriggerType.onDeposit:
        return 'On deposit';
      case TriggerType.roundUp:
        return 'Round-up';
      default:
        return 'Other';
    }
  }
}
