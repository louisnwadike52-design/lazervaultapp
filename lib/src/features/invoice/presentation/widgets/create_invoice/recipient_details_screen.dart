import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/create_invoice_cubit.dart';

/// Screen 2: Recipient Details
///
/// Collects recipient address and contact information
class RecipientDetailsScreen extends StatefulWidget {
  final bool showPhone;
  final bool showAddress;

  const RecipientDetailsScreen({
    super.key,
    this.showPhone = false,
    this.showAddress = false,
  });

  @override
  State<RecipientDetailsScreen> createState() => _RecipientDetailsScreenState();
}

class _RecipientDetailsScreenState extends State<RecipientDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
    _companyController = TextEditingController(text: cubit.recipientCompany);
    _contactController = TextEditingController(text: cubit.recipientContact);
    _emailController = TextEditingController(text: cubit.recipientEmail);
    _phoneController = TextEditingController(text: cubit.recipientPhone);
    _address1Controller = TextEditingController(text: cubit.recipientAddress1);
    _address2Controller = TextEditingController(text: cubit.recipientAddress2);
    _cityController = TextEditingController(text: cubit.recipientCity);
    _stateController = TextEditingController(text: cubit.recipientState);
    _postcodeController = TextEditingController(text: cubit.recipientPostcode);
    _countryController = TextEditingController(text: cubit.recipientCountry);
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
          'Recipient Details',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Your business or personal information as the invoice creator',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
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
          hint: 'e.g., Acme Corporation',
          icon: Icons.business,
          onChanged: (value) => cubit.updateRecipientCompany(value),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _contactController,
          label: 'Contact Person *',
          hint: 'Full name',
          icon: Icons.person,
          onChanged: (value) => cubit.updateRecipientContact(value),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _emailController,
          label: 'Email Address *',
          hint: 'contact@example.com',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => cubit.updateRecipientEmail(value),
        ),
        if (widget.showPhone) ...[
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number (Optional)',
            hint: '+1 234 567 8900',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            onChanged: (value) => cubit.updateRecipientPhone(value),
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
            hint: '123 Main Street',
            icon: Icons.location_on,
            onChanged: (value) => cubit.updateRecipientAddress1(value),
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _address2Controller,
            label: 'Address Line 2',
            hint: 'Apt, Suite, Floor (optional)',
            icon: Icons.location_city,
            onChanged: (value) => cubit.updateRecipientAddress2(value),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'New York',
                  icon: Icons.location_city,
                  onChanged: (value) => cubit.updateRecipientCity(value),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTextField(
                  controller: _stateController,
                  label: 'State/Province',
                  hint: 'NY',
                  icon: Icons.map,
                  onChanged: (value) => cubit.updateRecipientState(value),
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
                  hint: '10001',
                  icon: Icons.pin_drop,
                  onChanged: (value) => cubit.updateRecipientPostcode(value),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  hint: 'USA',
                  icon: Icons.public,
                  onChanged: (value) => cubit.updateRecipientCountry(value),
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
