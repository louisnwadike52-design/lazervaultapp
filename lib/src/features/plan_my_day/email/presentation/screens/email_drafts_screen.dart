import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_state.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/email_palette.dart';

/// Approval queue: pending AI drafts awaiting the user's approval. Each shows
/// the draft body with Approve (send) / Discard / Edit-then-send.
class EmailDraftsScreen extends StatefulWidget {
  const EmailDraftsScreen({super.key});

  @override
  State<EmailDraftsScreen> createState() => _EmailDraftsScreenState();
}

class _EmailDraftsScreenState extends State<EmailDraftsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmailCubit>().loadDrafts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmailPalette.background,
      appBar: AppBar(
        backgroundColor: EmailPalette.card,
        elevation: 0,
        title: Text('Approval queue',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<EmailCubit, EmailState>(
        listenWhen: (_, s) => s is EmailError,
        listener: (context, state) {
          if (state is EmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, s) => s is EmailDraftsLoading || s is EmailDraftsLoaded,
        builder: (context, state) {
          if (state is EmailDraftsLoading) {
            return const Center(child: LazerVaultLoader.small());
          }
          if (state is EmailDraftsLoaded) {
            if (state.drafts.isEmpty) return _empty();
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
              itemCount: state.drafts.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (_, i) => _draftCard(state.drafts[i]),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _empty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined,
                color: EmailPalette.textSecondary, size: 48.sp),
            SizedBox(height: 12.h),
            Text('No drafts awaiting approval',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 6.h),
            Text(
              'Auto-reply rules in approve mode will queue drafts here for you '
              'to review before sending.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary, fontSize: 13.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _draftCard(EmailDraft draft) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: EmailPalette.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: EmailPalette.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  draft.subject.isEmpty ? '(no subject)' : draft.subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: EmailPalette.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Pending',
                    style: GoogleFonts.inter(
                        color: EmailPalette.warning,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          if (draft.toAddr.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text('To ${draft.toAddr}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    color: EmailPalette.textSecondary, fontSize: 12.sp)),
          ],
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: EmailPalette.background,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              draft.body,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary,
                  fontSize: 13.sp,
                  height: 1.45),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => _editThenSend(draft),
                icon: const Icon(Icons.edit_outlined,
                    size: 16, color: EmailPalette.textSecondary),
                label: Text('Edit',
                    style: GoogleFonts.inter(
                        color: EmailPalette.textSecondary, fontSize: 13.sp)),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () =>
                    context.read<EmailCubit>().discardDraft(draft.id),
                style: OutlinedButton.styleFrom(
                  foregroundColor: EmailPalette.error,
                  side: BorderSide(
                      color: EmailPalette.error.withValues(alpha: 0.5)),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text('Discard',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, fontWeight: FontWeight.w600)),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () =>
                    context.read<EmailCubit>().approveDraft(draft.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: EmailPalette.success,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text('Approve',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _editThenSend(EmailDraft draft) async {
    final controller = TextEditingController(text: draft.body);
    final cubit = context.read<EmailCubit>();
    final edited = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: EmailPalette.card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit reply',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),
              TextField(
                controller: controller,
                maxLines: 8,
                minLines: 4,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: EmailPalette.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: EmailPalette.divider),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: EmailPalette.divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: EmailPalette.primary),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(ctx, controller.text),
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: Text('Approve and send',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EmailPalette.success,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    controller.dispose();
    if (edited != null && edited.trim().isNotEmpty) {
      cubit.approveDraft(draft.id, editedBody: edited);
    }
  }
}
