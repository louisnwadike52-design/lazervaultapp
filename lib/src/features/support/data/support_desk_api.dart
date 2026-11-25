import 'dart:async';
import 'dart:convert';

import 'package:lazervault/core/services/secure_storage_service.dart';

import 'support_api.dart';
import 'support_desk_models.dart';
import 'support_models.dart';

/// THE IN-APP SUPPORT DESK's client.
///
/// Reuses [SupportApi]'s URL building and headers rather than repeating them:
/// the desk reaches the SAME service through the SAME gateway origin, and a
/// second copy of that resolution is a second place for a dev-port override to
/// drift.
///
/// ## The admin paths
///
/// These call `/api/v1/admin/support/tickets/...`. core-gateway forwards a
/// narrow allowlist of those (see proxy.IsSupportDeskPath) and support-service
/// re-checks the admin role claim on every one — so a customer running a
/// patched build gets 403 from the service, not a desk.
class SupportDeskApi {
  final SupportApi _api;
  SupportDeskApi(SecureStorageService storage) : _api = SupportApi(storage);

  /// May I use the desk?
  ///
  /// Never throws: this is called on a dashboard build, and an exception here
  /// would break the screen for an ordinary customer who merely isn't an admin.
  /// Any failure answers "no desk", which is also the correct answer when
  /// support-service is simply unreachable.
  Future<DeskAccess> access() async {
    try {
      final res = await _api.rawGet('/api/v1/support/desk-access');
      if (res.statusCode != 200) return DeskAccess.none;
      final body = jsonDecode(res.body);
      if (body is! Map<String, dynamic>) return DeskAccess.none;
      return DeskAccess.fromJson(body);
    } catch (_) {
      return DeskAccess.none;
    }
  }

  /// Turn this agent's desk notifications on or off. Returns the state the
  /// server now holds, so the switch reflects what was stored rather than what
  /// was tapped.
  Future<bool> setPush(bool enabled) async {
    final res = await _api.rawPost(
      '/api/v1/support/desk-access/push',
      jsonEncode({'enabled': enabled}),
    );
    if (res.statusCode != 200) {
      throw Exception('Could not save that preference');
    }
    final body = jsonDecode(res.body);
    return body is Map && body['push_enabled'] == true;
  }

  /// May I work the TECHNICAL queue?
  ///
  /// Answers false rather than throwing, for the same reason [access] does: a
  /// responder without the role is told "no", and so is a responder whose
  /// service is briefly unreachable. Hiding a filter is the right response to
  /// both; an error banner is the right response to neither.
  Future<bool> technicalAccess() async {
    try {
      final res = await _api.rawGet('/api/v1/admin/support/technical/access');
      if (res.statusCode != 200) return false;
      final body = jsonDecode(res.body);
      return body is Map && body['technical'] == true;
    } catch (_) {
      return false;
    }
  }

  /// The queue. [status] filters server-side; empty means every status.
  ///
  /// [escalation] is a SECOND axis: 'technical' is the technical team's queue,
  /// 'none' is the desk's own view with escalated tickets taken out, and empty
  /// is everything. Asking for 'technical' without the role is a 403 from the
  /// server rather than a silently widened list.
  Future<List<DeskTicket>> queue({
    String status = 'open',
    String escalation = '',
    int limit = 40,
  }) async {
    final q = <String, String>{'limit': '$limit'};
    if (status.trim().isNotEmpty) q['status'] = status.trim();
    if (escalation.trim().isNotEmpty) q['escalation'] = escalation.trim();
    final res = await _api.rawGet('/api/v1/admin/support/tickets', query: q);
    if (res.statusCode == 403) {
      throw const DeskForbidden();
    }
    if (res.statusCode != 200) {
      throw Exception('Could not load the queue (${res.statusCode})');
    }
    final list = (jsonDecode(res.body)['tickets'] as List?) ?? const [];
    return list
        .whereType<Map<String, dynamic>>()
        .map(DeskTicket.fromJson)
        .toList();
  }

