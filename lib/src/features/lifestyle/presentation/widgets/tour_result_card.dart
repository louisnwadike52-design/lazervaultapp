import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/tour_result.dart';

class TourResultCard extends StatelessWidget {
  final TourResult tour;
  final VoidCallback onBook;

  const TourResultCard({
    super.key,
    required this.tour,
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
          // Tour image
          if (tour.imageUrl.isNotEmpty)
            SizedBox(
              height: 140,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: tour.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: const Color(0xFF2D2D2D),
                  child: const Center(
                    child: Icon(Icons.explore, color: Color(0xFF9CA3AF), size: 40),
                  ),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: const Color(0xFF2D2D2D),
                  child: const Center(
                    child: Icon(Icons.explore, color: Color(0xFF9CA3AF), size: 40),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  tour.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Details row
                Row(
                  children: [
                    if (tour.duration.isNotEmpty) ...[
                      const Icon(Icons.schedule, size: 14, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 4),
                      Text(tour.duration, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                      const SizedBox(width: 12),
                    ],
                    if (tour.rating > 0) ...[
                      const Icon(Icons.star, size: 14, color: Color(0xFFFB923C)),
                      const SizedBox(width: 2),
                      Text(
                        '${tour.rating.toStringAsFixed(1)} (${tour.reviewCount})',
                        style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                      ),
                    ],
                  ],
                ),
                if (tour.description.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    tour.description,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 12),
                // Price and book
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${tour.currency} ${tour.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'from ${tour.provider}',
                          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
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
