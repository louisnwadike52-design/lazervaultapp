import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';

/// VTU Africa transfer confirmation screen.
/// Shows the destination number to transfer airtime to, then submits the conversion.
class VtuafricaTransferScreen extends StatelessWidget {
  const VtuafricaTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final phoneNumber = args['phoneNumber'] as String;
    final network = args['network'] as String;
    final amount = args['amount'] as double;
    final destinationPhone = args['destinationPhone'] as String;
    final providerRate = args['providerRate'] as double;
    final estimatedCash = amount * providerRate;

    return BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
      listener: (context, state) {
        if (state is AirtimeToCashProcessingPending) {
          // Conversion submitted, waiting for webhook
          Get.offAllNamed('/airtime-to-cash/pending', arguments: {
            'conversion': state.conversion,
            'message': state.message,
          });
        } else if (state is AirtimeToCashFailed) {
          Get.snackbar(
            'Conversion Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      _buildIcon(),
                      SizedBox(height: 24.h),
                      _buildTitle(),
                      SizedBox(height: 32.h),
                      _buildTransferCard(
                        context,
                        phoneNumber,
                        network,
                        amount,
                        destinationPhone,
                        estimatedCash,
                      ),
                      SizedBox(height: 24.h),
                      _buildInstructions(),
                      SizedBox(height: 16.h),
                      _buildUssdHelpButton(context, network, destinationPhone, amount),
                      SizedBox(height: 32.h),
                      _buildWarning(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              _buildConfirmButton(context, phoneNumber, network, amount, destinationPhone),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF4E03D0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Icon(
        Icons.phone_in_talk,
        color: Colors.white,
        size: 40.sp,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'Transfer Airtime',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Send the exact amount to the number below',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildTransferCard(
    BuildContext context,
    String phoneNumber,
    String network,
    double amount,
    String destinationPhone,
    double estimatedCash,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0).withValues(alpha: 0.15),
            const Color(0xFF4E03D0).withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRANSFER DETAILS',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9CA3AF),
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Your Number', phoneNumber),
          SizedBox(height: 12.h),
          _buildDetailRow('Network', network.toUpperCase()),
          SizedBox(height: 12.h),
          _buildDetailRow('Amount', '₦${amount.toStringAsFixed(0)}'),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
          _buildDestinationRow(destinationPhone),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
          _buildDetailRow('You will receive', '₦${estimatedCash.toStringAsFixed(2)}',
              highlight: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool highlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: highlight ? const Color(0xFF10B981) : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationRow(String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer to this number',
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                phone,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Copy to clipboard
                  Clipboard.setData(ClipboardData(text: phone));
                  Get.snackbar(
                    'Copied',
                    'Phone number copied to clipboard',
                    backgroundColor: const Color(0xFF10B981),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: Icon(
                  Icons.copy,
                  color: const Color(0xFF4E03D0),
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF4E03D0),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Instructions',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildInstructionStep('1', 'Transfer the exact airtime amount to the number above'),
          SizedBox(height: 8.h),
          _buildInstructionStep('2', 'Wait for confirmation (usually within 2-5 minutes)'),
          SizedBox(height: 8.h),
          _buildInstructionStep('3', 'Your wallet will be credited automatically via webhook'),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4E03D0),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // Per-network USSD shortcode for transferring airtime to another
  // number. Sourced from each Nigerian MNO's published self-service
  // documentation. The "{N}" / "{A}" / "{P}" placeholders map to
  // recipient phone / amount / SIM transfer PIN respectively. Note:
  // each operator names this feature differently — MTN "Share"; Airtel
  // "Me2U"; Glo "Easy Share"; 9mobile "Share & Sell".
  static const Map<String, _UssdGuide> _ussdGuides = {
    'mtn': _UssdGuide(
      label: 'MTN Share',
      direct: '*777*{N}*{A}*{P}#',
      menu: '*777#',
      requiresPin: true,
      notes:
          'You\u2019ll need your MTN SIM transfer PIN. Set or reset it via *600# if you don\u2019t have one.',
    ),
    'airtel': _UssdGuide(
      label: 'Airtel Me2U',
      direct: '*432*{N}*{A}*{P}#',
      menu: '*432#',
      requiresPin: true,
      notes:
          'You\u2019ll need your Airtel SIM transfer PIN. Default is 1234 — reset via *432# if changed.',
    ),
    'glo': _UssdGuide(
      label: 'Glo Easy Share',
      direct: '*131*{A}*{N}*{P}#',
      menu: '*131#',
      requiresPin: true,
      notes:
          'You\u2019ll need your Glo SIM transfer PIN. Set/reset via *132*OldPIN*NewPIN*NewPIN#.',
    ),
    '9mobile': _UssdGuide(
      label: '9mobile Share & Sell',
      direct: '*223*{P}*{A}*{N}#',
      menu: '*223#',
      requiresPin: true,
      notes:
          'You\u2019ll need your 9mobile SIM transfer PIN. Default is 0000 — reset via *247# if changed.',
    ),
  };

  Widget _buildUssdHelpButton(
    BuildContext context,
    String network,
    String destinationPhone,
    double amount,
  ) {
    final hasGuide = _ussdGuides.containsKey(network.toLowerCase());
    if (!hasGuide) return const SizedBox.shrink();
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(Icons.dialpad, size: 18.sp, color: const Color(0xFF4E03D0)),
        onPressed: () =>
            _showUssdGuideSheet(context, network, destinationPhone, amount),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          side: BorderSide(color: const Color(0xFF4E03D0).withValues(alpha: 0.4)),
        ),
        label: Text(
          'Show me how to transfer airtime',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4E03D0),
          ),
        ),
      ),
    );
  }

  void _showUssdGuideSheet(
    BuildContext context,
    String network,
    String destinationPhone,
    double amount,
  ) {
    final guide = _ussdGuides[network.toLowerCase()];
    if (guide == null) return;
    final amountStr = amount.toStringAsFixed(0);
    final filledDirect = guide.direct
        .replaceAll('{N}', destinationPhone)
        .replaceAll('{A}', amountStr)
        .replaceAll('{P}', '<PIN>');

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  '${guide.label} step-by-step',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Use your phone\u2019s dialer to transfer ₦$amountStr airtime to $destinationPhone. '
                  'Once the transfer goes through, come back here and tap "I\u2019ve sent the airtime".',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 18.h),
                _ussdMethodCard(
                  title: 'Quickest — Direct USSD',
                  body:
                      'Dial this exact code on your $network line, replacing <PIN> with your SIM transfer PIN:',
                  code: filledDirect,
                ),
                SizedBox(height: 12.h),
                _ussdMethodCard(
                  title: 'Or — Menu USSD',
                  body:
                      'Dial the menu code below and follow the on-screen prompts. Choose "Transfer", enter $destinationPhone, amount $amountStr, then your PIN.',
                  code: guide.menu,
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_amber, size: 16.sp, color: const Color(0xFFFB923C)),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          guide.notes,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    child: Text(
                      'Got it',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4E03D0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _ussdMethodCard({
    required String title,
    required String body,
    required String code,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            body,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: code));
              Get.snackbar(
                'Copied',
                'USSD code copied to clipboard',
                duration: const Duration(seconds: 2),
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: Colors.white,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFF4E03D0).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      code,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Icon(Icons.copy, size: 16.sp, color: Colors.white.withValues(alpha: 0.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarning() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFEF4444),
            size: 18.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Only transfer after confirming. Multiple requests without transfer may lead to account blocking.',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFFEF4444),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(
    BuildContext context,
    String phoneNumber,
    String network,
    double amount,
    String destinationPhone,
  ) {
    return BlocBuilder<AirtimeToCashCubit, AirtimeToCashState>(
      builder: (context, state) {
        final isLoading = state is AirtimeToCashProcessing;
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          context.read<AirtimeToCashCubit>().submitVtuafricaConversion(
                            phoneNumber: phoneNumber,
                            network: network,
                            amount: amount,
                            destinationPhone: destinationPhone,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'I Have Transferred, Confirm',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'By confirming, you declare that you have transferred the airtime to the number above.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Per-network airtime-transfer USSD guide. `direct` is the one-shot
/// dialer string with placeholders ({N}=recipient, {A}=amount, {P}=PIN).
/// `menu` is the operator's interactive menu shortcode.
class _UssdGuide {
  final String label;
  final String direct;
  final String menu;
  final bool requiresPin;
  final String notes;

  const _UssdGuide({
    required this.label,
    required this.direct,
    required this.menu,
    required this.requiresPin,
    required this.notes,
  });
}
