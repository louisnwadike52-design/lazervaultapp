import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/linked_bank_account.dart';

/// Dropdown selector for choosing a linked bank account
class LinkedAccountSelector extends StatelessWidget {
  final List<LinkedBankAccount> accounts;
  final LinkedBankAccount? selectedAccount;
  final ValueChanged<LinkedBankAccount?> onChanged;
  final VoidCallback? onLinkNewAccount;
  final String? labelText;
  final bool showBalance;

  const LinkedAccountSelector({
    super.key,
    required this.accounts,
    required this.selectedAccount,
    required this.onChanged,
    this.onLinkNewAccount,
    this.labelText,
    this.showBalance = true,
  });

  @override
  Widget build(BuildContext context) {
    if (accounts.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<LinkedBankAccount>(
              value: selectedAccount,
              isExpanded: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              borderRadius: BorderRadius.circular(12.r),
              hint: _buildHint(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey[600],
              ),
              items: [
                ...accounts.map((account) => DropdownMenuItem(
                      value: account,
                      child: _buildAccountItem(account),
                    )),
                if (onLinkNewAccount != null)
                  DropdownMenuItem(
                    value: null,
                    enabled: false,
                    child: _buildLinkNewAccountOption(),
                  ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHint() {
    return Row(
      children: [
        Icon(
          Icons.account_balance_outlined,
          color: Colors.grey[400],
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          'Select a bank account',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountItem(LinkedBankAccount account) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          // Bank icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: _getBankColor(account.bankName).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.account_balance,
              color: _getBankColor(account.bankName),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // Account info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        account.bankName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (account.isDefault) ...[
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6C5CE7),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  account.displayAccountNumber,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Balance (if enabled)
          if (showBalance && account.lastKnownBalance != null) ...[
            SizedBox(width: 8.w),
            Text(
              account.formattedBalance,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],

          // Status indicator
          if (!account.isActive) ...[
            SizedBox(width: 8.w),
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 16.sp,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinkNewAccountOption() {
    return InkWell(
      onTap: onLinkNewAccount,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: const Color(0xFF6C5CE7),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Link New Account',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6C5CE7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[300]!,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.account_balance_outlined,
            size: 40.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 12.h),
          Text(
            'No bank accounts linked',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Link a bank account to make deposits',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
          ),
          if (onLinkNewAccount != null) ...[
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: onLinkNewAccount,
              icon: const Icon(Icons.add),
              label: const Text('Link Bank Account'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6C5CE7),
              ),
            ),
          ],
        ],
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
    return const Color(0xFF6C5CE7);
  }
}
