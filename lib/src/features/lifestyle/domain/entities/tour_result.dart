class TourResult {
  final String title;
  final String tourId;
  final String location;
  final double price;
  final String currency;
  final String duration;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final String affiliateUrl;
  final String description;
  final String provider;
  final String category;

  const TourResult({
    required this.title,
    required this.tourId,
    required this.location,
    required this.price,
    required this.currency,
    required this.duration,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    required this.affiliateUrl,
    required this.description,
    required this.provider,
    this.category = '',
  });
}
