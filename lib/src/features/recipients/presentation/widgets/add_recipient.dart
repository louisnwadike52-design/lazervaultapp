import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/contact_service.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_verification_result.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/account_confirmation_bottom_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_recipient_confirmation_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/features/contacts/presentation/cubit/contact_sync_cubit.dart';
import 'package:lazervault/src/features/contacts/presentation/cubit/contact_sync_state.dart';
import 'package:lazervault/src/features/contacts/data/models/lazervault_user_match_model.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final bool _isPersonal = true; // Personal or Business account
  final bool _isFavorite = false;
  String _bankSearchQuery = '';

  // Username Form Controller
  final TextEditingController _usernameController = TextEditingController();

  // Selected user from username search
  UserSearchResultEntity? _selectedUser;

  // Account verification state
  AccountVerificationResult? _verificationResult;
  bool _isVerifying = false;
  String? _selectedBankCode;

  // Banks list - fetched dynamically from backend with local fallback
  List<Map<String, String>> _banksList = [];
  bool _isLoadingBanks = false;
  String? _banksError;

  // Current country for bank selection (from locale)
  String _currentCountry = 'NG';

  @override
  void initState() {
    super.initState();
    _initializeCountryAndLoadBanks();
  }

  Future<void> _initializeCountryAndLoadBanks() async {
    // Get country from LocaleManager
    try {
      final localeManager = serviceLocator<LocaleManager>();
      _currentCountry = localeManager.currentCountry;
    } catch (e) {
      _currentCountry = 'NG'; // Default to Nigeria
    }
    _loadBanks();
  }

  void _loadBanks() {
    setState(() {
      _isLoadingBanks = true;
      _banksError = null;
    });

    // Use local banks data only - no API calls
    if (mounted) {
      setState(() {
        _banksList = BanksData.getBanksForCountry(_currentCountry);
        _isLoadingBanks = false;
        _banksError = null;
      });
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
          // Store verification result with bank name from Paystack
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
          if (verificationState.isRateLimitError) {
            // Rate limit hit — show manual entry bottom sheet
            _showManualAccountNameBottomSheet();
          } else {
            // Show error snackbar
            Get.snackbar(
              'Verification Failed',
              verificationState.userMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: verificationState.canRetry
                  ? Colors.orange.withValues(alpha: 0.8)
                  : Colors.red.withValues(alpha: 0.8),
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
        }
      },
      child: BlocConsumer<RecipientCubit, RecipientState>(
        listener: (context, state) {
          if (state is RecipientError) {
            Get.snackbar(
              'Error',
              state.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
          } else if (state is RecipientSuccess) {
            Get.snackbar(
              'Success',
              state.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withValues(alpha: 0.8),
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
                          color: Colors.white.withValues(alpha: 0.8),
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
            ? Colors.white.withValues(alpha: 0.2) 
            : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
              ? Colors.white.withValues(alpha: 0.4) 
              : Colors.white.withValues(alpha: 0.2),
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
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: _bankController.text == "Select Bank"
                      ? Colors.grey[50]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _bankController.text == "Select Bank"
                        ? Colors.grey[200]!
                        : Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                    width: _bankController.text == "Select Bank" ? 1 : 2,
                  ),
                  boxShadow: _bankController.text != "Select Bank"
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    // Bank Logo or Default Icon
                    if (_bankController.text == "Select Bank")
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.account_balance,
                          color: Colors.grey[500],
                          size: 22.sp,
                        ),
                      )
                    else
                      BankLogo(
                        bankName: _bankController.text,
                        bankCode: _selectedBankCode,
                        country: _currentCountry,
                        size: 44,
                        borderRadius: 10,
                      ),
                    SizedBox(width: 12.w),
                    // Bank Name and Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _bankController.text,
                            style: TextStyle(
                              color: _bankController.text == "Select Bank"
                                  ? Colors.grey[600]
                                  : Colors.black87,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (_bankController.text != "Select Bank") ...[
                            SizedBox(height: 2.h),
                            Text(
                              _getBankDescription(_bankController.text),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Change/Select indicator
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _bankController.text == "Select Bank"
                            ? Colors.grey[100]
                            : Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        _bankController.text == "Select Bank" ? 'Select' : 'Change',
                        style: TextStyle(
                          color: _bankController.text == "Select Bank"
                              ? Colors.grey[600]
                              : Color.fromARGB(255, 78, 3, 208),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
              color: Colors.green.withValues(alpha: 0.1),
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

  /// Fetch the recipient's personal account number by user ID
  Future<String?> _fetchRecipientAccountNumber(String userId) async {
    try {
      final accountsClient = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final callOptions = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final request = accounts_pb.GetUserAccountsRequest()
        ..targetUserId = userId;
      final response = await accountsClient.getUserAccounts(request, options: callOptions);
      // Find the personal account (first account or account_type == 'personal')
      for (final account in response.accounts) {
        if (account.accountType == 'personal' || account.accountType == '') {
          final acctNum = account.accountNumber.isNotEmpty
              ? account.accountNumber
              : account.maskedAccountNumber;
          if (acctNum.isNotEmpty) return acctNum;
        }
      }
      // Fallback: return first account's number
      if (response.accounts.isNotEmpty) {
        final first = response.accounts.first;
        return first.accountNumber.isNotEmpty
            ? first.accountNumber
            : first.maskedAccountNumber;
      }
      return null;
    } catch (e) {
      print('[AddRecipient] Error fetching recipient account: $e');
      return null;
    }
  }

  /// Show the username search bottom sheet, then confirmation sheet
  /// After confirming, proceed directly to the payment/amount screen
  void _showUsernameSearchSheet() async {
    final selectedUser = await UsernameSearchBottomSheet.show(context);
    if (!mounted) return;
    if (selectedUser == null) return;

    // Fetch the recipient's personal account number
    final accountNumber = await _fetchRecipientAccountNumber(selectedUser.userId);

    if (!mounted) return;

    // Show confirmation bottom sheet
    bool confirmed = false;
    bool isSaved = false;
    bool isFavorite = false;
    String? alias;

    await Get.bottomSheet(
      PopScope(
        canPop: true,
        child: StatefulBuilder(
          builder: (context, setSheetState) {
            return UsernameRecipientConfirmationSheet(
              user: selectedUser,
              accountNumber: accountNumber,
              onConfirm: () {
                setSheetState(() {
                  confirmed = true;
                  // Get the save/favorite/alias state from the sheet before closing
                  final sheetState = context
                      .findAncestorStateOfType<
                          UsernameRecipientConfirmationSheetState>();
                  if (sheetState != null) {
                    isSaved = sheetState.isSaved;
                    isFavorite = sheetState.isFavorite;
                    alias = sheetState.alias;
                  }
                });
                Get.back();
              },
              onCancel: () {
                Get.back();
              },
            );
          },
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );

    if (!mounted) return;
    if (confirmed) {
      // Proceed directly to payment screen after confirmation
      _proceedToPaymentWithUsernameRecipient(selectedUser, accountNumber, isSaved, isFavorite, alias);
    }
  }

  /// Proceed directly to payment screen with username recipient
  /// without showing them on the form first
  void _proceedToPaymentWithUsernameRecipient(
      UserSearchResultEntity selectedUser,
      String? accountNumber,
      bool isSaved,
      bool isFavorite,
      String? alias) {
    // Get active country from profile preferences
    String? countryCode;
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      countryCode = profileState.preferences.activeCountry.isNotEmpty
          ? profileState.preferences.activeCountry
          : null;
    }

    // Create temporary recipient model — do NOT save to backend yet.
    // Recipient will be saved after successful transfer + PIN verification.
    final recipient = RecipientModel(
      id: selectedUser.userId,
      name: selectedUser.fullName,
      accountNumber: accountNumber ?? '@${selectedUser.username}',
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: isFavorite,
      isSaved: isSaved,
      alias: alias,
      countryCode: countryCode,
      currency: CountryConfigs.getByCode(countryCode ?? 'NG')?.currency ?? 'NGN',
      email: selectedUser.email.isNotEmpty ? selectedUser.email : null,
    );

    // Navigate directly to send funds with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: {
        'recipient': recipient,
        'isTemporary': true,
        'shouldSaveOnSuccess': isSaved || isFavorite, // Save if user chose to save or favorite
      },
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
                Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                Color.fromARGB(255, 95, 20, 225).withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
          _proceedToPayment(_verificationResult!, false, _isFavorite, null);
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

  void _addUsernameRecipient() {
    // Check if a user was selected from search
    if (_selectedUser == null) {
      Get.snackbar(
        'No User Selected',
        'Please search and select a user first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Get active country from profile preferences
    String? countryCode;
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      countryCode = profileState.preferences.activeCountry.isNotEmpty
          ? profileState.preferences.activeCountry
          : null;
    }

    // Create temporary recipient model — do NOT save to backend yet.
    // Recipient will be saved after successful transfer + PIN verification.
    final recipient = RecipientModel(
      id: _selectedUser!.userId,
      name: _selectedUser!.fullName,
      accountNumber: '@${_selectedUser!.username}',
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      countryCode: countryCode,
      currency: CountryConfigs.getByCode(countryCode ?? 'NG')?.currency ?? 'NGN',
      email: _selectedUser!.email.isNotEmpty ? _selectedUser!.email : null,
    );

    // Navigate directly to send funds with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: {
        'recipient': recipient,
        'isTemporary': true,
        'shouldSaveOnSuccess': true,
      },
    );
  }

  void _showContactSelection() {
    final contactService = serviceLocator<ContactService>();
    Timer? searchDebounce;

    // State variables hoisted outside StatefulBuilder so they persist across rebuilds
    List<DeviceContact> allContacts = [];
    List<DeviceContact> filteredContacts = [];
    String searchQuery = '';
    bool isLoading = true;
    bool permissionDenied = false;
    bool permissionPermanentlyDenied = false;
    String? errorMessage;
    bool initialLoadTriggered = false;
    final searchController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            void loadContacts() {
              setSheetState(() {
                isLoading = true;
                permissionDenied = false;
                permissionPermanentlyDenied = false;
                errorMessage = null;
              });

              _loadContactsForSheet(
                contactService: contactService,
                onContactsLoaded: (contacts) {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      allContacts = contacts;
                      filteredContacts = contacts;
                      searchQuery = '';
                      searchController.clear();
                      isLoading = false;
                    });
                  }
                },
                onPermissionDenied: () {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      isLoading = false;
                      permissionDenied = true;
                    });
                  }
                },
                onPermissionPermanentlyDenied: () {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      isLoading = false;
                      permissionPermanentlyDenied = true;
                    });
                  }
                },
                onError: (message) {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      isLoading = false;
                      errorMessage = message;
                    });
                  }
                },
              );
            }

            // Trigger initial load once
            if (!initialLoadTriggered) {
              initialLoadTriggered = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                loadContacts();
              });
            }

            return _buildContactSheetContent(
              allContacts: allContacts,
              filteredContacts: filteredContacts,
              searchQuery: searchQuery,
              isLoading: isLoading,
              permissionDenied: permissionDenied,
              permissionPermanentlyDenied: permissionPermanentlyDenied,
              errorMessage: errorMessage,
              contactService: contactService,
              searchController: searchController,
              onRetry: loadContacts,
              onSearchChanged: (query) {
                searchDebounce?.cancel();
                searchDebounce = Timer(const Duration(milliseconds: 300), () {
                  final filtered = query.isEmpty
                      ? allContacts
                      : allContacts.where((c) => c.matchesQuery(query)).toList();
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      searchQuery = query;
                      filteredContacts = filtered;
                    });
                  }
                });
              },
              onContactTap: (contact) {
                searchDebounce?.cancel();
                Navigator.pop(bottomSheetContext);
                _showAddContactAsRecipientDialog(contact);
              },
            );
          },
        );
      },
    ).whenComplete(() {
      searchDebounce?.cancel();
      searchController.dispose();
    });
  }

  Future<void> _loadContactsForSheet({
    required ContactService contactService,
    required void Function(List<DeviceContact>) onContactsLoaded,
    required VoidCallback onPermissionDenied,
    required VoidCallback onPermissionPermanentlyDenied,
    required void Function(String) onError,
  }) async {
    try {
      final status = await contactService.getPermissionStatus();

      if (status.isPermanentlyDenied) {
        onPermissionPermanentlyDenied();
        return;
      }

      if (!status.isGranted) {
        final granted = await contactService.requestPermission();
        if (!granted) {
          // Check again to distinguish permanent denial
          final newStatus = await contactService.getPermissionStatus();
          if (newStatus.isPermanentlyDenied) {
            onPermissionPermanentlyDenied();
          } else {
            onPermissionDenied();
          }
          return;
        }
      }

      final contacts = await contactService.getContactsWithPhone();
      onContactsLoaded(contacts);
    } catch (e) {
      debugPrint('Error loading contacts: $e');
      onError('Failed to load contacts. Please try again.');
    }
  }

  Widget _buildContactSheetContent({
    required List<DeviceContact> allContacts,
    required List<DeviceContact> filteredContacts,
    required String searchQuery,
    required bool isLoading,
    required bool permissionDenied,
    required bool permissionPermanentlyDenied,
    required String? errorMessage,
    required ContactService contactService,
    required TextEditingController searchController,
    required VoidCallback onRetry,
    required void Function(String) onSearchChanged,
    required void Function(DeviceContact) onContactTap,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Row(
              children: [
                Text(
                  'Device Contacts',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                if (!isLoading && !permissionDenied && !permissionPermanentlyDenied && errorMessage == null)
                  Text(
                    searchQuery.isEmpty
                        ? '${allContacts.length} contacts'
                        : '${filteredContacts.length} results',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),

          // Search bar (only when contacts loaded)
          if (!isLoading && !permissionDenied && !permissionPermanentlyDenied && errorMessage == null && allContacts.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Search by name or phone number',
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[400], size: 18.sp),
                          onPressed: () {
                            searchController.clear();
                            onSearchChanged('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
            ),

          Divider(height: 1, color: Colors.grey[200]),

          // Content area
          Expanded(
            child: _buildContactSheetBody(
              filteredContacts: filteredContacts,
              searchQuery: searchQuery,
              isLoading: isLoading,
              permissionDenied: permissionDenied,
              permissionPermanentlyDenied: permissionPermanentlyDenied,
              errorMessage: errorMessage,
              contactService: contactService,
              allContactsEmpty: allContacts.isEmpty,
              onRetry: onRetry,
              onContactTap: onContactTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSheetBody({
    required List<DeviceContact> filteredContacts,
    required String searchQuery,
    required bool isLoading,
    required bool permissionDenied,
    required bool permissionPermanentlyDenied,
    required String? errorMessage,
    required ContactService contactService,
    required bool allContactsEmpty,
    required VoidCallback onRetry,
    required void Function(DeviceContact) onContactTap,
  }) {
    // Loading state
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color.fromARGB(255, 78, 3, 208),
            ),
            SizedBox(height: 16.h),
            Text(
              'Loading contacts...',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // Permission denied
    if (permissionDenied) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.contacts, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'Contacts Access Required',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'LazerVault needs access to your contacts to find people you can send money to.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.lock_open, size: 18.sp),
                label: const Text('Grant Permission'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Permission permanently denied
    if (permissionPermanentlyDenied) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.settings, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'Permission Required',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Contacts permission was denied. Please enable it in your device settings to browse contacts.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: () => contactService.openSettings(),
                icon: Icon(Icons.settings, size: 18.sp),
                label: const Text('Open Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Error state
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48.sp, color: Colors.red[300]),
              SizedBox(height: 16.h),
              Text(
                errorMessage,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, size: 18.sp),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Empty contacts
    if (allContactsEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_off, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'No Contacts Found',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'No contacts with phone numbers were found on your device.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Search no results
    if (filteredContacts.isEmpty && searchQuery.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'No Results',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'No contacts match "$searchQuery"',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Contact list
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return _buildContactListItem(contact: contact, onTap: onContactTap);
      },
    );
  }

  Widget _buildContactListItem({
    required DeviceContact contact,
    required void Function(DeviceContact) onTap,
  }) {
    return InkWell(
      onTap: () => onTap(contact),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Row(
          children: [
            // Avatar with initials
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 78, 3, 208),
                    Color.fromARGB(255, 120, 40, 240),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  contact.initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            // Name and phone
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (contact.phoneNumber != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      contact.phoneNumber!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[500],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
          ],
        ),
      ),
    );
  }

  // Contact bank verification state
  String? _contactSelectedBankCode;
  String? _contactSelectedBankName;
  AccountVerificationResult? _contactVerificationResult;

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    // Reset contact verification state
    _contactSelectedBankCode = null;
    _contactSelectedBankName = null;
    _contactVerificationResult = null;

    // First check if contact is a LazerVault user by phone number
    _checkIfLazerVaultUser(contact);
  }

  /// Check if contact is a LazerVault user via phone number lookup
  Future<void> _checkIfLazerVaultUser(DeviceContact contact) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Color.fromARGB(255, 78, 3, 208),
              ),
              SizedBox(height: 16.h),
              Text(
                'Checking if ${contact.name} is on LazerVault...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final contactSyncCubit = context.read<ContactSyncCubit>();

      // Extract phone numbers from contact
      final phoneNumbers = contact.phoneNumbers.isNotEmpty
          ? contact.phoneNumbers
          : contact.phoneNumber != null ? [contact.phoneNumber!] : <String>[];

      // Extract emails
      final emails = contact.emails.isNotEmpty
          ? contact.emails
          : contact.email != null ? [contact.email!] : <String>[];

      if (phoneNumbers.isEmpty && emails.isEmpty) {
        // No contact info to lookup, show bank selection
        Navigator.pop(context); // Close loading dialog
        _showContactBankSelectionSheet(contact);
        return;
      }

      // Find LazerVault user by phone/email
      await contactSyncCubit.findLazerVaultUsers(
        phoneNumbers: phoneNumbers,
        emails: emails,
      );

      // Check result
      final state = contactSyncCubit.state;
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog

      if (state is ContactSyncUsersFound && state.matchedUsers.isNotEmpty) {
        // Found a LazerVault user - show confirmation and proceed
        final matchedUser = state.matchedUsers.first;
        _showLazerVaultUserFoundDialog(contact, matchedUser);
      } else {
        // Not a LazerVault user - show bank selection
        _showContactBankSelectionSheet(contact);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog
      debugPrint('Error checking LazerVault user: $e');
      // On error, fallback to bank selection
      _showContactBankSelectionSheet(contact);
    }
  }

  /// Show dialog when contact is found to be a LazerVault user
  void _showLazerVaultUserFoundDialog(DeviceContact contact, LazerVaultUserMatchModel matchedUser) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                margin: EdgeInsets.only(bottom: 24.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Success Icon
              Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 78, 3, 208),
                      Color.fromARGB(255, 95, 20, 225),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 36.sp,
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                '${contact.name} is on LazerVault!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),

              Text(
                'You can send money instantly to their personal account',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),

              // User Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: matchedUser.profilePhotoUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                matchedUser.profilePhotoUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Text(
                                    matchedUser.name.isNotEmpty
                                        ? matchedUser.name.substring(0, 1).toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 78, 3, 208),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                matchedUser.name.isNotEmpty
                                    ? matchedUser.name.substring(0, 1).toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 78, 3, 208),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                matchedUser.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              if (matchedUser.isVerified) ...[
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 16.sp,
                                ),
                              ],
                            ],
                          ),
                          if (matchedUser.username.isNotEmpty)
                            Text(
                              '@${matchedUser.username}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color.fromARGB(255, 78, 3, 208),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  // Use Different Bank Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                        _showContactBankSelectionSheet(contact);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'Use Bank',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Send to LazerVault Button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                        _proceedWithLazerVaultUser(contact, matchedUser);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 78, 3, 208),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Send to LazerVault',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(bottomSheetContext).padding.bottom + 16.h),
            ],
          ),
        );
      },
    );
  }

  /// Proceed to payment with LazerVault user
  void _proceedWithLazerVaultUser(DeviceContact contact, LazerVaultUserMatchModel matchedUser) {
    final authState = context.read<AuthenticationCubit>().state;
    final profileState = context.read<ProfileCubit>().state;

    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Error',
        'Please log in to continue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    final accessToken = authState.profile.session.accessToken;
    final countryCode = profileState is ProfileLoaded
        ? profileState.preferences.activeCountry
        : 'NG';

    // Create recipient with LazerVault details
    final recipient = RecipientModel(
      id: matchedUser.userId,
      name: matchedUser.name,
      accountNumber: '@${matchedUser.username}', // Use username as account identifier
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      countryCode: countryCode,
    );

    // Navigate to initiate send funds with recipient data
    Get.toNamed(
      AppRoutes.initiateSendFunds,
      arguments: {
        'recipient': recipient,
        'accessToken': accessToken,
        'isLazerVaultUser': true,
        'lazerVaultUserId': matchedUser.userId,
      },
    );
  }

  /// Step 1: Show bank selection for contact
  void _showContactBankSelectionSheet(DeviceContact contact) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final searchController = TextEditingController();
            String searchQuery = '';

            return Container(
              height: MediaQuery.of(context).size.height * 0.80,
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
                        // Contact Avatar
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 78, 3, 208),
                                Color.fromARGB(255, 95, 20, 225),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Text(
                              contact.name.isNotEmpty
                                  ? contact.name.substring(0, 1).toUpperCase()
                                  : '?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Select their bank',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.sp,
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
                      controller: searchController,
                      onChanged: (value) {
                        setSheetState(() {
                          searchQuery = value.toLowerCase();
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
                                  onPressed: () {
                                    _loadBanks();
                                    setSheetState(() {});
                                  },
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        final filteredBanks = searchQuery.isEmpty
                            ? _banksList
                            : _banksList
                                .where((bank) => bank["name"]!
                                    .toLowerCase()
                                    .contains(searchQuery))
                                .toList();

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
                            return Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(bottomSheetContext);
                                    _contactSelectedBankCode = bank["code"];
                                    _contactSelectedBankName = bank["name"];
                                    _showContactAccountNumberSheet(contact);
                                  },
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border:
                                          Border.all(color: Colors.grey[200]!),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: _getBankGradientColors(
                                                  bank["name"]!),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              _getBankInitials(bank["name"]!),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            bank["name"]!,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
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
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Step 2: Show account number entry for contact
  void _showContactAccountNumberSheet(DeviceContact contact) {
    final accountController = TextEditingController();
    bool isVerifying = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return BlocListener<AccountVerificationCubit,
                AccountVerificationState>(
              listener: (context, verificationState) {
                if (verificationState is AccountVerificationLoading) {
                  setSheetState(() {
                    isVerifying = true;
                  });
                } else if (verificationState is AccountVerificationSuccess) {
                  setSheetState(() {
                    isVerifying = false;
                  });
                  // Store verification result
                  _contactVerificationResult = AccountVerificationResult(
                    accountNumber: verificationState.accountNumber,
                    accountName: verificationState.accountName,
                    bankName: verificationState.bankName,
                    bankCode: verificationState.bankCode,
                    verificationStatus: verificationState.verificationStatus,
                  );
                  // Close account number sheet and show confirmation
                  Navigator.pop(bottomSheetContext);
                  _showContactConfirmationSheet(contact);
                } else if (verificationState is AccountVerificationFailure) {
                  setSheetState(() {
                    isVerifying = false;
                  });
                  Get.snackbar(
                    'Verification Failed',
                    verificationState.userMessage,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.withValues(alpha: 0.8),
                    colorText: Colors.white,
                  );
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle Bar
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _getBankGradientColors(
                                    _contactSelectedBankName ?? ''),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              _getBankInitials(_contactSelectedBankName ?? ''),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.name,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  _contactSelectedBankName ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
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
                      SizedBox(height: 32.h),

                      // Account Number Label
                      Text(
                        'Account Number',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Account Number Field
                      TextField(
                        controller: accountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: 'Enter 10-digit account number',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.numbers_outlined,
                              color: Colors.grey[600]),
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
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          setSheetState(() {});
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Enter the 10-digit account number for ${contact.name}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.sp,
                        ),
                      ),

                      Spacer(),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isVerifying ||
                                  accountController.text.length != 10
                              ? null
                              : () {
                                  // Verify account
                                  this
                                      .context
                                      .read<AccountVerificationCubit>()
                                      .verifyAccount(
                                        bankCode: _contactSelectedBankCode!,
                                        accountNumber: accountController.text,
                                        bankName: _contactSelectedBankName!,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 78, 3, 208),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: isVerifying
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
                                      'Verifying...',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Verify Account',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16.h),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Step 3: Show confirmation with verified account name
  void _showContactConfirmationSheet(DeviceContact contact) {
    bool isSaved = false;
    bool isFavorite = false;
    String? alias;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Success Icon
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 48.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Center(
                      child: Text(
                        'Account Verified!',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Account Details Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Account Name',
                            _contactVerificationResult?.accountName ?? '',
                            isHighlighted: true,
                          ),
                          Divider(height: 24.h, color: Colors.grey[200]),
                          _buildDetailRow(
                            'Account Number',
                            _contactVerificationResult?.accountNumber ?? '',
                          ),
                          Divider(height: 24.h, color: Colors.grey[200]),
                          _buildDetailRow(
                            'Bank',
                            _contactVerificationResult?.bankName ?? '',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Save Recipient Toggle
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                color: isSaved ? const Color(0xFF4E03D0) : Colors.grey[600],
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  'Save Recipient',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isSaved,
                                onChanged: (value) {
                                  setSheetState(() {
                                    isSaved = value;
                                    if (!value) isFavorite = false;
                                  });
                                },
                                activeThumbColor: const Color(0xFF4E03D0),
                              ),
                            ],
                          ),
                          if (isSaved) ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  isFavorite ? Icons.star : Icons.star_border,
                                  color: isFavorite ? const Color(0xFFF59E0B) : Colors.grey[600],
                                  size: 24.sp,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    'Add to Favorites',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: isFavorite,
                                  onChanged: (value) {
                                    setSheetState(() {
                                      isFavorite = value;
                                    });
                                  },
                                  activeThumbColor: const Color(0xFFF59E0B),
                                ),
                              ],
                            ),
                          ],
                          // Alias input when saved
                          if (isSaved) ...[
                            SizedBox(height: 12.h),
                            TextField(
                              onChanged: (value) {
                                alias = value.isEmpty ? null : value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Nickname (optional)',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14.sp,
                                ),
                                prefixIcon: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.grey[500],
                                  size: 20.sp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: const BorderSide(color: Color(0xFF4E03D0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    Spacer(),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
                              // Reset state
                              _contactVerificationResult = null;
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
                              // Proceed to payment with verified contact
                              _proceedToPaymentWithContact(
                                  contact, isSaved, isFavorite, alias);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 78, 3, 208),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Proceed to Payment',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 16.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: isHighlighted ? Colors.green[700] : Colors.black87,
              fontSize: isHighlighted ? 16.sp : 14.sp,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  /// Proceed to payment with verified contact
  void _proceedToPaymentWithContact(DeviceContact contact, bool isSaved, bool isFavorite, String? alias) {
    if (_contactVerificationResult == null) return;

    // Create temporary recipient model (not saved to DB yet)
    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _contactVerificationResult!.accountName,
      accountNumber: _contactVerificationResult!.accountNumber,
      bankName: _contactVerificationResult!.bankName,
      sortCode: _contactVerificationResult!.bankCode,
      isFavorite: isFavorite,
      isSaved: isSaved,
      alias: alias,
      countryCode: 'NG',
      currency: 'NGN',
    );

    // Navigate to payment screen with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: temporaryRecipient,
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
                        color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            BanksData.getCountryFlag(_currentCountry),
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _currentCountry,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                                ? Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.05)
                                : Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                                color: isSelected 
                                  ? Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3)
                                  : Colors.grey[200]!,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Bank Logo (with network image fallback to initials)
                                BankLogo(
                                  bankName: bank["name"]!,
                                  bankCode: bank["code"],
                                  country: _currentCountry,
                                  size: 48,
                                  borderRadius: 12,
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
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return [Color(0xFFFF6600), Color(0xFFCC5200)];
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return [Color(0xFFFF6600), Color(0xFFCC4400)];
    if (lowerName.contains('first bank')) return [Color(0xFF003366), Color(0xFF002244)];
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return [Color(0xFFCC0000), Color(0xFF990000)];
    if (lowerName.contains('zenith')) return [Color(0xFFCC0000), Color(0xFF990000)];
    if (lowerName.contains('kuda')) return [Color(0xFF6B47ED), Color(0xFF5533CC)];
    if (lowerName.contains('opay')) return [Color(0xFF00C853), Color(0xFF009624)];
    if (lowerName.contains('palmpay')) return [Color(0xFF6C63FF), Color(0xFF5046E5)];
    if (lowerName.contains('fidelity')) return [Color(0xFF006B3F), Color(0xFF004D2D)];
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return [Color(0xFF6B2D7B), Color(0xFF4A1F55)];
    if (lowerName.contains('sterling')) return [Color(0xFFCC0000), Color(0xFF990000)];
    if (lowerName.contains('stanbic')) return [Color(0xFF0033A1), Color(0xFF002277)];
    if (lowerName.contains('ecobank')) return [Color(0xFF004C91), Color(0xFF003366)];
    if (lowerName.contains('union bank')) return [Color(0xFF003087), Color(0xFF002266)];
    if (lowerName.contains('wema') || lowerName.contains('alat')) return [Color(0xFF6B2D7B), Color(0xFF4A1F55)];
    if (lowerName.contains('polaris')) return [Color(0xFF003399), Color(0xFF002266)];
    if (lowerName.contains('keystone')) return [Color(0xFF0066CC), Color(0xFF004488)];
    if (lowerName.contains('heritage')) return [Color(0xFF006633), Color(0xFF004422)];
    if (lowerName.contains('moniepoint')) return [Color(0xFF0066FF), Color(0xFF0044CC)];
    if (lowerName.contains('carbon')) return [Color(0xFF00C9A7), Color(0xFF00A386)];

    // UK Banks
    if (lowerName.contains('barclays')) return [Color(0xFF0071CE), Color(0xFF004A8F)];
    if (lowerName.contains('hsbc')) return [Color(0xFFDB0011), Color(0xFFB8000E)];
    if (lowerName.contains('lloyds')) return [Color(0xFF006A4E), Color(0xFF004D3A)];
    if (lowerName.contains('natwest')) return [Color(0xFF5D2A8F), Color(0xFF4A1F75)];
    if (lowerName.contains('santander')) return [Color(0xFFEC0000), Color(0xFFD10000)];
    if (lowerName.contains('monzo')) return [Color(0xFFFF5A5F), Color(0xFFE64850)];
    if (lowerName.contains('starling')) return [Color(0xFF6935D3), Color(0xFF5229A8)];
    if (lowerName.contains('revolut')) return [Color(0xFF0073E6), Color(0xFF005BB5)];

    // Default gradient
    return [Color(0xFF78039C), Color(0xFF5F14E1)];
  }

  String _getBankInitials(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return 'AB';
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return 'GT';
    if (lowerName.contains('first bank')) return 'FB';
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return 'UBA';
    if (lowerName.contains('zenith')) return 'ZB';
    if (lowerName.contains('kuda')) return 'KD';
    if (lowerName.contains('opay')) return 'OP';
    if (lowerName.contains('palmpay')) return 'PP';
    if (lowerName.contains('fidelity')) return 'FD';
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return 'FC';
    if (lowerName.contains('sterling')) return 'SB';
    if (lowerName.contains('stanbic')) return 'SI';
    if (lowerName.contains('ecobank')) return 'EB';
    if (lowerName.contains('union bank')) return 'UB';
    if (lowerName.contains('wema')) return 'WB';
    if (lowerName.contains('alat')) return 'AL';
    if (lowerName.contains('polaris')) return 'PB';
    if (lowerName.contains('keystone')) return 'KB';
    if (lowerName.contains('heritage')) return 'HB';
    if (lowerName.contains('moniepoint')) return 'MP';
    if (lowerName.contains('carbon')) return 'CB';

    // UK Banks
    if (lowerName.contains('barclays')) return 'BC';
    if (lowerName.contains('hsbc')) return 'HS';
    if (lowerName.contains('lloyds')) return 'LB';
    if (lowerName.contains('natwest')) return 'NW';
    if (lowerName.contains('santander')) return 'SU';
    if (lowerName.contains('monzo')) return 'MZ';
    if (lowerName.contains('starling')) return 'SL';
    if (lowerName.contains('revolut')) return 'RV';

    // Default: first two characters
    if (bankName.length >= 2) {
      return bankName.substring(0, 2).toUpperCase();
    }
    return bankName.toUpperCase();
  }

  String _getBankDescription(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return 'Personal & Business Banking';
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return 'Digital Banking Leader';
    if (lowerName.contains('first bank')) return 'Nigeria\'s First Bank';
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return 'Africa\'s Global Bank';
    if (lowerName.contains('zenith')) return 'In Your Best Interest';
    if (lowerName.contains('kuda')) return 'Bank of the Free';
    if (lowerName.contains('opay')) return 'Digital Payments';
    if (lowerName.contains('palmpay')) return 'Mobile Money Services';
    if (lowerName.contains('fidelity')) return 'Truly Dependable';
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return 'My Bank and I';
    if (lowerName.contains('sterling')) return 'Your One-Customer Bank';
    if (lowerName.contains('stanbic')) return 'Moving Forward';
    if (lowerName.contains('ecobank')) return 'Pan-African Banking';
    if (lowerName.contains('union bank')) return 'Big. Strong. Reliable';
    if (lowerName.contains('wema') || lowerName.contains('alat')) return 'Digital Banking';
    if (lowerName.contains('moniepoint')) return 'Financial Services';
    if (lowerName.contains('carbon')) return 'Digital Finance';

    // UK Banks
    if (lowerName.contains('barclays')) return 'Personal & Business Banking';
    if (lowerName.contains('hsbc')) return 'Global Banking Services';
    if (lowerName.contains('lloyds')) return 'Everyday Banking Solutions';
    if (lowerName.contains('natwest')) return 'Royal Bank of Scotland Group';
    if (lowerName.contains('santander')) return 'Consumer & Business Banking';
    if (lowerName.contains('monzo')) return 'Smart Money Management';
    if (lowerName.contains('starling')) return 'Digital Banking';
    if (lowerName.contains('revolut')) return 'Financial Super App';

    return 'Banking Services';
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
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
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
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
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
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (_selectedBankCode == null) {
      Get.snackbar(
        'Error',
        'Bank code not found. Please reselect the bank.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
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

  /// Show manual account name entry when auto-verification is unavailable (rate limit)
  void _showManualAccountNameBottomSheet() {
    final nameController = TextEditingController();
    final accountNumber = _accountController.text.trim();
    final bankName = _bankController.text;
    final bankCode = _selectedBankCode ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(sheetContext).size.height * 0.55,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(Icons.edit_note, color: Colors.orange, size: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Account Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Auto-verification temporarily unavailable',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Bank & account info
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bank', style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                            Text(bankName, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Account', style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                            Text(accountNumber, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Name input
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: 'Account holder full name',
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.deepPurple.withValues(alpha: 0.6)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          Get.snackbar('Name Required', 'Please enter the account holder name',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.orange.withValues(alpha: 0.8),
                              colorText: Colors.white);
                          return;
                        }
                        Navigator.pop(sheetContext);

                        // Create result with manually entered name
                        final result = AccountVerificationResult(
                          accountNumber: accountNumber,
                          accountName: name,
                          bankName: bankName,
                          bankCode: bankCode,
                          verificationStatus: 'manual',
                        );
                        _verificationResult = result;
                        _showAccountConfirmationBottomSheet(result);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            // Get save/favorite/alias status from bottomsheet
            final bottomSheet = context.findAncestorStateOfType<AccountConfirmationBottomSheetState>();
            final isSaved = bottomSheet?.isSaved ?? false;
            final isFavorite = bottomSheet?.isFavorite ?? false;
            final alias = bottomSheet?.alias;

            // Close bottomsheet
            Navigator.pop(context);

            // Proceed to payment WITHOUT saving to DB (Lemfi-style)
            _proceedToPayment(result, isSaved, isFavorite, alias);
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
  /// (Lemfi-style: only save after successful payment)
  void _proceedToPayment(AccountVerificationResult result, bool isSaved, bool isFavorite, String? alias) {
    // Create temporary recipient model (not saved to DB yet)
    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      name: result.accountName,
      accountNumber: result.accountNumber,
      bankName: result.bankName,
      sortCode: result.bankCode, // Use bank code as sort code for Nigerian banks
      isFavorite: isFavorite,
      isSaved: isSaved,
      alias: alias,
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
