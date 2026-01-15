import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_chips_builder.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipients.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class SelectRecipients extends StatefulWidget {
  const SelectRecipients({super.key});

  @override
  State<SelectRecipients> createState() => _SelectRecipientsState();
}

class _SelectRecipientsState extends State<SelectRecipients> {
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
                            BackNavigator(),
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

                        // Search Bar and Voice Command
                        GestureDetector(
                          onTap: _showEnhancedRecipientSelection,
                          child: Container(
                            height: 48.h,
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
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 12.h,
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
                                             'Recipient, @username or contact',
                                             style: TextStyle(
                                               color: Colors.white.withValues(alpha: 0.7),
                                               fontSize: 14.sp,
                                             ),
                                           ),
                                         ),
                                        Icon(
                                          Icons.alternate_email,
                                          color: Colors.white.withValues(alpha: 0.8),
                                          size: 16.sp,
                                        ),
                                        SizedBox(width: 8.w),
                                        Icon(
                                          Icons.contacts_outlined,
                                          color: Colors.white.withValues(alpha: 0.8),
                                          size: 16.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 4.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // Implement voice command or show enhanced selection
                                      _showEnhancedRecipientSelection();
                                    },
                                    icon: Icon(Icons.mic,
                                        color: Colors.white, size: 20),
                                    constraints: BoxConstraints(
                                      minWidth: 40.w,
                                      minHeight: 40.w,
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
                              icon: Icons.schedule_outlined,
                              label: 'Schedule',
                              onTap: _launchScheduledTransfer,
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
      // Handle case where recipients list is empty
      if (state.recipients.isEmpty) {
        return const Center(
            child: Text('No previous recipients')); // User requested text
      }
      // Build the UI for displaying the list
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Frequent Section
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecipientChipsBuilder(recipients: state.recipients),
                ],
              ),
            ),

            // All Recipients Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Recipients(recipients: state.recipients),
              ],
            ),
          ],
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
            final recipient = RecipientModel(
              id: user.id,
              name: user.name,
              accountNumber: user.username,
              bankName: 'LazerVault',
              sortCode: '',
              isFavorite: false,
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

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    final nameController = TextEditingController(text: contact.name);
    final accountController = TextEditingController();
    final bankController = TextEditingController();
    final sortCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
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
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: accountController,
              decoration: InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: sortCodeController,
              decoration: InputDecoration(
                labelText: 'Sort Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: bankController,
              decoration: InputDecoration(
                labelText: 'Bank Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (accountController.text.isNotEmpty && 
                  sortCodeController.text.isNotEmpty &&
                  bankController.text.isNotEmpty) {
                final recipient = RecipientModel(
                  id: contact.id,
                  name: nameController.text,
                  accountNumber: accountController.text,
                  bankName: bankController.text,
                  sortCode: sortCodeController.text,
                  isFavorite: false,
                );
                Navigator.pop(dialogContext);
                Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
              }
            },
            child: Text('Add & Send'),
          ),
        ],
      ),
    );
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

  Future<void> _launchSplitBills() async {
    Get.toNamed(AppRoutes.splitBills);
  }
}
