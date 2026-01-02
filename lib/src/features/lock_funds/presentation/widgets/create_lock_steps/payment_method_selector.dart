import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/create_lock_cubit.dart';

/// Payment method selection screen - Step 5 of 5
///
/// Allows user to select payment method for the lock fund
class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, state) {
        final cubit = context.read<CreateLockCubit>();
        final selectedMethod = cubit.paymentMethod;
        final amount = cubit.amount;
        final currency = cubit.currency;

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Method',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Select how you want to fund your lock',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),

              // Amount to Pay Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Amount to Lock',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '$currency ${amount?.toStringAsFixed(2) ?? '0.00'}',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Payment Methods
              Text(
                'Select Payment Method',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),

              // Wallet Balance
              _buildPaymentMethodCard(
                context: context,
                method: 'wallet',
                icon: Icons.account_balance_wallet_rounded,
                title: 'Wallet Balance',
                subtitle: 'Pay from your LazerVault wallet',
                badge: 'Instant',
                badgeColor: const Color(0xFF10B981),
                isSelected: selectedMethod == 'wallet',
                onTap: () => cubit.updatePaymentMethod('wallet'),
              ),
              SizedBox(height: 16.h),

              // Debit Card
              _buildPaymentMethodCard(
                context: context,
                method: 'card',
                icon: Icons.credit_card_rounded,
                title: 'Debit/Credit Card',
                subtitle: 'Pay with your card',
                badge: 'Fast',
                badgeColor: const Color(0xFF6366F1),
                isSelected: selectedMethod == 'card',
                onTap: () => cubit.updatePaymentMethod('card'),
              ),
              SizedBox(height: 16.h),

              // Bank Transfer
              _buildPaymentMethodCard(
                context: context,
                method: 'bank',
                icon: Icons.account_balance_rounded,
                title: 'Bank Transfer',
                subtitle: 'Direct bank transfer',
                badge: '1-2 days',
                badgeColor: const Color(0xFFF59E0B),
                isSelected: selectedMethod == 'bank',
                onTap: () => cubit.updatePaymentMethod('bank'),
              ),
              SizedBox(height: 16.h),

              // Crypto
              _buildPaymentMethodCard(
                context: context,
                method: 'crypto',
                icon: Icons.currency_bitcoin_rounded,
                title: 'Cryptocurrency',
                subtitle: 'Pay with crypto',
                badge: 'Fast',
                badgeColor: const Color(0xFF6366F1),
                isSelected: selectedMethod == 'crypto',
                onTap: () => cubit.updatePaymentMethod('crypto'),
              ),
              SizedBox(height: 24.h),

              // Security Notice
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security_rounded,
                      color: const Color(0xFF10B981),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Your payment is secured with 256-bit encryption',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodCard({
    required BuildContext context,
    required String method,
    required IconData icon,
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [const Color(0xFF6366F1), const Color(0xFF8B5CF6)]
                : [const Color(0xFF2A2A3E), const Color(0xFF1F1F35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: isSelected ? 20 : 16,
              offset: Offset(0, isSelected ? 10 : 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: isSelected ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 28.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: isSelected ? 0.3 : 0.2),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: badgeColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.8)
                          : const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
