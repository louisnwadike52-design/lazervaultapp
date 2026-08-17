import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_state.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/email_palette.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/tone_selector.dart';
part 'email_settings_screen_widgets.dart';


/// Settings: connect/disconnect, auto-reply on/off, daily digest hour, and
/// managing auto-reply rules (list + add + delete).
class EmailSettingsScreen extends StatefulWidget {
  const EmailSettingsScreen({super.key});

  @override
  State<EmailSettingsScreen> createState() => _EmailSettingsScreenState();
}

class _EmailSettingsScreenState extends State<EmailSettingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmailCubit>().loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmailPalette.background,
      appBar: AppBar(
        backgroundColor: EmailPalette.card,
        elevation: 0,
        title: Text('Email settings',
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
        listenWhen: (_, s) =>
            s is EmailError || s is EmailDisconnected || s is EmailNotConnected,
        listener: (context, state) {
          if (state is EmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is EmailDisconnected) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gmail disconnected')),
            );
            context.read<EmailCubit>().loadSettings();
          } else if (state is EmailNotConnected) {
            // After a connect attempt from settings, refresh.
            context.read<EmailCubit>().loadSettings();
          }
        },
        buildWhen: (_, s) => s is EmailSettingsLoading || s is EmailSettingsLoaded,
        builder: (context, state) {
          if (state is EmailSettingsLoading) {
            return const Center(child: LazerVaultLoader.small());
          }
          if (state is EmailSettingsLoaded) {
            return _buildSettings(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSettings(EmailSettingsLoaded state) {
    final connected = state.status.connected;
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      children: [
        _connectionCard(state),
        if (connected) ...[
          SizedBox(height: 16.h),
          _autoReplyCard(state),
          SizedBox(height: 16.h),
          _digestCard(state),
          SizedBox(height: 16.h),
          _rulesSection(state),
        ],
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: EmailPalette.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: EmailPalette.divider),
      ),
      child: child,
    );
  }

  Widget _connectionCard(EmailSettingsLoaded state) {
    final connected = state.status.connected;
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline_rounded,
                  color: connected ? EmailPalette.success : EmailPalette.primary,
                  size: 22.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(connected ? 'Gmail connected' : 'Gmail not connected',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                    if (connected && state.status.email.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Text(state.status.email,
                          style: GoogleFonts.inter(
                              color: EmailPalette.textSecondary,
                              fontSize: 12.5.sp)),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          if (connected)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _confirmDisconnect(),
                icon: const Icon(Icons.link_off_rounded, size: 18),
                label: Text('Disconnect',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: EmailPalette.error,
                  side:
                      BorderSide(color: EmailPalette.error.withValues(alpha: 0.5)),
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.read<EmailCubit>().connect(),
                icon: const Icon(Icons.login_rounded, size: 18),
                label: Text('Connect Gmail',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: EmailPalette.primary,
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
    );
  }

  Widget _autoReplyCard(EmailSettingsLoaded state) {
    return _card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Auto-reply',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Text('Let rules draft or send replies for matching emails.',
                    style: GoogleFonts.inter(
                        color: EmailPalette.textSecondary, fontSize: 12.5.sp)),
              ],
            ),
          ),
          Switch(
            value: state.status.autoReplyEnabled,
            activeThumbColor: EmailPalette.success,
            onChanged: state.saving
                ? null
                : (v) =>
                    context.read<EmailCubit>().updateSettings(autoReplyEnabled: v),
          ),
        ],
      ),
    );
  }

  Widget _digestCard(EmailSettingsLoaded state) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily digest',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text('When to deliver your morning email summary.',
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary, fontSize: 12.5.sp)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(_formatHour(state.status.digestHour),
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
              const Spacer(),
              TextButton(
                onPressed: state.saving
                    ? null
                    : () => _pickDigestHour(state.status.digestHour),
                child: Text('Change',
                    style: GoogleFonts.inter(
                        color: EmailPalette.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rulesSection(EmailSettingsLoaded state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Auto-reply rules',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            TextButton.icon(
              onPressed: () => _showRuleSheet(),
              icon: const Icon(Icons.add, size: 18, color: EmailPalette.primary),
              label: Text('Add',
                  style: GoogleFonts.inter(
                      color: EmailPalette.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (state.rules.isEmpty)
          _card(
            child: Text(
              'No rules yet. Add a rule to auto-draft or auto-send replies for '
              'emails from a sender or with a subject keyword.',
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary, fontSize: 13.sp, height: 1.4),
            ),
          )
        else
          ...state.rules.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _ruleCard(r),
              )),
      ],
    );
  }

  Widget _ruleCard(EmailRule rule) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(rule.name.isEmpty ? 'Rule' : rule.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
              _pill(
                rule.mode == 'auto_send' ? 'Auto-send' : 'Approve',
                rule.mode == 'auto_send'
                    ? EmailPalette.success
                    : EmailPalette.warning,
              ),
              SizedBox(width: 6.w),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete_outline,
                    size: 20, color: EmailPalette.error),
                onPressed: () =>
                    context.read<EmailCubit>().deleteRule(rule.id),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              if (rule.fromContains.isNotEmpty)
                _tag('from: ${rule.fromContains}'),
              if (rule.subjectContains.isNotEmpty)
                _tag('subject: ${rule.subjectContains}'),
              if (rule.tone.isNotEmpty) _tag('tone: ${rule.tone}'),
              _tag(rule.enabled ? 'enabled' : 'disabled'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: color, fontSize: 10.sp, fontWeight: FontWeight.w600)),
    );
  }

  Widget _tag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: EmailPalette.background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(label,
          style: GoogleFonts.inter(
              color: EmailPalette.textSecondary, fontSize: 11.sp)),
    );
  }

  String _formatHour(int hour) {
    final h = hour % 24;
    final period = h < 12 ? 'AM' : 'PM';
    final display = h % 12 == 0 ? 12 : h % 12;
    return '$display:00 $period';
  }

  void _confirmDisconnect() async {
    final cubit = context.read<EmailCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: EmailPalette.card,
        title: Text('Disconnect Gmail?',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
        content: Text(
          'Lazervault will stop summarizing your inbox and sending replies. You '
          'can reconnect anytime.',
          style: GoogleFonts.inter(
              color: EmailPalette.textSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: EmailPalette.textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Disconnect',
                style: GoogleFonts.inter(
                    color: EmailPalette.error, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    if (confirmed == true) cubit.disconnect();
  }

  void _pickDigestHour(int current) async {
    final cubit = context.read<EmailCubit>();
    final picked = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: 320.h,
        decoration: BoxDecoration(
          color: EmailPalette.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text('Digest hour',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 24,
                itemBuilder: (_, h) => ListTile(
                  title: Text(_formatHour(h),
                      style: GoogleFonts.inter(
                          color: h == current
                              ? EmailPalette.primary
                              : Colors.white,
                          fontSize: 15.sp,
                          fontWeight:
                              h == current ? FontWeight.w600 : FontWeight.w400)),
                  trailing: h == current
                      ? const Icon(Icons.check, color: EmailPalette.primary)
                      : null,
                  onTap: () => Navigator.pop(ctx, h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (picked != null) cubit.updateSettings(digestHour: picked);
  }

  void _showRuleSheet() async {
    final cubit = context.read<EmailCubit>();
    final rule = await showModalBottomSheet<EmailRule>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _RuleFormSheet(),
    );
    if (rule != null) cubit.saveRule(rule);
  }
}
