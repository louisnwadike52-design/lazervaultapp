import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/fraud_detection/data/fraud_detection_service.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart';

/// Checks whether the account is fraud-frozen and, if so, shows the freeze modal
/// with a tx-PIN self-unfreeze. Returns true if the account ended up unlocked.
/// Best-effort — a status-call failure is swallowed (no modal). Call from the
/// dashboard on land, or from the chatbot's guided-unfreeze tool.
Future<bool> checkAndShowFraudFreeze(BuildContext context) async {
  try {
    final status =
        await serviceLocator<FraudDetectionService>().getFreezeStatus();
    if (!status.frozen || !context.mounted) return false;
    final unlocked = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => FraudFreezeModal(status: status),
    );
    return unlocked ?? false;
  } catch (_) {
    return false;
  }
}

/// Full-screen-ish modal shown when the account is frozen for suspicious activity.
/// Offers a self-service unlock gated by the transaction PIN (the SAME tx-PIN
/// bottomsheet the transfer flow uses).
class FraudFreezeModal extends StatefulWidget {
  const FraudFreezeModal({super.key, required this.status});
  final FraudFreezeStatus status;

  @override
  State<FraudFreezeModal> createState() => _FraudFreezeModalState();
}

class _FraudFreezeModalState extends State<FraudFreezeModal>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  bool _busy = false;
  String? _error;

  Future<void> _unlock() async {
    if (_busy) return;
    final txId = 'fraud-unfreeze-${DateTime.now().microsecondsSinceEpoch}';
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txId,
        transactionType: 'fraud_unfreeze',
        amount: 0,
        currency: 'NGN',
        title: "Verify it's you",
        message: 'Enter your transaction PIN to unlock your account.',
        successMessage: 'Account unlocked',
        onPinValidated: (verificationToken) async {
          final res =
              await serviceLocator<FraudDetectionService>().requestUnfreeze(
            verificationToken: verificationToken,
            transactionId: txId,
          );
          if (!res.success) {
            throw Exception(res.message.isNotEmpty
                ? res.message
                : "Couldn't unlock your account");
          }
        },
      );
      if (ok && mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.security_rounded,
                color: const Color(0xFFF59E0B), size: 30.sp),
          ),
          SizedBox(height: 16.h),
          Text('Account locked for review',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 10.h),
          Text(
            widget.status.reason.isNotEmpty
                ? widget.status.reason
                : 'We paused a transfer that looked unusually large for your account and locked it for your security. Verify it\'s you to unlock.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 13.5.sp, height: 1.45),
          ),
          if (_error != null) ...[
            SizedBox(height: 10.h),
            Text(_error!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444), fontSize: 12.sp)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).maybePop(false),
          child: Text('Not now',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
        ),
        ElevatedButton(
          onPressed: _busy ? null : _unlock,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4E03D0),
            foregroundColor: Colors.white,
          ),
          child: _busy
              ? SizedBox(
                  height: 18.r,
                  width: 18.r,
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white))
              : const Text('Unlock account'),
        ),
      ],
    );
  }
}
