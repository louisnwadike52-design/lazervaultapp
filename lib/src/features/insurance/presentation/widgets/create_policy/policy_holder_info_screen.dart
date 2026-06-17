import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import '../../cubit/create_policy_cubit.dart';
import 'validation_status_icon.dart';
import '../../../../../core/utils/form_field_validators.dart';

/// Screen 2: Policy Holder Information
///
/// Auto-fills name, email, phone from user profile
/// Implements real-time validation for email and phone
class PolicyHolderInfoScreen extends StatefulWidget {
  const PolicyHolderInfoScreen({super.key});

  @override
  State<PolicyHolderInfoScreen> createState() => _PolicyHolderInfoScreenState();
}

class _PolicyHolderInfoScreenState extends State<PolicyHolderInfoScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  ValidationStatus _emailStatus = ValidationStatus.neutral;
  ValidationStatus _phoneStatus = ValidationStatus.neutral;
  CountryLocale _selectedCountry = CountryLocales.all.first; // Nigeria default

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current cubit values
    final cubit = context.read<CreatePolicyCubit>();
    _nameController = TextEditingController(text: cubit.policyHolderName);
    _emailController = TextEditingController(text: cubit.policyHolderEmail);

    // Strip country dial code from pre-filled phone to show local digits only
    final prefillPhone = cubit.policyHolderPhone;
    String localPhone = prefillPhone;
    if (prefillPhone.isNotEmpty) {
      final sortedCountries = List<CountryLocale>.from(CountryLocales.all)
        ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
      for (final c in sortedCountries) {
        if (prefillPhone.startsWith(c.dialCode)) {
          _selectedCountry = c;
          localPhone = prefillPhone.substring(c.dialCode.length);
          break;
        }
      }
    }
    _phoneController = TextEditingController(text: localPhone);

    // Set initial validation status if fields are pre-filled
    if (cubit.policyHolderEmail.isNotEmpty) {
      _emailStatus = FormFieldValidators.isValidEmailFormat(cubit.policyHolderEmail)
          ? ValidationStatus.valid
          : ValidationStatus.invalid;
    }
    if (localPhone.isNotEmpty) {
      final stripped = localPhone.startsWith('0') ? localPhone.substring(1) : localPhone;
      _phoneStatus = (stripped.length >= 7 && stripped.length <= 14)
          ? ValidationStatus.valid
          : ValidationStatus.invalid;
    }

    // Add listeners for real-time updates to cubit
    _nameController.addListener(() {
      context.read<CreatePolicyCubit>().updatePolicyHolderName(_nameController.text);
    });

    _emailController.addListener(() {
      _validateEmailRealTime(_emailController.text);
      context.read<CreatePolicyCubit>().updatePolicyHolderEmail(_emailController.text);
    });

    _phoneController.addListener(() {
      final local = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
      final stripped = local.startsWith('0') ? local.substring(1) : local;
      _validatePhoneRealTime(stripped);
      // Always send full E.164 phone to cubit
      final fullPhone = '${_selectedCountry.dialCode}$stripped';
      context.read<CreatePolicyCubit>().updatePolicyHolderPhone(fullPhone);
    });

    // Animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutBack,
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateEmailRealTime(String email) {
    setState(() {
      if (email.isEmpty) {
        _emailStatus = ValidationStatus.neutral;
      } else if (FormFieldValidators.isValidEmailFormat(email)) {
        _emailStatus = ValidationStatus.valid;
      } else {
        _emailStatus = ValidationStatus.invalid;
      }
    });
  }

  void _validatePhoneRealTime(String localDigits) {
    setState(() {
      if (localDigits.isEmpty) {
        _phoneStatus = ValidationStatus.neutral;
      } else if (localDigits.length >= 7 && localDigits.length <= 14) {
        _phoneStatus = ValidationStatus.valid;
      } else {
        _phoneStatus = ValidationStatus.invalid;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 32.h),
              _buildAutoFillBanner(),
              SizedBox(height: 24.h),
              _buildNameField(),
              SizedBox(height: 20.h),
              _buildEmailField(),
              SizedBox(height: 20.h),
              _buildPhoneField(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Policy Holder Information',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Your personal details for this insurance policy',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildAutoFillBanner() {
    final cubit = context.read<CreatePolicyCubit>();

    if (!cubit.isAutoFilled) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome,
            size: 20.sp,
            color: const Color(0xFF6366F1),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Fields auto-filled from your profile. You can edit them if needed.',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Full Name',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              ' *',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            if (context.read<CreatePolicyCubit>().isAutoFilled)
              _buildAutoFillBadge(),
          ],
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _nameController,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your full name',
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              size: 20.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF6366F1),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Email Address',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              ' *',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            if (context.read<CreatePolicyCubit>().isAutoFilled)
              _buildAutoFillBadge(),
          ],
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your email address',
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
            prefixIcon: Icon(
              Icons.email_outlined,
              size: 20.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: ValidationStatusIcon(status: _emailStatus),
            ),
            filled: true,
            fillColor: _emailStatus.getBackgroundTint() ??
                Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: _emailStatus.getBorderColor(
                  neutralColor: Colors.white.withValues(alpha: 0.1),
                ),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: _emailStatus.getBorderColor(
                  neutralColor: const Color(0xFF6366F1),
                ),
                width: 1.5,
              ),
            ),
          ),
        ),
        if (_emailStatus == ValidationStatus.invalid)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Text(
              'Please enter a valid email address',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  void _showCountryCodePicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final filtered = searchQuery.isEmpty
                ? CountryLocales.all
                : CountryLocales.search(searchQuery);
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.9,
              minChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                        width: 40.w, height: 4.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Select Country Code',
                              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        child: TextField(
                          onChanged: (v) => setSheetState(() => searchQuery = v),
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Search country...',
                            hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                            prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                            filled: true, fillColor: const Color(0xFF0A0A0A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final country = filtered[index];
                            final isSelected = country.countryCode == _selectedCountry.countryCode;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _selectedCountry = country);
                                // Re-trigger cubit update with new dial code
                                final local = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
                                final stripped = local.startsWith('0') ? local.substring(1) : local;
                                context.read<CreatePolicyCubit>().updatePolicyHolderPhone('${country.dialCode}$stripped');
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.1) : const Color(0xFF0A0A0A),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: isSelected ? Border.all(color: const Color(0xFF3B82F6), width: 1.5) : null,
                                ),
                                child: Row(
                                  children: [
                                    Text(country.flag, style: TextStyle(fontSize: 24.sp)),
                                    SizedBox(width: 12.w),
                                    Expanded(child: Text(country.countryName, style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500))),
                                    Text(country.dialCode, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                    if (isSelected) ...[SizedBox(width: 8.w), Icon(Icons.check_circle, color: const Color(0xFF3B82F6), size: 20.sp)],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Phone Number',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              ' *',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            if (context.read<CreatePolicyCubit>().isAutoFilled)
              _buildAutoFillBadge(),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: _phoneStatus.getBackgroundTint() ??
                Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _phoneStatus.getBorderColor(
                neutralColor: Colors.white.withValues(alpha: 0.1),
              ),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Country code selector
              GestureDetector(
                onTap: _showCountryCodePicker,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xFF2D2D2D), width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_selectedCountry.flag, style: TextStyle(fontSize: 20.sp)),
                      SizedBox(width: 6.w),
                      Text(
                        _selectedCountry.dialCode,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(Icons.keyboard_arrow_down, color: const Color(0xFF6B7280), size: 18.sp),
                    ],
                  ),
                ),
              ),
              // Local phone number input
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: '08012345678',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: ValidationStatusIcon(status: _phoneStatus),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.h, left: 4.w),
          child: Text(
            _phoneStatus == ValidationStatus.invalid
                ? 'Enter at least 7 digits'
                : 'Enter your local phone number',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: _phoneStatus == ValidationStatus.invalid
                  ? Colors.red
                  : Colors.grey[500],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAutoFillBadge() {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          'Auto-filled',
          style: GoogleFonts.inter(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6366F1),
          ),
        ),
      ),
    );
  }
}
