// States for Education History
sealed class EducationHistoryState {}

class EducationHistoryInitial extends EducationHistoryState {}

class EducationHistoryLoading extends EducationHistoryState {}

class EducationHistoryLoaded extends EducationHistoryState {
  final List<dynamic> history;
  final bool hasMore;

  EducationHistoryLoaded({
    required this.history,
    this.hasMore = true,
  });
}

class EducationHistoryError extends EducationHistoryState {
  final String message;

  EducationHistoryError(this.message);
}
