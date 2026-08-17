part of 'exchange_home_screen.dart';

/// Currency picker bottom sheet extracted from CurrencyPairScreen.
class _CurrencyPickerSheet extends StatefulWidget {
  final List<SupportedCurrencyInfo> currencies;
  final String selectedCode;
  final String? excludeCode;
  final String title;
  final ValueChanged<String> onSelected;

  /// When non-null, a currency for which this returns true is rendered DISABLED
  /// (greyed, non-tappable) with [disabledHint] as a sublabel — e.g. PHP/CAD in
  /// convert mode (international-transfer only).
  final bool Function(SupportedCurrencyInfo)? disabledFor;
  final String? disabledHint;

  const _CurrencyPickerSheet({
    required this.currencies,
    required this.selectedCode,
    this.excludeCode,
    required this.title,
    required this.onSelected,
    this.disabledFor,
    this.disabledHint,
  });

  @override
  State<_CurrencyPickerSheet> createState() => _CurrencyPickerSheetState();
}

class _CurrencyPickerSheetState extends State<_CurrencyPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<SupportedCurrencyInfo> get _filtered {
    var list = widget.currencies;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list
          .where((c) =>
              c.code.toLowerCase().contains(q) ||
              c.name.toLowerCase().contains(q) ||
              c.country.toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search currency...',
                      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF6B7280)),
                      filled: true,
                      fillColor: const Color(0xFF0A0A0A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _filtered.length,
                itemBuilder: (context, index) {
                  final curr = _filtered[index];
                  final isSelected = curr.code == widget.selectedCode;
                  final isExcluded = curr.code == widget.excludeCode;
                  final isDisabled = widget.disabledFor?.call(curr) ?? false;
                  final muted = isExcluded || isDisabled;
                  final countryCode = curr.country.toLowerCase();
                  final flag = countryCode.isNotEmpty
                      ? countryCode
                          .toUpperCase()
                          .codeUnits
                          .map((c) => String.fromCharCode(c + 127397))
                          .join()
                      : '';

                  return ListTile(
                    enabled: !muted,
                    onTap: muted ? null : () => widget.onSelected(curr.code),
                    leading: Opacity(
                      opacity: isDisabled ? 0.45 : 1,
                      child: flag.isNotEmpty
                          ? Text(flag, style: const TextStyle(fontSize: 24))
                          : const Icon(Icons.currency_exchange,
                              color: Color(0xFF9CA3AF)),
                    ),
                    title: Text(
                      curr.code,
                      style: TextStyle(
                        color: muted ? const Color(0xFF6B7280) : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      isDisabled && widget.disabledHint != null
                          ? '${curr.name} · ${widget.disabledHint}'
                          : curr.name,
                      style: TextStyle(
                        color: muted
                            ? const Color(0xFF4B5563)
                            : const Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: Color(0xFF4E03D0), size: 20)
                        : isExcluded
                            ? const Text('Selected',
                                style: TextStyle(
                                    color: Color(0xFF6B7280), fontSize: 12))
                            : isDisabled
                                ? const Icon(Icons.lock_outline,
                                    color: Color(0xFF6B7280), size: 16)
                                : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
