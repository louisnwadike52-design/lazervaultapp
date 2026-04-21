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
  }) async {
    final controller = TextEditingController(text: payment.customerName);
    bool saving = false;
    String? error;

    final result = await showModalBottomSheet<BillBeneficiaryEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (ctx, setSheetState) {
              Future<void> submit() async {
                final nickname = controller.text.trim();
                if (nickname.isEmpty) {
                  setSheetState(() => error = 'Nickname cannot be empty');
                  return;
                }
                setSheetState(() {
                  saving = true;
                  error = null;
                });
                final repo = GetIt.I<ElectricityBillRepository>();
                final res = await repo.saveBeneficiary(
                  providerId: payment.providerId,
                  providerCode: payment.providerCode,
                  providerName: payment.providerName,
                  meterNumber: payment.meterNumber,
                  meterType: payment.meterType,
                  customerName: payment.customerName,
                  customerAddress: payment.customerAddress,
                  nickname: nickname,
                );
                res.fold(
                  (f) => setSheetState(() {
                    saving = false;
                    error = f.message;
                  }),
                  (beneficiary) => Navigator.of(ctx).pop(beneficiary),
                );
              }

              return Padding(
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
                      '${payment.providerName} · ${payment.meterNumber}',
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
                      controller: controller,
                      autofocus: true,
                      enabled: !saving,
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
                        errorText: error,
                      ),
                      onSubmitted: (_) => submit(),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: saving ? null : submit,
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
                      child: saving
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
              );
            },
          ),
        );
      },
    );

    controller.dispose();
    if (result != null) {
      Get.snackbar(
        'Saved',
        'Meter added to your beneficiaries',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
    return result;
  }
}
