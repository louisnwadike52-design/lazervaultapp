import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:lazervault/src/features/plan_my_day/email/data/email_websocket_service.dart';
import 'package:lazervault/src/features/plan_my_day/email/data/repositories/email_repository.dart';
import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';
import 'package:lazervault/src/features/plan_my_day/email/presentation/cubit/email_state.dart';

/// Cubit for the Gmail / email integration inside Plan My Day.
///
/// The connect flow uses google_sign_in v7 (`GoogleSignIn.instance`): after
/// `authenticate(...)` we call `authorizationClient.authorizeServer(scopes)` to
/// obtain the one-time **serverAuthCode**, which the backend exchanges for a
/// refresh token. `serverClientId` is the Web OAuth client id.
class EmailCubit extends Cubit<EmailState> {
  final EmailRepository _repository;
  final EmailWebSocketService? _ws;
  StreamSubscription<EmailWsEvent>? _wsSub;
  String _lastRange = 'today';

  EmailCubit(this._repository, [this._ws]) : super(EmailInitial());

  // Gmail scopes: read summaries + send replies on the user's behalf.
  static const List<String> _gmailScopes = [
    'https://www.googleapis.com/auth/gmail.readonly',
    'https://www.googleapis.com/auth/gmail.send',
  ];

  static const int _pageSize = 20;

