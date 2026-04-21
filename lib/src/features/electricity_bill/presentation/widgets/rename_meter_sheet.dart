import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';

/// Bottom-sheet that lets the user rename a saved meter beneficiary
/// inline. Used from the payment-history actions sheet AND the saved-
/// meters screen so every surface offers the same rename UX and the
/// new nickname appears everywhere the next time beneficiaries are
/// fetched (both call sites re-query via `BeneficiaryCubit.getBeneficiaries`
/// / repo fetch so no manual propagation is needed).
class RenameMeterSheet {
  RenameMeterSheet._();

  /// Returns the freshly-updated [BillBeneficiaryEntity] when the nickname
  /// was saved, or `null` when the user dismissed or the save failed.
  /// Callers that hold the beneficiary list in state use the returned
  /// entity to patch the single item in place instead of re-fetching.
  static Future<BillBeneficiaryEntity?> show(
    BuildContext context, {
    required BillBeneficiaryEntity beneficiary,
  }) async {
    final controller = TextEditingController(text: beneficiary.nickname);
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
                final newName = controller.text.trim();
                if (newName.isEmpty) {
                  setSheetState(() => error = 'Nickname cannot be empty');
                  return;
                }
                if (newName == beneficiary.nickname) {
                  Navigator.of(ctx).pop();
                  return;
                }
                setSheetState(() {
                  saving = true;
                  error = null;
                });
                final repo = GetIt.I<ElectricityBillRepository>();
                final res = await repo.updateBeneficiary(
                  beneficiaryId: beneficiary.id,
                  nickname: newName,
                );
                res.fold(
                  (f) => setSheetState(() {
                    saving = false;
                    error = f.message;
                  }),
                  (updated) => Navigator.of(ctx).pop(updated),
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
                      'Rename Meter',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${beneficiary.providerName} \u00B7 ${beneficiary.meterNumber}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      enabled: !saving,
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
                              'Save',
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
        'Updated',
        'Meter nickname saved',
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    }
    return result;
  }
}
