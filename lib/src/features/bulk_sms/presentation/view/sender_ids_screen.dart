import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import 'bulk_sms_theme.dart';

/// Sender IDs: list existing registrations (getSenderIds) and request a new one
/// (requestSenderId), showing pending / approved / rejected states.
class SenderIdsScreen extends StatefulWidget {
  const SenderIdsScreen({super.key});

  @override
  State<SenderIdsScreen> createState() => _SenderIdsScreenState();
}

class _SenderIdsScreenState extends State<SenderIdsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BulkSmsCubit>().loadSenderIds();
  }

  Color _statusColor(SenderIdStatusEnum s) => switch (s) {
        SenderIdStatusEnum.approved => BulkSmsTheme.success,
        SenderIdStatusEnum.pending => BulkSmsTheme.warning,
        SenderIdStatusEnum.rejected => BulkSmsTheme.error,
        SenderIdStatusEnum.unknown => BulkSmsTheme.textSecondary,
      };

  Future<void> _openRequestSheet() async {
    final idController = TextEditingController();
    final purposeController = TextEditingController();
    final cubit = context.read<BulkSmsCubit>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: BulkSmsTheme.bg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Request sender ID',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6.h),
                Text(
                  'A sender ID is the name your recipients see (max 11 chars). It needs provider approval before use.',
                  style: TextStyle(
                      color: BulkSmsTheme.textSecondary,
                      fontSize: 12.sp,
                      height: 1.4),
                ),
                SizedBox(height: 16.h),
                _field(idController, 'Sender ID (e.g. LazerVault)',
                    maxLength: 11,
                    formatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9 ]')),
                    ]),
                SizedBox(height: 12.h),
                _field(purposeController, 'Purpose (e.g. Customer alerts)',
                    maxLength: 120),
                SizedBox(height: 18.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final id = idController.text.trim();
                      final purpose = purposeController.text.trim();
                      if (id.isEmpty) {
                        LVSnackbar.showError(
                            title: 'Sender ID required',
                            message: 'Enter the sender ID you want to register.');
                        return;
                      }
                      Navigator.of(ctx).pop();
                      cubit.requestSenderId(
                        senderId: id,
                        country: 'NG',
                        purpose: purpose,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BulkSmsTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text('Submit request',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        );
      },
    );
    idController.dispose();
    purposeController.dispose();
  }

  Widget _field(
    TextEditingController controller,
    String hint, {
    int? maxLength,
    List<TextInputFormatter>? formatters,
  }) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      inputFormatters: formatters,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        counterStyle:
            TextStyle(color: BulkSmsTheme.textSecondary, fontSize: 10.sp),
        hintStyle:
            TextStyle(color: BulkSmsTheme.textSecondary, fontSize: 13.sp),
        filled: true,
        fillColor: BulkSmsTheme.card,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BulkSmsCubit, BulkSmsState>(
      listenWhen: (p, c) =>
          p.senderIdRequestStatus != c.senderIdRequestStatus,
      listener: (context, state) {
        if (state.senderIdRequestStatus == ActionStatus.success) {
          LVSnackbar.showSuccess(
            title: 'Request submitted',
            message: 'Your sender ID is pending approval.',
          );
        } else if (state.senderIdRequestStatus == ActionStatus.failed) {
          LVSnackbar.showError(
            title: 'Request failed',
            message: state.errorMessage ?? 'Please try again.',
          );
        }
      },
      child: Scaffold(
        backgroundColor: BulkSmsTheme.bg,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _openRequestSheet,
          backgroundColor: BulkSmsTheme.primary,
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text('Request',
              style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        ),
        body: SafeArea(
          child: Column(
            children: [
              BulkSmsHeader(
                title: 'Sender IDs',
                subtitle: 'The name recipients see',
                onBack: () => Get.back(),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: BulkSmsTheme.primary,
                  onRefresh: () =>
                      context.read<BulkSmsCubit>().loadSenderIds(),
                  child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
                    builder: (context, state) => _body(state),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BulkSmsState state) {
    if (state.senderIdsStatus == SectionStatus.loading &&
        state.senderIds.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: BulkSmsTheme.primary));
    }
    if (state.senderIds.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 60),
          BulkSmsEmptyState(
            icon: Icons.badge_outlined,
            title: 'Sending as "Lazervault"',
            subtitle:
                'Your messages already go out under our registered "Lazervault" '
                'sender — no setup needed. Optionally request your own branded '
                'sender name below (subject to network approval).',
          ),
        ],
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.senderIds.length,
      itemBuilder: (context, i) => _tile(state.senderIds[i]),
    );
  }

  Widget _tile(SenderIdEntity s) {
    final color = _statusColor(s.status);
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: BulkSmsTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38.w,
                height: 38.w,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.badge_rounded, color: color, size: 18.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(s.senderId,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(s.status.label,
                    style: TextStyle(
                        color: color,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          if (s.status == SenderIdStatusEnum.rejected &&
              s.rejectionReason.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text('Reason: ${s.rejectionReason}',
                style: TextStyle(color: BulkSmsTheme.error, fontSize: 11.sp)),
          ],
          if (s.country.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text('Country: ${s.country}',
                style: TextStyle(
                    color: BulkSmsTheme.textSecondary, fontSize: 11.sp)),
          ],
        ],
      ),
    );
  }
}
