import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/usecases/get_my_referral_code_usecase.dart';
import '../../domain/usecases/get_my_referral_stats_usecase.dart';
import '../../domain/usecases/get_my_referrals_usecase.dart';
import '../../domain/usecases/get_referral_leaderboard_usecase.dart';
import '../../domain/usecases/validate_referral_code_usecase.dart';
import '../../domain/usecases/get_my_points_balance_usecase.dart';
import '../../domain/usecases/get_my_points_history_usecase.dart';
import '../../domain/usecases/get_points_config_usecase.dart';
import 'referral_state.dart';

class ReferralCubit extends Cubit<ReferralState> {
  final GetMyReferralCodeUseCase _getMyReferralCodeUseCase;
  final GetMyReferralStatsUseCase _getMyReferralStatsUseCase;
  final GetReferralLeaderboardUseCase _getLeaderboardUseCase;
  final GetMyReferralsUseCase _getMyReferralsUseCase;
  final ValidateReferralCodeUseCase _validateReferralCodeUseCase;
  final GetMyPointsBalanceUseCase _getMyPointsBalanceUseCase;
  final GetMyPointsHistoryUseCase _getMyPointsHistoryUseCase;
  final GetPointsConfigUseCase _getPointsConfigUseCase;

  ReferralCubit({
    required GetMyReferralCodeUseCase getMyReferralCode,
    required GetMyReferralStatsUseCase getMyReferralStats,
    required GetReferralLeaderboardUseCase getLeaderboard,
    required GetMyReferralsUseCase getMyReferrals,
    required ValidateReferralCodeUseCase validateReferralCode,
    required GetMyPointsBalanceUseCase getMyPointsBalance,
    required GetMyPointsHistoryUseCase getMyPointsHistory,
    required GetPointsConfigUseCase getPointsConfig,
  })  : _getMyReferralCodeUseCase = getMyReferralCode,
        _getMyReferralStatsUseCase = getMyReferralStats,
        _getLeaderboardUseCase = getLeaderboard,
        _getMyReferralsUseCase = getMyReferrals,
        _validateReferralCodeUseCase = validateReferralCode,
        _getMyPointsBalanceUseCase = getMyPointsBalance,
        _getMyPointsHistoryUseCase = getMyPointsHistory,
        _getPointsConfigUseCase = getPointsConfig,
        super(const ReferralInitial());

  /// Load dashboard data (code, stats, leaderboard, recent referrals)
  Future<void> loadDashboard() async {
    if (isClosed) return;
    emit(const ReferralLoading(loadingMessage: 'Loading referral data...'));

    try {
      // Fetch all data in parallel with proper types
      print('[ReferralCubit] Fetching referral code...');
      final codeResult = await _getMyReferralCodeUseCase();
      print('[ReferralCubit] Code result: ${codeResult.isRight() ? "SUCCESS" : "FAILED"}');

      print('[ReferralCubit] Fetching referral stats...');
      final statsResult = await _getMyReferralStatsUseCase();
      print('[ReferralCubit] Stats result: ${statsResult.isRight() ? "SUCCESS" : "FAILED"}');

      print('[ReferralCubit] Fetching leaderboard...');
      final leaderboardResult = await _getLeaderboardUseCase(limit: 10, period: 'all_time');
      print('[ReferralCubit] Leaderboard result: ${leaderboardResult.isRight() ? "SUCCESS" : "FAILED"}');

      print('[ReferralCubit] Fetching referrals...');
      final referralsResult = await _getMyReferralsUseCase(page: 1, pageSize: 5);
      print('[ReferralCubit] Referrals result: ${referralsResult.isRight() ? "SUCCESS" : "FAILED"}');

      // Handle failures
      if (codeResult.isLeft()) {
        final failure = codeResult.fold((l) => l, (r) => null);
        print('[ReferralCubit] Code error: ${failure?.message}');
        if (isClosed) return;
        emit(ReferralError(failure?.message ?? 'Failed to load referral code'));
        return;
      }

      if (statsResult.isLeft()) {
        final failure = statsResult.fold((l) => l, (r) => null);
        print('[ReferralCubit] Stats error: ${failure?.message}');
        if (isClosed) return;
        emit(ReferralError(failure?.message ?? 'Failed to load referral stats'));
        return;
      }

      if (leaderboardResult.isLeft()) {
        final failure = leaderboardResult.fold((l) => l, (r) => null);
        print('[ReferralCubit] Leaderboard error: ${failure?.message}');
        if (isClosed) return;
        emit(ReferralError(failure?.message ?? 'Failed to load leaderboard'));
        return;
      }

      if (referralsResult.isLeft()) {
        final failure = referralsResult.fold((l) => l, (r) => null);
        print('[ReferralCubit] Referrals error: ${failure?.message}');
        if (isClosed) return;
        emit(ReferralError(failure?.message ?? 'Failed to load referrals'));
        return;
      }

      // Extract successful data
      final code = codeResult.fold((l) => null, (r) => r);
      final stats = statsResult.fold((l) => null, (r) => r);
      final leaderboard = leaderboardResult.fold((l) => null, (r) => r);
      final referrals = referralsResult.fold((l) => null, (r) => r);

      print('[ReferralCubit] All data loaded successfully');
      if (code != null && stats != null && leaderboard != null && referrals != null) {
        if (isClosed) return;
        emit(ReferralLoaded(
          myCode: code,
          stats: stats,
          leaderboard: leaderboard,
          recentReferrals: referrals,
        ));
      } else {
        if (isClosed) return;
        emit(const ReferralError('Failed to load dashboard data'));
      }
    } catch (e, stackTrace) {
      print('[ReferralCubit] Exception: $e');
      print('[ReferralCubit] StackTrace: $stackTrace');
      if (isClosed) return;
      emit(ReferralError('An unexpected error occurred: $e'));
    }
  }

