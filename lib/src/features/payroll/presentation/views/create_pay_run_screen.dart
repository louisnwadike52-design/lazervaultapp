import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/employee_entity.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/widgets/entity_create_sheet.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

class CreatePayRunScreen extends StatefulWidget {
  const CreatePayRunScreen({super.key});

  @override
  State<CreatePayRunScreen> createState() => _CreatePayRunScreenState();
}

class _CreatePayRunScreenState extends State<CreatePayRunScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  final _nameController = TextEditingController();

  // Employee selection
  List<EmployeeEntity> _employees = [];
  final Set<String> _selectedEmployeeIds = {};
  bool _selectAll = true;
  bool _employeesLoaded = false;

  // Recurring options
  bool _isRecurring = false;
  int _recurrenceFrequency = 0; // 0=none, 1=weekly, 2=biweekly, 3=monthly
  bool _autoApprove = false;

  static const _frequencyLabels = ['None', 'Weekly', 'Bi-Weekly', 'Monthly'];

  @override
  void initState() {
    super.initState();
    // Fetch employees for selection
    context.read<PayrollCubit>().listEmployees();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: InvoiceThemeColors.primaryPurple,
              surface: InvoiceThemeColors.secondaryBackground,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate == null || _endDate!.isBefore(picked)) {
          _endDate = DateTime(picked.year, picked.month + 1, 0);
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: InvoiceThemeColors.primaryPurple,
              surface: InvoiceThemeColors.secondaryBackground,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Only PAYABLE employees (linked user or bank account) can be in a pay run —
  // adding an un-payable one would fail the run at calculate/process time.
  int get _payableCount => _employees.where((e) => e.isPayable).length;

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _selectedEmployeeIds
          ..clear()
          ..addAll(_employees.where((e) => e.isPayable).map((e) => e.id));
      } else {
        _selectedEmployeeIds.clear();
      }
    });
  }

  void _toggleEmployee(String id) {
    setState(() {
      if (_selectedEmployeeIds.contains(id)) {
        _selectedEmployeeIds.remove(id);
      } else {
        _selectedEmployeeIds.add(id);
      }
      _selectAll = _payableCount > 0 && _selectedEmployeeIds.length == _payableCount;
    });
  }

  void _snackNotPayable(String name, String issue) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '$name can\'t be paid yet — $issue. Set up their payout in Employees first.'),
        backgroundColor: InvoiceThemeColors.warningOrange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Run the full add-employee flow in a bottom sheet; on create, prepend the
  /// new employee to the list and pre-select them for this pay run.
  Future<void> _createAndSelectEmployee() async {
    final created = await showCreateEmployeeSheet(context);
    if (created == null || !mounted) return;
    setState(() {
      _employees = [created, ..._employees];
      _selectedEmployeeIds.add(created.id);
      _selectAll = _selectedEmployeeIds.length == _employees.length;
      _employeesLoaded = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${created.fullName} added and selected'),
        backgroundColor: InvoiceThemeColors.successGreen,
      ),
    );
  }

  void _createPayRun() {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select both start and end dates',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: InvoiceThemeColors.errorRed,
        ),
      );
      return;
    }

    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'End date must be after start date',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: InvoiceThemeColors.errorRed,
        ),
      );
      return;
    }

    if (!_selectAll && _selectedEmployeeIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select at least one employee',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: InvoiceThemeColors.errorRed,
        ),
      );
      return;
    }

    if (_isRecurring && _recurrenceFrequency == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a recurrence frequency',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: InvoiceThemeColors.errorRed,
        ),
      );
      return;
    }

    // If selectAll, pass empty list (backend uses all active employees)
    final employeeIds = _selectAll ? <String>[] : _selectedEmployeeIds.toList();

    context.read<PayrollCubit>().createPayRun(
          start: _formatDate(_startDate!),
          end: _formatDate(_endDate!),
          name: _nameController.text.trim(),
          employeeIds: employeeIds,
          isRecurring: _isRecurring,
          recurrenceFrequency: _isRecurring ? _recurrenceFrequency : 0,
          autoApprove: _autoApprove,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is PayRunCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: InvoiceThemeColors.successGreen,
            ),
          );
          Navigator.of(context).pop();
        } else if (state is EmployeesLoaded && !_employeesLoaded) {
          setState(() {
            _employees = state.employees;
            _selectedEmployeeIds
              ..clear()
              ..addAll(state.employees.map((e) => e.id));
            _selectAll = true;
            _employeesLoaded = true;
          });
        } else if (state is PayrollError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: InvoiceThemeColors.errorRed,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading =
            state is PayrollLoading && _employeesLoaded;

        return Scaffold(
          backgroundColor: InvoiceThemeColors.primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Create Pay Run',
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 24.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header info card
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: InvoiceThemeColors.primaryPurple
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: InvoiceThemeColors.primaryPurple
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: InvoiceThemeColors.primaryPurpleLight,
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  'Configure the pay period, select employees, and set scheduling options.',
                                  style: GoogleFonts.inter(
                                    color: InvoiceThemeColors.primaryPurpleLight,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Pay Run Name
                        Text(
                          'Pay Run Name (optional)',
                          style: GoogleFonts.inter(
                            color: InvoiceThemeColors.textGray400,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: _nameController,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. January 2026 Salary',
                            hintStyle: GoogleFonts.inter(
                              color: InvoiceThemeColors.textGray500,
                              fontSize: 15.sp,
                            ),
                            prefixIcon: Icon(
                              Icons.label_outline,
                              color: InvoiceThemeColors.textGray400,
                              size: 20.sp,
                            ),
                            filled: true,
                            fillColor: InvoiceThemeColors.secondaryBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Start Date
                        Text(
                          'Pay Period Start',
                          style: GoogleFonts.inter(
                            color: InvoiceThemeColors.textGray400,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildDatePicker(
                          value: _startDate,
                          placeholder: 'Select start date',
                          onTap: _pickStartDate,
                        ),
                        SizedBox(height: 20.h),

                        // End Date
                        Text(
                          'Pay Period End',
                          style: GoogleFonts.inter(
                            color: InvoiceThemeColors.textGray400,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _buildDatePicker(
                          value: _endDate,
                          placeholder: 'Select end date',
                          onTap: _pickEndDate,
                        ),
                        SizedBox(height: 24.h),

                        // Employee Selection
                        _buildEmployeeSelection(),
                        SizedBox(height: 24.h),

                        // Recurring Toggle
                        _buildRecurringSection(),
                        SizedBox(height: 24.h),

                        // Summary
                        if (_startDate != null && _endDate != null)
                          _buildSummaryCard(),
                      ],
                    ),
                  ),
                ),

                // Bottom action
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: const BoxDecoration(
                    color: InvoiceThemeColors.primaryBackground,
                    border: Border(
                      top: BorderSide(color: InvoiceThemeColors.borderColor),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _createPayRun,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InvoiceThemeColors.primaryPurple,
                        disabledBackgroundColor:
                            InvoiceThemeColors.primaryPurple.withValues(alpha: 0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? LazerVaultLoader(size: 22)
                          : Text(
                              'Create Pay Run',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Date Picker
  // ---------------------------------------------------------------------------

  Widget _buildDatePicker({
    required DateTime? value,
    required String placeholder,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: value != null
                ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.5)
                : InvoiceThemeColors.borderColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: value != null
                  ? InvoiceThemeColors.primaryPurpleLight
                  : InvoiceThemeColors.textGray400,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              value != null ? _formatDate(value) : placeholder,
              style: GoogleFonts.inter(
                color: value != null ? Colors.white : InvoiceThemeColors.textGray500,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: InvoiceThemeColors.textGray500,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Employee Selection
  // ---------------------------------------------------------------------------

  Widget _buildEmployeeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Employees',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: _toggleSelectAll,
              child: Text(
                _selectAll ? 'Deselect All' : 'Select All',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.primaryPurpleLight,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          '${_selectedEmployeeIds.length} of ${_employees.length} selected',
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 12.h),
        // Add a brand-new employee inline (runs the full add-employee flow in a
        // sheet, then selects the result for this pay run).
        InkWell(
          onTap: _createAndSelectEmployee,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.person_add_alt_1_rounded,
                    color: InvoiceThemeColors.primaryPurpleLight, size: 20.sp),
                SizedBox(width: 10.w),
                Text(
                  'Add employee',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.primaryPurpleLight,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.h),
        if (_employees.isEmpty && !_employeesLoaded)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: LazerVaultLoader.small(),
            ),
          )
        else if (_employees.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'No employees found. Add employees first.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray500,
                fontSize: 13.sp,
              ),
            ),
          )
        else
          Container(
            constraints: BoxConstraints(maxHeight: 200.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 4.h),
              itemCount: _employees.length,
              separatorBuilder: (_, __) => Divider(
                color: InvoiceThemeColors.borderColor,
                height: 1,
                indent: 50.w,
              ),
              itemBuilder: (context, index) {
                final emp = _employees[index];
                final isSelected = _selectedEmployeeIds.contains(emp.id);
                final issue = emp.payoutIssue; // null = payable
                return InkWell(
                  // Un-payable employees (no linked user AND no bank account) can't
                  // be added — the pay run would fail for them. Tap explains why +
                  // points to Employees to fix. Mirrors the backend calculate gate.
                  onTap: () {
                    if (issue != null) {
                      _snackNotPayable(emp.fullName, issue);
                      return;
                    }
                    _toggleEmployee(emp.id);
                  },
                  child: Opacity(
                    opacity: issue != null ? 0.6 : 1.0,
                    child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? InvoiceThemeColors.primaryPurple
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                              color: issue != null
                                  ? InvoiceThemeColors.warningOrange
                                  : isSelected
                                      ? InvoiceThemeColors.primaryPurpleLight
                                      : InvoiceThemeColors.textGray500,
                              width: 1.5,
                            ),
                          ),
                          child: issue != null
                              ? Icon(Icons.priority_high,
                                  color: InvoiceThemeColors.warningOrange,
                                  size: 15.sp)
                              : isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16.sp,
                                    )
                                  : null,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                emp.fullName,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (issue != null)
                                Text(
                                  '$issue — set up payout to pay',
                                  style: GoogleFonts.inter(
                                    color: InvoiceThemeColors.warningOrange,
                                    fontSize: 11.5.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else if (emp.department.isNotEmpty)
                                Text(
                                  emp.department,
                                  style: GoogleFonts.inter(
                                    color: InvoiceThemeColors.textGray400,
                                    fontSize: 12.sp,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Text(
                          emp.formattedPayRate,
                          style: GoogleFonts.inter(
                            color: InvoiceThemeColors.textGray400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Recurring Section
  // ---------------------------------------------------------------------------

  Widget _buildRecurringSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recurring Pay Run',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: _isRecurring,
                onChanged: (v) => setState(() => _isRecurring = v),
                activeThumbColor: InvoiceThemeColors.primaryPurple,
              ),
            ],
          ),
          if (_isRecurring) ...[
            SizedBox(height: 12.h),
            Text(
              'Frequency',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: List.generate(3, (index) {
                final value = index + 1; // 1=weekly, 2=biweekly, 3=monthly
                final isSelected = _recurrenceFrequency == value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _recurrenceFrequency = value),
                    child: Container(
                      margin: EdgeInsets.only(right: index < 2 ? 8.w : 0),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? InvoiceThemeColors.primaryPurple
                                .withValues(alpha: 0.2)
                            : InvoiceThemeColors.borderColor,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? InvoiceThemeColors.primaryPurpleLight
                              : InvoiceThemeColors.borderColor,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _frequencyLabels[value],
                          style: GoogleFonts.inter(
                            color: isSelected
                                ? InvoiceThemeColors.primaryPurpleLight
                                : InvoiceThemeColors.textGray400,
                            fontSize: 13.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Auto-approve',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray400,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: _autoApprove,
                  onChanged: (v) => setState(() => _autoApprove = v),
                  activeThumbColor: InvoiceThemeColors.primaryPurple,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Summary
  // ---------------------------------------------------------------------------

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          if (_nameController.text.trim().isNotEmpty)
            _buildSummaryRow('Name', _nameController.text.trim()),
          _buildSummaryRow(
            'Period',
            '${_formatDate(_startDate!)} to ${_formatDate(_endDate!)}',
          ),
          _buildSummaryRow(
            'Duration',
            '${_endDate!.difference(_startDate!).inDays + 1} days',
          ),
          _buildSummaryRow(
            'Employees',
            _selectAll
                ? 'All (${_employees.length})'
                : '${_selectedEmployeeIds.length} selected',
          ),
          if (_isRecurring)
            _buildSummaryRow(
              'Recurring',
              _frequencyLabels[_recurrenceFrequency],
            ),
          _buildSummaryRow('Status', 'Draft (after creation)'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
