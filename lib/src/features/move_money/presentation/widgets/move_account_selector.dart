import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

import 'move_account_card.dart';

/// A horizontal scrollable list of [MoveAccountCard] widgets for account selection.
///
/// Displays linked bank accounts with an optional "+" card at the end to add a new account.
/// Supports filtering out a specific account via [excludeAccountId].
class MoveAccountSelector extends StatelessWidget {
  final List<LinkedBankAccount> accounts;
  final String? selectedAccountId;
  final ValueChanged<LinkedBankAccount> onAccountSelected;
  final String? excludeAccountId;
  final VoidCallback? onAddAccount;
  final String? label;

  const MoveAccountSelector({
    super.key,
    required this.accounts,
    required this.selectedAccountId,
    required this.onAccountSelected,
    this.excludeAccountId,
    this.onAddAccount,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final filteredAccounts = excludeAccountId != null
        ? accounts.where((a) => a.id != excludeAccountId).toList()
        : accounts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              label!,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
        SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: filteredAccounts.length + (onAddAccount != null ? 1 : 0),
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              // "Add account" card at the end
              if (index == filteredAccounts.length) {
                return _buildAddAccountCard();
              }

              final account = filteredAccounts[index];
              return MoveAccountCard(
                account: account,
                isSelected: account.id == selectedAccountId,
                onTap: account.isActive
                    ? () => onAccountSelected(account)
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddAccountCard() {
    return GestureDetector(
      onTap: onAddAccount,
      child: Container(
        width: 160.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: const Color(0xFF3B82F6),
                size: 24.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Link Account',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
