import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../../domain/repositories/insurance_repository.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';

/// Screen 2: Dynamic form fields from MyCover.ai product
class InsuranceFormScreen extends StatefulWidget {
  const InsuranceFormScreen({super.key});

  @override
  State<InsuranceFormScreen> createState() => _InsuranceFormScreenState();
}

class _InsuranceFormScreenState extends State<InsuranceFormScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Debouncer _debouncer = Debouncer(milliseconds: 300);
  final Map<String, List<AuxiliaryItem>> _auxiliaryCache = {};
  final Map<String, bool> _auxiliaryLoading = {};
  final Map<String, bool> _fileUploading = {};
  final Map<String, CountryLocale> _phoneCountryCodes = {}; // per-field country code

  /// Detects if a field requires file upload based on name patterns
  bool _isFileField(InsuranceProductFormField field) {
    final name = field.name.toLowerCase();
    final type = field.type.toLowerCase();
    return type == 'file' ||
        name.contains('image') ||
        name.contains('photo') ||
        name.contains('proof') ||
        name.contains('id_url') ||
        name.endsWith('_url');
  }

  /// Returns the utility ID for fields that need auxiliary data, or null.
  /// Fields with static options defined on the backend (e.g. state) should NOT
  /// be listed here — they use the options from the field definition directly.
  String? _getUtilityIdForField(String fieldName) {
    final name = fieldName.toLowerCase();
    if (name.contains('vehicle_make') || name == 'make') {
      return InsuranceUtilityIds.vehicleMakes;
    }
    if (name.contains('vehicle_model') || name == 'model') {
      return InsuranceUtilityIds.vehicleModels;
    }
    // State uses static options from backend — no auxiliary fetch needed
    return null;
  }

  /// Gets the dependent query value for a field (e.g., vehicle_model depends on vehicle_make)
  String? _getDependentQuery(String fieldName, Map<String, String> formData) {
    final name = fieldName.toLowerCase();
    if (name.contains('vehicle_model') || name == 'model') {
      return formData['vehicle_make'] ?? formData['make'];
    }
    return null;
  }

  @override
  void dispose() {
    for (final c in _controllers.values) { c.dispose(); }
    _debouncer.dispose();
    super.dispose();
  }

  TextEditingController _getController(String name, String initialValue) {
    if (!_controllers.containsKey(name)) {
      _controllers[name] = TextEditingController(text: initialValue);
    } else if (_controllers[name]!.text != initialValue && initialValue.isNotEmpty) {
      // Sync controller text if form data was updated externally (e.g., auto-fill)
      // Only update if initialValue is non-empty to avoid clearing user input
      final controller = _controllers[name]!;
      if (controller.text.isEmpty && initialValue.isNotEmpty) {
        controller.text = initialValue;
      }
    }
    return _controllers[name]!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePolicyCubit, CreatePolicyState>(
      builder: (context, state) {
        // Handle InsuranceProductSelected directly
        if (state is InsuranceProductSelected) {
          return _buildForm(state.product, state.formData, state.formErrors);
        }

        // Also handle states that occur while form is still visible
        // (e.g. quote loading after pressing Continue, or late SWR emission)
        final cubit = context.read<CreatePolicyCubit>();
        if (cubit.selectedProduct != null) {
          return _buildForm(cubit.selectedProduct!, cubit.formData, const {});
        }

        return Center(child: Text('Please select a product first',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))));
      },
    );
  }

  Widget _buildForm(InsuranceProduct product, Map<String, String> formData, Map<String, String> formErrors) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          _buildProductHeader(product),
          SizedBox(height: 24.h),
          Text('Your Details', style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(height: 4.h),
          Text('Fill in the required information for your insurance',
            style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
          SizedBox(height: 20.h),
          ...product.formFields.map((field) =>
            _buildFormField(context, field, formData[field.name] ?? '', formErrors[field.name])),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildProductHeader(InsuranceProduct product) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
      ),
      child: Row(children: [
        Container(
          width: 40.w, height: 40.w,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r)),
          child: Center(child: Icon(product.category.icon, size: 22.sp, color: const Color(0xFF6366F1))),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product.name, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          Text(product.providerName, style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
        ])),
        GestureDetector(
          onTap: () => _showProductInfoSheet(context, product),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6366F1).withValues(alpha: 0.12),
            ),
            child: Icon(Icons.info_outline, color: const Color(0xFF6366F1), size: 18.sp),
          ),
        ),
      ]),
    );
  }

  void _showProductInfoSheet(BuildContext context, InsuranceProduct product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.35,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r)),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  children: [
                    Row(children: [
                      Container(
                        width: 48.w, height: 48.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r)),
                        child: Icon(product.category.icon, size: 26.sp, color: const Color(0xFF6366F1)),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(product.name, style: GoogleFonts.inter(
                          fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                        SizedBox(height: 2.h),
                        Text(product.providerName, style: GoogleFonts.inter(
                          fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                      ])),
                    ]),
                    SizedBox(height: 16.h),
                    // Premium + category
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.premiumRange, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.category.displayName, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF6366F1))),
                      ),
                    ]),
                    SizedBox(height: 20.h),
                    // Description
                    _buildInfoSectionTitle('About'),
                    SizedBox(height: 8.h),
                    _buildInfoRichContent(product.description),
                    // How It Works
                    if (product.howItWorks.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildInfoSectionTitle('How It Works'),
                      SizedBox(height: 8.h),
                      _buildInfoRichContent(product.howItWorks),
                    ],
                    // Benefits
                    if (product.benefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildInfoSectionTitle('Benefits'),
                      SizedBox(height: 8.h),
                      ...product.benefits.map((b) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Icon(Icons.check_circle, size: 16.sp, color: const Color(0xFF10B981)),
                          SizedBox(width: 8.w),
                          Expanded(child: Text(b, style: GoogleFonts.inter(
                            fontSize: 13.sp, color: Colors.white, height: 1.4))),
                        ]),
                      )),
                    ],
                    // Full Benefits
                    if (product.fullBenefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildInfoSectionTitle('Full Coverage Details'),
                      SizedBox(height: 8.h),
                      _buildInfoRichContent(product.fullBenefits),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSectionTitle(String title) {
    return Text(title, style: GoogleFonts.inter(
      fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white));
  }

  Widget _buildInfoRichContent(String content) {
    if (content.contains('<') && content.contains('>')) {
      return HtmlWidget(
        content,
        textStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5),
        customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'},
      );
    }
    return Text(content, style: GoogleFonts.inter(
      fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5));
  }

  Widget _buildFormField(BuildContext context, InsuranceProductFormField field, String value, String? error) {
    final cubit = context.read<CreatePolicyCubit>();

    // Check for file upload fields
    if (_isFileField(field)) {
      return _buildFileUploadField(cubit, field, value, error);
    }

    // Check for auxiliary data select fields (states, vehicle makes/models)
    final utilityId = _getUtilityIdForField(field.name);
    if (utilityId != null) {
      final state = context.read<CreatePolicyCubit>().state;
      final formData = state is InsuranceProductSelected ? state.formData : <String, String>{};
      return _buildAuxiliarySelectField(cubit, field, value, error, utilityId, formData);
    }

    switch (field.type.toLowerCase()) {
      case 'select':
      case 'dropdown':
        return _buildDropdownField(cubit, field, value, error);
      case 'date':
        return _buildDateField(context, cubit, field, value, error);
      case 'boolean':
        return _buildBooleanField(cubit, field, value);
      case 'number':
        return _buildTextField(cubit, field, value, error,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.]'))]);
      case 'email':
        return _buildTextField(cubit, field, value, error, keyboardType: TextInputType.emailAddress);
      case 'phone':
        return _buildPhoneField(cubit, field, value, error);
      default:
        return _buildTextField(cubit, field, value, error);
    }
  }

  String? _validateField(InsuranceProductFormField field, String value) {
    if (value.isEmpty) return null;
    final type = field.type.toLowerCase();
    if (type == 'email' && (!value.contains('@') || !value.contains('.'))) {
      return 'Please enter a valid email address';
    }
    if (type == 'phone') {
      final digits = value.replaceAll(RegExp(r'[^\d]'), '');
      final stripped = digits.startsWith('0') ? digits.substring(1) : digits;
      if (stripped.length < 7) return 'Enter at least 7 digits';
      if (stripped.length > 14) return 'Phone number too long';
    }
    if (type == 'number') {
      if (double.tryParse(value) == null) return 'Please enter a valid number';
      if (double.parse(value) < 0) return 'Value must be positive';
    }
    if (type == 'text' && field.required && value.trim().length < 2) {
      return 'Must be at least 2 characters';
    }
    return null;
  }

  Widget _buildTextField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error,
      {TextInputType keyboardType = TextInputType.text, List<TextInputFormatter>? inputFormatters}) {
    final controller = _getController(field.name, value);
    final inlineError = error ?? _validateField(field, controller.text);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        if (field.description.isNotEmpty)
          Padding(padding: EdgeInsets.only(top: 2.h),
            child: field.description.contains('<') && field.description.contains('>')
              ? HtmlWidget(field.description, textStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                  customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'})
              : Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller, keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: (v) => _debouncer.run(() => cubit.updateFormField(field.name, v)),
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          decoration: InputDecoration(
            hintText: field.placeholder.isNotEmpty ? field.placeholder : 'Enter ${field.label.toLowerCase()}',
            hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5)),
            filled: true, fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF6366F1))),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFFEF4444))),
            errorText: inlineError,
            errorStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)),
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
        ),
      ]),
    );
  }

  Widget _buildPhoneField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    // Initialize country code for this field if not yet set
    _phoneCountryCodes.putIfAbsent(field.name, () {
      // Try to detect from existing value
      if (value.startsWith('+')) {
        final sorted = List<CountryLocale>.from(CountryLocales.all)
          ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
        for (final c in sorted) {
          if (value.startsWith(c.dialCode)) return c;
        }
      }
      return CountryLocales.all.first; // Nigeria default
    });

    final country = _phoneCountryCodes[field.name]!;

    // Strip dial code from displayed value so controller only has local digits
    String localValue = value;
    if (value.startsWith(country.dialCode)) {
      localValue = value.substring(country.dialCode.length);
    } else if (value.startsWith('+')) {
      // Strip any other dial code prefix
      final sorted = List<CountryLocale>.from(CountryLocales.all)
        ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
      for (final c in sorted) {
        if (value.startsWith(c.dialCode)) {
          localValue = value.substring(c.dialCode.length);
          break;
        }
      }
    }

    final controller = _getController(field.name, localValue);
    // Sync controller if value changed externally
    if (controller.text != localValue && localValue != value) {
      controller.text = localValue;
    }

    final digits = controller.text.replaceAll(RegExp(r'[^\d]'), '');
    final stripped = digits.startsWith('0') ? digits.substring(1) : digits;
    String? inlineError = error;
    if (inlineError == null && digits.isNotEmpty) {
      if (stripped.length < 7) {
        inlineError = 'Enter at least 7 digits';
      } else if (stripped.length > 14) {
        inlineError = 'Phone number too long';
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        if (field.description.isNotEmpty)
          Padding(padding: EdgeInsets.only(top: 2.h),
            child: Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: inlineError != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D),
            ),
          ),
          child: Row(
            children: [
              // Country code button
              GestureDetector(
                onTap: () => _showPhoneCountryPicker(field.name, cubit, field, controller),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Color(0xFF2D2D2D), width: 1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(country.flag, style: TextStyle(fontSize: 18.sp)),
                      SizedBox(width: 4.w),
                      Text(country.dialCode,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      SizedBox(width: 2.w),
                      Icon(Icons.keyboard_arrow_down, color: const Color(0xFF6B7280), size: 16.sp),
                    ],
                  ),
                ),
              ),
              // Local number input
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onChanged: (v) {
                    final local = v.replaceAll(RegExp(r'[^\d]'), '');
                    final s = local.startsWith('0') ? local.substring(1) : local;
                    final full = '${country.dialCode}$s';
                    _debouncer.run(() => cubit.updateFormField(field.name, full));
                  },
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: '08012345678',
                    hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (inlineError != null)
          Padding(
            padding: EdgeInsets.only(top: 6.h, left: 4.w),
            child: Text(inlineError, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444))),
          ),
      ]),
    );
  }

  void _showPhoneCountryPicker(String fieldName, CreatePolicyCubit cubit, InsuranceProductFormField field, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final filtered = searchQuery.isEmpty ? CountryLocales.all : CountryLocales.search(searchQuery);
            return DraggableScrollableSheet(
              initialChildSize: 0.7, maxChildSize: 0.9, minChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                      width: 40.w, height: 4.h,
                      decoration: BoxDecoration(color: const Color(0xFF2D2D2D), borderRadius: BorderRadius.circular(2.r)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('Select Country Code', style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                        GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp)),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      child: TextField(
                        onChanged: (v) => setSheetState(() => searchQuery = v),
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'Search country...', hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
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
                          final c = filtered[index];
                          final isSelected = c.countryCode == _phoneCountryCodes[fieldName]?.countryCode;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _phoneCountryCodes[fieldName] = c);
                              // Re-send full phone to cubit
                              final local = controller.text.replaceAll(RegExp(r'[^\d]'), '');
                              final s = local.startsWith('0') ? local.substring(1) : local;
                              cubit.updateFormField(field.name, '${c.dialCode}$s');
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
                              child: Row(children: [
                                Text(c.flag, style: TextStyle(fontSize: 24.sp)),
                                SizedBox(width: 12.w),
                                Expanded(child: Text(c.countryName, style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500))),
                                Text(c.dialCode, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                if (isSelected) ...[SizedBox(width: 8.w), Icon(Icons.check_circle, color: const Color(0xFF3B82F6), size: 20.sp)],
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDropdownField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showSelectBottomSheet(cubit, field, value),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: error != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D)),
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  value.isNotEmpty ? value : 'Select ${field.label.toLowerCase()}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: value.isNotEmpty ? Colors.white : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
            ]),
          ),
        ),
        if (error != null)
          Padding(padding: EdgeInsets.only(top: 6.h, left: 14.w),
            child: Text(error, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)))),
      ]),
    );
  }

  void _showSelectBottomSheet(CreatePolicyCubit cubit, InsuranceProductFormField field, String currentValue) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final options = field.options;
            final filtered = searchQuery.isEmpty
                ? options
                : options.where((o) => o.toLowerCase().contains(searchQuery.toLowerCase())).toList();
            return DraggableScrollableSheet(
              initialChildSize: options.length > 6 ? 0.7 : 0.45,
              maxChildSize: 0.9,
              minChildSize: 0.3,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                      width: 40.w, height: 4.h,
                      decoration: BoxDecoration(color: const Color(0xFF2D2D2D), borderRadius: BorderRadius.circular(2.r)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('Select ${field.label}',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp),
                        ),
                      ]),
                    ),
                    if (options.length > 5)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        child: TextField(
                          onChanged: (v) => setSheetState(() => searchQuery = v),
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                            prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                            filled: true, fillColor: const Color(0xFF0A0A0A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          ),
                        ),
                      ),
                    Expanded(
                      child: filtered.isEmpty
                        ? Center(child: Text('No options found', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14.sp)))
                        : ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final option = filtered[index];
                              final isSelected = option == currentValue;
                              return GestureDetector(
                                onTap: () {
                                  cubit.updateFormField(field.name, option);
                                  Navigator.pop(context);
                                  setState(() {}); // Refresh the form
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 6.h),
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.1) : const Color(0xFF0A0A0A),
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: isSelected ? Border.all(color: const Color(0xFF6366F1), width: 1.5) : null,
                                  ),
                                  child: Row(children: [
                                    Expanded(child: Text(option,
                                      style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400))),
                                    if (isSelected)
                                      Icon(Icons.check_circle, color: const Color(0xFF6366F1), size: 20.sp),
                                  ]),
                                ),
                              );
                            },
                          ),
                    ),
                  ]),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context, CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    final controller = _getController(field.name, value);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(context: context, initialDate: DateTime.now(),
              firstDate: DateTime(2000), lastDate: DateTime(2100),
              builder: (context, child) => Theme(
                data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFF6366F1), surface: Color(0xFF1F1F1F))),
                child: child!));
            if (date != null && mounted) {
              final formatted = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
              cubit.updateFormField(field.name, formatted);
              controller.text = formatted;
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Select date',
                hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5)),
                filled: true, fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                errorText: error,
                suffixIcon: Icon(Icons.calendar_today, color: const Color(0xFF9CA3AF), size: 18.sp),
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildBooleanField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.description.isNotEmpty)
            field.description.contains('<') && field.description.contains('>')
              ? HtmlWidget(field.description, textStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                  customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'})
              : Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
        ])),
        Switch(
          value: value.toLowerCase() == 'true' || value == '1' || value.toLowerCase() == 'yes',
          onChanged: (v) => cubit.updateFormField(field.name, v.toString()),
          activeColor: const Color(0xFF6366F1),
          activeTrackColor: const Color(0xFF6366F1).withValues(alpha: 0.3),
          inactiveThumbColor: const Color(0xFF9CA3AF),
          inactiveTrackColor: const Color(0xFF2D2D2D),
        ),
      ]),
    );
  }

  Widget _buildFileUploadField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    final isUploading = _fileUploading[field.name] ?? false;
    final hasUpload = value.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        if (field.description.isNotEmpty)
          Padding(padding: EdgeInsets.only(top: 2.h),
            child: field.description.contains('<') && field.description.contains('>')
              ? HtmlWidget(field.description, textStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                  customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'})
              : Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: isUploading ? null : () => _pickAndUploadFile(cubit, field),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: error != null ? const Color(0xFFEF4444) : hasUpload ? const Color(0xFF10B981) : const Color(0xFF2D2D2D)),
            ),
            child: Row(children: [
              Icon(
                hasUpload ? Icons.check_circle : Icons.cloud_upload_outlined,
                color: hasUpload ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(child: Text(
                isUploading ? 'Uploading...' : hasUpload ? 'File uploaded' : 'Tap to upload file',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: hasUpload ? const Color(0xFF10B981) : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                ),
              )),
              if (isUploading)
                SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF6366F1))),
            ]),
          ),
        ),
        if (error != null)
          Padding(padding: EdgeInsets.only(top: 6.h, left: 14.w),
            child: Text(error, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)))),
      ]),
    );
  }

  Future<void> _pickAndUploadFile(CreatePolicyCubit cubit, InsuranceProductFormField field) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );
    if (result == null || result.files.isEmpty || result.files.first.bytes == null) return;

    if (!mounted) return;
    setState(() => _fileUploading[field.name] = true);

    try {
      final repo = GetIt.I<InsuranceRepository>();
      final file = result.files.first;
      final documentType = field.name.contains('id') ? 'id_document'
          : field.name.contains('proof') ? 'proof_of_purchase'
          : field.name.contains('claim') ? 'claim_evidence'
          : 'device_photo';

      final uploadId = await repo.uploadInsuranceDocument(
        fileData: file.bytes!.toList(),
        filename: file.name,
        documentType: documentType,
      );

      cubit.updateFormField(field.name, uploadId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e'), backgroundColor: const Color(0xFFEF4444)),
        );
      }
    } finally {
      if (mounted) setState(() => _fileUploading[field.name] = false);
    }
  }

  Widget _buildAuxiliarySelectField(
    CreatePolicyCubit cubit,
    InsuranceProductFormField field,
    String value,
    String? error,
    String utilityId,
    Map<String, String> formData,
  ) {
    final cacheKey = '$utilityId:${_getDependentQuery(field.name, formData) ?? ""}';
    final items = _auxiliaryCache[cacheKey];
    final isLoading = _auxiliaryLoading[cacheKey] ?? false;

    // Load auxiliary data if not cached
    if (items == null && !isLoading) {
      _loadAuxiliaryData(cacheKey, utilityId, _getDependentQuery(field.name, formData));
    }

    final options = items?.map((i) => i.value).toList() ?? field.options;
    final labels = items != null ? {for (var i in items) i.value: i.label} : <String, String>{};

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: error != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D)),
          ),
          child: isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(children: [
                  SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF6366F1))),
                  SizedBox(width: 10.w),
                  Text('Loading options...', style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
                ]),
              )
            : DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value.isNotEmpty && options.contains(value) ? value : null,
                  hint: Text('Select ${field.label.toLowerCase()}',
                    style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5))),
                  isExpanded: true,
                  dropdownColor: const Color(0xFF1F1F1F),
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                  icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
                  items: options.map((o) => DropdownMenuItem(value: o, child: Text(labels[o] ?? o))).toList(),
                  onChanged: (v) { if (v != null) cubit.updateFormField(field.name, v); },
                ),
              ),
        ),
        if (error != null)
          Padding(padding: EdgeInsets.only(top: 6.h, left: 14.w),
            child: Text(error, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)))),
      ]),
    );
  }

  Future<void> _loadAuxiliaryData(String cacheKey, String utilityId, String? query) async {
    setState(() => _auxiliaryLoading[cacheKey] = true);
    try {
      final repo = GetIt.I<InsuranceRepository>();
      final items = await repo.getInsuranceAuxiliaryData(utilityId: utilityId, query: query);
      if (mounted) {
        setState(() {
          _auxiliaryCache[cacheKey] = items;
          _auxiliaryLoading[cacheKey] = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _auxiliaryLoading[cacheKey] = false);
    }
  }
}
