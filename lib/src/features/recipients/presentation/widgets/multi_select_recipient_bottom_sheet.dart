import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class MultiSelectRecipientBottomSheet extends StatefulWidget {
  final List<dynamic> alreadySelectedIds;
  final Function(List<RecipientModel>) onRecipientsSelected;

  const MultiSelectRecipientBottomSheet({
    super.key,
    required this.alreadySelectedIds,
    required this.onRecipientsSelected,
  });

  @override
  State<MultiSelectRecipientBottomSheet> createState() => _MultiSelectRecipientBottomSheetState();
}

class _MultiSelectRecipientBottomSheetState extends State<MultiSelectRecipientBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    // Initialize with already selected IDs
    _selectedIds.addAll(widget.alreadySelectedIds.map((id) => id.toString()));

    // Load recipients if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipientCubit = context.read<RecipientCubit>();
      final authState = context.read<AuthenticationCubit>().state;

      if (recipientCubit.state is! RecipientLoaded && authState is AuthenticationSuccess) {
        final localeManager = serviceLocator<LocaleManager>();
        recipientCubit.getRecipients(
          accessToken: authState.profile.session.accessToken,
          countryCode: localeManager.currentCountry,
          currency: localeManager.currentCurrency,
        );
      }
    });
  }

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

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _onDone(List<RecipientModel> allRecipients) {
    final selectedRecipients = allRecipients.where((recipient) {
      return _selectedIds.contains(recipient.id.toString()) &&
             !widget.alreadySelectedIds.contains(recipient.id);
    }).toList();

    widget.onRecipientsSelected(selectedRecipients);
    Get.back();
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Recipients',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (_selectedIds.isNotEmpty)
                            Text(
                              '${_selectedIds.length} selected',
                              style: GoogleFonts.inter(
                                color: Colors.blue[400],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
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
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
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
              child: BlocBuilder<RecipientCubit, RecipientState>(
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

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: filteredRecipients.length,
                            itemBuilder: (context, index) {
                              final recipient = filteredRecipients[index];
                              final isAlreadyAdded = widget.alreadySelectedIds.contains(recipient.id);
                              final isSelected = _selectedIds.contains(recipient.id.toString());

                              return _buildRecipientItem(
                                recipient,
                                isSelected,
                                isAlreadyAdded,
                              );
                            },
                          ),
                        ),

                        // Done button
                        if (_selectedIds.isNotEmpty)
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A3E),
                              border: Border(
                                top: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _onDone(state.recipients),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  'Add ${_selectedIds.where((id) => !widget.alreadySelectedIds.contains(id)).length} Recipients',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
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
                                final localeManager = serviceLocator<LocaleManager>();
                                context.read<RecipientCubit>().getRecipients(
                                  accessToken: authState.profile.session.accessToken,
                                  countryCode: localeManager.currentCountry,
                                  currency: localeManager.currentCurrency,
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

  Widget _buildRecipientItem(RecipientModel recipient, bool isSelected, bool isAlreadyAdded) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blue[600]!.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected
            ? Border.all(color: Colors.blue[400]!, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        enabled: !isAlreadyAdded,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        leading: Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isAlreadyAdded
                  ? [Colors.grey[600]!, Colors.grey[500]!]
                  : [Colors.blue[600]!, Colors.blue[400]!],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isAlreadyAdded
                ? Icon(Icons.check, color: Colors.white, size: 24.sp)
                : Text(
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
            color: isAlreadyAdded ? Colors.grey[500] : Colors.white,
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
            if (isAlreadyAdded)
              Text(
                'Already added',
                style: GoogleFonts.inter(
                  color: Colors.grey[500],
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        trailing: isAlreadyAdded
            ? null
            : Checkbox(
                value: isSelected,
                onChanged: (_) => _toggleSelection(recipient.id.toString()),
                activeColor: Colors.blue[600],
                checkColor: Colors.white,
              ),
        onTap: isAlreadyAdded ? null : () => _toggleSelection(recipient.id.toString()),
      ),
    );
  }
}
