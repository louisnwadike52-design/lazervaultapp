import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/statements/domain/entities/statement_entity.dart';
import 'package:lazervault/src/features/statements/domain/usecases/download_statement_usecase.dart';
import 'package:lazervault/src/features/statements/domain/usecases/get_statement_history_usecase.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_state.dart';

class StatementCubit extends Cubit<StatementState> {
  final DownloadStatementUseCase _downloadStatementUseCase;
  final GetStatementHistoryUseCase _getStatementHistoryUseCase;

  StatementCubit({
    required DownloadStatementUseCase downloadStatementUseCase,
    required GetStatementHistoryUseCase getStatementHistoryUseCase,
  })  : _downloadStatementUseCase = downloadStatementUseCase,
        _getStatementHistoryUseCase = getStatementHistoryUseCase,
        super(StatementInitial());

  Future<void> downloadStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    required StatementFormat format,
  }) async {
    emit(StatementDownloading());

    final result = await _downloadStatementUseCase.call(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      format: format,
    );

    result.fold(
      (failure) => emit(StatementDownloadFailure(message: failure.message)),
      (statement) => emit(StatementDownloadSuccess(statement: statement)),
    );
  }

  Future<void> getStatementHistory({
    required String accountId,
    int? limit,
  }) async {
    emit(StatementHistoryLoading());

    final result = await _getStatementHistoryUseCase.call(
      accountId: accountId,
      limit: limit,
    );

    result.fold(
      (failure) => emit(StatementHistoryFailure(message: failure.message)),
      (statements) => emit(StatementHistoryLoaded(statements: statements)),
    );
  }

  void reset() {
    emit(StatementInitial());
  }
}
