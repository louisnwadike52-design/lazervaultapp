import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/config/country_config.dart';
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
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_filter_chip_card.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/scan_bank_details_modal.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_transaction_history_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_transaction_history_modal.dart';
import 'dart:io';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/qr_scan_confirmation_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/transfer_history_bottom_sheet.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';

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

  // Filter state for recipients list
  RecipientFilterType _currentFilter = RecipientFilterType.all;

  // Scroll controller for recipients list
  final ScrollController _recipientsScrollController = ScrollController();

  String? _getAccessTokenFromState(AuthenticationState authState) {
    if (authState is AuthenticationSuccess) {
      return authState.profile.session.accessToken;
    }
    return null;
  }

  /// Get initials from name - capitalize first letter of each word
  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}';
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return '??';
  }

  /// Convert to title case (only capitalize first letter of each word)
  String _toTitleCase(String text) {
    return text.trim().split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  void initState() {
    super.initState();
    // Check initial authentication state
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken != null) {
      // If already authenticated, fetch recipients immediately with locale filters
      final localeManager = serviceLocator<LocaleManager>();
      context.read<RecipientCubit>().getRecipients(
        accessToken: accessToken,
        countryCode: localeManager.currentCountry,
        currency: localeManager.currentCurrency,
      );
    }
    // The listener below will handle cases where auth happens later.

    // Add scroll listener for pagination
    _recipientsScrollController.addListener(_onRecipientsScroll);
  }

  @override
  void dispose() {
    _recipientsScrollController.dispose();
    super.dispose();
  }

  void _onRecipientsScroll() {
    if (_recipientsScrollController.position.pixels >=
        _recipientsScrollController.position.maxScrollExtent * 0.8) {
      // Load more when scrolled to 80% of the list
      final recipientState = context.read<RecipientCubit>().state;
      if (recipientState is RecipientLoaded && recipientState.hasMore) {
        final authState = context.read<AuthenticationCubit>().state;
        final accessToken = _getAccessTokenFromState(authState);
        if (accessToken != null) {
          context.read<RecipientCubit>().loadMoreRecipients(accessToken: accessToken);
        }
      }
    }
  }

  /// Handle filter changes from the filter chips
  void _onFilterChanged(RecipientFilterType filterType) {
    setState(() {
      _currentFilter = filterType;
    });

    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = _getAccessTokenFromState(authState);
    if (accessToken == null) return;

    final localeManager = serviceLocator<LocaleManager>();
    final countryCode = localeManager.currentCountry;
    final currency = localeManager.currentCurrency;

    // Apply filter based on selected type
    switch (filterType) {
      case RecipientFilterType.all:
        context.read<RecipientCubit>().getRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
        );
        break;
      case RecipientFilterType.favorites:
        context.read<RecipientCubit>().getRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
          favoritesOnly: true,
        );
        break;
      case RecipientFilterType.recent:
        context.read<RecipientCubit>().getRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
        );
        break;
      case RecipientFilterType.bank:
        context.read<RecipientCubit>().getRecipients(
          accessToken: accessToken,
          countryCode: countryCode,
          currency: currency,
        );
        break;
    }
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
            final localeManager = serviceLocator<LocaleManager>();
            context.read<RecipientCubit>().getRecipients(
              accessToken: accessToken,
              countryCode: localeManager.currentCountry,
              currency: localeManager.currentCurrency,
            );
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
                            _buildQuickAction(
                              icon: Icons.history,
                              label: 'History',
                              onTap: _showTransferHistory,
                            ),
                          ],
                        ),
                      ),

                      // Filter chips - always visible
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: RecipientChipsBuilder(
                          onFilterChanged: _onFilterChanged,
                          selectedFilter: _currentFilter,
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
    // Handle Initial State explicitly - show centered loader while initializing
    if (state is RecipientInitial) {
      return _buildLoadingWidget();
    }

    if (state is RecipientLoading) {
      return _buildLoadingWidget();
    }

    if (state is RecipientLoadingMore) {
      // Show loading indicator at bottom while keeping current list visible
      final allRecipients = state.currentRecipients.toList();

      if (allRecipients.isEmpty) {
        return _buildLoadingWidget();
      }

      return RefreshIndicator(
        color: const Color.fromARGB(255, 78, 3, 208),
        onRefresh: () async {
          final authState = context.read<AuthenticationCubit>().state;
          if (authState is AuthenticationSuccess) {
            final lm = serviceLocator<LocaleManager>();
            await context.read<RecipientCubit>().getRecipients(
              accessToken: authState.profile.session.accessToken,
              countryCode: lm.currentCountry,
              currency: lm.currentCurrency,
            );
          }
        },
        child: CustomScrollView(
          controller: _recipientsScrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // All Recipients Section using SliverList
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == allRecipients.length) {
                      // Show loading more indicator at the end
                      return Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 78, 3, 208),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    final recipient = allRecipients[index];
                    return _buildRecipientItem(recipient);
                  },
                  childCount: allRecipients.length + 1, // +1 for loading indicator
                ),
              ),
            ),
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32.h),
            ),
          ],
        ),
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
      // Show all recipients
      final allRecipients = state.recipients.toList();
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
            final lm = serviceLocator<LocaleManager>();
            await context.read<RecipientCubit>().getRecipients(
              accessToken: authState.profile.session.accessToken,
              countryCode: lm.currentCountry,
              currency: lm.currentCurrency,
            );
          }
        },
        child: CustomScrollView(
          controller: _recipientsScrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            // All Recipients Section using SliverList
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == allRecipients.length) {
                      // Show "Load More" indicator at the end
                      return _buildLoadMoreIndicator(state);
                    }
                    final recipient = allRecipients[index];
                    return _buildRecipientItem(recipient);
                  },
                  childCount: allRecipients.length + (state.hasMore ? 1 : 0),
                ),
              ),
            ),
            // Bottom spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32.h),
            ),
          ],
        ),
      );
    }

    // Fallback for any other unhandled state (should ideally not be reached)
    return const Center(child: Text('An unexpected error occurred.'));
  }

  /// Build individual recipient item for the list
  Widget _buildRecipientItem(RecipientModel recipient) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(recipient.name),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),

                // Name, Alias, and Account Number - Expanded to take available space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name row with favorite icon
                      Row(
                        children: [
                          if (recipient.isFavorite)
                            Padding(
                              padding: EdgeInsets.only(right: 6.w),
                              child: Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber[700],
                              ),
                            ),
                          Expanded(
                            child: Text(
                              _toTitleCase(recipient.name),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                letterSpacing: 0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      // Alias row if exists
                      if (recipient.alias != null && recipient.alias!.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.label,
                              size: 14,
                              color: const Color(0xFF4E03D0),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Text(
                                recipient.alias!,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF4E03D0),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      // Account number row with bank info
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            recipient.accountNumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          // Show bank name next to account number if not LazerVault
                          if (recipient.bankName.toLowerCase() != 'lazervault') ...[
                            SizedBox(width: 8.w),
                            Text(
                              '• ${recipient.bankName}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),

                // Action icons - fixed position on the right
                // Quick repeat transfer button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () => _quickSendToRecipient(recipient),
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(
                        Icons.repeat,
                        color: const Color(0xFF4E03D0),
                        size: 20.w,
                      ),
                    ),
                  ),
                ),

                // More options button (three-dot menu)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () => _showRecipientOptionsSheet(recipient),
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey[600],
                        size: 22.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Quick send to recipient - show transaction history modal to select past amount
  void _quickSendToRecipient(RecipientModel recipient) {
    if (recipient.accountNumber.isEmpty) {
      Get.snackbar(
        'No Account Number',
        'This recipient has no account number to search transactions for.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    Get.bottomSheet(
      BlocProvider(
        create: (_) => GetIt.I<RecipientTransactionHistoryCubit>(),
        child: RecipientTransactionHistoryModal(recipient: recipient),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Show options bottom sheet for recipient
  void _showRecipientOptionsSheet(RecipientModel recipient) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sheet Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(recipient.name),
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _toTitleCase(recipient.name),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          recipient.accountNumber,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 24.h, color: Colors.grey[200]),

            // Options List
            _buildOptionTile(
              icon: Icons.repeat,
              title: 'Quick Send',
              color: const Color(0xFF4E03D0),
              onTap: () {
                Get.back();
                _quickSendToRecipient(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.schedule,
              title: 'Recurring Payments',
              color: const Color(0xFF3B82F6),
              onTap: () {
                Get.back();
                Get.toNamed(AppRoutes.recurringTransfers);
              },
            ),
            _buildOptionTile(
              icon: Icons.person_outline,
              title: 'View Details',
              color: Colors.grey[700]!,
              onTap: () {
                Get.back();
                _showRecipientDetailsSheet(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.edit_outlined,
              title: 'Add Alias',
              color: Colors.grey[700]!,
              onTap: () {
                Get.back();
                _showUpdateAliasDialog(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.share_outlined,
              title: 'Share Account',
              color: Colors.grey[700]!,
              onTap: () {
                Get.back();
                _shareRecipient(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.favorite_border,
              title: recipient.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
              color: recipient.isFavorite ? Colors.amber[700]! : Colors.grey[700]!,
              onTap: () {
                Get.back();
                _toggleFavorite(recipient);
              },
            ),
            _buildOptionTile(
              icon: Icons.delete_outline,
              title: 'Remove Recipient',
              color: Colors.red[400]!,
              onTap: () {
                Get.back();
                _showRemoveConfirmation(recipient);
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  /// Build option tile for bottom sheet
  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  /// Show recipient details bottom sheet
  void _showRecipientDetailsSheet(RecipientModel recipient) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: const Color(0xFF4E03D0),
                      size: 28.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recipient Details',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        Text(
                          'Saved recipient information',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: const Color(0xFF6B7280),
                      size: 24.sp,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Purple Gradient Card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4E03D0),
                              const Color(0xFF5F14E1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bank name with icon
                            Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.account_balance,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    recipient.bankName,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              height: 1,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            SizedBox(height: 20.h),

                            // Account holder name
                            Text(
                              'Account Holder',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              _toTitleCase(recipient.name),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Account number
                            Text(
                              'Account Number',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              recipient.accountNumber,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),

                            // Alias
                            if (recipient.alias != null && recipient.alias!.isNotEmpty) ...[
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.label_outline,
                                    color: Colors.white.withValues(alpha: 0.9),
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Alias: ${recipient.alias}',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Additional details below the card
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            if (recipient.sortCode.isNotEmpty)
                              _detailRow('Sort Code', recipient.sortCode),
                            if (recipient.countryCode != null && recipient.countryCode!.isNotEmpty)
                              _detailRow('Country', recipient.countryCode!),
                            if (recipient.currency != null && recipient.currency!.isNotEmpty)
                              _detailRow('Currency', recipient.currency!),
                            if (recipient.type != null && recipient.type!.isNotEmpty)
                              _detailRow('Type', _formatRecipientType(recipient.type)),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Action Buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                Get.back();
                                _shareRecipient(recipient);
                              },
                              icon: Icon(Icons.share, size: 18.sp),
                              label: Text('Share'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                side: BorderSide(color: const Color(0xFF4E03D0)),
                                foregroundColor: const Color(0xFF4E03D0),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.back();
                                Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
                              },
                              icon: Icon(Icons.send, size: 18.sp),
                              label: Text('Send Money'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4E03D0),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Detail row widget
  String _formatRecipientType(String? type) {
    switch (type?.toLowerCase()) {
      case 'internal':
        return 'Internal (LazerVault)';
      case 'external':
        return 'External (Bank)';
      case 'domestic':
        return 'Domestic Transfer';
      case 'international':
        return 'International Transfer';
      default:
        return type ?? 'Unknown';
    }
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }

  /// Show update alias dialog
  void _showUpdateAliasDialog(RecipientModel recipient) {
    final controller = TextEditingController(text: recipient.alias ?? '');
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = (authState is AuthenticationSuccess)
        ? authState.profile.session.accessToken
        : null;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Alias'),
          content: TextField(
            controller: controller,
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: 'Enter alias (e.g., "Mum", "Work")',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final trimmedValue = controller.text.trim();
                if (accessToken != null) {
                  context.read<RecipientCubit>().updateAlias(
                    recipientId: recipient.id,
                    alias: trimmedValue.isEmpty ? null : trimmedValue,
                    accessToken: accessToken,
                  );
                  Get.snackbar(
                    'Success',
                    trimmedValue.isEmpty ? 'Alias removed' : 'Alias updated',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green.withValues(alpha: 0.8),
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  /// Share recipient details
  void _shareRecipient(RecipientModel recipient) {
    var shareText =
        'Account details for:\nName: ${recipient.name}\nAccount Number: ${recipient.accountNumber}';
    shareText += '\nBank: ${recipient.bankName}';
    if (recipient.alias != null && recipient.alias!.isNotEmpty) {
      shareText += '\nAlias: ${recipient.alias}';
    }
    if (recipient.countryCode != null) {
      shareText += '\nCountry: ${recipient.countryCode}';
    }
    if (recipient.currency != null) {
      shareText += '\nCurrency: ${recipient.currency}';
    }
    shareText += '\n\n-Sent from LazerVault';
    SharePlus.instance.share(ShareParams(text: shareText));
  }

  /// Toggle favorite status
  void _toggleFavorite(RecipientModel recipient) {
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken = (authState is AuthenticationSuccess)
        ? authState.profile.session.accessToken
        : null;

    if (accessToken != null) {
      context.read<RecipientCubit>().toggleFavorite(
        recipientId: recipient.id,
        isFavorite: !recipient.isFavorite,
        accessToken: accessToken,
      );
      Get.snackbar(
        'Success',
        recipient.isFavorite ? 'Removed from favorites' : 'Added to favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  /// Show remove confirmation dialog
  void _showRemoveConfirmation(RecipientModel recipient) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Remove Recipient'),
          content: Text('Are you sure you want to remove ${recipient.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                final authState = context.read<AuthenticationCubit>().state;
                final accessToken = (authState is AuthenticationSuccess)
                    ? authState.profile.session.accessToken
                    : null;
                if (accessToken != null) {
                  context.read<RecipientCubit>().deleteRecipient(
                    recipientId: recipient.id,
                    accessToken: accessToken,
                  );
                }
              },
              child: Text('Remove', style: TextStyle(color: Colors.red[400])),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadMoreIndicator(RecipientState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Color.fromARGB(255, 78, 3, 208),
        ),
      ),
    );
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
            final currency = CountryConfigs.getByCode(_currentCountry)?.currency ?? 'NGN';
            final recipient = RecipientModel(
              id: user.id,
              name: user.name,
              accountNumber: user.username,
              bankName: 'LazerVault',
              sortCode: '',
              isFavorite: false,
              isSaved: false,
              countryCode: _currentCountry,
              currency: currency,
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
      isSaved: false,
      alias: alias,
      countryCode: 'NG',
      currency: 'NGN',
    );

    Get.toNamed(AppRoutes.initiateSendFunds, arguments: temporaryRecipient);
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
      // Step 1: Open QR scanner and wait for result
      final result = await Get.toNamed(AppRoutes.qrScanner);

      if (result == null || result is! Map<String, dynamic>) return;
      if (!mounted) return;

      final username = result['username'] as String? ?? '';
      final userId = result['recipientId'] as String? ?? '';

      // Validate we have enough data to verify
      if (username.isEmpty && userId.isEmpty) {
        _showQrScanErrorSheet(
          'Invalid QR Data',
          'The scanned QR code is missing recipient information. Please try scanning again.',
        );
        return;
      }

      // Step 2: Show verification loading sheet immediately
      _showQrVerificationLoadingSheet();
      // Allow the bottom sheet to render before starting network call
      await Future.delayed(const Duration(milliseconds: 100));

      // Step 3: Verify user exists on backend
      ProfileCubit? profileCubit;
      try {
        profileCubit = serviceLocator<ProfileCubit>();
        final searchQuery = username.isNotEmpty ? username : userId;
        final users = await profileCubit.searchUsers(searchQuery, limit: 5);

        // Dismiss loading sheet
        if (Get.isBottomSheetOpen ?? false) Get.back();
        if (!mounted) return;

        // Step 4: Match by userId or exact username
        UserSearchResultEntity? matchedUser;
        for (final u in users) {
          if ((userId.isNotEmpty && u.userId == userId) ||
              (username.isNotEmpty && u.username == username)) {
            matchedUser = u;
            break;
          }
        }

        if (matchedUser == null) {
          _showQrScanErrorSheet(
            'User Not Found',
            'The scanned QR code belongs to a user that could not be found. They may have deleted their account.',
          );
          return;
        }

        if (!mounted) return;

        // Step 5: Show confirmation bottom sheet with verified user details
        final qrCurrency = result['currency'] as String?;
        final currency = qrCurrency ??
            CountryConfigs.getByCode(_currentCountry)?.currency ??
            'NGN';
        final rawAmount = result['amount'];
        final qrAmount = rawAmount is int
            ? rawAmount
            : rawAmount is num
                ? rawAmount.toInt()
                : null;

        final action = await QrScanConfirmationSheet.show(
          context,
          user: matchedUser,
          requestedAmount: qrAmount,
          requestedCurrency: currency,
        );

        if (!mounted) return;

        if (action == QrScanAction.rescan) {
          // Re-launch scanner (loop)
          _launchQRScanner();
          return;
        }

        if (action == QrScanAction.confirm) {
          // Step 6: Create recipient from verified data and navigate
          final recipient = RecipientModel(
            id: matchedUser.userId,
            name: matchedUser.fullName,
            accountNumber: matchedUser.username,
            bankName: 'LazerVault',
            sortCode: '',
            isFavorite: false,
            isSaved: false,
            countryCode: _currentCountry,
            currency: currency,
            profileImageUrl: matchedUser.profilePicture,
          );

          final arguments = <String, dynamic>{'recipient': recipient};
          if (qrAmount != null) {
            arguments['prefillAmount'] = qrAmount;
            arguments['prefillCurrency'] = currency;
          }
          Get.toNamed(AppRoutes.initiateSendFunds, arguments: arguments);
        }
      } catch (e) {
        // Dismiss loading sheet if still open
        if (Get.isBottomSheetOpen ?? false) Get.back();
        if (!mounted) return;
        _showQrScanErrorSheet(
          'Verification Failed',
          'Could not verify the recipient. Please check your internet connection and try again.',
        );
      } finally {
        profileCubit?.close();
      }
    } catch (e) {
      Get.snackbar(
        'QR Scanner Error',
        'Failed to open QR scanner. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchBankDetailsScan() async {
    // Get auth cubit before any async operations
    final authCubit = context.read<AuthenticationCubit>();

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
      final authState = authCubit.state;
      final userId = (authState is AuthenticationSuccess)
          ? authState.profile.user.id
          : '';

      // Step 4: Call OCR endpoint
      final gatewayUrl = dotenv.env['CHAT_GATEWAY_URL'] ?? 'http://10.0.2.2:3011';
      final dataSource = BankScanDataSource(
        baseUrl: gatewayUrl,
        secureStorage: GetIt.I<SecureStorageService>(),
      );

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

  void _showQrVerificationLoadingSheet() {
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
              'Verifying Recipient',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Checking user details...',
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

  void _showQrScanErrorSheet(String title, String message, {bool isWarning = false}) {
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
                      _launchQRScanner();
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

  void _showTransferHistory() {
    Get.bottomSheet(
      BlocProvider(
        create: (_) => GetIt.I<TransactionHistoryCubit>(),
        child: const TransferHistoryBottomSheet(),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading recipients...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
