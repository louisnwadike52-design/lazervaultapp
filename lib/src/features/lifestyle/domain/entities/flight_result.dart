class FlightResult {
  final String provider;
  final String airline;
  final String airlineCode;
  final String origin;
  final String destination;
  final String departDate;
  final String returnDate;
  final double price;
  final String currency;
  final int durationMinutes;
  final int stops;
  final String cabinClass;
  final String affiliateUrl;
  final String departureTime;
  final String arrivalTime;

  const FlightResult({
    required this.provider,
    required this.airline,
    required this.airlineCode,
    required this.origin,
    required this.destination,
    required this.departDate,
    required this.returnDate,
    required this.price,
    required this.currency,
    required this.durationMinutes,
    required this.stops,
    required this.cabinClass,
    required this.affiliateUrl,
    this.departureTime = '',
    this.arrivalTime = '',
  });

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final mins = durationMinutes % 60;
    if (hours > 0 && mins > 0) return '${hours}h ${mins}m';
    if (hours > 0) return '${hours}h';
    return '${mins}m';
  }

  String get stopsLabel {
    if (stops == 0) return 'Direct';
    if (stops == 1) return '1 stop';
    return '$stops stops';
  }
}
