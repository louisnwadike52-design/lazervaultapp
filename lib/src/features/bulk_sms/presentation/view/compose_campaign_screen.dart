import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../utils/bulk_sms_utils.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import '../widgets/recipients_picker_sheet.dart';
import 'bulk_sms_theme.dart';

/// Compose a bulk SMS: sender-ID, message (live segment/unit count),
/// `{{variable}}` insertion, and recipients (via the recipients sheet).
class ComposeCampaignScreen extends StatefulWidget {
  const ComposeCampaignScreen({super.key});

  @override
  State<ComposeCampaignScreen> createState() => _ComposeCampaignScreenState();
}

class _ComposeCampaignScreenState extends State<ComposeCampaignScreen> {
  final TextEditingController _message = TextEditingController();
  final TextEditingController _senderIdField = TextEditingController();
  final FocusNode _messageFocus = FocusNode();

  String? _selectedSenderId;
  List<SmsRecipientEntity> _recipients = [];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<BulkSmsCubit>();
    cubit.loadSenderIds();
    cubit.loadBalance();
    cubit.loadProviders();
    _message.addListener(() => setState(() {}));
    // Default to the platform's registered sender so a brand-new user (no
    // approved sender IDs of their own) can send immediately without typing —
    // "Lazervault" is Termii-registered. Used as the manual-field default and as
    // the send fallback; a user with approved IDs picks one (auto-selected below).
    _senderIdField.text = 'Lazervault';
  }

  @override
  void dispose() {
    _message.dispose();
    _senderIdField.dispose();
    _messageFocus.dispose();
    super.dispose();
  }

  String _resolveProvider(BulkSmsState state) {
    final fromBalance = state.balance?.providerName ?? '';
    if (fromBalance.isNotEmpty) return fromBalance;
    final active = state.providers.where((p) => p.isActive).toList();
    if (active.isNotEmpty) return active.first.name;
    if (state.providers.isNotEmpty) return state.providers.first.name;
    return '';
  }

  void _insertVariable(String key) {
    final token = '{{$key}}';
    final sel = _message.selection;
    final text = _message.text;
    final start = sel.start < 0 ? text.length : sel.start;
    final end = sel.end < 0 ? text.length : sel.end;
    final next = text.replaceRange(start, end, token);
    _message.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: start + token.length),
    );
    _messageFocus.requestFocus();
  }

  Future<void> _openRecipients() async {
    final result = await showModalBottomSheet<List<SmsRecipientEntity>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecipientsPickerSheet(initial: _recipients),
    );
    if (result != null && mounted) {
      setState(() => _recipients = result);
    }
  }

  void _continue(BulkSmsState state) {
    final senderId = _selectedSenderId ?? _senderIdField.text.trim();
    if (senderId.isEmpty) {
      LVSnackbar.showError(
          title: 'Sender ID required',
          message: 'Select or enter a sender ID for your campaign.');
      return;
    }
    if (_message.text.trim().isEmpty) {
      LVSnackbar.showError(
          title: 'Message required',
          message: 'Write the message you want to send.');
      return;
    }
    if (_recipients.isEmpty) {
      LVSnackbar.showError(
          title: 'No recipients',
          message: 'Add at least one recipient to continue.');
      return;
    }
    final provider = _resolveProvider(state);
    Get.toNamed(AppRoutes.bulkSmsReview, arguments: {
      'providerName': provider,
      'senderId': senderId,
      'message': _message.text.trim(),
      'recipients': _recipients,
      'balance': state.balance?.creditsRemaining ?? 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BulkSmsTheme.bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            BulkSmsHeader(
              title: 'New campaign',
              subtitle: 'Compose your bulk SMS',
              onBack: () => Get.back(),
            ),
            Expanded(
              child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
                builder: (context, state) => ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    SizedBox(height: 4.h),
                    _senderIdSection(state),
                    SizedBox(height: 18.h),
                    _messageSection(),
                    SizedBox(height: 10.h),
                    _variableRow(),
                    SizedBox(height: 8.h),
                    _counts(),
                    SizedBox(height: 18.h),
                    _recipientsTile(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _continueBar(),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700)),
      );

  Widget _senderIdSection(BulkSmsState state) {
    final approved =
        state.senderIds.where((s) => s.status.isApproved).toList();
    // Auto-select the first approved sender ID so the user isn't silently sending
    // as the default "Lazervault" when they have their own approved IDs.
    if (approved.isNotEmpty && _selectedSenderId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _selectedSenderId == null) {
          setState(() => _selectedSenderId = approved.first.senderId);
        }
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _sectionLabel('Sender ID'),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.bulkSmsSenderIds),
              child: Text('Manage',
                  style: TextStyle(
                      color: BulkSmsTheme.primary, fontSize: 12.sp)),
            ),
          ],
        ),
        if (approved.isEmpty)
          _senderIdManualField()
        else
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: approved.map((s) {
              final selected = s.senderId == _selectedSenderId;
              return GestureDetector(
                onTap: () => setState(() => _selectedSenderId = s.senderId),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: selected
                        ? BulkSmsTheme.primary.withValues(alpha: 0.15)
                        : BulkSmsTheme.card,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: selected
                            ? BulkSmsTheme.primary
                            : BulkSmsTheme.divider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded,
                          size: 14.sp, color: BulkSmsTheme.success),
                      SizedBox(width: 6.w),
                      Text(s.senderId,
                          style: TextStyle(
                              color: Colors.white, fontSize: 13.sp)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _senderIdManualField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _senderIdField,
          maxLength: 11,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
          ],
          decoration: InputDecoration(
            counterStyle: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 10.sp),
            hintText: 'e.g. LazerVault',
            hintStyle: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 14.sp),
            filled: true,
            fillColor: BulkSmsTheme.card,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        Text(
          'No approved sender ID yet — unregistered IDs may be rejected. Request one from Manage.',
          style: TextStyle(
              color: BulkSmsTheme.textSecondary, fontSize: 11.sp, height: 1.3),
        ),
      ],
    );
  }

  Widget _messageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Message'),
        Container(
          decoration: BoxDecoration(
            color: BulkSmsTheme.card,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: BulkSmsTheme.divider),
          ),
          padding: EdgeInsets.all(12.w),
          child: TextField(
            controller: _message,
            focusNode: _messageFocus,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            style: TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.4),
            decoration: InputDecoration(
              hintText:
                  'Hi {{name}}, thanks for shopping with us. Enjoy 10% off today!',
              hintStyle: TextStyle(
                  color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
              border: InputBorder.none,
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _variableRow() {
    final used = BulkSmsUtils.variablesIn(_message.text);
    return Wrap(
      spacing: 8.w,
      runSpacing: 6.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('Insert:',
            style: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 12.sp)),
        _varChip('name'),
        _varChip('amount'),
        _varChip('date'),
        if (used.isNotEmpty)
          Text('Using: ${used.join(", ")}',
              style: TextStyle(
                  color: BulkSmsTheme.primary, fontSize: 11.sp)),
      ],
    );
  }

  Widget _varChip(String key) {
    return GestureDetector(
      onTap: () => _insertVariable(key),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: BulkSmsTheme.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
              color: BulkSmsTheme.primary.withValues(alpha: 0.4)),
        ),
        child: Text('{{$key}}',
            style: TextStyle(
                color: BulkSmsTheme.primary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _counts() {
    final text = _message.text;
    final segments = BulkSmsUtils.segmentCount(text);
    final units = BulkSmsUtils.estimatedUnits(
        message: text, recipientCount: _recipients.length);
    final encoding = BulkSmsUtils.isUnicode(text) ? 'Unicode' : 'GSM-7';
    return Row(
      children: [
        _pill('${text.length} chars'),
        SizedBox(width: 8.w),
        _pill('$segments segment${segments == 1 ? '' : 's'} · $encoding'),
        const Spacer(),
        if (_recipients.isNotEmpty)
          Text('~$units units',
              style: TextStyle(
                  color: BulkSmsTheme.warning,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _pill(String text) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(text,
            style: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 11.sp)),
      );

  Widget _recipientsTile() {
    return GestureDetector(
      onTap: _openRecipients,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: BulkSmsTheme.divider),
        ),
        child: Row(
          children: [
            Icon(Icons.people_alt_rounded,
                color: BulkSmsTheme.primary, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recipients',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 2.h),
                  Text(
                    _recipients.isEmpty
                        ? 'Add contacts, paste numbers, or import a CSV'
                        : '${_recipients.length} recipient(s) added',
                    style: TextStyle(
                        color: BulkSmsTheme.textSecondary, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: BulkSmsTheme.textSecondary, size: 22.sp),
          ],
        ),
      ),
    );
  }

  Widget _continueBar() {
    return BlocBuilder<BulkSmsCubit, BulkSmsState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.all(20.w),
        child: SizedBox(
          width: double.infinity,
          height: 54.h,
          child: ElevatedButton(
            onPressed: () => _continue(state),
            style: ElevatedButton.styleFrom(
              backgroundColor: BulkSmsTheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
            ),
            child: Text('Review campaign',
                style:
                    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
          ),
        ),
      ),
    );
  }
}
