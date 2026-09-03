import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/airtime_to_cash_conversion.dart';
import '../../../airtime/domain/entities/airtime_transaction.dart';

class A2CResultScreen extends StatefulWidget {
  const A2CResultScreen({super.key});

  @override
  State<A2CResultScreen> createState() => _A2CResultScreenState();
}

class _A2CResultScreenState extends State<A2CResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool isSuccess = false;
  bool isProcessingPending = false;
  String? errorMessage;
  String? pendingMessage;
  AirtimeToCashConversion? conversion;
  AirtimeTransaction? historyTxn;
  double? newBalance;
  String? phoneNumber;
  String? network;
  double? amount;
  double? estimatedCash;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      isSuccess = args['isSuccess'] ?? false;
      errorMessage = args['errorMessage'];
      conversion = args['conversion'];
      newBalance = args['newBalance'];
      phoneNumber = args['phoneNumber'];
      network = args['network'];
      amount = args['amount'];
      estimatedCash = args['estimatedCash'];
      pendingMessage = args['message'] as String?;
      // Opening a past A2C receipt from history passes an AirtimeTransaction
      // (the airtime-history model), not a conversion. Render from it so the
      // receipt shows instead of the old "Conversion Failed" dead-end.
      final txn = args['transaction'];
      if (txn is AirtimeTransaction) {
        historyTxn = txn;
        phoneNumber ??= txn.recipientPhoneNumber;
        network ??= txn.networkProvider.name.toUpperCase();
        amount ??= txn.amount;
        if (txn.isCompleted) {
          isSuccess = true;
        } else if (txn.isPending) {
          isProcessingPending = true;
        }
      }
      // The automation path passes isProcessingPending on the submit result so
      // a still-processing conversion isn't mislabeled "Successful".
      if (args['isProcessingPending'] == true) {
        isProcessingPending = true;
        isSuccess = true; // has a valid conversion payload; just not terminal
      }
    }
  }

  void _setupAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                SizedBox(height: 40.h),

                // Status icon and message
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildStatusSection(),
                ),

                SizedBox(height: 40.h),

                // Receipt card — full conversion receipt when we have one…
                if ((isSuccess || isProcessingPending) && conversion != null)
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildReceiptCard(),
                    ),
                  )
                // …otherwise render the history receipt straight from the
                // AirtimeTransaction so a past A2C entry shows real details
                // instead of the old "Conversion Failed" dead-end.
                else if (conversion == null && historyTxn != null)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildHistoryReceiptCard(historyTxn!),
                  ),

                SizedBox(height: 24.h),

                // Action buttons
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildActionButtons(),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color get _statusColor => isProcessingPending
      ? const Color(0xFFFB923C)
      : (isSuccess ? const Color(0xFF10B981) : const Color(0xFFEF4444));

  Widget _buildStatusSection() {
    return Column(
      children: [
        // Status icon
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _statusColor,
            boxShadow: [
              BoxShadow(
                color: _statusColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            isProcessingPending
                ? Icons.hourglass_top
                : (isSuccess ? Icons.check : Icons.close),
            color: Colors.white,
            size: 48.sp,
          ),
        ),

        SizedBox(height: 24.h),

        // Status title
        Text(
          isProcessingPending
              ? 'Conversion Processing'
              : (isSuccess ? 'Conversion Successful!' : 'Conversion Failed'),
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        SizedBox(height: 12.h),

        // Status message
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            isProcessingPending
                ? (pendingMessage ??
                    'Your cash will be credited once the transfer is confirmed. This usually takes 2-5 minutes.')
                : isSuccess
                    ? '\u20A6${conversion?.cashAmount.toStringAsFixed(2) ?? estimatedCash?.toStringAsFixed(2) ?? '0.00'} credited to your wallet'
                    : errorMessage ??
                        'Something went wrong with your conversion',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  double? _metaNum(Map<String, dynamic>? m, List<String> keys) {
    if (m == null) return null;
    for (final k in keys) {
      final v = m[k];
      if (v is num) return v.toDouble();
      if (v is String) {
        final p = double.tryParse(v);
        if (p != null) return p;
      }
    }
    return null;
  }

  // Receipt rendered from a history AirtimeTransaction (no full conversion
  // object). Shows the reliable fields; cash amount + rate come from the
  // payment metadata when the backend stamped them, otherwise they're omitted
  // rather than shown as a misleading ₦0.00.
  Widget _buildHistoryReceiptCard(AirtimeTransaction t) {
    final cash =
        _metaNum(t.metadata, ['cash_amount', 'cashAmount', 'amount_paid']);
    final rate = _metaNum(t.metadata, ['conversion_rate', 'conversionRate']);
    final fee =
        t.fee ?? _metaNum(t.metadata, ['fee', 'automation_fee', 'charge']);
    final headline = cash ?? t.amount;
    final headlineLabel = cash != null ? 'Cash Received' : 'Airtime Converted';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          decoration: const BoxDecoration(color: Color(0xFF1F1F1F)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF3B82F6),
                      Color.fromARGB(255, 78, 3, 208)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Text('Airtime to Cash',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    SizedBox(height: 16.h),
                    Text('₦${headline.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 34.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    SizedBox(height: 4.h),
                    Text(headlineLabel,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withValues(alpha: 0.7))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    if (t.transactionReference.isNotEmpty) ...[
                      _buildReceiptRow('Reference', t.transactionReference),
                      _buildDivider(),
                    ],
                    _buildReceiptRow('Phone Number', t.recipientPhoneNumber),
                    _buildDivider(),
                    _buildReceiptRow(
                        'Network', t.networkProvider.name.toUpperCase()),
                    _buildDivider(),
                    _buildReceiptRow(
                        'Airtime Amount', '₦${t.amount.toStringAsFixed(2)}'),
                    if (cash != null) ...[
                      _buildDivider(),
                      _buildReceiptRow(
                          'Cash Received', '₦${cash.toStringAsFixed(2)}'),
                    ],
                    if (rate != null && rate > 0) ...[
                      _buildDivider(),
                      _buildReceiptRow('Conversion Rate',
                          '${(rate * 100).toStringAsFixed(0)}%'),
                    ],
                    if (fee != null && fee > 0) ...[
                      _buildDivider(),
                      _buildReceiptRow('Fee', '₦${fee.toStringAsFixed(2)}'),
                    ],
                    _buildDivider(),
                    _buildReceiptRow('Status', t.status.displayName,
                        valueColor: t.isCompleted
                            ? const Color(0xFF10B981)
                            : (t.isPending
                                ? const Color(0xFFFB923C)
                                : const Color(0xFFEF4444))),
                    _buildDivider(),
                    _buildReceiptRow(
                      'Date & Time',
                      DateFormat('MMM dd, yyyy • hh:mm a').format(t.createdAt),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1F1F1F),
          ),
          child: Column(
            children: [
              _buildReceiptHeader(),
              _buildReceiptBody(),
              _buildReceiptFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color.fromARGB(255, 78, 3, 208)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Airtime to Cash',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      conversion?.network ?? network ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // Cash amount
          Text(
            '\u20A6${conversion?.cashAmount.toStringAsFixed(2) ?? '0.00'}',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Cash Received',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptBody() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          if (conversion?.reference != null) ...[
            _buildReceiptRow('Reference', conversion!.reference),
            _buildDivider(),
          ],
          _buildReceiptRow(
              'Phone Number', conversion?.phoneNumber ?? phoneNumber ?? ''),
          _buildDivider(),
          _buildReceiptRow('Network', conversion?.network ?? network ?? ''),
          _buildDivider(),
          _buildReceiptRow(
            'Airtime Amount',
            '\u20A6${conversion?.airtimeAmount.toStringAsFixed(2) ?? amount?.toStringAsFixed(2) ?? '0.00'}',
          ),
          _buildDivider(),
          _buildReceiptRow(
            'Conversion Rate',
            conversion?.ratePercentage ?? '',
          ),
          _buildDivider(),
          _buildReceiptRow(
            'Fee',
            '\u20A6${conversion?.fee.toStringAsFixed(2) ?? '0.00'}',
          ),
          _buildDivider(),
          _buildReceiptRow(
            'Status',
            conversion?.status.displayName ?? 'Completed',
            valueColor: const Color(0xFF10B981),
          ),
          if (conversion?.createdAt != null) ...[
            _buildDivider(),
            _buildReceiptRow(
              'Date & Time',
              DateFormat('MMM dd, yyyy \u2022 hh:mm a')
                  .format(conversion!.createdAt),
            ),
          ],

          // New balance section
          if (newBalance != null) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Balance',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  Text(
                    '\u20A6${newBalance!.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReceiptFooter() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Thank you for using Lazervault',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Keep this receipt for your records',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value,
      {Color? valueColor, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: Colors.white.withValues(alpha: isTotal ? 1.0 : 0.6),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ??
                  (isTotal
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.8)),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      height: 1,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Primary: Done
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Secondary actions
          Row(
            children: [
              if (!isSuccess)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.airtimeToCash),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1F1F1F)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              if (isSuccess)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.offAllNamed(AppRoutes.airtimeToCash),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1F1F1F)),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Convert More',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.toNamed(AppRoutes.airtimeHistory),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1F1F1F)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'View History',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
