part of 'intl_data_purchase_screen.dart';

/// Bottomsheet country picker with live search. Search matches the
/// country name, ISO-2 code, or dial code (case-insensitive) so users
/// can type "KE" / "+254" / "kenya" and get the same result. Selecting
/// a country pops the sheet with the [IntlDataCountry] — caller wires
/// it into whatever state it needs.
class _CountryPickerSheet extends StatefulWidget {
  final String selectedCode;

  const _CountryPickerSheet({required this.selectedCode});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<IntlDataCountry> _filtered() {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return IntlDataCountry.all;
    return IntlDataCountry.all.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.code.toLowerCase().contains(q) ||
          c.dial.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered();
    const primary = Color(0xFF4E03D0);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Select country',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (v) => setState(() => _query = v),
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Search by name, code, or dial…',
                  hintStyle: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(Icons.search,
                      color: const Color(0xFF6B7280), size: 20.sp),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Text(
                        'No countries match "$_query"',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: results.length,
                      separatorBuilder: (_, __) => Divider(
                        color: const Color(0xFF2D2D2D),
                        height: 1.h,
                      ),
                      itemBuilder: (ctx, i) {
                        final c = results[i];
                        final isSelected = c.code == widget.selectedCode;
                        return ListTile(
                          onTap: () => Navigator.of(ctx).pop(c),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 4.w),
                          leading: Text(c.flag,
                              style: TextStyle(fontSize: 24.sp)),
                          title: Text(
                            c.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${c.code} · ${c.dial}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(Icons.check_circle,
                                  color: primary, size: 20.sp)
                              : null,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
