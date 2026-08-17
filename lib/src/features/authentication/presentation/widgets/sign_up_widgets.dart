part of 'sign_up.dart';

/// Country picker bottomsheet for the phone field on signup page 2.
/// Lists every entry from `CountryLocales.all` with flag + name + dial
/// code, with a search box at the top. The previously-selected country
/// is highlighted. Selecting closes the sheet via `onSelect`.
class _PhoneCountryPickerSheet extends StatefulWidget {
  final String selectedCode;
  final void Function(CountryLocale) onSelect;

  const _PhoneCountryPickerSheet({
    required this.selectedCode,
    required this.onSelect,
  });

  @override
  State<_PhoneCountryPickerSheet> createState() => _PhoneCountryPickerSheetState();
}

class _PhoneCountryPickerSheetState extends State<_PhoneCountryPickerSheet> {
  static const Color _brandPurple = Color(0xFF4834D4);
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final all = CountryLocales.all;
    final filtered = _query.isEmpty
        ? all
        : all.where((c) {
            final q = _query.toLowerCase();
            return c.countryName.toLowerCase().contains(q) ||
                c.dialCode.contains(q) ||
                c.countryCode.toLowerCase().contains(q);
          }).toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Drag-handle
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: TextField(
                autofocus: false,
                style: const TextStyle(color: Colors.white),
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search country or dial code',
                  hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5)),
                  prefixIcon: Icon(Icons.search,
                      color: Colors.white.withValues(alpha: 0.5)),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.06),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final c = filtered[i];
                  final isSelected = c.countryCode == widget.selectedCode;
                  return InkWell(
                    onTap: () => widget.onSelect(c),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              c.countryName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            c.dialCode,
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          if (isSelected)
                            Icon(Icons.check, color: _brandPurple, size: 18.sp),
                        ],
                      ),
                    ),
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

/// Forces all typed input to lowercase as the user types. Used on the username
/// / Lazertag field so the on-screen handle matches the lowercased value the
/// backend stores and looks up — a case mismatch on a @tag transfer could
/// otherwise miss the recipient.
class _LowercaseTextFormatter extends TextInputFormatter {
  const _LowercaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(text: newValue.text.toLowerCase());
  }
}
