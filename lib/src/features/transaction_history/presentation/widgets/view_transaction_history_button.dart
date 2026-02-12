import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/types/transaction_service_mapping.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_history_navigation_helper.dart';

/// Reusable "View Transaction History" button widget
///
/// This widget provides a consistent way to navigate to transaction history
/// from various service screens throughout the app.
///
/// Usage:
/// ```dart
/// // For a specific service
/// ViewTransactionHistoryButton(
///   serviceName: AppServiceName.airtime,
/// )
///
/// // For all transactions (dashboard)
/// ViewTransactionHistoryButton.showAll()
/// ```
class ViewTransactionHistoryButton extends StatelessWidget {
  final AppServiceName? serviceName;
  final TransactionServiceType? serviceType;
  final String? customLabel;
  final IconData? icon;
  final Color? buttonColor;
  final bool isFullWidth;
  final bool isOutlined;
  final VoidCallback? onPressed;

  const ViewTransactionHistoryButton({
    super.key,
    this.serviceName,
    this.serviceType,
    this.customLabel,
    this.icon,
    this.buttonColor,
    this.isFullWidth = false,
    this.isOutlined = false,
    this.onPressed,
  }) : assert(
          serviceName != null || serviceType != null,
          'Either serviceName or serviceType must be provided',
        );

  /// Create button for all transactions (dashboard view)
  factory ViewTransactionHistoryButton.showAll({
    Key? key,
    String? customLabel,
    Color? buttonColor,
    bool isFullWidth = false,
    bool isOutlined = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: null,
      serviceType: null,
      customLabel: customLabel ?? 'View All Transactions',
      icon: Icons.history,
      buttonColor: buttonColor,
      isFullWidth: isFullWidth,
      isOutlined: isOutlined,
      onPressed: onPressed,
    );
  }

  /// Create button for airtime service
  factory ViewTransactionHistoryButton.airtime({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.airtime,
      customLabel: customLabel,
      icon: Icons.phone_android,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for gift cards service
  factory ViewTransactionHistoryButton.giftCards({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.giftCards,
      customLabel: customLabel,
      icon: Icons.card_giftcard,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for electricity service
  factory ViewTransactionHistoryButton.electricity({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.payBills,
      customLabel: customLabel,
      icon: Icons.bolt,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for crypto service
  factory ViewTransactionHistoryButton.crypto({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.crypto,
      customLabel: customLabel,
      icon: Icons.currency_bitcoin,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for stocks service
  factory ViewTransactionHistoryButton.stocks({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.stocks,
      customLabel: customLabel,
      icon: Icons.trending_up,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for insurance service
  factory ViewTransactionHistoryButton.insurance({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.insurance,
      customLabel: customLabel,
      icon: Icons.security,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for tag pay service
  factory ViewTransactionHistoryButton.tagPay({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.tagPay,
      customLabel: customLabel,
      icon: Icons.local_offer,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  /// Create button for autosave service
  factory ViewTransactionHistoryButton.autoSave({
    Key? key,
    String? customLabel,
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ViewTransactionHistoryButton(
      key: key,
      serviceName: AppServiceName.autoSave,
      customLabel: customLabel,
      icon: Icons.savings,
      isFullWidth: isFullWidth,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveServiceType = serviceType ?? serviceName?.toTransactionServiceType;

    if (effectiveServiceType == null && serviceName == null) {
      return const SizedBox.shrink();
    }

    final label = customLabel ??
        (effectiveServiceType != null
            ? 'View ${effectiveServiceType.displayName} History'
            : 'View All Transactions');

    final effectiveIcon = icon ??
        (effectiveServiceType != null ? effectiveServiceType.icon : Icons.history);

    final effectiveColor = buttonColor ??
        (effectiveServiceType != null ? effectiveServiceType.color : const Color(0xFF581CD9));

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        child: _buildButton(label, effectiveIcon, effectiveColor),
      );
    }

    return _buildButton(label, effectiveIcon, effectiveColor);
  }

  Widget _buildButton(String label, IconData icon, Color color) {
    final button = ElevatedButton.icon(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          _handleNavigation();
        }
      },
      icon: Icon(icon, size: 18.sp),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined
            ? Colors.transparent
            : color.withValues(alpha: 0.15),
        foregroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        side: isOutlined
            ? BorderSide(color: color, width: 1.5)
            : BorderSide(color: color.withValues(alpha: 0.3), width: 1),
      ),
    );

    return button;
  }

  void _handleNavigation() {
    final effectiveServiceType = serviceType ?? serviceName?.toTransactionServiceType;

    if (effectiveServiceType != null) {
      // Navigate to service-specific history
      TransactionHistoryNavigationHelper.navigateToServiceHistory(effectiveServiceType);
    } else {
      // Navigate to dashboard (all transactions)
      TransactionHistoryNavigationHelper.navigateToDashboard();
    }
  }
}

/// Text-only variant for more subtle navigation
class ViewTransactionHistoryTextButton extends StatelessWidget {
  final AppServiceName? serviceName;
  final TransactionServiceType? serviceType;
  final String? customLabel;
  final Color? textColor;
  final VoidCallback? onPressed;

  const ViewTransactionHistoryTextButton({
    super.key,
    this.serviceName,
    this.serviceType,
    this.customLabel,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveServiceType = serviceType ?? serviceName?.toTransactionServiceType;
    final effectiveColor = textColor ??
        (effectiveServiceType != null ? effectiveServiceType.color : const Color(0xFF581CD9));

    final label = customLabel ??
        (effectiveServiceType != null
            ? '${effectiveServiceType.displayName} History'
            : 'View All Transactions');

    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else if (effectiveServiceType != null) {
          TransactionHistoryNavigationHelper.navigateToServiceHistory(effectiveServiceType);
        } else {
          TransactionHistoryNavigationHelper.navigateToDashboard();
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: effectiveColor,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,
            color: effectiveColor,
          ),
        ],
      ),
    );
  }
}

/// Icon-only variant for minimal UI
class ViewTransactionHistoryIconButton extends StatelessWidget {
  final AppServiceName? serviceName;
  final TransactionServiceType? serviceType;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const ViewTransactionHistoryIconButton({
    super.key,
    this.serviceName,
    this.serviceType,
    this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveServiceType = serviceType ?? serviceName?.toTransactionServiceType;
    final effectiveColor = iconColor ??
        (effectiveServiceType != null ? effectiveServiceType.color : Colors.white70);

    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else if (effectiveServiceType != null) {
          TransactionHistoryNavigationHelper.navigateToServiceHistory(effectiveServiceType);
        } else {
          TransactionHistoryNavigationHelper.navigateToDashboard();
        }
      },
      icon: Icon(
        Icons.history,
        color: effectiveColor,
      ),
      tooltip: 'View Transaction History',
    );
  }
}
