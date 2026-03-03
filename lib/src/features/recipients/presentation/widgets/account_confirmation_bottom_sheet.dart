import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Account confirmation bottomsheet widget.
///
/// Displays verified account details and asks user to confirm
/// before saving the recipient.
class AccountConfirmationBottomSheet extends StatefulWidget {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String bankCode;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const AccountConfirmationBottomSheet({
    Key? key,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<AccountConfirmationBottomSheet> createState() =>
      AccountConfirmationBottomSheetState();
}

class AccountConfirmationBottomSheetState
    extends State<AccountConfirmationBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _isSaved = false;
  bool _isFavorite = false;
  String? _alias;
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          _buildDragHandle(),

          // Header
          _buildHeader(),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h),

                // Account Details Card
                _buildAccountDetailsCard(),

                SizedBox(height: 8.h),

                // Warning Info Box
                _buildInfoBox(),

                SizedBox(height: 6.h),

                // Favorite Toggle
                _buildFavoriteToggle(),

                // Alias Input (shown when favorite is toggled on)
                _buildAliasInput(),
              ],
            ),
          ),

          SizedBox(height: 4.h),

          // Bottom Action Buttons
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 36.w,
      height: 3.h,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Success Icon with animation
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: const Color(0xFF10B981),
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Title
          Expanded(
            child: Text(
              'Account Verified',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111827),
              ),
            ),
          ),

          // Close button
          GestureDetector(
            onTap: widget.onCancel,
            child: Icon(
              Icons.close,
              color: const Color(0xFF6B7280),
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF5F14E1),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bank name row
          Row(
            children: [
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 13.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  widget.bankName,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),

          // Account holder + account number in a compact 2-column layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account holder
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Holder',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.accountName.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Account number
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Account No.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.accountNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Alias display
          if (_alias != null && _alias!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(
                  Icons.label_outline,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 12.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Alias: $_alias',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: const Color(0xFFFBBF24),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: const Color(0xFFD97706),
            size: 14.sp,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              'Double-check the name matches the intended recipient.',
              style: TextStyle(
                color: const Color(0xFF92400E),
                fontSize: 11.sp,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteToggle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Save Recipient toggle
        SizedBox(
          height: 36.h,
          child: Row(
            children: [
              Icon(
                _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                color: _isSaved ? const Color(0xFF4E03D0) : const Color(0xFF6B7280),
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Save Recipient',
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.75,
                child: Switch(
                  value: _isSaved,
                  onChanged: (value) {
                    setState(() {
                      _isSaved = value;
                      if (!value) _isFavorite = false;
                    });
                  },
                  activeThumbColor: const Color(0xFF4E03D0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        // Add to Favorites toggle (only visible when saved)
        if (_isSaved)
          SizedBox(
            height: 36.h,
            child: Row(
              children: [
                Icon(
                  _isFavorite ? Icons.star : Icons.star_outline,
                  color: _isFavorite ? const Color(0xFFF59E0B) : const Color(0xFF6B7280),
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Add to Favorites',
                    style: TextStyle(
                      color: const Color(0xFF111827),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Transform.scale(
                  scale: 0.75,
                  child: Switch(
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() => _isFavorite = value);
                    },
                    activeThumbColor: const Color(0xFFF59E0B),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAliasInput() {
    if (!_isSaved) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Set Alias (optional)',
              style: TextStyle(
                color: const Color(0xFF374151),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              height: 36.h,
              child: TextFormField(
                maxLength: 50,
                style: TextStyle(fontSize: 12.sp),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'e.g. Mom, Coffee Shop',
                  hintStyle: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 6.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: const BorderSide(color: Color(0xFF4E03D0)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    final trimmed = value.trim();
                    _alias = trimmed.isEmpty ? null : trimmed;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Cancel button
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  side: const BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: const Color(0xFF374151),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(width: 10.w),

            // Confirm button
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: widget.onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  backgroundColor: const Color(0xFF4E03D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 16.sp,
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

  /// Whether recipient should be saved to the recipients list.
  bool get isSaved => _isSaved;

  /// Whether recipient should be marked as favorite.
  bool get isFavorite => _isFavorite;

  /// Get alias.
  String? get alias => _alias;
}
