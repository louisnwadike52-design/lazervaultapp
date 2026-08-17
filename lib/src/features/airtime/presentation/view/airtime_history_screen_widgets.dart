part of 'airtime_history_screen.dart';

/// Filter state held by the history screen. Applied on top of the pill
/// scope so the user can drill down by query/network/status/date/amount.
class _AirtimeFilters {
  final String query;
  final Set<NetworkProviderType> networks;
  final Set<AirtimeTransactionStatus> statuses;
  final DateTime? from;
  final DateTime? to;
  final double? minAmount;
  final double? maxAmount;

  const _AirtimeFilters({
    this.query = '',
    this.networks = const {},
    this.statuses = const {},
    this.from,
    this.to,
    this.minAmount,
    this.maxAmount,
  });

  bool get isActive =>
      query.trim().isNotEmpty ||
      networks.isNotEmpty ||
      statuses.isNotEmpty ||
      from != null ||
      to != null ||
      minAmount != null ||
      maxAmount != null;

  int get activeCount {
    var n = 0;
    if (query.trim().isNotEmpty) n++;
    if (networks.isNotEmpty) n++;
    if (statuses.isNotEmpty) n++;
    if (from != null || to != null) n++;
    if (minAmount != null || maxAmount != null) n++;
    return n;
  }

  bool match(AirtimeTransaction t) {
    if (networks.isNotEmpty && !networks.contains(t.networkProvider)) {
      return false;
    }
    if (statuses.isNotEmpty && !statuses.contains(t.status)) return false;
    if (from != null && t.createdAt.isBefore(from!)) return false;
    if (to != null && t.createdAt.isAfter(to!)) return false;
    if (minAmount != null && t.amount < minAmount!) return false;
    if (maxAmount != null && t.amount > maxAmount!) return false;
    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      final digits = q.replaceAll(RegExp(r'[^\d]'), '');
      final phoneDigits =
          t.recipientPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      final inPhone = digits.isNotEmpty && phoneDigits.contains(digits);
      final inRef = t.transactionReference.toLowerCase().contains(q);
      final inName = (t.recipientName ?? '').toLowerCase().contains(q);
      final inNetwork =
          t.networkProvider.displayName.toLowerCase().contains(q) ||
              t.networkProvider.shortName.toLowerCase().contains(q);
      if (!(inPhone || inRef || inName || inNetwork)) return false;
    }
    return true;
  }
}

/// Stateful bottom sheet that lets the user refine the airtime history by
/// text (phone/reference/name/network), network, status, date range and
/// amount range. Returns the new filter set via [onApply] when the user
/// taps the apply button; "Clear All" wipes everything and applies.
class _AirtimeFilterSheet extends StatefulWidget {
  final _AirtimeFilters initial;
  final Color accent;
  final Set<NetworkProviderType> availableNetworks;
  final ValueChanged<_AirtimeFilters> onApply;

  const _AirtimeFilterSheet({
    required this.initial,
    required this.accent,
    required this.availableNetworks,
    required this.onApply,
  });

  @override
  State<_AirtimeFilterSheet> createState() => _AirtimeFilterSheetState();
}

