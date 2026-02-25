import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// Step 3: Review & Send Invitation
/// - Recipient card with user info
/// - Summary of allocation, role, limits
/// - Optional personal message textarea
/// - Send Invitation button with loading state
class ReviewSendStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final FamilyAccountCubit cubit;
  final VoidCallback onSend;
  final Function(String) onUpdateMessage;

  const ReviewSendStep({
    super.key,
    required this.formData,
    required this.cubit,
    required this.onSend,
    required this.onUpdateMessage,
  });

  @override
  State<ReviewSendStep> createState() => _ReviewSendStepState();
}

class _ReviewSendStepState extends State<ReviewSendStep> {
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController(
      text: widget.formData['personalMessage'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  String _formatLimit(double limit) {
    if (limit <= 0) return 'Unlimited';
    return '\$${limit.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.formData['invitationDestination'] as String;
    final userName = widget.formData['selectedUserName'] as String? ?? '';
    final userEmail = widget.formData['selectedUserEmail'] as String? ?? '';
    final userPic = widget.formData['selectedUserProfilePicture'] as String? ?? '';
    final allocation = widget.formData['initialAllocation'] as double;
    final role = widget.formData['role'] as String;
    final noLimits = widget.formData['noLimits'] as bool? ?? true;
    final dailyLimit = widget.formData['dailyLimit'] as double;
    final monthlyLimit = widget.formData['monthlyLimit'] as double;
    final perTxnLimit = widget.formData['perTransactionLimit'] as double;
    final allocCap = widget.formData['allocationPercentageCap'] as double;

    // Build initials from username or name
    String initials = '';
    if (userName.isNotEmpty) {
      final parts = userName.split(' ');
      initials = parts.length >= 2
          ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
          : userName.substring(0, userName.length >= 2 ? 2 : 1).toUpperCase();
    } else if (destination.isNotEmpty) {
      initials = destination.substring(0, destination.length >= 2 ? 2 : 1).toUpperCase();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Review invitation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Confirm the details before sending',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Recipient Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  backgroundImage:
                      userPic.isNotEmpty ? NetworkImage(userPic) : null,
                  child: userPic.isEmpty
                      ? Text(
                          initials,
                          style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (userName.isNotEmpty)
                        Text(
                          userName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      Text(
                        '@$destination',
                        style: TextStyle(
                          color: const Color(0xFF3B82F6),
                          fontSize: 14.sp,
                        ),
                      ),
                      if (userEmail.isNotEmpty) ...[
                        SizedBox(height: 2.h),
                        Text(
                          userEmail,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Summary Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Allocation & Role
                _buildSectionHeader(
                    'Allocation & Role', Icons.account_balance_wallet_outlined),
                SizedBox(height: 12.h),
                _buildDetailRow(
                    'Initial Allocation', '\$${allocation.toStringAsFixed(2)}'),
                SizedBox(height: 8.h),
                _buildDetailRow(
                  'Role',
                  role == 'admin' ? 'Admin' : 'Member',
                  valueColor:
                      role == 'admin' ? const Color(0xFF3B82F6) : null,
                ),
                SizedBox(height: 20.h),

                Divider(color: const Color(0xFF2D2D2D), height: 1),
                SizedBox(height: 20.h),

                // Spending Limits
                _buildSectionHeader(
                    'Spending Limits', Icons.shield_outlined),
                SizedBox(height: 12.h),
                if (noLimits)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color:
                          const Color(0xFF3B82F6).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.all_inclusive,
                          color: const Color(0xFF3B82F6),
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'No Spending Limits',
                          style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  _buildDetailRow(
                      'Daily Limit', _formatLimit(dailyLimit)),
                  SizedBox(height: 8.h),
                  _buildDetailRow(
                      'Monthly Limit', _formatLimit(monthlyLimit)),
                  SizedBox(height: 8.h),
                  _buildDetailRow(
                      'Per-Transaction', _formatLimit(perTxnLimit)),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Allocation Cap',
                      '${allocCap.toStringAsFixed(0)}% of pool'),
                ],
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Personal Message
          Text(
            'Personal Message (Optional)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _messageController,
            maxLines: 3,
            maxLength: 500,
            onChanged: widget.onUpdateMessage,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText:
                  'Hey! I\'d love to have you join our family account...',
              hintStyle: TextStyle(
                color: const Color(0xFF6B7280),
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide:
                    const BorderSide(color: Color(0xFF3B82F6), width: 2),
              ),
              contentPadding: EdgeInsets.all(16.w),
              counterStyle: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Send Button
          BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
            bloc: widget.cubit,
            builder: (context, state) {
              final isLoading = state is FamilyMemberAdding;

              return Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                  ),
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color(0xFF3B82F6).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isLoading ? null : widget.onSend,
                    borderRadius: BorderRadius.circular(28.r),
                    child: Center(
                      child: isLoading
                          ? SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Send Invitation',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16.h),

          // Info Text
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF3B82F6),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'The recipient will receive an invitation to join your family account. You can modify their limits anytime after they accept.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3B82F6), size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF3B82F6),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
