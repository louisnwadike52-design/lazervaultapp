import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';

class RecordVATScreen extends StatefulWidget {
  const RecordVATScreen({super.key});

  @override
  State<RecordVATScreen> createState() => _RecordVATScreenState();
}

class _RecordVATScreenState extends State<RecordVATScreen> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  final _baseAmountController = TextEditingController();
  final _invoiceRefController = TextEditingController();
  final _periodController = TextEditingController();

  bool _isOutput = true; // true = OUTPUT, false = INPUT
  DateTime _transactionDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _periodController.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _baseAmountController.dispose();
    _invoiceRefController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  double get _baseAmountNaira {
    final text = _baseAmountController.text.replaceAll(',', '').trim();
    return double.tryParse(text) ?? 0.0;
  }

  double get _vatAmount => _baseAmountNaira * 0.075;

  String _formatAmount(double amount) {
    return '\u20A6${amount.toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _transactionDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              surface: Color(0xFF1F1F1F),
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _transactionDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final baseAmountKobo = (_baseAmountNaira * 100).toInt();

    context.read<TaxCubit>().recordVATTransaction(
          description: _descriptionController.text.trim(),
          baseAmount: baseAmountKobo,
          direction: _isOutput ? 1 : 0,
          invoiceReference: _invoiceRefController.text.trim(),
          period: _periodController.text.trim(),
          transactionDate: _formatDate(_transactionDate),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaxCubit, TaxState>(
      listener: (context, state) {
        if (state is VATTransactionRecorded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'VAT transaction recorded successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is TaxError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Record VAT Transaction',
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
                        _buildDescriptionField(),
                        SizedBox(height: 16.h),
                        _buildBaseAmountField(),
                        SizedBox(height: 12.h),
                        _buildVATAmountDisplay(),
                        SizedBox(height: 20.h),
                        _buildDirectionToggle(),
                        SizedBox(height: 20.h),
                        _buildInvoiceRefField(),
                        SizedBox(height: 16.h),
                        _buildPeriodField(),
                        SizedBox(height: 16.h),
                        _buildDatePicker(),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Description
  // ---------------------------------------------------------------------------

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Description *'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _descriptionController,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          maxLines: 2,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Description is required';
            }
            return null;
          },
          decoration: _inputDecoration(
            hint: 'e.g. Sale of goods to ABC Ltd',
            icon: Icons.description_outlined,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Base Amount
  // ---------------------------------------------------------------------------

  Widget _buildBaseAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Base Amount (Naira) *'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _baseAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
          ],
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Base amount is required';
            }
            final parsed =
                double.tryParse(value.replaceAll(',', '').trim());
            if (parsed == null || parsed <= 0) {
              return 'Enter a valid amount';
            }
            return null;
          },
          decoration: _inputDecoration(
            hint: 'e.g. 50000',
            icon: Icons.payments_outlined,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // VAT Amount Display
  // ---------------------------------------------------------------------------

  Widget _buildVATAmountDisplay() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate_outlined,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                'VAT Amount (7.5%)',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            _formatAmount(_vatAmount),
            style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Direction Toggle
  // ---------------------------------------------------------------------------

  Widget _buildDirectionToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Direction'),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildToggleOption(
                  label: 'OUTPUT',
                  subtitle: 'VAT charged on sales',
                  isSelected: _isOutput,
                  color: const Color(0xFF3B82F6),
                  onTap: () => setState(() => _isOutput = true),
                  isLeft: true,
                ),
              ),
              Expanded(
                child: _buildToggleOption(
                  label: 'INPUT',
                  subtitle: 'VAT paid on purchases',
                  isSelected: !_isOutput,
                  color: const Color(0xFF10B981),
                  onTap: () => setState(() => _isOutput = false),
                  isLeft: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleOption({
    required String label,
    required String subtitle,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
    required bool isLeft,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isLeft ? Radius.circular(12.r) : Radius.zero,
            right: isLeft ? Radius.zero : Radius.circular(12.r),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? color : const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: isSelected
                    ? color.withValues(alpha: 0.7)
                    : const Color(0xFF6B7280),
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Invoice Reference
  // ---------------------------------------------------------------------------

  Widget _buildInvoiceRefField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Invoice Reference (optional)'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _invoiceRefController,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          decoration: _inputDecoration(
            hint: 'e.g. INV-2026-001',
            icon: Icons.receipt_outlined,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Period
  // ---------------------------------------------------------------------------

  Widget _buildPeriodField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Period'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _periodController,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Period is required';
            }
            if (!RegExp(r'^\d{4}-\d{2}$').hasMatch(value.trim())) {
              return 'Use format YYYY-MM (e.g. 2026-02)';
            }
            return null;
          },
          decoration: _inputDecoration(
            hint: 'e.g. 2026-02',
            icon: Icons.calendar_month_outlined,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Date Picker
  // ---------------------------------------------------------------------------

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Transaction Date'),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event_outlined,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  _formatDate(_transactionDate),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Submit Button
  // ---------------------------------------------------------------------------

  Widget _buildSubmitButton() {
    return BlocBuilder<TaxCubit, TaxState>(
      builder: (context, state) {
        final isLoading = state is TaxLoading;

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
              onPressed: isLoading ? null : _submit,
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
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Record Transaction',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Widgets
  // ---------------------------------------------------------------------------

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: const Color(0xFF9CA3AF),
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF6B7280),
        fontSize: 15.sp,
      ),
      prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
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
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 14.h,
      ),
    );
  }
}
