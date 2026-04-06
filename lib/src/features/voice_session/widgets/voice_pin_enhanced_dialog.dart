import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Enhanced PIN entry dialog with comprehensive edge case handling.
///
/// Edge cases handled:
/// - Network timeouts with retry
/// - Account locked detection
/// - Dialog dismissed during processing
/// - Multiple rapid attempts
/// - Invalid payload validation
/// - User cancellation
/// - Loading state management
/// - Clear feedback for all states
class VoicePinEnhancedDialog extends StatefulWidget {
  final Map<String, dynamic> transactionPayload;
  final String accessToken;
  final void Function(bool success, {String? reference, String? error}) onComplete;

  const VoicePinEnhancedDialog({
    super.key,
    required this.transactionPayload,
    required this.accessToken,
    required this.onComplete,
  });

  @override
  State<VoicePinEnhancedDialog> createState() => _VoicePinEnhancedDialogState();
}

class _VoicePinEnhancedDialogState extends State<VoicePinEnhancedDialog> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isProcessing = false;
  String? _errorMessage;
  int _attempts = 0;
  int _networkRetries = 0;
  Timer? _timeoutTimer;
  Timer? _debounceTimer;
  static const int _maxAttempts = 3;
  static const int _maxNetworkRetries = 3;
  static const Duration _requestTimeout = Duration(seconds: 30);
  static const Duration _debounceDelay = Duration(milliseconds: 500);

  String get _transferGatewayUrl {
    return dotenv.env['TRANSFER_GATEWAY_URL'] ?? 'http://localhost:8084';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
      _startTimeoutTimer();
    });
  }

  @override
  void dispose() {
    // Edge case: Cancel all timers to prevent memory leaks
    _timeoutTimer?.cancel();
    _debounceTimer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimeoutTimer() {
    // Edge case: Auto-cancel after 3 minutes of inactivity
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(const Duration(minutes: 3), () {
      if (mounted && !_isProcessing) {
        widget.onComplete(false, error: 'PIN entry timed out. Please try again.');
        Navigator.of(context).pop();
      }
    });
  }

  String get _pin => _controllers.map((c) => c.text).join();

  void _onDigitChanged(int index, String value) {
    // Edge case: Reset timeout timer on user activity
    _startTimeoutTimer();

    // Edge case: Debounce rapid input to prevent issues
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDelay, () {
      if (_isProcessing) return;

      if (value.length == 1 && index < 3) {
        _focusNodes[index + 1].requestFocus();
      }

      // Auto-submit when all 4 digits entered
      if (_pin.length == 4) {
        _executeTransfer();
      }
    });
  }

  void _onKeyPressed(int index, RawKeyEvent event) {
    // Edge case: Reset timeout timer on user activity
    _startTimeoutTimer();

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

    // Edge case: Validate PIN format (digits only)
    if (!RegExp(r'^\d{4}$').hasMatch(pin)) {
      setState(() {
        _errorMessage = 'PIN must be 4 digits';
      });
      _clearPin();
      return;
    }

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    // Edge case: Cancel timeout timer during processing
    _timeoutTimer?.cancel();

    try {
      // Edge case: Validate transaction payload before making request
      final validationError = _validateTransactionPayload(widget.transactionPayload);
      if (validationError != null) {
        throw Exception(validationError);
      }

      final payload = widget.transactionPayload;
      final transferType = payload['transfer_type'] as String? ?? 'internal';
      final amountMajor = (payload['amount'] as num?) ?? 0;

      // Edge case: Validate amount
      if (amountMajor <= 0) {
        throw Exception('Invalid amount');
      }

      final amountMinor = (amountMajor * 100).toInt();

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

      // Edge case: Check for mounted before processing response
      if (!mounted) return;

      final response = await http.post(
        Uri.parse('$_transferGatewayUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
          'X-Account-Id': payload['account_id'] as String? ?? '',
        },
        body: jsonEncode(body),
      ).timeout(_requestTimeout);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reference = data['reference'] as String? ??
            data['payment']?['reference'] as String? ??
            '';
        widget.onComplete(true, reference: reference);
        // Edge case: Close dialog after short delay to show success
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) Navigator.of(context).pop();
      } else if (response.statusCode == 401) {
        // Edge case: Unauthorized - token expired
        throw Exception('Session expired. Please login again.');
      } else if (response.statusCode == 423) {
        // Edge case: Account locked
        final data = jsonDecode(response.body);
        final isLocked = data['is_locked'] as bool? ?? false;
        if (isLocked) {
          widget.onComplete(false, error: 'Account locked due to too many failed attempts');
          if (mounted) Navigator.of(context).pop();
          return;
        }
      } else if (response.statusCode >= 500) {
        // Edge case: Server error - should not count as PIN attempt
        throw Exception('Server error. Please try again.');
      } else {
        _attempts++;
        final data = jsonDecode(response.body);
        final errorMsg = data['message'] as String? ?? 'Transfer failed';
        final isLocked = data['is_locked'] as bool? ?? false;

        if (isLocked || _attempts >= _maxAttempts) {
          widget.onComplete(false, error: isLocked
              ? 'Account locked due to too many failed attempts'
              : 'Maximum PIN attempts exceeded');
          if (mounted) Navigator.of(context).pop();
        } else {
          setState(() {
            _isProcessing = false;
            _errorMessage = '$errorMsg (${_maxAttempts - _attempts} attempts remaining)';
          });
          _clearPin();
          _focusNodes[0].requestFocus();
        }
      }
    } catch (e) {
      if (!mounted) return;

      // Edge case: Network/timeout errors should NOT count as PIN attempts
      _networkRetries++;

      String errorMsg;
      if (e.toString().contains('TimeoutException') || e.toString().contains('Timeout')) {
        errorMsg = 'Request timed out. Please try again.';
      } else if (e.toString().contains('SocketException') || e.toString().contains('Connection')) {
        errorMsg = 'Connection error. Please check your internet.';
      } else if (e.toString().contains('Session expired')) {
        errorMsg = 'Session expired. Please login again.';
        widget.onComplete(false, error: errorMsg);
        if (mounted) Navigator.of(context).pop();
        return;
      } else {
        errorMsg = e.toString().replaceAll('Exception: ', '');
      }

      if (_networkRetries >= _maxNetworkRetries) {
        widget.onComplete(false, error: '$errorMsg Please try again later.');
        if (mounted) Navigator.of(context).pop();
        return;
      }

      setState(() {
        _isProcessing = false;
        _errorMessage = '$errorMsg (Retry $_networkRetries/$_maxNetworkRetries)';
      });
      _clearPin();
      _focusNodes[0].requestFocus();
    }
  }

  /// Validate transaction payload before making request
  String? _validateTransactionPayload(Map<String, dynamic> payload) {
    if (payload.isEmpty) {
      return 'Invalid transaction details';
    }

    final transferType = payload['transfer_type'] as String?;
    if (transferType == null) {
      return 'Transfer type not specified';
    }

    if (payload['amount'] == null) {
      return 'Amount not specified';
    }

    final amount = (payload['amount'] as num?) ?? 0;
    if (amount <= 0) {
      return 'Invalid amount';
    }

    if (payload['account_id'] == null) {
      return 'Account ID not specified';
    }

    if (transferType == 'domestic') {
      if (payload['recipient_account_number'] == null) {
        return 'Recipient account number not specified';
      }
      if (payload['recipient_bank_code'] == null) {
        return 'Recipient bank code not specified';
      }
    } else if (transferType == 'internal') {
      if (payload['recipient_username'] == null) {
        return 'Recipient username not specified';
      }
    }

    return null; // Validation passed
  }

  void _clearPin() {
    for (final c in _controllers) {
      c.clear();
    }
  }

  void _handleCancel() {
    // Edge case: Allow user to cancel if not processing
    if (!_isProcessing) {
      widget.onComplete(false, error: 'PIN entry cancelled');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isProcessing, // Prevent closing during processing
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleCancel();
        }
      },
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
                  child: Column(
                    children: [
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Processing...',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60.w,
                      height: 70.h,
                      child: RawKeyboardListener(
                        focusNode: _focusNodes[index],
                        onKey: (event) => _onKeyPressed(index, event),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          maxLength: 1,
                          onChanged: (value) => _onDigitChanged(index, value),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                            filled: true,
                            fillColor: _controllers[index].text.isNotEmpty
                                ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                                : const Color(0xFF2D2D2D),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: _errorMessage != null
                                    ? const Color(0xFFEF4444)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: _focusNodes[index].hasFocus
                                    ? const Color(0xFF3B82F6)
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                color: Color(0xFF3B82F6),
                                width: 2,
                              ),
                            ),
                          ),
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
                    border: Border.all(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: Color(0xFFEF4444),
                        size: 16,
                      ),
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

              SizedBox(height: 24.h),

              // Cancel button (only show when not processing)
              if (!_isProcessing)
                TextButton(
                  onPressed: _handleCancel,
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF9CA3AF),
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
