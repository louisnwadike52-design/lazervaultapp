import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  List<Map<String, String>> countries = [
    {"name": "United States", "code": "+1", "flag": "🇺🇸"},
    {"name": "United Kingdom", "code": "+44", "flag": "🇬🇧"},
    {"name": "Canada", "code": "+1", "flag": "🇨🇦"},
    {"name": "India", "code": "+91", "flag": "🇮🇳"},
    {"name": "Germany", "code": "+49", "flag": "🇩🇪"},
    {"name": "France", "code": "+33", "flag": "🇫🇷"},
    {"name": "Nigeria", "code": "+234", "flag": "🇳🇬"},
    {"name": "South Africa", "code": "+27", "flag": "🇿🇦"},
    {"name": "Australia", "code": "+61", "flag": "🇦🇺"},
    {"name": "Japan", "code": "+81", "flag": "🇯🇵"},
  ];

  List<Map<String, String>> filteredCountries = [];
  List<Map<String, String>> selectedCountries = [];

  @override
  void initState() {
    super.initState();
    filteredCountries = List.from(countries);
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
            onPressed: () {
              if (_selectedCountryController.text.isNotEmpty) {
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
