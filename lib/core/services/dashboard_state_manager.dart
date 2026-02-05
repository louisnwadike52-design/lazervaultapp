/// Manages dashboard UI state that should persist across navigation.
///
/// This is a singleton that stores carousel positions so they can be
/// restored when returning to the dashboard from other screens.
class DashboardStateManager {
  // Singleton instance
  static final DashboardStateManager _instance = DashboardStateManager._internal();
  factory DashboardStateManager() => _instance;
  DashboardStateManager._internal();

  /// Current services carousel page index
  int _servicesCarouselIndex = 0;

  /// Get the current services carousel index
  int get servicesCarouselIndex => _servicesCarouselIndex;

  /// Set the services carousel index
  void setServicesCarouselIndex(int index) {
    _servicesCarouselIndex = index;
  }

  /// Reset all state (e.g., on logout)
  void reset() {
    _servicesCarouselIndex = 0;
  }
}
