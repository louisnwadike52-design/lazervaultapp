import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_search_result_entity.dart';
import '../../../../../core/services/injection_container.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';

class CreateTagScreenRedesigned extends StatefulWidget {
  const CreateTagScreenRedesigned({super.key});

  @override
  State<CreateTagScreenRedesigned> createState() => _CreateTagScreenRedesignedState();
}

class _CreateTagScreenRedesignedState extends State<CreateTagScreenRedesigned> {
  final _searchController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  UserSearchResultEntity? _selectedUser;
  String _currency = 'ZAR';
  List<UserSearchResultEntity> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Clear all state when screen loads to avoid caching
    _selectedUser = null;
    _searchResults = [];
    _isSearching = false;
    _searchController.clear();
    _amountController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await context.read<TagPayCubit>().searchUsers(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      Get.snackbar(
        'Search Error',
        e.toString(),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    }
  }

  void _createTag() {
    print('🔵 _createTag called');
    print('Selected user: $_selectedUser');
    print('Amount controller text: ${_amountController.text}');

    if (_selectedUser == null) {
      print('⚠️ No user selected');
      Get.snackbar(
        'No User Selected',
        'Please select a user to tag',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final amount = double.tryParse(_amountController.text);
    print('Parsed amount: $amount');

    if (amount == null || amount <= 0) {
      print('⚠️ Invalid amount');
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    print('✅ Creating tag for user: ${_selectedUser!.username}, amount: $amount');

    // Navigate to processing screen
    Get.toNamed(
      AppRoutes.tagCreationProcessing,
      arguments: {
        'recipientName': _selectedUser!.fullName,
        'recipientTag': _selectedUser!.username,
        'amount': amount,
        'currency': _currency,
        'description': _descriptionController.text.trim(),
      },
    );

    // Trigger tag creation after navigation
    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<TagPayCubit>().createTag(
            taggedUserTagPay: _selectedUser!.username,
            amount: amount,
            currency: _currency,
            description: _descriptionController.text.trim(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocBuilder<TagPayCubit, TagPayState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 32.h),
                if (_selectedUser == null) ...[
                  _buildUserSearch(),
                  if (_searchResults.isNotEmpty || _isSearching)
                    _buildSearchResults(),
                ] else ...[
                  _buildSelectedUser(),
                  SizedBox(height: 24.h),
                  _buildAmountInput(),
                  SizedBox(height: 24.h),
                  _buildDescriptionInput(),
                  SizedBox(height: 32.h),
                  _buildCreateButton(),
                ],
              ],
            ),
          ),
        );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
                'Tag a User',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Create payment tag to pay later',
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

  Widget _buildUserSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search User',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: _searchController,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintText: 'Search by @username or name',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              suffixIcon: _isSearching
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF3B82F6)),
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _searchUsers(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return Container(
        margin: EdgeInsets.only(top: 16.h),
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(const Color(0xFF3B82F6)),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      constraints: BoxConstraints(maxHeight: 300.h),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final user = _searchResults[index];
          return ListTile(
            onTap: () {
              setState(() {
                _selectedUser = user;
                _searchController.clear();
                _searchResults = [];
              });
            },
            leading: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.person,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
            ),
            title: Text(
              user.fullName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              '@${user.username}',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF9CA3AF),
              size: 16.sp,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedUser() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF3B82F6), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.2),
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Icon(
              Icons.person,
              color: const Color(0xFF3B82F6),
              size: 28.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedUser!.fullName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '@${_selectedUser!.username}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedUser = null;
              });
            },
            icon: Icon(
              Icons.close,
              color: const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        // Quick Amount Buttons
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [50.0, 100.0, 200.0, 500.0].map((amount) =>
            GestureDetector(
              onTap: () {
                setState(() {
                  _amountController.text = amount.toStringAsFixed(0);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: _amountController.text == amount.toStringAsFixed(0)
                    ? const Color(0xFF4E03D0).withOpacity(0.2)
                    : const Color(0xFF1F1F1F),
                  border: Border.all(
                    color: _amountController.text == amount.toStringAsFixed(0)
                      ? const Color(0xFF4E03D0)
                      : const Color(0xFF2D2D2D),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '$_currency ${amount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    color: _amountController.text == amount.toStringAsFixed(0)
                      ? const Color(0xFF4E03D0)
                      : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ).toList(),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text(
                _currency,
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description (Optional)',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: 3,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintText: 'What is this tag for?',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        final isLoading = state is TagPayLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _createTag,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              disabledBackgroundColor: const Color(0xFF3B82F6).withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Create Payment Tag',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
