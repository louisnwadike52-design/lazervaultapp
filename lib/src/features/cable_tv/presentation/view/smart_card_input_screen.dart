import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';

class SmartCardInputScreen extends StatefulWidget {
  const SmartCardInputScreen({super.key});

  @override
  State<SmartCardInputScreen> createState() => _SmartCardInputScreenState();
}

class _SmartCardInputScreenState extends State<SmartCardInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _smartCardController = TextEditingController();
  bool _isValidated = false;

  @override
  void initState() {
    super.initState();
    // Prefill the input from args when the user is renewing a saved
    // smart card (or repeating a history row). Every read path uses
    // `_resolveProvider()` now so a caller that only knows
    // providerCode/providerName still gets a working provider entity.
    final args = _args();
    final prefill = args['smartCardNumber'];
    if (prefill is String && prefill.trim().isNotEmpty) {
      _smartCardController.text = prefill.trim();
    }
  }

  @override
  void dispose() {
    _smartCardController.dispose();
    super.dispose();
  }

  /// Defensive args reader. Returns an empty map when no arguments were
  /// passed — stops the old `null cast to Map<String, dynamic>` crash
  /// when a deep-link or background restore lands here without args.
  Map<String, dynamic> _args() {
    final raw = Get.arguments;
    return raw is Map<String, dynamic> ? raw : const {};
  }

  /// Accepts either a full `CableTVProviderEntity` under `provider`, or a
  /// `providerCode` + `providerName` pair (the shape used by saved-
  /// beneficiaries' "Renew Subscription" and by history-row repeats).
  /// Returns null only when neither shape is present — build/validate
  /// paths handle that by bouncing the user back with a snackbar.
  CableTVProviderEntity? _resolveProvider() {
    final args = _args();
    final p = args['provider'];
    if (p is CableTVProviderEntity) return p;
    final code = (args['providerCode'] ?? args['provider_code'])?.toString() ?? '';
    final name = (args['providerName'] ?? args['provider_name'])?.toString() ?? '';
    if (code.isEmpty) return null;
    return CableTVProviderEntity(
      id: code,
      name: name.isNotEmpty ? name : code,
      serviceId: code.toLowerCase(),
      logoUrl: '',
      isActive: true,
      commissionRate: 0,
    );
  }

  void _onValidate() {
    if (_formKey.currentState!.validate()) {
      final provider = _resolveProvider();
      if (provider == null) {
        Get.snackbar('Provider missing',
            'Open this screen from a saved smart card or the providers grid.',
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
        return;
      }
      context.read<CableTVCubit>().validateSmartCard(
            providerId: provider.serviceId,
            smartCardNumber: _smartCardController.text.trim(),
          );
    }
  }

  void _onContinue() {
    final provider = _resolveProvider();
    if (provider == null) return;
    final cubitState = context.read<CableTVCubit>().state;

    if (cubitState is SmartCardValidated) {
      Get.toNamed(
        AppRoutes.cableTVPackageSelection,
        arguments: {
          'provider': provider,
          'validation': cubitState.validation,
          'smartCardNumber': cubitState.smartCardNumber,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = _resolveProvider();
    if (provider == null) {
      // Defensive fallback — avoid a hard cast crash. A brief "missing
      // provider" empty state with a back CTA is much less jarring than
      // a `type 'Null' is not a subtype of CableTVProviderEntity` red
      // screen when the caller's args shape is wrong.
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.tv_off,
                    size: 48.sp, color: const Color(0xFF4B5563)),
                SizedBox(height: 16.h),
                Text('Provider missing',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.h),
                Text(
                  'Open this screen from a saved smart card or the providers grid.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Go back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Smart Card Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocListener<CableTVCubit, CableTVState>(
          listener: (context, state) {
            if (state is SmartCardValidated) {
              setState(() {
                _isValidated = true;
              });
            } else if (state is SmartCardValidationFailed) {
              setState(() {
                _isValidated = false;
              });
              Get.snackbar(
                'Validation Failed',
                state.message,
                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.w),
                borderRadius: 12,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // Provider info card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFF2D2D2D),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.live_tv,
                          color: const Color(0xFF4E03D0),
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.name,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Enter your smart card number below',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),

                // Smart card input form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Card Number',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _smartCardController,
                        keyboardType: TextInputType.number,
                        maxLength: 12,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter 10-digit smart card number',
                          hintStyle: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                            fontSize: 16.sp,
                          ),
                          counterText: '',
                          filled: true,
                          fillColor: const Color(0xFF1F1F1F),
                          prefixIcon: Icon(
                            Icons.credit_card,
                            color: const Color(0xFF9CA3AF),
                            size: 20.sp,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFF4E03D0),
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFEF4444),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFEF4444),
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (_) {
                          if (_isValidated) {
                            setState(() {
                              _isValidated = false;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Smart card number is required';
                          }
                          if (value.trim().length < 10) {
                            return 'Smart card number must be at least 10 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Enter the 10-digit number from your decoder',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF).withValues(alpha: 0.6),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Validation result card
                BlocBuilder<CableTVCubit, CableTVState>(
                  builder: (context, state) {
                    if (state is SmartCardValidated && _isValidated) {
                      return _buildValidationResultCard(state);
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const Spacer(),

                // Action button
                BlocBuilder<CableTVCubit, CableTVState>(
                  builder: (context, state) {
                    final isValidating = state is SmartCardValidating;

                    if (_isValidated && state is SmartCardValidated) {
                      return _buildButton(
                        label: 'Continue',
                        onPressed: _onContinue,
                        isLoading: false,
                      );
                    }

                    return _buildButton(
                      label: 'Validate Smart Card',
                      onPressed: isValidating ? null : _onValidate,
                      isLoading: isValidating,
                    );
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidationResultCard(SmartCardValidated state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: const Color(0xFF10B981),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Card Verified',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Customer Name', state.validation.customerName),
          SizedBox(height: 10.h),
          _buildDetailRow('Current Package', state.validation.currentPackage),
          if (state.validation.renewalDate.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _buildDetailRow('Renewal Date', state.validation.renewalDate),
          ],
          if (state.validation.dueDate.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _buildDetailRow('Due Date', state.validation.dueDate),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback? onPressed,
    required bool isLoading,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4E03D0),
          disabledBackgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
