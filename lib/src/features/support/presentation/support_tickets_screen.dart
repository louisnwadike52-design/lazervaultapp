import 'dart:async';
import 'package:lazervault/src/features/support/presentation/support_sla_notice.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_api.dart';
import '../data/support_models.dart';
import 'support_chat_screen.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';
part 'support_tickets_screen_widgets.dart';

/// The support hub — the first screen for every "contact support" entry point
/// (drawer, settings help, account sheet). Lists the user's tickets split into
/// open and closed tabs, and creates new tickets (live chat or a reported
/// problem) from the floating action button. Tapping a ticket opens its thread.
class SupportTicketsScreen extends StatefulWidget {
  /// When set, the create-ticket composer opens straight away, pre-filled.
  ///
  /// For refusals that can only be resolved by a person — an identity number
  /// already linked to another account, a date of birth that cannot be edited
  /// in the app — the screen used to open on an empty ticket list with a FAB,
  /// so the customer had to find the button, then compose an explanation of a
  /// failure we had already classified. See [openKycProfileFix].
  /// A ticket number to open on arrival, from a "support replied" push.
  ///
  /// The list still loads behind it, so a stale or already-deleted number
  /// degrades to the list rather than a blank screen — the reply is in there
  /// either way.
  final String? openTicketNumber;

  final String? composeSubject;
  final String? composeMessage;

  const SupportTicketsScreen({
    super.key,
    this.openTicketNumber,
    this.composeSubject,
    this.composeMessage,
  });

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
    _loadSlaNotice();
    // Opened FOR a specific problem: go straight to the composer rather than
    // making the customer find the FAB. After the first frame so the sheet has
    // a mounted Navigator, and only once.
    if ((widget.composeSubject ?? '').trim().isNotEmpty ||
        (widget.composeMessage ?? '').trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _onCreateNewTicket();
      });
    }
    // Keep unread badges + statuses fresh while the hub is on screen (staff
    // replies land as unread counts). Silent — never disturbs the list state
    // on a transient failure.
    _poll =
        Timer.periodic(const Duration(seconds: 15), (_) => _load(silent: true));
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
      _openDeepLinkedTicket();
    } catch (e) {
      if (!mounted || silent) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  List<SupportTicket> get _open => _tickets.where((t) => !t.isClosed).toList();
  List<SupportTicket> get _closed => _tickets.where((t) => t.isClosed).toList();

  /// Opens a thread and refreshes the list on return (read/unread + status
  /// may have changed — e.g. replying to a closed ticket reopens it).
  /// Whether the push-linked ticket has already been opened, so the 15-second
  /// refresh does not reopen it every tick — and so returning from the thread
  /// does not bounce the customer straight back into it.
  bool _deepLinkOpened = false;

  /// Open the ticket a "support replied" push pointed at.
  ///
  /// RUNS AFTER THE LIST LOADS, not in initState: the number has to be matched
  /// against real tickets, and the thread screen wants the ticket object. A
  /// number that matches nothing simply leaves the customer on the list, which
  /// is the honest outcome — the reply is visible there.
  void _openDeepLinkedTicket() {
    if (_deepLinkOpened) return;
    final want = (widget.openTicketNumber ?? '').trim().toUpperCase();
    if (want.isEmpty) return;
    _deepLinkOpened = true;

    SupportTicket? match;
    for (final t in _tickets) {
      if (t.ticketNumber.trim().toUpperCase() == want) {
        match = t;
        break;
      }
    }
    if (match == null) return;

    // After the frame, so the Navigator this pushes onto is mounted — the same
    // reason the composer auto-open above is deferred.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _openThread(match);
    });
  }

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
    final result = await showAppBottomSheet<_NewTicketResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _NewTicketSheet(
        openTickets: open,
        initialSubject: widget.composeSubject,
        initialMessage: widget.composeMessage,
      ),
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
      final ticket =
          await _api.createTicket(subject: subject, message: message);
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

  /// The server-set reply-time promise. Null until it arrives, and null for
  /// good if it cannot be fetched — the banner is reassurance, not content,
  /// and the ticket list must never fail to open because of it.
  String? _slaText;

  Future<void> _loadSlaNotice() async {
    final t = await _api.responseSlaText();
    if (mounted && t != null) setState(() => _slaText = t);
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
                      style: TextStyle(color: _textSecondary, fontSize: 13.sp)),
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
                    style: ElevatedButton.styleFrom(backgroundColor: _primary),
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
    // The notice scrolls WITH the list rather than pinning above it: on a
    // short list a pinned banner takes a third of the screen to say
    // something the customer only needs to read once.
    //
    // Only on the OPEN tab. A reply-time promise above a list of resolved
    // tickets is answering a question nobody is asking there.
    final showNotice = !closedTab && (_slaText?.trim().isNotEmpty ?? false);
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      // Bottom inset keeps the FAB from covering the last ticket row.
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
      itemCount: tickets.length + (showNotice ? 1 : 0),
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, i) {
        if (showNotice && i == 0) {
          return SupportSlaNotice(
            text: _slaText,
            background: _card,
            accent: _primary,
            textColor: _textSecondary,
          );
        }
        return _ticketTile(tickets[i - (showNotice ? 1 : 0)]);
      },
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
                          t.subject.isNotEmpty
                              ? t.subject
                              : 'Chat with support',
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
