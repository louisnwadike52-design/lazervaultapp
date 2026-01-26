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

/// Extension to get stage details
extension DirectPayStageExtension on DirectPayStage {
  String get title {
    switch (this) {
      case DirectPayStage.linking:
        return 'Linking Account';
      case DirectPayStage.initiating:
        return 'Initiating Payment';
      case DirectPayStage.authorizing:
        return 'Authorizing Payment';
      case DirectPayStage.processing:
        return 'Processing Deposit';
      case DirectPayStage.success:
        return 'Deposit Successful';
      case DirectPayStage.failed:
        return 'Deposit Failed';
    }
  }

  String get description {
    switch (this) {
      case DirectPayStage.linking:
        return 'Securely connecting to your bank...';
      case DirectPayStage.initiating:
        return 'Setting up your deposit...';
      case DirectPayStage.authorizing:
        return 'Please complete authorization...';
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
        return const Color(0xFF6C5CE7);
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
  String? _errorMessage;
  String? _bankName;
  double? _amount;
  String? _currency;
  bool _isVisible = false;

  DirectPayStage get stage => _stage;
  String? get errorMessage => _errorMessage;
  String? get bankName => _bankName;
  double? get amount => _amount;
  String? get currency => _currency;
  bool get isVisible => _isVisible;

  void show({
    required String bankName,
    required double amount,
    required String currency,
  }) {
    _bankName = bankName;
    _amount = amount;
    _currency = currency;
    _stage = DirectPayStage.linking;
    _errorMessage = null;
    _isVisible = true;
    notifyListeners();
  }

  void updateStage(DirectPayStage stage, {String? errorMessage}) {
    _stage = stage;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void reset() {
    _stage = DirectPayStage.linking;
    _errorMessage = null;
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

  const DirectPayProgressBottomsheet({
    super.key,
    required this.controller,
    this.onDismiss,
    this.onSuccess,
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

      // Handle success navigation
      if (widget.controller.stage == DirectPayStage.success) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && widget.onSuccess != null) {
            widget.onSuccess!();
          }
        });
      }

      setState(() {});
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
              color: Colors.black.withOpacity(0.3),
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
                  color: Colors.white.withOpacity(0.3),
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
                        color: stage.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: stage.color.withOpacity(0.3),
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

              // Stage title
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  stage.title,
                  key: ValueKey(stage.title),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Stage description
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.controller.errorMessage ?? stage.description,
                  key: ValueKey(widget.controller.errorMessage ?? stage.description),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: stage == DirectPayStage.failed
                        ? Colors.red.withOpacity(0.8)
                        : Colors.white.withOpacity(0.7),
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
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: Colors.white.withOpacity(0.6),
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.controller.bankName ?? 'Bank',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Container(
                        width: 1,
                        height: 16.h,
                        color: Colors.white.withOpacity(0.2),
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

              // Action button for terminal states
              if (isTerminal)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.controller.hide();
                        if (stage == DirectPayStage.success &&
                            widget.onSuccess != null) {
                          widget.onSuccess!();
                        } else if (widget.onDismiss != null) {
                          widget.onDismiss!();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: stage == DirectPayStage.success
                            ? const Color(0xFF10B981)
                            : Colors.grey.shade700,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        stage == DirectPayStage.success
                            ? 'Go to Dashboard'
                            : 'Try Again',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSteps(DirectPayStage currentStage) {
    final stages = [
      DirectPayStage.linking,
      DirectPayStage.initiating,
      DirectPayStage.authorizing,
      DirectPayStage.processing,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        children: List.generate(stages.length * 2 - 1, (index) {
          if (index.isOdd) {
            // Connector line
            final prevStageIndex = (index - 1) ~/ 2;
            final isCompleted = currentStage.stageIndex > prevStageIndex;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2.h,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF10B981)
                      : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
            );
          } else {
            // Step indicator
            final stageIndex = index ~/ 2;
            final stage = stages[stageIndex];
            final isActive = currentStage.stageIndex == stageIndex;
            final isCompleted = currentStage.stageIndex > stageIndex;
            final isFailed = currentStage == DirectPayStage.failed &&
                currentStage.stageIndex == stageIndex;

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
      bgColor = const Color(0xFF6C5CE7).withOpacity(0.2);
      borderColor = const Color(0xFF6C5CE7);
      child = AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 8.w * _pulseAnimation.value,
            height: 8.w * _pulseAnimation.value,
            decoration: const BoxDecoration(
              color: Color(0xFF6C5CE7),
              shape: BoxShape.circle,
            ),
          );
        },
      );
    } else {
      bgColor = Colors.transparent;
      borderColor = Colors.white.withOpacity(0.3);
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
    ),
  );
}
