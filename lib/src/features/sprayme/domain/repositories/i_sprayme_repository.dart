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
  Future<SprayWallet> fundWallet({required int amount, required String sourceAccountId, required String pin});
  Future<SprayWallet> withdrawFromWallet({required int amount, required String destinationAccountId, required String pin});

  // Actions
  Future<SprayActionResult> sendGift({required String sessionId, required String giftId, int quantity = 1});
  Future<SprayActionResult> sprayMoney({required String sessionId, required int denomination, required int tapCount});
  Future<int> sendLike(String sessionId);

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
}
