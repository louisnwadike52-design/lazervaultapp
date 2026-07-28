import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_action_result.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';

abstract class ISprayMeRepository {
  // Sessions
  Future<SpraySession> createSession({
    required String title,
    required String description,
    required String occasionType,
    String coverImageUrl = '',
    String currency = 'NGN',
  });
  Future<SpraySession> getSession(String sessionId);
  Future<SpraySession> getSessionByCode(String code);
  Future<SpraySession> joinSession(String sessionCode);
  Future<void> leaveSession(String sessionId);
  Future<SpraySession> endSession(String sessionId);
  Future<List<SpraySession>> getMySessions({String filter = 'all', int page = 1, int pageSize = 20});

  // Wallet
  Future<SprayWallet> getWallet();
  Future<SprayWallet> fundWallet({required int amount, required String sourceAccountId, required String verificationToken});
  Future<SprayWallet> buyGiftCredit({
    required List<Map<String, dynamic>> items,
    required String sourceAccountId,
    required String verificationToken,
    required String idempotencyKey,
    String sessionId,
    String currency,
  });
  Future<SprayWallet> withdrawFromWallet({required int amount, required String destinationAccountId, required String verificationToken});

  // Actions
  Future<SprayActionResult> sendGift({required String sessionId, required String giftId, int quantity = 1});
  Future<SprayActionResult> sprayMoney({required String sessionId, required int denomination, required int tapCount});
  Future<({int totalLikes, int totalLikeTaps, int liveLikeTaps})> sendLike(
      String sessionId,
      {int count});

  // Catalog
  Future<List<SprayGift>> getGiftCatalog({String? category});

  // Stats
  Future<SessionStats> getSessionStats(String sessionId);
  Future<MySprayStats> getMySprayStats({String period = 'all'});

  // History
  Future<List<SprayTransaction>> getSessionTransactions(String sessionId, {int page = 1, int pageSize = 20});
  Future<List<SprayTransaction>> getMyTransactions({String type = 'all', int page = 1, int pageSize = 20});

  // Participants
  Future<List<SessionParticipant>> getSessionParticipants(String sessionId);

  // Comments
  Future<SprayComment> addComment({required String sessionId, required String text});
  Future<List<SprayComment>> getComments(String sessionId, {int page = 1, int pageSize = 50});

  // Live video streaming
  Future<Map<String, dynamic>> startStream(String sessionId, {bool recordingEnabled = false});
  Future<SpraySession> stopStream(String sessionId);
  Future<void> pauseStream(String sessionId);
  Future<void> resumeStream(String sessionId);
  Future<Map<String, dynamic>> getStreamToken(String sessionId);
  Future<void> inviteCoHost(String sessionId, {required String userId, String userName = ''});
  Future<void> revokeCoHost(String sessionId, {required String userId});
  // Guest "boxes"
  Future<void> requestSeat(String sessionId);
  Future<void> approveSeat(String sessionId, {required String userId, String userName});
  Future<void> declineSeat(String sessionId, {required String userId});
  Future<void> leaveSeat(String sessionId);
  Future<void> removeFromSeat(String sessionId, {required String userId});
  Future<void> toggleRecording(String sessionId, {required bool enabled});
}
