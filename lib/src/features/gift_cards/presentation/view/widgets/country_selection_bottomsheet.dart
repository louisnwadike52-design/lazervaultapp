import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/gift_card_entity.dart';

/// Country selection bottomsheet for filtering gift cards by country.
/// Supports dynamic countries from Reloadly API with fallback to hardcoded list.
class CountrySelectionBottomsheet extends StatefulWidget {
  final String selectedCountryCode;
  final Function(String countryCode, String countryName) onCountrySelected;
  final List<GiftCardCountry> dynamicCountries;

  const CountrySelectionBottomsheet({
    super.key,
    required this.selectedCountryCode,
    required this.onCountrySelected,
    this.dynamicCountries = const [],
  });

  // Fallback list when dynamic countries haven't loaded
  static const List<Map<String, String>> _fallbackCountries = [
    {'code': 'NG', 'name': 'Nigeria', 'currency': 'NGN'},
    {'code': 'US', 'name': 'United States', 'currency': 'USD'},
    {'code': 'GB', 'name': 'United Kingdom', 'currency': 'GBP'},
    {'code': 'CA', 'name': 'Canada', 'currency': 'CAD'},
    {'code': 'AU', 'name': 'Australia', 'currency': 'AUD'},
    {'code': 'DE', 'name': 'Germany', 'currency': 'EUR'},
    {'code': 'FR', 'name': 'France', 'currency': 'EUR'},
    {'code': 'ZA', 'name': 'South Africa', 'currency': 'ZAR'},
  ];

  @override
  State<CountrySelectionBottomsheet> createState() => _CountrySelectionBottomsheetState();

  /// Static method to show the bottomsheet
  static void show({
    required BuildContext context,
    required String selectedCountryCode,
    required Function(String countryCode, String countryName) onCountrySelected,
    List<GiftCardCountry> dynamicCountries = const [],
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CountrySelectionBottomsheet(
        selectedCountryCode: selectedCountryCode,
        onCountrySelected: onCountrySelected,
        dynamicCountries: dynamicCountries,
      ),
    );
  }

  /// Generate flag emoji from ISO 3166-1 alpha-2 country code
  static String getFlag(String countryCode) {
    if (countryCode.length != 2) return '\u{1F30D}';
    final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
    return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
  }

  /// Get country name by country code
  static String getCountryName(String countryCode) {
    if (countryCode.isEmpty) return 'All Countries';
    final country = _fallbackCountries.firstWhere(
      (c) => c['code'] == countryCode,
      orElse: () => {'name': countryCode},
    );
    return country['name']!;
  }
}

class _CountrySelectionBottomsheetState extends State<CountrySelectionBottomsheet> {
  String _searchQuery = '';
  final _searchController = TextEditingController();

  static const _allCountriesItem = _CountryItem(
    code: '',
    name: 'All Countries',
    currency: '',
    flag: '\u{1F30D}', // Globe emoji
  );

  /// Builds the country list to display — "All Countries" first, then dynamic/fallback
  List<_CountryItem> get _countries {
    final List<_CountryItem> items = [_allCountriesItem];

    if (widget.dynamicCountries.isNotEmpty) {
      items.addAll(widget.dynamicCountries
          .map((c) => _CountryItem(
                code: c.isoCode,
                name: c.name,
                currency: c.currencyCode,
                flag: getFlag(c.isoCode),
              )));
    } else {
      items.addAll(CountrySelectionBottomsheet._fallbackCountries
          .map((c) => _CountryItem(
                code: c['code']!,
                name: c['name']!,
                currency: c['currency']!,
                flag: getFlag(c['code']!),
              )));
    }
    return items;
  }

  static String getFlag(String code) => CountrySelectionBottomsheet.getFlag(code);

  List<_CountryItem> get _filteredCountries {
    if (_searchQuery.isEmpty) return _countries;
    final q = _searchQuery.toLowerCase();
    return _countries
        .where((c) =>
            c.name.toLowerCase().contains(q) ||
            c.code.toLowerCase().contains(q) ||
            c.currency.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredCountries;
    final hasDynamic = widget.dynamicCountries.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Country',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        hasDynamic
                            ? '${widget.dynamicCountries.length} countries available'
                            : 'Choose a country to see available gift cards',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2D2D),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search countries...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF6B7280),
                  size: 20.sp,
                ),
                filled: true,
                fillColor: const Color(0xFF0A0A0A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Countries list
          SizedBox(
            height: 400.h,
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, color: const Color(0xFF6B7280), size: 32.sp),
                        SizedBox(height: 8.h),
                        Text(
                          'No countries match your search',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final country = filtered[index];
                      final isSelected = country.code == widget.selectedCountryCode;
                      return _buildCountryTile(
                        context: context,
                        country: country,
                        isSelected: isSelected,
                      );
                    },
                  ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildCountryTile({
    required BuildContext context,
    required _CountryItem country,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        widget.onCountrySelected(country.code, country.name);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
              : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              country.flag,
              style: TextStyle(fontSize: 28.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    country.code.isEmpty
                        ? 'Browse gift cards from all countries'
                        : '${country.code} \u2022 ${country.currency}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 22.w,
                height: 22.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Internal model for country display
class _CountryItem {
  final String code;
  final String name;
  final String currency;
  final String flag;

  const _CountryItem({
    required this.code,
    required this.name,
    required this.currency,
    required this.flag,
  });
}
