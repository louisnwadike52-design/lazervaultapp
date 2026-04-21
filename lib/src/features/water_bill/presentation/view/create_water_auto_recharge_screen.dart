import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../domain/entities/water_auto_recharge.dart';
import '../../domain/entities/water_beneficiary.dart';
import '../cubit/water_auto_recharge_cubit.dart';
import '../cubit/water_auto_recharge_state.dart';
import '../cubit/water_beneficiary_cubit.dart';
import '../cubit/water_beneficiary_state.dart';

/// Create or edit a water-bill Auto-Pay schedule. Mirrors
/// `CreateDataAutoRechargeScreen` but simpler — water has no variation;
/// user supplies a saved account + amount + cadence + time.
class CreateWaterAutoRechargeScreen extends StatefulWidget {
  const CreateWaterAutoRechargeScreen({super.key});

  @override
  State<CreateWaterAutoRechargeScreen> createState() =>
      _CreateWaterAutoRechargeScreenState();
}

class _CreateWaterAutoRechargeScreenState
    extends State<CreateWaterAutoRechargeScreen> {
  WaterBeneficiary? _beneficiary;
  final TextEditingController _amountController = TextEditingController();
  String _frequency = 'monthly';
  int _dayOfMonth = 1;
  int _dayOfWeek = 1;
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0);
  bool _saving = false;

  bool _locked = false;
  String? _editId;

  @override
  void initState() {
    super.initState();
    context.read<WaterBeneficiaryCubit>().load();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _locked = args['locked'] == true;
      final ar = args['autoRecharge'];
      if (ar is WaterAutoRecharge) {
        _editId = ar.id;
        _amountController.text = ar.amount.toStringAsFixed(0);
        _frequency = ar.frequency.isNotEmpty ? ar.frequency : 'monthly';
        _dayOfWeek = ar.dayOfWeek > 0 ? ar.dayOfWeek : 1;
        _dayOfMonth = ar.dayOfMonth > 0 ? ar.dayOfMonth : 1;
        _time = TimeOfDay(hour: ar.executionHour, minute: ar.executionMinute);
        _locked = true;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final b = args['beneficiary'];
        if (b is WaterBeneficiary) setState(() => _beneficiary = b);
        if (ar is WaterAutoRecharge && ar.beneficiary != null) {
          setState(() => _beneficiary = ar.beneficiary);
        }
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_beneficiary == null) {
      _snack('Pick a saved water account', error: true);
      return;
    }
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      _snack('Enter a valid amount', error: true);
      return;
    }
    setState(() => _saving = true);
    try {
      if (_editId != null) {
        await context.read<WaterAutoRechargeCubit>().update(
              autoRechargeId: _editId!,
              amount: amount,
              frequency: _frequency,
              dayOfWeek: _dayOfWeek,
              dayOfMonth: _dayOfMonth,
              executionHour: _time.hour,
              executionMinute: _time.minute,
            );
      } else {
        await context.read<WaterAutoRechargeCubit>().create(
              beneficiaryId: _beneficiary!.id,
              amount: amount,
              currency: 'NGN',
              frequency: _frequency,
              dayOfWeek: _dayOfWeek,
              dayOfMonth: _dayOfMonth,
              executionHour: _time.hour,
              executionMinute: _time.minute,
            );
      }
      if (!mounted) return;
      Get.back(result: true);
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            error ? const Color(0xFFEF4444) : const Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaterAutoRechargeCubit, WaterAutoRechargeState>(
      listener: (context, state) {
        if (state is WaterAutoRechargeError && _saving) {
          setState(() => _saving = false);
          _snack(state.message, error: true);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
            onPressed: () => Get.back(),
          ),
          title: Text(_editId != null ? 'Edit Auto-Pay' : 'Create Auto-Pay',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Saved Account'),
                SizedBox(height: 8.h),
                _beneficiarySelector(),
                SizedBox(height: 16.h),
                _label('Amount (NGN)'),
                SizedBox(height: 8.h),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  decoration: InputDecoration(
                    hintText: 'e.g., 5000',
                    hintStyle: TextStyle(
                        color: const Color(0xFF4B5563), fontSize: 15.sp),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF4E03D0)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                  ),
                ),
                SizedBox(height: 16.h),
                _label('Frequency'),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _freqChip('daily', 'Daily'),
                    SizedBox(width: 8.w),
                    _freqChip('weekly', 'Weekly'),
                    SizedBox(width: 8.w),
                    _freqChip('monthly', 'Monthly'),
                  ],
                ),
                SizedBox(height: 16.h),
                if (_frequency == 'weekly') ...[
                  _label('Day of week'),
                  SizedBox(height: 8.h),
                  _dayOfWeekPicker(),
                  SizedBox(height: 16.h),
                ],
                if (_frequency == 'monthly') ...[
                  _label('Day of month'),
                  SizedBox(height: 8.h),
                  _dayOfMonthPicker(),
                  SizedBox(height: 16.h),
                ],
                _label('Execution time'),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                    if (picked != null) setState(() => _time = picked);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time,
                            color: const Color(0xFF10B981), size: 18.sp),
                        SizedBox(width: 10.w),
                        Text(_time.format(context),
                            style: TextStyle(
                                color: Colors.white, fontSize: 15.sp)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                      elevation: 0,
                    ),
                    child: _saving
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            _editId != null
                                ? 'Update Auto-Pay'
                                : 'Schedule Auto-Pay',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(t,
      style: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFF9CA3AF),
          fontWeight: FontWeight.w500));

  Widget _beneficiarySelector() {
    if (_locked && _beneficiary != null) {
      final b = _beneficiary!;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(Icons.lock_outline,
                color: const Color(0xFF6B7280), size: 16.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                '${b.nickname ?? b.accountNumber} \u00B7 ${b.providerName}',
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    return BlocBuilder<WaterBeneficiaryCubit, WaterBeneficiaryState>(
      buildWhen: (_, s) => s is WaterBeneficiariesLoaded,
      builder: (context, state) {
        if (state is! WaterBeneficiariesLoaded) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Color(0xFF10B981)),
                ),
              ),
            ),
          );
        }
        final list = state.beneficiaries;
        if (list.isEmpty) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text(
              'No saved accounts. Pay a water bill first and save the account to auto-pay it.',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<WaterBeneficiary>(
              isExpanded: true,
              value: _beneficiary,
              hint: Text('Select a saved account',
                  style: TextStyle(
                      color: const Color(0xFF4B5563), fontSize: 15.sp)),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF9CA3AF)),
              dropdownColor: const Color(0xFF1F1F1F),
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              items: list
                  .map((b) => DropdownMenuItem<WaterBeneficiary>(
                        value: b,
                        child: Text(
                          '${b.nickname ?? b.accountNumber} \u00B7 ${b.providerName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _beneficiary = v),
            ),
          ),
        );
      },
    );
  }

  Widget _freqChip(String value, String label) {
    final selected = _frequency == value;
    return GestureDetector(
      onTap: () => setState(() => _frequency = value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF10B981) : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: selected
                ? const Color(0xFF10B981)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : const Color(0xFF9CA3AF))),
      ),
    );
  }

  Widget _dayOfWeekPicker() => Row(
        children: List.generate(7, (i) {
          final day = i + 1;
          final selected = _dayOfWeek == day;
          const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _dayOfWeek = day),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2.w),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF10B981)
                      : const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: selected
                          ? const Color(0xFF10B981)
                          : const Color(0xFF2D2D2D)),
                ),
                child: Text(names[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            selected ? Colors.white : const Color(0xFF9CA3AF))),
              ),
            ),
          );
        }),
      );

  Widget _dayOfMonthPicker() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 1.2,
        ),
        itemCount: 31,
        itemBuilder: (_, i) {
          final day = i + 1;
          final selected = _dayOfMonth == day;
          return GestureDetector(
            onTap: () => setState(() => _dayOfMonth = day),
            child: Container(
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF10B981)
                    : const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: selected
                        ? const Color(0xFF10B981)
                        : const Color(0xFF2D2D2D)),
              ),
              child: Center(
                child: Text('$day',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            selected ? Colors.white : const Color(0xFF9CA3AF))),
              ),
            ),
          );
        },
      );
}
