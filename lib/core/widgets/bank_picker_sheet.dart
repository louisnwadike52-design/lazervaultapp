import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/utilities/bank_sort.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';

/// Colour set for [BankPickerSheet]. The picker is surface-agnostic: callers
/// pass [BankPickerTheme.light] (the send-funds / add-recipient flows) or
/// [BankPickerTheme.dark] (split-bills and other dark-surfaced flows) so the
/// SAME widget renders correctly on either background.
class BankPickerTheme {
  final Color surface; // sheet background
  final Color handle; // drag handle
  final Color onSurface; // primary text
  final Color muted; // secondary text / icons
  final Color fieldFill; // search field background
  final Color border; // tile / field borders
  final Color accent; // brand accent (icon chip, selected state)
  final Color error; // error state
  final Color tileSelectedBg; // selected tile background

  const BankPickerTheme({
    required this.surface,
    required this.handle,
    required this.onSurface,
    required this.muted,
    required this.fieldFill,
    required this.border,
    required this.accent,
    required this.error,
    required this.tileSelectedBg,
  });

  /// Light surface — mirrors the send-funds / add-recipient bank picker.
  factory BankPickerTheme.light() => BankPickerTheme(
        surface: Colors.white,
        handle: Colors.grey.shade300,
        onSurface: Colors.black87,
        muted: Colors.grey.shade600,
        fieldFill: Colors.grey.shade100,
        border: Colors.grey.shade200,
        accent: const Color(0xFF4E03D0),
        error: Colors.red.shade400,
        tileSelectedBg: const Color(0xFF4E03D0).withValues(alpha: 0.06),
      );

  /// Dark surface — matches the split-bills create flow palette.
  factory BankPickerTheme.dark() => const BankPickerTheme(
        surface: Color(0xFF1F1F1F),
        handle: Color(0xFF4B5563),
        onSurface: Colors.white,
        muted: Color(0xFF9CA3AF),
        fieldFill: Color(0xFF2D2D2D),
        border: Color(0xFF2D2D2D),
        accent: Color(0xFF4834D4),
        error: Color(0xFFEF4444),
        tileSelectedBg: Color(0x224834D4),
      );
}

/// A single, reusable bank-search bottom sheet shared by every "choose a bank"
/// flow (send-funds / add-recipient / split-bills). It:
///   * uses [BankLogo] (bundled logos with an initials/gradient fallback),
///   * owns its own search controller + debounce timer and disposes them in
///     [State.dispose] (so it never trips the `dependents.isEmpty` framework
///     assertion the old inline pickers hit),
///   * loads the static bank list immediately then refreshes from the backend,
///   * returns the chosen bank via `Navigator.pop(context, {'name','code'})`.
///
/// Use [BankPickerSheet.show] and await the result:
/// ```dart
/// final bank = await BankPickerSheet.show(context,
///     country: 'NG', theme: BankPickerTheme.dark());
/// if (bank != null) { /* bank['code'], bank['name'] */ }
/// ```
class BankPickerSheet extends StatefulWidget {
  final String country;
  final String? selectedBankCode;
  final BankPickerTheme theme;

  const BankPickerSheet({
    super.key,
    required this.country,
    required this.theme,
    this.selectedBankCode,
  });

  /// Presents the sheet and resolves to the selected bank
  /// (`{'name': ..., 'code': ...}`) or null if dismissed.
  static Future<Map<String, String>?> show(
    BuildContext context, {
    required String country,
    String? selectedBankCode,
    BankPickerTheme? theme,
  }) {
    return showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BankPickerSheet(
        country: country,
        selectedBankCode: selectedBankCode,
        theme: theme ?? BankPickerTheme.light(),
      ),
    );
  }

  @override
  State<BankPickerSheet> createState() => _BankPickerSheetState();
}

