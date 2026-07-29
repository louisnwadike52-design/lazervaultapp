import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/app_surfaces.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';

import 'mandate_status_badge.dart';

/// A card displaying a linked bank account for selection in the Move Money flow.
///
/// Shows bank name, masked account number, account name, and mandate status badge.
/// Displays a green border when [isSelected] is true.
class MoveAccountCard extends StatelessWidget {
  final LinkedBankAccount account;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final MandateEntity? mandate;

  const MoveAccountCard({
    super.key,
    required this.account,
    required this.isSelected,
    this.onTap,
    this.onLongPress,
    this.mandate,
  });

  @override
  Widget build(BuildContext context) {
    // State-coloured accent (matches the deposit cards): selected → green,
    // needs-reauth → amber, active Direct Debit → green, else soft purple.
    final bool ddActive = mandate != null &&
        (mandate!.status == MandateStatus.readyToDebit ||
            mandate!.status == MandateStatus.active);
    final Color accent = isSelected
        ? const Color(0xFF10B981)
        : account.needsReauthorization
            ? const Color(0xFFFB923C)
            : ddActive
                ? const Color(0xFF10B981)
                : AppSurfaces.accentPurple;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 172.w,
        padding: EdgeInsets.all(14.w),
        decoration: AppSurfaces.card(
          accent: accent,
          radius: 16,
          accentAlpha: isSelected ? 0.90 : 0.30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bank icon + selection indicator
            Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: _getBankColor(account.bankName)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.account_balance,
                    color: _getBankColor(account.bankName),
                    size: 18.sp,
                  ),
                ),
                const Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFF10B981),
                    size: 20.sp,
                  ),
              ],
            ),
            SizedBox(height: 6.h),

            // Bank name
            Text(
              account.bankName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),

            // Masked account number
            Text(
              account.displayAccountNumber,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 2.h),

            // Account name
            Text(
              account.accountName,
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),

            // Live bank balance (Mono-read; auto/manual refresh keeps it
            // current). Edge states: unreadable/never-read balances show a
            // neutral placeholder instead of a misleading ₦0.00.
            // COST-AWARE display: we no longer auto-read Mono on load, so show
            // the last-known (cached) balance and label it "not live" when stale;
            // the user refreshes explicitly (cost-confirmed) to get a live figure.
            Builder(builder: (_) {
              final hasBalance = account.balanceUpdatedAt != null;
              final fresh = hasBalance &&
                  DateTime.now()
                          .difference(account.balanceUpdatedAt!)
                          .inMinutes <
                      3;
              if (!hasBalance) {
                return Text(
                  'Tap refresh to load balance',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                  ),
                );
              }
              return Text(
                '₦${account.lastKnownBalance.toStringAsFixed(2)}${fresh ? '' : ' · not live'}',
                style: GoogleFonts.inter(
                  color: fresh ? Colors.white : Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
            SizedBox(height: 2.h),

            // Mandate status badge
            MandateStatusBadge(mandate: mandate),

            // Status warning if account is not active
            if (!account.isActive) ...[
              SizedBox(height: 6.h),
              Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: const Color(0xFFFB923C),
                    size: 12.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    account.needsReauthorization
                        ? 'Reauthorize'
                        : 'Inactive',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getBankColor(String bankName) {
    final name = bankName.toLowerCase();
    if (name.contains('access')) return const Color(0xFFED7D31);
    if (name.contains('gtb') || name.contains('guaranty')) {
      return const Color(0xFFE94C16);
    }
    if (name.contains('zenith')) return const Color(0xFFED1C24);
    if (name.contains('uba')) return const Color(0xFFE4002B);
    if (name.contains('first')) return const Color(0xFF003366);
    if (name.contains('sterling')) return const Color(0xFF003399);
    if (name.contains('fidelity')) return const Color(0xFF009933);
    if (name.contains('fcmb')) return const Color(0xFF800080);
    if (name.contains('ecobank')) return const Color(0xFF003366);
    if (name.contains('union')) return const Color(0xFF009DDC);
    if (name.contains('polaris')) return const Color(0xFF8B0000);
    if (name.contains('stanbic')) return const Color(0xFF0033A0);
    if (name.contains('wema')) return const Color(0xFF800080);
    if (name.contains('keystone')) return const Color(0xFF006400);
    if (name.contains('kuda')) return const Color(0xFF40196D);
    if (name.contains('opay')) return const Color(0xFF1BB066);
    if (name.contains('palmpay')) return const Color(0xFF6F42C1);
    if (name.contains('moniepoint')) return const Color(0xFF2F3292);
    return const Color(0xFF3B82F6);
  }
}