class _AirtimeFilterSheetState extends State<_AirtimeFilterSheet> {
  late TextEditingController _queryCtrl;
  late TextEditingController _minCtrl;
  late TextEditingController _maxCtrl;
  late Set<NetworkProviderType> _networks;
  late Set<AirtimeTransactionStatus> _statuses;
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    _queryCtrl = TextEditingController(text: widget.initial.query);
    _minCtrl = TextEditingController(
        text: widget.initial.minAmount?.toStringAsFixed(0) ?? '');
    _maxCtrl = TextEditingController(
        text: widget.initial.maxAmount?.toStringAsFixed(0) ?? '');
    _networks = {...widget.initial.networks};
    _statuses = {...widget.initial.statuses};
    _from = widget.initial.from;
    _to = widget.initial.to;
  }

  @override
  void dispose() {
    _queryCtrl.dispose();
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    'Filter Transactions',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _clearAll,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 4.h),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: widget.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Search'),
                    SizedBox(height: 8.h),
                    _searchField(),
                    SizedBox(height: 20.h),
                    if (widget.availableNetworks.isNotEmpty) ...[
                      _sectionLabel('Network'),
                      SizedBox(height: 8.h),
                      _networkChips(),
                      SizedBox(height: 20.h),
                    ],
                    _sectionLabel('Status'),
                    SizedBox(height: 8.h),
                    _statusChips(),
                    SizedBox(height: 20.h),
                    _sectionLabel('Date range'),
                    SizedBox(height: 8.h),
                    _dateRangeRow(),
                    SizedBox(height: 20.h),
                    _sectionLabel('Amount range'),
                    SizedBox(height: 8.h),
                    _amountRangeRow(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _apply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.accent,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withValues(alpha: 0.85),
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _queryCtrl,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Phone, reference, name or network',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 13.sp,
        ),
        prefixIcon: Icon(Icons.search,
            color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
        suffixIcon: _queryCtrl.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.close,
                    color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
                onPressed: () => setState(() => _queryCtrl.clear()),
              ),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _networkChips() {
    final networks = widget.availableNetworks.toList()
      ..sort((a, b) => a.displayName.compareTo(b.displayName));
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: networks.map((n) {
        final selected = _networks.contains(n);
        return _chip(
          label: n.shortName,
          selected: selected,
          leading: Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: n.color,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () => setState(() {
            selected ? _networks.remove(n) : _networks.add(n);
          }),
        );
      }).toList(),
    );
  }

  Widget _statusChips() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: AirtimeTransactionStatus.values.map((s) {
        final selected = _statuses.contains(s);
        return _chip(
          label: s.displayName,
          selected: selected,
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: s.color,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () => setState(() {
            selected ? _statuses.remove(s) : _statuses.add(s);
          }),
        );
      }).toList(),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected
              ? widget.accent.withValues(alpha: 0.2)
              : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: selected
                ? widget.accent
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading,
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateRangeRow() {
    return Row(
      children: [
        Expanded(
          child: _dateButton(
            label: _from == null
                ? 'From'
                : DateFormat('MMM dd, yyyy').format(_from!),
            onTap: () => _pickDate(isFrom: true),
            onClear: _from == null ? null : () => setState(() => _from = null),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _dateButton(
            label:
                _to == null ? 'To' : DateFormat('MMM dd, yyyy').format(_to!),
            onTap: () => _pickDate(isFrom: false),
            onClear: _to == null ? null : () => setState(() => _to = null),
          ),
        ),
      ],
    );
  }

  Widget _dateButton({
    required String label,
    required VoidCallback onTap,
    VoidCallback? onClear,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                color: Colors.white.withValues(alpha: 0.5), size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onClear != null)
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close,
                    color: Colors.white.withValues(alpha: 0.5), size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }

  Widget _amountRangeRow() {
    return Row(
      children: [
        Expanded(child: _amountField(_minCtrl, 'Min')),
        SizedBox(width: 10.w),
        Expanded(child: _amountField(_maxCtrl, 'Max')),
      ],
    );
  }

  Widget _amountField(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          final dotCount = '.'.allMatches(newValue.text).length;
          if (dotCount > 1) return oldValue;
          return newValue;
        }),
      ],
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 13.sp,
        ),
        prefixText: '\u20A6 ',
        prefixStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final initial = isFrom ? (_from ?? now) : (_to ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.dark(
            primary: widget.accent,
            onPrimary: Colors.white,
            surface: const Color(0xFF1F1F1F),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (isFrom) {
        _from = DateTime(picked.year, picked.month, picked.day);
        if (_to != null && _to!.isBefore(_from!)) _to = null;
      } else {
        _to = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
        if (_from != null && _from!.isAfter(_to!)) _from = null;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _queryCtrl.clear();
      _minCtrl.clear();
      _maxCtrl.clear();
      _networks.clear();
      _statuses.clear();
      _from = null;
      _to = null;
    });
  }

  void _apply() {
    final minText = _minCtrl.text.trim();
    final maxText = _maxCtrl.text.trim();
    var minAmt = minText.isEmpty ? null : double.tryParse(minText);
    var maxAmt = maxText.isEmpty ? null : double.tryParse(maxText);

    // Reject non-parseable non-empty inputs (e.g. a lone ".") rather than
    // silently dropping them — the user's intent is otherwise ambiguous.
    if (minText.isNotEmpty && minAmt == null) {
      _showSnackBar('Min amount isn\u2019t a valid number');
      return;
    }
    if (maxText.isNotEmpty && maxAmt == null) {
      _showSnackBar('Max amount isn\u2019t a valid number');
      return;
    }

    // Clamp negatives to zero (the input formatters block '-' but
    // paste/IME edge cases can still sneak a negative through).
    if (minAmt != null && minAmt < 0) minAmt = 0;
    if (maxAmt != null && maxAmt < 0) maxAmt = 0;

    // Swap when min > max so the user still gets a sensible range
    // instead of an always-empty result set.
    if (minAmt != null && maxAmt != null && minAmt > maxAmt) {
      final tmp = minAmt;
      minAmt = maxAmt;
      maxAmt = tmp;
    }

    widget.onApply(_AirtimeFilters(
      query: _queryCtrl.text,
      networks: Set.unmodifiable(_networks),
      statuses: Set.unmodifiable(_statuses),
      from: _from,
      to: _to,
      minAmount: minAmt,
      maxAmount: maxAmt,
    ));
    Navigator.of(context).pop();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF2D2D2D),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
