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

class IncomingTagsScreen extends StatefulWidget {
  const IncomingTagsScreen({super.key});

  @override
  State<IncomingTagsScreen> createState() => _IncomingTagsScreenState();
}

class _IncomingTagsScreenState extends State<IncomingTagsScreen> {
  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  void _loadTags() {
    context.read<TagPayCubit>().getMyIncomingTags();
  }

  Future<void> _refreshTags() async {
    await context.read<TagPayCubit>().getMyIncomingTags();
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
              child: RefreshIndicator(
                onRefresh: _refreshTags,
                color: const Color(0xFF3B82F6),
                backgroundColor: const Color(0xFF1F1F1F),
                child: BlocBuilder<TagPayCubit, TagPayState>(
                  builder: (context, state) {
                    if (state is TagPayLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF3B82F6)),
                        ),
                      );
                    }

                    if (state is MyIncomingTagsLoaded) {
                      if (state.tags.isEmpty) {
                        return _buildEmptyState();
                      }
                      return _buildTagsList(state.tags);
                    }

                    // Show empty scrollable to allow pull-to-refresh even on error
                    return ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [],
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
                  'Tags I Received',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Tags I need to pay',
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
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Container(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80.h),
              Icon(
                Icons.inbox_outlined,
                size: 80.sp,
                color: const Color(0xFF6B7280),
              ),
              SizedBox(height: 24.h),
              Text(
                'No Incoming Tags',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'You haven\'t received any payment tags yet.\nWhen someone creates a tag for you, it will appear here.',
                textAlign: TextAlign.center,
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
    );
  }

  Widget _buildTagsList(List<UserTagEntity> tags) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(20.w),
      itemCount: tags.length,
      itemBuilder: (context, index) {
        return _buildTagItem(tags[index]);
      },
    );
  }

  Widget _buildTagItem(UserTagEntity tag) {
    final isPending = tag.status == TagStatus.pending;
    // Handle empty tagger info gracefully
    final taggerName = tag.taggerName.isNotEmpty ? tag.taggerName : 'LazerVault User';
    final taggerTag = tag.taggerTagPay.isNotEmpty ? '@${tag.taggerTagPay}' : '';

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) => TagDetailsBottomSheet(
            tag: tag,
            isOutgoing: false,
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
                ? const Color(0xFF3B82F6)
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
                      'From: $taggerName',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (taggerTag.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        taggerTag,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isPending
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                      : const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isPending ? 'PENDING' : 'PAID',
                  style: GoogleFonts.inter(
                    color: isPending
                        ? const Color(0xFF3B82F6)
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
              if (isPending)
                GestureDetector(
                  onTap: () => _navigateToQuickPay(tag),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFB923C), Color(0xFFF97316)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFB923C).withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flash_on_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Quick Pay',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
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

  /// Navigate directly to payment confirmation screen (Quick Pay flow)
  void _navigateToQuickPay(UserTagEntity tag) {
    Get.toNamed(
      AppRoutes.tagPaymentConfirmation,
      arguments: {'tag': tag},
    );
  }

}
