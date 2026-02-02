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
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_verification_result.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_chips_builder.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipients.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/scan_bank_details_modal.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

class SelectRecipients extends StatefulWidget {
  const SelectRecipients({super.key});

  @override
  State<SelectRecipients> createState() => _SelectRecipientsState();
}

class _SelectRecipientsState extends State<SelectRecipients> {
  // Contact bank verification state
  List<Map<String, String>> _banksList = [];
  bool _isLoadingBanks = false;
  String? _banksError;
  String? _contactSelectedBankCode;
  String? _contactSelectedBankName;
  AccountVerificationResult? _contactVerificationResult;

  // Current country for bank selection (from locale)
  String _currentCountry = 'NG';

  String? _getAccessTokenFromState(AuthenticationState authState) {
    if (authState is AuthenticationSuccess) {
      return authState.profile.session.accessToken;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    // Check initial authentication state
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken != null) {
      // If already authenticated, fetch recipients immediately
      context.read<RecipientCubit>().getRecipients(accessToken: accessToken);
    }
    // The listener below will handle cases where auth happens later.
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        // Handle side-effects based on Authentication state
        final accessToken = _getAccessTokenFromState(authState);
        if (accessToken == null) {
          Get.snackbar('Authentication Error', 'You need to be logged in.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.7),
              colorText: Colors.white);
        } else {
          // authState is AuthenticationSuccess
          // Trigger fetch if needed (handles auth happening while screen is visible)
          final recipientState = context.read<RecipientCubit>().state;
          if (recipientState is RecipientInitial) {
            // Pass the retrieved token
            context
                .read<RecipientCubit>()
                .getRecipients(accessToken: accessToken);
          }
        }
      },
      builder: (context, authState) {
        // Build UI based on Authentication state
        // Check if token exists in builder as well for robustness
        final currentToken = _getAccessTokenFromState(authState);
        if (currentToken != null) {
          // User is authenticated, show the recipient UI
          return BlocConsumer<RecipientCubit, RecipientState>(
            listener: (context, recipientState) {
              // Add listener for RecipientState changes if needed
            },
            builder: (context, recipientState) {
              // Build UI based on Recipient state
              return Stack(children: [
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with Back Button
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.offAllNamed(AppRoutes.dashboard),
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Select Recipient',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            ServiceVoiceButton(
                              serviceName: 'transfers',
                              iconColor: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        // Search Bar
                        GestureDetector(
                          onTap: _showEnhancedRecipientSelection,
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(24),
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
                                Icon(
                                  Icons.search,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  size: 20,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    'Search recipients...',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Content Section
                Container(
                  margin: EdgeInsets.only(top: Get.height * 0.22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      // Quick Actions Strip
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[100]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildQuickAction(
                              icon: Icons.qr_code_scanner_outlined,
                              label: 'Scan QR',
                              onTap: _launchQRScanner,
                            ),
                            _buildQuickAction(
                              icon: Icons.person_add_outlined,
                              label: 'Add User',
                              onTap: () => Get.toNamed(AppRoutes.addRecipient),
                            ),
                            _buildQuickAction(
                              icon: Icons.document_scanner_outlined,
                              label: 'Scan Bank Details',
                              onTap: _launchBankDetailsScan,
                            ),
                            _buildQuickAction(
                              icon: Icons.group_outlined,
                              label: 'Split Bills',
                              onTap: _launchSplitBills,
                            ),
                          ],
                        ),
                      ),

                      // Recipients List Section
                      Expanded(
                        child: _buildRecipientsList(recipientState),
                      ),
                    ],
                  ),
                ),
              ]);
            },
          );
        } else {
          // User is not authenticated, show placeholder/loading
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Waiting for authentication..."),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildRecipientsList(RecipientState state) {
    // Handle Initial State explicitly
    if (state is RecipientInitial) {
      // Show nothing or a specific initialization message before loading starts
      return const Center(child: Text('Initializing recipient list...'));
    }

    if (state is RecipientLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is RecipientError) {
      // Handle specific auth error from RecipientCubit
      if (state.message == 'User not authenticated') {
        return Center(
          child: Text(
            'Authentication error. Please login again.',
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
          ),
        );
      } else {
        // Display general recipient errors
        return Center(
          child: Text(
            'Error loading recipients: ${state.message}', // Add context to error
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
            textAlign: TextAlign.center, // Center align error text
          ),
        );
      }
    }

    if (state is RecipientLoaded) {
      // Show all recipients, with favorites at the top
      final allRecipients = state.recipients.toList();
      final favoriteRecipients = allRecipients
          .where((recipient) => recipient.isFavorite)
          .toList();
      final otherRecipients = allRecipients
          .where((recipient) => !recipient.isFavorite)
          .toList();

      // Handle case where there are no recipients at all
      if (allRecipients.isEmpty) {
        return RefreshIndicator(
          color: const Color.fromARGB(255, 78, 3, 208),
          onRefresh: () async {
            final authState = context.read<AuthenticationCubit>().state;
            if (authState is AuthenticationSuccess) {
              await context.read<RecipientCubit>().getRecipients(
                accessToken: authState.profile.session.accessToken,
              );
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No Saved Recipients',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Add recipients to see them here',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: 200.w,
                        height: 48.h,
                        child: ElevatedButton.icon(
                          onPressed: () => Get.toNamed(AppRoutes.addRecipient),
                          icon: Icon(Icons.person_add, size: 20.sp),
                          label: Text(
                            'Add User',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 78, 3, 208),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }

      // Build the UI displaying all recipients (favorites first)
      return RefreshIndicator(
        color: const Color.fromARGB(255, 78, 3, 208),
        onRefresh: () async {
          final authState = context.read<AuthenticationCubit>().state;
          if (authState is AuthenticationSuccess) {
            await context.read<RecipientCubit>().getRecipients(
              accessToken: authState.profile.session.accessToken,
            );
          }
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Favorites Section
              if (favoriteRecipients.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RecipientChipsBuilder(recipients: favoriteRecipients),
                    ],
                  ),
                ),
              ],
              // All Recipients Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Recipients(recipients: allRecipients),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Fallback for any other unhandled state (should ideally not be reached)
    return const Center(child: Text('An unexpected error occurred.'));
  }

  void _showEnhancedRecipientSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: EnhancedRecipientSelectionBottomSheet(
          onRecipientSelected: (recipient) {
            // Navigate to send funds with selected recipient
            Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
          },
          onLazertagUserSelected: (user) {
            // Convert lazertag user to recipient and navigate
            // Note: currency is not set here - the sender's account currency will be used for the receipt
            final recipient = RecipientModel(
              id: user.id,
              name: user.name,
              accountNumber: user.username,
              bankName: 'LazerVault',
              sortCode: '',
              isFavorite: false,
              // currency: null - sender's account currency will be used (dynamic based on locale)
            );
            Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
          },
          onContactSelected: (contact) {
            // Show dialog to add contact as recipient, then navigate
            _showAddContactAsRecipientDialog(contact);
          },
        ),
      ),
    );
  }

  void _loadBanksIfNeeded() {
    if (_banksList.isNotEmpty || _isLoadingBanks) return;

    // Get country from LocaleManager
    try {
      final localeManager = serviceLocator<LocaleManager>();
      _currentCountry = localeManager.currentCountry;
    } catch (e) {
      _currentCountry = 'NG'; // Default to Nigeria
    }

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

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    // Reset contact verification state
    _contactSelectedBankCode = null;
    _contactSelectedBankName = null;
    _contactVerificationResult = null;

    // Load banks first
    _loadBanksIfNeeded();
    _showContactBankSelectionSheet(contact);
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
                                    _loadBanksIfNeeded();
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
                                        BankLogo(
                                          bankName: bank["name"]!,
                                          bankCode: bank["code"],
                                          country: _currentCountry,
                                          size: 40,
                                          borderRadius: 10,
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
                  _contactVerificationResult = AccountVerificationResult(
                    accountNumber: verificationState.accountNumber,
                    accountName: verificationState.accountName,
                    bankName: verificationState.bankName,
                    bankCode: verificationState.bankCode,
                    verificationStatus: verificationState.verificationStatus,
                  );
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
                          BankLogo(
                            bankName: _contactSelectedBankName ?? '',
                            bankCode: _contactSelectedBankCode,
                            country: _currentCountry,
                            size: 48,
                            borderRadius: 12,
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

                    // Save as Favorite Toggle
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: Colors.amber[700],
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Save to favorites',
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
                            activeThumbColor: Color.fromARGB(255, 78, 3, 208),
                          ),
                        ],
                      ),
                    ),

                    // Alias Input (visible when favorite is toggled)
                    if (isFavorite) ...[
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: TextField(
                          maxLength: 50,
                          decoration: InputDecoration(
                            hintText: 'Set alias (optional)',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            counterText: '',
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (value) {
                            setSheetState(() {
                              alias = value.isEmpty ? null : value;
                            });
                          },
                        ),
                      ),
                    ],

                    Spacer(),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
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
                              _proceedToPaymentWithContact(contact, isFavorite, alias);
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

  void _proceedToPaymentWithContact(DeviceContact contact, bool isFavorite, String? alias) {
    if (_contactVerificationResult == null) return;

    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _contactVerificationResult!.accountName,
      accountNumber: _contactVerificationResult!.accountNumber,
      bankName: _contactVerificationResult!.bankName,
      sortCode: _contactVerificationResult!.bankCode,
      isFavorite: isFavorite,
      alias: alias,
      countryCode: 'NG',
      currency: 'NGN',
    );

    Get.toNamed(AppRoutes.initiateSendFunds, arguments: temporaryRecipient);
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
    if (bankName.isEmpty) return '??';
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

    // Default: first letters of first two words
    final words = bankName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return bankName.substring(0, 2).toUpperCase();
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 78, 3, 208),
              size: 24,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchQRScanner() async {
    try {
      final result = await Get.toNamed(AppRoutes.qrScanner);

      if (result != null && result is Map<String, dynamic>) {
        // QR code scanned successfully - create recipient from scanned data
        final recipient = RecipientModel(
          id: result['recipientId'] ?? '',
          name: result['name'] ?? result['username'] ?? 'Unknown',
          accountNumber: result['username'] ?? '',
          bankName: 'LazerVault',
          sortCode: '',
          isFavorite: false,
        );

        // Navigate to send funds with scanned recipient
        // Include pre-filled amount if from v2 payment QR
        final arguments = <String, dynamic>{'recipient': recipient};
        if (result['amount'] != null) {
          arguments['prefillAmount'] = result['amount'];
          arguments['prefillCurrency'] = result['currency'] ?? 'NGN';
        }
        Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
      }
    } catch (e) {
      Get.snackbar(
        'QR Scanner Error',
        'Failed to open QR scanner: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchScheduledTransfer() async {
    // Show scheduled transfer dialog
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 78, 3, 208),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (!mounted || selectedDate == null) return;

    // Show time picker
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 78, 3, 208),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (!mounted || selectedTime == null) return;

    // Combine date and time
    final scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Navigate to send funds with scheduled time
    Get.toNamed(
      AppRoutes.initiateSendFunds,
      arguments: {'scheduledAt': scheduledDateTime},
    );
  }

  Future<void> _launchBankDetailsScan() async {
    // Step 1: Capture image from camera
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 2048,
      maxHeight: 2048,
      imageQuality: 85,
    );

    if (image == null) return; // User cancelled
    if (!mounted) return;

    // Step 2: Show processing bottom sheet immediately
    _showScanProcessingSheet();
    // Allow the bottom sheet to render before starting network call
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      // Step 3: Get user ID from auth state
      final authState = context.read<AuthenticationCubit>().state;
      final userId = (authState is AuthenticationSuccess)
          ? authState.profile.user.id
          : '';

      // Step 4: Call OCR endpoint
      final gatewayUrl = dotenv.env['CHAT_GATEWAY_URL'] ?? 'http://10.0.2.2:3011';
      final dataSource = BankScanDataSource(baseUrl: gatewayUrl);

      final result = await dataSource.scanBankDetails(
        imageFile: File(image.path),
        userId: userId,
        locale: 'en-$_currentCountry',
      );

      dataSource.dispose();

      // Dismiss processing sheet
      if (Get.isBottomSheetOpen ?? false) Get.back();

      if (!mounted) return;

      // Step 5: Show extracted details modal for review + verification
      final verified = await ScanBankDetailsModal.show(
        context,
        scanResult: result,
        country: _currentCountry,
      );

      if (verified != null) {
        // Step 6: Navigate to send funds with verified account
        Get.toNamed(
          AppRoutes.initiateSendFunds,
          arguments: {
            'accountNumber': verified['accountNumber'],
            'accountName': verified['accountName'],
            'bankName': verified['bankName'],
            'bankCode': verified['bankCode'],
            'source': 'ocr_scan',
          },
        );
      }
    } on BankScanLowConfidenceException catch (e) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
      _showScanErrorSheet('Low Quality Image', e.message, isWarning: true);
    } on BankScanException catch (e) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
      _showScanErrorSheet('Scan Failed', e.message);
    } catch (e) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
      _showScanErrorSheet('Error', 'Something went wrong. Please try again.\n${e.toString()}');
    }
  }

  void _showScanProcessingSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SizedBox(
                  width: 36.w,
                  height: 36.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation(Color(0xFF4E03D0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Scanning Bank Details',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Extracting account information from the image...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 16.h),
            LinearProgressIndicator(
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4E03D0)),
              minHeight: 3.h,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void _showScanErrorSheet(String title, String message, {bool isWarning = false}) {
    final color = isWarning ? Colors.orange : Colors.red;
    final icon = isWarning ? Icons.warning_amber_rounded : Icons.error_outline;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 36.sp),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _launchBankDetailsScan();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _launchSplitBills() async {
    Get.toNamed(AppRoutes.splitBills);
  }
}
