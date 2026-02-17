import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

/// Open Banking Status Card
/// Shows connection status and provides options to connect/sync bank accounts
class OpenBankingStatusCard extends StatelessWidget {
  final bool isConnected;
  final bool isSyncing;
  final List<LinkedBankAccount> linkedAccounts;
  final VoidCallback onConnectBank;
  final VoidCallback onSync;
  final VoidCallback? onViewAll;

  const OpenBankingStatusCard({
    super.key,
    this.isConnected = false,
    this.isSyncing = false,
    this.linkedAccounts = const [],
    required this.onConnectBank,
    required this.onSync,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final displayAccounts = linkedAccounts.length > 2
        ? linkedAccounts.sublist(0, 2)
        : linkedAccounts;
    final hasMore = linkedAccounts.length > 2;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF7C3AED),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Open Banking',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        isConnected
                            ? '${linkedAccounts.length} bank${linkedAccounts.length != 1 ? 's' : ''} connected'
                            : 'Connect your bank for automatic tracking',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isConnected)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Connected',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),

            // Content
            if (!isConnected) ...[
              _FeatureItem(
                icon: Icons.sync,
                title: 'Auto-Sync Transactions',
                description: 'Automatically import all your transactions',
              ),
              SizedBox(height: 12.h),
              _FeatureItem(
                icon: Icons.category,
                title: 'Smart Categorization',
                description: 'AI-powered expense categorization',
              ),
              SizedBox(height: 12.h),
              _FeatureItem(
                icon: Icons.security,
                title: 'Bank-Level Security',
                description: '256-bit encryption & secure connections',
              ),
            ] else if (displayAccounts.isNotEmpty) ...[
              ...displayAccounts.map((account) => Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: _LinkedAccountRow(account: account),
                  )),
              if (hasMore)
                GestureDetector(
                  onTap: onViewAll,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h, bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View all ${linkedAccounts.length} banks',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withValues(alpha: 0.7),
                          size: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
            ] else ...[
              _FeatureItem(
                icon: Icons.check_circle,
                title: 'Transactions Synced',
                description: 'Last sync: Just now',
              ),
              SizedBox(height: 12.h),
              _FeatureItem(
                icon: Icons.check_circle,
                title: 'Balances Updated',
                description: 'Real-time balance tracking',
              ),
            ],

            SizedBox(height: 20.h),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSyncing ? null : (isConnected ? onSync : onConnectBank),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4E03D0),
                  disabledBackgroundColor: Colors.white.withValues(alpha: 0.6),
                  disabledForegroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.5),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: isSyncing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: const Color(0xFF4E03D0).withValues(alpha: 0.5),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Syncing...',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        isConnected ? 'Sync Now' : 'Connect Bank Account',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkedAccountRow extends StatelessWidget {
  final LinkedBankAccount account;

  const _LinkedAccountRow({required this.account});

  String _formatSyncTime(DateTime? syncTime) {
    if (syncTime == null) return 'Never synced';
    final diff = DateTime.now().difference(syncTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.account_balance, color: Colors.white, size: 18.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.bankName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${account.accountNumber} · ${_formatSyncTime(account.balanceUpdatedAt)}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            CurrencySymbols.formatAmount(account.lastKnownBalance),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
