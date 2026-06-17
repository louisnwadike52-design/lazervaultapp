class DailySummary {
  final String date;
  final int tasksCompleted;
  final int tasksTotal;
  final int eventsAttended;
  final int focusMinutes;
  final double completionRate;
  final List<String> topCategories;
  final String productivityScore; // low, medium, high

  DailySummary({
    required this.date,
    required this.tasksCompleted,
    required this.tasksTotal,
    required this.eventsAttended,
    required this.focusMinutes,
    required this.completionRate,
    required this.topCategories,
    required this.productivityScore,
  });

  factory DailySummary.fromJson(Map<String, dynamic> json) {
    return DailySummary(
      date: json['date'] as String,
      tasksCompleted: json['tasks_completed'] as int? ?? 0,
      tasksTotal: json['tasks_total'] as int? ?? 0,
      eventsAttended: json['events_attended'] as int? ?? 0,
      focusMinutes: json['focus_minutes'] as int? ?? 0,
      completionRate: (json['completion_rate'] as num?)?.toDouble() ?? 0.0,
      topCategories: (json['top_categories'] as List<dynamic>?)?.cast<String>() ?? [],
      productivityScore: json['productivity_score'] as String? ?? 'medium',
    );
  }

  int get tasksRemaining => tasksTotal - tasksCompleted;

  double get completionPercentage => tasksTotal > 0
      ? (tasksCompleted / tasksTotal * 100)
      : 0.0;

  String get productivityLabel {
    switch (productivityScore) {
      case 'high':
        return 'Excellent!';
      case 'medium':
        return 'Good progress';
      case 'low':
        return 'Room to improve';
      default:
        return '';
    }
  }
}