  bool _googleInitialized = false;

  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) return;
    await GoogleSignIn.instance.initialize(
      serverClientId: dotenv.env['GMAIL_WEB_CLIENT_ID'] ?? '',
    );
    _googleInitialized = true;
  }

  /// Maps `range` selector -> (apiRange, hours) for the summaries call.
  static ({String apiRange, int? hours}) _rangeToApi(String range) {
    switch (range) {
      case 'last_24h':
        return (apiRange: 'last_n_hours', hours: 24);
      case 'last_7d':
        return (apiRange: 'last_n_hours', hours: 168);
      case 'today':
      default:
        return (apiRange: 'today', hours: null);
    }
  }

  // ==================== INBOX ====================

  Future<void> loadInbox({String range = 'today'}) async {
    if (isClosed) return;
    _lastRange = range;
    emit(EmailLoading());
    try {
      final status = await _repository.getStatus();
      if (!status.connected) {
        if (!isClosed) emit(EmailNotConnected());
        return;
      }
      await _loadSummaries(status, range);
      _startRealtime();
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to load your inbox')));
    }
  }

  /// Connects the realtime WS (idempotent) and refreshes the inbox/drafts when
  /// the backend pushes events. Best-effort — polling/Sync still work if the WS
  /// is unavailable.
  void _startRealtime() {
    final ws = _ws;
    if (ws == null || _wsSub != null) return;
    ws.connect();
    _wsSub = ws.events.listen((event) {
      if (isClosed) return;
      switch (event.type) {
        case 'email.received':
          _silentRefresh();
          break;
        case 'email.reply_pending':
        case 'email.reply_sent':
          loadDrafts();
          break;
      }
    });
  }

  Future<void> _silentRefresh() async {
    try {
      final status = await _repository.getStatus();
      if (status.connected && !isClosed) {
        await _loadSummaries(status, _lastRange);
      }
    } catch (_) {/* keep current view on refresh failure */}
  }

  @override
  Future<void> close() {
    _wsSub?.cancel();
    _ws?.disconnect();
    return super.close();
  }

  Future<void> _loadSummaries(
      EmailConnectionStatus status, String range) async {
    final r = _rangeToApi(range);
    final result = await _repository.getSummaries(
      range: r.apiRange,
      hours: r.hours,
      limit: _pageSize,
      offset: 0,
      includeDigest: true,
    );
    if (!isClosed) {
      emit(EmailInboxLoaded(
        status: status,
        range: range,
        digest: result.digest,
        messages: result.messages,
        total: result.total,
        hasMore: result.messages.length < result.total,
      ));
    }
  }

  Future<void> changeRange(String range) async {
    _lastRange = range;
    final current = state;
    if (current is! EmailInboxLoaded) {
      await loadInbox(range: range);
      return;
    }
    emit(EmailLoading());
    try {
      await _loadSummaries(current.status, range);
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to load emails')));
    }
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! EmailInboxLoaded || current.loadingMore || !current.hasMore) {
      return;
    }
    emit(current.copyWith(loadingMore: true));
    try {
      final r = _rangeToApi(current.range);
      final result = await _repository.getSummaries(
        range: r.apiRange,
        hours: r.hours,
        limit: _pageSize,
        offset: current.messages.length,
        includeDigest: false,
      );
      final merged = [...current.messages, ...result.messages];
      if (!isClosed) {
        emit(current.copyWith(
          messages: merged,
          total: result.total,
          loadingMore: false,
          hasMore: merged.length < result.total && result.messages.isNotEmpty,
        ));
      }
    } catch (e) {
      if (!isClosed) emit(current.copyWith(loadingMore: false));
    }
  }

  Future<void> syncNow() async {
    final current = state;
    if (current is EmailInboxLoaded) {
      emit(current.copyWith(syncing: true));
    }
    try {
      final count = await _repository.sync();
      if (!isClosed) emit(EmailSynced(count));
      // Reload the current range so new messages appear.
      final range = current is EmailInboxLoaded ? current.range : 'today';
      await loadInbox(range: range);
    } catch (e) {
      if (!isClosed) {
        if (current is EmailInboxLoaded) {
          emit(current.copyWith(syncing: false));
        }
        emit(EmailError(_msg(e, 'Sync failed')));
        if (current is EmailInboxLoaded) emit(current.copyWith(syncing: false));
      }
    }
  }

  // ==================== CONNECT ====================

  Future<void> connect() async {
    if (isClosed) return;
    emit(EmailConnecting());
    try {
      await _ensureGoogleInitialized();

      final GoogleSignInAccount user;
      try {
        user = await GoogleSignIn.instance.authenticate(scopeHint: _gmailScopes);
      } on GoogleSignInException catch (e) {
        if (isClosed) return;
        if (e.code == GoogleSignInExceptionCode.canceled) {
          emit(EmailNotConnected(message: 'Sign-in was cancelled'));
        } else {
          emit(EmailNotConnected(
              message: 'Google sign-in failed: ${e.description ?? e.code.name}'));
        }
        return;
      }

      // Obtain the one-time server auth code for the Gmail scopes. This is what
      // the backend exchanges for a refresh token to read/send on the user's
      // behalf. `authorizeServer` can return null on some platforms if a server
      // auth token isn't available (e.g. not the initial login).
      final serverAuth =
          await user.authorizationClient.authorizeServer(_gmailScopes);
      final serverAuthCode = serverAuth?.serverAuthCode;
      if (serverAuthCode == null || serverAuthCode.isEmpty) {
        if (!isClosed) {
          emit(EmailNotConnected(
              message:
                  "Couldn't get Gmail permission. Please try connecting again."));
        }
        return;
      }

      await _repository.connect(serverAuthCode: serverAuthCode);
      // Load the freshly connected inbox.
      await loadInbox();
    } catch (e) {
      if (!isClosed) {
        emit(EmailNotConnected(message: _msg(e, 'Failed to connect Gmail')));
      }
    }
  }

  Future<void> disconnect() async {
    if (isClosed) return;
    try {
      await _repository.disconnect();
      try {
        await GoogleSignIn.instance.signOut();
      } catch (_) {
        // Local sign-out is best-effort; the backend disconnect is the source of
        // truth.
      }
      if (!isClosed) emit(EmailDisconnected());
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to disconnect')));
    }
  }

  // ==================== THREAD ====================

  Future<void> openThread(String gmailMessageId) async {
    if (isClosed) return;
    emit(EmailThreadLoading());
    try {
      final detail = await _repository.getMessage(gmailMessageId);
      if (!isClosed) emit(EmailThreadLoaded(detail: detail));
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to load message')));
    }
  }

  Future<void> draftReply({String tone = 'professional', String instructions = ''}) async {
    final current = state;
    if (current is! EmailThreadLoaded) return;
    emit(current.copyWith(drafting: true));
    try {
      final draft = await _repository.draftReply(
        gmailMessageId: current.detail.message.gmailMessageId,
        tone: tone,
        instructions: instructions,
      );
      if (!isClosed) emit(current.copyWith(draft: draft, drafting: false));
    } catch (e) {
      if (!isClosed) {
        emit(current.copyWith(drafting: false));
        emit(EmailError(_msg(e, 'Failed to draft reply')));
        emit(current.copyWith(drafting: false));
      }
    }
  }

  Future<void> sendReply({required String body, String? draftId}) async {
    final current = state;
    if (current is! EmailThreadLoaded) return;
    if (body.trim().isEmpty) {
      emit(EmailError('The reply is empty'));
      emit(current);
      return;
    }
    emit(current.copyWith(sending: true));
    try {
      final sentId = await _repository.sendReply(
        draftId: draftId,
        gmailMessageId: current.detail.message.gmailMessageId,
        body: body,
      );
      if (!isClosed) emit(EmailReplySent(sentId));
    } catch (e) {
      if (!isClosed) {
        emit(current.copyWith(sending: false));
        emit(EmailError(_msg(e, 'Failed to send reply')));
        emit(current.copyWith(sending: false));
      }
    }
  }

  // ==================== APPROVAL QUEUE ====================

  Future<void> loadDrafts() async {
    if (isClosed) return;
    emit(EmailDraftsLoading());
    try {
      final drafts = await _repository.getDrafts();
      if (!isClosed) emit(EmailDraftsLoaded(drafts));
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to load drafts')));
    }
  }

  Future<void> approveDraft(String draftId, {String? editedBody}) async {
    try {
      await _repository.approveDraft(draftId, editedBody: editedBody);
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to approve draft')));
    }
    await loadDrafts();
  }

  Future<void> discardDraft(String draftId) async {
    try {
      await _repository.discardDraft(draftId);
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to discard draft')));
    }
    await loadDrafts();
  }

  // ==================== BUILD MY DAY ====================

  Future<void> buildDay({String range = 'today'}) async {
    if (isClosed) return;
    emit(EmailBuildingDay());
    try {
      final r = _rangeToApi(range);
      final result = await _repository.buildDay(range: r.apiRange, hours: r.hours);
      if (!isClosed) emit(EmailDayBuilt(result));
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to build your day')));
    }
  }

  // ==================== SETTINGS / RULES ====================

  Future<void> loadSettings() async {
    if (isClosed) return;
    emit(EmailSettingsLoading());
    try {
      final status = await _repository.getStatus();
      final rules = status.connected ? await _repository.getRules() : <EmailRule>[];
      if (!isClosed) emit(EmailSettingsLoaded(status: status, rules: rules));
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to load settings')));
    }
  }

  Future<void> updateSettings({bool? autoReplyEnabled, int? digestHour}) async {
    final current = state;
    if (current is! EmailSettingsLoaded) return;
    final newAuto = autoReplyEnabled ?? current.status.autoReplyEnabled;
    final newHour = digestHour ?? current.status.digestHour;
    emit(current.copyWith(saving: true));
    try {
      await _repository.updateSettings(
        autoReplyEnabled: newAuto,
        digestHour: newHour,
      );
      if (!isClosed) {
        emit(current.copyWith(
          status: current.status
              .copyWith(autoReplyEnabled: newAuto, digestHour: newHour),
          saving: false,
        ));
      }
    } catch (e) {
      if (!isClosed) {
        emit(current.copyWith(saving: false));
        emit(EmailError(_msg(e, 'Failed to save settings')));
        emit(current.copyWith(saving: false));
      }
    }
  }

  Future<void> saveRule(EmailRule rule) async {
    final current = state;
    try {
      await _repository.saveRule(rule);
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to save rule')));
    }
    if (current is EmailSettingsLoaded) {
      await loadSettings();
    }
  }

  Future<void> deleteRule(String ruleId) async {
    try {
      await _repository.deleteRule(ruleId);
    } catch (e) {
      if (!isClosed) emit(EmailError(_msg(e, 'Failed to delete rule')));
    }
    await loadSettings();
  }

  // ==================== HELPERS ====================

  String _msg(Object e, String fallback) {
    final s = e.toString();
    if (s.isEmpty || s == 'Exception') return fallback;
    return s.replaceFirst('Exception: ', '');
  }
}
