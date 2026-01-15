import 'package:equatable/equatable.dart';

class TVPackageEntity extends Equatable {
  final String packageCode;
  final String packageName;
  final String providerCode;
  final double price;
  final String currency;
  final int duration; // in days (30 for monthly)
  final String? description;
  final List<String> channels; // for TV packages
  final List<String> features; // for internet packages
  final bool isActive;

  const TVPackageEntity({
    required this.packageCode,
    required this.packageName,
    required this.providerCode,
    required this.price,
    required this.currency,
    required this.duration,
    this.description,
    this.channels = const [],
    this.features = const [],
    this.isActive = true,
  });

  String get formattedPrice => '$currency${price.toStringAsFixed(2)}';

  String get formattedDuration {
    if (duration >= 30) {
      final months = (duration / 30).round();
      return months == 1 ? '1 Month' : '$months Months';
    }
    return '$duration Days';
  }

  @override
  List<Object?> get props => [
        packageCode,
        packageName,
        providerCode,
        price,
        currency,
        duration,
        description,
        channels,
        features,
        isActive,
      ];
}
