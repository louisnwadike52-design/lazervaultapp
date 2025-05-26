import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/types/app_routes.dart';

class SellToContactScreen extends StatefulWidget {
  const SellToContactScreen({super.key});

  @override
  State<SellToContactScreen> createState() => _SellToContactScreenState();
}

class _SellToContactScreenState extends State<SellToContactScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGiftCard = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildGiftCardSelector(),
              Expanded(
                child: _buildContactsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Sell to Contact',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextField(
          controller: _searchController,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: 'Search contacts...',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey[400],
              size: 24.sp,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGiftCardSelector() {
    // TODO: Replace with actual gift cards from cubit
    final List<Map<String, dynamic>> mockGiftCards = [
      {
        'brand': 'Amazon',
        'logo': 'https://example.com/amazon.png',
        'amount': 100.00,
      },
      {
        'brand': 'Netflix',
        'logo': 'https://example.com/netflix.png',
        'amount': 29.99,
      },
    ];

    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: mockGiftCards.length,
        itemBuilder: (context, index) {
          final card = mockGiftCards[index];
          return _buildGiftCardOption(card);
        },
      ),
    );
  }

  Widget _buildGiftCardOption(Map<String, dynamic> card) {
    final isSelected = _selectedGiftCard == card['brand'];
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[900],
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => setState(() => _selectedGiftCard = card['brand']),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CachedNetworkImage(
                      imageUrl: card['logo'],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_rounded,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.card_giftcard_rounded,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  card['brand'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${card['amount'].toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactsList() {
    // TODO: Replace with actual contacts from cubit
    final List<Map<String, dynamic>> mockContacts = [
      {
        'name': 'John Doe',
        'avatar': 'https://example.com/avatar1.png',
        'phone': '+1 234 567 8900',
      },
      {
        'name': 'Jane Smith',
        'avatar': 'https://example.com/avatar2.png',
        'phone': '+1 234 567 8901',
      },
      // Add more mock data as needed
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: mockContacts.length,
      itemBuilder: (context, index) {
        final contact = mockContacts[index];
        return _buildContactItem(contact);
      },
    );
  }

  Widget _buildContactItem(Map<String, dynamic> contact) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            if (_selectedGiftCard.isNotEmpty) {
              // TODO: Show confirmation dialog
              _showConfirmationDialog(contact);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select a gift card first'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.grey[800],
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: contact['avatar'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Icon(
                        Icons.person,
                        color: Colors.grey[400],
                        size: 24.sp,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        color: Colors.grey[400],
                        size: 24.sp,
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
                        contact['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        contact['phone'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey[400],
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(Map<String, dynamic> contact) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirm Sale',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Are you sure you want to sell your $_selectedGiftCard gift card to ${contact['name']}?',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Process the sale
                        Get.back();
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Gift card sale initiated'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 