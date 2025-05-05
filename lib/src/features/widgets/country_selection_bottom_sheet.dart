import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/countries.dart';

class CountrySelectionBottomSheet extends StatefulWidget {
  const CountrySelectionBottomSheet({
    super.key,
    required this.selectedCountry,
    required this.onSelect,
  });

  final Country selectedCountry;
  final ValueChanged<Country> onSelect;

  @override
  State<CountrySelectionBottomSheet> createState() =>
      _CountrySelectionBottomSheetState();
}

class _CountrySelectionBottomSheetState
    extends State<CountrySelectionBottomSheet> {
  final TextEditingController searchController = TextEditingController();
  List<Country> filteredCountries = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredCountries = AppData.countries; // Initialize with all countries

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
        filteredCountries = AppData.countries
            .where((country) =>
                country.name.toLowerCase().contains(searchQuery) ||
                country.code.toLowerCase().contains(searchQuery))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context), // Dismiss when tapping outside
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0.r),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.95,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0.h, horizontal: 8.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Currency",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search for a currency",
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade600,
                        ),
                        fillColor: const Color(0xFFF0F0F0),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior().copyWith(overscroll: false),
                        child: filteredCountries.isEmpty
                            ? Center(
                                child: Text(
                                  "No matching countries",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                controller: scrollController,
                                itemCount: filteredCountries.length,
                                itemBuilder: (context, index) {
                                  final country = filteredCountries[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 16.0.r,
                                      backgroundImage: AssetImage(country.flag),
                                    ),
                                    title: Text(
                                      country.name,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: Text(
                                      country.code,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    onTap: () {
                                      widget
                                          .onSelect(country); // Pass selection
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
