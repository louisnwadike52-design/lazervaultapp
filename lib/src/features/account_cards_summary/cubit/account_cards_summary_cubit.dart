import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_account_summaries_usecase.dart';
import 'account_cards_summary_state.dart';


class AccountCardsSummaryCubit extends Cubit<AccountCardsSummaryState> {
  final GetAccountSummariesUseCase _getAccountSummariesUseCase;

  AccountCardsSummaryCubit(this._getAccountSummariesUseCase)
      : super(AccountCardsSummaryInitial());

  Future<void> fetchAccountSummaries({
    required String userId,
    String? accessToken,
    String? country,
  }) async {
    if (isClosed) return;
    emit(AccountCardsSummaryLoading());
    final result = await _getAccountSummariesUseCase.call(
      userId: userId,
      accessToken: accessToken,
      country: country,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(AccountCardsSummaryError(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (summaries) => emit(AccountCardsSummaryLoaded(summaries)),
    );
  }
} 