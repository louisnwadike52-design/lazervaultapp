import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// DirectPay Progress Stage
enum DirectPayStage {
  linking,
  initiating,
  authorizing,
  processing,
  success,
  failed,
}

/// Which user journey the dark progress sheet narrates. The step rail and the
/// stage copy adapt to it:
/// - [linkAndDeposit]: fresh bank via Mono Connect → 4 steps starting at
///   "Linking Account".
/// - [redeposit]: an ALREADY-LINKED bank ("Deposit again" card / post-mandate
///   resume) → 3 steps, never shows "Linking Account".
/// - [mandateSetup]: recurring toggle ON → 4 steps with Direct Debit wording
///   for the setup/authorization stages.
enum DirectPayProgressFlow {
  linkAndDeposit,
  redeposit,
  mandateSetup,
}

extension DirectPayProgressFlowSteps on DirectPayProgressFlow {
  /// The non-terminal stages shown on the step rail, in order.
  List<DirectPayStage> get steps {
    switch (this) {
      case DirectPayProgressFlow.linkAndDeposit:
      case DirectPayProgressFlow.mandateSetup:
        return const [
          DirectPayStage.linking,
          DirectPayStage.initiating,
          DirectPayStage.authorizing,
          DirectPayStage.processing,
        ];
      case DirectPayProgressFlow.redeposit:
        return const [
          DirectPayStage.initiating,
          DirectPayStage.authorizing,
          DirectPayStage.processing,
        ];
    }
  }

  /// Rail position of [stage] for this flow. Terminal stages (success/failed)
  /// rank past the end so every step renders completed; a stage that isn't on
  /// this flow's rail (defensive) clamps to 0.
  int indexOf(DirectPayStage stage) {
    if (stage == DirectPayStage.success || stage == DirectPayStage.failed) {
      return steps.length;
    }
    final i = steps.indexOf(stage);
    return i < 0 ? 0 : i;
  }
}

/// Extension to get stage details
extension DirectPayStageExtension on DirectPayStage {
  String get title => titleFor(DirectPayProgressFlow.linkAndDeposit);

  /// Flow-aware stage title. The same stage reads differently depending on the
  /// journey: a redeposit never links, and a mandate setup authorizes a Direct
  /// Debit rather than a single payment.
  String titleFor(DirectPayProgressFlow flow) {
    switch (this) {
      case DirectPayStage.linking:
        return 'Linking Account';
      case DirectPayStage.initiating:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Setting Up Direct Debit'
            : (flow == DirectPayProgressFlow.redeposit
                ? 'Preparing Deposit'
                : 'Initiating Payment');
      case DirectPayStage.authorizing:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Authorize Direct Debit'
            : 'Authorizing Payment';
      case DirectPayStage.processing:
        return 'Processing Deposit';
      case DirectPayStage.success:
        return 'Deposit Successful';
      case DirectPayStage.failed:
        return 'Deposit Failed';
    }
  }

  String get description =>
      descriptionFor(DirectPayProgressFlow.linkAndDeposit);

  /// Flow-aware stage description (see [titleFor]).
  String descriptionFor(DirectPayProgressFlow flow) {
    switch (this) {
      case DirectPayStage.linking:
        return 'Securely connecting to your bank...';
      case DirectPayStage.initiating:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Creating your Direct Debit mandate...'
            : 'Setting up your deposit...';
      case DirectPayStage.authorizing:
        return flow == DirectPayProgressFlow.mandateSetup
            ? 'Approve the Direct Debit at your bank...'
            : 'Please complete authorization...';
      case DirectPayStage.processing:
        return 'Your deposit is being processed...';
      case DirectPayStage.success:
        return 'Your funds have been deposited!';
      case DirectPayStage.failed:
        return 'Something went wrong';
    }
  }

  IconData get icon {
    switch (this) {
      case DirectPayStage.linking:
        return Icons.link;
      case DirectPayStage.initiating:
        return Icons.receipt_long;
      case DirectPayStage.authorizing:
        return Icons.security;
      case DirectPayStage.processing:
        return Icons.sync;
      case DirectPayStage.success:
        return Icons.check_circle;
      case DirectPayStage.failed:
        return Icons.error;
    }
  }

  Color get color {
    switch (this) {
      case DirectPayStage.linking:
      case DirectPayStage.initiating:
      case DirectPayStage.authorizing:
      case DirectPayStage.processing:
        return const Color.fromARGB(255, 78, 3, 208);
      case DirectPayStage.success:
        return const Color(0xFF10B981);
      case DirectPayStage.failed:
        return Colors.red;
    }
  }

