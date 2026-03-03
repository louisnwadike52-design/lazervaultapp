import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/presentation/widgets/subscription_countdown_timer.dart';
import 'package:lazervault/src/features/subscriptions/presentation/widgets/subscription_expiry_gauge.dart';

/// Detail screen for a single subscription.
/// Takes subscription data via route arguments.
class SubscriptionDetailScreen extends StatelessWidget {
  const SubscriptionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subscription = Get.arguments is ActiveSubscriptionEntity
        ? Get.arguments as ActiveSubscriptionEntity
        : null;

    if (subscription == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Subscription not found',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
          ),
        ),
      );
    }

    return _DetailView(subscription: subscription);
  }
}

class _DetailView extends StatelessWidget {
  final ActiveSubscriptionEntity subscription;

  const _DetailView({required this.subscription});

  String _formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    final symbol = subscription.currency.isNotEmpty
        ? CurrencySymbols.getSymbol(subscription.currency)
        : CurrencySymbols.currentSymbol;
    return '$symbol${formatter.format(amount)}';
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  String _formatDateTime(DateTime date) {
    return DateFormat('MMM d, yyyy - h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Subscription Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Expiry gauge
                    Center(
                      child: SubscriptionExpiryGauge(
                        subscription: subscription,
                        size: 200,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Plan name + provider
                    Text(
                      subscription.planName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          subscription.typeIcon,
                          color: const Color(0xFF9CA3AF),
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          subscription.providerName,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Countdown timer
                    Center(
                      child: SubscriptionCountdownTimer(
                        expiresAt: subscription.expiresAt,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Details card
                    _buildDetailsCard(),

                    // Token card (electricity only)
                    if (subscription.subscriptionType.toLowerCase() ==
                            'electricity' &&
                        subscription.token.isNotEmpty) ...[
                      SizedBox(height: 12.h),
                      _buildTokenCard(context),
                    ],

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Bottom action bar
            _buildBottomAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Status',
            subscription.status,
            valueColor: subscription.statusColor,
          ),
          _buildDivider(),
          _buildDetailRow('Customer Number', subscription.customerNumber),
          _buildDivider(),
          _buildDetailRow('Amount', _formatAmount(subscription.amount)),
          _buildDivider(),
          _buildDetailRow('Purchased', _formatDateTime(subscription.purchasedAt)),
          if (subscription.hasExpiry) ...[
            _buildDivider(),
            _buildDetailRow(
              'Expires',
              _formatDate(subscription.expiresAt!),
              valueColor: subscription.isExpired
                  ? const Color(0xFFEF4444)
                  : subscription.isExpiringSoon
                      ? const Color(0xFFFB923C)
                      : null,
            ),
          ],
          if (subscription.validityDays > 0) ...[
            _buildDivider(),
            _buildDetailRow(
              'Validity',
              '${subscription.validityDays} day${subscription.validityDays == 1 ? '' : 's'}',
            ),
          ],
          if (subscription.units > 0) ...[
            _buildDivider(),
            _buildDetailRow('Units', subscription.units.toStringAsFixed(2)),
          ],
          _buildDivider(),
          _buildDetailRow('Reference', subscription.paymentReference),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: const Color(0xFF2D2D2D),
      height: 1.h,
    );
  }

  Widget _buildTokenCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bolt,
                color: const Color(0xFFF59E0B),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Electricity Token',
                style: TextStyle(
                  color: const Color(0xFFF59E0B),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: subscription.token),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Token copied to clipboard'),
                      backgroundColor: Color(0xFF10B981),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.copy,
                      color: const Color(0xFF9CA3AF),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Copy',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SelectableText(
              subscription.token,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: () {
            final route = switch (subscription.subscriptionType.toLowerCase()) {
              'data' => AppRoutes.dataBundlesHome,
              'cable_tv' => AppRoutes.cableTVHome,
              'internet' => AppRoutes.internetBillHome,
              'electricity' => AppRoutes.electricityBillHome,
              'airtime' => AppRoutes.airtime,
              _ => null,
            };
            if (route != null) {
              Get.toNamed(route);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Renew Subscription',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
