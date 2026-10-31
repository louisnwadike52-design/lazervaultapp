import '../../src/features/widgets/dashboard/expenditure_chart_type.dart';

/// Manages dashboard UI state that should persist across navigation.
///
/// This is a singleton that stores carousel positions so they can be
/// restored when returning to the dashboard from other screens.
class DashboardStateManager {
  // Singleton instance
  static final DashboardStateManager _instance =
      DashboardStateManager._internal();
  factory DashboardStateManager() => _instance;
  DashboardStateManager._internal();

  /// Current services carousel page index
  int _servicesCarouselIndex = 0;

  /// Get the current services carousel index
  int get servicesCarouselIndex => _servicesCarouselIndex;

  /// The expenditure card's chosen chart shape.
  ///
  /// Lives here rather than in the card's own State because that State is
  /// disposed every time the user leaves the dashboard — tapping into a
  /// service and coming back would reset the chart to a line and lose the
  /// choice they just made.
  ///
  /// Deliberately NOT written to disk. It resets to the default on a cold
  /// start, which is wanted: the line trend is the right thing to open on, and
  /// persisting it to SharedPreferences would mean an async read the card
  /// cannot wait for, so the first frame would draw a line and then visibly
  /// swap to the remembered shape.
  ///
  /// Null means "never chosen" — the card picks the first shape its data
  /// supports, which is not always the line (a period with categories but a
  /// single day of activity has no line to draw).
  ExpenditureChartType? _expenditureChartType;

  ExpenditureChartType? get expenditureChartType => _expenditureChartType;

  void setExpenditureChartType(ExpenditureChartType type) {
    _expenditureChartType = type;
  }

  /// Set the services carousel index
  void setServicesCarouselIndex(int index) {
    _servicesCarouselIndex = index;
  }

  /// Reset all state (e.g., on logout)
  void reset() {
    _servicesCarouselIndex = 0;
    _expenditureChartType = null;
  }
}