  int get stageIndex {
    switch (this) {
      case DirectPayStage.linking:
        return 0;
      case DirectPayStage.initiating:
        return 1;
      case DirectPayStage.authorizing:
        return 2;
      case DirectPayStage.processing:
        return 3;
      case DirectPayStage.success:
      case DirectPayStage.failed:
        return 4;
    }
  }
}

/// Controller for managing DirectPay progress
class DirectPayProgressController extends ChangeNotifier {
  DirectPayStage _stage = DirectPayStage.linking;
  DirectPayProgressFlow _flow = DirectPayProgressFlow.linkAndDeposit;
  String? _errorMessage;
  String? _errorTitle;
  bool _retryable = true;
  String? _bankName;
  double? _amount;
  String? _currency;
  bool _isVisible = false;

  DirectPayStage get stage => _stage;
  DirectPayProgressFlow get flow => _flow;
  String? get errorMessage => _errorMessage;
  String? get errorTitle => _errorTitle;
  bool get retryable => _retryable;
  String? get bankName => _bankName;
  double? get amount => _amount;
  String? get currency => _currency;
  bool get isVisible => _isVisible;

  void show({
    required String bankName,
    required double amount,
    required String currency,
    DirectPayProgressFlow flow = DirectPayProgressFlow.linkAndDeposit,
  }) {
    _bankName = bankName;
    _amount = amount;
    _currency = currency;
    _flow = flow;
    // Start at the first stage of THIS journey — a redeposit on an
    // already-linked bank must never open on "Linking Account".
    _stage = flow.steps.first;
    _errorMessage = null;
    _errorTitle = null;
    _retryable = true;
    _isVisible = true;
    notifyListeners();
  }

  void updateStage(
    DirectPayStage stage, {
    String? errorMessage,
    String? errorTitle,
    bool retryable = true,
  }) {
    _stage = stage;
    _errorMessage = errorMessage;
    _errorTitle = errorTitle;
    _retryable = retryable;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void reset() {
    _stage = DirectPayStage.linking;
    _flow = DirectPayProgressFlow.linkAndDeposit;
    _errorMessage = null;
    _errorTitle = null;
    _retryable = true;
    _bankName = null;
    _amount = null;
    _currency = null;
    _isVisible = false;
    notifyListeners();
  }
}

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

  const DirectPayProgressBottomsheet({
    super.key,
    required this.controller,
    this.onDismiss,
    this.onSuccess,
    this.onRetry,
    this.onExit,
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
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),

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
                  onPressed: () {
                    widget.controller.hide();
                    if (widget.onSuccess != null) widget.onSuccess!();
                  },
                )
              else if (stage == DirectPayStage.failed) ...[
                // Primary recovery action depends on whether retrying the
                // exact same deposit can plausibly succeed. Transient errors
                // (network, provider down, timeout, cancelled auth) → re-run
                // the deposit. Terminal errors (insufficient funds, currency
                // mismatch, unsupported bank) → send the user back to the
                // form to fix the input, since an identical retry would fail.
                if (widget.controller.retryable && widget.onRetry != null)
                  _buildPrimaryButton(
                    label: 'Try Again',
                    color: const Color.fromARGB(255, 78, 3, 208),
                    onPressed: () {
                      widget.controller.hide();
                      widget.onRetry!();
                    },
                  )
                else
                  _buildPrimaryButton(
                    label: 'Edit Deposit',
                    color: Colors.grey.shade700,
                    onPressed: () {
                      widget.controller.hide();
                      if (widget.onDismiss != null) widget.onDismiss!();
                    },
                  ),
                SizedBox(height: 8.h),
                // Secondary: bail out to the dashboard.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        widget.controller.hide();
                        if (widget.onExit != null) {
                          widget.onExit!();
                        } else if (widget.onDismiss != null) {
                          widget.onDismiss!();
                        }
                      },
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
    final currentIndex = flow.indexOf(currentStage);

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
    builder: (context) => DirectPayProgressBottomsheet(
      controller: controller,
      onSuccess: () {
        Navigator.of(context).pop();
        if (onSuccess != null) onSuccess();
      },
      onDismiss: () {
        Navigator.of(context).pop();
        if (onDismiss != null) onDismiss();
      },
      onRetry: onRetry == null
          ? null
          : () {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              onRetry();
            },
      onExit: onExit,
    ),
  );
}
