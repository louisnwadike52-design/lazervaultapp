import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_wallet.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_participant.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/spray_comment.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';

class SprayRoomState {
  final SpraySession? session;
  final SprayWallet? wallet;
  final List<SprayGift> gifts;
  final List<SessionParticipant> participants;
  final List<SprayRoomEvent> recentEvents;
  final List<SprayComment> comments;
  final int totalLikes;
  final int totalSprayed;
  final int totalGiftsValue; // total value of gifts in kobo
  final int totalGiftsCount; // number of gifts sent
  final int participantCount;
  final bool isConnected;
  final bool isLoading;
  final bool sessionEnded;
  final bool connectionFailed; // true when WebSocket gave up reconnecting
  final bool walletLoadFailed; // true when wallet failed to load
  final bool actionInProgress; // true when a gift/spray/comment is in-flight
  final String? error;

  // Money spray state
  final int? selectedDenomination;
  final int sprayBudget; // how much loaded for spraying in kobo
  final int sprayedSoFar; // how much sprayed so far from budget

  const SprayRoomState({
    this.session,
    this.wallet,
    this.gifts = const [],
    this.participants = const [],
    this.recentEvents = const [],
    this.comments = const [],
    this.totalLikes = 0,
    this.totalSprayed = 0,
    this.totalGiftsValue = 0,
    this.totalGiftsCount = 0,
    this.participantCount = 0,
    this.isConnected = false,
    this.isLoading = false,
    this.sessionEnded = false,
    this.connectionFailed = false,
    this.walletLoadFailed = false,
    this.actionInProgress = false,
    this.error,
    this.selectedDenomination,
    this.sprayBudget = 0,
    this.sprayedSoFar = 0,
  });

  SprayRoomState copyWith({
    SpraySession? session,
    SprayWallet? wallet,
    List<SprayGift>? gifts,
    List<SessionParticipant>? participants,
    List<SprayRoomEvent>? recentEvents,
    List<SprayComment>? comments,
    int? totalLikes,
    int? totalSprayed,
    int? totalGiftsValue,
    int? totalGiftsCount,
    int? participantCount,
    bool? isConnected,
    bool? isLoading,
    bool? sessionEnded,
    bool? connectionFailed,
    bool? walletLoadFailed,
    bool? actionInProgress,
    String? error,
    int? selectedDenomination,
    int? sprayBudget,
    int? sprayedSoFar,
  }) {
    return SprayRoomState(
      session: session ?? this.session,
      wallet: wallet ?? this.wallet,
      gifts: gifts ?? this.gifts,
      participants: participants ?? this.participants,
      recentEvents: recentEvents ?? this.recentEvents,
      comments: comments ?? this.comments,
      totalLikes: totalLikes ?? this.totalLikes,
      totalSprayed: totalSprayed ?? this.totalSprayed,
      totalGiftsValue: totalGiftsValue ?? this.totalGiftsValue,
      totalGiftsCount: totalGiftsCount ?? this.totalGiftsCount,
      participantCount: participantCount ?? this.participantCount,
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
      sessionEnded: sessionEnded ?? this.sessionEnded,
      connectionFailed: connectionFailed ?? this.connectionFailed,
      walletLoadFailed: walletLoadFailed ?? this.walletLoadFailed,
      actionInProgress: actionInProgress ?? this.actionInProgress,
      error: error,
      selectedDenomination: selectedDenomination ?? this.selectedDenomination,
      sprayBudget: sprayBudget ?? this.sprayBudget,
      sprayedSoFar: sprayedSoFar ?? this.sprayedSoFar,
    );
  }

  double get walletBalanceMajor => (wallet?.balance ?? 0) / 100;
  double get totalSprayedMajor => totalSprayed / 100;
  double get totalGiftsValueMajor => totalGiftsValue / 100;

  /// Total worth of everything sprayed: cash + gifts
  int get totalWorth => totalSprayed + totalGiftsValue;
  double get totalWorthMajor => totalWorth / 100;

  int get sprayRemaining => sprayBudget - sprayedSoFar;
  double get sprayRemainingMajor => sprayRemaining / 100;
  bool get canSpray =>
      !sessionEnded &&
      isConnected &&
      !actionInProgress &&
      sprayRemaining > 0 &&
      selectedDenomination != null &&
      selectedDenomination! <= sprayRemaining &&
      (wallet?.balance ?? 0) >= selectedDenomination!;
}
