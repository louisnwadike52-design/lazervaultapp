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
  }) {
    return showModalBottomSheet<BillBeneficiaryEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => _RenameMeterSheetBody(beneficiary: beneficiary),
    );
  }
}

class _RenameMeterSheetBody extends StatefulWidget {
  const _RenameMeterSheetBody({required this.beneficiary});

  final BillBeneficiaryEntity beneficiary;

  @override
  State<_RenameMeterSheetBody> createState() => _RenameMeterSheetBodyState();
}

class _RenameMeterSheetBodyState extends State<_RenameMeterSheetBody> {
  late final TextEditingController _controller;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.beneficiary.nickname);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;
    final newName = _controller.text.trim();
    if (newName.isEmpty) {
      setState(() => _error = 'Nickname cannot be empty');
      return;
    }
    if (newName == widget.beneficiary.nickname) {
      Navigator.of(context).pop();
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final repo = GetIt.I<ElectricityBillRepository>();
    final res = await repo.updateBeneficiary(
      beneficiaryId: widget.beneficiary.id,
      nickname: newName,
    );
    // Sheet may have been dismissed mid-save — bail before touching state.
    if (!mounted) return;
    res.fold(
      (f) => setState(() {
        _saving = false;
        _error = f.message;
      }),
      (updated) {
        Navigator.of(context).pop(updated);
        Get.snackbar(
          'Updated',
          'Meter nickname saved',
          backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                'Rename Meter',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '${widget.beneficiary.providerName} · ${widget.beneficiary.meterNumber}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _controller,
                autofocus: true,
                enabled: !_saving,
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
        ),
      ),
    );
  }
}
