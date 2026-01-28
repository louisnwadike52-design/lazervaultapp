import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';

class EditAutoSaveRuleScreen extends StatefulWidget {
  const EditAutoSaveRuleScreen({super.key});

  @override
  State<EditAutoSaveRuleScreen> createState() => _EditAutoSaveRuleScreenState();
}

class _EditAutoSaveRuleScreenState extends State<EditAutoSaveRuleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _minimumBalanceController = TextEditingController();
  final _maximumPerSaveController = TextEditingController();

  late AutoSaveRuleEntity originalRule;
  late AmountType _selectedAmountType;
  ScheduleFrequency? _selectedFrequency;
  TimeOfDay? _selectedTime;
  int? _selectedDay;

  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    originalRule = Get.arguments as AutoSaveRuleEntity;
    _populateFields();
  }

  void _populateFields() {
    _nameController.text = originalRule.name;
    _descriptionController.text = originalRule.description;
    _amountController.text = originalRule.amountValue.toString();
    _selectedAmountType = originalRule.amountType;

    // Populate optional fields
    if (originalRule.targetAmount != null) {
      _targetAmountController.text = originalRule.targetAmount.toString();
    }
    if (originalRule.minimumBalance != null) {
      _minimumBalanceController.text = originalRule.minimumBalance.toString();
    }
    if (originalRule.maximumPerSave != null) {
      _maximumPerSaveController.text = originalRule.maximumPerSave.toString();
    }

    // Populate schedule fields if scheduled rule
    if (originalRule.triggerType == TriggerType.scheduled) {
      _selectedFrequency = originalRule.frequency;
      _selectedDay = originalRule.scheduleDay;

      if (originalRule.scheduleTime != null) {
        final timeParts = originalRule.scheduleTime!.split(':');
        if (timeParts.length == 2) {
          _selectedTime = TimeOfDay(
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1]),
          );
        }
      }
    }

    // Add listeners to track changes
    _nameController.addListener(_checkForChanges);
    _descriptionController.addListener(_checkForChanges);
    _amountController.addListener(_checkForChanges);
    _targetAmountController.addListener(_checkForChanges);
    _minimumBalanceController.addListener(_checkForChanges);
    _maximumPerSaveController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    setState(() {
      _hasChanges = _nameController.text != originalRule.name ||
          _descriptionController.text != originalRule.description ||
          _amountController.text != originalRule.amountValue.toString() ||
          _selectedAmountType != originalRule.amountType ||
          _targetAmountController.text != (originalRule.targetAmount?.toString() ?? '') ||
          _minimumBalanceController.text != (originalRule.minimumBalance?.toString() ?? '') ||
          _maximumPerSaveController.text != (originalRule.maximumPerSave?.toString() ?? '');
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _targetAmountController.dispose();
    _minimumBalanceController.dispose();
    _maximumPerSaveController.dispose();
    super.dispose();
  }

  Future<bool> _showDiscardDialog() async {
    if (!_hasChanges) return true;

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        title: Text(
          'Discard Changes?',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'You have unsaved changes. Are you sure you want to discard them?',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Keep Editing',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Text(
                'Discard',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  void _showPreview() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Preview Changes',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  ),
                ],
              ),
            ),
            Divider(color: const Color(0xFF2D2D2D), height: 1),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: EdgeInsets.all(20.w),
                children: [
                  if (_nameController.text != originalRule.name)
                    _buildChangeItem(
                      'Name',
                      originalRule.name,
                      _nameController.text,
                    ),
                  if (_descriptionController.text != originalRule.description)
                    _buildChangeItem(
                      'Description',
                      originalRule.description,
                      _descriptionController.text,
                    ),
                  if (_amountController.text != originalRule.amountValue.toString() ||
                      _selectedAmountType != originalRule.amountType)
                    _buildChangeItem(
                      'Amount',
                      '${originalRule.amountType == AmountType.fixed ? '\$' : ''}${originalRule.amountValue}${originalRule.amountType == AmountType.percentage ? '%' : ''}',
                      '${_selectedAmountType == AmountType.fixed ? '\$' : ''}${_amountController.text}${_selectedAmountType == AmountType.percentage ? '%' : ''}',
                    ),
                  if (_targetAmountController.text != (originalRule.targetAmount?.toString() ?? ''))
                    _buildChangeItem(
                      'Target Amount',
                      originalRule.targetAmount != null ? '\$${originalRule.targetAmount}' : 'Not Set',
                      _targetAmountController.text.isEmpty ? 'Not Set' : '\$${_targetAmountController.text}',
                    ),
                  if (_minimumBalanceController.text != (originalRule.minimumBalance?.toString() ?? ''))
                    _buildChangeItem(
                      'Minimum Balance',
                      originalRule.minimumBalance != null ? '\$${originalRule.minimumBalance}' : 'Not Set',
                      _minimumBalanceController.text.isEmpty ? 'Not Set' : '\$${_minimumBalanceController.text}',
                    ),
                  if (_maximumPerSaveController.text != (originalRule.maximumPerSave?.toString() ?? ''))
                    _buildChangeItem(
                      'Maximum Per Save',
                      originalRule.maximumPerSave != null ? '\$${originalRule.maximumPerSave}' : 'Not Set',
                      _maximumPerSaveController.text.isEmpty ? 'Not Set' : '\$${_maximumPerSaveController.text}',
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        minimumSize: Size(double.infinity, 48.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _saveChanges();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        minimumSize: Size(double.infinity, 48.h),
                      ),
                      child: Text(
                        'Confirm & Save',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangeItem(String label, String oldValue, String newValue) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color.fromARGB(255, 78, 3, 208),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OLD',
                      style: GoogleFonts.inter(
                        color: Colors.grey[600],
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      oldValue,
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEW',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      newValue,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF10B981),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields correctly',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate amount
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid amount greater than zero',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate percentage is not greater than 100
    if (_selectedAmountType == AmountType.percentage && amount > 100) {
      Get.snackbar(
        'Validation Error',
        'Percentage cannot exceed 100%',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Validate optional amounts
    if (_targetAmountController.text.isNotEmpty) {
      final targetAmount = double.tryParse(_targetAmountController.text);
      if (targetAmount == null || targetAmount <= 0) {
        Get.snackbar(
          'Validation Error',
          'Target amount must be a positive number',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    if (_minimumBalanceController.text.isNotEmpty) {
      final minBalance = double.tryParse(_minimumBalanceController.text);
      if (minBalance == null || minBalance < 0) {
        Get.snackbar(
          'Validation Error',
          'Minimum balance must be zero or greater',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    if (_maximumPerSaveController.text.isNotEmpty) {
      final maxPerSave = double.tryParse(_maximumPerSaveController.text);
      if (maxPerSave == null || maxPerSave <= 0) {
        Get.snackbar(
          'Validation Error',
          'Maximum per save must be a positive number',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      if (_selectedAmountType == AmountType.fixed && maxPerSave < amount) {
        Get.snackbar(
          'Validation Error',
          'Maximum per save cannot be less than the save amount',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    // Prepare schedule time if scheduled rule
    String? scheduleTime;
    if (originalRule.triggerType == TriggerType.scheduled && _selectedTime != null) {
      scheduleTime = '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
    }

    // Call update rule
    context.read<AutoSaveCubit>().updateRule(
      ruleId: originalRule.id,
      name: _nameController.text,
      description: _descriptionController.text,
      amountType: _selectedAmountType,
      amountValue: double.parse(_amountController.text),
      frequency: _selectedFrequency,
      scheduleTime: scheduleTime,
      scheduleDay: _selectedDay,
      targetAmount: _targetAmountController.text.isEmpty ? null : double.parse(_targetAmountController.text),
      minimumBalance: _minimumBalanceController.text.isEmpty ? null : double.parse(_minimumBalanceController.text),
      maximumPerSave: _maximumPerSaveController.text.isEmpty ? null : double.parse(_maximumPerSaveController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _showDiscardDialog();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          elevation: 0,
          shadowColor: Colors.black.withValues(alpha: 0.05),
          title: Text(
            'Edit Auto-Save Rule',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              final shouldPop = await _showDiscardDialog();
              if (shouldPop && mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: BlocListener<AutoSaveCubit, AutoSaveState>(
          listener: (context, state) {
            if (state is AutoSaveRuleUpdated) {
              Get.snackbar(
                'Success',
                'Auto-save rule updated successfully!',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 2),
              );
              // Pop back to details screen
              Navigator.pop(context);
            } else if (state is AutoSaveError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 3),
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
                  // Info Banner
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFF3B82F6),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            'Trigger type and accounts cannot be changed after creation',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Editable Fields
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

                  // Schedule settings for scheduled rules
                  if (originalRule.triggerType == TriggerType.scheduled) ...[
                    SizedBox(height: 24.h),
                    _buildSectionHeader('Schedule Settings', Icons.schedule),
                    SizedBox(height: 12.h),
                    _buildFrequencySelector(),
                    if (_selectedFrequency != null) ...[
                      SizedBox(height: 16.h),
                      _buildTimeSelector(),
                    ],
                  ],

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

                  // Save Button
                  BlocBuilder<AutoSaveCubit, AutoSaveState>(
                    builder: (context, state) {
                      final isLoading = state is AutoSaveLoading;
                      return Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          gradient: _hasChanges
                              ? const LinearGradient(
                                  colors: [Color.fromARGB(255, 78, 3, 208), Color.fromARGB(255, 98, 33, 224)],
                                )
                              : null,
                          color: _hasChanges ? null : const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: _hasChanges
                              ? [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16.r),
                            onTap: (isLoading || !_hasChanges) ? null : _showPreview,
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
                                        Icon(
                                          Icons.check_circle,
                                          color: _hasChanges ? Colors.white : Colors.grey[600],
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          'Preview & Save Changes',
                                          style: GoogleFonts.inter(
                                            color: _hasChanges ? Colors.white : Colors.grey[600],
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
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color.fromARGB(255, 78, 3, 208), size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
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
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
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
              color: Colors.white,
              fontSize: 15.sp,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: Colors.grey[500],
                fontSize: 15.sp,
              ),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
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
                borderSide: const BorderSide(color: Color.fromARGB(255, 78, 3, 208), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: RadioGroup<AmountType>(
        groupValue: _selectedAmountType,
        onChanged: (value) {
          setState(() => _selectedAmountType = value ?? _selectedAmountType);
          _checkForChanges();
        },
        child: Row(
          children: [
            Expanded(
              child: RadioListTile<AmountType>(
                title: Text(
                  'Fixed Amount',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: AmountType.fixed,
                activeColor: const Color.fromARGB(255, 78, 3, 208),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<AmountType>(
                title: Text(
                  'Percentage',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: AmountType.percentage,
                activeColor: const Color.fromARGB(255, 78, 3, 208),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
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
            color: Colors.grey[400],
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
      onTap: () {
        setState(() => _selectedFrequency = isSelected ? null : freq);
        _checkForChanges();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color.fromARGB(255, 78, 3, 208) : const Color(0xFF2D2D2D),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isSelected ? const Color.fromARGB(255, 78, 3, 208) : Colors.grey[400],
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
          _checkForChanges();
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
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
                color: _selectedTime == null ? Colors.grey[500] : Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.access_time,
              color: const Color.fromARGB(255, 78, 3, 208),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
