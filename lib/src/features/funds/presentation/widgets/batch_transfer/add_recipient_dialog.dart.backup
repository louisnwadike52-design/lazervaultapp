import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/utilities/uk_banks_data.dart';
import 'package:lazervault/core/utilities/sort_code_formatter.dart';

class AddRecipientDialog extends StatefulWidget {
  final Function(RecipientModel)? onRecipientAdded;

  const AddRecipientDialog({
    super.key,
    this.onRecipientAdded,
  });

  @override
  State<AddRecipientDialog> createState() => _AddRecipientDialogState();
}

class _AddRecipientDialogState extends State<AddRecipientDialog> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _sortCodeController = TextEditingController();
  final _bankSearchController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isFavorite = false;
  bool _isLoading = false;
  String? _selectedBank;
  List<String> _filteredBanks = UKBanksData.ukBanks;
  bool _showBankDropdown = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _accountNumberController.dispose();
    _sortCodeController.dispose();
    _bankSearchController.dispose();
    super.dispose();
  }

  void _filterBanks(String query) {
    setState(() {
      _filteredBanks = UKBanksData.searchBanks(query);
    });
  }

  void _handleAddRecipient() async {
    if (!_formKey.currentState!.validate()) return;

    // Validate bank selection
    if (_selectedBank == null || _selectedBank!.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a bank',
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(
        'Error',
        'Please log in to continue',
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
      );
      return;
    }

    // Get digits-only sort code for storage
    final sortCodeDigits = SortCodeInputFormatter.getDigitsOnly(_sortCodeController.text);

    final newRecipient = RecipientModel(
      id: '0', // Will be assigned by backend
      name: _nameController.text.trim(),
      accountNumber: _accountNumberController.text.trim(),
      bankName: _selectedBank!,
      sortCode: sortCodeDigits,
      isFavorite: _isFavorite,
    );

    await context.read<RecipientCubit>().addRecipient(
      recipient: newRecipient,
      accessToken: authState.profile.session.accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipientCubit, RecipientState>(
      listener: (context, state) {
        if (state is RecipientSuccess && state.recipient != null) {
          setState(() {
            _isLoading = false;
          });

          Get.snackbar(
            'Success',
            'Recipient added successfully',
            backgroundColor: Colors.green[600],
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );

          // Call the callback with the new recipient
          if (widget.onRecipientAdded != null) {
            widget.onRecipientAdded!(state.recipient!);
          }

          // Close the dialog
          Navigator.of(context).pop(state.recipient);
        } else if (state is RecipientError) {
          setState(() {
            _isLoading = false;
          });

          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: Colors.red[600],
            colorText: Colors.white,
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              constraints: BoxConstraints(maxHeight: 650.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1A1A3E),
                    const Color(0xFF0F0F23),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTextField(
                              controller: _nameController,
                              label: 'Recipient Name',
                              hint: 'e.g., John Doe',
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter recipient name';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            _buildTextField(
                              controller: _accountNumberController,
                              label: 'Account Number',
                              hint: 'e.g., 12345678',
                              icon: Icons.account_balance,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter account number';
                                }
                                if (value.trim().length < 8) {
                                  return 'Account number must be at least 8 digits';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            _buildTextField(
                              controller: _sortCodeController,
                              label: 'Sort Code',
                              hint: 'XX-XX-XX',
                              icon: Icons.numbers,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                SortCodeInputFormatter(),
                              ],
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter sort code';
                                }
                                if (!SortCodeInputFormatter.isValidSortCode(value)) {
                                  return 'Sort code must be 6 digits (XX-XX-XX)';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            _buildBankDropdown(),

                            SizedBox(height: 20.h),

                            // Favorite toggle
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.06),
                                    Colors.white.withValues(alpha: 0.03),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.red[600]!, Colors.red[500]!],
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      'Add to favorites',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                    value: _isFavorite,
                                    onChanged: (value) {
                                      setState(() {
                                        _isFavorite = value;
                                      });
                                    },
                                    activeTrackColor: Colors.red[500],
                                    activeColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[600]!.withValues(alpha: 0.2),
            Colors.blue[400]!.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[500]!],
              ),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[600]!.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Recipient',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Save recipient details for future transfers',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
              prefixIcon: Container(
                margin: EdgeInsets.all(12.w),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[600]!, Colors.blue[500]!],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: Colors.white, size: 18.sp),
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.08),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.red[400]!, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Name',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Bank selection button/field
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showBankDropdown = !_showBankDropdown;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12.w),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[600]!, Colors.blue[500]!],
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(Icons.business, color: Colors.white, size: 18.sp),
                      ),
                      Expanded(
                        child: Text(
                          _selectedBank ?? 'Select a bank',
                          style: GoogleFonts.inter(
                            color: _selectedBank != null ? Colors.white : Colors.grey[600],
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      Icon(
                        _showBankDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ],
                  ),
                ),
              ),

              // Dropdown list
              if (_showBankDropdown) ...[
                SizedBox(height: 8.h),
                Container(
                  constraints: BoxConstraints(maxHeight: 250.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F0F23),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Search field
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: TextField(
                          controller: _bankSearchController,
                          onChanged: _filterBanks,
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Search banks...',
                            hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
                            prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.08),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          ),
                        ),
                      ),

                      // Banks list
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredBanks.length,
                          itemBuilder: (context, index) {
                            final bank = _filteredBanks[index];
                            final isSelected = bank == _selectedBank;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedBank = bank;
                                  _showBankDropdown = false;
                                  _bankSearchController.clear();
                                  _filteredBanks = UKBanksData.ukBanks;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue[600]!.withValues(alpha: 0.3)
                                      : Colors.transparent,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        bank,
                                        style: GoogleFonts.inter(
                                          color: isSelected ? Colors.white : Colors.grey[300],
                                          fontSize: 14.sp,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.blue[400],
                                        size: 20.sp,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF0F0F23).withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[600]!, Colors.blue[500]!],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[600]!.withValues(alpha: 0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleAddRecipient,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: _isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Add Recipient',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
