import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';

class FlightResultModel extends FlightResult {
  const FlightResultModel({
    required super.provider,
    required super.airline,
    required super.airlineCode,
    required super.origin,
    required super.destination,
    required super.departDate,
    required super.returnDate,
    required super.price,
    required super.currency,
    required super.durationMinutes,
    required super.stops,
    required super.cabinClass,
    required super.affiliateUrl,
    super.departureTime,
    super.arrivalTime,
  });

  factory FlightResultModel.fromJson(Map<String, dynamic> json) {
    return FlightResultModel(
      provider: json['provider'] as String? ?? '',
      airline: json['airline'] as String? ?? '',
      airlineCode: json['airline_code'] as String? ?? '',
      origin: json['origin'] as String? ?? '',
      destination: json['destination'] as String? ?? '',
      departDate: json['depart_date'] as String? ?? '',
      returnDate: json['return_date'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? '',
      durationMinutes: json['duration_minutes'] as int? ?? 0,
      stops: json['stops'] as int? ?? 0,
      cabinClass: json['cabin_class'] as String? ?? '',
      affiliateUrl: json['affiliate_url'] as String? ?? '',
      departureTime: json['departure_time'] as String? ?? '',
      arrivalTime: json['arrival_time'] as String? ?? '',
    );
  }
}
