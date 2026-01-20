import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/linked_bank_account.dart';

/// Card widget to display a linked bank account
class LinkedAccountCard extends StatelessWidget {
  final LinkedBankAccount account;
  final VoidCallback? onUnlink;
  final VoidCallback? onSetDefault;
  final VoidCallback? onRefreshBalance;

  const LinkedAccountCard({
    super.key,
    required this.account,
    this.onUnlink,
    this.onSetDefault,
    this.onRefreshBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: account.isDefault
              ? const Color(0xFF6C5CE7)
              : Colors.grey[200]!,
          width: account.isDefault ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Bank icon
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: _getBankColor(account.bankName).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.account_balance,
                    color: _getBankColor(account.bankName),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),

                // Bank info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              account.bankName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          if (account.isDefault)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C5CE7).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Default',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6C5CE7),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${account.accountName} • ${account.displayAccountNumber}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Status bar (if not active)
          if (account.needsReauthorization)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange[700],
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'This account needs to be reconnected',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to reauthorization
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange[700],
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                    ),
                    child: Text(
                      'Reconnect',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Balance section (if active)
          if (account.isActive)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        account.formattedBalance,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (!account.isDefault && onSetDefault != null)
                        IconButton(
                          onPressed: onSetDefault,
                          icon: Icon(
                            Icons.star_outline,
                            color: Colors.grey[400],
                            size: 20.sp,
                          ),
                          tooltip: 'Set as default',
                        ),
                      IconButton(
                        onPressed: onRefreshBalance,
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                        tooltip: 'Refresh balance',
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                        onSelected: (value) {
                          switch (value) {
                            case 'unlink':
                              onUnlink?.call();
                              break;
                            case 'default':
                              onSetDefault?.call();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          if (!account.isDefault)
                            const PopupMenuItem(
                              value: 'default',
                              child: Row(
                                children: [
                                  Icon(Icons.star_outline, size: 20),
                                  SizedBox(width: 8),
                                  Text('Set as Default'),
                                ],
                              ),
                            ),
                          const PopupMenuItem(
                            value: 'unlink',
                            child: Row(
                              children: [
                                Icon(Icons.link_off, size: 20, color: Colors.red),
                                SizedBox(width: 8),
                                Text(
                                  'Unlink Account',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getBankColor(String bankName) {
    // Map bank names to colors for visual distinction
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
    if (name.contains('heritage')) return const Color(0xFF006400);
    if (name.contains('jaiz')) return const Color(0xFF006400);
    if (name.contains('kuda')) return const Color(0xFF40196D);
    if (name.contains('opay')) return const Color(0xFF1BB066);
    if (name.contains('palmpay')) return const Color(0xFF6F42C1);
    if (name.contains('moniepoint')) return const Color(0xFF2F3292);
    return const Color(0xFF6C5CE7); // Default color
  }
}
