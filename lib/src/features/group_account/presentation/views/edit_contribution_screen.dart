import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/social_link_helpers.dart';
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
  late TextEditingController _whatsappLinkController;
  late TextEditingController _telegramLinkController;
  late DateTime _deadline;
  late ContributionStatus _selectedStatus;
  late bool _autoPayEnabled;
  // Auto-Payout (separate from auto-pay, which is member-side debit).
  // Toggling this on/off determines whether the platform fires the
  // payout automatically once a receiver is set, OR whether the
  // creator must press the manual Trigger Payout CTA on the banner.
  // Editable here so admins can flip auto → manual mid-flight to
  // surface the Trigger Payout button on contribution details when
  // they need to release funds early (e.g. before deadline).
  late bool _autoPayoutEnabled;
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
    // Strip the canonical prefix so the controller holds only the
    // suffix; the prefix is rendered as InputDecoration.prefixText so
    // the user just types/edits what comes after the domain.
    _whatsappLinkController = TextEditingController(
      text: stripCanonicalPrefix(c.whatsappGroupLink, whatsappLinkPrefix),
    );
    _telegramLinkController = TextEditingController(
      text: stripCanonicalPrefix(c.telegramGroupLink, telegramLinkPrefix),
    );

    // Normalize the loaded deadline to end-of-day local time. Existing
    // rows often have midnight (`2026-04-28 00:00:00`) because the date
    // picker historically returned that; the create flow now writes
    // 23:59:59 and the picker callback below normalizes any subsequent
    // pick to 23:59:59 too. Without this normalization, opening an old
    // row and re-picking the same date would flip _deadline from
    // midnight to 23:59:59 and trigger _onFieldChanged() — a phantom
    // "has changes" prompt for an edit the user didn't make.
    _deadline = DateTime(
      c.deadline.year,
      c.deadline.month,
      c.deadline.day,
      23, 59, 59, 999,
    );
    _selectedStatus = c.status;
    _autoPayEnabled = c.autoPayEnabled;
    _autoPayoutEnabled = c.autoPayoutEnabled;
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
    _whatsappLinkController.addListener(_onFieldChanged);
    _telegramLinkController.addListener(_onFieldChanged);
    _gracePeriodController.addListener(_onFieldChanged);
    _penaltyAmountController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _regularAmountController.dispose();
    _whatsappLinkController.dispose();
    _telegramLinkController.dispose();
    _gracePeriodController.dispose();
    _penaltyAmountController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    final c = widget.contribution;
    // Compare deadlines by date (year+month+day) only — we normalize
    // _deadline to end-of-day on load so the time component would
    // otherwise always differ from a midnight-stored historical value.
    final deadlineDateChanged =
        _deadline.year != c.deadline.year ||
        _deadline.month != c.deadline.month ||
        _deadline.day != c.deadline.day;
    final hasChanges = _titleController.text != c.title ||
        _descriptionController.text != c.description ||
        deadlineDateChanged ||
        _selectedStatus != c.status ||
        _autoPayEnabled != c.autoPayEnabled ||
        _autoPayoutEnabled != c.autoPayoutEnabled ||
        _allowPartialPayments != c.allowPartialPayments ||
        _whatsappLinkController.text != stripCanonicalPrefix(c.whatsappGroupLink, whatsappLinkPrefix) ||
        _telegramLinkController.text != stripCanonicalPrefix(c.telegramGroupLink, telegramLinkPrefix);

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
                  _buildExternalLinksSection(),
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
        // Title is immutable post-creation. Receipts, push notifications,
        // chat headers, and audit logs all reference the title; renaming
        // it would split the audit trail. Render the existing value as a
        // read-only field so the user sees what they have without being
        // misled into thinking they can change it. The server enforces
        // the same rule (UpdateContribution rejects title changes).
        TextFormField(
          controller: _titleController,
          readOnly: true,
          enabled: false,
          style: GoogleFonts.inter(color: Colors.white70),
          decoration: _inputDecoration('Enter contribution title').copyWith(
            suffixIcon: Icon(Icons.lock_outline,
                size: 16.sp, color: Colors.grey[500]),
            helperText: 'Title cannot be changed after creation',
            helperStyle: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 11.sp,
            ),
          ),
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

  /// Status FSM mirroring server-side `isContributionStatusTransitionAllowed`:
  ///
  ///   active    ⇄ paused
  ///   active    → completed / cancelled
  ///   paused    → completed / cancelled
  ///   completed / cancelled — terminal (no further transitions)
  ///
  /// `current` is the contribution's persisted status; `next` is the
  /// row the user is about to tap. Same-status taps are allowed
  /// (selecting your current status is a no-op). Anything else is
  /// blocked and shown disabled with a tooltip.
  bool _isStatusTransitionAllowed(
      ContributionStatus current, ContributionStatus next) {
    if (current == next) return true;
    switch (current) {
      case ContributionStatus.active:
        return next == ContributionStatus.paused ||
            next == ContributionStatus.completed ||
            next == ContributionStatus.cancelled;
      case ContributionStatus.paused:
        return next == ContributionStatus.active ||
            next == ContributionStatus.completed ||
            next == ContributionStatus.cancelled;
      case ContributionStatus.completed:
      case ContributionStatus.cancelled:
        return false;
    }
  }

  Widget _buildStatusSelector() {
    final current = widget.contribution.status;
    // Cancelled is reachable through "Delete contribution" elsewhere —
    // not exposed as a status pill here so users don't conflate it
    // with the recoverable paused state.
    final options = <ContributionStatus>[
      ContributionStatus.active,
      ContributionStatus.paused,
      ContributionStatus.completed,
    ];
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
            children: options.map((status) {
              final isSelected = _selectedStatus == status;
              final allowed = _isStatusTransitionAllowed(current, status);
              return InkWell(
                onTap: allowed
                    ? () {
                        setState(() {
                          _selectedStatus = status;
                        });
                        _onFieldChanged();
                      }
                    : () {
                        // Surface why the row is blocked instead of
                        // failing silently — the user otherwise can't
                        // tell if it's a bug or an intended rule.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${_getStatusLabel(current)} → ${_getStatusLabel(status)} is not allowed.'),
                          ),
                        );
                      },
                child: Opacity(
                  opacity: allowed ? 1.0 : 0.45,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: status != options.last
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
                        if (!allowed)
                          Icon(Icons.lock_outline,
                              size: 16.sp, color: Colors.grey[500]),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: const Color.fromARGB(255, 78, 3, 208),
                            size: 24.sp,
                          ),
                      ],
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

  Widget _buildExternalLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.link,
              color: const Color.fromARGB(255, 78, 3, 208),
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Social Media Links (Optional)',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Add WhatsApp or Telegram links for this contribution',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: _whatsappLinkController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: _inputDecoration('invite-code').copyWith(
            prefixIcon: Icon(
              Icons.message,
              color: const Color(0xFF25D366),
              size: 20.sp,
            ),
            // `prefix:` widget instead of `prefixText:` so the
            // canonical URL prefix is visible even when the field is
            // unfocused + empty (Material's prefixText hides in that
            // state). User sees what the field is for at a glance.
            prefix: Text(
              whatsappLinkPrefix,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF25D366),
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: _telegramLinkController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: _inputDecoration('group-handle').copyWith(
            prefixIcon: Icon(
              Icons.send,
              color: const Color(0xFF0088CC),
              size: 20.sp,
            ),
            prefix: Text(
              telegramLinkPrefix,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF0088CC),
                width: 2,
              ),
            ),
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
              _buildSettingToggle(
                title: 'Auto-Payout',
                subtitle: _autoPayoutEnabled
                    ? 'Platform fires the payout automatically once a receiver is set'
                    : 'Creator must press “Trigger Payout” on the contribution details page',
                value: _autoPayoutEnabled,
                onChanged: (value) {
                  setState(() {
                    _autoPayoutEnabled = value;
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
    }
  }

  String _getTypeLabel(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return 'One Time Goal';
      case ContributionType.rotatingSavings:
        return 'Rotating Savings (Ajo)';
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

    if (picked != null) {
      // Normalize to end-of-day local time (showDatePicker returns 00:00).
      // A contribution due "Apr 28" must remain valid until Apr 29 00:00.
      final normalized = DateTime(picked.year, picked.month, picked.day, 23, 59, 59, 999);
      if (normalized != _deadline) {
        setState(() {
          _deadline = normalized;
        });
        _onFieldChanged();
      }
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final c = widget.contribution;

      // Build metadata with external links
      final metadata = Map<String, dynamic>.from(c.metadata ?? {});

      // Update WhatsApp link — re-prepend the canonical prefix that
      // the input decoration showed but didn't store in the controller.
      final whatsappFull = buildSocialFullUrl(_whatsappLinkController.text, whatsappLinkPrefix);
      if (whatsappFull != null) {
        metadata['whatsapp_group_link'] = whatsappFull;
      } else {
        metadata.remove('whatsapp_group_link');
      }

      // Update Telegram link
      final telegramFull = buildSocialFullUrl(_telegramLinkController.text, telegramLinkPrefix);
      if (telegramFull != null) {
        metadata['telegram_group_link'] = telegramFull;
      } else {
        metadata.remove('telegram_group_link');
      }

      // Title is immutable post-creation (server enforces). Pass the
      // existing value through unchanged so the gateway-side mapper
      // still sees a non-empty string but our edits don't try to
      // mutate it. Removing it from copyWith keeps `title` stable.
      final updatedContribution = c.copyWith(
        description: _descriptionController.text.trim(),
        deadline: _deadline,
        status: _selectedStatus,
        autoPayoutEnabled: _autoPayoutEnabled,
        metadata: metadata,
      );

      context.read<GroupAccountCubit>().updateContributionDetails(updatedContribution);
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
