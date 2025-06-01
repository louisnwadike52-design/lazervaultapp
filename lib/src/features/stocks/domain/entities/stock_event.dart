class StockEvent {
  final String id;
  final String title;
  final DateTime date;
  final String type;
  final String description;

  const StockEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
    required this.description,
  });
} 