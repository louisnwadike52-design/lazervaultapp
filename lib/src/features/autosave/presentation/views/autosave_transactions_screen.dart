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
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'autosave_transactions_screen_widgets.dart';


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
            return const Center(child: LazerVaultLoader.small());
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
      const _FilterOption(
        label: 'Bank inflow',
        value: TriggerType.externalInflow,
        icon: Icons.account_balance,
        accent: Color(0xFFF97316),
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
