import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import '../cubit/customer_cubit.dart';
import '../cubit/customer_state.dart';

class EditCustomerScreen extends StatefulWidget {
  final CustomerEntity customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _businessNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _countryController;
  late final TextEditingController _tinController;
  late final TextEditingController _bankAccountNumberController;
  late final TextEditingController _bankCodeController;
  late final TextEditingController _bankNameController;
  late final TextEditingController _tagsController;
  late final TextEditingController _notesController;

  late String _selectedSegment;
  late String _selectedStatus;

  static const _segments = ['None', 'VIP', 'Retail', 'Wholesale', 'Government'];
  static const _statuses = ['Active', 'Inactive', 'Blocked'];

  @override
  void initState() {
    super.initState();
    final c = widget.customer;
    _nameController = TextEditingController(text: c.name);
    _businessNameController = TextEditingController(text: c.businessName);
    _emailController = TextEditingController(text: c.email);
    _phoneController = TextEditingController(text: c.phone);
    _addressController = TextEditingController(text: c.address);
    _cityController = TextEditingController(text: c.city);
    _stateController = TextEditingController(text: c.state);
    _countryController = TextEditingController(text: c.country);
    _tinController = TextEditingController(text: c.tin);
    _bankAccountNumberController =
        TextEditingController(text: c.bankAccountNumber);
    _bankCodeController = TextEditingController(text: c.bankCode);
    _bankNameController = TextEditingController(text: c.bankName);
    _tagsController = TextEditingController(text: c.tags.join(', '));
    _notesController = TextEditingController(text: c.notes);
    _selectedSegment = _segmentToString(c.segment);
    _selectedStatus = _statusToString(c.status);
  }

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

  String _segmentToString(CustomerSegment segment) {
    switch (segment) {
      case CustomerSegment.vip:
        return 'VIP';
      case CustomerSegment.retail:
        return 'Retail';
      case CustomerSegment.wholesale:
        return 'Wholesale';
      case CustomerSegment.government:
        return 'Government';
      default:
        return 'None';
    }
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

  String _statusToString(CustomerStatus status) {
    switch (status) {
      case CustomerStatus.active:
        return 'Active';
      case CustomerStatus.inactive:
        return 'Inactive';
      case CustomerStatus.blocked:
        return 'Blocked';
    }
  }

  int _statusToInt(String status) {
    switch (status) {
      case 'Active':
        return 0;
      case 'Inactive':
        return 1;
      case 'Blocked':
        return 2;
      default:
        return 0;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFF10B981);
      case 'Inactive':
        return const Color(0xFF9CA3AF);
      case 'Blocked':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
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

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    context.read<CustomerCubit>().updateCustomer(
          customerId: widget.customer.id,
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
          status: _statusToInt(_selectedStatus),
          tags: _parseTags(_tagsController.text),
          notes: _notesController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is CustomerUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Customer updated successfully',
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
              'Edit Customer',
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

                          // --- Status ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Status'),
                          SizedBox(height: 12.h),
                          Row(
                            children: _statuses.map((statusLabel) {
                              final isSelected = statusLabel == _selectedStatus;
                              final color = _statusColor(statusLabel);

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(
                                      () => _selectedStatus = statusLabel),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right:
                                          statusLabel != 'Blocked' ? 8.w : 0,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? color.withValues(alpha: 0.15)
                                          : const Color(0xFF1F1F1F),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? color
                                            : const Color(0xFF2D2D2D),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        statusLabel,
                                        style: GoogleFonts.inter(
                                          color: isSelected
                                              ? color
                                              : const Color(0xFF9CA3AF),
                                          fontSize: 13.sp,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
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
          onPressed: isLoading ? null : _saveChanges,
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
                  'Save Changes',
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
