import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

enum QrScanAction { confirm, rescan, cancel }

class QrScanConfirmationSheet extends StatefulWidget {
  final UserSearchResultEntity user;
  final int? requestedAmount;
  final String? requestedCurrency;
  final VoidCallback onConfirm;
  final VoidCallback onRescan;

  const QrScanConfirmationSheet({
    super.key,
    required this.user,
    this.requestedAmount,
    this.requestedCurrency,
    required this.onConfirm,
    required this.onRescan,
  });

  /// Shows the confirmation sheet and returns the user's action.
  static Future<QrScanAction?> show(
    BuildContext context, {
    required UserSearchResultEntity user,
    int? requestedAmount,
    String? requestedCurrency,
  }) async {
    QrScanAction? action;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => QrScanConfirmationSheet(
        user: user,
        requestedAmount: requestedAmount,
        requestedCurrency: requestedCurrency,
        onConfirm: () {
          action = QrScanAction.confirm;
          Navigator.of(ctx).pop();
        },
        onRescan: () {
          action = QrScanAction.rescan;
          Navigator.of(ctx).pop();
        },
      ),
    );
    return action;
  }

  @override
  State<QrScanConfirmationSheet> createState() =>
      _QrScanConfirmationSheetState();
}

class _QrScanConfirmationSheetState extends State<QrScanConfirmationSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _buildDragHandle(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  _buildHeaderBadge(),
                  SizedBox(height: 24.h),
                  _buildProfileSection(),
                  SizedBox(height: 24.h),
                  _buildAccountDetailsCard(),
                  if (widget.requestedAmount != null) ...[
                    SizedBox(height: 16.h),
                    _buildAmountRequestCard(),
                  ],
                  SizedBox(height: 16.h),
                  _buildInfoBox(),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
          _buildBottomActions(),
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

  Widget _buildHeaderBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.qr_code_scanner,
            color: const Color(0xFF10B981),
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'Scanned via QR',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                width: 3,
              ),
            ),
            child: widget.user.profilePicture.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      widget.user.profilePicture,
                      fit: BoxFit.cover,
                      width: 80.w,
                      height: 80.h,
                      errorBuilder: (_, __, ___) => _buildInitials(),
                    ),
                  )
                : _buildInitials(),
          ),
          SizedBox(height: 16.h),
          Text(
            widget.user.fullName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '@${widget.user.username}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4E03D0),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified,
                color: const Color(0xFF10B981),
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                'LazerVault User',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        widget.user.initials,
        style: TextStyle(
          color: const Color(0xFF4E03D0),
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4E03D0),
            Color(0xFF5F14E1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'LazerVault',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
          SizedBox(height: 20.h),
          Text(
            'Account Holder',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.user.fullName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Account',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '@${widget.user.username}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRequestCard() {
    final amount = widget.requestedAmount!;
    final currency = widget.requestedCurrency ?? 'NGN';
    final displayAmount = (amount / 100).toStringAsFixed(2);

    String currencySymbol;
    switch (currency.toUpperCase()) {
      case 'NGN':
        currencySymbol = '\u20A6';
        break;
      case 'USD':
        currencySymbol = '\$';
        break;
      case 'GBP':
        currencySymbol = '\u00A3';
        break;
      case 'EUR':
        currencySymbol = '\u20AC';
        break;
      default:
        currencySymbol = currency;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.payments_outlined,
              color: const Color(0xFF10B981),
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Requested Amount',
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$currencySymbol$displayAmount',
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFBBF24),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: const Color(0xFFD97706),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Confirm this is the person you want to send money to.',
              style: TextStyle(
                color: const Color(0xFF92400E),
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onRescan,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  side: const BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner,
                      color: const Color(0xFF374151),
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Rescan',
                      style: TextStyle(
                        color: const Color(0xFF374151),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: widget.onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  backgroundColor: const Color(0xFF4E03D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send Money',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
