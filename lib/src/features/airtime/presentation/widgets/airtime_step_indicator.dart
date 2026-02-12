import 'package:flutter/material.dart';

class AirtimeStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;

  const AirtimeStepIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
    this.stepLabels = const ['Network', 'Phone', 'Amount', 'Confirm'],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isOdd) {
            // Connector line
            final stepIndex = index ~/ 2;
            final isCompleted = stepIndex < currentStep;
            return Expanded(
              child: Container(
                height: 2,
                color: isCompleted
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFF2D2D2D),
              ),
            );
          }
          // Step circle
          final stepIndex = index ~/ 2;
          final isActive = stepIndex == currentStep;
          final isCompleted = stepIndex < currentStep;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? const Color(0xFF3B82F6)
                      : isActive
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF2D2D2D),
                  border: isActive
                      ? Border.all(
                          color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                          width: 3,
                        )
                      : null,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF9CA3AF),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stepIndex < stepLabels.length ? stepLabels[stepIndex] : '',
                style: TextStyle(
                  color: isActive || isCompleted
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
