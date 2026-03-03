import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// Confirmation bottom sheet shown after selecting a LazerVault user by username.
/// Displays the user's profile picture, name, username, and account info.
/// Allows saving to favorites before confirming.
class UsernameRecipientConfirmationSheet extends StatefulWidget {
  final UserSearchResultEntity user;
  final String? accountNumber;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const UsernameRecipientConfirmationSheet({
    super.key,
    required this.user,
    this.accountNumber,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<UsernameRecipientConfirmationSheet> createState() =>
      UsernameRecipientConfirmationSheetState();
}

class UsernameRecipientConfirmationSheetState
    extends State<UsernameRecipientConfirmationSheet>
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

  /// Whether recipient should be saved to the recipients list.
  bool get isSaved => _isSaved;

  bool get isFavorite => _isFavorite;

  /// Get alias.
  String? get alias => _alias;

  double get _sheetHeightFraction => _isSaved ? 0.92 : 0.82;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      height: MediaQuery.of(context).size.height * _sheetHeightFraction,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 36.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 10.h, bottom: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 8.h),
                        _buildProfileSection(),
                        SizedBox(height: 20.h),
                        _buildAccountCard(),
                        SizedBox(height: 16.h),
                        _buildContactAndInfo(),
                        SizedBox(height: 16.h),
                        _buildToggles(),
                        _buildAliasInput(),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Column(
        children: [
          // Avatar
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                width: 2.5,
              ),
            ),
            child: widget.user.profilePicture.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      widget.user.profilePicture,
                      fit: BoxFit.cover,
                      width: 56.w,
                      height: 56.w,
                      errorBuilder: (_, __, ___) => _buildInitials(),
                    ),
                  )
                : _buildInitials(),
          ),
          SizedBox(height: 10.h),
          // Name
          Text(
            widget.user.fullName,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          // @ badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '@${widget.user.username}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4E03D0),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          // Verified
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: const Color(0xFF10B981), size: 15.sp),
              SizedBox(width: 4.w),
              Text(
                'LazerVault User',
                style: TextStyle(
                  fontSize: 12.sp,
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
          fontSize: 26.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountCard() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4E03D0), Color(0xFF5F14E1)],
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
          // Bank header
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.account_balance, color: Colors.white, size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Text(
                'LazerVault',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
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
            widget.user.fullName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 14.h),
          // Personal account
          Text(
            'Personal Account',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.accountNumber ?? '@${widget.user.username}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          // Alias
          if (_alias != null && _alias!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.label_outline, color: Colors.white70, size: 14.sp),
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

  Widget _buildContactAndInfo() {
    final hasEmail = widget.user.email.isNotEmpty;
    final hasPhone = widget.user.phoneNumber.isNotEmpty;

    return Column(
      children: [
        // Contact row
        if (hasEmail || hasPhone)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                if (hasEmail) ...[
                  _buildContactItem(Icons.email_outlined, 'Email', widget.user.email),
                ],
                if (hasEmail && hasPhone) ...[
                  Container(
                    width: 1,
                    height: 40.h,
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    color: const Color(0xFFE5E7EB),
                  ),
                ],
                if (hasPhone) ...[
                  _buildContactItem(Icons.phone_outlined, 'Phone', widget.user.phoneNumber),
                ],
              ],
            ),
          ),
        SizedBox(height: 10.h),
        // Info bar
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFFBBF24)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: const Color(0xFFD97706), size: 18.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Confirm this is the person you want to send money to.',
                  style: TextStyle(
                    color: const Color(0xFF92400E),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: const Color(0xFF4E03D0), size: 16.sp),
          ),
          SizedBox(width: 10.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: const Color(0xFF374151),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggles() {
    return Column(
      children: [
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
        if (_isSaved)
          SizedBox(
            height: 40.h,
            child: Row(
              children: [
                Icon(
                  _isFavorite ? Icons.star : Icons.star_outline,
                  color: _isFavorite ? const Color(0xFFF59E0B) : const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Add to Favorites',
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
    return SizedBox(
      height: 46.h,
      child: TextFormField(
        maxLength: 50,
        style: TextStyle(fontSize: 13.sp),
        decoration: InputDecoration(
          hintText: 'Alias (optional) e.g. Mom',
          hintStyle: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
          counterText: '',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
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
            Expanded(
              child: OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
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
                      'Confirm & Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.send_rounded, color: Colors.white, size: 18.sp),
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
