import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_api.dart';
import '../data/support_models.dart';
import 'support_chat_screen.dart';

/// The support hub — the first screen for every "contact support" entry point
/// (drawer, settings help, account sheet). Lists the user's tickets split into
/// open and closed tabs, and creates new tickets (live chat or a reported
/// problem) from the floating action button. Tapping a ticket opens its thread.
class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen>
    with SingleTickerProviderStateMixin {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF4E03D0);
  static const _textSecondary = Color(0xFF9CA3AF);

  /// Users may hold at most this many open tickets at once (mirrors
  /// support-service `MaxOpenTicketsPerUser`). Only an admin can exceed it.
  static const _maxOpen = 5;

  late final SupportApi _api;
  late final TabController _tabs;
  List<SupportTicket> _tickets = [];
  bool _loading = true;
  String? _error;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _api = SupportApi(serviceLocator<SecureStorageService>());
    _tabs = TabController(length: 2, vsync: this);
    _load();
    // Keep unread badges + statuses fresh while the hub is on screen (staff
    // replies land as unread counts). Silent — never disturbs the list state
    // on a transient failure.
    _poll = Timer.periodic(const Duration(seconds: 15), (_) => _load(silent: true));
  }

  @override
  void dispose() {
    _poll?.cancel();
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _load({bool silent = false}) async {
    try {
      final t = await _api.listTickets();
      // Most recent activity first within each tab.
      t.sort((a, b) {
        final at = a.lastMessageAt, bt = b.lastMessageAt;
        if (at == null && bt == null) return 0;
        if (at == null) return 1;
        if (bt == null) return -1;
        return bt.compareTo(at);
      });
      if (!mounted) return;
      setState(() {
        _tickets = t;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted || silent) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  List<SupportTicket> get _open =>
      _tickets.where((t) => !t.isClosed).toList();
  List<SupportTicket> get _closed =>
      _tickets.where((t) => t.isClosed).toList();

  /// Opens a thread and refreshes the list on return (read/unread + status
  /// may have changed — e.g. replying to a closed ticket reopens it).
  Future<void> _openThread(SupportTicket? ticket) async {
    await Get.to(() => SupportChatScreen(ticket: ticket));
    _load(silent: true);
  }

  /// Entry point for the "Create new ticket" FAB. Reminds the user of existing
  /// open tickets, then requires a subject + first message before minting a new
  /// ticket ID. Blocks once the user is at the open-ticket cap.
  Future<void> _onCreateNewTicket() async {
    // Decide against the freshest data — an admin may have just closed or opened
    // a ticket for this user since the last poll.
    await _load(silent: true);
    if (!mounted) return;
    final open = _open;
    if (open.length >= _maxOpen) {
      await _showLimitDialog(open.length);
      return;
    }
    final result = await showModalBottomSheet<_NewTicketResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewTicketSheet(openTickets: open),
    );
    if (result == null || !mounted) return;
    await _createTicket(result.subject, result.message);
  }

  Future<void> _createTicket(String subject, String message) async {
    // Simple blocking overlay while the ticket is minted.
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: _primary)),
    );
    try {
      final ticket = await _api.createTicket(subject: subject, message: message);
      if (!mounted) return;
      Navigator.of(context).pop(); // dismiss the loader
      await _openThread(ticket);
    } on SupportTicketLimitException catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      await _showLimitDialog(e.openCount);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      // Surface a friendly message on a modal (never raw exception text).
      await _showErrorDialog(_friendlyError(e));
    }
  }

  /// Cleans an error into user-facing copy — strips the `Exception:` prefix and
  /// falls back to a generic sentence when the message isn't presentable.
  String _friendlyError(Object e) {
    final msg = e.toString().replaceFirst('Exception:', '').trim();
    if (msg.isEmpty || msg.toLowerCase().startsWith('exception')) {
      return 'Something went wrong creating your ticket. Please try again.';
    }
    return msg;
  }

  Future<void> _showErrorDialog(String message) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: const Text("Couldn't create ticket",
            style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: _textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK', style: TextStyle(color: _primary)),
          ),
        ],
      ),
    );
  }

  Future<void> _showLimitDialog(int openCount) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: const Text('Maximum open tickets reached',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'You have $openCount open tickets, which is the maximum of $_maxOpen. '
          'Please wait for one of your open tickets to be closed before creating '
          'a new one.',
          style: const TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _tabs.animateTo(0); // show the Open tab
            },
            child: const Text('View open tickets',
                style: TextStyle(color: _primary)),
          ),
        ],
      ),
    );
  }

  // ===== Build =====

  Color _statusColor(String s) {
    switch (s) {
      case 'open':
        return const Color(0xFF3B82F6);
      case 'in_progress':
        return _primary;
      case 'waiting_customer':
        return const Color(0xFFFB923C);
      case 'resolved':
      case 'closed':
        return const Color(0xFF10B981);
      default:
        return _textSecondary;
    }
  }

  String _relativeTime(DateTime? t) {
    if (t == null) return '';
    final d = DateTime.now().difference(t.toLocal());
    if (d.inMinutes < 1) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    if (d.inDays < 7) return '${d.inDays}d ago';
    final local = t.toLocal();
    return '${local.day}/${local.month}/${local.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        // Force white on the near-black background — theme-default icons
        // would render dark-on-dark (same fix as the chat screen).
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Support tickets',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _primary,
          indicatorWeight: 2.5,
          labelColor: Colors.white,
          unselectedLabelColor: _textSecondary,
          labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 13.sp),
          tabs: [
            Tab(text: _loading ? 'Open' : 'Open (${_open.length})'),
            Tab(text: _loading ? 'Closed' : 'Closed (${_closed.length})'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        // Each tap deliberately mints a NEW ticket (new ticket ID) after
        // reminding the user of any tickets they already have open.
        onPressed: _onCreateNewTicket,
        icon: const Icon(Icons.add),
        label: Text('Create new ticket',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _buildList(_open, closedTab: false),
          _buildList(_closed, closedTab: true),
        ],
      ),
    );
  }

  Widget _buildList(List<SupportTicket> tickets, {required bool closedTab}) {
    return RefreshIndicator(
      color: _primary,
      onRefresh: _load,
      child: _buildListBody(tickets, closedTab: closedTab),
    );
  }

  Widget _buildListBody(List<SupportTicket> tickets,
      {required bool closedTab}) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _primary));
    }
    if (_error != null && _tickets.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 0.25.sh),
          Center(
            child: Column(
              children: [
                Icon(Icons.cloud_off, size: 40.sp, color: _textSecondary),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Text('Couldn\'t load your tickets.\n$_error',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: _textSecondary, fontSize: 13.sp)),
                ),
                SizedBox(height: 16.h),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _loading = true;
                      _error = null;
                    });
                    _load();
                  },
                  icon: Icon(Icons.refresh, color: Colors.white, size: 18.sp),
                  label: const Text('Try again',
                      style: TextStyle(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: _primary)),
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (tickets.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 0.25.sh),
          Center(
            child: Column(
              children: [
                Icon(
                  closedTab
                      ? Icons.inventory_2_outlined
                      : Icons.support_agent_outlined,
                  size: 48.sp,
                  color: _textSecondary,
                ),
                SizedBox(height: 12.h),
                Text(
                  closedTab ? 'No closed tickets' : 'No open tickets',
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
                SizedBox(height: 6.h),
                Text(
                  closedTab
                      ? 'Resolved conversations will show up here'
                      : 'Need a hand? Open a ticket and our team will reply',
                  style: TextStyle(color: _textSecondary, fontSize: 12.sp),
                ),
                if (!closedTab) ...[
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: _primary),
                    onPressed: _onCreateNewTicket,
                    child: const Text('Create new ticket',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    }
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      // Bottom inset keeps the FAB from covering the last ticket row.
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
      itemCount: tickets.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, i) => _ticketTile(tickets[i]),
    );
  }

  Widget _ticketTile(SupportTicket t) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () => _openThread(t),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                t.kind == 'report'
                    ? Icons.bug_report_outlined
                    : Icons.chat_outlined,
                color: _primary,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.subject.isNotEmpty ? t.subject : 'Chat with support',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (t.lastMessageAt != null)
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(_relativeTime(t.lastMessageAt),
                              style: TextStyle(
                                  color: _textSecondary, fontSize: 10.sp)),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _statusColor(t.status).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          t.status.replaceAll('_', ' '),
                          style: TextStyle(
                              color: _statusColor(t.status),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(t.ticketNumber,
                          style: TextStyle(
                              color: _textSecondary, fontSize: 10.sp)),
                    ],
                  ),
                ],
              ),
            ),
            if (t.unreadForUser > 0)
              Container(
                margin: EdgeInsets.only(left: 8.w),
                padding: EdgeInsets.all(6.w),
                constraints: BoxConstraints(minWidth: 22.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${t.unreadForUser}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Payload returned by [_NewTicketSheet] once the user confirms creation.
class _NewTicketResult {
  final String subject;
  final String message;
  const _NewTicketResult(this.subject, this.message);
}

/// Bottom sheet for creating a new ticket. Reminds the user of any existing open
/// tickets (so they don't pile up duplicates) and makes clear a NEW ticket ID is
/// being assigned. Owns + disposes its own controllers to avoid the dispose-timing
/// crash seen when disposing in `whenComplete`.
class _NewTicketSheet extends StatefulWidget {
  final List<SupportTicket> openTickets;
  const _NewTicketSheet({required this.openTickets});

  @override
  State<_NewTicketSheet> createState() => _NewTicketSheetState();
}

class _NewTicketSheetState extends State<_NewTicketSheet> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF4E03D0);
  static const _textSecondary = Color(0xFF9CA3AF);

  // Character limits — kept in sync with support-service (maxUserText=5000,
  // maxSubjectLen=160). The field enforces them and shows a live counter.
  static const _maxMessage = 5000;
  static const _maxSubject = 160;

  final _subject = TextEditingController();
  final _message = TextEditingController();
  bool _showError = false;

  @override
  void dispose() {
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  void _submit() {
    final subject = _subject.text.trim();
    final message = _message.text.trim();
    if (subject.isEmpty || message.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    Navigator.of(context).pop(_NewTicketResult(subject, message));
  }

  @override
  Widget build(BuildContext context) {
    final open = widget.openTickets;
    return Padding(
      // Lift the sheet above the keyboard.
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _textSecondary.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Create a new ticket',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 6.h),
              Text(
                'A new ticket ID will be assigned. Keep separate issues in separate '
                'tickets so our team can track each one.',
                style: TextStyle(color: _textSecondary, fontSize: 12.sp),
              ),
              if (open.isNotEmpty) ...[
                SizedBox(height: 14.h),
                _existingTicketsReminder(open),
              ],
              SizedBox(height: 18.h),
              _label('Subject'),
              SizedBox(height: 6.h),
              _field(_subject, 'Short summary of your issue',
                  minLines: 1, maxLines: 1, maxLength: _maxSubject),
              SizedBox(height: 14.h),
              _label('Message'),
              SizedBox(height: 6.h),
              // Roomy, growing field for a full description (expands to ~12 lines
              // then scrolls); capped + counted against the standard limit.
              _field(_message, 'Describe what you need help with in detail',
                  minLines: 6, maxLines: 12, maxLength: _maxMessage),
              if (_showError) ...[
                SizedBox(height: 10.h),
                Text('Please add a subject and a message.',
                    style: TextStyle(
                        color: const Color(0xFFEF4444), fontSize: 12.sp)),
              ],
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: BorderSide(
                            color: _textSecondary.withValues(alpha: 0.4)),
                      ),
                      child: Text('Cancel',
                          style: TextStyle(
                              color: Colors.white, fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text('Continue',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _existingTicketsReminder(List<SupportTicket> open) {
    // Show up to a few of the user's open tickets so they can decide whether they
    // really need a new one, or should reply to an existing thread instead.
    final preview = open.take(3).toList();
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
            color: const Color(0xFFFB923C).withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline,
                  size: 15.sp, color: const Color(0xFFFB923C)),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  open.length == 1
                      ? 'You already have 1 open ticket:'
                      : 'You already have ${open.length} open tickets:',
                  style: TextStyle(
                      color: const Color(0xFFFB923C),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ...preview.map((t) => Padding(
                padding: EdgeInsets.only(top: 3.h, left: 23.w),
                child: Text(
                  '• ${t.ticketNumber}${t.subject.isNotEmpty ? ' — ${t.subject}' : ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: _textSecondary, fontSize: 11.sp),
                ),
              )),
          if (open.length > preview.length)
            Padding(
              padding: EdgeInsets.only(top: 3.h, left: 23.w),
              child: Text('and ${open.length - preview.length} more…',
                  style: TextStyle(color: _textSecondary, fontSize: 11.sp)),
            ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: TextStyle(
          color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600));

  Widget _field(TextEditingController c, String hint,
      {required int minLines, required int maxLines, required int maxLength}) {
    return TextField(
      controller: c,
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      // Rebuild the counter as the user types.
      onChanged: (_) => setState(() {}),
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      // Dark-theme styled live counter (turns red at the limit).
      buildCounter: (context,
          {required int currentLength, required bool isFocused, int? maxLength}) {
        final max = maxLength ?? 0;
        return Padding(
          padding: EdgeInsets.only(top: 4.h, right: 2.w),
          child: Text(
            '$currentLength/$max',
            style: TextStyle(
              color: currentLength >= max
                  ? const Color(0xFFEF4444)
                  : _textSecondary,
              fontSize: 11.sp,
            ),
          ),
        );
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: _textSecondary, fontSize: 13.sp),
        filled: true,
        fillColor: _card,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
