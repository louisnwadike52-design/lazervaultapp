import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';

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
    super.key,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    required this.bankCode,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<AccountConfirmationBottomSheet> createState() =>
      AccountConfirmationBottomSheetState();
}

class AccountConfirmationBottomSheetState
    extends State<AccountConfirmationBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _isSaved = true; // Save recipient ON by default.
  // Favorites are managed from the recipients list (star / 3-dot), not here.
  final bool _isFavorite = false;
  String? _alias;
  // While the alias field is focused we compress the account card + hide the
  // info box so the field stays visible above the keyboard (the sheet no longer
  // rides up under the keyboard or hides the field being typed).
  bool _aliasEditing = false;
  final FocusNode _aliasFocusNode = FocusNode();
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
    _aliasFocusNode.addListener(() {
      if (!mounted) return;
      final editing = _aliasFocusNode.hasFocus;
      if (editing != _aliasEditing) setState(() => _aliasEditing = editing);
    });
  }

  @override
  void dispose() {
    _aliasFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      // Lift the whole sheet above the keyboard so the alias field is never
      // covered; the animation keeps it smooth as the keyboard opens/closes.
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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

          // Content — scrollable so that on the smallest screens the content +
          // keyboard can never exceed the sheet height and throw a RenderFlex
          // overflow; it just scrolls instead. Flexible bounds it to the space
          // left above the (keyboard-lifted) bottom actions.
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12.h),

                  // Account Details Card — compresses to a compact row while the
                  // alias field is focused so it (and the field) stay visible.
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: _buildAccountDetailsCard(compact: _aliasEditing),
                  ),

                  // Warning Info Box — hidden while typing the alias to free the
                  // vertical room the field needs above the keyboard; reshown after.
                  if (!_aliasEditing) ...[
                    SizedBox(height: 16.h),
                    _buildInfoBox(),
                  ],

                  SizedBox(height: 16.h),

                  // Favorite Toggle
                  _buildFavoriteToggle(),

                  // Alias Input (shown when favorite is toggled on)
                  _buildAliasInput(),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Bottom Action Buttons
          _buildBottomActions(),
        ],
      ),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Container(
      width: 36.w,
      height: 4.h,
      margin: EdgeInsets.only(top: 10.h, bottom: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD1D5DB),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          // Success Icon with animation
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: const Color(0xFF10B981),
                size: 22.sp,
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Title
          Expanded(
            child: Text(
              'Account Verified',
              style: TextStyle(
                fontSize: 17.sp,
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
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountDetailsCard({bool compact = false}) {
    // Compact: a single bank-logo + name row (used while the alias field is
    // focused so the card shrinks out of the keyboard's way).
    if (compact) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4E03D0), Color(0xFF5F14E1)],
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            BankLogo(
                bankName: widget.bankName,
                bankCode: widget.bankCode,
                size: 30.w),
            SizedBox(width: 10.w),
            Expanded(
              // Keep BOTH the name and the account NUMBER visible in compact
              // mode — the user is verifying this recipient while typing an
              // alias, so the number must never scroll out of view.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.accountName.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    widget.accountNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF5F14E1),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bank name row
          Row(
            children: [
              BankLogo(
                bankName: widget.bankName,
                bankCode: widget.bankCode,
                size: 36.w,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  BanksData.displayName(widget.bankName, widget.bankCode),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),
          SizedBox(height: 14.h),

          // Account holder
          Text(
            'Account Holder',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.accountName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),

          SizedBox(height: 14.h),

          // Account number
          Text(
            'Account No.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.accountNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),

          // Alias display
          if (_alias != null && _alias!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.label_outline,
                  color: Colors.white70,
                  size: 14.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Alias: $_alias',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(10.r),
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
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Double-check the name matches the intended recipient.',
              style: TextStyle(
                color: const Color(0xFF92400E),
                fontSize: 12.sp,
                height: 1.4,
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
          height: 40.h,
          child: Row(
            children: [
              Icon(
                _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                color: _isSaved ? const Color(0xFF4E03D0) : const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Save Recipient',
                  style: TextStyle(
                    color: const Color(0xFF374151),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: _isSaved,
                  onChanged: (value) {
                    setState(() => _isSaved = value);
                  },
                  activeThumbColor: const Color(0xFF4E03D0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
        // Favorites are no longer set here — they're toggled from each saved
        // recipient (the star on the row / the 3-dot menu) on the recipients
        // screen, so this sheet stays focused on verify + save.
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
                focusNode: _aliasFocusNode,
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
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: const Color(0xFFF3F4F6), width: 1)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Cancel button
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onCancel,
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
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: const Color(0xFF374151),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Confirm button
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
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 18.sp,
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
