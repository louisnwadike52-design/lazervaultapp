import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/business/presentation/receipts/business_receipt.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Record a Withholding-Tax (WHT) deduction against a vendor payment. Mirrors the
/// Record VAT screen; the fixed 7.5% VAT rate is replaced by a WHT-rate selector
/// (common Nigerian WHT rates: 5% and 10%). Backend auto-computes the WHT amount.
class RecordWHTScreen extends StatefulWidget {
  const RecordWHTScreen({super.key});

  @override
  State<RecordWHTScreen> createState() => _RecordWHTScreenState();
}

class _RecordWHTScreenState extends State<RecordWHTScreen> {
  final _formKey = GlobalKey<FormState>();

  final _vendorController = TextEditingController();
  final _paymentAmountController = TextEditingController();
  final _paymentRefController = TextEditingController();
  final _periodController = TextEditingController();

  double _whtRate = 5.0; // percent
  DateTime _transactionDate = DateTime.now();

  static const _rates = [2.5, 5.0, 10.0];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _periodController.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _vendorController.dispose();
    _paymentAmountController.dispose();
    _paymentRefController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  double get _paymentNaira {
    final text = _paymentAmountController.text.replaceAll(',', '').trim();
    return double.tryParse(text) ?? 0.0;
  }

  double get _whtAmount => _paymentNaira * (_whtRate / 100.0);

  String _formatAmount(double amount) => '₦${amount.toStringAsFixed(2)}';

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

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

    final paymentKobo = (_paymentNaira * 100).toInt();

    context.read<TaxCubit>().recordWHTDeduction(
          vendorName: _vendorController.text.trim(),
          paymentAmount: paymentKobo,
          whtRate: _whtRate,
          paymentReference: _paymentRefController.text.trim(),
          period: _periodController.text.trim(),
          transactionDate: _formatDate(_transactionDate),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaxCubit, TaxState>(
      listener: (context, state) {
        if (state is WHTDeductionRecorded) {
          final tx = buildBusinessReceipt(
            type: TransactionServiceType.tax,
            title: 'WHT recorded',
            amountMajor: _whtAmount,
            flow: TransactionFlow.neutral,
            status: UnifiedTransactionStatus.completed,
            reference: _paymentRefController.text.trim().isNotEmpty
                ? _paymentRefController.text.trim()
                : null,
            counterpartyName: _vendorController.text.trim().isNotEmpty
                ? _vendorController.text.trim()
                : null,
            description: 'Withholding tax at ${_whtRate.toStringAsFixed(1)}%',
            metadata: {
              'Payment amount': '₦${_paymentNaira.toStringAsFixed(2)}',
              'WHT (${_whtRate.toStringAsFixed(1)}%)':
                  '₦${_whtAmount.toStringAsFixed(2)}',
              if (_vendorController.text.trim().isNotEmpty)
                'Vendor': _vendorController.text.trim(),
              if (_periodController.text.trim().isNotEmpty)
                'Period': _periodController.text.trim(),
            },
          );
          showBusinessReceipt(context, tx).then((_) => Get.back(result: true));
          return;
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
            'Record WHT Deduction',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVendorField(),
                        SizedBox(height: 16.h),
                        _buildPaymentAmountField(),
                        SizedBox(height: 20.h),
                        _buildRateSelector(),
                        SizedBox(height: 12.h),
                        _buildWHTAmountDisplay(),
                        SizedBox(height: 20.h),
                        _buildPaymentRefField(),
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

  Widget _buildVendorField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Vendor / Payee *'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _vendorController,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Vendor name is required';
            }
            return null;
          },
          decoration: _inputDecoration(
            hint: 'e.g. ABC Consulting Ltd',
            icon: Icons.store_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Payment Amount (Naira) *'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _paymentAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
          ],
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Payment amount is required';
            }
            final parsed = double.tryParse(value.replaceAll(',', '').trim());
            if (parsed == null || parsed <= 0) {
              return 'Enter a valid amount';
            }
            return null;
          },
          decoration: _inputDecoration(
            hint: 'e.g. 200000',
            icon: Icons.payments_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildRateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('WHT Rate'),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: _rates.map((r) {
              final selected = _whtRate == r;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _whtRate = r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        '${r % 1 == 0 ? r.toStringAsFixed(0) : r.toStringAsFixed(1)}%',
                        style: GoogleFonts.inter(
                          color: selected
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                          fontWeight:
                              selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWHTAmountDisplay() {
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
              Icon(Icons.calculate_outlined,
                  color: const Color(0xFF3B82F6), size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                'WHT to withhold',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            _formatAmount(_whtAmount),
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

  Widget _buildPaymentRefField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Payment Reference (optional)'),
        SizedBox(height: 6.h),
        TextFormField(
          controller: _paymentRefController,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          decoration: _inputDecoration(
            hint: 'e.g. PAY-2026-001',
            icon: Icons.receipt_outlined,
          ),
        ),
      ],
    );
  }

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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.event_outlined,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
                SizedBox(width: 12.w),
                Text(
                  _formatDate(_transactionDate),
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
                ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_down,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<TaxCubit, TaxState>(
      builder: (context, state) {
        final isLoading = state is TaxLoading;
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: const BoxDecoration(
            color: Color(0xFF0A0A0A),
            border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
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
                  ? LazerVaultLoader(size: 22)
                  : Text(
                      'Record Deduction',
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
      hintStyle:
          GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 15.sp),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );
  }
}
