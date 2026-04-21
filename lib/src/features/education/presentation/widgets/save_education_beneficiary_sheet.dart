import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/education_beneficiary_remote_datasource.dart';
import '../cubit/education_beneficiary_cubit.dart';
import '../cubit/education_beneficiary_state.dart';

/// Save / edit a saved exam candidate (education PIN beneficiary).
/// Minimal single-field (nickname) sheet that writes through the cubit.
/// On create the nickname is required; on edit it may be cleared.
class SaveEducationBeneficiarySheet extends StatefulWidget {
  final String candidateNumber;
  final String examType;
  final String providerCode;
  final String providerName;
  final String? candidateName;
  final String? existingBeneficiaryId;
  final String? existingNickname;

  const SaveEducationBeneficiarySheet({
    super.key,
    required this.candidateNumber,
    required this.examType,
    required this.providerCode,
    required this.providerName,
    this.candidateName,
    this.existingBeneficiaryId,
    this.existingNickname,
  });

  bool get isEditing => existingBeneficiaryId != null;

  static Future<bool?> show(
    BuildContext context, {
    required String candidateNumber,
    required String examType,
    required String providerCode,
    required String providerName,
    String? candidateName,
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
      builder: (_) => BlocProvider(
        create: (_) => GetIt.I<EducationBeneficiaryCubit>(),
        child: SaveEducationBeneficiarySheet(
          candidateNumber: candidateNumber,
          examType: examType,
          providerCode: providerCode,
          providerName: providerName,
          candidateName: candidateName,
          existingBeneficiaryId: existingBeneficiaryId,
          existingNickname: existingNickname,
        ),
      ),
    );
  }

  @override
  State<SaveEducationBeneficiarySheet> createState() =>
      _SaveEducationBeneficiarySheetState();
}

class _SaveEducationBeneficiarySheetState
    extends State<SaveEducationBeneficiarySheet> {
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
    final nickname = _nicknameController.text.trim().isEmpty
        ? null
        : _nicknameController.text.trim();

    if (!widget.isEditing && (nickname == null || nickname.isEmpty)) {
      setState(() => _error = 'Nickname is required');
      return;
    }

    if (nickname != null && nickname.isNotEmpty) {
      try {
        final ds = GetIt.I<EducationBeneficiaryRemoteDataSource>();
        final beneficiaries = await ds.getBeneficiaries();
        final duplicate = beneficiaries.any(
          (b) =>
              b.nickname != null &&
              b.nickname!.toLowerCase() == nickname.toLowerCase() &&
              b.id != widget.existingBeneficiaryId,
        );
        if (duplicate) {
          setState(() => _error = 'This name is already used for another candidate');
          return;
        }
      } catch (_) {
        // Best-effort — proceed if the duplicate probe fails.
      }
    }

    if (!mounted) return;
    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final cubit = context.read<EducationBeneficiaryCubit>();
      if (widget.isEditing) {
        await cubit.update(
          beneficiaryId: widget.existingBeneficiaryId!,
          nickname: nickname ?? '',
        );
      } else {
        await cubit.save(
          candidateNumber: widget.candidateNumber,
          examType: widget.examType,
          providerCode: widget.providerCode,
          providerName: widget.providerName,
          nickname: nickname,
          candidateName: widget.candidateName,
        );
      }
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.isEditing;
    return BlocListener<EducationBeneficiaryCubit, EducationBeneficiaryState>(
      listener: (context, state) {
        if (state is EducationBeneficiaryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Padding(
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
              isEdit ? 'Edit Candidate' : 'Save Candidate',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '${widget.examType.toUpperCase()} \u00B7 ${widget.candidateNumber}',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Text(
                  'Nickname',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (!widget.isEditing) ...[
                  SizedBox(width: 4.w),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFFEF4444),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
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
                hintText: 'e.g., Son, Daughter, Self',
                hintStyle: TextStyle(
                    color: const Color(0xFF4B5563), fontSize: 15.sp),
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
                        isEdit ? 'Update Candidate' : 'Save Candidate',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
