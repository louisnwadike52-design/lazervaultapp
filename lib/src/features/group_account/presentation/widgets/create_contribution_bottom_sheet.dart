import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class CreateContributionBottomSheet extends StatefulWidget {
  final String groupId;
  final List<GroupMember> groupMembers;

  const CreateContributionBottomSheet({
    super.key,
    required this.groupId,
    required this.groupMembers,
  });

  @override
  State<CreateContributionBottomSheet> createState() => _CreateContributionBottomSheetState();
}

class _CreateContributionBottomSheetState extends State<CreateContributionBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _regularAmountController = TextEditingController();
  final _totalCyclesController = TextEditingController();
  final _penaltyAmountController = TextEditingController();
  final _gracePeriodController = TextEditingController();
  final _minimumBalanceController = TextEditingController();

  ContributionType _selectedType = ContributionType.oneTime;
  ContributionFrequency? _selectedFrequency;
  String _selectedCurrency = 'USD';
  DateTime _selectedDeadline = DateTime.now().add(const Duration(days: 30));
  DateTime? _selectedStartDate;
  bool _autoPayEnabled = false;
  bool _allowPartialPayments = true;
  List<String> _rotationOrder = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _rotationOrder = widget.groupMembers
        .where((m) => m.status == GroupMemberStatus.active)
        .map((m) => m.userId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1F1F1F),
            const Color(0xFF0A0A0A),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is GroupAccountContributionCreated) {
            Navigator.pop(context);
          } else if (state is GroupAccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is GroupAccountLoading;
          
          return Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFF2D2D2D),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: isLoading ? null : () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.close,
                          color: isLoading ? Colors.grey : Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Text(
                        'Create Contribution',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: isLoading ? null : _submitContribution,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isLoading ? Colors.grey : const Color(0xFF6C5CE7),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                'Create',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Contribution Type Selection
                        _buildSectionTitle('Contribution Type'),
                        SizedBox(height: 12.h),
                        _buildTypeSelector(),
                        
                        SizedBox(height: 24.h),
                        
                        // Basic Information
                        _buildSectionTitle('Basic Information'),
                        SizedBox(height: 12.h),
                        _buildBasicInfoFields(),
                        
                        if (_selectedType != ContributionType.oneTime) ...[
                          SizedBox(height: 24.h),
                          _buildSectionTitle('Schedule Settings'),
                          SizedBox(height: 12.h),
                          _buildScheduleFields(),
                        ],
                        
                        if (_selectedType == ContributionType.rotatingSavings) ...[
                          SizedBox(height: 24.h),
                          _buildSectionTitle('Payout Rotation'),
                          SizedBox(height: 12.h),
                          _buildRotationOrderWidget(),
                        ],
                        
                        SizedBox(height: 24.h),
                        _buildSectionTitle('Advanced Settings'),
                        SizedBox(height: 12.h),
                        _buildAdvancedSettings(),
                        
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Column(
      children: ContributionType.values.map((type) {
        final isSelected = _selectedType == type;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedType = type;
              if (type == ContributionType.oneTime) {
                _selectedFrequency = null;
                _autoPayEnabled = false;
              } else if (type == ContributionType.rotatingSavings) {
                _selectedFrequency = ContributionFrequency.monthly;
                _autoPayEnabled = false; // Manual payments for transparency
              }
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6C5CE7).withOpacity(0.2) : const Color(0xFF1F1F1F),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF666666),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      type.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  type.description,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBasicInfoFields() {
    return Column(
      children: [
        _buildTextField(
          controller: _titleController,
          label: 'Goal Title',
          hint: 'Enter contribution goal title',
          validator: (value) => value?.isEmpty == true ? 'Title is required' : null,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _descriptionController,
          label: 'Description',
          hint: 'Describe the purpose of this contribution',
          maxLines: 3,
          validator: (value) => value?.isEmpty == true ? 'Description is required' : null,
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: _targetAmountController,
                label: 'Target Amount',
                hint: '0.00',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty == true) return 'Amount is required';
                  if (double.tryParse(value!) == null) return 'Invalid amount';
                  return null;
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildCurrencyDropdown(),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildDatePicker(
          label: 'Target Date',
          selectedDate: _selectedDeadline,
          onDateSelected: (date) => setState(() => _selectedDeadline = date),
        ),
      ],
    );
  }

  Widget _buildScheduleFields() {
    return Column(
      children: [
        _buildFrequencyDropdown(),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _regularAmountController,
          label: 'Regular Payment Amount',
          hint: 'Amount each member should pay per cycle',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_selectedType != ContributionType.oneTime && (value?.isEmpty == true)) {
              return 'Regular amount is required for scheduled contributions';
            }
            if (value?.isNotEmpty == true && double.tryParse(value!) == null) {
              return 'Invalid amount';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildDatePicker(
                label: 'Start Date',
                selectedDate: _selectedStartDate ?? DateTime.now(),
                onDateSelected: (date) => setState(() => _selectedStartDate = date),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTextField(
                controller: _totalCyclesController,
                label: 'Total Cycles',
                hint: 'Number of payment cycles',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isNotEmpty == true && int.tryParse(value!) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRotationOrderWidget() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payout Order',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Drag to reorder who receives money when',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFF888888),
            ),
          ),
          SizedBox(height: 12.h),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _rotationOrder.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = _rotationOrder.removeAt(oldIndex);
                _rotationOrder.insert(newIndex, item);
              });
            },
            itemBuilder: (context, index) {
              final userId = _rotationOrder[index];
              final member = widget.groupMembers.firstWhere((m) => m.userId == userId);
              
              return Container(
                key: ValueKey(userId),
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.drag_handle, color: const Color(0xFF666666), size: 16.sp),
                    SizedBox(width: 12.w),
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: const Color(0xFF6C5CE7),
                      child: Text(
                        member.userName.isNotEmpty ? member.userName[0].toUpperCase() : 'U',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.userName,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Position ${index + 1}',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: const Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedSettings() {
    return Column(
      children: [
        _buildSwitchTile(
          title: 'Auto-Pay',
          subtitle: 'Automatically process payments when due',
          value: _autoPayEnabled,
          onChanged: (value) => setState(() => _autoPayEnabled = value),
        ),
        SizedBox(height: 16.h),
        _buildSwitchTile(
          title: 'Allow Partial Payments',
          subtitle: 'Members can pay less than the full amount',
          value: _allowPartialPayments,
          onChanged: (value) => setState(() => _allowPartialPayments = value),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _penaltyAmountController,
                label: 'Penalty Amount',
                hint: 'Penalty for late payments',
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTextField(
                controller: _gracePeriodController,
                label: 'Grace Period (Days)',
                hint: 'Days before penalty applies',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _minimumBalanceController,
          label: 'Minimum Balance for Payout',
          hint: 'Minimum amount needed before payout',
          keyboardType: TextInputType.number,
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
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF666666),
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF6C5CE7)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFE74C3C)),
            ),
            contentPadding: EdgeInsets.all(12.w),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Currency',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: _selectedCurrency,
          onChanged: (value) => setState(() => _selectedCurrency = value!),
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          dropdownColor: const Color(0xFF1F1F1F),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            contentPadding: EdgeInsets.all(12.w),
          ),
          items: ['USD', 'EUR', 'GBP', 'NGN', 'GHS', 'ZAR', 'KES'].map((currency) {
            return DropdownMenuItem(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFrequencyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Frequency',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<ContributionFrequency?>(
          value: _selectedFrequency,
          onChanged: (value) => setState(() => _selectedFrequency = value),
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          dropdownColor: const Color(0xFF1F1F1F),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            contentPadding: EdgeInsets.all(12.w),
          ),
          items: ContributionFrequency.values.map((frequency) {
            return DropdownMenuItem(
              value: frequency,
              child: Text(frequency.displayName),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xFF6C5CE7),
                      surface: Color(0xFF1F1F1F),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) {
              onDateSelected(date);
            }
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              border: Border.all(color: const Color(0xFF2D2D2D)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF666666),
                  size: 16.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  DateFormat('MMM dd, yyyy').format(selectedDate),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6C5CE7),
            trackColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected) 
                  ? const Color(0xFF6C5CE7).withOpacity(0.3)
                  : const Color(0xFF2D2D2D);
            }),
          ),
        ],
      ),
    );
  }

  void _submitContribution() {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<GroupAccountCubit>();
    
    final targetAmount = double.tryParse(_targetAmountController.text) ?? 0;

    cubit.createNewContribution(
      groupId: widget.groupId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      targetAmount: targetAmount,
      currency: _selectedCurrency,
      deadline: _selectedDeadline,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _regularAmountController.dispose();
    _totalCyclesController.dispose();
    _penaltyAmountController.dispose();
    _gracePeriodController.dispose();
    _minimumBalanceController.dispose();
    super.dispose();
  }
} 