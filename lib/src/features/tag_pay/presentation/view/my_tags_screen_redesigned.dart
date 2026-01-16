import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/shared_widgets/app_loading_button.dart';
import '../../../../../core/shared_widgets/lv_snackbar.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';

class MyTagsScreenRedesigned extends StatefulWidget {
  const MyTagsScreenRedesigned({super.key});

  @override
  State<MyTagsScreenRedesigned> createState() => _MyTagsScreenRedesignedState();
}

class _MyTagsScreenRedesignedState extends State<MyTagsScreenRedesigned> {
  @override
  void initState() {
    super.initState();
    // Always fetch fresh tags when screen loads, no caching
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTags();
    });
  }

  void _loadTags() {
    // Force fresh fetch of tags from backend
    context.read<TagPayCubit>().getMyTags();
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

                  if (state is TagPayError) {
                    return _buildError(state.message);
                  }

                  if (state is MyTagsLoaded) {
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
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        int pendingCount = 0;
        if (state is MyTagsLoaded) {
          pendingCount = state.tags.where((t) => t.status == TagStatus.pending).length;
        }

        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF4E03D0), const Color(0xFF6B21E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
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
                    Row(
                      children: [
                        Text(
                          'My Tags',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (pendingCount > 0) ...[
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              '$pendingCount',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      pendingCount > 0
                          ? '$pendingCount pending payment${pendingCount > 1 ? "s" : ""}'
                          : 'All caught up!',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _loadTags,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagsList(List<UserTagEntity> tags) {
    // Separate pending and paid tags
    final pendingTags = tags.where((tag) => tag.status == TagStatus.pending).toList();
    final paidTags = tags.where((tag) => tag.status == TagStatus.paid).toList();

    return RefreshIndicator(
      onRefresh: () async {
        _loadTags();
      },
      child: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          if (pendingTags.isNotEmpty) ...[
            Text(
              'Pending Payments',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            ...pendingTags.map((tag) => _buildTagCard(tag, isPending: true)),
            SizedBox(height: 24.h),
          ],
          if (paidTags.isNotEmpty) ...[
            Text(
              'Paid Tags',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            ...paidTags.map((tag) => _buildTagCard(tag, isPending: false)),
          ],
        ],
      ),
    );
  }

  Widget _buildTagCard(UserTagEntity tag, {required bool isPending}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: isPending
            ? Border.all(color: const Color(0xFF3B82F6), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Icon(
                        Icons.person,
                        color: const Color(0xFF3B82F6),
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tag.taggerName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '@${tag.taggerTagPay}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isPending)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xFF10B981),
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Paid',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF10B981),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            tag.formattedAmount,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      if (tag.description.isNotEmpty)
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'For',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                tag.description,
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: const Color(0xFF9CA3AF),
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _formatDate(tag.createdAt),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isPending)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Quick Pay Button
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          await Get.bottomSheet<bool>(
                            _QuickPayBottomSheet(tag: tag),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                        },
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flash_on,
                                color: const Color(0xFF4E03D0),
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Quick Pay',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF4E03D0),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 48.h,
                    color: const Color(0xFF2D2D2D),
                  ),
                  // Details Button
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.tagPaymentConfirmation,
                            arguments: tag,
                          );
                        },
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(16.r),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.payment,
                                color: const Color(0xFF10B981),
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Details',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF10B981),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 80.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Tags Yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Tags from other users will appear here.\nShare your @username to receive tags!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 24.h),
            Text(
              'Failed to Load Tags',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _loadTags,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Quick Pay Bottom Sheet Widget
class _QuickPayBottomSheet extends StatefulWidget {
  final UserTagEntity tag;
  const _QuickPayBottomSheet({required this.tag});

  @override
  State<_QuickPayBottomSheet> createState() => _QuickPayBottomSheetState();
}

class _QuickPayBottomSheetState extends State<_QuickPayBottomSheet> {
  final _pinController = TextEditingController();
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Title & Amount
          Text(
            'Quick Pay',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            widget.tag.formattedAmount,
            style: GoogleFonts.inter(
              color: const Color(0xFF4E03D0),
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'to ${widget.tag.taggerName}',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),

          SizedBox(height: 24.h),

          // PIN Input
          TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            textAlign: TextAlign.center,
            autofocus: true,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              letterSpacing: 12,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: '••••',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 24.sp,
                letterSpacing: 12,
              ),
              counterText: '',
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Pay Button
          AppLoadingButton(
            text: 'Pay Now',
            isLoading: _isProcessing,
            backgroundColor: const Color(0xFF4E03D0),
            onPressed: _processPinPayment,
          ),

          SizedBox(height: 16.h),
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Future<void> _processPinPayment() async {
    if (_pinController.text.length != 4) {
      LVSnackbar.showError(
        title: 'Invalid PIN',
        message: 'Please enter your 4-digit PIN',
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // Get default account
      final accountCubit = context.read<AccountCardsSummaryCubit>();
      final accountState = accountCubit.state;

      if (accountState is! AccountCardsSummaryLoaded || accountState.accountSummaries.isEmpty) {
        throw Exception('No account available for payment');
      }

      final defaultAccount = accountState.accountSummaries.first;

      await context.read<TagPayCubit>().payTag(
        tagId: widget.tag.id,
        sourceAccountId: defaultAccount.id.toString(),
      );

      Get.back(result: true);
      // Success handled by cubit listener

    } catch (e) {
      setState(() => _isProcessing = false);
      LVSnackbar.showError(
        title: 'Payment Failed',
        message: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
