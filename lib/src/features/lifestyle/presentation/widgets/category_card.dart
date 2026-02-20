import 'package:flutter/material.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';

class CategoryCard extends StatelessWidget {
  final LifestyleCategory category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  IconData get _icon {
    switch (category.icon) {
      case 'flight':
        return Icons.flight;
      case 'hotel':
        return Icons.hotel;
      case 'tour':
        return Icons.explore;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: category.available ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: category.available
                ? const Color(0xFF2D2D2D)
                : const Color(0xFF1A1A1A),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: category.available
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _icon,
                  color: category.available
                      ? const Color(0xFF3B82F6)
                      : Colors.grey,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                style: TextStyle(
                  color: category.available ? Colors.white : Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                category.available
                    ? '${category.providers.length} provider${category.providers.length != 1 ? 's' : ''}'
                    : 'Coming soon',
                style: TextStyle(
                  color: category.available
                      ? const Color(0xFF9CA3AF)
                      : Colors.grey[700],
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
