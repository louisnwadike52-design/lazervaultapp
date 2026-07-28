import 'package:dio/dio.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_action_result.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';

class SprayMeRemoteDataSource {
  final Dio _dio;

  SprayMeRemoteDataSource(this._dio);

  // ─── Sessions ────────────────────────────────────────────────

  Future<SpraySession> createSession({
    required String title,
    required String description,
    required String occasionType,
    String coverImageUrl = '',
    String currency = 'NGN',
  }) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions', data: {
        'title': title,
        'description': description,
        'occasion_type': occasionType,
        'cover_image_url': coverImageUrl,
        'currency': currency,
      });
      return SpraySession.fromJson(response.data['session'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'create session');
    }
  }

  Future<SpraySession> getSession(String sessionId) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/$sessionId');
      return SpraySession.fromJson(response.data['session'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'load session');
    }
  }

  Future<SpraySession> getSessionByCode(String code) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/code/$code');
      return SpraySession.fromJson(response.data['session'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'find session');
    }
  }

  Future<SpraySession> joinSession(String sessionCode) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/join', data: {
        'session_code': sessionCode,
      });
      return SpraySession.fromJson(response.data['session'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'join session');
    }
  }

  Future<void> leaveSession(String sessionId) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/leave');
    } on DioException catch (e) {
      throw _mapDioError(e, 'leave session');
    }
  }

  Future<SpraySession> endSession(String sessionId) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/end');
      return SpraySession.fromJson(response.data['session'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'end session');
    }
  }

  Future<List<SpraySession>> getMySessions({String filter = 'all', int page = 1, int pageSize = 20}) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/my', queryParameters: {
        'filter': filter,
        'page': page,
        'page_size': pageSize,
      });
      final sessions = response.data['sessions'] as List<dynamic>? ?? [];
      return sessions
          .whereType<Map<String, dynamic>>()
          .map((json) => SpraySession.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load sessions');
    }
  }

  // ─── Wallet ──────────────────────────────────────────────────

  Future<SprayWallet> getWallet() async {
    try {
      final response = await _dio.get('/api/v1/sprayme/wallet');
      return SprayWallet.fromJson(response.data['wallet'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'load wallet');
    }
  }

  Future<SprayWallet> fundWallet({required int amount, required String sourceAccountId, required String verificationToken}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/wallet/fund', data: {
        'amount': amount,
        'source_account_id': sourceAccountId,
        // Pre-minted single-use PIN verification token (canonical tx-PIN modal
        // flow). Backend FundWalletRequest.verification_token validates it via
        // auth-service, bound to source_account_id.
        'verification_token': verificationToken,
      });
      return SprayWallet.fromJson(response.data['wallet'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'fund wallet');
    }
  }

  /// Buy gift credit straight from a personal account. The cart total is
  /// debited from [sourceAccountId] and credited to the spendable spray balance.
  /// This replaces fundWallet for joiners (no separate fundable wallet).
  Future<SprayWallet> buyGiftCredit({
    required List<Map<String, dynamic>> items,
    required String sourceAccountId,
    required String verificationToken,
    required String idempotencyKey,
    String sessionId = '',
    String currency = 'NGN',
  }) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/wallet/buy-gift', data: {
        'items': items,
        'source_account_id': sourceAccountId,
        // Canonical tx-PIN modal token (BuyGiftCreditRequest.verification_token).
        'verification_token': verificationToken,
        'idempotency_key': idempotencyKey,
        'session_id': sessionId,
        'currency': currency,
      });
      return SprayWallet.fromJson(response.data['wallet'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'buy gift credit');
    }
  }

  Future<SprayWallet> withdrawFromWallet({required int amount, required String destinationAccountId, required String verificationToken}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/wallet/withdraw', data: {
        'amount': amount,
        'destination_account_id': destinationAccountId,
        // Canonical tx-PIN modal token (WithdrawFromWalletRequest.verification_token),
        // bound to destination_account_id.
        'verification_token': verificationToken,
      });
      return SprayWallet.fromJson(response.data['wallet'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'withdraw from wallet');
    }
  }

  // ─── Spray Actions ──────────────────────────────────────────

  Future<SprayActionResult> sendGift({required String sessionId, required String giftId, int quantity = 1}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/gift', data: {
        'gift_id': giftId,
        'quantity': quantity,
      });
      return SprayActionResult.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'send gift');
    }
  }

  Future<SprayActionResult> sprayMoney({required String sessionId, required int denomination, required int tapCount}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/spray', data: {
        'denomination': denomination,
        'tap_count': tapCount,
      });
      return SprayActionResult.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'spray money');
    }
  }

  /// Send [count] like taps (TikTok-style batch). Returns the distinct-liker
  /// count plus the lifetime + current-live tap accumulators.
  Future<({int totalLikes, int totalLikeTaps, int liveLikeTaps})> sendLike(
      String sessionId,
      {int count = 1}) async {
    try {
      final response = await _dio.post(
        '/api/v1/sprayme/sessions/$sessionId/like',
        data: {'count': count < 1 ? 1 : count},
      );
      final d = response.data as Map<String, dynamic>;
      return (
        totalLikes: (d['total_likes'] as num?)?.toInt() ?? 0,
        totalLikeTaps: (d['total_like_taps'] as num?)?.toInt() ?? 0,
        liveLikeTaps: (d['live_like_taps'] as num?)?.toInt() ?? 0,
      );
    } on DioException catch (e) {
      throw _mapDioError(e, 'send like');
    }
  }

  // ─── Gift Catalog ───────────────────────────────────────────

  Future<List<SprayGift>> getGiftCatalog({String? category}) async {
    try {
      final params = <String, dynamic>{};
      if (category != null && category.isNotEmpty) params['category'] = category;
      final response = await _dio.get('/api/v1/sprayme/gifts', queryParameters: params);
      final gifts = response.data['gifts'] as List<dynamic>? ?? [];
      return gifts
          .whereType<Map<String, dynamic>>()
          .map((json) => SprayGift.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load gifts');
    }
  }

  // ─── Stats ──────────────────────────────────────────────────

  Future<SessionStats> getSessionStats(String sessionId) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/$sessionId/stats');
      return SessionStats.fromJson(response.data['stats'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'load stats');
    }
  }

  Future<MySprayStats> getMySprayStats({String period = 'all'}) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/stats/my', queryParameters: {'period': period});
      return MySprayStats.fromJson(response.data['stats'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'load stats');
    }
  }

  // ─── History ────────────────────────────────────────────────

  Future<List<SprayTransaction>> getSessionTransactions(String sessionId, {int page = 1, int pageSize = 20}) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/$sessionId/transactions', queryParameters: {
        'page': page,
        'page_size': pageSize,
      });
      final txs = response.data['transactions'] as List<dynamic>? ?? [];
      return txs.whereType<Map<String, dynamic>>().map((j) => SprayTransaction.fromJson(j)).toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load transactions');
    }
  }

  Future<List<SprayTransaction>> getMyTransactions({String type = 'all', int page = 1, int pageSize = 20}) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/transactions', queryParameters: {
        'type': type,
        'page': page,
        'page_size': pageSize,
      });
      final txs = response.data['transactions'] as List<dynamic>? ?? [];
      return txs.whereType<Map<String, dynamic>>().map((j) => SprayTransaction.fromJson(j)).toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load transactions');
    }
  }

  // ─── Participants ───────────────────────────────────────────

  Future<List<SessionParticipant>> getSessionParticipants(String sessionId) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/$sessionId/participants');
      final ps = response.data['participants'] as List<dynamic>? ?? [];
      return ps.whereType<Map<String, dynamic>>().map((j) => SessionParticipant.fromJson(j)).toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load participants');
    }
  }

  // ─── Comments ─────────────────────────────────────────────

  Future<SprayComment> addComment({required String sessionId, required String text}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/comment', data: {
        'text': text,
      });
      return SprayComment.fromJson(response.data['comment'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'add comment');
    }
  }

  Future<List<SprayComment>> getComments(String sessionId, {int page = 1, int pageSize = 50}) async {
    try {
      final response = await _dio.get('/api/v1/sprayme/sessions/$sessionId/comments', queryParameters: {
        'page': page,
        'page_size': pageSize,
      });
      final comments = response.data['comments'] as List<dynamic>? ?? [];
      return comments
          .whereType<Map<String, dynamic>>()
          .map((json) => SprayComment.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load comments');
    }
  }

  // ─── Live Video Streaming ───────────────────────────────────

  /// Host: start the live video broadcast. Returns {session, url, room_name, token, role}.
  Future<Map<String, dynamic>> startStream(String sessionId, {bool recordingEnabled = false}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/stream/start', data: {
        'recording_enabled': recordingEnabled,
      });
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throw _mapDioError(e, 'start live video');
    }
  }

  /// Host: stop the live video broadcast.
  Future<SpraySession> stopStream(String sessionId) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/stream/stop');
      return SpraySession.fromJson(response.data['session'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'stop live video');
    }
  }

  /// Host: pause the live broadcast without ending it. Viewers see a paused
  /// overlay; the LiveKit room, co-hosts and recording stay intact for resume.
  Future<void> pauseStream(String sessionId) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/stream/pause');
    } on DioException catch (e) {
      throw _mapDioError(e, 'pause live video');
    }
  }

  /// Host: resume a paused live broadcast.
  Future<void> resumeStream(String sessionId) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/stream/resume');
    } on DioException catch (e) {
      throw _mapDioError(e, 'resume live video');
    }
  }

  /// Any participant: resolve how to watch/broadcast. Returns either
  /// {mode:'webrtc', url, room_name, token, role, paused} or {mode:'hls', hls_url, paused}.
  Future<Map<String, dynamic>> getStreamToken(String sessionId) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/stream/token');
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throw _mapDioError(e, 'join live video');
    }
  }

  /// Host: promote a participant to co-host.
  Future<void> inviteCoHost(String sessionId, {required String userId, String userName = ''}) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/cohost/invite', data: {
        'user_id': userId,
        'user_name': userName,
      });
    } on DioException catch (e) {
      throw _mapDioError(e, 'invite co-host');
    }
  }

  /// Host: demote a co-host back to a viewer.
  Future<void> revokeCoHost(String sessionId, {required String userId}) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/cohost/revoke', data: {
        'user_id': userId,
      });
    } on DioException catch (e) {
      throw _mapDioError(e, 'revoke co-host');
    }
  }

  // ── Guest "boxes" (request-to-join-stage) ──

  /// Viewer: request to join the stage as a guest.
  Future<void> requestSeat(String sessionId) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/seat/request');
    } on DioException catch (e) {
      throw _mapDioError(e, 'request seat');
    }
  }

  /// Host: approve a pending seat request (guest → box).
  Future<void> approveSeat(String sessionId,
      {required String userId, String userName = ''}) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/seat/approve',
          data: {'user_id': userId, 'user_name': userName});
    } on DioException catch (e) {
      throw _mapDioError(e, 'approve seat');
    }
  }

  /// Host: decline a pending seat request.
  Future<void> declineSeat(String sessionId, {required String userId}) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/seat/decline',
          data: {'user_id': userId});
    } on DioException catch (e) {
      throw _mapDioError(e, 'decline seat');
    }
  }

  /// Guest: leave the stage.
  Future<void> leaveSeat(String sessionId) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/seat/leave');
    } on DioException catch (e) {
      throw _mapDioError(e, 'leave seat');
    }
  }

  /// Host: remove a seated guest from the stage.
  Future<void> removeFromSeat(String sessionId,
      {required String userId}) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/seat/remove',
          data: {'user_id': userId});
    } on DioException catch (e) {
      throw _mapDioError(e, 'remove guest');
    }
  }

  /// Host: toggle recording of the live stream mid-broadcast.
  Future<void> toggleRecording(String sessionId, {required bool enabled}) async {
    try {
      await _dio.post('/api/v1/sprayme/sessions/$sessionId/recording/toggle', data: {
        'enabled': enabled,
      });
    } on DioException catch (e) {
      throw _mapDioError(e, 'toggle recording');
    }
  }

  // ─── Error Mapping ──────────────────────────────────────────

  /// Friendly text for known server error codes (the gateway/service put these in
  /// the JSON `error` field). Checked BEFORE status-code mapping so operator gates
  /// and precondition failures never surface as raw codes or the wrong message.
  static const Map<String, String> _serverErrorMessages = {
    'live_video_disabled': "Live video isn't available right now.",
    'service_voice_disabled': "Voice isn't available here right now.",
    'cohost_disabled': 'Co-hosting is turned off right now.',
    'guests_disabled': 'Adding guests is turned off right now.',
    'recording_disabled': 'Recording is turned off right now.',
    'recording_not_entitled': "Recording isn't available on your plan.",
    'session is full': 'This session is full. Try again later.',
    'session is not live': "The stream isn't live right now.",
    'the stage is full': 'The stage is full — no free guest boxes.',
    'go live before adding guests to the stage':
        'Go live first, then you can add guests to the stage.',
  };

  Exception _mapDioError(DioException e, String operation) {
    final statusCode = e.response?.statusCode;

    // Prefer a known server error code (operator gates, "session is full", etc.)
    // over generic status-based text.
    final data = e.response?.data;
    final serverErr = (data is Map && data['error'] is String) ? data['error'] as String : null;
    if (serverErr != null && _serverErrorMessages.containsKey(serverErr)) {
      return Exception(_serverErrorMessages[serverErr]);
    }

    if (statusCode == 401) return Exception('Session expired. Please log in again.');
    if (statusCode == 403) return Exception('You do not have permission to $operation.');
    if (statusCode == 404) {
      switch (operation) {
        case 'add comment':
        case 'load comments':
          // Session not found (not because it ended - comments work on ended sessions)
          return Exception('Session not found. Please check the session code and try again.');
        case 'load session':
        case 'find session':
          return Exception('Session not found. It may have ended or the code is invalid.');
        case 'join session':
          return Exception('Session not found. Please check the code and try again.');
        case 'send gift':
        case 'spray money':
        case 'send like':
          return Exception('This session has ended. You can no longer $operation.');
        case 'load wallet':
          return Exception('Wallet not found. Please try again.');
        default:
          return Exception('The requested resource was not found.');
      }
    }
    if (statusCode == 409) {
      // 409 now covers several conflicts (already-joined, session full, not live).
      // Known codes were handled above; fall back sensibly by operation.
      if (serverErr != null) return Exception(serverErr);
      if (operation == 'join session') return Exception('You have already joined this session.');
      return Exception('That action conflicts with the current state. Please refresh and try again.');
    }
    if (statusCode == 422) {
      if (data is Map && data['error'] != null) return Exception('${data['error']}');
      return Exception('Insufficient balance to $operation.');
    }
    if (statusCode != null && statusCode >= 500) return Exception('Server error. Please try again later.');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timed out. Please check your internet and try again.');
      case DioExceptionType.connectionError:
        return Exception('Unable to connect. Please check your internet connection.');
      default:
        if (data is Map && data['error'] != null) return Exception('${data['error']}');
        return Exception('Failed to $operation. Please try again.');
    }
  }
}
