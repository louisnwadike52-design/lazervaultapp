import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/cable_tv_reminder.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../cubit/cable_tv_beneficiary_cubit.dart';
import '../cubit/cable_tv_beneficiary_state.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_reminder_cubit.dart';
import '../cubit/cable_tv_reminder_state.dart';
import '../cubit/cable_tv_state.dart';

enum _Recurrence { daily, weekly, monthly }

class CreateCableTVReminderScreen extends StatefulWidget {
  const CreateCableTVReminderScreen({super.key});

  @override
  State<CreateCableTVReminderScreen> createState() =>
      _CreateCableTVReminderScreenState();
}

class _CreateCableTVReminderScreenState
    extends State<CreateCableTVReminderScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _purple = Color(0xFF4E03D0);
  static const _secondary = Color(0xFF9CA3AF);
  static const _dim = Color(0xFF6B7280);

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  CableTVBeneficiary? _selectedBeneficiary;
  bool _isRecurring = false;
  _Recurrence _recurrence = _Recurrence.monthly;

  bool _isEditing = false;
  String? _reminderId;

  // Package state
  TVPackageEntity? _selectedPackage;
  TVPackageEntity? _editFallbackPackage;
  List<TVPackageEntity>? _loadedPackages;
  bool _packagesLoading = false;
  String? _packagesError;

  /// Reminder's beneficiaryId (edit mode) held until the beneficiaries cubit
  /// loads so we can resolve it to a real [CableTVBeneficiary] and auto-
  /// select it + fire the package load.
  String? _pendingEditBeneficiaryId;

  @override
  void initState() {
    super.initState();
    context.read<CableTVBeneficiaryCubit>().load();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) return;

    final existing = args['reminder'] as CableTVReminder?;
    if (existing != null) {
      _isEditing = true;
      _reminderId = existing.id;
      _titleController.text = existing.title;
      _descriptionController.text = existing.description ?? '';
      _isRecurring = existing.isRecurring;
      if (existing.recurrenceType != null) {
        _recurrence = _Recurrence.values.firstWhere(
          (r) => r.name == existing.recurrenceType,
          orElse: () => _Recurrence.monthly,
        );
      }
      final dt = existing.reminderDate.isNotEmpty
          ? DateTime.tryParse(existing.reminderDate)?.toLocal()
          : null;
      if (dt != null) {
        _selectedDate = dt;
        _selectedTime = TimeOfDay.fromDateTime(dt);
      }
      // Build synthetic package from stored values so UI is populated while
      // real catalog loads.
      if (existing.variationCode != null &&
          existing.variationCode!.isNotEmpty) {
        _editFallbackPackage = TVPackageEntity(
          id: existing.variationCode!,
          name: existing.variationCode!,
          variationCode: existing.variationCode!,
          amount: existing.amount ?? 0.0,
          providerId: '',
          validity: '',
        );
        _selectedPackage = _editFallbackPackage;
      }
      if (existing.beneficiaryId.isNotEmpty) {
        _pendingEditBeneficiaryId = existing.beneficiaryId;
      }
    } else {
      final title = args['title'] as String?;
      if (title != null) _titleController.text = title;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final prefilledBeneficiary = args['beneficiary'] as CableTVBeneficiary?;
      if (prefilledBeneficiary != null) {
        setState(() => _selectedBeneficiary = prefilledBeneficiary);
        _loadPackages(prefilledBeneficiary.providerCode);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _loadPackages(String providerCode) {
    if (providerCode.isEmpty) return;
    setState(() {
      _packagesLoading = true;
      _packagesError = null;
    });
    context.read<CableTVCubit>().getPackages(providerId: providerCode);
  }

  void _onBeneficiaryChanged(CableTVBeneficiary? b) {
    setState(() {
      _selectedBeneficiary = b;
      _selectedPackage = null;
      _loadedPackages = null;
      _packagesError = null;
    });
    if (b != null) _loadPackages(b.providerCode);
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: _purple,
            onPrimary: Colors.white,
            surface: Color(0xFF1A1A1A),
            onSurface: Colors.white,
          ),
          dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF1A1A1A)),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: _purple,
            onPrimary: Colors.white,
            surface: Color(0xFF1A1A1A),
            onSurface: Colors.white,
          ),
          dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF1A1A1A)),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final dt = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    if (dt.isBefore(DateTime.now())) {
      Get.snackbar('Invalid Time', 'Please choose a time in the future',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white);
      return;
    }

    // Plan is optional for reminders, but if one is set we must verify it
    // exists in the loaded catalog so the stored variation code is valid
    // for the downstream auto-pay / renewal flows.
    String? variationCode = _selectedPackage?.variationCode;
    double? amount = _selectedPackage?.amount;
    if (_selectedPackage != null && _selectedBeneficiary != null) {
      if (_packagesLoading) {
        Get.snackbar('Loading', 'Still loading plans. Please wait.',
            backgroundColor: const Color(0xFFFB923C),
            colorText: Colors.white);
        return;
      }
      if (_loadedPackages == null) {
        Get.snackbar('Plans unavailable',
            'Plans failed to load. Retry or clear the plan before saving.',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
        return;
      }
      final match = _loadedPackages!.where(
        (p) => p.variationCode == _selectedPackage!.variationCode,
      );
      if (match.isEmpty) {
        Get.snackbar('Plan not found',
            'Selected plan is no longer available. Pick another or clear it.',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
        return;
      }
      // Pin to the catalog entry so the stored values match VTpass exactly.
      _selectedPackage = match.first;
      variationCode = _selectedPackage!.variationCode;
      amount = _selectedPackage!.amount;
    }

    if (_isEditing && _reminderId != null) {
      context.read<CableTVReminderCubit>().updateReminder(
            reminderId: _reminderId!,
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: dt,
            amount: amount,
            variationCode: variationCode,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrence.name : null,
          );
    } else {
      context.read<CableTVReminderCubit>().createReminder(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            reminderDate: dt,
            amount: amount,
            variationCode: variationCode,
            beneficiaryId: _selectedBeneficiary?.id,
            isRecurring: _isRecurring,
            recurrenceType: _isRecurring ? _recurrence.name : null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CableTVReminderCubit, CableTVReminderState>(
          listener: (context, state) {
            if (state is CableTVReminderCreated) {
              Get.back(result: true);
              Get.snackbar('Success', 'Reminder created',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(16.w));
            } else if (state is CableTVReminderUpdated) {
              Get.back(result: true);
              Get.snackbar('Success', 'Reminder updated',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(16.w));
            } else if (state is CableTVReminderError) {
              Get.snackbar('Error', state.message,
                  backgroundColor: const Color(0xFFEF4444),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(16.w));
            }
          },
        ),
        BlocListener<CableTVBeneficiaryCubit, CableTVBeneficiaryState>(
          listener: (context, state) {
            // Resolve an edit-mode pending beneficiaryId to a real object so
            // the selector auto-populates and packages start loading.
            if (state is CableTVBeneficiariesLoaded &&
                _pendingEditBeneficiaryId != null &&
                _selectedBeneficiary == null) {
              final match = state.beneficiaries.where(
                (b) => b.id == _pendingEditBeneficiaryId,
              );
              if (match.isNotEmpty) {
                final b = match.first;
                if (!mounted) return;
                setState(() => _selectedBeneficiary = b);
                _pendingEditBeneficiaryId = null;
                _loadPackages(b.providerCode);
              } else {
                // Beneficiary was deleted — clear the pointer and let the
                // user pick a new one or save without a link.
                _pendingEditBeneficiaryId = null;
              }
            }
          },
        ),
        BlocListener<CableTVCubit, CableTVState>(
          listener: (context, state) {
            if (state is TVPackagesLoaded) {
              if (!mounted) return;
              setState(() {
                _loadedPackages = state.packages;
                _packagesLoading = false;
                _packagesError = null;
                if (_editFallbackPackage != null) {
                  final match = state.packages.where(
                    (p) => p.variationCode == _editFallbackPackage!.variationCode,
                  );
                  _selectedPackage =
                      match.isNotEmpty ? match.first : _editFallbackPackage;
                } else if (_selectedPackage != null) {
                  final match = state.packages.where(
                    (p) => p.variationCode == _selectedPackage!.variationCode,
                  );
                  _selectedPackage = match.isNotEmpty ? match.first : null;
                }
              });
            } else if (state is CableTVError) {
              if (!mounted) return;
              setState(() {
                _packagesLoading = false;
                _packagesError = state.message;
              });
            } else if (state is CableTVLoading) {
              if (!mounted) return;
              setState(() {
                _packagesLoading = true;
                _packagesError = null;
              });
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 20.sp),
            onPressed: () => Get.back(),
          ),
          title: Text(
            _isEditing ? 'Edit TV Reminder' : 'Create TV Reminder',
            style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        body: BlocBuilder<CableTVReminderCubit, CableTVReminderState>(
          builder: (context, state) {
            final isLoading = state is CableTVReminderCreating ||
                state is CableTVReminderUpdating ||
                state is CableTVReminderLoading;
            return SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Smart card ──────────────────────────────
                    _label('Saved Smart Card'),
                    SizedBox(height: 8.h),
                    _beneficiarySelector(),
                    SizedBox(height: 20.h),

                    // ── Subscription plan ───────────────────────
                    _label('Subscription Plan (Optional)'),
                    SizedBox(height: 8.h),
                    _packageSelector(),
                    SizedBox(height: 20.h),

                    // Amount read-only — derived from plan. Hide when the
                    // synthetic fallback has a 0 amount (legacy reminder
                    // without a stored amount).
                    if (_selectedPackage != null &&
                        _selectedPackage!.amount > 0) ...[
                      _label('Amount'),
                      SizedBox(height: 8.h),
                      _amountDisplay(),
                      SizedBox(height: 20.h),
                    ],

                    // ── Title ────────────────────────────────────
                    _label('Reminder Title'),
                    SizedBox(height: 8.h),
                    _textField(
                      controller: _titleController,
                      hint: 'e.g., Renew DStv Compact',
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Please enter a title'
                          : null,
                    ),
                    SizedBox(height: 20.h),

                    // ── Description ──────────────────────────────
                    _label('Description (Optional)'),
                    SizedBox(height: 8.h),
                    _textField(
                      controller: _descriptionController,
                      hint: 'Add details about this reminder',
                      maxLines: 2,
                    ),
                    SizedBox(height: 20.h),

                    // ── Date & Time ──────────────────────────────
                    _label('Reminder Date & Time'),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: _dateTimeCard(
                            icon: Icons.calendar_today,
                            label: 'Date',
                            value: DateFormat('MMM dd, yyyy')
                                .format(_selectedDate),
                            onTap: _selectDate,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _dateTimeCard(
                            icon: Icons.access_time,
                            label: 'Time',
                            value: _formatTime(_selectedTime),
                            onTap: _selectTime,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // ── Recurring ────────────────────────────────
                    _recurringSection(),
                    SizedBox(height: 32.h),

                    // ── CTA ──────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _purple,
                          disabledBackgroundColor:
                              _purple.withValues(alpha: 0.5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r)),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 24.h,
                                width: 24.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                _isEditing
                                    ? 'Update Reminder'
                                    : 'Create Reminder',
                                style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Package selector ─────────────────────────────────────────

  Widget _packageSelector() {
    if (_selectedBeneficiary == null) {
      return _disabledField(
        icon: Icons.tv,
        text: 'Select a smart card to load plans',
      );
    }

    if (_packagesLoading && _loadedPackages == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(_purple),
              ),
            ),
            SizedBox(width: 12.w),
            Text('Loading packages…',
                style: TextStyle(color: _secondary, fontSize: 14.sp)),
          ],
        ),
      );
    }

    if (_packagesError != null && _loadedPackages == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    color: const Color(0xFFEF4444), size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(_packagesError!,
                      style: TextStyle(
                          color: const Color(0xFFEF4444), fontSize: 13.sp)),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          TextButton.icon(
            onPressed: () =>
                _loadPackages(_selectedBeneficiary!.providerCode),
            icon: Icon(Icons.refresh, size: 16.sp),
            label: Text('Retry', style: TextStyle(fontSize: 13.sp)),
            style: TextButton.styleFrom(
              foregroundColor: _purple,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: _showPackageSheet,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _selectedPackage != null ? _purple : _border,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.live_tv,
                color: _selectedPackage != null ? _purple : _dim,
                size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: _selectedPackage == null
                  ? Text('Select a plan (optional)',
                      style:
                          TextStyle(color: const Color(0xFF4B5563), fontSize: 15.sp))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_selectedPackage!.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 2.h),
                        Text(_selectedPackage!.variationCode,
                            style: TextStyle(color: _dim, fontSize: 11.sp)),
                      ],
                    ),
            ),
            if (_packagesLoading)
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(_purple),
                ),
              )
            else
              Icon(Icons.keyboard_arrow_down,
                  color: _secondary, size: 20.sp),
          ],
        ),
      ),
    );
  }

  void _showPackageSheet() {
    final packages = _loadedPackages ?? [];
    if (packages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No plans available for this provider'),
          backgroundColor: const Color(0xFFFB923C),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12.w),
        ),
      );
      return;
    }
    final fmt = NumberFormat('#,##0', 'en_NG');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.55,
        minChildSize: 0.35,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Choose a Plan',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  itemCount: packages.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) {
                    final p = packages[i];
                    final selected =
                        _selectedPackage?.variationCode == p.variationCode;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedPackage = p);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: selected
                              ? _purple.withValues(alpha: 0.12)
                              : Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: selected
                                ? _purple
                                : Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(p.name,
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Text(p.variationCode,
                                          style: TextStyle(
                                              color: _secondary,
                                              fontSize: 11.sp)),
                                      if (p.validity.isNotEmpty) ...[
                                        Text(' · ',
                                            style: TextStyle(
                                                color: _secondary,
                                                fontSize: 11.sp)),
                                        Text(p.validity,
                                            style: TextStyle(
                                                color: _secondary,
                                                fontSize: 11.sp)),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '₦${fmt.format(p.amount)}',
                              style: GoogleFonts.inter(
                                  color: const Color(0xFF10B981),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            if (selected) ...[
                              SizedBox(width: 8.w),
                              Icon(Icons.check_circle,
                                  color: _purple, size: 18.sp),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountDisplay() {
    final fmt = NumberFormat('#,##0', 'en_NG');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: _dim, size: 16.sp),
          SizedBox(width: 10.w),
          Text(
            '₦${fmt.format(_selectedPackage!.amount)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF10B981),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8.w),
          Text('(set by package)',
              style: TextStyle(color: _dim, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _disabledField({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Icon(icon, color: _dim, size: 18.sp),
          SizedBox(width: 12.w),
          Text(text, style: TextStyle(color: _dim, fontSize: 14.sp)),
        ],
      ),
    );
  }

  // ── Beneficiary selector ─────────────────────────────────────

  Widget _beneficiarySelector() {
    return BlocBuilder<CableTVBeneficiaryCubit, CableTVBeneficiaryState>(
      buildWhen: (_, s) => s is CableTVBeneficiariesLoaded,
      builder: (context, state) {
        if (state is! CableTVBeneficiariesLoaded) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: _border),
            ),
            child: const Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_purple),
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
              color: _card,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: _border),
            ),
            child: Text(
              'No saved smart cards. Reminder will be unlinked.',
              style: GoogleFonts.inter(
                  fontSize: 13.sp, color: Colors.white.withValues(alpha: 0.5)),
            ),
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: _border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CableTVBeneficiary>(
              isExpanded: true,
              value: _selectedBeneficiary,
              hint: Text('Select a smart card',
                  style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      color: Colors.white.withValues(alpha: 0.3))),
              icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.white.withValues(alpha: 0.5)),
              dropdownColor: const Color(0xFF1A1A1A),
              style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white),
              items: [
                DropdownMenuItem<CableTVBeneficiary>(
                  value: null,
                  child: Text('None',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: Colors.white.withValues(alpha: 0.5))),
                ),
                ...list.map((b) => DropdownMenuItem<CableTVBeneficiary>(
                      value: b,
                      child: Text(
                        '${b.nickname ?? b.smartCardNumber} · ${b.providerName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ],
              onChanged: _onBeneficiaryChanged,
            ),
          ),
        );
      },
    );
  }

  // ── Helpers ──────────────────────────────────────────────────

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white.withValues(alpha: 0.7)));

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) =>
      TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              GoogleFonts.inter(fontSize: 15.sp, color: Colors.white.withValues(alpha: 0.3)),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide:
                  BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: _purple, width: 2)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
      );

  Widget _dateTimeCard({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 15.sp, color: _purple),
                  SizedBox(width: 8.w),
                  Text(label,
                      style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.white.withValues(alpha: 0.5))),
                ],
              ),
              SizedBox(height: 6.h),
              Text(value,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
        ),
      );

  Widget _recurringSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _purple.withValues(alpha: 0.1),
            _purple.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _purple.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.repeat, color: _purple, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text('Recurring Reminder',
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              Switch(
                value: _isRecurring,
                onChanged: (v) => setState(() => _isRecurring = v),
                activeThumbColor: _purple,
                activeTrackColor: _purple.withValues(alpha: 0.5),
              ),
            ],
          ),
          if (_isRecurring) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                _recurChip(_Recurrence.daily, 'Daily'),
                SizedBox(width: 10.w),
                _recurChip(_Recurrence.weekly, 'Weekly'),
                SizedBox(width: 10.w),
                _recurChip(_Recurrence.monthly, 'Monthly'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _recurChip(_Recurrence type, String label) {
    final selected = _recurrence == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _recurrence = type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: selected ? _purple : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
                color:
                    selected ? _purple : Colors.white.withValues(alpha: 0.1)),
          ),
          child: Center(
            child: Text(label,
                style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w500,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay t) {
    final now = DateTime.now();
    return DateFormat.jm()
        .format(DateTime(now.year, now.month, now.day, t.hour, t.minute));
  }
}
