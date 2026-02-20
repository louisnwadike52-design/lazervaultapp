import 'package:lazervault/src/features/lifestyle/domain/entities/tour_result.dart';

class TourResultModel extends TourResult {
  const TourResultModel({
    required super.title,
    required super.tourId,
    required super.location,
    required super.price,
    required super.currency,
    required super.duration,
    required super.rating,
    required super.reviewCount,
    required super.imageUrl,
    required super.affiliateUrl,
    required super.description,
    required super.provider,
    super.category,
  });

  factory TourResultModel.fromJson(Map<String, dynamic> json) {
    return TourResultModel(
      title: json['title'] as String? ?? '',
      tourId: json['tour_id'] as String? ?? '',
      location: json['location'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: json['review_count'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      affiliateUrl: json['affiliate_url'] as String? ?? '',
      description: json['description'] as String? ?? '',
      provider: json['provider'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }
}
