import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';

class CreateOrganizationScreen extends StatefulWidget {
  const CreateOrganizationScreen({super.key});

  @override
  State<CreateOrganizationScreen> createState() =>
      _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState extends State<CreateOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _logoUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _logoUrlController.dispose();
    super.dispose();
  }

  void _onCreate() {
    if (!_formKey.currentState!.validate()) return;

    final args = Get.arguments as Map<String, dynamic>?;
    final accountId = args?['accountId'] as String? ?? '';

    if (accountId.isEmpty) {
      Get.snackbar(
        'Error',
        'Account ID is required',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    context.read<IDPayCubit>().createOrganization(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          logoUrl: _logoUrlController.text.trim().isNotEmpty
              ? _logoUrlController.text.trim()
              : null,
          accountId: accountId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
        ),
        title: Text(
          'Create Organization',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<IDPayCubit, IDPayState>(
        listener: (context, state) {
          if (state is IDPayOrganizationCreated) {
            Get.snackbar(
              'Success',
              'Organization "${state.organization.name}" created',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.back();
          }
          if (state is IDPayError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is IDPayLoading;

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Organization Name',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextFormField(
                              controller: _nameController,
                              maxLength: 100,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                              decoration: _inputDecoration('e.g. Church A')
                                  .copyWith(counterText: ''),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Name is required';
                                }
                                if (value.trim().length > 100) {
                                  return 'Name cannot exceed 100 characters';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Description (optional)',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextFormField(
                              controller: _descriptionController,
                              maxLength: 500,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                              maxLines: 3,
                              decoration: _inputDecoration(
                                      'Describe your organization')
                                  .copyWith(counterText: ''),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Logo URL (optional)',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextFormField(
                              controller: _logoUrlController,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                              keyboardType: TextInputType.url,
                              decoration: _inputDecoration(
                                  'https://example.com/logo.png'),
                              validator: (value) {
                                if (value != null && value.trim().isNotEmpty) {
                                  final uri = Uri.tryParse(value.trim());
                                  if (uri == null ||
                                      !uri.hasScheme ||
                                      (!uri.isScheme('http') &&
                                          !uri.isScheme('https'))) {
                                    return 'Enter a valid URL (https://...)';
                                  }
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _onCreate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 24.sp,
                                height: 24.sp,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Create Organization',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF6B7280),
        fontSize: 15.sp,
      ),
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );
  }
}
