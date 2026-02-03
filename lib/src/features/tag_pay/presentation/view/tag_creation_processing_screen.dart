import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/user_tag_entity.dart';

class TagCreationProcessingScreen extends StatefulWidget {
  const TagCreationProcessingScreen({super.key});

  @override
  State<TagCreationProcessingScreen> createState() => _TagCreationProcessingScreenState();
}

class _TagCreationProcessingScreenState extends State<TagCreationProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  late final Map<String, dynamic> _args;
  late final String _recipientName;
  late final String _recipientTag;
  late final List<String> _recipientNames;
  late final List<String> _recipientTags;
  late final double _amount;
  late final String _currency;
  late final String _description;
  late final bool _isBatch;

  @override
  void initState() {
    super.initState();

    _args = Get.arguments as Map<String, dynamic>;
    _recipientName = _args['recipientName'] as String;
    _recipientTag = _args['recipientTag'] as String;
    _recipientNames = (_args['recipientNames'] as List<String>?) ?? [_recipientName];
    _recipientTags = (_args['recipientTags'] as List<String>?) ?? [_recipientTag];
    _amount = _args['amount'] as double;
    _currency = _args['currency'] as String;
    _description = (_args['description'] as String?) ?? '';
    _isBatch = _args['isBatch'] as bool? ?? false;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);

    // Dispatch the create call on THIS screen's cubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dispatchCreateTag();
    });
  }

  void _dispatchCreateTag() {
    final cubit = context.read<TagPayCubit>();
    if (_isBatch) {
      cubit.batchCreateTags(
        taggedUserTagPays: _recipientTags,
        amount: _amount,
        currency: _currency,
        description: _description,
      );
    } else {
      cubit.createTag(
        taggedUserTagPay: _recipientTags.first,
        amount: _amount,
        currency: _currency,
        description: _description,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = _recipientNames.length;

    return BlocListener<TagPayCubit, TagPayState>(
      listener: (context, state) {
        if (state is TagCreatedSuccess) {
          Get.offNamed(
            AppRoutes.tagCreationReceipt,
            arguments: {
              'tag': state.tag,
              'tags': [state.tag],
              'recipientName': _recipientName,
              'recipientTag': _recipientTag,
              'recipientNames': _recipientNames,
              'recipientTags': _recipientTags,
              'amount': _amount,
              'currency': _currency,
              'description': _description,
            },
          );
        } else if (state is BatchTagsCreatedSuccess) {
          Get.offNamed(
            AppRoutes.tagCreationReceipt,
            arguments: {
              'tag': state.tags.first,
              'tags': state.tags,
              'recipientName': _recipientNames.first,
              'recipientTag': _recipientTags.first,
              'recipientNames': _recipientNames,
              'recipientTags': _recipientTags,
              'amount': _amount,
              'currency': _currency,
              'description': _description,
            },
          );
        } else if (state is TagPayError) {
          Get.back();
          Get.snackbar(
            'Tag Creation Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _buildProcessingAnimation(),
                SizedBox(height: 32.h),
                Text(
                  _isBatch ? 'Creating $count Tags' : 'Creating Tag',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  _isBatch
                      ? 'Please wait while we create your tags'
                      : 'Please wait while we create your tag',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32.h),
                _buildTagDetails(),
                const Spacer(),
                _buildLoadingIndicator(),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.sell,
                  color: const Color(0xFF3B82F6),
                  size: 60.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTagDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (_isBatch)
            _buildDetailRow('Total', '${UserTagEntity.currencySymbol(_currency)}${(_amount * _recipientNames.length).toStringAsFixed(2)}')
          else
            _buildDetailRow('Amount', '${UserTagEntity.currencySymbol(_currency)}${_amount.toStringAsFixed(2)}'),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          if (_isBatch) ...[
            _buildDetailRow('Users', '${_recipientNames.length} recipients'),
            SizedBox(height: 12.h),
            _buildDetailRow('Each', '${UserTagEntity.currencySymbol(_currency)}${_amount.toStringAsFixed(2)}'),
          ] else ...[
            _buildDetailRow('For', _recipientNames.first),
            SizedBox(height: 12.h),
            _buildDetailRow('Tag', '@${_recipientTags.first}'),
          ],
          if (_description.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Note', _description),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
        strokeWidth: 3,
      ),
    );
  }
}
