import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/hotel_result.dart';

class HotelResultCard extends StatelessWidget {
  final HotelResult hotel;
  final VoidCallback onBook;

  const HotelResultCard({
    super.key,
    required this.hotel,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel image
          if (hotel.imageUrl.isNotEmpty)
            SizedBox(
              height: 160,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: hotel.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: const Color(0xFF2D2D2D),
                  child: const Center(
                    child: Icon(Icons.hotel, color: Color(0xFF9CA3AF), size: 40),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: const Color(0xFF2D2D2D),
                  child: const Center(
                    child: Icon(Icons.hotel, color: Color(0xFF9CA3AF), size: 40),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and stars
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        hotel.hotelName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      hotel.starsDisplay,
                      style: const TextStyle(color: Color(0xFFFB923C), fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Location and rating
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        hotel.location,
                        style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (hotel.rating > 0) ...[
                      const Icon(Icons.star, size: 14, color: Color(0xFFFB923C)),
                      const SizedBox(width: 2),
                      Text(
                        hotel.rating.toStringAsFixed(1),
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                // Provider badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    hotel.provider,
                    style: const TextStyle(color: Color(0xFF3B82F6), fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 12),
                // Price and book
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${hotel.currency} ${hotel.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'per night',
                          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Book', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
