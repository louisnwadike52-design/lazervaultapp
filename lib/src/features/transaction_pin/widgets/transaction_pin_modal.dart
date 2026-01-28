import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Transaction PIN entry bottom sheet for payment verification
class TransactionPinModal extends StatefulWidget {
  final String? title;
  final String? message;
  final double? amount;
  final String? currency;
  final String? currencySymbol;
  final Function(String) onPinSubmitted;
  final VoidCallback? onForgotPin;
  final VoidCallback? onCancel;
  final int maxAttempts;
  final int currentAttempt;
  final String? errorMessage;
  final bool isLoading;

  const TransactionPinModal({
    super.key,
    this.title,
    this.message,
    this.amount,
    this.currency,
    this.currencySymbol,
    required this.onPinSubmitted,
    this.onForgotPin,
    this.onCancel,
    this.maxAttempts = 3,
    this.currentAttempt = 1,
    this.errorMessage,
    this.isLoading = false,
  });

  @override
  State<TransactionPinModal> createState() => _TransactionPinModalState();
}

class _TransactionPinModalState extends State<TransactionPinModal> {
  final List<FocusNode> _pinFocusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());

  String _pin = '';
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pinFocusNodes.isNotEmpty) {
        _pinFocusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onPinChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _pinFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _pinFocusNodes[index - 1].requestFocus();
    }

    _pin = _pinControllers.map((c) => c.text).join();

    if (_pin.length == 4) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _submitPin();
      });
    }
  }

  void _submitPin() {
    if (_pin.length == 4) {
      widget.onPinSubmitted(_pin);
    }
  }

  String get _displaySymbol =>
      widget.currencySymbol ?? widget.currency ?? '';

  @override
  Widget build(BuildContext context) {
    final remainingAttempts = widget.maxAttempts - widget.currentAttempt;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),

              // Lock icon
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 28.sp,
                  color: const Color(0xFF4E03D0),
                ),
              ),
              SizedBox(height: 16.h),

              // Title
              Text(
                widget.title ?? 'Enter Transaction PIN',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),

              // Message
              if (widget.message != null)
                Text(
                  widget.message!,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),

              // Amount display
              if (widget.amount != null) ...[
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Amount',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '$_displaySymbol${widget.amount!.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4E03D0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Error message
              if (widget.errorMessage != null) ...[
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700, size: 18.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          widget.errorMessage!,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Attempts warning
              if (remainingAttempts > 0 && remainingAttempts < widget.maxAttempts) ...[
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text(
                        '$remainingAttempts attempt${remainingAttempts == 1 ? '' : 's'} remaining',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 24.h),

              // PIN input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 56.w,
                    height: 60.h,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    child: TextField(
                      controller: _pinControllers[index],
                      focusNode: _pinFocusNodes[index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      keyboardType: TextInputType.number,
                      obscureText: _isObscured,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => _onPinChanged(value, index),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Color(0xFF4E03D0), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 16.h),

              // Actions row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Show/Hide PIN
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: Icon(
                      _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      size: 18.sp,
                      color: Colors.grey.shade600,
                    ),
                    label: Text(
                      _isObscured ? 'Show' : 'Hide',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  // Forgot PIN
                  TextButton(
                    onPressed: widget.isLoading
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            widget.onForgotPin?.call();
                          },
                    child: Text(
                      'Forgot PIN?',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4E03D0),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              // Cancel button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: OutlinedButton(
                  onPressed: widget.isLoading ? null : () {
                    Navigator.of(context).pop();
                    widget.onCancel?.call();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Show transaction PIN bottom sheet
/// Returns the PIN if submitted, null if cancelled
Future<String?> showTransactionPinModal(
  BuildContext context, {
  String? title,
  String? message,
  double? amount,
  String? currency,
  String? currencySymbol,
  int maxAttempts = 3,
  int currentAttempt = 1,
  String? errorMessage,
  bool isLoading = false,
  VoidCallback? onForgotPin,
}) async {
  String? submittedPin;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => TransactionPinModal(
      title: title,
      message: message,
      amount: amount,
      currency: currency,
      currencySymbol: currencySymbol,
      maxAttempts: maxAttempts,
      currentAttempt: currentAttempt,
      errorMessage: errorMessage,
      isLoading: isLoading,
      onPinSubmitted: (pin) {
        submittedPin = pin;
        Navigator.of(context).pop();
      },
      onForgotPin: onForgotPin,
      onCancel: () {},
    ),
  );

  return submittedPin;
}
