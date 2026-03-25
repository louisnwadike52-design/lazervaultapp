import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';

class SprayMeCubit extends Cubit<SprayMeState> {
  final ISprayMeRepository _repository;

  SprayMeCubit(this._repository) : super(SprayMeInitial());

  // ─── Sessions ────────────────────────────────────────────────

  Future<void> createSession({
    required String title,
    required String description,
    required String occasionType,
    String coverImageUrl = '',
    String currency = 'NGN',
  }) async {
    emit(SprayMeLoading());
    try {
      final session = await _repository.createSession(
        title: title,
        description: description,
        occasionType: occasionType,
        coverImageUrl: coverImageUrl,
        currency: currency,
      );
      emit(SessionCreated(session));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> getSession(String sessionId) async {
    emit(SprayMeLoading());
    try {
      final session = await _repository.getSession(sessionId);
      emit(SessionLoaded(session));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> getSessionByCode(String code) async {
    emit(SprayMeLoading());
    try {
      final session = await _repository.getSessionByCode(code);
      emit(SessionLoaded(session));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> joinSession(String sessionCode) async {
    emit(SprayMeLoading());
    try {
      final session = await _repository.joinSession(sessionCode);
      emit(SessionJoined(session));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> leaveSession(String sessionId) async {
    try {
      await _repository.leaveSession(sessionId);
      emit(SessionLeft());
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> endSession(String sessionId) async {
    emit(SprayMeLoading());
    try {
      final session = await _repository.endSession(sessionId);
      emit(SessionEnded(session));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loadMySessions({String filter = 'all', int page = 1}) async {
    emit(SprayMeLoading());
    try {
      final sessions = await _repository.getMySessions(filter: filter, page: page);
      emit(MySessionsLoaded(sessions: sessions, totalCount: sessions.length));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ─── Wallet ──────────────────────────────────────────────────

  Future<void> loadWallet() async {
    emit(SprayMeLoading());
    try {
      final wallet = await _repository.getWallet();
      emit(WalletLoaded(wallet));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> fundWallet({
    required int amount,
    required String sourceAccountId,
    required String pin,
  }) async {
    emit(SprayMeLoading());
    try {
      final wallet = await _repository.fundWallet(
        amount: amount,
        sourceAccountId: sourceAccountId,
        pin: pin,
      );
      emit(WalletFunded(
        wallet: wallet,
        reference: 'SPRAY-FUND',
        message: 'Wallet funded successfully',
      ));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> withdrawFromWallet({
    required int amount,
    required String destinationAccountId,
    required String pin,
  }) async {
    emit(SprayMeLoading());
    try {
      final wallet = await _repository.withdrawFromWallet(
        amount: amount,
        destinationAccountId: destinationAccountId,
        pin: pin,
      );
      emit(WalletWithdrawn(
        wallet: wallet,
        reference: 'SPRAY-WD',
        message: 'Withdrawal successful',
      ));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ─── Spray Actions ──────────────────────────────────────────

  Future<void> sendGift({
    required String sessionId,
    required String giftId,
    int quantity = 1,
  }) async {
    try {
      final result = await _repository.sendGift(
        sessionId: sessionId,
        giftId: giftId,
        quantity: quantity,
      );
      if (result.wallet != null) {
        emit(GiftSent(
          wallet: result.wallet!,
          transactionId: result.transactionId ?? '',
          message: result.message,
        ));
      }
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> sprayMoney({
    required String sessionId,
    required int denomination,
    required int tapCount,
  }) async {
    try {
      final result = await _repository.sprayMoney(
        sessionId: sessionId,
        denomination: denomination,
        tapCount: tapCount,
      );
      if (result.wallet != null) {
        emit(MoneySprayed(
          wallet: result.wallet!,
          totalSprayed: result.totalSprayed ?? 0,
          transactionId: result.transactionId ?? '',
        ));
      }
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> sendLike(String sessionId) async {
    try {
      final totalLikes = await _repository.sendLike(sessionId);
      emit(LikeSent(totalLikes));
    } catch (e) {
      // Silently ignore like errors
    }
  }

  // ─── Catalog ─────────────────────────────────────────────────

  Future<void> loadGiftCatalog({String? category}) async {
    emit(SprayMeLoading());
    try {
      final gifts = await _repository.getGiftCatalog(category: category);
      emit(GiftCatalogLoaded(gifts));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ─── Stats ───────────────────────────────────────────────────

  Future<void> loadSessionStats(String sessionId) async {
    emit(SprayMeLoading());
    try {
      final stats = await _repository.getSessionStats(sessionId);
      emit(SessionStatsLoaded(stats));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loadMySprayStats({String period = 'all'}) async {
    emit(SprayMeLoading());
    try {
      final stats = await _repository.getMySprayStats(period: period);
      emit(MySprayStatsLoaded(stats));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ─── History ─────────────────────────────────────────────────

  Future<void> loadSessionTransactions(String sessionId, {int page = 1}) async {
    emit(SprayMeLoading());
    try {
      final transactions = await _repository.getSessionTransactions(sessionId, page: page);
      emit(TransactionsLoaded(transactions: transactions, totalCount: transactions.length));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loadMyTransactions({String type = 'all', int page = 1}) async {
    emit(SprayMeLoading());
    try {
      final transactions = await _repository.getMyTransactions(type: type, page: page);
      emit(TransactionsLoaded(transactions: transactions, totalCount: transactions.length));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ─── Participants ────────────────────────────────────────────

  Future<void> loadParticipants(String sessionId) async {
    try {
      final participants = await _repository.getSessionParticipants(sessionId);
      emit(ParticipantsLoaded(participants));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ─── Comments ─────────────────────────────────────────────────

  Future<void> loadComments(String sessionId, {int page = 1}) async {
    try {
      final comments = await _repository.getComments(sessionId, page: page);
      emit(CommentsLoaded(comments: comments, totalCount: comments.length));
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> addComment({required String sessionId, required String text}) async {
    if (text.trim().isEmpty) return;
    try {
      await _repository.addComment(sessionId: sessionId, text: text.trim());
      // Reload comments after adding
      loadComments(sessionId);
    } catch (e) {
      emit(SprayMeError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
