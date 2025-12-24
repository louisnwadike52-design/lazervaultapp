import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/injection_container.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';

class CreateTagPayScreen extends StatelessWidget {
  const CreateTagPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<TagPayCubit>(),
      child: const _CreateTagPayView(),
    );
  }
}

class _CreateTagPayView extends StatefulWidget {
  const _CreateTagPayView();

  @override
  State<_CreateTagPayView> createState() => _CreateTagPayViewState();
}

class _CreateTagPayViewState extends State<_CreateTagPayView> {
  final _tagPayController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecking = false;
  bool _isAvailable = false;
  String? _availabilityMessage;
  List<String> _suggestions = [];

  @override
  void dispose() {
    _tagPayController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  void _checkAvailability(String tagPay) {
    if (tagPay.isEmpty) {
      setState(() {
        _isChecking = false;
        _isAvailable = false;
        _availabilityMessage = null;
        _suggestions = [];
      });
      return;
    }

    // Remove @ if user added it
    final cleanTag = tagPay.replaceAll('@', '').replaceAll('\$', '');

    if (cleanTag.length < 3) {
      setState(() {
        _isChecking = false;
        _isAvailable = false;
        _availabilityMessage = 'Tag pay must be at least 3 characters';
        _suggestions = [];
      });
      return;
    }

    setState(() => _isChecking = true);
    context.read<TagPayCubit>().checkAvailability(cleanTag);
  }

  void _createTagPay() {
    if (!_formKey.currentState!.validate()) return;
    if (!_isAvailable) {
      Get.snackbar(
        'Unavailable',
        'Please choose an available tag pay',
        backgroundColor: const Color(0xFF1F1F1F),
        colorText: Colors.white,
      );
      return;
    }

    final cleanTag = _tagPayController.text.replaceAll('@', '').replaceAll('\$', '');
    context.read<TagPayCubit>().createTagPay(
      tagPay: cleanTag,
      displayName: _displayNameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is TagPayAvailabilityChecked) {
            setState(() {
              _isChecking = false;
              _isAvailable = state.available;
              _availabilityMessage = state.message;
              _suggestions = state.suggestions;
            });
          } else if (state is TagPayLoaded) {
            Get.snackbar(
              'Success',
              'Tag pay created successfully!',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
            );
            Get.back(result: state.tagPay);
          } else if (state is TagPayError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is TagPayLoading;

          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildInfoCard(),
                          SizedBox(height: 32.h),
                          _buildTagPayInput(),
                          SizedBox(height: 24.h),
                          _buildDisplayNameInput(),
                          if (_suggestions.isNotEmpty) ...[
                            SizedBox(height: 24.h),
                            _buildSuggestions(),
                          ],
                          SizedBox(height: 32.h),
                          _buildCreateButton(isLoading),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Create Tag Pay',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E3A8A),
            Color(0xFF3B82F6),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Choose a unique tag pay that your friends can use to send you money instantly',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagPayInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tag Pay',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _tagPayController,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: 'yourname',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                '\$',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: _isChecking
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  )
                : _tagPayController.text.isNotEmpty
                    ? Icon(
                        _isAvailable ? Icons.check_circle : Icons.cancel,
                        color: _isAvailable
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      )
                    : null,
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
            ),
          ),
          onChanged: (value) {
            // Debounce the check
            Future.delayed(const Duration(milliseconds: 500), () {
              if (value == _tagPayController.text) {
                _checkAvailability(value);
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a tag pay';
            }
            final cleanTag = value.replaceAll('@', '').replaceAll('\$', '');
            if (cleanTag.length < 3) {
              return 'Tag pay must be at least 3 characters';
            }
            if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(cleanTag)) {
              return 'Only letters, numbers, and underscores allowed';
            }
            return null;
          },
        ),
        if (_availabilityMessage != null) ...[
          SizedBox(height: 8.h),
          Text(
            _availabilityMessage!,
            style: GoogleFonts.inter(
              color: _isAvailable
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDisplayNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display Name',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _displayNameController,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: 'Your Name',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your display name';
            }
            if (value.length < 2) {
              return 'Display name must be at least 2 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggestions',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _suggestions.map((suggestion) {
            return GestureDetector(
              onTap: () {
                _tagPayController.text = suggestion;
                _checkAvailability(suggestion);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFF3B82F6)),
                ),
                child: Text(
                  '\$$suggestion',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCreateButton(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : _createTagPay,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3B82F6),
        disabledBackgroundColor: const Color(0xFF374151),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              'Create Tag Pay',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
