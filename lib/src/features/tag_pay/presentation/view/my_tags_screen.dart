import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';

class MyTagsScreen extends StatefulWidget {
  const MyTagsScreen({super.key});

  @override
  State<MyTagsScreen> createState() => _MyTagsScreenState();
}

class _MyTagsScreenState extends State<MyTagsScreen> {
  final _pinController = TextEditingController();
  String? _selectedAccountId;

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  void _loadTags() {
    context.read<TagPayCubit>().getMyTags();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _showPayDialog(UserTagEntity tag) {
    // For now, use a default account ID - this should be fetched from user state in production
    _selectedAccountId = "default-account-id";

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Pay Tag',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pay ${tag.formattedAmount} to ${tag.taggerName}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 16.h),
            if (tag.description.isNotEmpty) ...[
              Text(
                'For: ${tag.description}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),
            ],
            Text(
              'Account: Default Account',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                labelText: 'Transaction PIN',
                labelStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                counterText: '',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _pinController.clear();
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_pinController.text.length != 4) {
                Get.snackbar(
                  'Invalid PIN',
                  'PIN must be 4 digits',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                );
                return;
              }
              if (_selectedAccountId == null) {
                Get.snackbar(
                  'No Account Selected',
                  'Please select an account',
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                );
                return;
              }

              Navigator.of(dialogContext).pop();
              context.read<TagPayCubit>().payTag(
                    tagId: tag.id,
                    sourceAccountId: _selectedAccountId!,
                  );
              _pinController.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
            child: Text(
              'Pay Now',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'My Tags',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadTags,
          ),
        ],
      ),
      body: BlocConsumer<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is TagPaidSuccess) {
            Get.snackbar(
              'Success',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
            );
            _loadTags(); // Reload tags after payment
          } else if (state is TagPayError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          if (state is TagPayLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
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
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sell_outlined,
            size: 80.sp,
            color: const Color(0xFF374151),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Tags Yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You have no pending tags to pay',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsList(List<UserTagEntity> tags) {
    return RefreshIndicator(
      onRefresh: () async => _loadTags(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          return _buildTagCard(tag);
        },
      ),
    );
  }

  Widget _buildTagCard(UserTagEntity tag) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.sell,
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
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '@${tag.taggerTagPay}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                tag.formattedAmount,
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
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
          SizedBox(height: 12.h),
          Text(
            'Tagged ${_formatDate(tag.createdAt)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showPayDialog(tag),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Pay Now',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
