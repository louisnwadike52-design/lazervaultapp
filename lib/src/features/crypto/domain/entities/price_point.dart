import 'package:equatable/equatable.dart';

class PricePoint extends Equatable {
  final DateTime timestamp;
  final double price;
  final double? open;
  final double? high;
  final double? low;
  final double? close;
  final double? volume;

  const PricePoint({
    required this.timestamp,
    required this.price,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });

  @override
  List<Object?> get props => [timestamp, price, open, high, low, close, volume];

  PricePoint copyWith({
    DateTime? timestamp,
    double? price,
    double? open,
    double? high,
    double? low,
    double? close,
    double? volume,
  }) {
    return PricePoint(
      timestamp: timestamp ?? this.timestamp,
      price: price ?? this.price,
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      volume: volume ?? this.volume,
    );
  }
} 