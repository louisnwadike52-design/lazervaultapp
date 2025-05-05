import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart'; // Ensure this import exists
import 'package:lazervault/core/types/countries.dart'; // Ensure this import exists
import 'package:lazervault/core/types/language.dart'; // Ensure this import exists
import 'package:lazervault/core/types/screen.dart'; // Ensure this import exists
import 'package:lazervault/src/features/widgets/build_form_field.dart'; // Ensure this import exists
import 'package:lazervault/src/features/widgets/themed_app_bar.dart'; // Ensure this import exists
import 'package:lazervault/src/features/widgets/universal_image_loader.dart'; // Ensure this import exists

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  Country selectedCountry = AppData.countries.first;
  final TextEditingController searchController = TextEditingController();
  List<Language> filteredLanguages = [];
  String searchQuery = "";
  String? selectedLanguageCode = AppData.languages[0].code;

  @override
  void initState() {
    super.initState();
    filteredLanguages = AppData.languages;

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
        filteredLanguages = AppData.languages
            .where((language) =>
                language.name.toLowerCase().contains(searchQuery) ||
                language.code.toLowerCase().contains(searchQuery))
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
    return Scaffold(
      body: Column(
        children: [
          ThemedAppBar(
            title: ScreenName.languages.displayName,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Get.back();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No route to go back."),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Choose a language",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.0.h),
                      BuildFormField(
                        controller: searchController,
                        placeholder: 'Choose a language...',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 24.sp,
                        ),
                        name: 'search_recipient',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredLanguages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final language = filteredLanguages[index];
                      return ListTile(
                        leading: UniversalImageLoader(
                          imagePath: language.flagPath,
                          height: 32.0.h,
                          width: 48.0.w,
                        ),
                        title: Text(
                          language.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Radio<String>(
                          value:
                              language.code, // Use language code as the value
                          groupValue:
                              selectedLanguageCode, // Track selected language
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLanguageCode =
                                  newValue; // Update selected language
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        onTap: () {
                          setState(() {
                            selectedLanguageCode =
                                language.code; // Update selection on tap
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
