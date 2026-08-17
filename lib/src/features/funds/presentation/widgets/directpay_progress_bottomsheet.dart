import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'directpay_progress_bottomsheet_widgets.dart';


/// Animated DirectPay Progress Bottomsheet
class DirectPayProgressBottomsheet extends StatefulWidget {
  final DirectPayProgressController controller;
  final VoidCallback? onDismiss;
  final VoidCallback? onSuccess;

  /// Re-run the whole deposit (re-link + re-authorize). Shown as the primary
  /// action when a failure is classified as retryable.
  final VoidCallback? onRetry;

  /// Leave the deposit flow and go to the dashboard. Shown as the secondary
  /// action on any failure.
  final VoidCallback? onExit;

  /// Route the user into BVN/identity verification. Shown as the PRIMARY
  /// action ("Verify Now") only on the KYC-required terminal state
  /// ([DirectPayProgressController.kycRequired]). The host wires this to save
  /// the pending deposit + navigate to the KYC screen.
  final VoidCallback? onKycVerify;

  const DirectPayProgressBottomsheet({
    super.key,
    required this.controller,
    this.onDismiss,
    this.onSuccess,
    this.onRetry,
    this.onExit,
    this.onKycVerify,
  });

  @override
  State<DirectPayProgressBottomsheet> createState() =>
      _DirectPayProgressBottomsheetState();
}

