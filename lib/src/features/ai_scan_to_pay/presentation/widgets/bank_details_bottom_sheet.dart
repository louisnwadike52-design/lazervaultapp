import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              color: const Color(0xFF4E03D0).withOpacity(0.1),
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
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFF59E0B).withOpacity(0.1),
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
                color: const Color(0xFF10B981).withOpacity(0.1),
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
        color: color.withOpacity(0.1),
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
