import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class CreateAutoSaveRuleScreen extends StatefulWidget {
  const CreateAutoSaveRuleScreen({super.key});

  @override
  State<CreateAutoSaveRuleScreen> createState() => _CreateAutoSaveRuleScreenState();
}

class _CreateAutoSaveRuleScreenState extends State<CreateAutoSaveRuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _minimumBalanceController = TextEditingController();
  final _maximumPerSaveController = TextEditingController();
  final _roundUpToController = TextEditingController();

  TriggerType _selectedTriggerType = TriggerType.onDeposit;
  AmountType _selectedAmountType = AmountType.fixed;
  ScheduleFrequency? _selectedFrequency;
  String? _selectedSourceAccountId;
  String? _selectedDestinationAccountId;
  TimeOfDay? _selectedTime;
  int? _selectedDay;

  @override
  void initState() {
    super.initState();
    context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
          userId: 'current_user',
          accessToken: null,
        );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _targetAmountController.dispose();
    _minimumBalanceController.dispose();
    _maximumPerSaveController.dispose();
    _roundUpToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.05),
        title: Text(
          'Create Auto-Save Rule',
          style: GoogleFonts.inter(
            color: const Color(0xFF1A1D1F),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1D1F)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AutoSaveCubit, AutoSaveState>(
        listener: (context, state) {
          if (state is AutoSaveRuleCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Auto-save rule created successfully!',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                backgroundColor: const Color(0xFF00C853),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            );
            Navigator.pop(context);
          } else if (state is AutoSaveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                backgroundColor: const Color(0xFFFF6B6B),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Rule Name',
                  hint: 'e.g., Save on Paycheck',
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Describe your savings goal',
                  maxLines: 3,
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter a description' : null,
                ),
                SizedBox(height: 24.h),
                _buildSectionHeader('Trigger Settings', Icons.alarm),
                SizedBox(height: 12.h),
                _buildTriggerTypeSelector(),
                if (_selectedTriggerType == TriggerType.scheduled) ...[
                  SizedBox(height: 16.h),
                  _buildFrequencySelector(),
                  if (_selectedFrequency != null) ...[
                    SizedBox(height: 16.h),
                    _buildTimeSelector(),
                  ],
                ],
                if (_selectedTriggerType == TriggerType.roundUp) ...[
                  SizedBox(height: 16.h),
                  _buildTextField(
                    controller: _roundUpToController,
                    label: 'Round Up To',
                    hint: 'e.g., 10',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (_selectedTriggerType == TriggerType.roundUp && (value?.isEmpty ?? true)) {
                        return 'Please enter round up amount';
                      }
                      return null;
                    },
                  ),
                ],
                SizedBox(height: 24.h),
                _buildSectionHeader('Amount Settings', Icons.attach_money),
                SizedBox(height: 12.h),
                _buildAmountTypeSelector(),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _amountController,
                  label: _selectedAmountType == AmountType.fixed ? 'Amount (\$)' : 'Percentage (%)',
                  hint: _selectedAmountType == AmountType.fixed ? '50.00' : '10',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) return 'Please enter an amount';
                    final amount = double.tryParse(value!);
                    if (amount == null || amount <= 0) return 'Please enter a valid amount';
                    if (_selectedAmountType == AmountType.percentage && amount > 100) {
                      return 'Percentage cannot exceed 100';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                _buildSectionHeader('Account Selection', Icons.account_balance_wallet),
                SizedBox(height: 12.h),
                _buildAccountSelector(),
                SizedBox(height: 24.h),
                _buildSectionHeader('Optional Limits', Icons.flag),
                SizedBox(height: 12.h),
                _buildTextField(
                  controller: _targetAmountController,
                  label: 'Target Amount (Optional)',
                  hint: 'e.g., 1000.00',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _minimumBalanceController,
                  label: 'Minimum Balance (Optional)',
                  hint: 'e.g., 100.00',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  controller: _maximumPerSaveController,
                  label: 'Maximum Per Save (Optional)',
                  hint: 'e.g., 500.00',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 32.h),
                BlocBuilder<AutoSaveCubit, AutoSaveState>(
                  builder: (context, state) {
                    final isLoading = state is AutoSaveLoading;
                    return Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C853), Color(0xFF00A843)],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00C853).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: isLoading ? null : _createRule,
                          child: Center(
                            child: isLoading
                                ? SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.check_circle, color: Colors.white),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Create Auto-Save Rule',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF2A85FF), size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFF1A1D1F),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF6F767E),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            validator: validator,
            style: GoogleFonts.inter(
              color: const Color(0xFF1A1D1F),
              fontSize: 15.sp,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9A9FA5),
                fontSize: 15.sp,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFF2A85FF), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTriggerTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How would you like to save?',
          style: GoogleFonts.inter(
            color: const Color(0xFF6F767E),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _buildTriggerCard('On Deposit', TriggerType.onDeposit, Icons.arrow_downward)),
            SizedBox(width: 12.w),
            Expanded(child: _buildTriggerCard('Scheduled', TriggerType.scheduled, Icons.schedule)),
            SizedBox(width: 12.w),
            Expanded(child: _buildTriggerCard('Round Up', TriggerType.roundUp, Icons.trending_up)),
          ],
        ),
      ],
    );
  }

  Widget _buildTriggerCard(String label, TriggerType type, IconData icon) {
    final isSelected = _selectedTriggerType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedTriggerType = type),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A85FF).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2A85FF) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2A85FF) : const Color(0xFF6F767E),
              size: 28.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? const Color(0xFF2A85FF) : const Color(0xFF6F767E),
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: RadioListTile<AmountType>(
              title: Text(
                'Fixed Amount',
                style: GoogleFonts.inter(
                  color: const Color(0xFF1A1D1F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: AmountType.fixed,
              groupValue: _selectedAmountType,
              onChanged: (value) => setState(() => _selectedAmountType = value!),
              activeColor: const Color(0xFF2A85FF),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: RadioListTile<AmountType>(
              title: Text(
                'Percentage',
                style: GoogleFonts.inter(
                  color: const Color(0xFF1A1D1F),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: AmountType.percentage,
              groupValue: _selectedAmountType,
              onChanged: (value) => setState(() => _selectedAmountType = value!),
              activeColor: const Color(0xFF2A85FF),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How often?',
          style: GoogleFonts.inter(
            color: const Color(0xFF6F767E),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 2.5,
          children: [
            _buildFrequencyChip('Daily', ScheduleFrequency.daily),
            _buildFrequencyChip('Weekly', ScheduleFrequency.weekly),
            _buildFrequencyChip('Bi-Weekly', ScheduleFrequency.biweekly),
            _buildFrequencyChip('Monthly', ScheduleFrequency.monthly),
          ],
        ),
      ],
    );
  }

  Widget _buildFrequencyChip(String label, ScheduleFrequency freq) {
    final isSelected = _selectedFrequency == freq;
    return GestureDetector(
      onTap: () => setState(() => _selectedFrequency = isSelected ? null : freq),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A85FF).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2A85FF) : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isSelected ? const Color(0xFF2A85FF) : const Color(0xFF6F767E),
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _selectedTime ?? TimeOfDay.now(),
        );
        if (time != null) {
          setState(() => _selectedTime = time);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTime == null
                  ? 'Select Time'
                  : '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}',
              style: GoogleFonts.inter(
                color: _selectedTime == null ? const Color(0xFF9A9FA5) : const Color(0xFF1A1D1F),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.access_time,
              color: const Color(0xFF2A85FF),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoaded) {
          final allAccounts = state.accountSummaries;

          // Filter savings accounts for destination
          final savingsAccounts = allAccounts.where((a) =>
            a.accountType.toLowerCase().contains('saving') ||
            a.accountType.toLowerCase().contains('money market')
          ).toList();

          // Set default destination to first savings account
          if (_selectedDestinationAccountId == null && savingsAccounts.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _selectedDestinationAccountId = savingsAccounts.first.id.toString();
              });
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAccountDropdown(
                label: 'Source Account',
                hint: 'Select account to save from',
                value: _selectedSourceAccountId,
                accounts: allAccounts.map((a) => {
                  'id': a.id.toString(),
                  'name': '${a.accountType} (****${a.accountNumberLast4})'
                }).toList(),
                onChanged: (value) => setState(() => _selectedSourceAccountId = value),
              ),
              SizedBox(height: 16.h),
              _buildAccountDropdown(
                label: 'Destination Account',
                hint: 'Select savings account',
                value: _selectedDestinationAccountId,
                accounts: savingsAccounts.map((a) => {
                  'id': a.id.toString(),
                  'name': '${a.accountType} (****${a.accountNumberLast4})'
                }).toList(),
                onChanged: (value) => setState(() => _selectedDestinationAccountId = value),
                showSavingsBadge: true,
              ),
            ],
          );
        }
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2A85FF)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccountDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<Map<String, String>> accounts,
    required Function(String?) onChanged,
    bool showSavingsBadge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF6F767E),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showSavingsBadge) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Savings',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF00C853),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9A9FA5),
                  fontSize: 15.sp,
                ),
              ),
              dropdownColor: Colors.white,
              style: GoogleFonts.inter(
                color: const Color(0xFF1A1D1F),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              items: accounts.map((account) {
                return DropdownMenuItem<String>(
                  value: account['id'],
                  child: Text(account['name']!),
                );
              }).toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF2A85FF)),
            ),
          ),
        ),
      ],
    );
  }

  void _createRule() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedSourceAccountId == null || _selectedDestinationAccountId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select both source and destination accounts',
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFFFF6B6B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }

    if (_selectedTriggerType == TriggerType.scheduled && _selectedFrequency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a frequency for scheduled savings',
            style: GoogleFonts.inter(fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFFFF6B6B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }

    final scheduleTime = _selectedTime != null
        ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
        : null;

    // Call the cubit to create the rule with backend integration
    context.read<AutoSaveCubit>().createRule(
          name: _nameController.text,
          description: _descriptionController.text,
          triggerType: _selectedTriggerType,
          amountType: _selectedAmountType,
          amountValue: double.parse(_amountController.text),
          sourceAccountId: _selectedSourceAccountId!,
          destinationAccountId: _selectedDestinationAccountId!,
          frequency: _selectedFrequency,
          scheduleTime: scheduleTime,
          scheduleDay: _selectedDay,
          roundUpTo: _roundUpToController.text.isEmpty ? null : int.parse(_roundUpToController.text),
          targetAmount: _targetAmountController.text.isEmpty ? null : double.parse(_targetAmountController.text),
          minimumBalance: _minimumBalanceController.text.isEmpty ? null : double.parse(_minimumBalanceController.text),
          maximumPerSave: _maximumPerSaveController.text.isEmpty ? null : double.parse(_maximumPerSaveController.text),
        );
  }
}
