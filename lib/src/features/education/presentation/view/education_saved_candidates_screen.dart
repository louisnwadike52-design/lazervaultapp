import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_beneficiary_item.dart';
import '../../domain/entities/education_beneficiary.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../cubit/education_beneficiary_cubit.dart';
import '../cubit/education_beneficiary_state.dart';

/// Saved exam candidates for education PIN purchases. Actions: View
/// Details, View Purchases, Buy PIN, Set Reminder, Edit Nickname, Delete.
/// Education has no auto-recharge since PINs are one-time purchases.
class EducationSavedCandidatesScreen extends StatefulWidget {
  const EducationSavedCandidatesScreen({super.key});

  @override
  State<EducationSavedCandidatesScreen> createState() =>
      _EducationSavedCandidatesScreenState();
}

class _EducationSavedCandidatesScreenState
    extends State<EducationSavedCandidatesScreen> {
  List<EducationBeneficiary>? _beneficiaries;
  bool _loading = true;
  String? _error;

  static const Color _primary = Color(0xFF4E03D0);

  Color _providerColor(String code) {
    final c = code.toUpperCase();
    if (c.contains('WAEC')) return const Color(0xFF10B981);
    if (c.contains('JAMB')) return _primary;
    if (c.contains('NECO')) return const Color(0xFFFB923C);
    if (c.contains('NABTEB')) return const Color(0xFFEF4444);
    return _primary;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EducationBeneficiaryCubit>(
      create: (_) => GetIt.I<EducationBeneficiaryCubit>()..load(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
          ),
          title: Text('Saved Candidates',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          actions: [
            IconButton(
              tooltip: 'Reminders',
              onPressed: () => Get.toNamed(AppRoutes.educationReminders),
              icon: Icon(Icons.notifications_outlined,
                  color: const Color(0xFFFB923C), size: 22.sp),
            ),
          ],
        ),
        body: BlocListener<EducationBeneficiaryCubit, EducationBeneficiaryState>(
          listener: (context, state) {
            if (!mounted) return;
            if (state is EducationBeneficiariesLoading) {
              setState(() {
                _loading = true;
                _error = null;
              });
            } else if (state is EducationBeneficiariesLoaded) {
              setState(() {
                _beneficiaries = state.beneficiaries;
                _loading = false;
                _error = null;
              });
            } else if (state is EducationBeneficiaryError) {
              setState(() {
                _loading = false;
                _error = state.message;
              });
            }
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null &&
        (_beneficiaries == null || _beneficiaries!.isEmpty)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 16.h),
            Text(_error!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () =>
                  context.read<EducationBeneficiaryCubit>().load(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (_loading && _beneficiaries == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(_primary),
        ),
      );
    }
    final list = _beneficiaries ?? const [];
    if (list.isEmpty) return _buildEmpty();
    return RefreshIndicator(
      color: _primary,
      backgroundColor: const Color(0xFF1F1F1F),
      onRefresh: () => context.read<EducationBeneficiaryCubit>().load(),
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (_, i) => _buildItem(list[i]),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined,
                size: 64.sp, color: const Color(0xFF4B5563)),
            SizedBox(height: 16.h),
            Text(
              'No saved candidates yet',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 8.h),
            Text(
              'After buying an exam PIN, tap "Save Candidate" on the result screen to add them here for one-tap repurchases.',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(EducationBeneficiary b) {
    final accent = _providerColor(b.providerCode);
    return BillBeneficiaryItem(
      displayName: (b.nickname?.isNotEmpty == true)
          ? b.nickname!
          : b.candidateNumber,
      identifier: '${b.examType.toUpperCase()} \u00B7 ${b.candidateNumber}',
      providerName: b.providerName,
      providerColor: accent,
      lastPlanOrAmount: (b.lastAmount != null && b.lastAmount! > 0)
          ? '\u20A6${b.lastAmount!.toStringAsFixed(0)}'
          : null,
      usageCount: b.purchaseCount,
      onTap: () => _showOptions(b),
      onLongPress: () => _confirmDelete(b),
      flat: true,
      leftAccentColor: accent,
    );
  }

  void _showOptions(EducationBeneficiary b) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r)),
            ),
            SizedBox(height: 16.h),
            ListTile(
              leading: const Icon(Icons.info_outline, color: _primary),
              title: Text('View Details',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _showDetailsDialog(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.history, color: Color(0xFF9CA3AF)),
              title: Text('View Purchases',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.educationHistory,
                  arguments: {
                    'candidateNumber': b.candidateNumber,
                    'examType': b.examType,
                    'providerCode': b.providerCode,
                  },
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: const Icon(Icons.school, color: _primary),
              title: Text('Buy PIN',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _startRepeatPurchase(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: const Icon(Icons.notifications_outlined,
                  color: Color(0xFFFB923C)),
              title: Text('Set Reminder',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                Get.toNamed(
                  AppRoutes.educationRemindersCreate,
                  arguments: {'beneficiary': b},
                );
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading:
                  const Icon(Icons.edit_outlined, color: Color(0xFF9CA3AF)),
              title: Text('Edit Nickname',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _editNickname(b);
              },
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            ListTile(
              leading: const Icon(Icons.delete_outline,
                  color: Color(0xFFEF4444)),
              title: Text('Delete Candidate',
                  style: TextStyle(
                      color: const Color(0xFFEF4444), fontSize: 15.sp)),
              onTap: () {
                Navigator.of(ctx).pop();
                _confirmDelete(b);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Route a saved candidate into the purchase flow. Builds a minimal
  /// synthetic `EducationProviderEntity` and passes `rebuyPurchase` so
  /// the purchase screen pre-fills billers code + phone if available.
  void _startRepeatPurchase(EducationBeneficiary b) {
    final provider = EducationProviderEntity(
      id: b.providerCode,
      name: b.providerName,
      serviceId: b.examType.toLowerCase(),
      variationCode: '',
      logoUrl: '',
      isActive: true,
      amount: b.lastAmount ?? 0,
      description: b.providerName,
    );
    Get.toNamed(
      AppRoutes.educationPurchase,
      arguments: <String, dynamic>{
        'provider': provider,
        'rebuyPurchase': <String, dynamic>{
          'billersCode': b.candidateNumber,
          'quantity': 1,
        },
      },
    );
  }

  void _showDetailsDialog(EducationBeneficiary b) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        titlePadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
        contentPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
        actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
        title: Text(
          b.nickname?.isNotEmpty == true ? b.nickname! : b.candidateNumber,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('Candidate #', b.candidateNumber),
                _detailRow('Exam Type', b.examType.toUpperCase()),
                _detailRow('Provider', b.providerName),
                if (b.nickname?.isNotEmpty == true)
                  _detailRow('Nickname', b.nickname!),
                if (b.candidateName?.isNotEmpty == true)
                  _detailRow('Candidate name', b.candidateName!),
                if (b.lastAmount != null && b.lastAmount! > 0)
                  _detailRow('Last amount',
                      '\u20A6${b.lastAmount!.toStringAsFixed(2)}'),
                _detailRow('Purchases', b.purchaseCount.toString()),
                if (b.lastPurchaseAt != null && b.lastPurchaseAt!.isNotEmpty)
                  _detailRow('Last used', _formatIso(b.lastPurchaseAt)),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Close',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(label,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  String _formatIso(String? iso) {
    if (iso == null || iso.isEmpty) return '\u2014';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    return dt.toLocal().toString().split('.').first;
  }

  void _editNickname(EducationBeneficiary b) {
    final controller = TextEditingController(text: b.nickname ?? '');
    bool loading = false;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: Text('Edit Nickname',
              style: TextStyle(color: Colors.white, fontSize: 17.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${b.providerName} \u00B7 ${b.candidateNumber}',
                  style: TextStyle(
                      fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              SizedBox(height: 16.h),
              TextField(
                controller: controller,
                autofocus: true,
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Enter nickname',
                  hintStyle: TextStyle(
                      color: const Color(0xFF4B5563), fontSize: 15.sp),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xFF2D2D2D))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xFF2D2D2D))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: _primary)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Cancel',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 14.sp))),
            TextButton(
              onPressed: loading
                  ? null
                  : () async {
                      setLocal(() => loading = true);
                      try {
                        await context
                            .read<EducationBeneficiaryCubit>()
                            .update(
                              beneficiaryId: b.id,
                              nickname: controller.text.trim().isEmpty
                                  ? null
                                  : controller.text.trim(),
                            );
                        if (ctx.mounted) Navigator.of(ctx).pop();
                      } catch (_) {
                        setLocal(() => loading = false);
                      }
                    },
              child: loading
                  ? SizedBox(
                      width: 14.w,
                      height: 14.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(_primary),
                      ),
                    )
                  : Text('Save',
                      style: TextStyle(
                          color: _primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(EducationBeneficiary b) {
    final name =
        (b.nickname?.isNotEmpty == true) ? b.nickname! : b.candidateNumber;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete Candidate',
            style: TextStyle(color: Colors.white, fontSize: 17.sp)),
        content: Text(
          'Delete $name? This cannot be undone.',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<EducationBeneficiaryCubit>().delete(b.id);
            },
            child: Text('Delete',
                style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
