import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../domain/entities/recipient_entity.dart';
import '../controllers/exchange_controller.dart';
import 'exchange_confirmation_screen.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/add_recipient.dart';

class ExchangeRecipientScreen extends StatefulWidget {
  const ExchangeRecipientScreen({super.key});

  @override
  State<ExchangeRecipientScreen> createState() => _ExchangeRecipientScreenState();
}

class _ExchangeRecipientScreenState extends State<ExchangeRecipientScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: GetX<ExchangeController>(
          builder: (controller) {
            return Column(
              children: [
                _buildHeader(controller),
                _buildSearchBar(),
                Expanded(
                  child: _buildRecipientList(controller),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(ExchangeController controller) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
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
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
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
                  'Select Recipient',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Sending ${controller.fromCurrency.value?.code} ${controller.amount.value.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search recipients...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientList(ExchangeController controller) {
    if (controller.isLoadingRecipients.value) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
        ),
      );
    }

    final recipients = controller.recipients.where((recipient) {
      if (_searchQuery.isEmpty) return true;
      return recipient.name.toLowerCase().contains(_searchQuery) ||
          recipient.accountNumber.toLowerCase().contains(_searchQuery) ||
          recipient.bankName.toLowerCase().contains(_searchQuery);
    }).toList();

    if (recipients.isEmpty && _searchQuery.isNotEmpty) {
      // Show empty state for search with no results
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _buildAddNewRecipient(),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    color: const Color(0xFF6B7280),
                    size: 64.sp,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No recipients found',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Try a different search term',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (recipients.isEmpty && controller.recipients.isEmpty) {
      // Show empty state when there are no recipients at all
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _buildAddNewRecipient(),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    color: const Color(0xFF6B7280),
                    size: 64.sp,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No recipients yet',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Add a recipient to get started',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: recipients.length + 1, // +1 for "Add New" button
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildAddNewRecipient();
        }

        final recipient = recipients[index - 1];
        return _buildRecipientItem(recipient, controller);
      },
    );
  }

  Widget _buildAddNewRecipient() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // Navigate to the Add Recipient screen
            Get.to(() => const AddRecipient());
          },
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: const Color(0xFF3B82F6),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    'Add New Recipient',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF3B82F6),
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientItem(Recipient recipient, ExchangeController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            controller.setSelectedRecipient(recipient);
            Get.to(() => const ExchangeConfirmationScreen());
          },
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1E3A8A),
                        Color(0xFF3B82F6),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      recipient.name.substring(0, 1).toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        recipient.bankName,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '****${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF9CA3AF),
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
