import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/countries.dart';
import 'package:lazervault/core/utilities/display_success_dialog.dart';
import 'package:lazervault/src/features/widgets/country_selection_bottom_sheet.dart';

class RequestFunds extends StatefulWidget {
  const RequestFunds({super.key});

  @override
  State<RequestFunds> createState() => _RequestFundsState();
}

class _RequestFundsState extends State<RequestFunds> {
  Country selectedCountry = AppData.countries.first;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  Future<void> _showCountrySelectionBottomSheet() async {
    final selected = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) => CountrySelectionBottomSheet(
        selectedCountry: selectedCountry,
        onSelect: (country) => Navigator.pop(context, country),
      ),
    );

    if (selected != null) {
      setState(() => selectedCountry = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header - Made more prominent against purple background
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
              ),
              Expanded(
                child: Text(
                  'Request Funds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(width: 48.w),
            ],
          ),
        ),
    
        // Main Content
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipient Info - Lighter background for contrast
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.w),
                            child: Image.asset(
                              "assets/images/dp.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Louis Nwadike",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "3887498783",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
    
                  // Amount Input - Updated styling
                  Text(
                    'Amount',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: _showCountrySelectionBottomSheet,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12.r,
                                  backgroundImage: AssetImage(selectedCountry.flag),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  selectedCountry.code,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                              ),
                              hintText: 'Enter amount',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
    
                  // Updated _buildInputField method calls with new styling
                  _buildInputField(
                    label: 'Email',
                    hint: 'youremail@example.com',
                    controller: emailController,
                    icon: Icons.email_outlined,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    borderColor: Colors.white.withOpacity(0.15),
                  ),
                  SizedBox(height: 24.h),
    
                  _buildInputField(
                    label: 'Notes',
                    hint: 'Please make payment',
                    controller: notesController,
                    icon: Icons.note_outlined,
                    maxLines: 3,
                    backgroundColor: Colors.white.withOpacity(0.08),
                    borderColor: Colors.white.withOpacity(0.15),
                  ),
                ],
              ),
            ),
          ),
        ),
    
        // Request Button - Updated styling
        Padding(
          padding: EdgeInsets.all(24.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => displaySuccessDialog(
                context: context,
                iconPath: "assets/images/success.png",
                title: "Request Sent",
                subtitle: "Payment request is successfully sent",
                confirmationText: "Done",
                dismissText: "Back to home",
                onConfirm: () => Get.offAllNamed(AppRoutes.dashboard),
                onDismiss: () => Get.offAllNamed(AppRoutes.dashboard),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1ED69E).withOpacity(0.9),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 4,
                shadowColor: Color(0xFF1ED69E).withOpacity(0.3),
              ),
              child: Text(
                'Send Request',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Updated _buildInputField method with new parameters
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: maxLines,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