class _BankPickerSheetState extends State<BankPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  List<Map<String, String>> _banks = [];
  bool _loading = false;
  String? _error;

  // Bank list sort — defaults to "Most popular" (Nigerian ranking). Shared with
  // the send-funds recipient screen via [bank_sort.dart] so every picker sorts
  // identically and shares the same recently-used list.
  BankSort _sort = BankSort.mostUsed;
  List<String> _recentCodes = [];
  List<String> _mostUsedCodes = [];

  @override
  void initState() {
    super.initState();
    _loadBanks();
    RecentBanks.load().then((codes) {
      if (mounted) setState(() => _recentCodes = codes);
    });
    MostUsedBanks.load().then((codes) {
      if (mounted) setState(() => _mostUsedCodes = codes);
    });
    // Refresh from the server's authoritative frequency (cross-device), then
    // reload the ranking. Best-effort; the local tally already painted above.
    MostUsedBanks.syncFromBackend().then((_) {
      MostUsedBanks.load().then((codes) {
        if (mounted) setState(() => _mostUsedCodes = codes);
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _loadBanks() {
    // Paint the bundled static list immediately so the sheet is never blank,
    // then refresh from the backend (only NG is dynamic; others stay static).
    final staticList = BanksData.getBanksForCountry(widget.country);
    setState(() {
      _banks = staticList;
      _loading = staticList.isEmpty;
      _error = null;
    });
    GetIt.I<BankRepository>().getBanks(widget.country).then((banks) {
      if (!mounted) return;
      setState(() {
        if (banks.isNotEmpty) _banks = banks;
        _loading = false;
      });
    }).catchError((_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        if (_banks.isEmpty) _error = 'Failed to load banks';
      });
    });
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      if (mounted) setState(() => _query = value.toLowerCase().trim());
    });
  }

  List<Map<String, String>> get _filtered {
    final matched = _query.isEmpty
        ? _banks
        : _banks
            .where((b) => (b['name'] ?? '').toLowerCase().contains(_query))
            .toList();
    // Sorting only makes sense for the Nigerian ranking; for other countries the
    // static list is already curated, so leave the order untouched unless the
    // user picked alphabetical/recent explicitly.
    return sortBanks(matched, _sort, _recentCodes,
        mostUsedCodes: _mostUsedCodes);
  }

  /// A single sort pill. Matches the send-funds recipient screen's pills so the
  /// two "choose a bank" surfaces look and behave identically.
  Widget _sortPill(String label, BankSort value, BankPickerTheme t) {
    final isSel = value == _sort;
    return GestureDetector(
      onTap: () => setState(() => _sort = value),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSel ? t.accent : t.fieldFill,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSel ? t.accent : t.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSel ? Colors.white : t.muted,
            fontSize: 13,
            fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    final filtered = _filtered;
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle.
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: t.handle,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: t.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.account_balance, color: t.accent, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Bank',
                        style: TextStyle(
                          color: t.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Choose the recipient's bank",
                        style: TextStyle(color: t.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: t.fieldFill,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.close, color: t.muted, size: 18),
                  ),
                ),
              ],
            ),
          ),
          // Search field.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: t.onSurface),
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search banks...',
                hintStyle: TextStyle(color: t.muted),
                prefixIcon: Icon(Icons.search, color: t.muted),
                filled: true,
                fillColor: t.fieldFill,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Sort pills — default "Most used" (the user's own transfer history;
          // falls back to the Nigerian popularity ranking when there's none yet).
          SizedBox(
            height: 34,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _sortPill('Most used', BankSort.mostUsed, t),
                const SizedBox(width: 8),
                _sortPill('Most popular', BankSort.popular, t),
                const SizedBox(width: 8),
                _sortPill('A–Z', BankSort.alphabetical, t),
                const SizedBox(width: 8),
                _sortPill('Recent', BankSort.recent, t),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: _buildBody(t, filtered)),
        ],
      ),
    );
  }

  Widget _buildBody(BankPickerTheme t, List<Map<String, String>> filtered) {
    if (_loading && _banks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: t.accent),
            ),
            const SizedBox(height: 12),
            Text('Loading banks...', style: TextStyle(color: t.muted, fontSize: 14)),
          ],
        ),
      );
    }
    if (_error != null && _banks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: t.error, size: 40),
            const SizedBox(height: 12),
            Text('Failed to load banks',
                style: TextStyle(color: t.muted, fontSize: 14)),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _loadBanks,
              icon: Icon(Icons.refresh, color: t.accent, size: 18),
              label: Text('Retry', style: TextStyle(color: t.accent)),
            ),
          ],
        ),
      );
    }
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, color: t.muted, size: 40),
            const SizedBox(height: 12),
            Text('No banks found',
                style: TextStyle(color: t.onSurface, fontSize: 15)),
            const SizedBox(height: 4),
            Text('Try a different search term',
                style: TextStyle(color: t.muted, fontSize: 13)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final bank = filtered[index];
        final isSelected = widget.selectedBankCode != null &&
            bank['code'] == widget.selectedBankCode;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isSelected ? t.tileSelectedBg : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? t.accent : t.border,
            ),
          ),
          // Transparent Material gives the ListTile a Material ancestor so its
          // ink splash is visible over the Container decoration (silences the
          // "ListTile background color or ink splashes may be invisible" spam).
          child: Material(
            type: MaterialType.transparency,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              leading: BankLogo(
                bankName: bank['name'] ?? '',
                bankCode: bank['code'],
                country: widget.country,
                size: 44,
                borderRadius: 10,
              ),
              title: Text(
                bank['name'] ?? '',
                style: TextStyle(
                  color: t.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              trailing: isSelected
                  ? Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: t.accent, shape: BoxShape.circle),
                      child:
                          const Icon(Icons.check, color: Colors.white, size: 16),
                    )
                  : Icon(Icons.chevron_right, color: t.muted, size: 20),
              onTap: () {
                RecentBanks.record(bank['code']);
                Navigator.pop(context, bank);
              },
            ),
          ),
        );
      },
    );
  }
}
