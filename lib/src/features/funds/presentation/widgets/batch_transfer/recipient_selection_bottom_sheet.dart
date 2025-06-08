import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class RecipientSelectionBottomSheet extends StatefulWidget {
  final Function(RecipientModel) onRecipientSelected;

  const RecipientSelectionBottomSheet({
    super.key,
    required this.onRecipientSelected,
  });

  @override
  State<RecipientSelectionBottomSheet> createState() => _RecipientSelectionBottomSheetState();
}

class _RecipientSelectionBottomSheetState extends State<RecipientSelectionBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RecipientModel> _filterRecipients(List<RecipientModel> recipients) {
    if (_searchQuery.isEmpty) return recipients;
    
    return recipients.where((recipient) {
      return recipient.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             recipient.accountNumber.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            
            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Recipient',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(AppRoutes.addRecipient);
                        },
                        icon: Icon(Icons.add, color: Colors.blue[400], size: 20.sp),
                        label: Text(
                          'Add New',
                          style: GoogleFonts.inter(
                            color: Colors.blue[400],
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.inter(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search recipients...',
                        hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Recipients list
            Expanded(
              child: BlocConsumer<RecipientCubit, RecipientState>(
                listener: (context, state) {
                  if (state is RecipientSuccess) {
                    // Handle success state if needed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RecipientLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (state is RecipientLoaded) {
                    final filteredRecipients = _filterRecipients(state.recipients);
                    
                    if (filteredRecipients.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isNotEmpty ? Icons.search_off : Icons.people_outline,
                              size: 64.sp,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              _searchQuery.isNotEmpty 
                                ? 'No recipients found matching "$_searchQuery"'
                                : 'No recipients found',
                              style: GoogleFonts.inter(
                                color: Colors.grey[400],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            if (_searchQuery.isEmpty) ...[
                              SizedBox(height: 8.h),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.addRecipient);
                                },
                                child: Text(
                                  'Add your first recipient',
                                  style: GoogleFonts.inter(
                                    color: Colors.blue[400],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }
                    
                    return ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: filteredRecipients.length,
                      itemBuilder: (context, index) {
                        final recipient = filteredRecipients[index];
                        return _buildRecipientItem(recipient);
                      },
                    );
                  } else if (state is RecipientError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.sp,
                            color: Colors.red[400],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Error loading recipients',
                            style: GoogleFonts.inter(
                              color: Colors.red[400],
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton(
                            onPressed: () {
                              final authState = context.read<AuthenticationCubit>().state;
                              if (authState is AuthenticationSuccess) {
                                context.read<RecipientCubit>().getRecipients(
                                  accessToken: authState.profile.session.accessToken,
                                );
                              }
                            },
                            child: Text(
                              'Retry',
                              style: GoogleFonts.inter(
                                color: Colors.blue[400],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildRecipientItem(RecipientModel recipient) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        leading: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[600]!, Colors.blue[400]!],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              recipient.name.isNotEmpty ? recipient.name.substring(0, 1).toUpperCase() : 'R',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        title: Text(
          recipient.name,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipient.accountNumber.length > 4
                ? '••• ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}'
                : recipient.accountNumber,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
            if (recipient.bankName.isNotEmpty)
              Text(
                recipient.bankName,
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (recipient.isFavorite)
              Icon(Icons.favorite, color: Colors.red[400], size: 20.sp),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey[400],
              size: 24.sp,
            ),
          ],
        ),
        onTap: () {
          widget.onRecipientSelected(recipient);
          Get.back();
        },
      ),
    );
  }
} 