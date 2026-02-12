import 'package:equatable/equatable.dart';
import '../../domain/entities/crowdfund_entities.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object?> get props => [];
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardEntry> entries;
  final LeaderboardSortBy sortBy;
  final String? category;
  final bool isStale;

  const LeaderboardLoaded({
    required this.entries,
    required this.sortBy,
    this.category,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [entries, sortBy, category, isStale];
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError(this.message);

  @override
  List<Object?> get props => [message];
}
