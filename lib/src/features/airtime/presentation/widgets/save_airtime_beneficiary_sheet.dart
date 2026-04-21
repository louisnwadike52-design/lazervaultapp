import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/airtime_repository.dart';

/// Bottom sheet for saving or editing an airtime beneficiary.
///
/// Mirrors `SaveDataBeneficiarySheet` but uses the airtime repository.
class SaveAirtimeBeneficiarySheet extends StatefulWidget {
  final String phoneNumber;
  final String networkCode;
  final String networkName;
  final String? operatorId;
  final String countryCode;
  final String? existingBeneficiaryId;
  final String? existingNickname;

  const SaveAirtimeBeneficiarySheet({
    super.key,
    required this.phoneNumber,
    required this.networkCode,
    required this.networkName,
    this.operatorId,
    this.countryCode = 'NG',
    this.existingBeneficiaryId,
    this.existingNickname,
  });

  bool get isEditing => existingBeneficiaryId != null;

  static Future<bool?> show(
    BuildContext context, {
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? operatorId,
    String countryCode = 'NG',
    String? existingBeneficiaryId,
    String? existingNickname,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => SaveAirtimeBeneficiarySheet(
        phoneNumber: phoneNumber,
        networkCode: networkCode,
        networkName: networkName,
        operatorId: operatorId,
        countryCode: countryCode,
        existingBeneficiaryId: existingBeneficiaryId,
        existingNickname: existingNickname,
      ),
    );
  }

  @override
  State<SaveAirtimeBeneficiarySheet> createState() =>
      _SaveAirtimeBeneficiarySheetState();
}

class _SaveAirtimeBeneficiarySheetState
    extends State<SaveAirtimeBeneficiarySheet> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.existingNickname != null) {
      _nicknameController.text = widget.existingNickname!;
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final nickname = _nicknameController.text.trim();

    // Validate unique nickname
    if (nickname.isNotEmpty) {
      try {
        final repo = GetIt.I<AirtimeRepository>();
        final beneficiaries = await repo.getAirtimeBeneficiaries();
        final duplicate = beneficiaries.any(
          (b) =>
              b.nickname != null &&
              b.nickname!.toLowerCase() == nickname.toLowerCase() &&
              b.id != widget.existingBeneficiaryId,
        );
        if (duplicate) {
          setState(() =>
              _error = 'This name is already used for another contact');
          return;
        }
      } catch (_) {
        // Proceed — validation is best-effort
      }
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final repo = GetIt.I<AirtimeRepository>();
      if (widget.isEditing) {
        await repo.updateAirtimeBeneficiary(
          beneficiaryId: widget.existingBeneficiaryId!,
          nickname: nickname.isEmpty ? null : nickname,
        );
      } else {
        await repo.saveAirtimeBeneficiary(
          phoneNumber: widget.phoneNumber,
          networkCode: widget.networkCode,
          networkName: widget.networkName,
          nickname: nickname.isEmpty ? null : nickname,
          countryCode: widget.countryCode,
          operatorId: widget.operatorId,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEditing;
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 20.h),
          Text(
            isEdit ? 'Edit Airtime Contact' : 'Save Airtime Contact',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${widget.phoneNumber} \u00B7 ${widget.networkName}',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Nickname',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _nicknameController,
            autofocus: true,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
            decoration: InputDecoration(
              hintText: 'e.g., Mom, Brother',
              hintStyle:
                  TextStyle(color: const Color(0xFF4B5563), fontSize: 15.sp),
              errorText: _error,
              filled: true,
              fillColor: const Color(0xFF0A0A0A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF4E03D0)),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: _saving
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      isEdit ? 'Update Contact' : 'Save Contact',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
