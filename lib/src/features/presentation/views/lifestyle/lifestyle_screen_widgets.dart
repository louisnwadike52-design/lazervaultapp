part of 'lifestyle_screen.dart';

class LifestylePromo {
  final String title;
  final String description;
  final String image;
  final Color backgroundColor;

  LifestylePromo({
    required this.title,
    required this.description,
    required this.image,
    required this.backgroundColor,
  });
}

class LifestyleCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<PerkItem> items;

  LifestyleCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class PerkItem {
  final String title;
  final String description;
  final String image;

  PerkItem({
    required this.title,
    required this.description,
    required this.image,
  });
}
