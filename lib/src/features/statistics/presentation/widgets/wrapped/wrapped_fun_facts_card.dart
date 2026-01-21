import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Card showing fun facts and comparisons
class WrappedFunFactsCard extends StatelessWidget {
  final List<WrappedFunFact> funFacts;

  const WrappedFunFactsCard({
    super.key,
    required this.funFacts,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.funFacts,
      title: 'Fun Facts',
      subtitle: 'Some interesting numbers',
      child: ListView.builder(
        itemCount: funFacts.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return _FunFactItem(funFact: funFacts[index]);
        },
      ),
    );
  }
}

class _FunFactItem extends StatelessWidget {
  final WrappedFunFact funFact;

  const _FunFactItem({required this.funFact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                funFact.emoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  funFact.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF2d3436),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            funFact.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF636e72),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFf093fb).withOpacity(0.3),
                  const Color(0xFFf5576c).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              funFact.comparison,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF2d3436),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
