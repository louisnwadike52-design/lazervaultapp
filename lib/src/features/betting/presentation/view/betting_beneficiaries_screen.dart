import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cubit/betting_cubit.dart';
import '../cubit/betting_state.dart';
import 'betting_theme.dart';

/// Saved betting accounts management. In pick-mode (arguments {'pickMode':true})
/// tapping a row returns it to the caller for select-don't-type prefill.
class BettingBeneficiariesScreen extends StatefulWidget {
  const BettingBeneficiariesScreen({super.key});

  @override
  State<BettingBeneficiariesScreen> createState() =>
      _BettingBeneficiariesScreenState();
}

class _BettingBeneficiariesScreenState
    extends State<BettingBeneficiariesScreen> {
  static const _bg = BettingTheme.bg;
  static const _card = BettingTheme.card;
  static const _divider = BettingTheme.divider;
  static const _primary = BettingTheme.primary;
  static const _error = BettingTheme.error;
  static const _textSecondary = BettingTheme.textSecondary;

  bool _pickMode = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _pickMode = (args?['pickMode'] as bool?) ?? false;
    context.read<BettingCubit>().loadBeneficiaries();
  }

  void _confirmDelete(BettingBeneficiary b) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text('Remove saved account',
            style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        content: Text(
          'Remove ${b.nickname.isNotEmpty ? b.nickname : b.accountName}?',
          style: TextStyle(color: _textSecondary, fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel',
                style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<BettingCubit>().deleteBeneficiary(b.id);
            },
            child: const Text('Remove', style: TextStyle(color: _error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<BettingCubit, BettingState>(
                buildWhen: (_, s) =>
                    s is BettingBeneficiariesLoading ||
                    s is BettingBeneficiariesLoaded ||
                    s is BettingBeneficiariesError,
                builder: (context, state) {
                  if (state is BettingBeneficiariesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: _primary),
                    );
                  }
                  if (state is BettingBeneficiariesError) {
                    return _buildError(state.message);
                  }
                  if (state is BettingBeneficiariesLoaded) {
                    if (state.beneficiaries.isEmpty) return _buildEmpty();
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: state.beneficiaries.length,
                      itemBuilder: (context, i) =>
                          _buildTile(state.beneficiaries[i]),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
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
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            _pickMode ? 'Select saved account' : 'Saved accounts',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BettingBeneficiary b) {
    return GestureDetector(
      onTap: _pickMode ? () => Get.back(result: b) : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _divider),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(11.r),
              ),
              child: Icon(Icons.sports_soccer, color: _primary, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b.nickname.isNotEmpty ? b.nickname : b.accountName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${b.platform} · ${b.accountUserid}',
                    style: TextStyle(color: _textSecondary, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            if (_pickMode)
              Icon(Icons.chevron_right, color: _textSecondary, size: 20.sp)
            else
              IconButton(
                onPressed: () => _confirmDelete(b),
                icon: Icon(Icons.delete_outline, color: _error, size: 20.sp),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: _error, size: 40.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () =>
                  context.read<BettingCubit>().loadBeneficiaries(),
              child: const Text('Retry', style: TextStyle(color: _primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_border, color: _textSecondary, size: 44.sp),
          SizedBox(height: 12.h),
          Text(
            'No saved accounts yet',
            style: TextStyle(color: _textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
