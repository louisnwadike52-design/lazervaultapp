import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import '../widgets/tag_details_bottom_sheet.dart';

class OutgoingTagsScreen extends StatefulWidget {
  const OutgoingTagsScreen({super.key});

  @override
  State<OutgoingTagsScreen> createState() => _OutgoingTagsScreenState();
}

class _OutgoingTagsScreenState extends State<OutgoingTagsScreen> {
  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  void _loadTags() {
    context.read<TagPayCubit>().getMyOutgoingTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocConsumer<TagPayCubit, TagPayState>(
                listener: (context, state) {
                  if (state is TagPaidSuccess) {
                    Get.snackbar(
                      'Success!',
                      state.message,
                      backgroundColor: const Color(0xFF10B981),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                    _loadTags();
                  } else if (state is TagPayError) {
                    Get.snackbar(
                      'Error',
                      state.message,
                      backgroundColor: const Color(0xFFEF4444),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TagPayLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF3B82F6)),
                      ),
                    );
                  }

                  if (state is MyOutgoingTagsLoaded) {
                    if (state.tags.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildTagsList(state.tags);
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
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tags I Sent',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tags where others owe me',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.label_outline,
            size: 80.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Outgoing Tags',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'You haven\'t created any payment tags yet.\nCreate a tag to track payments you need to make.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 32.h),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.createTag),
            icon: Icon(Icons.add, size: 20.sp),
            label: Text(
              'Create Tag',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsList(List<UserTagEntity> tags) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: tags.length,
      itemBuilder: (context, index) {
        return _buildTagItem(tags[index]);
      },
    );
  }

  Widget _buildTagItem(UserTagEntity tag) {
    final isPending = tag.status == TagStatus.pending;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => TagDetailsBottomSheet(
            tag: tag,
            isOutgoing: true,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isPending
                ? const Color(0xFFFB923C)
                : const Color(0xFF10B981),
            width: 1,
          ),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To: ${tag.taggedUserName}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '@${tag.taggedUserTagPay}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFFFB923C).withValues(alpha: 0.1)
                      : const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isPending ? 'PENDING' : 'PAID',
                  style: GoogleFonts.inter(
                    color: isPending
                        ? const Color(0xFFFB923C)
                        : const Color(0xFF10B981),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${tag.currency} ${tag.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: isPending ? const Color(0xFFFB923C) : const Color(0xFF10B981),
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (tag.description.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              tag.description,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ],
        ],
      ),
      ),
    );
  }

}
