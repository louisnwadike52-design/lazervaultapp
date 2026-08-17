part of 'invoice_processing_screen.dart';

enum InvoiceProcessingStatus {
  initiated,
  validating,
  processing,
  completed,
}

class _ProcessingStep {
  final InvoiceProcessingStatus status;
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
