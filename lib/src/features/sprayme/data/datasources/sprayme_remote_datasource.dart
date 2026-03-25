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

  Future<SprayWallet> fundWallet({required int amount, required String sourceAccountId, required String pin}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/wallet/fund', data: {
        'amount': amount,
        'source_account_id': sourceAccountId,
        'transaction_pin': pin,
      });
      return SprayWallet.fromJson(response.data['wallet'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioError(e, 'fund wallet');
    }
  }

  Future<SprayWallet> withdrawFromWallet({required int amount, required String destinationAccountId, required String pin}) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/wallet/withdraw', data: {
        'amount': amount,
        'destination_account_id': destinationAccountId,
        'transaction_pin': pin,
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

  Future<int> sendLike(String sessionId) async {
    try {
      final response = await _dio.post('/api/v1/sprayme/sessions/$sessionId/like');
      return (response.data['total_likes'] as num?)?.toInt() ?? 0;
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

  // ─── Error Mapping ──────────────────────────────────────────

  Exception _mapDioError(DioException e, String operation) {
    final statusCode = e.response?.statusCode;
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
    if (statusCode == 409) return Exception('Already joined this session.');
    if (statusCode == 422) {
      final data = e.response?.data;
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
        final data = e.response?.data;
        if (data is Map && data['error'] != null) return Exception('${data['error']}');
        return Exception('Failed to $operation. Please try again.');
    }
  }
}
