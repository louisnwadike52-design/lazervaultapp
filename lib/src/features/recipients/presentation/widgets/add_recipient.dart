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
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_verification_result.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/account_confirmation_bottom_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

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

  // Selected user from username search
  UserSearchResultEntity? _selectedUser;

  // Account verification state
  AccountVerificationResult? _verificationResult;
  bool _isVerifying = false;
  String? _selectedBankCode;

  // Banks list - fetched dynamically from backend
  List<Map<String, String>> _banksList = [];
  bool _isLoadingBanks = false;
  String? _banksError;

  @override
  void initState() {
    super.initState();
    _loadBanks();
  }

  Future<void> _loadBanks() async {
    setState(() {
      _isLoadingBanks = true;
      _banksError = null;
    });

    try {
      final cubit = context.read<AccountVerificationCubit>();
      final banks = await cubit.getSupportedBanks(country: 'NG');
      if (mounted) {
        setState(() {
          _banksList = banks;
          _isLoadingBanks = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _banksError = e.toString();
          _isLoadingBanks = false;
        });
      }
    }
  }

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
    return BlocListener<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, verificationState) {
        setState(() {
          _isVerifying = verificationState is AccountVerificationLoading;
        });

        if (verificationState is AccountVerificationSuccess) {
          // Store verification result
          _verificationResult = AccountVerificationResult(
            accountNumber: verificationState.accountNumber,
            accountName: verificationState.accountName,
            bankName: verificationState.bankName,
            bankCode: verificationState.bankCode,
            verificationStatus: verificationState.verificationStatus,
          );

          // Show confirmation bottomsheet
          _showAccountConfirmationBottomSheet(_verificationResult!);
        } else if (verificationState is AccountVerificationFailure) {
          // Show error snackbar
          Get.snackbar(
            'Verification Failed',
            verificationState.userMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: verificationState.canRetry
                ? Colors.orange.withOpacity(0.8)
                : Colors.red.withOpacity(0.8),
            colorText: Colors.white,
            duration: Duration(seconds: 4),
            mainButton: verificationState.canRetry
                ? TextButton(
                    onPressed: () {
                      Get.back();
                      _handleVerifyAccount();
                    },
                    child: Text('Retry', style: TextStyle(color: Colors.white)),
                  )
                : null,
          );
        }
      },
      child: BlocConsumer<RecipientCubit, RecipientState>(
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
    ),
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
          'Enter account number and we\'ll verify the account holder name',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),

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
        SizedBox(height: 16.h),

        // Account Number Field (10 digits for Nigerian accounts)
        Column(
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
            TextField(
              controller: _accountController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: 'Enter 10-digit account number',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.numbers_outlined, color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 78, 3, 208),
                    width: 2,
                  ),
                ),
                counterText: '',
                suffixIcon: _accountController.text.length == 10
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                setState(() {
                  // Reset verification when account number changes
                  if (_verificationResult != null) {
                    _verificationResult = null;
                  }
                }); // Refresh for check icon
              },
            ),
          ],
        ),
        // Show verification result if successful
        if (_verificationResult != null) ...[
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Verified',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _verificationResult!.accountName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
          'Search and add recipients by their LazerVault username',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // Username Search Field - Tappable to open search bottom sheet
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
            GestureDetector(
              onTap: _showUsernameSearchSheet,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _selectedUser != null
                        ? const Color.fromARGB(255, 78, 3, 208)
                        : Colors.grey[200]!,
                    width: _selectedUser != null ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: _selectedUser != null
                          ? const Color.fromARGB(255, 78, 3, 208)
                          : Colors.grey[600],
                      size: 22.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _selectedUser != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedUser!.fullName,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  '@${_selectedUser!.username}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 78, 3, 208),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Tap to search for username',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16.sp,
                              ),
                            ),
                    ),
                    if (_selectedUser != null)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedUser = null;
                            _usernameController.clear();
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                          size: 20.sp,
                        ),
                      )
                    else
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey[400],
                        size: 24.sp,
                      ),
                  ],
                ),
              ),
            ),
          ],
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
                  'Search for LazerVault users by username. Selected users will be automatically verified.',
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

  /// Show the username search bottom sheet
  void _showUsernameSearchSheet() async {
    final selectedUser = await UsernameSearchBottomSheet.show(context);
    if (selectedUser != null) {
      setState(() {
        _selectedUser = selectedUser;
        // Store just the username without @ - will add single @ when sending to backend
        _usernameController.text = selectedUser.username;
      });
    }
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
    final isLoading = state is RecipientLoading || _isVerifying;

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
      onPressed: isLoading ? null : _handleAddRecipient,
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  _isVerifying ? 'Verifying...' : 'Processing...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
        // Show "Verify Recipient" if verification hasn't been done yet
        if (_verificationResult == null) {
          return 'Verify Recipient';
        }
        return 'Proceed to Payment';
      case AddRecipientMethod.username:
        return 'Add Recipient';
      case AddRecipientMethod.contacts:
        return 'Browse Contacts';
    }
  }

  void _handleAddRecipient() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        // If verification hasn't been done yet, verify first
        if (_verificationResult == null) {
          _handleVerifyAccount();
        } else {
          // Verification already done, proceed to payment
          _proceedToPayment(_verificationResult!, _isFavorite);
        }
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
    // Check if a user was selected from search
    if (_selectedUser == null) {
      Get.snackbar(
        'No User Selected',
        'Please search and select a user first',
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

      // Create username with single @ prefix for backend
      final usernameForBackend = '@${_selectedUser!.username}';

      context.read<RecipientCubit>().addRecipient(
        recipient: RecipientModel(
          id: _selectedUser!.userId,
          name: _selectedUser!.fullName,
          accountNumber: usernameForBackend, // Username with single @ for backend
          bankName: 'LazerVault',
          sortCode: '',
          isFavorite: false,
          countryCode: countryCode,
          email: _selectedUser!.email.isNotEmpty ? _selectedUser!.email : null,
        ),
        accessToken: accessToken,
      );
    }
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
                    if (_isLoadingBanks) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Color.fromARGB(255, 78, 3, 208),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Loading banks...',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (_banksError != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: Colors.red[400],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Failed to load banks',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed: _loadBanks,
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    final filteredBanks = _bankSearchQuery.isEmpty
                        ? _banksList
                        : _banksList.where((bank) =>
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
                              _selectedBankCode = bank["code"]; // Store bank code for verification
                              // Reset verification when bank changes
                              _verificationResult = null;
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

  // ========== New Account Verification Methods ==========

  /// Handle account verification via Paystack API
  Future<void> _handleVerifyAccount() async {
    final accountNumber = _accountController.text.trim();
    final bankName = _bankController.text;

    // Validate bank selection
    if (bankName == "Select Bank") {
      Get.snackbar(
        'Bank Required',
        'Please select a bank first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Validate account number
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

    // Validate 10 digits for Nigerian accounts
    if (accountNumber.length != 10 || !RegExp(r'^\d+$').hasMatch(accountNumber)) {
      Get.snackbar(
        'Invalid Account Number',
        'Account number must be exactly 10 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (_selectedBankCode == null) {
      Get.snackbar(
        'Error',
        'Bank code not found. Please reselect the bank.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Call verification cubit
    await context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: accountNumber,
          bankName: bankName,
        );
  }

  /// Show account confirmation bottomsheet after successful verification
  void _showAccountConfirmationBottomSheet(AccountVerificationResult result) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return AccountConfirmationBottomSheet(
          accountNumber: result.accountNumber,
          accountName: result.accountName,
          bankName: result.bankName,
          bankCode: result.bankCode,
          onConfirm: () {
            // Get favorite status from bottomsheet
            final bottomSheet = context.findAncestorStateOfType<AccountConfirmationBottomSheetState>();
            final isFavorite = bottomSheet?.isFavorite ?? false;

            // Close bottomsheet
            Navigator.pop(context);

            // Proceed to payment WITHOUT saving to DB (Lemfi-style)
            _proceedToPayment(result, isFavorite);
          },
          onCancel: () {
            // Close bottomsheet and reset verification
            Navigator.pop(context);
            setState(() {
              _verificationResult = null;
            });
          },
        );
      },
    );
  }

  /// Proceed to payment screen without saving recipient to database
  /// (Lemfi-style: only save after successful payment if favorited)
  void _proceedToPayment(AccountVerificationResult result, bool isFavorite) {
    // Create temporary recipient model (not saved to DB yet)
    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      name: result.accountName,
      accountNumber: result.accountNumber,
      bankName: result.bankName,
      sortCode: result.bankCode, // Use bank code as sort code for Nigerian banks
      isFavorite: isFavorite,
      countryCode: 'NG',
      currency: 'NGN',
    );

    // Navigate to payment screen with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: temporaryRecipient,
    );
  }
}
