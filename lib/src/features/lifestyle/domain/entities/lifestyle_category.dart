class LifestyleCategory {
  final String id;
  final String name;
  final String description;
  final String icon;
  final bool available;
  final List<String> providers;

  const LifestyleCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.available,
    required this.providers,
  });
}
