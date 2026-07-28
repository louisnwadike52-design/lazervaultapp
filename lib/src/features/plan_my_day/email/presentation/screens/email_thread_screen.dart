import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_state.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/email_palette.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/tone_selector.dart';

/// Thread view: fetches the full body on demand and offers an AI reply composer
/// (tone selector -> AI draft in an editable field -> send, with an auto-send
/// toggle that sends immediately once the draft is ready).
class EmailThreadScreen extends StatefulWidget {
  final String gmailMessageId;
  const EmailThreadScreen({super.key, required this.gmailMessageId});

  @override
  State<EmailThreadScreen> createState() => _EmailThreadScreenState();
}

class _EmailThreadScreenState extends State<EmailThreadScreen> {
  final TextEditingController _replyController = TextEditingController();
  String _tone = 'professional';
  bool _autoSend = false;
  bool _composerOpen = false;
  // Tracks the draft id we've already synced into the reply field, so we don't
  // clobber the user's edits every rebuild.
  String? _syncedDraftId;

  @override
  void initState() {
    super.initState();
    context.read<EmailCubit>().openThread(widget.gmailMessageId);
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _draftReply() {
    setState(() => _composerOpen = true);
    context.read<EmailCubit>().draftReply(tone: _tone);
  }

  void _send() {
    final draftId = _currentDraftId;
    context.read<EmailCubit>().sendReply(
          body: _replyController.text,
          draftId: draftId,
        );
  }

  String? _currentDraftId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmailPalette.background,
      appBar: AppBar(
        backgroundColor: EmailPalette.card,
        elevation: 0,
        title: Text('Email',
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
        listener: (context, state) {
          if (state is EmailReplySent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reply sent')),
            );
            Navigator.pop(context);
          } else if (state is EmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EmailThreadLoaded && state.draft != null) {
            // Populate the reply field once when a fresh AI draft arrives.
            final d = state.draft!;
            _currentDraftId = d.id;
            if (_syncedDraftId != d.id) {
              _syncedDraftId = d.id;
              _replyController.text = d.body;
              // Auto-send toggle: send immediately once the draft is ready.
              if (_autoSend) {
                context.read<EmailCubit>().sendReply(
                      body: d.body,
                      draftId: d.id,
                    );
              }
            }
          }
        },
        builder: (context, state) {
          if (state is EmailThreadLoading) {
            return const Center(child: LazerVaultLoader.small());
          }
          if (state is EmailThreadLoaded) {
            return _buildThread(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildThread(EmailThreadLoaded state) {
    final m = state.detail.message;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.subject.isEmpty ? '(no subject)' : m.subject,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        m.fromAddr,
                        style: GoogleFonts.inter(
                            color: EmailPalette.textSecondary, fontSize: 13.sp),
                      ),
                    ),
                    if (m.receivedAt != null)
                      Text(
                        DateFormat('MMM d, HH:mm').format(m.receivedAt!),
                        style: GoogleFonts.inter(
                            color: EmailPalette.textSecondary, fontSize: 12.sp),
                      ),
                  ],
                ),
                if (m.summary.trim().isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  _summaryCard(m.summary),
                ],
                SizedBox(height: 16.h),
                Divider(color: EmailPalette.divider, height: 1),
                SizedBox(height: 16.h),
                if (state.detail.body.trim().isEmpty)
                  Text(
                    m.snippet.isEmpty ? 'No content.' : m.snippet,
                    style: GoogleFonts.inter(
                        color: EmailPalette.textSecondary,
                        fontSize: 14.sp,
                        height: 1.5),
                  )
                else
                  Text(
                    state.detail.body,
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp, height: 1.55),
                  ),
                SizedBox(height: 20.h),
                if (_composerOpen) _composer(state),
              ],
            ),
          ),
        ),
        if (!_composerOpen) _replyBar(),
      ],
    );
  }

  Widget _summaryCard(String summary) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: EmailPalette.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: EmailPalette.accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, color: EmailPalette.accent, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              summary,
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary,
                  fontSize: 13.sp,
                  height: 1.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _replyBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
        decoration: const BoxDecoration(
          color: EmailPalette.card,
          border: Border(top: BorderSide(color: EmailPalette.divider)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _draftReply,
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: Text('Draft reply with AI',
                style: GoogleFonts.inter(
                    fontSize: 14.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: EmailPalette.accent,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _composer(EmailThreadLoaded state) {
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
              Icon(Icons.reply_rounded, color: EmailPalette.primary, size: 18.sp),
              SizedBox(width: 8.w),
              Text('AI reply',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: EmailPalette.textSecondary),
                onPressed: () => setState(() => _composerOpen = false),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text('Tone',
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary, fontSize: 12.sp)),
          SizedBox(height: 8.h),
          ToneSelector(
            selected: _tone,
            onChanged: (t) => setState(() => _tone = t),
          ),
          SizedBox(height: 12.h),
          if (state.drafting)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                children: [
                  const LazerVaultLoader.small(),
                  SizedBox(width: 12.w),
                  Text('Drafting a reply...',
                      style: GoogleFonts.inter(
                          color: EmailPalette.textSecondary, fontSize: 13.sp)),
                ],
              ),
            )
          else ...[
            TextField(
              controller: _replyController,
              maxLines: 8,
              minLines: 4,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Your reply will appear here...',
                hintStyle: GoogleFonts.inter(
                    color: EmailPalette.textSecondary, fontSize: 13.sp),
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
            SizedBox(height: 12.h),
            Row(
              children: [
                Switch(
                  value: _autoSend,
                  activeThumbColor: EmailPalette.success,
                  onChanged: (v) => setState(() => _autoSend = v),
                ),
                Expanded(
                  child: Text(
                    'Auto-send when the AI draft is ready',
                    style: GoogleFonts.inter(
                        color: EmailPalette.textSecondary, fontSize: 12.5.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: state.sending ? null : _draftReply,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text('Redraft',
                        style: GoogleFonts.inter(
                            fontSize: 13.sp, fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: EmailPalette.divider),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.sending ? null : _send,
                    icon: state.sending
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.send_rounded, size: 18),
                    label: Text('Send',
                        style: GoogleFonts.inter(
                            fontSize: 13.sp, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EmailPalette.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