class _DirectPayProgressBottomsheetState
    extends State<DirectPayProgressBottomsheet>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    widget.controller.addListener(_onControllerChanged);
    if (widget.controller.isVisible) {
      _slideController.forward();
    }
  }

  void _onControllerChanged() {
    if (mounted) {
      if (widget.controller.isVisible) {
        _slideController.forward();
      } else {
        _slideController.reverse();
      }

      setState(() {});

      // Handle success navigation. Hold on the success state briefly so the
      // user actually SEES "Deposit Successful" complete on the deposit screen
      // before we auto-advance to the dashboard (the host used to navigate
      // synchronously, flashing the dashboard before this rendered). The
      // `mounted` guard makes this safe if the user taps "Go to Dashboard"
      // first (that pops/disposes the sheet, so this no-ops).
      if (widget.controller.stage == DirectPayStage.success &&
          widget.onSuccess != null) {
        Future.delayed(const Duration(milliseconds: 1400), () {
          if (mounted && widget.onSuccess != null) {
            widget.onSuccess!();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  String get _currencySymbol {
    switch (widget.controller.currency) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return '₦';
    }
  }

  /// Dismiss the sheet RELIABLY. `controller.hide()` only collapses the content
  /// to SizedBox.shrink(); the showModalBottomSheet route + its barrier stay
  /// mounted and keep eating touches. So the SHEET owns popping its own route
  /// here — never relying on the host callback to do it, because a callback can
  /// legitimately no-op (e.g. onExit → _navigateToDashboard early-returns when
  /// the dashboard redirect already ran) and leave the barrier stuck. The
  /// callback is then only responsible for post-dismiss side effects (navigate /
  /// retry / KYC). The host's whenComplete resets its _isProgressSheetShown flag
  /// when the route pops, so the sheet can always reopen.
  void _dismiss(BuildContext context, [VoidCallback? then]) {
    widget.controller.hide();
    final nav = Navigator.of(context);
    if (nav.canPop()) nav.pop();
    if (then != null) then();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.isVisible) {
      return const SizedBox.shrink();
    }

    final stage = widget.controller.stage;
    final isTerminal =
        stage == DirectPayStage.success || stage == DirectPayStage.failed;

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top row: centered drag handle + a cancel (X). The sheet is
              // isDismissible:false / enableDrag:false, so this X is the user's
              // only way to bail out of a stuck/long-running step.
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 4.w),
                child: Row(
                  children: [
                    SizedBox(width: 40.w), // balances the X so the handle stays centered
                    Expanded(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 4.h),
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.white.withValues(alpha: 0.75),
                          size: 22.sp),
                      tooltip: 'Close',
                      // The sheet pops its OWN route (see _dismiss); the host
                      // callback only runs post-dismiss side effects.
                      onPressed: () =>
                          _dismiss(context, widget.onDismiss ?? widget.onExit),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Progress indicator
              _buildProgressSteps(stage),
              SizedBox(height: 24.h),

              // Animated icon
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isTerminal ? 1.0 : _pulseAnimation.value,
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: stage.color.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: stage.color.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        stage.icon,
                        color: stage.color,
                        size: 40.sp,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),

              // Stage title (failure can override with a friendlier title)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Builder(
                  builder: (_) {
                    final title = (stage == DirectPayStage.failed
                            ? widget.controller.errorTitle
                            : null) ??
                        stage.titleFor(widget.controller.flow);
                    return Text(
                      title,
                      key: ValueKey(title),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.h),

              // Stage description
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.controller.errorMessage ??
                      stage.descriptionFor(widget.controller.flow),
                  key: ValueKey(widget.controller.errorMessage ??
                      stage.descriptionFor(widget.controller.flow)),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: stage == DirectPayStage.failed
                        ? Colors.red.withValues(alpha: 0.8)
                        : Colors.white.withValues(alpha: 0.7),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Amount display
              if (widget.controller.amount != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.controller.bankName ?? 'Bank',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        width: 1,
                        height: 16.h,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        '$_currencySymbol${widget.controller.amount!.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 24.h),

              // Action buttons for terminal states
              if (stage == DirectPayStage.success)
                _buildPrimaryButton(
                  label: 'Go to Dashboard',
                  color: const Color(0xFF10B981),
                  onPressed: () => _dismiss(context, widget.onSuccess),
                )
              else if (stage == DirectPayStage.failed &&
                  widget.controller.kycRequired) ...[
                // KYC gate: the deposit/mandate can't proceed until the user
                // verifies their BVN. Primary CTA routes into verification;
                // secondary just dismisses (no stuck spinner left behind).
                _buildPrimaryButton(
                  label: 'Verify Now',
                  color: const Color.fromARGB(255, 78, 3, 208),
                  onPressed: () => _dismiss(
                      context, widget.onKycVerify ?? widget.onDismiss),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () =>
                          _dismiss(context, widget.onExit ?? widget.onDismiss),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withValues(alpha: 0.7),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (stage == DirectPayStage.failed) ...[
                // Primary recovery action depends on whether retrying the
                // exact same deposit can plausibly succeed. Transient errors
                // (network, provider down, timeout, cancelled auth) → re-run
                // the deposit. Terminal errors (insufficient funds, currency
                // mismatch, unsupported bank) → send the user back to the
                // form to fix the input, since an identical retry would fail.
                if (widget.controller.retryable && widget.onRetry != null)
                  _buildPrimaryButton(
                    label: widget.controller.retryLabel ?? 'Try Again',
                    color: const Color.fromARGB(255, 78, 3, 208),
                    onPressed: () => _dismiss(context, widget.onRetry),
                  )
                else
                  _buildPrimaryButton(
                    label: 'Edit Deposit',
                    color: Colors.grey.shade700,
                    onPressed: () =>
                        _dismiss(context, widget.onDismiss ?? widget.onExit),
                  ),
                SizedBox(height: 8.h),
                // Secondary: bail out to the dashboard.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () =>
                          _dismiss(context, widget.onExit ?? widget.onDismiss),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withValues(alpha: 0.7),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'Back to Dashboard',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSteps(DirectPayStage currentStage) {
    // The rail is journey-specific: a redeposit on an already-linked bank has
    // no "Linking Account" step, so it renders 3 dots instead of 4.
    final flow = widget.controller.flow;
    final stages = flow.steps;
    // On failure, position the rail at the step we actually failed at (red X
    // there, green before, inactive after) instead of running all steps to
    // completion. success still ranks past the end (all green).
    final currentIndex = currentStage == DirectPayStage.failed
        ? flow.indexOf(widget.controller.failedAtStage ?? stages.first)
        : flow.indexOf(currentStage);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        children: List.generate(stages.length * 2 - 1, (index) {
          if (index.isOdd) {
            // Connector line
            final prevStageIndex = (index - 1) ~/ 2;
            final isCompleted = currentIndex > prevStageIndex;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2.h,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF10B981)
                      : Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
            );
          } else {
            // Step indicator
            final stageIndex = index ~/ 2;
            final stage = stages[stageIndex];
            final isActive = currentIndex == stageIndex &&
                currentStage != DirectPayStage.failed;
            final isCompleted = currentIndex > stageIndex;
            final isFailed = currentStage == DirectPayStage.failed &&
                currentIndex == stageIndex;

            return _buildStepIndicator(
              isActive: isActive,
              isCompleted: isCompleted,
              isFailed: isFailed,
              stage: stage,
            );
          }
        }),
      ),
    );
  }

  Widget _buildStepIndicator({
    required bool isActive,
    required bool isCompleted,
    required bool isFailed,
    required DirectPayStage stage,
  }) {
    Color bgColor;
    Color borderColor;
    Widget? child;

    if (isCompleted) {
      bgColor = const Color(0xFF10B981);
      borderColor = const Color(0xFF10B981);
      child = Icon(Icons.check, color: Colors.white, size: 14.sp);
    } else if (isFailed) {
      bgColor = Colors.red;
      borderColor = Colors.red;
      child = Icon(Icons.close, color: Colors.white, size: 14.sp);
    } else if (isActive) {
      bgColor = const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2);
      borderColor = const Color.fromARGB(255, 78, 3, 208);
      child = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 8.w * _pulseAnimation.value,
            height: 8.w * _pulseAnimation.value,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 78, 3, 208),
              shape: BoxShape.circle,
            ),
          );
        },
      );
    } else {
      bgColor = Colors.transparent;
      borderColor = Colors.white.withValues(alpha: 0.3);
      child = null;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Center(child: child),
    );
  }
}

/// Show DirectPay progress as an overlay
void showDirectPayProgressOverlay({
  required BuildContext context,
  required DirectPayProgressController controller,
  VoidCallback? onSuccess,
  VoidCallback? onDismiss,
  VoidCallback? onRetry,
  VoidCallback? onExit,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    // The sheet pops its OWN route (DirectPayProgressBottomsheet._dismiss), so
    // these callbacks are post-dismiss side effects only — they must NOT pop
    // (double-pop would remove the wrong route).
    builder: (context) => DirectPayProgressBottomsheet(
      controller: controller,
      onSuccess: onSuccess,
      onDismiss: onDismiss,
      onRetry: onRetry,
      onExit: onExit,
    ),
  );
}
