import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/customer_cubit.dart';
import '../cubit/customer_state.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _tinController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _tagsController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedSegment = 'None';

  static const _segments = ['None', 'VIP', 'Retail', 'Wholesale', 'Government'];

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _tinController.dispose();
    _bankAccountNumberController.dispose();
    _bankCodeController.dispose();
    _bankNameController.dispose();
    _tagsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  int _segmentToInt(String segment) {
    switch (segment) {
      case 'VIP':
        return 1;
      case 'Retail':
        return 2;
      case 'Wholesale':
        return 3;
      case 'Government':
        return 4;
      default:
        return 0;
    }
  }

  List<String> _parseTags(String input) {
    if (input.trim().isEmpty) return [];
    return input
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    context.read<CustomerCubit>().createCustomer(
          name: _nameController.text.trim(),
          businessName: _businessNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          country: _countryController.text.trim(),
          tin: _tinController.text.trim(),
          bankAccountNumber: _bankAccountNumberController.text.trim(),
          bankCode: _bankCodeController.text.trim(),
          bankName: _bankNameController.text.trim(),
          segment: _segmentToInt(_selectedSegment),
          tags: _parseTags(_tagsController.text),
          notes: _notesController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is CustomerCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Customer "${state.customer.name}" created successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is CustomerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CustomerLoading;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Add Customer',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- Basic Info ---
                          _buildSectionTitle('Basic Information'),
                          SizedBox(height: 16.h),
                          _buildTextField(
                            controller: _nameController,
                            label: 'Customer Name *',
                            hint: 'e.g. John Doe',
                            icon: Icons.person_outline,
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Name is required'
                                : null,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _businessNameController,
                            label: 'Business Name',
                            hint: 'e.g. Doe Enterprises Ltd',
                            icon: Icons.business_outlined,
                          ),

                          // --- Contact Info ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Contact Information'),
                          SizedBox(height: 16.h),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            hint: 'e.g. john@example.com',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Phone',
                            hint: 'e.g. +234 801 234 5678',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _addressController,
                            label: 'Address',
                            hint: 'Street address',
                            icon: Icons.location_on_outlined,
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _cityController,
                                  label: 'City',
                                  hint: 'e.g. Lagos',
                                  icon: Icons.location_city_outlined,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: _buildTextField(
                                  controller: _stateController,
                                  label: 'State',
                                  hint: 'e.g. Lagos',
                                  icon: Icons.map_outlined,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _countryController,
                            label: 'Country',
                            hint: 'e.g. Nigeria',
                            icon: Icons.flag_outlined,
                          ),

                          // --- Business Info ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Business Information'),
                          SizedBox(height: 16.h),
                          _buildTextField(
                            controller: _tinController,
                            label: 'TIN',
                            hint: 'Tax Identification Number',
                            icon: Icons.receipt_long_outlined,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _bankNameController,
                            label: 'Bank Name',
                            hint: 'e.g. First Bank',
                            icon: Icons.account_balance_outlined,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _bankAccountNumberController,
                            label: 'Bank Account Number',
                            hint: 'e.g. 0123456789',
                            icon: Icons.credit_card_outlined,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _bankCodeController,
                            label: 'Bank Code',
                            hint: 'e.g. 011',
                            icon: Icons.pin_outlined,
                            keyboardType: TextInputType.number,
                          ),

                          // --- Segment ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Classification'),
                          SizedBox(height: 16.h),
                          Text(
                            'Segment',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F1F1F),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedSegment,
                                isExpanded: true,
                                dropdownColor: const Color(0xFF1F1F1F),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: const Color(0xFF9CA3AF),
                                  size: 20.sp,
                                ),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                ),
                                items: _segments.map((seg) {
                                  return DropdownMenuItem(
                                    value: seg,
                                    child: Text(seg),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _selectedSegment = value);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _tagsController,
                            label: 'Tags',
                            hint: 'Comma-separated, e.g. priority, wholesale',
                            icon: Icons.label_outline,
                          ),

                          // --- Notes ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Additional'),
                          SizedBox(height: 16.h),
                          _buildTextField(
                            controller: _notesController,
                            label: 'Notes',
                            hint: 'Any additional notes about this customer',
                            icon: Icons.notes_outlined,
                            maxLines: 3,
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomActions(isLoading),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Widgets
  // ---------------------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 15.sp,
            ),
            prefixIcon:
                Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            disabledBackgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Add Customer',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
