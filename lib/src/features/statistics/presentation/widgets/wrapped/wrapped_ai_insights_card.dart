import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Card showing AI-generated personality insights
class WrappedAIInsightsCard extends StatelessWidget {
  final WrappedAIInsights aiInsights;

  const WrappedAIInsightsCard({
    super.key,
    required this.aiInsights,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.aiInsights,
      title: 'You\'re a...',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          // Financial Persona
          Text(
            aiInsights.financialPersona,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: const Color(0xFF2d3436),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Personality Traits
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: aiInsights.personalityTraits.map((trait) {
              return _TraitChip(trait: trait);
            }).toList(),
          ),
          const SizedBox(height: 24),
          // Overall Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              aiInsights.overallSummary,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF2d3436),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          // Personalized Insights
          if (aiInsights.personalizedInsights.isNotEmpty) ...[
            Text(
              'Your Insights',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF2d3436),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...aiInsights.personalizedInsights.take(3).map((insight) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          insight,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF2d3436),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: 24),
          // Encouragement
          Text(
            aiInsights.encouragement,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF636e72),
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _TraitChip extends StatelessWidget {
  final String trait;

  const _TraitChip({required this.trait});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        trait,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
