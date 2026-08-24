import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/scan_entities.dart';
import '../cubit/ai_scan_cubit.dart';
import 'error_widgets.dart';

/// Bank Details Bottom Sheet
///
/// Displays extracted bank account details with editable fields,
/// confidence indicators, and payment initiation.
class BankDetailsBottomSheet extends StatefulWidget {
  final BankDetails extractedDetails;
  final String sessionId;

  const BankDetailsBottomSheet({
    Key? key,
    required this.extractedDetails,
    required this.sessionId,
  }) : super(key: key);

  @override
  State<BankDetailsBottomSheet> createState() => _BankDetailsBottomSheetState();
}

class _BankDetailsBottomSheetState extends State<BankDetailsBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _accountNumberController;
  late TextEditingController _accountNameController;
  late TextEditingController _bankNameController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  // Off-screen renderer for the branded "share as image" card.
  final ScreenshotController _shareController = ScreenshotController();
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _accountNumberController = TextEditingController(
      text: widget.extractedDetails.accountNumber,
    );
    _accountNameController = TextEditingController(
      text: widget.extractedDetails.accountName,
    );
    _bankNameController = TextEditingController(
      text: widget.extractedDetails.bankName,
    );
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountNameController.dispose();
    _bankNameController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          _buildDragHandle(),

          // Header with account type badge
          _buildHeader(),

          // Form Content (Scrollable)
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),

                    // Bank Name (read-only with icon)
                    _buildBankNameField(),
                    SizedBox(height: 16.h),

                    // Account Number (editable with confidence)
                    _buildAccountNumberField(),
                    SizedBox(height: 16.h),

                    // Account Name (validated via Paystack)
                    _buildAccountNameField(),
                    SizedBox(height: 16.h),

                    // Copy-all + branded Share of the resolved details.
                    _buildCopyShareActions(),
                    SizedBox(height: 4.h),

                    // Routing Number (if available)
                    if (widget.extractedDetails.routingNumber != null)
                      ...[
                        _buildRoutingNumberField(),
                        SizedBox(height: 16.h),
                      ],

                    // Divider
                    Divider(height: 32.h, color: const Color(0xFFE5E7EB)),

                    // Amount Input
                    _buildAmountField(),
                    SizedBox(height: 16.h),

                    // Description (optional)
                    _buildDescriptionField(),
                    SizedBox(height: 24.h),

                    // Confidence Score Info Card
                    if (widget.extractedDetails.requiresReview)
                      _buildConfidenceWarning(),

                    SizedBox(height: 100.h), // Space for bottom button
                  ],
                ),
              ),
            ),
          ),

          // Bottom Action
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    final isInternal = widget.extractedDetails.isInternal;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: const BoxDecoration(
        color: Color(0xFFF9FAFB),
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Bank Icon
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.account_balance,
              color: const Color(0xFF4E03D0),
              size: 24.r,
            ),
          ),
          SizedBox(width: 12.w),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Details',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isInternal
                            ? const Color(0xFF10B981).withValues(alpha: 0.1)
                            : const Color(0xFFF59E0B).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        isInternal ? 'LazerVault User' : 'External Bank',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: isInternal
                              ? const Color(0xFF10B981)
                              : const Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Close Button
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBankNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Name',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _bankNameController,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.business, size: 20.r, color: const Color(0xFF6B7280)),
            suffixIcon: _copyFieldButton(
              () => _copyValue(_bankName, 'Bank name'),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountNumberField() {
    final confidence = widget.extractedDetails.fieldConfidence['account_number'] ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Account Number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
            SizedBox(width: 8.w),
            _buildConfidenceBadge(confidence),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: 'Enter account number',
            prefixIcon: Icon(Icons.numbers, size: 20.r, color: const Color(0xFF6B7280)),
            suffixIcon: _copyFieldButton(
              () => _copyValue(_accountNumber, 'Account number'),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Account number is required';
            }
            if (value.length < 8 || value.length > 17) {
              return 'Invalid account number length';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAccountNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Account Name',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF374151),
              ),
            ),
            SizedBox(width: 8.w),
            // Verified badge (from Paystack)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, size: 12.r, color: const Color(0xFF10B981)),
                  SizedBox(width: 4.w),
                  Text(
                    'Verified',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _accountNameController,
          readOnly: true, // Validated via Paystack, not editable
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline, size: 20.r, color: const Color(0xFF6B7280)),
            suffixIcon: _copyFieldButton(
              () => _copyValue(_accountName, 'Account name'),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
          ),
        ),
      ],
    );
  }

  Widget _buildRoutingNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Routing Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: widget.extractedDetails.routingNumber,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.route, size: 20.r, color: const Color(0xFF6B7280)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: '0.00',
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.r),
              child: Text(
                '\$',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4E03D0),
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Amount is required';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Enter a valid amount';
            }
            // TODO: Check against balance via BLoC
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description (Optional)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          maxLength: 100,
          decoration: InputDecoration(
            hintText: 'What is this payment for?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildConfidenceBadge(double confidence) {
    Color color;
    String label;

    if (confidence >= 0.8) {
      color = const Color(0xFF10B981);
      label = 'High';
    } else if (confidence >= 0.6) {
      color = const Color(0xFFF59E0B);
      label = 'Medium';
    } else {
      color = const Color(0xFFEF4444);
      label = 'Low';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildConfidenceWarning() {
    return LowConfidenceWarning(
      confidenceScore: widget.extractedDetails.confidenceScore,
      onRetake: () {
        // Close bottomsheet and return to camera
        Navigator.pop(context);
        // Trigger camera restart could be handled by cubit
      },
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000),
            blurRadius: 10.r,
            offset: Offset(0, -4.r),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: _handleProceedToPay,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Proceed to Pay',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward, size: 20.r, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===== Copy / Share of the resolved bank details =====

  String get _bankName => _bankNameController.text.trim();
  String get _accountNumber => _accountNumberController.text.trim();
  String get _accountName => _accountNameController.text.trim();

  void _snack(String message) {
    Get.snackbar(
      'Copied',
      message,
      backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.95),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
    );
  }

  void _copyValue(String value, String label) {
    if (value.trim().isEmpty) return;
    Clipboard.setData(ClipboardData(text: value.trim()));
    _snack('$label copied to clipboard');
  }

  /// Small per-field copy affordance aligned to the right of a detail field.
  Widget _copyFieldButton(VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      tooltip: 'Copy',
      splashRadius: 20.r,
      icon: Icon(
        Icons.copy_rounded,
        size: 18.r,
        color: const Color(0xFF4E03D0),
      ),
    );
  }

  /// Clean, multi-line block of all the resolved details. Empty fields are
  /// omitted so the copied/shared text never carries a blank or "null" line.
  String _buildDetailsBlock() {
    final lines = <String>[
      if (_bankName.isNotEmpty) 'Bank: $_bankName',
      if (_accountNumber.isNotEmpty) 'Account Number: $_accountNumber',
      if (_accountName.isNotEmpty) 'Account Name: $_accountName',
    ];
    return lines.join('\n');
  }

  void _copyAllDetails() {
    final block = _buildDetailsBlock();
    if (block.isEmpty) return;
    Clipboard.setData(ClipboardData(text: block));
    _snack('Bank details copied to clipboard');
  }

  /// A small branded card (the details + the LazerVault logo) rendered to an
  /// image and shared. The image carries the branding; the text body is the
  /// clean details block with a brand header so recipients see it inline too.
  Future<void> _shareDetails() async {
    if (_isSharing) return;
    final block = _buildDetailsBlock();
    if (block.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No bank details to share yet')),
      );
      return;
    }
    setState(() => _isSharing = true);
    try {
      Uint8List? imageBytes;
      try {
        imageBytes = await _shareController.captureFromWidget(
          _buildBrandedShareCard(),
          pixelRatio: 3.0,
          delay: const Duration(milliseconds: 80),
          context: context,
        );
      } catch (_) {
        imageBytes = null; // Fall back to text-only share below.
      }

      final shareText = 'LazerVault • Bank Details\n\n$block';
      if (imageBytes != null) {
        final tempDir = await getTemporaryDirectory();
        final fileName =
            'LazerVault_BankDetails_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(imageBytes);
        await SharePlus.instance.share(
          ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
            files: [XFile(file.path)],
            text: shareText,
            subject: 'LazerVault Bank Details',
          ),
        );
      } else {
        await SharePlus.instance.share(
          ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),text: shareText, subject: 'LazerVault Bank Details'),
        );
      }
    } catch (e) {
      // Share cancelled by the user surfaces as a normal completion on most
      // platforms; only genuine errors land here. Keep it quiet + non-fatal.
      debugPrint('[BankDetailsBottomSheet] share error: $e');
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  /// The branded card captured to an image for sharing: LazerVault logo +
  /// brand header over the resolved bank-detail rows.
  Widget _buildBrandedShareCard() {
    Widget row(String label, String value) {
      if (value.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 360,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand header — logo + wordmark.
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/app_icon_with_bg.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'LazerVault',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4E03D0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Bank Details',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            const Divider(height: 24, color: Color(0xFFE5E7EB)),
            row('Bank', _bankName),
            row('Account Number', _accountNumber),
            row('Account Name', _accountName),
            const SizedBox(height: 8),
            const Text(
              'Shared via LazerVault',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  /// Footer row with "Copy all" + "Share" actions for the resolved details.
  Widget _buildCopyShareActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _copyAllDetails,
            icon: Icon(Icons.copy_all_rounded, size: 18.r),
            label: Text(
              'Copy all',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF4E03D0),
              side: const BorderSide(color: Color(0xFF4E03D0)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _isSharing ? null : _shareDetails,
            icon: _isSharing
                ? SizedBox(
                    width: 16.r,
                    height: 16.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Icon(Icons.ios_share_rounded, size: 18.r),
            label: Text(
              'Share',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleProceedToPay() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    // Close bottomsheet
    Navigator.pop(context);

    // Trigger payment flow in Cubit
    context.read<AiScanCubit>().initiatePayment(
          bankDetails: widget.extractedDetails,
          amount: amount,
          description: _descriptionController.text,
        );
  }
}
