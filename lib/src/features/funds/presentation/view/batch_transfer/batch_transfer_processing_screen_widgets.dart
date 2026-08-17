part of 'batch_transfer_processing_screen.dart';

enum BatchProcessingStatus {
  initiated,
  validating,
  reservingFunds,
  processing,
  completed,
}

class _ProcessingStep {
  final BatchProcessingStatus status;
  final String title;
  final String description;
  final IconData icon;

  const _ProcessingStep({
    required this.status,
    required this.title,
    required this.description,
    required this.icon,
  });
}
