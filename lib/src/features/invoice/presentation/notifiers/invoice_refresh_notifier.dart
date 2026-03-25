import 'package:flutter/foundation.dart';

/// Singleton notifier that bridges invoice state changes across different
/// cubit instances and route scopes.
///
/// When an invoice is created, unlocked, paid, or otherwise mutated on a
/// screen that owns its own [InvoiceCubit] instance, the notifier fires so
/// that the [InvoiceHomeScreen] (which holds a separate cubit) can reload.
class InvoiceRefreshNotifier extends ChangeNotifier {
  /// Call after any mutation that should cause the invoice list to reload.
  void notifyRefresh() {
    notifyListeners();
  }
}
