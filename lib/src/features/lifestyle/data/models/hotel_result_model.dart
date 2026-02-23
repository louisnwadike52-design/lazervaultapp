import 'package:lazervault/src/features/lifestyle/domain/entities/hotel_result.dart';

class HotelResultModel extends HotelResult {
  const HotelResultModel({
    required super.hotelName,
    required super.hotelId,
    required super.location,
    required super.stars,
    required super.rating,
    required super.pricePerNight,
    required super.totalPrice,
    required super.currency,
    required super.imageUrl,
    required super.affiliateUrl,
    required super.amenities,
    required super.provider,
  });

  factory HotelResultModel.fromJson(Map<String, dynamic> json) {
    return HotelResultModel(
      hotelName: json['hotel_name'] as String? ?? '',
      hotelId: json['hotel_id'] as String? ?? '',
      location: json['location'] as String? ?? '',
      stars: json['stars'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      pricePerNight: (json['price_per_night'] as num?)?.toDouble() ?? 0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      affiliateUrl: json['affiliate_url'] as String? ?? '',
      amenities: (json['amenities'] as List<dynamic>?)
              ?.whereType<String>()
              .toList() ??
          [],
      provider: json['provider'] as String? ?? '',
    );
  }
}
