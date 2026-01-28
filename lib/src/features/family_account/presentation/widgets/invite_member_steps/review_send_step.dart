import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// Step 4: Review & Send Invitation
/// - Summary card with all selections
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

  String _getMethodLabel(String method) {
    switch (method) {
      case 'email':
        return 'Email';
      case 'phone':
        return 'Phone';
      case 'username':
        return 'Username';
      default:
        return method;
    }
  }

  IconData _getMethodIcon(String method) {
    switch (method) {
      case 'email':
        return Icons.email_outlined;
      case 'phone':
        return Icons.phone_outlined;
      case 'username':
        return Icons.alternate_email;
      default:
        return Icons.person_outline;
    }
  }

  String _formatLimit(double limit) {
    if (limit <= 0) return 'Unlimited';
    return '\$${limit.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final method = widget.formData['invitationMethod'] as String;
    final destination = widget.formData['invitationDestination'] as String;
    final allocation = widget.formData['initialAllocation'] as double;
    final role = widget.formData['role'] as String;
    final noLimits = widget.formData['noLimits'] as bool? ?? false;
    final dailyLimit = widget.formData['dailyLimit'] as double;
    final monthlyLimit = widget.formData['monthlyLimit'] as double;
    final perTxnLimit = widget.formData['perTransactionLimit'] as double;
    final allocCap = widget.formData['allocationPercentageCap'] as double;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Review invitation',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Confirm the details before sending',
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Summary Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipient Section
                _buildSectionHeader('Recipient', _getMethodIcon(method)),
                SizedBox(height: 12.h),
                _buildDetailRow(_getMethodLabel(method), destination),
                SizedBox(height: 20.h),

                Divider(color: const Color(0xFFE0E0E0), height: 1),
                SizedBox(height: 20.h),

                // Allocation & Role Section
                _buildSectionHeader('Allocation & Role', Icons.account_balance_wallet_outlined),
                SizedBox(height: 12.h),
                _buildDetailRow('Initial Allocation', '\$${allocation.toStringAsFixed(2)}'),
                SizedBox(height: 8.h),
                _buildDetailRow(
                  'Role',
                  role == 'admin' ? 'Admin' : 'Member',
                  valueColor: role == 'admin' ? const Color(0xFF6C5CE7) : null,
                ),
                SizedBox(height: 20.h),

                Divider(color: const Color(0xFFE0E0E0), height: 1),
                SizedBox(height: 20.h),

                // Spending Limits Section
                _buildSectionHeader('Spending Limits', Icons.shield_outlined),
                SizedBox(height: 12.h),
                if (noLimits)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.all_inclusive,
                          color: const Color(0xFF6C5CE7),
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'No Spending Limits',
                          style: TextStyle(
                            color: const Color(0xFF6C5CE7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  _buildDetailRow('Daily Limit', _formatLimit(dailyLimit)),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Monthly Limit', _formatLimit(monthlyLimit)),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Per-Transaction', _formatLimit(perTxnLimit)),
                ],
                SizedBox(height: 12.h),
                _buildDetailRow('Allocation Cap', '${allocCap.toStringAsFixed(0)}% of pool'),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Personal Message Section
          Text(
            'Personal Message (Optional)',
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add a personal touch to your invitation',
            style: TextStyle(
              color: const Color(0xFF888888),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: _messageController,
            maxLines: 4,
            maxLength: 500,
            onChanged: widget.onUpdateMessage,
            style: TextStyle(
              color: const Color(0xFF1E1E2E),
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: 'Hey! I\'d love to have you join our family account...',
              hintStyle: TextStyle(
                color: const Color(0xFF999999),
                fontSize: 14.sp,
              ),
              filled: true,
              fillColor: const Color(0xFFF8F8F8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF6C5CE7),
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.all(16.w),
              counterStyle: TextStyle(
                color: const Color(0xFF888888),
                fontSize: 11.sp,
              ),
            ),
          ),
          SizedBox(height: 32.h),

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
                    colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                  ),
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.4),
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
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF6C5CE7),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'The recipient will receive an invitation to join your family account. You can modify their limits anytime after they accept.',
                    style: TextStyle(
                      color: const Color(0xFF666666),
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
        Icon(
          icon,
          color: const Color(0xFF6C5CE7),
          size: 18.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF6C5CE7),
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
            color: const Color(0xFF888888),
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? const Color(0xFF1E1E2E),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
