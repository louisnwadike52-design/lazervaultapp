import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../utils/bulk_sms_utils.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import 'bulk_sms_theme.dart';

/// Review + PIN-confirm step for sending (or scheduling) a bulk SMS campaign.
/// Sending/scheduling CONSUMES credits, so it is gated behind the transaction
/// PIN and forwards the verification token.
class CampaignReviewScreen extends StatefulWidget {
  const CampaignReviewScreen({super.key});

  @override
  State<CampaignReviewScreen> createState() => _CampaignReviewScreenState();
}

class _CampaignReviewScreenState extends State<CampaignReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  String _providerName = '';
  String _senderId = '';
  String _message = '';
  List<SmsRecipientEntity> _recipients = [];
  int _balance = 0;

  bool _schedule = false;
  DateTime? _scheduledAt;
  bool _isProcessing = false;
  final String _idempotencyKey = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _providerName = (args['providerName'] as String?) ?? '';
      _senderId = (args['senderId'] as String?) ?? '';
      _message = (args['message'] as String?) ?? '';
      _recipients =
          (args['recipients'] as List?)?.cast<SmsRecipientEntity>() ?? [];
      _balance = (args['balance'] as int?) ?? 0;
    }
  }

  int get _units => BulkSmsUtils.estimatedUnits(
      message: _message, recipientCount: _recipients.length);

  bool get _sufficient => _balance >= _units;

  Future<void> _pickSchedule() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(hours: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
    );
    if (time == null || !mounted) return;
    final picked =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    if (picked.isBefore(DateTime.now())) {
      LVSnackbar.showError(
          title: 'Invalid time',
          message: 'Pick a time in the future to schedule.');
      return;
    }
    setState(() => _scheduledAt = picked);
  }

  Future<void> _confirm() async {
    if (_isProcessing) return;
    if (!_sufficient) {
      LVSnackbar.showError(
        title: 'Not enough units',
        message: 'You need $_units units but have $_balance. Buy more first.',
      );
      return;
    }
    if (_schedule && _scheduledAt == null) {
      LVSnackbar.showError(
          title: 'Pick a time',
          message: 'Choose when the campaign should be sent.');
      return;
    }

    setState(() => _isProcessing = true);
    final cubit = context.read<BulkSmsCubit>();
    final transactionId = 'bulk_sms_${DateTime.now().millisecondsSinceEpoch}';
    final scheduled = _schedule;

    final ok = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'bulk_sms_send',
      amount: 0,
      currency: 'NGN',
      title: scheduled ? 'Confirm schedule' : 'Confirm send',
      message: scheduled
          ? 'Schedule $_units units to ${_recipients.length} recipients'
          : 'Send $_units units to ${_recipients.length} recipients',
      successMessage: scheduled ? 'Campaign scheduled' : 'Campaign sent',
      preserveHostSheet: true,
      onPinValidated: (token) async {
        if (scheduled) {
          await cubit.scheduleCampaign(
            providerName: _providerName,
            senderId: _senderId,
            messageTemplate: _message,
            recipients: _recipients,
            scheduledAt: _scheduledAt!,
            transactionId: transactionId,
            verificationToken: token,
            idempotencyKey: _idempotencyKey,
          );
        } else {
          await cubit.sendCampaign(
            providerName: _providerName,
            senderId: _senderId,
            messageTemplate: _message,
            recipients: _recipients,
            transactionId: transactionId,
            verificationToken: token,
            idempotencyKey: _idempotencyKey,
          );
        }
        // Surface a backend failure to the PIN sheet (money-safety: never show
        // success on a failed send).
        if (cubit.state.sendStatus == ActionStatus.failed) {
          throw Exception(
              cubit.state.errorMessage ?? 'Campaign could not be sent');
        }
      },
    );

    if (!ok) {
      if (mounted) setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    final result = cubit.state.sendResult;
    Get.offNamed(AppRoutes.bulkSmsProcessing, arguments: {
      'result': result,
      'scheduled': scheduled,
      'recipientCount': _recipients.length,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BulkSmsTheme.bg,
      body: SafeArea(
        child: Column(
          children: [
            BulkSmsHeader(
              title: 'Review campaign',
              subtitle: 'Confirm before you send',
              onBack: () => Get.back(),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  SizedBox(height: 4.h),
                  _unitsHero(),
                  SizedBox(height: 14.h),
                  _detailsCard(),
                  SizedBox(height: 14.h),
                  _messagePreview(),
                  SizedBox(height: 14.h),
                  _scheduleCard(),
                  if (!_sufficient) ...[
                    SizedBox(height: 14.h),
                    _insufficientBanner(),
                  ],
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            _confirmBar(),
          ],
        ),
      ),
    );
  }

  Widget _unitsHero() {
    return BulkSmsGradientCard(
      padding: EdgeInsets.all(18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Units required',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13.sp)),
              SizedBox(height: 4.h),
              Text('$_units',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w800)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Your balance',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13.sp)),
              SizedBox(height: 4.h),
              Text('$_balance',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailsCard() {
    final segs = BulkSmsUtils.segmentCount(_message);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          _row('Sender ID', _senderId.isEmpty ? '—' : _senderId),
          SizedBox(height: 10.h),
          _row('Recipients', '${_recipients.length}'),
          SizedBox(height: 10.h),
          _row('Segments', '$segs per message'),
          SizedBox(height: 10.h),
          _row('Provider', _providerName.isEmpty ? 'Auto' : _providerName),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6), fontSize: 13.sp)),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _messagePreview() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: BulkSmsTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Message',
              style: TextStyle(
                  color: BulkSmsTheme.textSecondary, fontSize: 12.sp)),
          SizedBox(height: 8.h),
          Text(_message,
              style:
                  TextStyle(color: Colors.white, fontSize: 14.sp, height: 1.4)),
        ],
      ),
    );
  }

  Widget _scheduleCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.schedule_rounded,
                  color: BulkSmsTheme.primary, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text('Schedule for later',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
              Switch(
                value: _schedule,
                activeThumbColor: BulkSmsTheme.primary,
                onChanged: (v) => setState(() {
                  _schedule = v;
                  if (!v) _scheduledAt = null;
                }),
              ),
            ],
          ),
          if (_schedule) ...[
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _pickSchedule,
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: BulkSmsTheme.bg,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: BulkSmsTheme.divider),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event, color: BulkSmsTheme.primary, size: 16.sp),
                    SizedBox(width: 10.w),
                    Text(
                      _scheduledAt == null
                          ? 'Pick date & time'
                          : DateFormat('EEE, d MMM yyyy · h:mm a')
                              .format(_scheduledAt!),
                      style:
                          TextStyle(color: Colors.white, fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _insufficientBanner() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: BulkSmsTheme.error.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: BulkSmsTheme.error, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'You need ${_units - _balance} more units for this campaign.',
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.bulkSmsBuyCredits),
            child: Text('Buy',
                style: TextStyle(
                    color: BulkSmsTheme.primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _confirmBar() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 54.h,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _confirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: BulkSmsTheme.primary,
            disabledBackgroundColor:
                BulkSmsTheme.primary.withValues(alpha: 0.4),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
          ),
          child: _isProcessing
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  _schedule ? 'Schedule campaign' : 'Send campaign',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                ),
        ),
      ),
    );
  }
}
