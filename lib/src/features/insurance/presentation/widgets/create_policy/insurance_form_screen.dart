import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
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

  /// Returns the utility ID for fields that need auxiliary data, or null
  String? _getUtilityIdForField(String fieldName) {
    final name = fieldName.toLowerCase();
    if (name.contains('vehicle_make') || name == 'make') {
      return InsuranceUtilityIds.vehicleMakes;
    }
    if (name.contains('vehicle_model') || name == 'model') {
      return InsuranceUtilityIds.vehicleModels;
    }
    if (name.contains('state') && !name.contains('status')) {
      return InsuranceUtilityIds.nigerianStates;
    }
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
    }
    return _controllers[name]!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePolicyCubit, CreatePolicyState>(
      builder: (context, state) {
        if (state is! InsuranceProductSelected) {
          return Center(child: Text('Please select a product first',
            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))));
        }

        final product = state.product;
        final formData = state.formData;
        final formErrors = state.formErrors;

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
      },
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
      ]),
    );
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
        return _buildTextField(cubit, field, value, error, keyboardType: TextInputType.number);
      case 'email':
        return _buildTextField(cubit, field, value, error, keyboardType: TextInputType.emailAddress);
      case 'phone':
        return _buildTextField(cubit, field, value, error, keyboardType: TextInputType.phone);
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
    if (type == 'phone' && !RegExp(r'^[0-9+\-\s()]+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  Widget _buildTextField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error,
      {TextInputType keyboardType = TextInputType.text}) {
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
            child: Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller, keyboardType: keyboardType,
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

  Widget _buildDropdownField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
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
            color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: error != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.isNotEmpty && field.options.contains(value) ? value : null,
              hint: Text('Select ${field.label.toLowerCase()}',
                style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5))),
              isExpanded: true, dropdownColor: const Color(0xFF1F1F1F),
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
              items: field.options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
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
            if (date != null) {
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
            Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
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
            child: Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
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