  /// Refresh dashboard data
  Future<void> refreshDashboard() async {
    await loadDashboard();
  }

  /// Copy referral code to clipboard
  Future<void> copyReferralCode(String code) async {
    try {
      await Clipboard.setData(ClipboardData(text: code));
      if (isClosed) return;
      emit(const ReferralCodeCopied());

      // Return to loaded state after short delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (state is ReferralLoaded) {
        // Already loaded, do nothing
      } else {
        // Reload dashboard if not in loaded state
        await loadDashboard();
      }
    } catch (e) {
      if (isClosed) return;
      emit(ReferralError('Failed to copy code: $e'));
    }
  }

  /// Share referral code via system share sheet
  Future<void> shareReferralCode(String code, {String? currency}) async {
    try {
      final currencySymbol = _getCurrencySymbol(currency ?? 'GBP');
      final message =
          'Join LazerVault using my referral code: $code and get ${currencySymbol}50 bonus! '
          'Download the app now: https://lazervault.com';

      await SharePlus.instance.share(ShareParams(text: message));
    } catch (e) {
      if (isClosed) return;
      emit(ReferralError('Failed to share code: $e'));
    }
  }

  /// Validate referral code (for signup)
  Future<void> validateCode(String code) async {
    if (code.isEmpty) {
      if (isClosed) return;
      emit(const ReferralValidated(
        isValid: false,
        message: 'Please enter a referral code',
      ));
      return;
    }

    if (isClosed) return;
    emit(const ReferralValidating());

    final result = await _validateReferralCodeUseCase(code: code);

    result.fold(
      (failure) => emit(ReferralValidated(
        isValid: false,
        message: failure.message,
      )),
      (isValid) => emit(ReferralValidated(
        isValid: isValid,
        message: isValid ? 'Valid referral code' : 'Invalid referral code',
      )),
    );
  }

  /// Get currency symbol for display
  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'NGN':
        return '₦';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      default:
        return '\$';
    }
  }

  /// Load all referrals with optional filter (for All Referrals screen)
  Future<void> loadAllReferrals({String filter = '', int page = 1}) async {
    if (isClosed) return;
    emit(const ReferralLoading(loadingMessage: 'Loading referrals...'));

    final result = await _getMyReferralsUseCase(
      page: page,
      pageSize: 20,
      filter: filter,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (referrals) => emit(AllReferralsLoaded(
        referrals: referrals,
        filter: filter,
        currentPage: page,
        hasMore: referrals.length >= 20,
      )),
    );
  }

  /// Load more referrals for pagination
  Future<void> loadMoreReferrals() async {
    final currentState = state;
    if (currentState is! AllReferralsLoaded || !currentState.hasMore) return;

    final nextPage = currentState.currentPage + 1;
    final result = await _getMyReferralsUseCase(
      page: nextPage,
      pageSize: 20,
      filter: currentState.filter,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (newReferrals) => emit(currentState.copyWith(
        referrals: [...currentState.referrals, ...newReferrals],
        currentPage: nextPage,
        hasMore: newReferrals.length >= 20,
      )),
    );
  }

  /// Load LazerPoints balance
  Future<void> loadPointsBalance() async {
    if (isClosed) return;
    emit(const ReferralLoading(loadingMessage: 'Loading points...'));

    final result = await _getMyPointsBalanceUseCase();

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (balance) => emit(PointsBalanceLoaded(balance: balance)),
    );
  }

  /// Load LazerPoints transaction history
  Future<void> loadPointsHistory({int page = 1}) async {
    if (isClosed) return;
    if (page == 1) {
      emit(const ReferralLoading(loadingMessage: 'Loading points history...'));
    }

    final result = await _getMyPointsHistoryUseCase(page: page, pageSize: 20);

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (transactions) {
        if (page > 1 && state is PointsHistoryLoaded) {
          final current = state as PointsHistoryLoaded;
          emit(current.copyWith(
            transactions: [...current.transactions, ...transactions],
            currentPage: page,
            hasMore: transactions.length >= 20,
          ));
        } else {
          emit(PointsHistoryLoaded(
            transactions: transactions,
            currentPage: page,
            hasMore: transactions.length >= 20,
          ));
        }
      },
    );
  }

  /// Load more points history for pagination
  Future<void> loadMorePointsHistory() async {
    final currentState = state;
    if (currentState is! PointsHistoryLoaded || !currentState.hasMore) return;
    await loadPointsHistory(page: currentState.currentPage + 1);
  }

  /// Load LazerPoints earn rules/configuration
  Future<void> loadPointsConfig() async {
    if (isClosed) return;
    emit(const ReferralLoading(loadingMessage: 'Loading points config...'));

    final result = await _getPointsConfigUseCase();

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReferralError(failure.message)),
      (configs) => emit(PointsConfigLoaded(configs: configs)),
    );
  }

  /// Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(const ReferralInitial());
  }
}
