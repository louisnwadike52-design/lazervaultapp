import 'package:lazervault/src/features/sprayme/data/datasources/sprayme_remote_datasource.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_action_result.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';

class SprayMeRepositoryImpl implements ISprayMeRepository {
  final SprayMeRemoteDataSource _dataSource;

  SprayMeRepositoryImpl(this._dataSource);

  @override
  Future<SpraySession> createSession({
    required String title,
    required String description,
    required String occasionType,
    String coverImageUrl = '',
    String currency = 'NGN',
  }) => _dataSource.createSession(
    title: title,
    description: description,
    occasionType: occasionType,
    coverImageUrl: coverImageUrl,
    currency: currency,
  );

  @override
  Future<SpraySession> getSession(String sessionId) => _dataSource.getSession(sessionId);

  @override
  Future<SpraySession> getSessionByCode(String code) => _dataSource.getSessionByCode(code);

  @override
  Future<SpraySession> joinSession(String sessionCode) => _dataSource.joinSession(sessionCode);

  @override
  Future<void> leaveSession(String sessionId) => _dataSource.leaveSession(sessionId);

  @override
  Future<SpraySession> endSession(String sessionId) => _dataSource.endSession(sessionId);

  @override
  Future<List<SpraySession>> getMySessions({String filter = 'all', int page = 1, int pageSize = 20}) =>
      _dataSource.getMySessions(filter: filter, page: page, pageSize: pageSize);

  @override
  Future<SprayWallet> getWallet() => _dataSource.getWallet();

  @override
  Future<SprayWallet> fundWallet({required int amount, required String sourceAccountId, required String verificationToken}) =>
      _dataSource.fundWallet(amount: amount, sourceAccountId: sourceAccountId, verificationToken: verificationToken);

  @override
  Future<SprayWallet> buyGiftCredit({
    required List<Map<String, dynamic>> items,
    required String sourceAccountId,
    required String verificationToken,
    required String idempotencyKey,
    String sessionId = '',
    String currency = 'NGN',
  }) =>
      _dataSource.buyGiftCredit(
        items: items,
        sourceAccountId: sourceAccountId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        sessionId: sessionId,
        currency: currency,
      );

  @override
  Future<SprayWallet> withdrawFromWallet({required int amount, required String destinationAccountId, required String verificationToken}) =>
      _dataSource.withdrawFromWallet(amount: amount, destinationAccountId: destinationAccountId, verificationToken: verificationToken);

  @override
  Future<SprayActionResult> sendGift({required String sessionId, required String giftId, int quantity = 1}) =>
      _dataSource.sendGift(sessionId: sessionId, giftId: giftId, quantity: quantity);

  @override
  Future<SprayActionResult> sprayMoney({required String sessionId, required int denomination, required int tapCount}) =>
      _dataSource.sprayMoney(sessionId: sessionId, denomination: denomination, tapCount: tapCount);

  @override
  Future<({int totalLikes, int totalLikeTaps, int liveLikeTaps})> sendLike(
          String sessionId,
          {int count = 1}) =>
      _dataSource.sendLike(sessionId, count: count);

  @override
  Future<List<SprayGift>> getGiftCatalog({String? category}) => _dataSource.getGiftCatalog(category: category);

  @override
  Future<SessionStats> getSessionStats(String sessionId) => _dataSource.getSessionStats(sessionId);

  @override
  Future<MySprayStats> getMySprayStats({String period = 'all'}) => _dataSource.getMySprayStats(period: period);

  @override
  Future<List<SprayTransaction>> getSessionTransactions(String sessionId, {int page = 1, int pageSize = 20}) =>
      _dataSource.getSessionTransactions(sessionId, page: page, pageSize: pageSize);

  @override
  Future<List<SprayTransaction>> getMyTransactions({String type = 'all', int page = 1, int pageSize = 20}) =>
      _dataSource.getMyTransactions(type: type, page: page, pageSize: pageSize);

  @override
  Future<List<SessionParticipant>> getSessionParticipants(String sessionId) =>
      _dataSource.getSessionParticipants(sessionId);

  @override
  Future<SprayComment> addComment({required String sessionId, required String text}) =>
      _dataSource.addComment(sessionId: sessionId, text: text);

  @override
  Future<List<SprayComment>> getComments(String sessionId, {int page = 1, int pageSize = 50}) =>
      _dataSource.getComments(sessionId, page: page, pageSize: pageSize);

  // ─── Live video streaming ──

  @override
  Future<Map<String, dynamic>> startStream(String sessionId, {bool recordingEnabled = false}) =>
      _dataSource.startStream(sessionId, recordingEnabled: recordingEnabled);

  @override
  Future<SpraySession> stopStream(String sessionId) => _dataSource.stopStream(sessionId);

  @override
  Future<void> pauseStream(String sessionId) => _dataSource.pauseStream(sessionId);

  @override
  Future<void> resumeStream(String sessionId) => _dataSource.resumeStream(sessionId);

  @override
  Future<Map<String, dynamic>> getStreamToken(String sessionId) => _dataSource.getStreamToken(sessionId);

  @override
  Future<void> inviteCoHost(String sessionId, {required String userId, String userName = ''}) =>
      _dataSource.inviteCoHost(sessionId, userId: userId, userName: userName);

  @override
  Future<void> revokeCoHost(String sessionId, {required String userId}) =>
      _dataSource.revokeCoHost(sessionId, userId: userId);

  @override
  Future<void> requestSeat(String sessionId) =>
      _dataSource.requestSeat(sessionId);

  @override
  Future<void> approveSeat(String sessionId,
          {required String userId, String userName = ''}) =>
      _dataSource.approveSeat(sessionId, userId: userId, userName: userName);

  @override
  Future<void> declineSeat(String sessionId, {required String userId}) =>
      _dataSource.declineSeat(sessionId, userId: userId);

  @override
  Future<void> leaveSeat(String sessionId) => _dataSource.leaveSeat(sessionId);

  @override
  Future<void> removeFromSeat(String sessionId, {required String userId}) =>
      _dataSource.removeFromSeat(sessionId, userId: userId);

  @override
  Future<void> toggleRecording(String sessionId, {required bool enabled}) =>
      _dataSource.toggleRecording(sessionId, enabled: enabled);
}
