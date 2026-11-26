import 'dart:async';
import 'package:lazervault/src/features/widgets/full_screen_image_viewer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_desk_api.dart';
import '../data/support_desk_models.dart';
import '../data/support_models.dart';
import 'package:lazervault/src/features/support/presentation/support_message_time.dart';

/// THE IN-APP SUPPORT DESK.
///
/// An operator with support access works the ticket queue from their phone:
/// read who is waiting, open a thread, reply, close it.
///
/// ## Why this exists next to the admin dashboard
///
/// Support arrives at every hour, and the dashboard needs a laptop. Before
/// this, a customer messaging at 9pm waited until somebody sat down at one. The
/// desk is deliberately NOT a second dashboard: it does five things — queue,
/// read, reply, change status, mark read — and that is the same list
/// core-gateway forwards (proxy.IsSupportDeskPath). Anything else stays on the
/// dashboard, where it belongs.
///
/// ## Access
///
/// Gated on the server's own answer (`/support/desk-access`), which resolves
/// the role claim. This screen never decides the question itself, and the gate
/// here is for the UI only: every request it makes is re-checked by
/// support-service, so a customer who reached this route cannot read a ticket.
/// A [DeskForbidden] mid-session pops the screen rather than leaving a
/// half-working queue on display.
class SupportDeskScreen extends StatefulWidget {
  /// A ticket id to open on arrival, from a desk push.
  final String? openTicketId;
  const SupportDeskScreen({super.key, this.openTicketId});

  @override
  State<SupportDeskScreen> createState() => _SupportDeskScreenState();
}

class _SupportDeskScreenState extends State<SupportDeskScreen> {
  late final SupportDeskApi _api =
      SupportDeskApi(serviceLocator<SecureStorageService>());

  DeskAccess _access = DeskAccess.none;
  List<DeskTicket> _tickets = const [];
  bool _loading = true;
  String? _error;
  String _status = 'open';

  /// Which audience's queue is on screen.
  ///
  /// '' = everything, 'none' = the desk's own view with escalated tickets
  /// taken out, 'technical' = the technical team's queue. A SECOND axis from
  /// [_status], because a ticket with engineering is still open.
  String _escalation = '';

  /// Whether this responder may see the technical queue at all. False hides
  /// the filter entirely rather than showing a chip that 403s.
  bool _canSeeTechnical = false;

  bool _openedDeepLink = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final access = await _api.access();
    if (!mounted) return;
    setState(() => _access = access);
    if (!access.canUse) {
      setState(() {
        _loading = false;
        _error = null;
      });
      return;
    }
    // Asked once, after desk access is established: a responder without the
    // desk has no queue to filter, and asking first would be a request every
    // ordinary customer makes on every dashboard build.
    final technical = await _api.technicalAccess();
    if (mounted) setState(() => _canSeeTechnical = technical);

