import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batches_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batches_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';

/// Lists every saved-batch draft for the current user. Mirrors the
/// electricity-bill beneficiaries-screen visual language.
class SavedBatchesScreen extends StatefulWidget {
  const SavedBatchesScreen({super.key});

  @override
  State<SavedBatchesScreen> createState() => _SavedBatchesScreenState();
}

class _SavedBatchesScreenState extends State<SavedBatchesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SavedBatchesCubit>().load();
    });
  }

  Future<void> _refresh() async {
    await context.read<SavedBatchesCubit>().refresh();
  }

  void _openDetail(SavedBatchEntity batch) async {
    await Get.toNamed(
      AppRoutes.savedBatchDetail,
      arguments: {'savedBatchId': batch.id},
    );
    if (mounted) {
      // Refresh on return so any rename / item edits / delete is reflected.
      context.read<SavedBatchesCubit>().refresh();
    }
  }

  Future<void> _confirmDelete(SavedBatchEntity batch) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCard,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r)),
        title: Text('Delete saved batch?',
            style: GoogleFonts.inter(
                color: btTextPrimary, fontWeight: FontWeight.w600)),
        content: Text(
          'This will remove "${batch.name}" and all of its ${batch.itemCount} recipients. No money will be moved.',
          style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: btTextSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text('Delete',
                style: GoogleFonts.inter(color: btRed)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!mounted) return;
    final ok = await context.read<SavedBatchesCubit>().delete(batch.id);
    if (!mounted) return;
    Get.snackbar(
      ok ? 'Deleted' : 'Could not delete',
      ok
          ? 'Saved batch removed.'
          : 'We could not delete this saved batch. Please try again.',
      backgroundColor: ok ? btGreen : btRed,
      colorText: btTextPrimary,
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: btBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                color: btBlue,
                backgroundColor: btCard,
                child: BlocBuilder<SavedBatchesCubit, SavedBatchesState>(
                  builder: (context, state) {
                    if (state is SavedBatchesLoading) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 60.h),
                          const Center(
                              child: CircularProgressIndicator(color: btBlue)),
                        ],
                      );
                    }
                    if (state is SavedBatchesError) {
                      return _buildError(state.message);
                    }
                    final batches = state is SavedBatchesLoaded
                        ? state.batches
                        : const <SavedBatchEntity>[];
                    if (batches.isEmpty) {
                      return _buildEmpty();
                    }
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                      itemCount: batches.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, i) =>
                          _buildBatchCard(batches[i]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child:
                  Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saved Batches',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 2.h),
                Text('Reusable transfer templates. No money moves until you tap Send.',
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 12.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: btBlue.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(Icons.bookmark_border_rounded,
                    color: btBlue, size: 32.sp),
              ),
              SizedBox(height: 16.h),
              Text('No saved batches yet',
                  style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 6.h),
              SizedBox(
                width: 280.w,
                child: Text(
                  'Save a batch from the review screen and it will appear here. Saved batches let you re-send to the same recipients with one tap.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: btTextSecondary, fontSize: 12.sp, height: 1.5),
                ),
              ),
              SizedBox(height: 22.h),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.batchTransfer),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: btBlue,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text('Start a new batch',
                      style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              Icon(Icons.error_outline_rounded, color: btRed, size: 32.sp),
              SizedBox(height: 12.h),
              Text('Could not load saved batches',
                  style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 6.h),
              SizedBox(
                width: 280.w,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.inter(color: btTextSecondary, fontSize: 12.sp),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () => context.read<SavedBatchesCubit>().load(),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: btBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text('Retry',
                      style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBatchCard(SavedBatchEntity batch) {
    final symbol = CurrencyUtils.getSymbol(batch.currency);
    final updated = batch.updatedAt ?? batch.createdAt;
    final updatedStr = updated != null
        ? DateFormat('MMM dd, yyyy').format(updated)
        : '';

    return GestureDetector(
      onTap: () => _openDetail(batch),
      onLongPress: () => _confirmDelete(batch),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: btBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: btBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.bookmark_rounded, color: btBlue, size: 20.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    batch.name.isEmpty ? 'Untitled batch' : batch.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${batch.itemCount} recipient${batch.itemCount == 1 ? '' : 's'}  •  $symbol${batch.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 12.sp),
                  ),
                  if (updatedStr.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text('Updated $updatedStr',
                        style: GoogleFonts.inter(
                            color: btTextTertiary, fontSize: 11.sp)),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () => _confirmDelete(batch),
              icon: Icon(Icons.delete_outline,
                  color: btTextSecondary, size: 20.sp),
              tooltip: 'Delete saved batch',
            ),
          ],
        ),
      ),
    );
  }
}
