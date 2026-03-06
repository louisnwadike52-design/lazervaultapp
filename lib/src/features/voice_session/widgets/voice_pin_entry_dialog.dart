import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// PIN entry dialog for voice sessions.
///
/// CRITICAL: PIN is sent directly to the Go API (transfer-gateway),
/// NEVER through the voice agent, for security reasons.
class VoicePinEntryDialog extends StatefulWidget {
  final Map<String, dynamic> transactionPayload;
  final String accessToken;
  final void Function(bool success, {String? reference, String? error}) onComplete;

  const VoicePinEntryDialog({
    super.key,
    required this.transactionPayload,
    required this.accessToken,
    required this.onComplete,
  });

  @override
  State<VoicePinEntryDialog> createState() => _VoicePinEntryDialogState();
}

class _VoicePinEntryDialogState extends State<VoicePinEntryDialog> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isProcessing = false;
  String? _errorMessage;
  int _attempts = 0;
  static const int _maxAttempts = 3;

  String get _transferGatewayUrl {
    return dotenv.env['TRANSFER_GATEWAY_URL'] ?? 'http://localhost:8084';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _pin => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }

    // Auto-submit when all 4 digits entered
    if (_pin.length == 4) {
      _executeTransfer();
    }
  }

  void _onKeyPressed(int index, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _executeTransfer() async {
    if (_isProcessing) return;

    final pin = _pin;
    if (pin.length != 4) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    try {
      final payload = widget.transactionPayload;
      final transferType = payload['transfer_type'] as String? ?? 'internal';
      final amountMajor = (payload['amount'] as num?) ?? 0;
      final amountMinor = (amountMajor * 100).toInt(); // Convert to kobo

      String endpoint;
      Map<String, dynamic> body;

      if (transferType == 'domestic') {
        endpoint = '/api/v1/transfers/domestic';
        body = {
          'transaction_pin': pin,
          'from_account_id': payload['account_id'] ?? '',
          'account_number': payload['recipient_account_number'] ?? '',
          'bank_code': payload['recipient_bank_code'] ?? '',
          'amount': amountMinor,
          'currency': payload['currency'] ?? 'NGN',
          'narration': payload['narration'] ?? 'Voice transfer',
        };
      } else {
        // Internal (C2C) — verify-and-transfer
        endpoint = '/api/v1/transfers/verify-and-transfer';
        body = {
          'transaction_pin': pin,
          'from_account_id': payload['account_id'] ?? '',
          'to_username': payload['recipient_username'] ?? '',
          'amount': amountMinor,
          'currency': payload['currency'] ?? 'NGN',
          'narration': payload['narration'] ?? 'Voice transfer',
          if (payload['category_id'] != null) 'category_id': payload['category_id'],
        };
      }

      final response = await http.post(
        Uri.parse('$_transferGatewayUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
          'X-Account-Id': payload['account_id'] as String? ?? '',
        },
        body: jsonEncode(body),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reference = data['reference'] as String? ??
            data['payment']?['reference'] as String? ??
            '';
        widget.onComplete(true, reference: reference);
      } else {
        _attempts++;
        final data = jsonDecode(response.body);
        final errorMsg = data['message'] as String? ?? 'Transfer failed';
        final isLocked = data['is_locked'] as bool? ?? false;

        if (isLocked || _attempts >= _maxAttempts) {
          widget.onComplete(false, error: isLocked
              ? 'Account locked due to too many failed attempts'
              : 'Maximum PIN attempts exceeded');
        } else {
          setState(() {
            _isProcessing = false;
            _errorMessage = '$errorMsg (${_maxAttempts - _attempts} attempts remaining)';
            for (final c in _controllers) {
              c.clear();
            }
            _focusNodes[0].requestFocus();
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      _attempts++;
      if (_attempts >= _maxAttempts) {
        widget.onComplete(false, error: 'Network error after multiple attempts');
      } else {
        setState(() {
          _isProcessing = false;
          _errorMessage = 'Connection error. Tap to retry. (${_maxAttempts - _attempts} left)';
          for (final c in _controllers) {
            c.clear();
          }
          _focusNodes[0].requestFocus();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // barrierDismissible: false equivalent
      child: Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Lock icon
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_rounded,
                  color: const Color(0xFF3B82F6),
                  size: 28.sp,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                'Enter Transaction PIN',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Enter your 4-digit PIN to complete this transfer',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),

              // PIN input fields
              if (_isProcessing)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const CircularProgressIndicator(
                    color: Color(0xFF3B82F6),
                    strokeWidth: 3,
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 52.w,
                      height: 56.h,
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (event) => _onKeyPressed(index, event),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          obscureText: true,
                          obscuringCharacter: '*',
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: const Color(0xFF2D2D2D),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                color: Color(0xFF3B82F6),
                                width: 2,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) => _onDigitChanged(index, value),
                        ),
                      ),
                    );
                  }),
                ),

              // Error message
              if (_errorMessage != null) ...[
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 18.sp),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFFEF4444),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 20.h),

              // Cancel button
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: TextButton(
                  onPressed: _isProcessing
                      ? null
                      : () => widget.onComplete(false, error: 'Cancelled by user'),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
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