  /// One ticket and its whole thread.
  Future<({DeskTicket ticket, List<SupportMessage> messages})> thread(
      String ticketId) async {
    final res = await _api.rawGet('/api/v1/admin/support/tickets/$ticketId');
    if (res.statusCode == 403) throw const DeskForbidden();
    if (res.statusCode != 200) {
      throw Exception('Could not open that ticket (${res.statusCode})');
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final t = DeskTicket.fromJson(
        (body['ticket'] as Map<String, dynamic>?) ?? const {});
    final msgs = ((body['messages'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(SupportMessage.fromJson)
        .toList();
    return (ticket: t, messages: msgs);
  }

  /// Reply as support. [agentName] is what the customer sees.
  Future<SupportMessage> reply(
    String ticketId,
    String body, {
    String agentName = '',
  }) async {
    final res = await _api.rawPost(
      '/api/v1/admin/support/tickets/$ticketId/messages',
      jsonEncode({
        'body': body,
        if (agentName.trim().isNotEmpty) 'admin_name': agentName.trim(),
      }),
    );
    if (res.statusCode == 403) throw const DeskForbidden();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Could not send that reply (${res.statusCode})');
    }
    return SupportMessage.fromJson(
        (jsonDecode(res.body)['message'] as Map<String, dynamic>?) ?? const {});
  }

  /// Ask the assistant to DRAFT a reply. Sends nothing.
  ///
  /// The draft comes back for the responder to edit and post through [reply],
  /// which remains the only call that writes to a customer's thread. That
  /// separation is why this route is safe to expose on a handset at all.
  ///
  /// [messageId] names the message to answer. Omitted means "whatever the
  /// customer asked last" — support threads do not take turns, so the newest
  /// line is often "ok thanks" rather than the question worth answering.
  ///
  /// THE WHOLE THREAD IS STILL READ either way; the id only narrows what is
  /// answered, so a draft cannot contradict something we already said.
  Future<DeskDraft> aiDraft(String ticketId, {String? messageId}) async {
    final res = await _api.rawPost(
      '/api/v1/admin/support/tickets/$ticketId/ai-draft',
      jsonEncode({
        if ((messageId ?? '').trim().isNotEmpty) 'message_id': messageId!.trim(),
      }),
    );
    if (res.statusCode == 403) throw const DeskForbidden();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      // The server writes these for staff — "no AI model is configured", "that
      // message is not on this ticket" — so its sentence is shown rather than
      // a status code the responder cannot act on.
      String message = 'Could not draft a reply (${res.statusCode})';
      try {
        final err = (jsonDecode(res.body) as Map<String, dynamic>)['error'];
        if (err is String && err.trim().isNotEmpty) message = err.trim();
      } catch (_) {/* keep the generic message */}
      throw Exception(message);
    }
    return DeskDraft.fromJson(
        (jsonDecode(res.body) as Map<String, dynamic>?) ?? const {});
  }

  /// Change a ticket's status — the desk's only mutation beyond replying.
  Future<void> setStatus(String ticketId, String status) async {
    final res = await _api.rawPatch(
      '/api/v1/admin/support/tickets/$ticketId',
      jsonEncode({'status': status}),
    );
    if (res.statusCode == 403) throw const DeskForbidden();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('Could not update that ticket (${res.statusCode})');
    }
  }

  /// Hand a ticket to the technical team.
  ///
  /// [note] is REQUIRED and the server enforces a minimum length — an engineer
  /// opening the ticket cold needs the agent's reading of the problem, not the
  /// customer's description they have already read. A refusal comes back as
  /// the server's own sentence so the agent is told what to type.
  Future<void> escalate(String ticketId, String note) async {
    final res = await _api.rawPost(
      '/api/v1/admin/support/tickets/$ticketId/escalate',
      jsonEncode({'tier': 'technical', 'note': note}),
    );
    if (res.statusCode == 403) throw const DeskForbidden();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(_serverMessage(res.body) ??
          'Could not escalate that ticket (${res.statusCode})');
    }
  }

  /// Hand a ticket back to the support desk. Technical roles only.
  Future<void> returnToSupport(String ticketId, {String note = ''}) async {
    final res = await _api.rawPost(
      '/api/v1/admin/support/tickets/$ticketId/return',
      jsonEncode({'note': note}),
    );
    if (res.statusCode == 403) throw const DeskForbidden();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception(_serverMessage(res.body) ??
          'Could not return that ticket (${res.statusCode})');
    }
  }

  /// The server's own `error` string, when it sent one.
  ///
  /// These endpoints refuse with a sentence written for the person pressing
  /// the button ("say what the technical team needs to look at"). Replacing it
  /// with a status code would throw away the only part of the response that
  /// tells them what to do.
  String? _serverMessage(String body) {
    try {
      final j = jsonDecode(body);
      if (j is Map && j['error'] is String) {
        final m = (j['error'] as String).trim();
        return m.isEmpty ? null : m;
      }
    } catch (_) {}
    return null;
  }

  /// Best-effort: clears this agent's unread count on a ticket they opened.
  Future<void> markRead(String ticketId) async {
    try {
      await _api.rawPost('/api/v1/admin/support/tickets/$ticketId/read', '');
    } catch (_) {/* reading a ticket must never fail because of this */}
  }
}

/// The server refused: this account's role no longer carries support access.
///
/// Distinguished from a generic failure because the UI response is different —
/// a 403 means leave the desk, not retry.
class DeskForbidden implements Exception {
  const DeskForbidden();
  @override
  String toString() => 'Your account no longer has support access.';
}
