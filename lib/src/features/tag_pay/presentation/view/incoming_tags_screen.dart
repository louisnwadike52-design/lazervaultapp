import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
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

                  if (state is MyIncomingTagsLoaded) {
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
    return Container(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => _showPaymentDialog(tag),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flash_on,
                          size: 18.sp,
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

  void _showPaymentDialog(UserTagEntity tag) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AccountSelectionBottomSheet(
        tag: tag,
        onAccountSelected: (accountId) {
          Navigator.pop(context);
          _processPayment(tag, accountId);
        },
      ),
    );
  }

  void _processPayment(UserTagEntity tag, String accountId) {
    print('💳 [IncomingTagsScreen] Navigating to processing screen for tag ${tag.id} from account $accountId');
    // Navigate to processing screen - it will trigger the payment in its initState
    Get.toNamed(
      AppRoutes.tagPayProcessing,
      arguments: {
        'tag': tag,
        'accountId': accountId,
      },
    );
  }
}

class _AccountSelectionBottomSheet extends StatefulWidget {
  final UserTagEntity tag;
  final Function(String) onAccountSelected;

  const _AccountSelectionBottomSheet({
    required this.tag,
    required this.onAccountSelected,
  });

  @override
  State<_AccountSelectionBottomSheet> createState() => _AccountSelectionBottomSheetState();
}

class _AccountSelectionBottomSheetState extends State<_AccountSelectionBottomSheet> {
  String? _selectedAccountId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Select Account',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose an account to pay ${widget.tag.currency} ${widget.tag.amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
            builder: (context, state) {
              if (state is AccountCardsSummaryLoading) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.h),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                );
              }

              if (state is AccountCardsSummaryLoaded) {
                if (state.accountSummaries.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(32.h),
                    child: Text(
                      'No accounts available',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.accountSummaries.length,
                  itemBuilder: (context, index) {
                    final account = state.accountSummaries[index];
                    final hasEnoughBalance = account.balance >= widget.tag.amount;
                    final isSelected = _selectedAccountId == account.id;

                    return GestureDetector(
                      onTap: hasEnoughBalance
                          ? () {
                              setState(() {
                                _selectedAccountId = account.id;
                              });
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: hasEnoughBalance
                              ? (isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.15) : const Color(0xFF2D2D2D))
                              : const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: hasEnoughBalance
                                ? (isSelected ? const Color(0xFF3B82F6) : const Color(0xFF3B82F6).withValues(alpha: 0.3))
                                : const Color(0xFF374151),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: hasEnoughBalance
                                    ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                                    : const Color(0xFF374151).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Icon(
                                Icons.account_balance_wallet,
                                color: hasEnoughBalance
                                    ? const Color(0xFF3B82F6)
                                    : const Color(0xFF6B7280),
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    account.accountType.toUpperCase(),
                                    style: GoogleFonts.inter(
                                      color: hasEnoughBalance
                                          ? Colors.white
                                          : const Color(0xFF6B7280),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${account.currency} ${account.balance.toStringAsFixed(2)}',
                                    style: GoogleFonts.inter(
                                      color: hasEnoughBalance
                                          ? const Color(0xFF9CA3AF)
                                          : const Color(0xFF6B7280),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (hasEnoughBalance)
                              Container(
                                width: 24.w,
                                height: 24.w,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF3B82F6)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF3B82F6),
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16.sp,
                                      )
                                    : null,
                              )
                            else
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  'Insufficient',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFEF4444),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: _selectedAccountId != null
                  ? const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: _selectedAccountId == null ? const Color(0xFF374151) : null,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: _selectedAccountId != null
                  ? [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ElevatedButton(
              onPressed: _selectedAccountId != null
                  ? () {
                      widget.onAccountSelected(_selectedAccountId!);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                disabledBackgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: _selectedAccountId != null ? Colors.white : const Color(0xFF6B7280),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
