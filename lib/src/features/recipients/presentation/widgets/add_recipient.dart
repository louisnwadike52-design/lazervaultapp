import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';

enum AddRecipientMethod { bankDetails, username, contacts }

class AddRecipient extends StatefulWidget {
  const AddRecipient({super.key});

  @override
  State<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends State<AddRecipient> {
  AddRecipientMethod _selectedMethod = AddRecipientMethod.bankDetails;

  // Bank Details Form Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();
  final TextEditingController _bankController = TextEditingController(text: "Select Bank");
  final TextEditingController _bankSearchController = TextEditingController();
  bool _isPersonal = true; // Personal or Business account
  bool _isFavorite = false;
  String _bankSearchQuery = '';

  // Username Form Controller
  final TextEditingController _usernameController = TextEditingController();

  final List<Map<String, dynamic>> ukBanks = [
    {"name": "Barclays", "logo": "https://upload.wikimedia.org/wikipedia/commons/3/3e/Barclays_logo.svg"},
    {"name": "HSBC", "logo": "https://upload.wikimedia.org/wikipedia/commons/5/5a/HSBC_logo_%282018%29.svg"},
    {"name": "Lloyds Bank", "logo": "https://images.app.goo.gl/e69Fa8zSismMDCb5A"},
    {"name": "NatWest", "logo": "https://upload.wikimedia.org/wikipedia/commons/3/31/NatWest_logo.svg"},
    {"name": "Santander UK", "logo": "https://upload.wikimedia.org/wikipedia/commons/b/b3/Santander_Logo.svg"},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _accountController.dispose();
    _sortCodeController.dispose();
    _bankController.dispose();
    _bankSearchController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipientCubit, RecipientState>(
      listener: (context, state) {
        if (state is RecipientError) {
          Get.snackbar(
            'Error',
            state.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        } else if (state is RecipientSuccess) {
          Get.snackbar(
            'Success',
            state.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
          );

          // Navigate to initiate send funds screen with the newly created recipient
          if (state.recipient != null) {
            Get.offNamed(
              AppRoutes.initiateSendFunds,
              arguments: state.recipient,
            );
          } else {
            // If no recipient is returned (shouldn't happen), just go back
            Get.back();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Top Purple Section with Gradient
              Container(
                height: Get.height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 78, 3, 208),
                      Color.fromARGB(255, 95, 20, 225),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                      // Header with Back Button
              Row(
                children: [
                          BackNavigator(),
                          Expanded(
                            child: Text(
                              'Add New Recipient',
                              textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Description
                      Text(
                        'Choose how you\'d like to add a recipient',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Method Selection Cards
                      Row(
                            children: [
                          Expanded(
                            child: _buildMethodCard(
                              method: AddRecipientMethod.bankDetails,
                              icon: Icons.account_balance_outlined,
                              title: 'Bank Details',
                              isSelected: _selectedMethod == AddRecipientMethod.bankDetails,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildMethodCard(
                              method: AddRecipientMethod.username,
                              icon: Icons.alternate_email,
                              title: '@Username',
                              isSelected: _selectedMethod == AddRecipientMethod.username,
                            ),
                          ),
                          SizedBox(width: 12.w),
                              Expanded(
                            child: _buildMethodCard(
                              method: AddRecipientMethod.contacts,
                              icon: Icons.contacts_outlined,
                              title: 'Contacts',
                              isSelected: _selectedMethod == AddRecipientMethod.contacts,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Main Content Section
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(24.w),
                        child: _buildSelectedMethodContent(),
                      ),
                    ),
                    
                    // Bottom Action Button
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[100]!, width: 1),
                        ),
                      ),
                      child: _buildActionButton(state),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMethodCard({
    required AddRecipientMethod method,
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected 
            ? Colors.white.withOpacity(0.2) 
            : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
              ? Colors.white.withOpacity(0.4) 
              : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedMethodContent() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        return _buildBankDetailsForm();
      case AddRecipientMethod.username:
        return _buildUsernameForm();
      case AddRecipientMethod.contacts:
        return _buildContactsForm();
    }
  }

  Widget _buildBankDetailsForm() {
    return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
        Text(
          'Bank Account Details',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter the recipient\'s banking information',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // Account Type Selector
                      Container(
          padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
            color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isPersonal = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: _isPersonal ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: _isPersonal ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ] : null,
                    ),
                              child: Text(
                      'Personal',
                      textAlign: TextAlign.center,
                                style: TextStyle(
                        color: _isPersonal ? Color.fromARGB(255, 78, 3, 208) : Colors.grey[600],
                                  fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _isPersonal = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: !_isPersonal ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: !_isPersonal ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ] : null,
                    ),
                    child: Text(
                      'Business',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                        color: !_isPersonal ? Color.fromARGB(255, 78, 3, 208) : Colors.grey[600],
                        fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Form Fields
                            _buildFormField(
                              controller: _nameController,
          label: _isPersonal? 'Full Name' : 'Business Name',
          hint: _isPersonal ? 'Enter recipient\'s full name' : 'Enter business name',
          icon: _isPersonal ? Icons.person_outline : Icons.business_outlined,
                            ),
                            SizedBox(height: 16.h),
        
                            _buildAccountNumberField(),
                            SizedBox(height: 16.h),
        
                            _buildSortCodeField(),
                            SizedBox(height: 16.h),

        // Bank Selection
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bank',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _showBankSelectionBottomSheet,
                                child: Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                  color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey[200]!),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance,
                      color: Colors.grey[600],
                                        size: 24.sp,
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: Text(
                                          _bankController.text,
                                          style: TextStyle(
                          color: _bankController.text == "Select Bank"
                              ? Colors.grey[600]
                              : Colors.black87,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                      color: Colors.grey[600],
                                        size: 16.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
          ],
        ),
        SizedBox(height: 24.h),

        // Favorite Toggle
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                color: Color.fromARGB(255, 78, 3, 208),
                                      size: 24.sp,
                                    ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                                    Text(
                                      'Save as Favorite',
                                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                    Text(
                      'Quick access for future transfers',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                                ),
                                Switch(
                                  value: _isFavorite,
                onChanged: (value) => setState(() => _isFavorite = value),
                activeThumbColor: Color.fromARGB(255, 78, 3, 208),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LazerTag Username',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add recipients using their LazerVault username',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // Username Input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextField(
                controller: _usernameController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter @username',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.alternate_email,
                    color: Color.fromARGB(255, 78, 3, 208),
                    size: 24.sp,
                  ),
                ),
                                  onChanged: (value) {
                  if (!value.startsWith('@') && value.isNotEmpty) {
                    _usernameController.text = '@$value';
                    _usernameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _usernameController.text.length),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        // Example Tags
        Text(
          'Try searching for:',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: ['@louis', '@sarah', '@mike'].map((username) {
            return GestureDetector(
              onTap: () {
                _usernameController.text = username;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  username,
                  style: TextStyle(
                    color: Color.fromARGB(255, 78, 3, 208),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24.h),

        // Info Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.blue[100]!),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue[600],
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Recipients added by username will be automatically verified as LazerVault users',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 12.sp,
                  ),
                ),
                            ),
                          ],
                        ),
                      ),
                    ],
    );
  }

  Widget _buildContactsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Device Contacts',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add recipients from your phone contacts',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // Access Contacts Button
              Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                Color.fromARGB(255, 95, 20, 225).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.contacts_outlined,
                  color: Color.fromARGB(255, 78, 3, 208),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Access Contacts',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Browse your contacts and add their banking details',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: _showContactSelection,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                icon: Icon(Icons.search, size: 18.sp),
                label: Text(
                  'Browse Contacts',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Info Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.green[100]!),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security_outlined,
                color: Colors.green[600],
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Your contacts are processed locally and never stored on our servers',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              icon: Icon(
                icon,
                color: Colors.grey[600],
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSortCodeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort Code',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: _sortCodeController,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
              letterSpacing: 1.5,
            ),
            keyboardType: TextInputType.number,
            maxLength: 8, // 6 digits + 2 hyphens
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
              TextInputFormatter.withFunction((oldValue, newValue) {
                final text = newValue.text;
                if (text.isEmpty) return newValue;

                // Format as XX-XX-XX
                String formatted = '';
                for (int i = 0; i < text.length; i++) {
                  if (i == 2 || i == 4) {
                    formatted += '-';
                  }
                  formatted += text[i];
                }

                return TextEditingValue(
                  text: formatted,
                  selection: TextSelection.collapsed(offset: formatted.length),
                );
              }),
            ],
            decoration: InputDecoration(
              hintText: 'XX-XX-XX',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.sp,
                letterSpacing: 1.5,
              ),
              border: InputBorder.none,
              counterText: '',
              icon: Icon(
                Icons.numbers_outlined,
                color: Colors.grey[600],
                size: 24.sp,
              ),
              suffixIcon: _sortCodeController.text.replaceAll('-', '').length == 6
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20.sp,
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Enter 6 digits (formatted as XX-XX-XX)',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(RecipientState state) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                    minimumSize: Size(double.infinity, 56.h),
                  ),
      onPressed: state is RecipientLoading ? null : _handleAddRecipient,
      child: state is RecipientLoading
          ? SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              _getActionButtonText(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  String _getActionButtonText() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        return 'Add Recipient';
      case AddRecipientMethod.username:
        return 'Find & Add User';
      case AddRecipientMethod.contacts:
        return 'Browse Contacts';
    }
  }

  void _handleAddRecipient() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        _addBankDetailsRecipient();
        break;
      case AddRecipientMethod.username:
        _addUsernameRecipient();
        break;
      case AddRecipientMethod.contacts:
        _showContactSelection();
        break;
    }
  }

  void _addBankDetailsRecipient() {
    // Trim all inputs
    final name = _nameController.text.trim();
    final accountNumber = _accountController.text.trim();
    final sortCode = _sortCodeController.text.replaceAll('-', '').trim();
    final bankName = _bankController.text;

    // Validate required fields
    if (name.isEmpty) {
      Get.snackbar(
        'Name Required',
        'Please enter the recipient\'s ${_isPersonal ? 'full name' : 'business name'}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (accountNumber.isEmpty) {
      Get.snackbar(
        'Account Number Required',
        'Please enter the account number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Validate account number (8 digits for UK)
    if (accountNumber.length != 8 || !RegExp(r'^\d+$').hasMatch(accountNumber)) {
      Get.snackbar(
        'Invalid Account Number',
        'Account number must be exactly 8 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (sortCode.isEmpty) {
      Get.snackbar(
        'Sort Code Required',
        'Please enter the sort code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Validate sort code (6 digits)
    if (sortCode.length != 6 || !RegExp(r'^\d+$').hasMatch(sortCode)) {
      Get.snackbar(
        'Invalid Sort Code',
        'Sort code must be exactly 6 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (bankName == "Select Bank") {
      Get.snackbar(
        'Bank Required',
        'Please select a bank',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final accessToken = authState.profile.session.accessToken;

      // Get active country from profile preferences
      String? countryCode;
      final profileState = context.read<ProfileCubit>().state;
      if (profileState is ProfileLoaded) {
        countryCode = profileState.preferences.activeCountry.isNotEmpty
            ? profileState.preferences.activeCountry
            : null;
      }

      context.read<RecipientCubit>().addRecipient(
        recipient: RecipientModel(
          id: '',
          name: name,
          accountNumber: accountNumber,
          bankName: bankName,
          sortCode: sortCode, // Store without hyphens
          isFavorite: _isFavorite,
          countryCode: countryCode,
        ),
        accessToken: accessToken,
      );
    }
  }

  void _addUsernameRecipient() {
    if (_usernameController.text.isEmpty || _usernameController.text == '@') {
      Get.snackbar(
        'Username Required',
        'Please enter a valid username',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Mock implementation - in real app, this would search for the user
    final username = _usernameController.text;
    final mockUser = _getMockUserByUsername(username);
    
    if (mockUser != null) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        final accessToken = authState.profile.session.accessToken;

        // Get active country from profile preferences
        String? countryCode;
        final profileState = context.read<ProfileCubit>().state;
        if (profileState is ProfileLoaded) {
          countryCode = profileState.preferences.activeCountry.isNotEmpty
              ? profileState.preferences.activeCountry
              : null;
        }

        context.read<RecipientCubit>().addRecipient(
          recipient: RecipientModel(
            id: mockUser['id']!,
            name: mockUser['name']!,
            accountNumber: username,
            bankName: 'LazerVault',
            sortCode: '',
            isFavorite: false,
            countryCode: countryCode,
          ),
          accessToken: accessToken,
        );
      }
    } else {
      Get.snackbar(
        'User Not Found',
        'No LazerVault user found with username $username',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Map<String, String>? _getMockUserByUsername(String username) {
    final mockUsers = {
      '@louis': {'id': 'lz1', 'name': 'Louis Lawrence'},
      '@sarah': {'id': 'lz2', 'name': 'Sarah Johnson'},
      '@mike': {'id': 'lz3', 'name': 'Mike Davis'},
    };
    return mockUsers[username.toLowerCase()];
  }

  void _showContactSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: EnhancedRecipientSelectionBottomSheet(
          onRecipientSelected: (recipient) {
            // Handle existing recipient selection if needed
          },
          onLazertagUserSelected: (user) {
            // Handle lazertag user selection if needed
          },
          onContactSelected: (contact) {
            Navigator.pop(bottomSheetContext);
            _showAddContactAsRecipientDialog(contact);
          },
          allowLazertagUsers: false, // Only show contacts
          allowContacts: true,
        ),
                          ),
                        );
                      }

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    final nameController = TextEditingController(text: contact.name);
    final accountController = TextEditingController();
    final bankController = TextEditingController();
    final sortCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Add Contact as Recipient',
                        style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFormField(
              controller: nameController,
              label: 'Name',
              hint: 'Full name',
              icon: Icons.person_outline,
            ),
            SizedBox(height: 16.h),
            _buildFormField(
              controller: accountController,
              label: 'Account Number',
              hint: 'Enter account number',
              icon: Icons.account_balance_outlined,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),
            _buildFormField(
              controller: sortCodeController,
              label: 'Sort Code',
              hint: 'Enter sort code',
              icon: Icons.numbers_outlined,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),
            _buildFormField(
              controller: bankController,
              label: 'Bank Name',
              hint: 'Enter bank name',
              icon: Icons.account_balance,
              ),
            ],
          ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (accountController.text.isNotEmpty && 
                  sortCodeController.text.isNotEmpty &&
                  bankController.text.isNotEmpty) {
                
                final authState = context.read<AuthenticationCubit>().state;
                if (authState is AuthenticationSuccess) {
                  final accessToken = authState.profile.session.accessToken;

                  // Get active country from profile preferences
                  String? countryCode;
                  final profileState = context.read<ProfileCubit>().state;
                  if (profileState is ProfileLoaded) {
                    countryCode = profileState.preferences.activeCountry.isNotEmpty
                        ? profileState.preferences.activeCountry
                        : null;
                  }

                  final recipient = RecipientModel(
                    id: contact.id,
                    name: nameController.text,
                    accountNumber: accountController.text,
                    bankName: bankController.text,
                    sortCode: sortCodeController.text,
                    isFavorite: false,
                    countryCode: countryCode,
                  );

                  Navigator.pop(dialogContext);
                  context.read<RecipientCubit>().addRecipient(
                    recipient: recipient,
                    accessToken: accessToken,
                  );
                }
              } else {
                Get.snackbar(
                  'Incomplete Information',
                  'Please fill in all banking details',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.orange.withOpacity(0.8),
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
            ),
            child: Text('Add Recipient'),
          ),
        ],
      ),
    );
  }

  void _showBankSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: Column(
            children: [
              // Handle Bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              
              // Header Section
              Container(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.account_balance_outlined,
                        color: Color.fromARGB(255, 78, 3, 208),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
                            "Select Bank",
          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Choose your recipient's bank",
                            style: TextStyle(
                              color: Colors.grey[600],
            fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
        Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: _bankSearchController,
                  onChanged: (value) {
                    setState(() {
                      _bankSearchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search banks...',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                      size: 20.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),

              // Popular Banks Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Text(
                      "Popular Banks",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
            borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "UK",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 16.h),

              // Banks List
              Expanded(
                child: Builder(
                  builder: (context) {
                    final filteredBanks = _bankSearchQuery.isEmpty
                        ? ukBanks
                        : ukBanks.where((bank) =>
                            bank["name"]!.toLowerCase().contains(_bankSearchQuery)
                          ).toList();

                    if (filteredBanks.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No banks found',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Try a different search term',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      itemCount: filteredBanks.length,
                      itemBuilder: (context, index) {
                        final bank = filteredBanks[index];
                    final isSelected = _bankController.text == bank["name"];
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _bankController.text = bank["name"]!;
                            });
                            Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: isSelected 
                                ? Color.fromARGB(255, 78, 3, 208).withOpacity(0.05)
                                : Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                                color: isSelected 
                                  ? Color.fromARGB(255, 78, 3, 208).withOpacity(0.3)
                                  : Colors.grey[200]!,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Bank Logo Container
                                Container(
                                  width: 48.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: _getBankGradientColors(bank["name"]!),
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _getBankGradientColors(bank["name"]!)[0].withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      _getBankInitials(bank["name"]!),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                
                                // Bank Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bank["name"]!,
                                        style: TextStyle(
                                          color: Colors.black87,
                fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        _getBankDescription(bank["name"]!),
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Selection Indicator
                                if (isSelected)
                                  Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 78, 3, 208),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  )
                                else
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey[400],
                                    size: 16.sp,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                    );
                  },
                ),
              ),

              // Bottom Safe Area
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  List<Color> _getBankGradientColors(String bankName) {
    switch (bankName.toLowerCase()) {
      case 'barclays':
        return [Color(0xFF0071CE), Color(0xFF004A8F)];
      case 'hsbc':
        return [Color(0xFFDB0011), Color(0xFFB8000E)];
      case 'lloyds bank':
        return [Color(0xFF006A4E), Color(0xFF004D3A)];
      case 'natwest':
        return [Color(0xFF5D2A8F), Color(0xFF4A1F75)];
      case 'santander uk':
        return [Color(0xFFEC0000), Color(0xFFD10000)];
      default:
        return [Color(0xFF78039C), Color(0xFF5F14E1)];
    }
  }

  String _getBankInitials(String bankName) {
    switch (bankName.toLowerCase()) {
      case 'barclays':
        return 'BC';
      case 'hsbc':
        return 'HS';
      case 'lloyds bank':
        return 'LB';
      case 'natwest':
        return 'NW';
      case 'santander uk':
        return 'SU';
      default:
        return bankName.substring(0, 2).toUpperCase();
    }
  }

  String _getBankDescription(String bankName) {
    switch (bankName.toLowerCase()) {
      case 'barclays':
        return 'Personal & Business Banking';
      case 'hsbc':
        return 'Global Banking Services';
      case 'lloyds bank':
        return 'Everyday Banking Solutions';
      case 'natwest':
        return 'Royal Bank of Scotland Group';
      case 'santander uk':
        return 'Consumer & Business Banking';
      default:
        return 'Banking Services';
    }
  }

  Widget _buildAccountNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Number',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: _accountController,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.sp,
              letterSpacing: 1.0,
            ),
            keyboardType: TextInputType.number,
            maxLength: 8,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
            ],
            decoration: InputDecoration(
              hintText: '12345678',
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              counterText: '',
              icon: Icon(
                Icons.account_balance_outlined,
                color: Colors.grey[600],
                size: 24.sp,
              ),
              suffixIcon: _accountController.text.length == 8
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20.sp,
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {}); // Rebuild to show/hide check icon
            },
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Enter 8 digits',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