    await _load();
    // A push names ONE ticket. Open it after the queue has loaded, so backing
    // out of the thread lands on a populated list rather than a spinner.
    if (!_openedDeepLink && (widget.openTicketId ?? '').isNotEmpty) {
      _openedDeepLink = true;
      final id = widget.openTicketId!;
      if (mounted) _openThread(id);
    }
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final rows = await _api.queue(status: _status, escalation: _escalation);
      if (!mounted) return;
      setState(() {
        _tickets = rows;
        _loading = false;
      });
    } on DeskForbidden catch (e) {
      _loseAccess(e.toString());
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  /// The role was revoked while the screen was open. Leaving a stale queue up
  /// would be the one state where the UI claims an authority the server has
  /// already withdrawn.
  void _loseAccess(String message) {
    if (!mounted) return;
    setState(() {
      _access = DeskAccess(canUse: false, reason: message);
      _tickets = const [];
      _loading = false;
    });
  }

  Future<void> _openThread(String ticketId) async {
    await Get.to(() => _DeskThreadScreen(
          api: _api,
          ticketId: ticketId,
          canReturn: _canSeeTechnical,
        ));
    // Unread counts and statuses change inside the thread, so the queue is
    // always refetched on the way back rather than left showing what it showed
    // before the agent replied.
    if (mounted) _load();
  }

  Future<void> _togglePush(bool v) async {
    final previous = _access.pushEnabled;
    setState(() => _access = DeskAccess(
        canUse: _access.canUse, pushEnabled: v, reason: _access.reason));
    try {
      final saved = await _api.setPush(v);
      if (!mounted) return;
      setState(() => _access = DeskAccess(
          canUse: _access.canUse, pushEnabled: saved, reason: _access.reason));
    } catch (_) {
      // Put the switch back. A notification preference that looks saved and
      // is not is how an agent comes to believe they are being alerted.
      if (!mounted) return;
      setState(() => _access = DeskAccess(
          canUse: _access.canUse,
          pushEnabled: previous,
          reason: _access.reason));
      Get.snackbar('Not saved', 'That preference could not be saved.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support desk'),
        actions: [
          if (_access.canUse)
            IconButton(
              tooltip: _access.pushEnabled
                  ? 'Notifications on'
                  : 'Notifications off',
              icon: Icon(_access.pushEnabled
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_off_outlined),
              onPressed: () => _togglePush(!_access.pushEnabled),
            ),
          if (_access.canUse)
            IconButton(
              tooltip: 'Refresh',
              icon: const Icon(Icons.refresh),
              onPressed: _loading ? null : _load,
            ),
        ],
      ),
      body: _buildBody(theme),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_loading && _tickets.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_access.canUse) return _noAccess(theme);

    return Column(
      children: [
        _statusFilter(theme),
        if (_canSeeTechnical) _escalationFilter(theme),
        if (_error != null) _errorBanner(theme, _error!),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _load,
            child: _tickets.isEmpty
                ? _empty(theme)
                : ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: _tickets.length,
                    separatorBuilder: (_, __) => Divider(height: 1.h),
                    itemBuilder: (_, i) => _row(theme, _tickets[i]),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _noAccess(ThemeData theme) => Center(
        child: Padding(
          padding: EdgeInsets.all(28.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 44.sp, color: theme.disabledColor),
              SizedBox(height: 14.h),
              Text('Support desk',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                _access.reason.trim().isEmpty
                    ? 'This account does not have support access.'
                    : _access.reason,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

  Widget _statusFilter(ThemeData theme) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            for (final s in const [
              ('open', 'Open'),
              ('pending', 'Pending'),
              ('resolved', 'Resolved'),
              ('', 'All'),
            ])
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ChoiceChip(
                  label: Text(s.$2),
                  selected: _status == s.$1,
                  onSelected: (_) {
                    if (_status == s.$1) return;
                    setState(() => _status = s.$1);
                    _load();
                  },
                ),
              ),
          ],
        ),
      );

  /// WHOSE QUEUE. Only rendered for a responder who may actually open the
  /// technical one — a filter that refuses when tapped is worse than no
  /// filter.
  Widget _escalationFilter(ThemeData theme) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 10.h),
        child: Row(
          children: [
            for (final e in const [
              ('', 'Everything'),
              ('none', 'Support desk'),
              ('technical', 'Technical'),
            ])
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: ChoiceChip(
                  avatar: e.$1 == 'technical'
                      ? Icon(Icons.engineering_outlined, size: 15.w)
                      : null,
                  label: Text(e.$2),
                  selected: _escalation == e.$1,
                  onSelected: (_) {
                    if (_escalation == e.$1) return;
                    setState(() => _escalation = e.$1);
                    _load();
                  },
                ),
              ),
          ],
        ),
      );

  Widget _errorBanner(ThemeData theme, String msg) => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(msg,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onErrorContainer)),
      );

  Widget _empty(ThemeData theme) => ListView(
        // A ListView so pull-to-refresh still works on an empty queue —
        // otherwise the one state an agent most wants to re-check is the one
        // state they cannot.
        children: [
          SizedBox(height: 120.h),
          Center(
            child: Column(
              children: [
                Icon(Icons.inbox_outlined,
                    size: 40.sp, color: theme.disabledColor),
                SizedBox(height: 10.h),
                Text(
                  _status.isEmpty
                      ? 'No tickets.'
                      : 'Nothing ${_status == 'open' ? 'open' : _status}.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _row(ThemeData theme, DeskTicket t) {
    final waiting = t.unreadForAdmin > 0;
    return ListTile(
      onTap: () => _openThread(t.id),
      leading: CircleAvatar(
        backgroundColor: waiting
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHighest,
        child: Text(
          t.who.trim().isEmpty ? '?' : t.who.trim()[0].toUpperCase(),
          style: TextStyle(
            color: waiting
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(t.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: waiting ? FontWeight.w700 : FontWeight.w500,
                )),
          ),
          // WITH ENGINEERING, marked in the queue itself.
          //
          // Without it the desk's "Everything" view cannot tell a ticket
          // nobody has touched from one that is already being worked on
          // somewhere else — and the first thing that produces is two people
          // replying to the same customer with different answers.
          if (t.isEscalated) ...[
            SizedBox(width: 6.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.engineering_outlined,
                      size: 11.w, color: theme.colorScheme.onTertiaryContainer),
                  SizedBox(width: 3.w),
                  Text('Tech',
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onTertiaryContainer)),
                ],
              ),
            ),
          ],
        ],
      ),
      subtitle: Text('${t.who} · ${t.ticketNumber}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (waiting)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text('${t.unreadForAdmin}',
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700)),
            ),
          SizedBox(height: 3.h),
          Text(_ago(t.lastMessageAt), style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}

