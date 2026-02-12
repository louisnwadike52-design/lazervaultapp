import 'package:equatable/equatable.dart';

class CreditScoreAIInsights extends Equatable {
  final String personalizedSummary;
  final List<FactorAnalysis> factorAnalysis;
  final List<String> actionableRecommendations;
  final String scoreProjection;
  final String riskAssessment;

  const CreditScoreAIInsights({
    required this.personalizedSummary,
    required this.factorAnalysis,
    required this.actionableRecommendations,
    required this.scoreProjection,
    required this.riskAssessment,
  });

  factory CreditScoreAIInsights.fromJson(Map<String, dynamic> json) {
    return CreditScoreAIInsights(
      personalizedSummary: json['personalized_summary'] as String? ?? '',
      factorAnalysis: (json['factor_analysis'] as List<dynamic>?)
              ?.map((e) => FactorAnalysis.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      actionableRecommendations:
          (json['actionable_recommendations'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      scoreProjection: json['score_projection'] as String? ?? '',
      riskAssessment: json['risk_assessment'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [
        personalizedSummary,
        factorAnalysis,
        actionableRecommendations,
        scoreProjection,
        riskAssessment,
      ];
}

class FactorAnalysis extends Equatable {
  final String factor;
  final double score;
  final String analysis;
  final String recommendation;

  const FactorAnalysis({
    required this.factor,
    required this.score,
    required this.analysis,
    required this.recommendation,
  });

  factory FactorAnalysis.fromJson(Map<String, dynamic> json) {
    return FactorAnalysis(
      factor: json['factor'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      analysis: json['analysis'] as String? ?? '',
      recommendation: json['recommendation'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [factor, score, analysis, recommendation];
}
