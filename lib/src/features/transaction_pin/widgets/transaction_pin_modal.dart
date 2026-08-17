import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/utils/transaction_service_label.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
part 'transaction_pin_modal_widgets.dart';


class TransactionPinModalState extends State<TransactionPinModal>
    with TickerProviderStateMixin {
  final List<FocusNode> _pinFocusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _pinControllers =
      List.generate(4, (_) => TextEditingController());

  String _pin = '';
  bool _isObscured = true;
  PinModalPhase _phase = PinModalPhase.pinEntry;
  String _statusMessage = '';
  String? _failureMessage;

  // Mutable attempt tracking (updated by resetToEntry)
  late int _currentAttempt;
  late int _maxAttempts;
  String? _inlineErrorMessage;

  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _checkController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _currentAttempt = widget.currentAttempt;
    _maxAttempts = widget.maxAttempts;
    _inlineErrorMessage = widget.errorMessage;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );

    // Standard OTP backspace behaviour: intercept Backspace at each box's focus
    // node so that pressing delete on an ALREADY-EMPTY box steps back to the
    // previous box and clears it. onChanged (see [_onPinChanged]) can't do this
    // because an empty box fires no text-change event, which is why users
    // previously had to tap into a box to delete. Applies to every caller of
    // this shared modal.
    for (var i = 0; i < _pinFocusNodes.length; i++) {
      final index = i;
      _pinFocusNodes[i].onKeyEvent = (node, event) =>
          _handlePinBackspace(index, event);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pinFocusNodes.isNotEmpty) {
        _pinFocusNodes[0].requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _checkController.dispose();
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Transition to verifying phase (called by mixin after PIN submitted)
  void setVerifying() {
    if (!mounted) return;
    setState(() {
      _phase = PinModalPhase.verifying;
      _statusMessage = 'Verifying PIN...';
    });
    _pulseController.repeat(reverse: true);
  }

  /// Transition to processing phase (called by mixin after PIN verified)
  void setProcessing({String? message}) {
    if (!mounted) return;
    setState(() {
      _phase = PinModalPhase.processing;
      _statusMessage = message ?? 'Processing...';
    });
    if (!_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    }
  }

  /// Transition to success phase (called by mixin after transfer succeeds)
  void setSuccess({String? message}) {
    if (!mounted) return;
    _pulseController.stop();
    setState(() {
      _phase = PinModalPhase.success;
      _statusMessage = message ?? 'PIN Verified';
    });
    _checkController.forward();
  }

  /// Transition to failed phase
  void setFailed(String message) {
    if (!mounted) return;
    _pulseController.stop();
    setState(() {
      _phase = PinModalPhase.failed;
      _failureMessage = message;
      // Honest header: the red X next to a 'Processing...' title read as a
      // contradiction. The body below carries the detailed reason.
      _statusMessage = 'Transaction Failed';
    });
  }

  /// Reset to PIN entry (e.g., on retry after wrong PIN)
  /// Updates attempt count and error message inline without closing the sheet
  void resetToEntry({String? errorMessage, int? currentAttempt}) {
    if (!mounted) return;
    _pulseController.stop();
    _checkController.reset();
    for (var c in _pinControllers) {
      c.clear();
    }
    _pin = '';
    setState(() {
      _phase = PinModalPhase.pinEntry;
      _failureMessage = null;
      if (errorMessage != null) _inlineErrorMessage = errorMessage;
      if (currentAttempt != null) _currentAttempt = currentAttempt;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pinFocusNodes.isNotEmpty && mounted) {
        _pinFocusNodes[0].requestFocus();
      }
    });
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

  /// Standard OTP Backspace handling. [_onPinChanged] can only react when the
  /// box's text actually changes, so a Backspace on an ALREADY-EMPTY box fires
  /// nothing and the caret appears stuck — the user had to tap into a filled box
  /// to delete. This intercepts Backspace at the focus-node level: on an empty
  /// box it steps back to the previous box, clears it, and places the caret
  /// there — matching every standard PIN/OTP field.
  KeyEventResult _handlePinBackspace(int index, KeyEvent event) {
    final isDown = event is KeyDownEvent || event is KeyRepeatEvent;
    if (!isDown || event.logicalKey != LogicalKeyboardKey.backspace) {
      return KeyEventResult.ignored;
    }
    // Non-empty box: let the TextField delete its own character (which then
    // routes through _onPinChanged and moves focus back).
    if (_pinControllers[index].text.isNotEmpty) {
      return KeyEventResult.ignored;
    }
    // Empty box + Backspace → step back and clear the previous box.
    if (index > 0) {
      final prev = index - 1;
      _pinControllers[prev].value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      _pinFocusNodes[prev].requestFocus();
      _pin = _pinControllers.map((c) => c.text).join();
      if (mounted) setState(() {});
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
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
    return Container(
      padding: EdgeInsets.only(
        bottom: _phase == PinModalPhase.pinEntry
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _phase == PinModalPhase.pinEntry
              ? _buildPinEntryContent()
              : _buildProcessingContent(),
        ),
      ),
    );
  }

  Widget _buildPinEntryContent() {
    // Tries remaining INCLUDING the current attempt. _currentAttempt is
    // 1-indexed and only advances AFTER a failed attempt, so on the first
    // failure (currentAttempt becomes 2) the user still has _maxAttempts-1
    // tries left, and on the final try (currentAttempt == _maxAttempts) exactly
    // 1 remains.
    final remainingAttempts = _maxAttempts - _currentAttempt + 1;

    return Padding(
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

          // Recipient identity (chat-driven money moves) — shows WHO the user is
          // paying while they enter the PIN. Reviewing this IS the confirmation.
          if ((widget.recipientName?.trim().isNotEmpty ?? false) ||
              (widget.recipientImageUrl?.trim().isNotEmpty ?? false)) ...[
            SizedBox(height: 12.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                UserAvatar(
                  size: 32.r,
                  imageUrl: widget.recipientImageUrl,
                  firstName: (widget.recipientName ?? '').split(' ').first,
                  lastName: (widget.recipientName ?? '').split(' ').length > 1
                      ? (widget.recipientName ?? '').split(' ').sublist(1).join(' ')
                      : null,
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    widget.recipientName ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],

          // Optional caller-supplied action (e.g. voice "Custom Voice" pill)
          if (widget.headerAction != null) ...[
            SizedBox(height: 12.h),
            widget.headerAction!,
          ],

          // Amount display (shows total including fee)
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
              child: Builder(builder: (_) {
                final base = widget.amount ?? 0;
                final fee = widget.fee ?? 0;
                final total = widget.totalAmount ?? (base + fee);
                // A "base + fee" split only makes sense when there's a genuine
                // base distinct from the fee. A fee-only charge (e.g. a balance
                // refresh) has no base — the total IS the fee, so don't render a
                // phantom "0.00 + …" (or a doubled "100 + 100") breakdown.
                final hasBase = base > 0;
                final feeOnly = fee > 0 && !hasBase;
                return Column(
                  children: [
                    Text(
                      feeOnly
                          ? 'Fee'
                          : (fee > 0 ? 'Total Amount' : 'Amount'),
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '$_displaySymbol${total.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4E03D0),
                      ),
                    ),
                    if (hasBase && fee > 0) ...[
                      SizedBox(height: 4.h),
                      Text(
                        '${base.toStringAsFixed(2)} + ${fee.toStringAsFixed(2)} fee',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ],
                );
              }),
            ),
          ],

          // Error message
          if (_inlineErrorMessage != null) ...[
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
                      _inlineErrorMessage!,
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

          // Attempts warning — standard practice: surface "N attempts
          // remaining" ONLY after the first failed attempt (currentAttempt
          // advances past 1), never on the initial PIN entry.
          if (_currentAttempt > 1 && remainingAttempts > 0) ...[
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
                  key: Key('transaction_pin_digit_$index'),
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
                        // Prefer the caller's handler; otherwise fall back to the
                        // shared OTP reset flow so "Forgot PIN?" always recovers,
                        // even for callers that didn't wire onForgotPin.
                        if (widget.onForgotPin != null) {
                          widget.onForgotPin!.call();
                        } else {
                          Get.toNamed(AppRoutes.forgotPin);
                        }
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
    );
  }

  Widget _buildProcessingContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
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
          SizedBox(height: 32.h),

          // Animated icon
          _buildPhaseIcon(),
          SizedBox(height: 24.h),

          // Status message
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _statusMessage,
              key: ValueKey(_statusMessage),
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: _phase == PinModalPhase.success
                    ? const Color(0xFF16A34A)
                    : _phase == PinModalPhase.failed
                        ? Colors.red.shade700
                        : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8.h),

          // Subtitle
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _getSubtitle(),
              key: ValueKey(_phase),
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Amount display in processing view (with fee breakdown if applicable)
          if (widget.amount != null) ...[
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: _phase == PinModalPhase.success
                    ? const Color(0xFF16A34A).withValues(alpha: 0.06)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _phase == PinModalPhase.success
                      ? const Color(0xFF16A34A).withValues(alpha: 0.2)
                      : Colors.grey.shade200,
                ),
              ),
              child: Builder(builder: (_) {
                // Mirror the PIN-entry view's amount logic so the headline never
                // flips to 0.00 on the processing beat. A fee-only charge (e.g. a
                // balance refresh passes amount:0) has NO base — the headline IS
                // the fee/total; only a genuine base+fee shows the breakdown rows.
                final base = widget.amount ?? 0;
                final fee = widget.fee ?? 0;
                final total = widget.totalAmount ?? (base + fee);
                final hasBase = base > 0;
                return Column(
                  children: [
                    // Main amount (the total charged — the fee for a fee-only charge)
                    Text(
                      '$_displaySymbol${total.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: _phase == PinModalPhase.success
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF4E03D0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Fee + Total breakdown ONLY when there's a genuine base
                    // distinct from the fee (never a phantom "0.00 + fee").
                    if (hasBase && fee > 0) ...[
                      SizedBox(height: 8.h),
                      Divider(color: Colors.grey.shade200, height: 1),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fee',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Text(
                            '$_displaySymbol${fee.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: _phase == PinModalPhase.success
                                  ? const Color(0xFF16A34A)
                                  : Colors.black87,
                            ),
                          ),
                          Text(
                            '$_displaySymbol${total.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: _phase == PinModalPhase.success
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF4E03D0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              }),
            ),
          ],

          // Progress steps
          SizedBox(height: 24.h),
          _buildProgressSteps(),

          // Failure message
          if (_phase == PinModalPhase.failed && _failureMessage != null) ...[
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
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
                      _failureMessage!,
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

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildPhaseIcon() {
    switch (_phase) {
      case PinModalPhase.verifying:
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) => Transform.scale(
            scale: _pulseAnimation.value,
            child: child,
          ),
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: LazerVaultLoader(size: 32),
            ),
          ),
        );

      case PinModalPhase.processing:
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) => Transform.scale(
            scale: _pulseAnimation.value,
            child: child,
          ),
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF4E03D0).withValues(alpha: 0.15),
                  const Color(0xFF7C3AED).withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: LazerVaultLoader(size: 32),
            ),
          ),
        );

      case PinModalPhase.success:
        return ScaleTransition(
          scale: _checkAnimation,
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: const BoxDecoration(
              color: Color(0xFF16A34A),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: 40.sp,
              color: Colors.white,
            ),
          ),
        );

      case PinModalPhase.failed:
        return Container(
          width: 72.w,
          height: 72.w,
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            size: 40.sp,
            color: Colors.red.shade700,
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  String _getSubtitle() {
    switch (_phase) {
      case PinModalPhase.verifying:
        return 'Securely verifying your transaction PIN';
      case PinModalPhase.processing:
        // Precedence: explicit caller override → service-specific copy derived
        // from transactionType → the original transfer default (unchanged for
        // the transfer family / deposit / withdrawal / etc.).
        return widget.processingSubtitle ??
            _serviceSubtitle(
              specific: (noun) => 'Your $noun is being processed',
              generic: 'Your $kGenericServiceNoun is being processed',
              transferDefault: 'Your transfer is being processed',
            );
      case PinModalPhase.success:
        return widget.successSubtitle ??
            _serviceSubtitle(
              specific: (noun) => 'Your $noun was successful',
              generic: 'Your $kGenericServiceNoun was successful',
              transferDefault: 'Your transfer has been completed',
            );
      case PinModalPhase.failed:
        return 'Something went wrong';
      default:
        return '';
    }
  }

  /// Resolve a phase subtitle from [transactionType]:
  /// - a recognised bill/service type → [specific] with its friendly noun,
  /// - a transfer-family type (and null/unset) → [transferDefault] (unchanged),
  /// - any other recognised-but-unmapped non-transfer type → [generic]
  ///   ("payment") so it never mislabels itself a transfer.
  String _serviceSubtitle({
    required String Function(String noun) specific,
    required String generic,
    required String transferDefault,
  }) {
    final type = widget.transactionType;
    final noun = transactionServiceNoun(type);
    if (noun != null) return specific(noun);
    if (type == null || type.trim().isEmpty || isTransferFamilyType(type)) {
      return transferDefault;
    }
    return generic;
  }

  Widget _buildProgressSteps() {
    final steps = [
      _StepInfo('PIN Verified', PinModalPhase.verifying),
      _StepInfo('Processing', PinModalPhase.processing),
      _StepInfo('Complete', PinModalPhase.success),
    ];

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Connector line
          final stepIndex = index ~/ 2;
          final isActive = _getStepOrder(_phase) > stepIndex;
          return Expanded(
            child: Container(
              height: 2.h,
              color: isActive
                  ? const Color(0xFF16A34A)
                  : Colors.grey.shade200,
            ),
          );
        }

        final stepIndex = index ~/ 2;
        final step = steps[stepIndex];
        final stepOrder = stepIndex;
        final currentOrder = _getStepOrder(_phase);
        final isCompleted = currentOrder > stepOrder;
        final isCurrent = currentOrder == stepOrder;
        final isFailed = _phase == PinModalPhase.failed && isCurrent;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: isFailed
                    ? Colors.red.shade50
                    : isCompleted
                        ? const Color(0xFF16A34A)
                        : isCurrent
                            ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                            : Colors.grey.shade100,
                shape: BoxShape.circle,
                border: isCurrent && !isFailed
                    ? Border.all(color: const Color(0xFF4E03D0), width: 2)
                    : null,
              ),
              child: Center(
                child: isCompleted
                    ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                    : isFailed
                        ? Icon(Icons.close, size: 16.sp, color: Colors.red.shade700)
                        : isCurrent
                            ? LazerVaultLoader(size: 12)
                            : null,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              step.label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                fontWeight: isCompleted || isCurrent
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: isFailed
                    ? Colors.red.shade700
                    : isCompleted
                        ? const Color(0xFF16A34A)
                        : isCurrent
                            ? const Color(0xFF4E03D0)
                            : Colors.grey.shade400,
              ),
            ),
          ],
        );
      }),
    );
  }

  int _getStepOrder(PinModalPhase phase) {
    switch (phase) {
      case PinModalPhase.verifying:
        return 0;
      case PinModalPhase.processing:
        return 1;
      case PinModalPhase.success:
        return 3; // All complete
      case PinModalPhase.failed:
        return 1; // Failed at processing
      default:
        return -1;
    }
  }
}

