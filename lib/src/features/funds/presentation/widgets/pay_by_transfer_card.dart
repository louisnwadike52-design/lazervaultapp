import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/funds/data/services/deposit_simulation_service.dart';

/// Pay by Transfer Card - Shows user's virtual account (NUBAN) details for deposits
/// Users can copy the account details and transfer directly from any bank app
///
/// In development mode, includes a "Simulate Deposit" button for testing.
class PayByTransferCard extends StatefulWidget {
  final String accountNumber;
  final String accountName;
  final String bankName;
  final String? accountId;  // User's account ID for simulation
  final String? userId;     // User's ID for notifications
  final VoidCallback? onInfoTap;
  final VoidCallback? onSimulationComplete;

  const PayByTransferCard({
    super.key,
    required this.accountNumber,
    required this.accountName,
    required this.bankName,
    this.accountId,
    this.userId,
    this.onInfoTap,
    this.onSimulationComplete,
  });

  @override
  State<PayByTransferCard> createState() => _PayByTransferCardState();
}

class _PayByTransferCardState extends State<PayByTransferCard> {
  bool _isSimulating = false;

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$label copied to clipboard',
      backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
    );
  }

  Future<void> _showSimulationBottomSheet(BuildContext context) async {
    final selectedAmount = useState<double?>(null);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00D09C).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.science,
                        color: const Color(0xFF00D09C),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Simulate Deposit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Testing mode - simulate Flutterwave webhook',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.white.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Account info
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simulating deposit to:',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.accountNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      widget.accountName,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Amount selection
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Select amount',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Quick amount buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: DepositSimulationService.testAmounts.map((amount) {
                    final isSelected = selectedAmount.value == amount;
                    return InkWell(
                      onTap: () {
                        setSheetState(() {
                          selectedAmount.value = amount;
                        });
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00D09C)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF00D09C) : Colors.transparent,
                          ),
                        ),
                        child: Text(
                          '₦${amount.toString()}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 24.h),

              // Simulate button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedAmount.value == null || _isSimulating
                        ? null
                        : () async {
                            setSheetState(() {
                              _isSimulating = true;
                            });
                            Navigator.pop(context);

                            final result = await DepositSimulationService.simulateDeposit(
                              accountNumber: widget.accountNumber,
                              accountName: widget.accountName,
                              amount: selectedAmount.value!,
                            );

                            setState(() {
                              _isSimulating = false;
                            });

                            if (result.success) {
                              Get.snackbar(
                                'Deposit Simulated!',
                                result.message,
                                backgroundColor: Colors.green.withOpacity(0.9),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 3),
                                margin: EdgeInsets.all(16.w),
                              );
                              widget.onSimulationComplete?.call();
                            } else {
                              Get.snackbar(
                                'Simulation Failed',
                                result.message,
                                backgroundColor: Colors.red.withOpacity(0.9),
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: const Duration(seconds: 4),
                                margin: EdgeInsets.all(16.w),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedAmount.value == null
                          ? Colors.grey.shade700
                          : const Color(0xFF00D09C),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isSimulating
                        ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(
                            'Simulate Deposit',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDevMode = DepositSimulationService.isSimulationEnabled;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF00D09C).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: const Color(0xFF00D09C),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay by Transfer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Transfer directly to your LazerVault wallet',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Development mode indicator
              if (isDevMode)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'DEV',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 20.h),

          // Account Details
          _buildDetailRow(
            context,
            label: 'Bank Name',
            value: widget.bankName,
            showCopy: false,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            label: 'Account Number',
            value: widget.accountNumber,
            showCopy: true,
            onCopy: () => _copyToClipboard(context, widget.accountNumber, 'Account number'),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            context,
            label: 'Account Name',
            value: widget.accountName,
            showCopy: true,
            onCopy: () => _copyToClipboard(context, widget.accountName, 'Account name'),
          ),

          SizedBox(height: 16.h),

          // Info note
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF00D09C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFF00D09C).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF00D09C),
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Transfers usually arrive in 1-5 minutes',
                    style: TextStyle(
                      color: const Color(0xFF00D09C),
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Simulation button (development mode only)
          if (isDevMode) ...[
            SizedBox(height: 16.h),
            InkWell(
              onTap: _isSimulating ? null : () => _showSimulationBottomSheet(context),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF4834D4)],
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isSimulating)
                      SizedBox(
                        height: 16.h,
                        width: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    else ...[
                      Icon(Icons.science, color: Colors.white, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Simulate Test Deposit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    bool showCopy = false,
    VoidCallback? onCopy,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: label == 'Account Number' ? 1.2 : 0,
                ),
              ),
            ],
          ),
          if (showCopy)
            GestureDetector(
              onTap: onCopy,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.copy,
                  color: const Color(0xFF6C5CE7),
                  size: 16.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
