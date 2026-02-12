import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import '../../../domain/entities/insurance_product_entity.dart';
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
}