/// How long a customer has been waiting, which is the only time fact an agent
/// scanning a queue needs. An absolute timestamp would have to be read and
/// subtracted on every row.
String _ago(DateTime? t) {
  if (t == null) return '';
  final d = DateTime.now().difference(t);
  if (d.inMinutes < 1) return 'now';
  if (d.inMinutes < 60) return '${d.inMinutes}m';
  if (d.inHours < 24) return '${d.inHours}h';
  return '${d.inDays}d';
}

/// One ticket's thread, with a reply box.
class _DeskThreadScreen extends StatefulWidget {
  final SupportDeskApi api;
  final String ticketId;

  /// Whether this responder may hand an escalated ticket BACK. Anyone may
  /// escalate — the agent who cannot answer a question is the one who should
  /// say so — but only the team that took it can declare itself finished,
  /// or a ticket could be pulled out from under an engineer mid-look.
  final bool canReturn;

  const _DeskThreadScreen({
    required this.api,
    required this.ticketId,
    this.canReturn = false,
  });

  @override
  State<_DeskThreadScreen> createState() => _DeskThreadScreenState();
}

class _DeskThreadScreenState extends State<_DeskThreadScreen> {
  final _composer = TextEditingController();
  final _scroll = ScrollController();

  DeskTicket? _ticket;
  List<SupportMessage> _messages = const [];
  bool _loading = true;
  bool _sending = false;
  String? _error;

  /// REPLY WITH AI, on the phone.
  ///
  /// The desk exists because support arrives at every hour and the dashboard
  /// needs a laptop — which makes the handset the surface where starting from
  /// a draft matters most, and a blank box plus a thumb keyboard the thing it
  /// replaces.
  bool _drafting = false;

  /// The responder-facing note about the last draft: how sure the assistant
  /// was, whether our knowledge base grounded it, and which message it
  /// answers. Cleared once the reply is sent.
  String? _draftNote;

