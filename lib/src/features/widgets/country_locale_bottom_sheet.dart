import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/locale_manager.dart';

/// Bottom sheet for selecting country/locale with search functionality
///
/// Features:
/// - Search by country name, code, or locale
/// - Displays country flag, name, and locale code
/// - Material Design draggable bottom sheet
/// - Reactive filtering
class CountryLocaleBottomSheet extends StatefulWidget {
  final String? selectedCountryCode;
  final Function(CountryLocale) onCountrySelected;

  const CountryLocaleBottomSheet({
    super.key,
    this.selectedCountryCode,
    required this.onCountrySelected,
  });

  /// Show the bottom sheet
  static Future<CountryLocale?> show(
    BuildContext context, {
    String? selectedCountryCode,
  }) async {
    return showModalBottomSheet<CountryLocale>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CountryLocaleBottomSheet(
        selectedCountryCode: selectedCountryCode,
        onCountrySelected: (country) {
          Navigator.of(context).pop(country);
        },
      ),
    );
  }

  @override
  State<CountryLocaleBottomSheet> createState() => _CountryLocaleBottomSheetState();
}

class _CountryLocaleBottomSheetState extends State<CountryLocaleBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<CountryLocale> _filteredCountries = CountryLocales.all;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    setState(() {
      _filteredCountries = CountryLocales.search(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Country',
                      style: GoogleFonts.inter(
                        color: Colors.black87,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.grey[700],
                        size: 24.sp,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(
                    color: Colors.black87,
                    fontSize: 15.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search country, code, or locale...',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 15.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color.fromARGB(255, 78, 3, 208),
                      size: 22.sp,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear_rounded,
                              color: Colors.grey[400],
                              size: 20.sp,
                            ),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 78, 3, 208),
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                  ),
                ),
              ),

              // Results count
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${_filteredCountries.length} ${_filteredCountries.length == 1 ? 'country' : 'countries'}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[600],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Country list
              Expanded(
                child: _filteredCountries.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          bottom: 20.h,
                        ),
                        itemCount: _filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          final isSelected = country.countryCode ==
                              widget.selectedCountryCode;

                          return _buildCountryTile(country, isSelected);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryTile(CountryLocale country, bool isSelected) {
    return InkWell(
      onTap: () => widget.onCountrySelected(country),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.08)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Flag
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  country.flag,
                  style: TextStyle(fontSize: 26.sp),
                ),
              ),
            ),

            SizedBox(width: 14.w),

            // Country details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.countryName,
                    style: GoogleFonts.inter(
                      color: Colors.black87,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          country.locale,
                          style: GoogleFonts.inter(
                            color: const Color.fromARGB(255, 78, 3, 208),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        country.dialCode,
                        style: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        country.countryCode,
                        style: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Selected indicator
            if (isSelected)
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 48.sp,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'No countries found',
            style: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try a different search term',
            style: GoogleFonts.inter(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
