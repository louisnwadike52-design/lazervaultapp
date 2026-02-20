import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';

class LifestyleCategoryModel extends LifestyleCategory {
  const LifestyleCategoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
    required super.available,
    required super.providers,
  });

  factory LifestyleCategoryModel.fromJson(Map<String, dynamic> json) {
    return LifestyleCategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      available: json['available'] as bool? ?? false,
      providers: (json['providers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
