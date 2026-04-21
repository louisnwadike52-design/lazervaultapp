import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import '../cubit/water_beneficiary_cubit.dart';
import '../cubit/water_beneficiary_state.dart';

/// Save / edit a water utility account. Mirrors
/// `SaveInternetBeneficiarySheet` — minimal single-field (nickname) sheet
/// that writes straight through to the commerce-gateway backed cubit.
/// On create the nickname is required; on edit it may be cleared.
class SaveWaterBeneficiarySheet extends StatefulWidget {
  final String accountNumber;
  final String providerCode;
  final String providerName;
  final String? customerName;
  final String? existingBeneficiaryId;
  final String? existingNickname;

  const SaveWaterBeneficiarySheet({
    super.key,
    required this.accountNumber,
    required this.providerCode,
    required this.providerName,
    this.customerName,
    this.existingBeneficiaryId,
    this.existingNickname,
  });

  bool get isEditing => existingBeneficiaryId != null;

  static Future<bool?> show(
    BuildContext context, {
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? customerName,
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
        create: (_) => GetIt.I<WaterBeneficiaryCubit>(),
        child: SaveWaterBeneficiarySheet(
          accountNumber: accountNumber,
          providerCode: providerCode,
          providerName: providerName,
          customerName: customerName,
          existingBeneficiaryId: existingBeneficiaryId,
          existingNickname: existingNickname,
        ),
      ),
    );
  }

  @override
  State<SaveWaterBeneficiarySheet> createState() =>
      _SaveWaterBeneficiarySheetState();
}

class _SaveWaterBeneficiarySheetState extends State<SaveWaterBeneficiarySheet> {
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
        final ds = GetIt.I<WaterBeneficiaryRemoteDataSource>();
        final beneficiaries = await ds.getBeneficiaries();
        final duplicate = beneficiaries.any(
          (b) =>
              b.nickname != null &&
              b.nickname!.toLowerCase() == nickname.toLowerCase() &&
              b.id != widget.existingBeneficiaryId,
        );
        if (duplicate) {
          setState(() => _error = 'This name is already used for another contact');
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
      final cubit = context.read<WaterBeneficiaryCubit>();
      if (widget.isEditing) {
        await cubit.update(
          beneficiaryId: widget.existingBeneficiaryId!,
          nickname: nickname ?? '',
        );
      } else {
        await cubit.save(
          accountNumber: widget.accountNumber,
          providerCode: widget.providerCode,
          providerName: widget.providerName,
          nickname: nickname,
          customerName: widget.customerName,
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
    return BlocListener<WaterBeneficiaryCubit, WaterBeneficiaryState>(
      listener: (context, state) {
        if (state is WaterBeneficiaryError) {
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
              isEdit ? 'Edit Water Account' : 'Save Water Account',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '${widget.accountNumber} \u00B7 ${widget.providerName}',
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
                hintText: 'e.g., Home, Shop',
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
                        isEdit ? 'Update Account' : 'Save Account',
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
