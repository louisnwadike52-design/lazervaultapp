import 'package:flutter/material.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';

class FlightResultCard extends StatelessWidget {
  final FlightResult flight;
  final VoidCallback onBook;

  const FlightResultCard({
    super.key,
    required this.flight,
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Route and airline
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        flight.origin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.arrow_forward, color: Color(0xFF9CA3AF), size: 16),
                      ),
                      Text(
                        flight.destination,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    flight.provider,
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Details row
            Row(
              children: [
                _buildDetail(Icons.airline_seat_recline_normal, flight.airline),
                const SizedBox(width: 16),
                _buildDetail(Icons.schedule, flight.formattedDuration),
                const SizedBox(width: 16),
                _buildDetail(Icons.connecting_airports, flight.stopsLabel),
              ],
            ),
            const SizedBox(height: 12),
            // Date
            if (flight.departDate.isNotEmpty)
              Row(
                children: [
                  _buildDetail(Icons.calendar_today, flight.departDate),
                  if (flight.returnDate.isNotEmpty) ...[
                    const SizedBox(width: 16),
                    _buildDetail(Icons.event, 'Return: ${flight.returnDate}'),
                  ],
                ],
              ),
            const SizedBox(height: 16),
            // Price and book button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${flight.currency} ${flight.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'per person',
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
    );
  }

  Widget _buildDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
      ],
    );
  }
}
