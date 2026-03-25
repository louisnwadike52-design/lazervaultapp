import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_transaction.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';

sealed class SprayMeState {}

class SprayMeInitial extends SprayMeState {}

class SprayMeLoading extends SprayMeState {}

class SprayMeError extends SprayMeState {
  final String message;
  SprayMeError(this.message);
}

// ─── Session States ──────────────────────────────────────────────

class SessionCreated extends SprayMeState {
  final SpraySession session;
  SessionCreated(this.session);
}

class SessionLoaded extends SprayMeState {
  final SpraySession session;
  SessionLoaded(this.session);
}

class SessionJoined extends SprayMeState {
  final SpraySession session;
  SessionJoined(this.session);
}

class SessionLeft extends SprayMeState {}

class SessionEnded extends SprayMeState {
  final SpraySession session;
  SessionEnded(this.session);
}

class MySessionsLoaded extends SprayMeState {
  final List<SpraySession> sessions;
  final int totalCount;
  MySessionsLoaded({required this.sessions, required this.totalCount});
}

// ─── Wallet States ───────────────────────────────────────────────

class WalletLoaded extends SprayMeState {
  final SprayWallet wallet;
  WalletLoaded(this.wallet);
}

class WalletFunded extends SprayMeState {
  final SprayWallet wallet;
  final String reference;
  final String message;
  WalletFunded({required this.wallet, required this.reference, required this.message});
}

class WalletWithdrawn extends SprayMeState {
  final SprayWallet wallet;
  final String reference;
  final String message;
  WalletWithdrawn({required this.wallet, required this.reference, required this.message});
}

// ─── Spray Action States ─────────────────────────────────────────

class GiftSent extends SprayMeState {
  final SprayWallet wallet;
  final String transactionId;
  final String message;
  GiftSent({required this.wallet, required this.transactionId, required this.message});
}

class MoneySprayed extends SprayMeState {
  final SprayWallet wallet;
  final int totalSprayed;
  final String transactionId;
  MoneySprayed({required this.wallet, required this.totalSprayed, required this.transactionId});
}

class LikeSent extends SprayMeState {
  final int totalLikes;
  LikeSent(this.totalLikes);
}

// ─── Catalog States ──────────────────────────────────────────────

class GiftCatalogLoaded extends SprayMeState {
  final List<SprayGift> gifts;
  GiftCatalogLoaded(this.gifts);
}

// ─── Stats States ────────────────────────────────────────────────

class SessionStatsLoaded extends SprayMeState {
  final SessionStats stats;
  SessionStatsLoaded(this.stats);
}

class MySprayStatsLoaded extends SprayMeState {
  final MySprayStats stats;
  MySprayStatsLoaded(this.stats);
}

// ─── History States ──────────────────────────────────────────────

class TransactionsLoaded extends SprayMeState {
  final List<SprayTransaction> transactions;
  final int totalCount;
  TransactionsLoaded({required this.transactions, required this.totalCount});
}

// ─── Participant States ──────────────────────────────────────────

class ParticipantsLoaded extends SprayMeState {
  final List<SessionParticipant> participants;
  ParticipantsLoaded(this.participants);
}

// ─── Comment States ───────────────────────────────────────────────

class CommentsLoaded extends SprayMeState {
  final List<SprayComment> comments;
  final int totalCount;
  CommentsLoaded({required this.comments, required this.totalCount});
}
