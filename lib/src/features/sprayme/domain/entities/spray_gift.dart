class SprayGift {
  final String id;
  final String name;
  final String emoji;
  final String description;
  final int price;
  final String category;
  final int sortOrder;
  final String animationType;

  const SprayGift({
    required this.id,
    required this.name,
    required this.emoji,
    this.description = '',
    this.price = 0,
    required this.category,
    this.sortOrder = 0,
    this.animationType = 'float_up',
  });

  double get priceMajor => price / 100;
  bool get isFree => price == 0;

  factory SprayGift.fromJson(Map<String, dynamic> json) {
    return SprayGift(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? 'basic',
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      animationType: json['animation_type'] as String? ?? 'float_up',
    );
  }
}
