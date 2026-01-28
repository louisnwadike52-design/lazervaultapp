import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/core/services/locale_manager.dart';

class CountryPickerDialog extends StatefulWidget {
  final String currentCountry;
  final String currentCurrency;

  const CountryPickerDialog({
    super.key,
    required this.currentCountry,
    required this.currentCurrency,
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late String _selectedCountry;
  late String _selectedCurrency;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.currentCountry;
    _selectedCurrency = widget.currentCurrency;
  }

  List<CountryLocale> get _filteredCountries {
    if (_searchQuery.isEmpty) {
      return CountryLocales.all;
    }
    final lowerQuery = _searchQuery.toLowerCase();
    return CountryLocales.all.where((country) {
      return country.countryName.toLowerCase().contains(lowerQuery) ||
             country.countryCode.toLowerCase().contains(lowerQuery) ||
             country.currency.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  void _handleSave() {
    context.read<ProfileCubit>().updateUserProfile(
          country: _selectedCountry,
          currency: _selectedCurrency,
        );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        padding: EdgeInsets.all(24.w),
        constraints: BoxConstraints(maxHeight: 600.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.public_outlined,
                  color: const Color(0xFF4E03D0),
                  size: 28.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Country & Currency',
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Search Field
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              ),
            ),

            SizedBox(height: 16.h),

            // Country List
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = _filteredCountries[index];
                  final isSelected = _selectedCountry == country.countryName;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCountry = country.countryName;
                        _selectedCurrency = country.currency;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4E03D0)
                              : Colors.grey.shade200,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Flag emoji
                          Text(
                            country.flag,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  country.countryName,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    color: isSelected
                                        ? const Color(0xFF4E03D0)
                                        : const Color(0xFF1F2937),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Text(
                                      country.currency,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? const Color(0xFF4E03D0).withValues(alpha: 0.7)
                                            : const Color(0xFF6B7280),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      '• ${country.countryCode}',
                                      style: GoogleFonts.inter(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF4E03D0),
                              size: 20.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            // Action Button
            ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Save',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
