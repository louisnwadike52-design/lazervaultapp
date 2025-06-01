class PricePoint {
  final DateTime timestamp;
  final double price;
  final double? volume;

  PricePoint({
    required this.timestamp,
    required this.price,
    this.volume,
  });
} 