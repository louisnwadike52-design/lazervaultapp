import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;

import '../../domain/entities/lock_fund_entity.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';

class LockFundAutoSaveScreen extends StatefulWidget {
  final LockFund lockFund;
  final LockFundAutoSaveConfig? existingAutoSave;

  const LockFundAutoSaveScreen({
    super.key,
    required this.lockFund,
    this.existingAutoSave,
  });

  @override
  State<LockFundAutoSaveScreen> createState() => _LockFundAutoSaveScreenState();
}

class _LockFundAutoSaveScreenState extends State<LockFundAutoSaveScreen> {
  final _amountController = TextEditingController();
  String _frequency = 'daily';
  bool _isSubmitting = false;

  bool get _isEditing => widget.existingAutoSave != null;

  @override
  void initState() {
    super.initState();
    if (widget.existingAutoSave != null) {
      _amountController.text = widget.existingAutoSave!.amount.toStringAsFixed(0);
      _frequency = widget.existingAutoSave!.frequency;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockFundsCubit, LockFundsState>(
      listener: (context, state) {
        if (state is AutoSaveCreated) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isEditing ? 'Auto-save updated' : 'Auto-save created'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Navigator.of(context).pop(true);
        } else if (state is LockFundsError) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: const Color(0xFFEF4444)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            _isEditing ? 'Edit Auto-Save' : 'Set Up Auto-Save',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            if (_isEditing)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                onPressed: _onDelete,
              ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lock fund info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Text(widget.lockFund.lockType.icon, style: TextStyle(fontSize: 28.sp)),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.lockFund.displayName,
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.lockFund.formattedAmount,
                            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Existing auto-save stats
                if (_isEditing && widget.existingAutoSave != null) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat(
                          'Total Saved',
                          currency_formatter.CurrencySymbols.formatAmountWithCurrency(
                            widget.existingAutoSave!.totalSaved,
                            widget.lockFund.currency,
                          ),
                        ),
                        _buildStat('Deposits', '${widget.existingAutoSave!.runCount}'),
                        _buildStat('Status', widget.existingAutoSave!.isActive ? 'Active' : 'Paused'),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                // Amount input
                Text(
                  'Auto-Save Amount',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))],
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    prefixText: '${currency_formatter.CurrencySymbols.getSymbol(widget.lockFund.currency)} ',
                    prefixStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 20.sp),
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(color: const Color(0xFF4B5563), fontSize: 20.sp),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 24.h),

                // Frequency selector
                Text(
                  'Frequency',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: ['daily', 'weekly', 'monthly'].map((freq) {
                    final isSelected = _frequency == freq;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _frequency = freq),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF1F1F1F),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              freq[0].toUpperCase() + freq.substring(1),
                              style: GoogleFonts.inter(
                                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                                fontSize: 14.sp,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),

                // Summary
                if (_amount > 0)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '${currency_formatter.CurrencySymbols.formatAmountWithCurrency(_amount, widget.lockFund.currency)} will be saved $_frequency into "${widget.lockFund.displayName}"',
                          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),

                const Spacer(),

                // Pause button (for editing)
                if (_isEditing && widget.existingAutoSave!.isActive) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: _onPause,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFFB923C)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      ),
                      child: Text(
                        'Pause Auto-Save',
                        style: GoogleFonts.inter(color: const Color(0xFFFB923C), fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: _amount > 0 && !_isSubmitting ? _onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      disabledBackgroundColor: const Color(0xFF2D2D2D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            width: 24.w, height: 24.h,
                            child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            _isEditing ? 'Update Auto-Save' : 'Start Auto-Save',
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
        SizedBox(height: 4.h),
        Text(value, style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  void _onSubmit() {
    setState(() => _isSubmitting = true);
    final cubit = context.read<LockFundsCubit>();

    if (_isEditing) {
      cubit.updateAutoSave(
        autoSaveId: widget.existingAutoSave!.id,
        amount: _amount,
        frequency: _frequency,
      );
    } else {
      cubit.createAutoSave(
        lockFundId: widget.lockFund.id,
        sourceAccountId: widget.lockFund.sourceAccountId ?? '',
        amount: _amount,
        frequency: _frequency,
      );
    }
  }

  void _onPause() {
    context.read<LockFundsCubit>().updateAutoSave(
      autoSaveId: widget.existingAutoSave!.id,
      status: 'paused',
    );
  }

  void _onDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Stop Auto-Save?', style: GoogleFonts.inter(color: Colors.white)),
        content: Text(
          'This will permanently stop the auto-save for this PiggyVault.',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<LockFundsCubit>().deleteAutoSave(autoSaveId: widget.existingAutoSave!.id);
              Navigator.of(context).pop(true);
            },
            child: Text('Stop', style: GoogleFonts.inter(color: const Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }
}