/// Show transaction PIN bottom sheet with inline processing states.
///
/// Instead of returning the PIN, this now takes a [pinModalKey] GlobalKey
/// so the caller can control phases via the state object.
///
/// Returns the PIN if submitted, null if cancelled.
Future<String?> showTransactionPinModal(
  BuildContext context, {
  String? title,
  String? message,
  double? amount,
  double? fee,
  double? totalAmount,
  String? currency,
  String? currencySymbol,
  int maxAttempts = 3,
  int currentAttempt = 1,
  String? errorMessage,
  bool isLoading = false,
  VoidCallback? onForgotPin,
  GlobalKey<TransactionPinModalState>? pinModalKey,
}) async {
  String? submittedPin;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => TransactionPinModal(
      key: pinModalKey,
      title: title,
      message: message,
      amount: amount,
      fee: fee,
      totalAmount: totalAmount,
      currency: currency,
      currencySymbol: currencySymbol,
      maxAttempts: maxAttempts,
      currentAttempt: currentAttempt,
      errorMessage: errorMessage,
      isLoading: isLoading,
      onPinSubmitted: (pin) {
        submittedPin = pin;
        // Don't pop — the mixin will control the lifecycle now
        if (pinModalKey == null) {
          // Legacy behavior: pop immediately if no key provided
          Navigator.of(context).pop();
        }
      },
      onForgotPin: onForgotPin,
      onCancel: () {},
    ),
  );

  return submittedPin;
}
