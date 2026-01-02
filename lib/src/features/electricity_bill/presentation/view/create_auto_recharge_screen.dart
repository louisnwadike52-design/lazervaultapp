import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/extensions/meter_type_extension.dart';
import '../cubit/beneficiary_cubit.dart';
import '../cubit/beneficiary_state.dart';
import '../cubit/auto_recharge_cubit.dart';
import '../cubit/auto_recharge_state.dart';

class CreateAutoRechargeScreen extends StatefulWidget {
  const CreateAutoRechargeScreen({super.key});

  @override
  State<CreateAutoRechargeScreen> createState() => _CreateAutoRechargeScreenState();
}

class _CreateAutoRechargeScreenState extends State<CreateAutoRechargeScreen> {
  final TextEditingController _amountController = TextEditingController();

  BillBeneficiaryEntity? _selectedBeneficiary;
  RechargeFrequency _selectedFrequency = RechargeFrequency.monthly;
  int _selectedDayOfWeek = 1; // Monday
  int _selectedDayOfMonth = 1;

  @override
  void initState() {
    super.initState();
    context.read<BeneficiaryCubit>().getBeneficiaries();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _createAutoRecharge() {
    if (_selectedBeneficiary == null) {
      Get.snackbar(
        'Error',
        'Please select a beneficiary',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter an amount',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Error',
        'Please enter a valid amount',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }

    context.read<AutoRechargeCubit>().createAutoRecharge(
          beneficiaryId: _selectedBeneficiary!.id,
          amount: amount,
          currency: 'NGN',
          frequency: _selectedFrequency,
          dayOfWeek: _selectedFrequency == RechargeFrequency.weekly ? _selectedDayOfWeek : null,
          dayOfMonth: _selectedFrequency == RechargeFrequency.monthly ? _selectedDayOfMonth : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocListener<AutoRechargeCubit, AutoRechargeState>(
                  listener: (context, state) {
                    if (state is AutoRechargeCreated) {
                      Get.snackbar(
                        'Success',
                        state.message,
                        backgroundColor: Colors.green.withOpacity(0.9),
                        colorText: Colors.white,
                      );
                      Get.back();
                    }

                    if (state is AutoRechargeError) {
                      Get.snackbar(
                        'Error',
                        state.message,
                        backgroundColor: Colors.red.withOpacity(0.9),
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBeneficiarySelector(),
                        SizedBox(height: 24.h),
                        _buildAmountInput(),
                        SizedBox(height: 24.h),
                        _buildFrequencySelector(),
                        SizedBox(height: 24.h),
                        if (_selectedFrequency == RechargeFrequency.weekly)
                          _buildDayOfWeekSelector(),
                        if (_selectedFrequency == RechargeFrequency.monthly)
                          _buildDayOfMonthSelector(),
                        if (_selectedFrequency != RechargeFrequency.daily)
                          SizedBox(height: 24.h),
                        _buildSummary(),
                        SizedBox(height: 32.h),
                        _buildCreateButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Auto-Recharge',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Set up automatic payments',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiarySelector() {
    return BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        if (state is BeneficiariesLoaded) {
          if (state.beneficiaries.isEmpty) {
            return Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.white.withOpacity(0.3),
                    size: 48.sp,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'No beneficiaries found',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Please add a beneficiary first',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Beneficiary',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<BillBeneficiaryEntity>(
                    value: _selectedBeneficiary,
                    hint: Text(
                      'Choose a beneficiary',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 14.sp,
                      ),
                    ),
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1A1A3E),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    items: state.beneficiaries.map((beneficiary) {
                      return DropdownMenuItem(
                        value: beneficiary,
                        child: Text(
                          beneficiary.displayName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBeneficiary = value;
                      });
                    },
                  ),
                ),
              ),
              if (_selectedBeneficiary != null) ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFF4E03D0).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: const Color(0xFF4E03D0),
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              _selectedBeneficiary!.customerName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.numbers,
                            color: Colors.white.withOpacity(0.6),
                            size: 14.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            _selectedBeneficiary!.meterNumber,
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4E03D0).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              _selectedBeneficiary!.meterType.displayName,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF4E03D0),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
        );
      },
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recharge Amount',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.3),
                fontSize: 24.sp,
              ),
              border: InputBorder.none,
              prefix: Text(
                '₦ ',
                style: GoogleFonts.inter(
                  color: const Color(0xFF4E03D0),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFrequencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recharge Frequency',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildFrequencyOption('Daily', RechargeFrequency.daily, Icons.today),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildFrequencyOption('Weekly', RechargeFrequency.weekly, Icons.calendar_view_week),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _buildFrequencyOption('Monthly', RechargeFrequency.monthly, Icons.calendar_month),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFrequencyOption(String label, RechargeFrequency frequency, IconData icon) {
    final isSelected = _selectedFrequency == frequency;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFrequency = frequency;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4E03D0).withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.1),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.6),
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.8),
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayOfWeekSelector() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Day of Week',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: List.generate(7, (index) {
            final dayNumber = index + 1;
            final isSelected = _selectedDayOfWeek == dayNumber;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDayOfWeek = dayNumber;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: index < 6 ? 4.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4E03D0).withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    days[index],
                    style: GoogleFonts.inter(
                      color: isSelected ? const Color(0xFF4E03D0) : Colors.white.withOpacity(0.8),
                      fontSize: 10.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDayOfMonthSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Day of Month',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: _selectedDayOfMonth,
              isExpanded: true,
              dropdownColor: const Color(0xFF1A1A3E),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.6),
              ),
              items: List.generate(28, (index) {
                final day = index + 1;
                return DropdownMenuItem(
                  value: day,
                  child: Text(
                    'Day $day${_getDaySuffix(day)} of every month',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                );
              }),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedDayOfMonth = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Widget _buildSummary() {
    String frequencyText = '';
    switch (_selectedFrequency) {
      case RechargeFrequency.daily:
        frequencyText = 'Every day';
        break;
      case RechargeFrequency.weekly:
        final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        frequencyText = 'Every ${days[_selectedDayOfWeek - 1]}';
        break;
      case RechargeFrequency.monthly:
        frequencyText = 'On day $_selectedDayOfMonth${_getDaySuffix(_selectedDayOfMonth)} of every month';
        break;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF4E03D0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color(0xFF4E03D0),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Summary',
                style: GoogleFonts.inter(
                  color: const Color(0xFF4E03D0),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Your account will be automatically recharged:',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            frequencyText,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (_selectedBeneficiary != null && _amountController.text.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              'Amount: ₦${_amountController.text}',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return BlocBuilder<AutoRechargeCubit, AutoRechargeState>(
      builder: (context, state) {
        final isLoading = state is AutoRechargeCreating;

        return GestureDetector(
          onTap: isLoading ? null : _createAutoRecharge,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4E03D0),
                  const Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Text(
                    'Create Auto-Recharge',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
        );
      },
    );
  }
}
