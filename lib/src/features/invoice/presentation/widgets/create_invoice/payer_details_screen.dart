import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../cubit/create_invoice_cubit.dart';

/// Screen 3: Payer Details
///
/// Collects payer address, contact information, and optional logo/image
class PayerDetailsScreen extends StatefulWidget {
  final bool showPhone;
  final bool showAddress;

  const PayerDetailsScreen({
    super.key,
    this.showPhone = false,
    this.showAddress = false,
  });

  @override
  State<PayerDetailsScreen> createState() => _PayerDetailsScreenState();
}

class _PayerDetailsScreenState extends State<PayerDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final ImagePicker _imagePicker = ImagePicker();

  late TextEditingController _companyController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postcodeController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    // Initialize controllers with current cubit values
    final cubit = context.read<CreateInvoiceCubit>();
    _companyController = TextEditingController(text: cubit.payerCompany);
    _contactController = TextEditingController(text: cubit.payerContact);
    _emailController = TextEditingController(text: cubit.payerEmail);
    _phoneController = TextEditingController(text: cubit.payerPhone);
    _address1Controller = TextEditingController(text: cubit.payerAddress1);
    _address2Controller = TextEditingController(text: cubit.payerAddress2);
    _cityController = TextEditingController(text: cubit.payerCity);
    _stateController = TextEditingController(text: cubit.payerState);
    _postcodeController = TextEditingController(text: cubit.payerPostcode);
    _countryController = TextEditingController(text: cubit.payerCountry);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _companyController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      final cubit = context.read<CreateInvoiceCubit>();
      cubit.updatePayerImage(File(image.path));
    }
    } finally {
      _isPickingImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 32.h),
            _buildLogoSection(),
            SizedBox(height: 32.h),
            _buildFormFields(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payer Details',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Details of the person or company who will pay this invoice',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();
        final payerImage = cubit.payerImage;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logo/Image (Optional)',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 140.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: payerImage != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.file(
                              payerImage,
                              width: double.infinity,
                              height: 140.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: () => cubit.updatePayerImage(null),
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 48.sp,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Tap to add logo or image',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormFields() {
    final cubit = context.read<CreateInvoiceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _companyController,
          label: 'Company Name (Optional)',
          hint: 'Your Business Name',
          icon: Icons.business,
          onChanged: (value) => cubit.updatePayerCompany(value),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _contactController,
          label: 'Contact Person *',
          hint: 'Your full name',
          icon: Icons.person,
          onChanged: (value) => cubit.updatePayerContact(value),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _emailController,
          label: 'Email Address (Optional)',
          hint: 'your@email.com',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => cubit.updatePayerEmail(value),
        ),
        SizedBox(height: 6.h),
        Text(
          'If provided, an email with the invoice will be automatically sent to the payer',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[500],
          ),
        ),
        if (widget.showPhone) ...[
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number (Optional)',
            hint: '+1 234 567 8900',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            onChanged: (value) => cubit.updatePayerPhone(value),
          ),
        ],
        if (widget.showAddress) ...[
          SizedBox(height: 24.h),
          Text(
            'Address (Optional)',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _address1Controller,
            label: 'Street Address',
            hint: '456 Business Blvd',
            icon: Icons.location_on,
            onChanged: (value) => cubit.updatePayerAddress1(value),
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _address2Controller,
            label: 'Address Line 2',
            hint: 'Suite, Unit (optional)',
            icon: Icons.location_city,
            onChanged: (value) => cubit.updatePayerAddress2(value),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'San Francisco',
                  icon: Icons.location_city,
                  onChanged: (value) => cubit.updatePayerCity(value),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTextField(
                  controller: _stateController,
                  label: 'State/Province',
                  hint: 'CA',
                  icon: Icons.map,
                  onChanged: (value) => cubit.updatePayerState(value),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _postcodeController,
                  label: 'Postcode/ZIP',
                  hint: '94102',
                  icon: Icons.pin_drop,
                  onChanged: (value) => cubit.updatePayerPostcode(value),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  hint: 'USA',
                  icon: Icons.public,
                  onChanged: (value) => cubit.updatePayerCountry(value),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            prefixIcon: Icon(
              icon,
              size: 20.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }
}
