import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class EditContributionScreen extends StatefulWidget {
  final Contribution contribution;

  const EditContributionScreen({
    super.key,
    required this.contribution,
  });

  @override
  State<EditContributionScreen> createState() => _EditContributionScreenState();
}

class _EditContributionScreenState extends State<EditContributionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _targetAmountController;
  late TextEditingController _regularAmountController;
  late DateTime _deadline;
  late ContributionStatus _selectedStatus;
  late bool _autoPayEnabled;
  late bool _allowPartialPayments;
  late TextEditingController _gracePeriodController;
  late TextEditingController _penaltyAmountController;

  bool _isLoading = false;
  bool _hasChanges = false;
  bool _hasPayments = false;

  @override
  void initState() {
    super.initState();
    final c = widget.contribution;

    _titleController = TextEditingController(text: c.title);
    _descriptionController = TextEditingController(text: c.description);
    _targetAmountController = TextEditingController(text: (c.targetAmount / 100).toStringAsFixed(0));
    _regularAmountController = TextEditingController(
      text: c.regularAmount != null ? (c.regularAmount! / 100).toStringAsFixed(0) : '',
    );
    _deadline = c.deadline;
    _selectedStatus = c.status;
    _autoPayEnabled = c.autoPayEnabled;
    _allowPartialPayments = c.allowPartialPayments;
    _gracePeriodController = TextEditingController(
      text: c.gracePeriodDays?.toString() ?? '0',
    );
    _penaltyAmountController = TextEditingController(
      text: c.penaltyAmount != null ? (c.penaltyAmount! / 100).toStringAsFixed(0) : '0',
    );

    _hasPayments = c.currentAmount > 0;

    _titleController.addListener(_onFieldChanged);
    _descriptionController.addListener(_onFieldChanged);
    _targetAmountController.addListener(_onFieldChanged);
    _regularAmountController.addListener(_onFieldChanged);
    _gracePeriodController.addListener(_onFieldChanged);
    _penaltyAmountController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _regularAmountController.dispose();
    _gracePeriodController.dispose();
    _penaltyAmountController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    final c = widget.contribution;
    final hasChanges = _titleController.text != c.title ||
        _descriptionController.text != c.description ||
        _deadline != c.deadline ||
        _selectedStatus != c.status ||
        _autoPayEnabled != c.autoPayEnabled ||
        _allowPartialPayments != c.allowPartialPayments;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => _handleBack(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Edit Contribution',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_hasChanges)
            TextButton(
              onPressed: _isLoading ? null : _saveChanges,
              child: Text(
                'Save',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 78, 3, 208),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: BlocListener<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is GroupAccountLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is GroupAccountSuccess) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Contribution updated successfully'),
                backgroundColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Get.back(result: true);
          } else if (state is GroupAccountError) {
            setState(() {
              _isLoading = false;
            });
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTypeIndicator(),
                  SizedBox(height: 24.h),
                  _buildTitleField(),
                  SizedBox(height: 20.h),
                  _buildDescriptionField(),
                  SizedBox(height: 20.h),
                  _buildTargetAmountField(),
                  SizedBox(height: 20.h),
                  _buildDeadlineField(),
                  SizedBox(height: 20.h),
                  _buildStatusSelector(),
                  SizedBox(height: 24.h),
                  _buildSettingsSection(),
                  SizedBox(height: 32.h),
                  _buildSaveButton(),
                  if (_canDelete()) ...[
                    SizedBox(height: 16.h),
                    _buildDeleteButton(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIndicator() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              _getTypeIcon(widget.contribution.type),
              color: const Color.fromARGB(255, 78, 3, 208),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTypeLabel(widget.contribution.type),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Contribution type cannot be changed',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _titleController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: _inputDecoration('Enter contribution title'),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _descriptionController,
          style: GoogleFonts.inter(color: Colors.white),
          maxLines: 3,
          decoration: _inputDecoration('Describe this contribution'),
        ),
      ],
    );
  }

  Widget _buildTargetAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Target Amount',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_hasPayments) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Locked',
                  style: GoogleFonts.inter(
                    color: Colors.orange,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _targetAmountController,
          style: GoogleFonts.inter(color: Colors.white),
          enabled: !_hasPayments,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: _inputDecoration(
            'Enter target amount',
            prefixText: '\u20A6 ',
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter target amount';
            }
            if (int.tryParse(value) == null || int.parse(value) <= 0) {
              return 'Please enter a valid amount';
            }
            return null;
          },
        ),
        if (_hasPayments)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              'Target amount cannot be changed after payments have been made',
              style: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 12.sp,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDeadlineField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deadline',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: _selectDeadline,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.grey[400],
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  DateFormat('MMMM d, yyyy').format(_deadline),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              ContributionStatus.active,
              ContributionStatus.paused,
              ContributionStatus.completed,
            ].map((status) {
              final isSelected = _selectedStatus == status;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedStatus = status;
                  });
                  _onFieldChanged();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: status != ContributionStatus.completed
                          ? BorderSide(color: Colors.grey[800]!, width: 0.5)
                          : BorderSide.none,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          _getStatusLabel(status),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: const Color.fromARGB(255, 78, 3, 208),
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              _buildSettingToggle(
                title: 'Auto Pay',
                subtitle: 'Automatically debit members on payment dates',
                value: _autoPayEnabled,
                onChanged: (value) {
                  setState(() {
                    _autoPayEnabled = value;
                  });
                  _onFieldChanged();
                },
              ),
              Divider(color: Colors.grey[800], height: 1),
              _buildSettingToggle(
                title: 'Allow Partial Payments',
                subtitle: 'Members can pay less than the required amount',
                value: _allowPartialPayments,
                onChanged: (value) {
                  setState(() {
                    _allowPartialPayments = value;
                  });
                  _onFieldChanged();
                },
              ),
              Divider(color: Colors.grey[800], height: 1),
              _buildSettingInput(
                title: 'Grace Period (Days)',
                controller: _gracePeriodController,
                keyboardType: TextInputType.number,
              ),
              Divider(color: Colors.grey[800], height: 1),
              _buildSettingInput(
                title: 'Late Payment Penalty',
                controller: _penaltyAmountController,
                keyboardType: TextInputType.number,
                prefix: '\u20A6 ',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color.fromARGB(255, 78, 3, 208),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingInput({
    required String title,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? prefix,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 100.w,
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              keyboardType: keyboardType,
              inputFormatters: keyboardType == TextInputType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixText: prefix,
                prefixStyle: GoogleFonts.inter(color: Colors.grey[400]),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _hasChanges && !_isLoading ? _saveChanges : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 78, 3, 208),
          disabledBackgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Save Changes',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _showDeleteConfirmation,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFEF4444),
          side: const BorderSide(color: Color(0xFFEF4444)),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Delete Contribution',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {String? prefixText}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
      prefixText: prefixText,
      prefixStyle: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 78, 3, 208),
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
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );
  }

  IconData _getTypeIcon(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return Icons.flag;
      case ContributionType.rotatingSavings:
        return Icons.autorenew;
      case ContributionType.investmentPool:
        return Icons.trending_up;
      case ContributionType.recurringGoal:
        return Icons.repeat;
    }
  }

  String _getTypeLabel(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return 'One-Time Goal';
      case ContributionType.rotatingSavings:
        return 'Rotating Savings (Ajo)';
      case ContributionType.investmentPool:
        return 'Investment Pool';
      case ContributionType.recurringGoal:
        return 'Recurring Goal';
    }
  }

  Color _getStatusColor(ContributionStatus status) {
    switch (status) {
      case ContributionStatus.active:
        return const Color(0xFF10B981);
      case ContributionStatus.paused:
        return const Color(0xFFFB923C);
      case ContributionStatus.completed:
        return const Color(0xFF3B82F6);
      case ContributionStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }

  String _getStatusLabel(ContributionStatus status) {
    switch (status) {
      case ContributionStatus.active:
        return 'Active';
      case ContributionStatus.paused:
        return 'Paused';
      case ContributionStatus.completed:
        return 'Completed';
      case ContributionStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool _canDelete() {
    return !_hasPayments && widget.contribution.status != ContributionStatus.completed;
  }

  void _handleBack() {
    if (_hasChanges) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: Text(
            'Discard Changes?',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          content: Text(
            'You have unsaved changes. Are you sure you want to discard them?',
            style: GoogleFonts.inter(color: Colors.grey[300]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Keep Editing',
                style: GoogleFonts.inter(color: Colors.grey[400]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.back();
              },
              child: Text(
                'Discard',
                style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
              ),
            ),
          ],
        ),
      );
    } else {
      Get.back();
    }
  }

  Future<void> _selectDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 78, 3, 208),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
      _onFieldChanged();
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final targetAmount = !_hasPayments
          ? int.parse(_targetAmountController.text) * 100
          : null;

      context.read<GroupAccountCubit>().updateContributionDetails(
        contributionId: widget.contribution.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        targetAmount: targetAmount,
        deadline: _deadline,
        status: _selectedStatus,
      );
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Delete Contribution?',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          'This action cannot be undone. All payment history will be lost.',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<GroupAccountCubit>().deleteContribution(widget.contribution.id);
              Get.back(result: 'deleted');
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
