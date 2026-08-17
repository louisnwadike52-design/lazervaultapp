part of 'transfer_processing_screen.dart';

/// Transfer processing states from backend
enum TransferProcessingStatus {
  initiated,
  validating,
  processing,
  completed,
  failed,
}

class _ProcessingStep {
  final TransferProcessingStatus status;
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
