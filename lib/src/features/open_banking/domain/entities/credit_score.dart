import 'package:equatable/equatable.dart';

class CreditScoreEntity extends Equatable {
  final String id;
  final int score; // 300-850
  final String rating; // excellent, good, fair, poor
  final String bankName;
  final String linkedAccountId;
  final double paymentHistoryScore;
  final double incomeStabilityScore;
  final double spendingDisciplineScore;
  final double accountAgeScore;
  final double balanceConsistencyScore;
  final int transactionsAnalyzed;
  final int monthsOfData;
  final DateTime calculatedAt;
  final DateTime? nextRefreshAt;
  final List<CreditScoreTipEntity> tips;
  final String source; // "lazervault", "external", "combined"
  final String sourceLabel;
  final double confidence; // 0.0-1.0

  const CreditScoreEntity({
    required this.id,
    required this.score,
    required this.rating,
    required this.bankName,
    required this.linkedAccountId,
    required this.paymentHistoryScore,
    required this.incomeStabilityScore,
    required this.spendingDisciplineScore,
    required this.accountAgeScore,
    required this.balanceConsistencyScore,
    required this.transactionsAnalyzed,
    required this.monthsOfData,
    required this.calculatedAt,
    this.nextRefreshAt,
    this.tips = const [],
    this.source = 'external',
    this.sourceLabel = '',
    this.confidence = 0.0,
  });

  String get ratingLabel {
    switch (rating) {
      case 'excellent':
        return 'Excellent';
      case 'good':
        return 'Good';
      case 'fair':
        return 'Fair';
      case 'poor':
        return 'Poor';
      default:
        return rating;
    }
  }

  @override
  List<Object?> get props => [
        id,
        score,
        rating,
        bankName,
        linkedAccountId,
        paymentHistoryScore,
        incomeStabilityScore,
        spendingDisciplineScore,
        accountAgeScore,
        balanceConsistencyScore,
        transactionsAnalyzed,
        monthsOfData,
        calculatedAt,
        nextRefreshAt,
        tips,
        source,
        sourceLabel,
        confidence,
      ];
}

class MultiSourceCreditScores extends Equatable {
  final CreditScoreEntity lazervaultScore;
  final CreditScoreEntity? externalScore;
  final CreditScoreEntity? combinedScore;
  final bool hasLinkedBanks;

  const MultiSourceCreditScores({
    required this.lazervaultScore,
    this.externalScore,
    this.combinedScore,
    required this.hasLinkedBanks,
  });

  @override
  List<Object?> get props => [
        lazervaultScore,
        externalScore,
        combinedScore,
        hasLinkedBanks,
      ];
}

class CreditScoreTipEntity extends Equatable {
  final String title;
  final String description;
  final String category;
  final int potentialImpact;

  const CreditScoreTipEntity({
    required this.title,
    required this.description,
    required this.category,
    required this.potentialImpact,
  });

  @override
  List<Object?> get props => [title, description, category, potentialImpact];
}

class CreditScoreHistoryEntity extends Equatable {
  final List<CreditScoreHistoryPointEntity> history;
  final int scoreChange;

  const CreditScoreHistoryEntity({
    required this.history,
    required this.scoreChange,
  });

  @override
  List<Object?> get props => [history, scoreChange];
}

class CreditScoreHistoryPointEntity extends Equatable {
  final int score;
  final String rating;
  final DateTime date;

  const CreditScoreHistoryPointEntity({
    required this.score,
    required this.rating,
    required this.date,
  });

  @override
  List<Object?> get props => [score, rating, date];
}
