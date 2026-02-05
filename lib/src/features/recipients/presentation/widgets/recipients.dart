import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_transaction_history_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/recipient_transaction_history_modal.dart';

class Recipients extends StatefulWidget {
  final List<RecipientModel> recipients;

  const Recipients({
    super.key,
    required this.recipients,
  });

  @override
  State<Recipients> createState() => _RecipientsState();
}

class _RecipientsState extends State<Recipients> {
  List<RecipientModel> selectedRecipients = [];

  String? _getAccessToken() {
    final authState = BlocProvider.of<AuthenticationCubit>(context, listen: false).state;
    if (authState is AuthenticationSuccess) {
      return authState.profile.session.accessToken;
    }
    return null;
  }

  void _shareRecipient(RecipientModel recipient) {
    var shareText =
        'Account details for:\nName: ${recipient.name}\nAccount Number: ${recipient.accountNumber}';
    shareText += '\nBank: ${recipient.bankName}';
    if (recipient.countryCode != null) {
      shareText += '\nCountry: ${recipient.countryCode}';
    }
    if (recipient.currency != null) {
      shareText += '\nCurrency: ${recipient.currency}';
    }
    SharePlus.instance.share(ShareParams(text: shareText));
  }

  void _showUpdateAliasDialog(BuildContext context, RecipientModel recipient) {
    final controller = TextEditingController(text: recipient.alias ?? '');
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Alias'),
          content: TextField(
            controller: controller,
            maxLength: 50,
            decoration: const InputDecoration(
              hintText: 'Enter alias',
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
                final accessToken = _getAccessToken();
                if (accessToken != null) {
                  BlocProvider.of<RecipientCubit>(context, listen: false).updateAlias(
                    recipientId: recipient.id,
                    alias: trimmedValue.isEmpty ? null : trimmedValue,
                    accessToken: accessToken,
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

  IconData _recipientTypeIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'internal':
        return Icons.swap_horiz;
      case 'external':
        return Icons.account_balance;
      case 'domestic':
        return Icons.home;
      case 'international':
        return Icons.public;
      default:
        return Icons.help_outline;
    }
  }

  Color _recipientTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'internal':
        return const Color(0xFF4E03D0);
      case 'external':
        return const Color(0xFF059669);
      case 'domestic':
        return const Color(0xFF2563EB);
      case 'international':
        return const Color(0xFFD97706);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _showViewDetailsSheet(BuildContext context, RecipientModel recipient) {
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
                    // Recipient Type Badge
                    if (recipient.type != null && recipient.type!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: _recipientTypeColor(recipient.type).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: _recipientTypeColor(recipient.type).withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _recipientTypeIcon(recipient.type),
                                color: _recipientTypeColor(recipient.type),
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                _formatRecipientType(recipient.type),
                                style: TextStyle(
                                  color: _recipientTypeColor(recipient.type),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: 16.h),

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
                              recipient.name.toUpperCase(),
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
                            if (recipient.type != null && recipient.type!.isNotEmpty)
                              _detailRow('Added Via', _formatRecipientType(recipient.type)),
                            if (recipient.sortCode.isNotEmpty)
                              _detailRow('Sort Code', recipient.sortCode),
                            if (recipient.countryCode != null && recipient.countryCode!.isNotEmpty)
                              _detailRow('Country', recipient.countryCode!),
                            if (recipient.currency != null && recipient.currency!.isNotEmpty)
                              _detailRow('Currency', recipient.currency!),
                            if (recipient.iban != null && recipient.iban!.isNotEmpty)
                              _detailRow('IBAN', recipient.iban!),
                            if (recipient.swiftCode != null && recipient.swiftCode!.isNotEmpty)
                              _detailRow('SWIFT/BIC', recipient.swiftCode!),
                            if (recipient.email != null && recipient.email!.isNotEmpty)
                              _detailRow('Email', recipient.email!),
                            if (recipient.phoneNumber != null && recipient.phoneNumber!.isNotEmpty)
                              _detailRow('Phone', recipient.phoneNumber!),
                          ],
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
    );
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

  void _showRemoveConfirmation(BuildContext context, RecipientModel recipient) {
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
                final accessToken = _getAccessToken();
                if (accessToken != null) {
                  BlocProvider.of<RecipientCubit>(context, listen: false).deleteRecipient(
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.recipients.length,
      itemBuilder: (context, index) {
        final recipient = widget.recipients[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                offset: Offset(0, 2),
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
                        shape: BoxShape.circle,                      ),
                      child: Center(
                        child: Text(
                          recipient.name.substring(0, 2).toUpperCase(),
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),

                    // Name, Alias, and Account Number
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipient.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              letterSpacing: 0.2,
                            ),
                          ),
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
                                Text(
                                  recipient.alias!,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF4E03D0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          SizedBox(height: 4.h),
                          Text(
                            recipient.accountNumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Transaction History Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () => _openTransactionHistory(context, recipient),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            Icons.history,
                            color: const Color(0xFF4E03D0),
                            size: 22.w,
                          ),
                        ),
                      ),
                    ),

                    // More Options Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () => _showOptionsSheet(context, recipient),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            Icons.more_horiz,
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
      },
    );
  }

  void _openTransactionHistory(BuildContext context, RecipientModel recipient) {
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

  void _showOptionsSheet(BuildContext context, RecipientModel recipient) {
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

            // Options List
            ListTile(
              leading: Icon(Icons.edit_outlined, color: Colors.grey[700]),
              title: Text(
                'Update Alias',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Get.back();
                _showUpdateAliasDialog(context, recipient);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.grey[700]),
              title: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Get.back();
                _showViewDetailsSheet(context, recipient);
              },
            ),
            ListTile(
              leading: Icon(Icons.share_outlined, color: Colors.grey[700]),
              title: Text(
                'Share',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Get.back();
                _shareRecipient(recipient);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: Colors.red[400]),
              title: Text(
                'Remove',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red[400],
                ),
              ),
              onTap: () {
                Get.back();
                _showRemoveConfirmation(context, recipient);
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