  /// The message the draft in the composer answers, so the thread can mark it.
  String? _draftTargetId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _composer.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final r = await widget.api.thread(widget.ticketId);
      if (!mounted) return;
      setState(() {
        _ticket = r.ticket;
        _messages = r.messages;
        _loading = false;
      });
      // Clearing the unread count is what makes the queue's badge mean
      // something. Best-effort by design — failing it must not block reading.
      widget.api.markRead(widget.ticketId);
      _toBottom();
    } on DeskForbidden catch (e) {
      if (!mounted) return;
      Get.back();
      Get.snackbar('Support desk', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void _toBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  /// Ask for a draft. Nothing is sent: it lands in the composer and the
  /// responder decides.
  ///
  /// [targetId] is the message they tapped; null means the composer button,
  /// which answers the newest customer question.
  Future<void> _draftWithAi({String? targetId}) async {
    if (_drafting || _sending) return;
    // NEVER OVERWRITE WHAT THEY HAVE TYPED. Losing a half-written reply to a
    // mis-tap on a handset — where the button sits next to the keyboard —
    // would make this something people are afraid of pressing.
    if (_composer.text.trim().isNotEmpty) {
      setState(() => _draftNote =
          'Clear the box first — a draft would overwrite what you typed.');
      return;
    }
    setState(() {
      _drafting = true;
      _draftNote = null;
      _draftTargetId = targetId;
    });
    try {
      final d = await widget.api.aiDraft(widget.ticketId, messageId: targetId);
      if (!mounted) return;
      if (d.draft.trim().isEmpty) {
        setState(() {
          _drafting = false;
          _draftTargetId = null;
          _draftNote = d.note.isNotEmpty
              ? d.note
              : 'The assistant had no suggestion for this ticket.';
        });
        return;
      }
      // Always say where it came from and how sure it was. A responder who
      // cannot tell a grounded answer from a guess will eventually send one.
      final parts = <String>[
        d.confident
            ? 'Draft ready — read it before sending.'
            : 'Draft ready, but the assistant was NOT confident. Check it.',
        if (d.usedKnowledge) 'Used the knowledge base.',
        if (d.note.isNotEmpty) d.note,
      ];
      final answeredId =
          d.answeredMessageId.isNotEmpty ? d.answeredMessageId : targetId;
      final answered = answeredId == null
          ? null
          : _messages.where((m) => m.id == answeredId).firstOrNull;
      final body =
          (answered?.body ?? '').replaceAll(RegExp(r'\s+'), ' ').trim();
      if (body.isNotEmpty) {
        parts.add('Answering: "'
            '${body.length <= 60 ? body : '${body.substring(0, 60)}…'}"');
      }
      // TEACH THE GESTURE WHERE IT IS RELEVANT.
      //
      // Long-press is not discoverable, and a hint shown on arrival is read
      // before it means anything. Said here — once the responder is holding a
      // draft of the NEWEST question and can see which one that was — it
      // answers the question they are about to have: "but I wanted to answer
      // the other one".
      if (targetId == null) {
        parts.add('Long-press a customer message to answer that one instead.');
      }
      setState(() {
        _composer.text = d.draft;
        _drafting = false;
        _draftTargetId = answeredId;
        _draftNote = parts.join(' ');
      });
    } on DeskForbidden catch (e) {
      if (!mounted) return;
      setState(() {
        _drafting = false;
        _draftTargetId = null;
      });
      Get.back();
      Get.snackbar('Support desk', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _drafting = false;
        _draftTargetId = null;
        _draftNote = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _send() async {
    final text = _composer.text.trim();
    if (text.isEmpty || _sending) return;
    setState(() => _sending = true);
    try {
      final msg = await widget.api.reply(widget.ticketId, text);
      if (!mounted) return;
      setState(() {
        // Append the SERVER's message, not the typed text: it carries the id,
        // sender name and timestamp the thread renders, and echoing the local
        // string would show a bubble that differs from what the customer got.
        _messages = [..._messages, msg];
        _composer.clear();
        _sending = false;
        // The question has been answered, so nothing in the thread is still
        // pending. Leaving the marker would point at a message that is done.
        _draftTargetId = null;
        _draftNote = null;
      });
      _toBottom();
    } on DeskForbidden catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      Get.back();
      Get.snackbar('Support desk', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      Get.snackbar('Not sent', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// WITH THE TECHNICAL TEAM — stated at the top of the thread.
  ///
  /// The note is support's reading of the problem, and it is the first thing
  /// an engineer opening this needs. Putting it behind a tap would mean the
  /// person it was written for is the one who has to go looking for it.
  Widget _escalationBanner(ThemeData theme, DeskTicket t) {
    final who = t.escalatedByName.trim();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.engineering_outlined,
                  size: 16.w, color: theme.colorScheme.onTertiaryContainer),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  who.isEmpty
                      ? 'With the technical team'
                      : 'With the technical team · raised by $who',
                  style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onTertiaryContainer),
                ),
              ),
              if (t.escalatedAt != null)
                Text(_ago(t.escalatedAt),
                    style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onTertiaryContainer)),
            ],
          ),
          if (t.escalationNote.trim().isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(t.escalationNote.trim(),
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onTertiaryContainer)),
          ],
        ],
      ),
    );
  }

  /// Collects the note, then escalates.
  ///
  /// The note is collected BEFORE the call rather than retried after a
  /// refusal: the server requires one, and a dialog that appears only after an
  /// error teaches the agent that the button is broken.
  Future<void> _askToEscalate() async {
    final controller = TextEditingController();
    final note = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Escalate to technical'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What should the technical team look at? They can already read '
              'the customer\u2019s own description \u2014 tell them what you '
              'tried and what looks wrong.',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: controller,
              autofocus: true,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'e.g. VA mint returns 500 on retry for this account',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text),
            child: const Text('Escalate'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (note == null || !mounted) return;
    try {
      await widget.api.escalate(widget.ticketId, note);
      if (!mounted) return;
      await _load();
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
          'Not escalated', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// Hands it back. The note is OPTIONAL here — "fixed, deployed" is often the
  /// whole truth, and the thread already carries the work.
  Future<void> _askToReturn() async {
    final controller = TextEditingController();
    final note = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Return to support'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'What did you find? (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text),
            child: const Text('Return'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (note == null || !mounted) return;
    try {
      await widget.api.returnToSupport(widget.ticketId, note: note);
      if (!mounted) return;
      await _load();
    } catch (e) {
      if (!mounted) return;
      Get.snackbar('Not returned', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _setStatus(String status) async {
    try {
      await widget.api.setStatus(widget.ticketId, status);
      if (!mounted) return;
      await _load();
    } catch (e) {
      if (!mounted) return;
      Get.snackbar('Not updated', e.toString().replaceFirst('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = _ticket;
    return Scaffold(
      appBar: AppBar(
        title: Text(t?.who ?? 'Ticket',
            maxLines: 1, overflow: TextOverflow.ellipsis),
        bottom: t == null
            ? null
            : PreferredSize(
                preferredSize: Size.fromHeight(20.h),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: Text('${t.ticketNumber} · ${t.status}',
                      style: theme.textTheme.labelSmall),
                ),
              ),
        actions: [
          if (t != null && !t.isClosed)
            PopupMenuButton<String>(
              tooltip: 'Actions',
              onSelected: (v) {
                switch (v) {
                  case 'escalate':
                    _askToEscalate();
                  case 'return':
                    _askToReturn();
                  default:
                    _setStatus(v);
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                    value: 'pending', child: Text('Mark pending')),
                const PopupMenuItem(
                    value: 'resolved', child: Text('Mark resolved')),
                // ESCALATE is offered while the ticket is NOT already out.
                // Re-escalating is legitimate on the server (a hard problem
                // goes back and forth), but offering it on a ticket that is
                // visibly with engineering reads as "it did not work".
                if (!t.isEscalated)
                  const PopupMenuItem(
                    value: 'escalate',
                    child: Text('Escalate to technical'),
                  ),
                if (t.isEscalated && widget.canReturn)
                  const PopupMenuItem(
                    value: 'return',
                    child: Text('Return to support'),
                  ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          if (t != null && t.isEscalated) _escalationBanner(theme, t),
          if (_error != null)
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Text(_error!,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.error)),
            ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scroll,
                    padding: EdgeInsets.all(12.w),
                    itemCount: _messages.length,
                    itemBuilder: (_, i) {
                      final m = _messages[i];
                      if (!SupportMessageTime.needsDivider(_messages, i)) {
                        return _bubble(theme, m);
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SupportDayDivider(
                            date: m.createdAt!,
                            background:
                                theme.colorScheme.surfaceContainerHighest,
                            textColor: theme.colorScheme.onSurfaceVariant,
                          ),
                          _bubble(theme, m),
                        ],
                      );
                    },
                  ),
          ),
          _replyDestinationBanner(theme),
          _composerBar(theme),
        ],
      ),
    );
  }

  Widget _bubble(ThemeData theme, SupportMessage m) {
    // STAFF messages sit on the right here, which is the opposite of the
    // customer's screen — on the desk, "mine" is support's side.
    final mine = m.isStaff;
    // ANSWER THIS ONE.
    //
    // A long-press rather than a button: the bubble is already a tap target
    // for its attachment, and a per-message button on every customer line
    // would crowd a 280-pixel bubble on a handset. Long-press is the gesture
    // the platform already uses for "act on this message".
    //
    // Offered on the CUSTOMER's messages only, with words in them — a draft
    // is written in answer to something they said, and the server refuses a
    // staff line or an empty one anyway.
    final canDraft = !mine && !m.isSystem && m.body.trim().isNotEmpty;
    final targeted = _draftTargetId != null && _draftTargetId == m.id;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: canDraft && !_drafting && !_sending
            ? () => _draftWithAi(targetId: m.id)
            : null,
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
          constraints: BoxConstraints(maxWidth: 280.w),
          decoration: BoxDecoration(
            color: m.isSystem
                ? theme.colorScheme.surfaceContainerHighest
                : mine
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12.r),
            // The message the draft in the composer answers. Without it the
            // responder is holding a reply to a question they can no longer
            // identify — which is the whole point of having chosen one.
            border: targeted
                ? Border.all(color: theme.colorScheme.primary, width: 2)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (m.senderName.trim().isNotEmpty && !mine)
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(m.senderName,
                      style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSecondaryContainer)),
                ),
              // THE ATTACHMENT, WHICH THE DESK DID NOT RENDER AT ALL.
              //
              // A customer sends a screenshot because the words are not enough;
              // the agent's own thread showed the caption and dropped the image,
              // so the one piece of evidence in the ticket was invisible to the
              // person working it. They had to open the admin console on a
              // laptop to see what had been sent — which is the thing this desk
              // exists to avoid.
              //
              // Tapping opens it full screen with a Hero flight back into the
              // bubble, the same gesture the customer's own thread and the event
              // flyers use. The tag is the MESSAGE id, not the URL: the same
              // screenshot sent twice would otherwise put two Heroes with one
              // tag in the tree, which throws on flight.
              if (m.hasImage)
                Padding(
                  padding: EdgeInsets.only(bottom: m.body.isEmpty ? 0 : 6.h),
                  child: GestureDetector(
                    onTap: () => FullScreenImageViewer.open(
                      context,
                      m.mediaUrl,
                      heroTag: 'desk-media-${m.id}',
                      caption: m.senderName.trim().isNotEmpty
                          ? m.senderName.trim()
                          : (mine ? 'You' : 'Customer'),
                    ),
                    child: Hero(
                      tag: 'desk-media-${m.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          m.mediaUrl,
                          fit: BoxFit.cover,
                          // Bounded so one tall screenshot does not take the
                          // whole thread; the full-screen view is where it is
                          // actually read.
                          height: 150.h,
                          loadingBuilder: (context, child, progress) =>
                              progress == null
                                  ? child
                                  : Container(
                                      height: 150.h,
                                      width: 0.5.sw,
                                      color: Colors.black26,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                    ),
                          // A dead URL must not leave a blank gap: say an image
                          // was sent and could not be loaded, so the thread
                          // still makes sense.
                          errorBuilder: (_, __, ___) => Container(
                            height: 90.h,
                            width: 0.5.sw,
                            color: Colors.black26,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.broken_image_outlined,
                                      size: 20.sp,
                                      color:
                                          theme.colorScheme.onSurfaceVariant),
                                  SizedBox(height: 4.h),
                                  Text('Image unavailable',
                                      style: theme.textTheme.labelSmall),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (m.body.trim().isNotEmpty)
                Text(
                  m.body,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: m.isSystem
                        ? theme.colorScheme.onSurfaceVariant
                        : mine
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              // WHEN IT WAS SENT, same rule as the customer's thread — an agent
              // reading a ticket back needs to see how long the customer waited,
              // and the two sides must not disagree about the time of the same
              // message.
              if (m.createdAt != null)
                Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      SupportMessageTime.clock(m.createdAt!.toLocal()),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 9.5.sp,
                        color: (m.isSystem
                                ? theme.colorScheme.onSurfaceVariant
                                : mine
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSecondaryContainer)
                            .withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// WHERE THIS REPLY IS GOING, said before it is written.
  ///
  /// A pre-auth ticket is raised by somebody who could not sign in, so it is
  /// parked under a sentinel owner — no device to push to, and no in-app
  /// thread they can open, because not being able to open it is why they
  /// wrote. The address they typed is the only route, and it is UNVERIFIED:
  /// nothing has checked they own it.
  ///
  /// Both facts belong above the composer rather than in the ticket header. A
  /// responder is about to write to a stranger's inbox, and "do not put
  /// anything in here you would not send to an unverified address" is only
  /// useful before they type it.
  Widget _replyDestinationBanner(ThemeData theme) {
    final t = _ticket;
    if (t == null) return const SizedBox.shrink();

    // No address on a pre-auth ticket means nothing can reach them. Said
    // plainly rather than hidden — a responder who types a careful answer
    // into a void has been failed by the screen, not by the customer.
    if (t.hasNoWayToReply) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(Icons.report_gmailerrorred_outlined,
                size: 16.w, color: theme.colorScheme.onErrorContainer),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'This customer could not sign in and left no address. '
                'Nothing you write here can reach them.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onErrorContainer),
              ),
            ),
          ],
        ),
      );
    }

    if (!t.repliesGoToEmailOnly) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.alternate_email_rounded,
              size: 16.w, color: theme.colorScheme.onTertiaryContainer),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your reply is emailed to ${t.userEmail}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'They could not sign in, so this is the only way to reach '
                  'them — and the address is unverified. Do not include '
                  'anything you would not send to a stranger.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer
                        .withValues(alpha: 0.85),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _composerBar(ThemeData theme) {
    final closed = _ticket?.isClosed ?? false;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 10.h),
        child: closed
            ? Row(
                children: [
                  Expanded(
                    child: Text(
                      'This ticket is ${_ticket?.status ?? 'closed'}. Reopen it to reply.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _setStatus('open'),
                    child: const Text('Reopen'),
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // WHAT THE ASSISTANT SAID ABOUT ITS OWN DRAFT, above the
                  // box holding it. A caution printed after the responder has
                  // already pressed send is not a caution.
                  if (_draftNote != null) ...[
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.auto_awesome,
                              size: 14.w,
                              color: theme.colorScheme.onSurfaceVariant),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              _draftNote!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => setState(() {
                              _draftNote = null;
                              _draftTargetId = null;
                            }),
                            child: Icon(Icons.close,
                                size: 14.w,
                                color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _composer,
                          minLines: 1,
                          maxLines: 4,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            hintText: 'Reply to the customer…',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      // Asks for a draft of the newest customer question. To
                      // answer an earlier one, the responder taps that message.
                      IconButton(
                        tooltip: 'Reply with AI — nothing is sent until you '
                            'press send',
                        onPressed: (_drafting || _sending)
                            ? null
                            : () => _draftWithAi(),
                        icon: _drafting
                            ? SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : const Icon(Icons.auto_awesome),
                      ),
                      SizedBox(width: 4.w),
                      IconButton.filled(
                        onPressed: _sending ? null : _send,
                        icon: _sending
                            ? SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : const Icon(Icons.send),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
