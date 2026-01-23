import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _selectedCountryController =
      TextEditingController();

  // Country data with dialing codes and ISO country codes for locale mapping
  // Nigeria is first as it's the default and primary supported country
  List<Map<String, String>> countries = [
    {"name": "Nigeria", "code": "+234", "flag": "🇳🇬", "countryCode": "NG"},
    {"name": "United States", "code": "+1", "flag": "🇺🇸", "countryCode": "US"},
    {"name": "United Kingdom", "code": "+44", "flag": "🇬🇧", "countryCode": "GB"},
    {"name": "Canada", "code": "+1", "flag": "🇨🇦", "countryCode": "CA"},
    {"name": "India", "code": "+91", "flag": "🇮🇳", "countryCode": "IN"},
    {"name": "Germany", "code": "+49", "flag": "🇩🇪", "countryCode": "DE"},
    {"name": "France", "code": "+33", "flag": "🇫🇷", "countryCode": "FR"},
    {"name": "South Africa", "code": "+27", "flag": "🇿🇦", "countryCode": "ZA"},
    {"name": "Australia", "code": "+61", "flag": "🇦🇺", "countryCode": "AU"},
    {"name": "Japan", "code": "+81", "flag": "🇯🇵", "countryCode": "JP"},
  ];

  List<Map<String, String>> filteredCountries = [];
  List<Map<String, String>> selectedCountries = [];

  @override
  void initState() {
    super.initState();
    filteredCountries = List.from(countries);
    // Preselect Nigeria by default and save to services
    _preselectDefaultCountry();
    // Save the default locale immediately
    _saveSelectedCountry();
  }

  /// Preselect Nigeria as the default country
  void _preselectDefaultCountry() {
    final nigeria = countries.firstWhere(
      (c) => c["countryCode"] == "NG",
      orElse: () => countries.first,
    );
    if (!selectedCountries.contains(nigeria)) {
      selectedCountries.add(nigeria);
      _updateSelectedCountries();
    }
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildCountryPickerSheet(),
    );
  }

  Widget _buildCountryPickerSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Done button - always visible at the top
          Padding(
            padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 32.0,
                ),
                minimumSize: Size(double.infinity, 36.h),
              ),
              onPressed: () {
                _updateSelectedCountries();
                Navigator.pop(context);
              },
              child: Text(
                "Done",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ),
          // Search field
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BuildFormField(
                    controller: _searchController,
                    name: "search_country",
                    placeholder: "Search country",
                    prefixIcon: const Icon(Icons.search, color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.blue),
                      onPressed: () {
                        _searchController.clear();
                        setState(
                            () => filteredCountries = List.from(countries));
                      },
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredCountries = countries
                            .where((country) => country["name"]!
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Scrollable country list
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final isSelected = selectedCountries.contains(country);
                return ListTile(
                  tileColor: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  leading:
                      Text(country["flag"]!, style: TextStyle(fontSize: 24.sp)),
                  title: Text(
                    country["name"]!,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    country["code"]!,
                    style: TextStyle(
                      color: isSelected ? Colors.black54 : Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCountries.remove(country);
                      } else {
                        selectedCountries.add(country);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateSelectedCountries() {
    setState(() {
      _selectedCountryController.text = selectedCountries
          .map((country) => "${country["flag"]} ${country["name"]}")
          .join(", ");
    });
  }

  /// Get locale string from country name (e.g., "Nigeria" -> "en-NG")
  String? _getLocaleFromCountryName(String countryName) {
    final country = countries.firstWhere(
      (c) => c["name"] == countryName,
      orElse: () => {},
    );
    final countryCode = country["countryCode"];
    if (countryCode == null || countryCode.isEmpty) return null;
    return 'en-$countryCode';
  }

  /// Get ISO country code from country name (e.g., "Nigeria" -> "NG")
  String? _getCountryCodeFromName(String countryName) {
    final country = countries.firstWhere(
      (c) => c["name"] == countryName,
      orElse: () => {},
    );
    return country["countryCode"];
  }

  /// Save selected country to SignupStateService and LocaleManager
  Future<void> _saveSelectedCountry() async {
    if (selectedCountries.isEmpty) return;

    try {
      final signupStateService = serviceLocator<SignupStateService>();
      final localeManager = serviceLocator<LocaleManager>();

      // Get the first selected country (primary country)
      final primaryCountry = selectedCountries.first;
      final countryName = primaryCountry["name"];
      final countryCode = _getCountryCodeFromName(countryName ?? '');
      final locale = _getLocaleFromCountryName(countryName ?? '');

      if (countryCode != null && locale != null) {
        // Save to signup draft
        await signupStateService.updateDraftLocale(locale);
        // Also persist to LocaleManager for immediate access
        await localeManager.setCountry(countryCode);
      }
    } catch (e) {
      // Silently fail - country selection is best effort
      print('Error saving country selection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveController = ResponsiveController(context);

    return Column(
      children: [
        ThemedAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Get.back();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No route to go back.")),
                );
              }
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.0.h),
                Text(
                  "Country of Residence",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0.h),
                SizedBox(
                  width: responsiveController.screenWidth * 0.7,
                  child: Text(
                    "Please select all the countries that you're a tax resident in",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                  ),
                ),
                SizedBox(height: 16.0.h),

                /// **Country Selection Field**
                GestureDetector(
                  onTap: () => _openBottomSheet(context),
                  child: AbsorbPointer(
                    child: BuildFormField(
                      controller: _selectedCountryController,
                      name: "country",
                      placeholder: "Select Countries",
                      prefixIcon:
                          const Icon(Icons.public, color: Colors.black45),
                      suffixIcon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black45),
                    ),
                  ),
                ),

                /// **Display Selected Countries**
                if (selectedCountries.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Wrap(
                      spacing: 8.w,
                      children: selectedCountries.map((country) {
                        return Chip(
                          label: Text("${country["flag"]} ${country["name"]}"),
                          backgroundColor: Colors.blue.shade100,
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: 140.0.h, left: 16.0.w, right: 16.0.w),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 32.0,
              ),
              minimumSize: Size(double.infinity, 36.h),
            ),
            onPressed: () async {
              if (_selectedCountryController.text.isNotEmpty) {
                // Save selected country to SignupStateService and LocaleManager
                await _saveSelectedCountry();
                Get.toNamed(AppRoutes.enableBiometricAccess);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select a country")),
                );
              }
            },
            child: Text(
              "Confirm",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
        ),
      ],
    );
  }
}
