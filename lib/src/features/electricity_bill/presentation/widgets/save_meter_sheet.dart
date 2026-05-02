import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';

/// Bottom-sheet that saves a meter as a beneficiary inline from the
/// payment-history actions sheet. The user only picks a nickname — every
/// other field (provider, meter number, meter type, customer name and
/// address) is carried over from the [BillPaymentEntity] that already
/// went through meter validation, so there is nothing to re-validate.
///
/// Returns the freshly-saved [BillBeneficiaryEntity] on success so
/// callers that need the beneficiary — e.g. attaching a reminder or
/// auto-recharge to it — can use it without a second round-trip.
/// Returns `null` if the user dismissed or the save failed.
class SaveMeterSheet {
  SaveMeterSheet._();

  static Future<BillBeneficiaryEntity?> show(
    BuildContext context, {
    required BillPaymentEntity payment,
  }) {
    return showModalBottomSheet<BillBeneficiaryEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _SaveMeterSheetBody(payment: payment),
    );
  }
}

class _SaveMeterSheetBody extends StatefulWidget {
  const _SaveMeterSheetBody({required this.payment});

  final BillPaymentEntity payment;

  @override
  State<_SaveMeterSheetBody> createState() => _SaveMeterSheetBodyState();
}

class _SaveMeterSheetBodyState extends State<_SaveMeterSheetBody> {
  late final TextEditingController _controller;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.payment.customerName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final nickname = _controller.text.trim();
    if (nickname.isEmpty) {
      setState(() => _error = 'Nickname cannot be empty');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final repo = GetIt.I<ElectricityBillRepository>();
    final res = await repo.saveBeneficiary(
      providerId: widget.payment.providerId,
      providerCode: widget.payment.providerCode,
      providerName: widget.payment.providerName,
      meterNumber: widget.payment.meterNumber,
      meterType: widget.payment.meterType,
      customerName: widget.payment.customerName,
      customerAddress: widget.payment.customerAddress,
      nickname: nickname,
    );
    // Sheet may have been dismissed mid-save — bail before touching state.
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _saving = false;
        _error = f.message;
      }),
      (beneficiary) {
        Navigator.of(context).pop(beneficiary);
        Get.snackbar(
          'Saved',
          'Meter added to your beneficiaries',
          backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Block back-button / drag-down dismiss while a save is in flight so the
    // user can't strand a pending request and so the controller isn't torn
    // down before the result lands.
    return PopScope(
      canPop: !_saving,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4B5563),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Save Meter',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${widget.payment.providerName} · ${widget.payment.meterNumber}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Name this meter',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: _controller,
                autofocus: true,
                enabled: !_saving,
                textCapitalization: TextCapitalization.words,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g. Home meter',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  errorText: _error,
                ),
                onSubmitted: (_) => _submit(),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _saving ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      const Color(0xFF4E03D0).withValues(alpha: 0.4),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _saving
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Save Meter',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
