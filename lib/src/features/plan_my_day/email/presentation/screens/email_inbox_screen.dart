import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_state.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/screens/email_drafts_screen.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/screens/email_settings_screen.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/screens/email_thread_screen.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/widgets/email_palette.dart';
part 'email_inbox_screen_widgets.dart';


/// Email home / inbox inside Plan My Day. Shows a connect banner when not
/// connected; otherwise a range selector, sync action, AI digest and a
/// paginated list of summarized emails.
class EmailInboxScreen extends StatefulWidget {
  const EmailInboxScreen({super.key});

  @override
  State<EmailInboxScreen> createState() => _EmailInboxScreenState();
}

class _EmailInboxScreenState extends State<EmailInboxScreen> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<EmailCubit>().loadInbox();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 300) {
      context.read<EmailCubit>().loadMore();
    }
  }

  void _openThread(EmailMessage message) {
    final cubit = context.read<EmailCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: EmailThreadScreen(gmailMessageId: message.gmailMessageId),
        ),
      ),
    ).then((_) => cubit.loadInbox());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EmailPalette.background,
      appBar: AppBar(
        backgroundColor: EmailPalette.card,
        elevation: 0,
        title: Text(
          'Inbox',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: 'Approval queue',
            icon: const Icon(Icons.drafts_outlined, color: Colors.white),
            onPressed: () {
              final cubit = context.read<EmailCubit>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const EmailDraftsScreen(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Email settings',
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              final cubit = context.read<EmailCubit>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const EmailSettingsScreen(),
                  ),
                ),
              ).then((_) => cubit.loadInbox());
            },
          ),
        ],
      ),
      body: BlocConsumer<EmailCubit, EmailState>(
        listenWhen: (_, s) => s is EmailSynced || s is EmailError,
        listener: (context, state) {
          if (state is EmailSynced) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.newCount == 0
                  ? 'You are up to date'
                  : '${state.newCount} new email${state.newCount == 1 ? '' : 's'} synced'),
            ));
          } else if (state is EmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (_, s) =>
            s is EmailLoading ||
            s is EmailNotConnected ||
            s is EmailConnecting ||
            s is EmailInboxLoaded,
        builder: (context, state) {
          if (state is EmailConnecting) {
            return _centered(
              const LazerVaultLoader.small(),
              label: 'Connecting your Gmail...',
            );
          }
          if (state is EmailNotConnected) {
            return _ConnectBanner(message: state.message);
          }
          if (state is EmailLoading) {
            return const Center(child: LazerVaultLoader.small());
          }
          if (state is EmailInboxLoaded) {
            return _buildInbox(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _centered(Widget child, {String? label}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (label != null) ...[
            SizedBox(height: 14.h),
            Text(label,
                style: GoogleFonts.inter(
                    color: EmailPalette.textSecondary, fontSize: 13.sp)),
          ],
        ],
      ),
    );
  }

  Widget _buildInbox(EmailInboxLoaded state) {
    return Column(
      children: [
        _rangeBar(state),
        Expanded(
          child: RefreshIndicator(
            color: EmailPalette.primary,
            backgroundColor: EmailPalette.card,
            onRefresh: () =>
                context.read<EmailCubit>().loadInbox(range: state.range),
            child: ListView(
              controller: _scroll,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
              children: [
                if (state.digest.trim().isNotEmpty) ...[
                  _digestCard(state.digest),
                  SizedBox(height: 16.h),
                ],
                _buildDayButton(state.range),
                SizedBox(height: 16.h),
                if (state.messages.isEmpty)
                  _emptyState()
                else
                  ...state.messages.map((m) => _messageTile(m)),
                if (state.loadingMore) ...[
                  SizedBox(height: 16.h),
                  const Center(child: LazerVaultLoader.small()),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rangeBar(EmailInboxLoaded state) {
    Widget chip(String label, String value) {
      final selected = state.range == value;
      return Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: GestureDetector(
          onTap: () => context.read<EmailCubit>().changeRange(value),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selected ? EmailPalette.primary : EmailPalette.card,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: selected ? EmailPalette.primary : EmailPalette.divider,
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: selected ? Colors.white : EmailPalette.textSecondary,
                fontSize: 12.5.sp,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      color: EmailPalette.card,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 8.w, 10.h),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  chip('Today', 'today'),
                  chip('Last 24h', 'last_24h'),
                  chip('Last 7 days', 'last_7d'),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: 'Sync now',
            onPressed: state.syncing
                ? null
                : () => context.read<EmailCubit>().syncNow(),
            icon: state.syncing
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(EmailPalette.primary),
                    ),
                  )
                : const Icon(Icons.sync, color: EmailPalette.primary),
          ),
        ],
      ),
    );
  }

  Widget _digestCard(String digest) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF1F1F1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: EmailPalette.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome,
                  color: const Color(0xFF8B5CF6), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Your email digest',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            digest,
            style: GoogleFonts.inter(
              color: EmailPalette.textSecondary,
              fontSize: 13.sp,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(String range) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _confirmBuildDay(range),
        icon: const Icon(Icons.playlist_add_check_rounded, size: 20),
        label: Text(
          'Build my day from emails',
          style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: EmailPalette.success,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
      ),
    );
  }

  void _confirmBuildDay(String range) async {
    final cubit = context.read<EmailCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    // Kick off the build; listen for the result once.
    late final void Function() removeListener;
    void listener() {
      final s = cubit.state;
      if (s is EmailDayBuilt) {
        removeListener();
        messenger.showSnackBar(SnackBar(
          content: Text(s.result.message.isNotEmpty
              ? s.result.message
              : 'Added ${s.result.createdTasks} tasks, ${s.result.createdEvents} events, ${s.result.createdBlocks} blocks'),
        ));
        // Pop back so the Plan My Day board refreshes.
        navigator.pop();
      } else if (s is EmailError) {
        removeListener();
        messenger.showSnackBar(SnackBar(content: Text(s.message)));
        cubit.loadInbox(range: range);
      }
    }

    final sub = cubit.stream.listen((_) => listener());
    removeListener = sub.cancel;
    await cubit.buildDay(range: range);
  }

  Widget _emptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 48.h),
      child: Column(
        children: [
          Icon(Icons.mark_email_read_outlined,
              color: EmailPalette.textSecondary, size: 48.sp),
          SizedBox(height: 12.h),
          Text(
            'No emails in this range',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Tap sync to pull the latest, or widen the range.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                color: EmailPalette.textSecondary, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }

  Widget _messageTile(EmailMessage m) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () => _openThread(m),
          child: Container(
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
                    if (!m.isRead)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: const BoxDecoration(
                          color: EmailPalette.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Expanded(
                      child: Text(
                        m.fromDisplay,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight:
                              m.isRead ? FontWeight.w500 : FontWeight.w700,
                        ),
                      ),
                    ),
                    if (m.receivedAt != null)
                      Text(
                        _timeLabel(m.receivedAt!),
                        style: GoogleFonts.inter(
                            color: EmailPalette.textSecondary, fontSize: 11.sp),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  m.subject.isEmpty ? '(no subject)' : m.subject,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: EmailPalette.textSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (m.summary.trim().isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: EmailPalette.background,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.auto_awesome,
                            size: 13.sp, color: const Color(0xFF8B5CF6)),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            m.summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: EmailPalette.textSecondary,
                              fontSize: 12.sp,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (m.snippet.trim().isNotEmpty) ...[
                  SizedBox(height: 6.h),
                  Text(
                    m.snippet,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: EmailPalette.textSecondary, fontSize: 12.sp),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _timeLabel(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return DateFormat('HH:mm').format(dt);
    }
    return DateFormat('MMM d').format(dt);
  }
}
