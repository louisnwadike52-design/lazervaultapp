class HotelResult {
  final String hotelName;
  final String hotelId;
  final String location;
  final int stars;
  final double rating;
  final double pricePerNight;
  final double totalPrice;
  final String currency;
  final String imageUrl;
  final String affiliateUrl;
  final List<String> amenities;
  final String provider;

  const HotelResult({
    required this.hotelName,
    required this.hotelId,
    required this.location,
    required this.stars,
    required this.rating,
    required this.pricePerNight,
    required this.totalPrice,
    required this.currency,
    required this.imageUrl,
    required this.affiliateUrl,
    required this.amenities,
    required this.provider,
  });

  String get starsDisplay => List.filled(stars, '★').join();
}
