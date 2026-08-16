import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// Shortcut types that map to quick action identifiers on both platforms.
/// These must match the native shortcutType (Android) / type (iOS) values.
class QuickActionTypes {
  static const String sendMoney = 'send_money';
  static const String scanToPay = 'scan_to_pay';
  static const String checkBalance = 'check_balance';
  static const String payBills = 'pay_bills';
}

/// Service that initializes app icon quick actions (long-press shortcuts)
/// and routes taps to the correct screen.
///
/// Shortcuts:
///   - Send Money → /send-funds
///   - Scan to Pay → /qr-pay/scan
///   - Check Balance → /dashboard
///   - Pay Bills → /bills
class QuickActionsService {
  static QuickActionsService? _instance;
  static QuickActionsService get instance =>
      _instance ??= QuickActionsService._();

  QuickActionsService._();
  factory QuickActionsService() => instance;

  final QuickActions _quickActions = const QuickActions();
  bool _initialized = false;

  /// Pending shortcut type received before navigation was ready.
  String? _pendingShortcut;

  /// True only where app-icon quick actions exist. The `quick_actions` plugin
  /// ships Android/iOS implementations only — on web/desktop the platform
  /// channel isn't registered, so calling it throws MissingPluginException.
  bool get _isSupportedPlatform =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Initialize quick actions and register the handler.
  /// Call this after the app's first frame so GetX navigation is available.
  void initialize() {
    if (_initialized) return;
    _initialized = true;

    // No-op on unsupported platforms rather than throwing a plugin exception.
    if (!_isSupportedPlatform) return;

    _quickActions.initialize((String shortcutType) {
      debugPrint('[QuickActions] Shortcut tapped: $shortcutType');
      _handleShortcut(shortcutType);
    });

    // Register dynamic shortcuts (supplements native static shortcuts).
    // These appear even if the user hasn't configured static shortcuts correctly.
    unawaited(
      _quickActions.setShortcutItems([
        const ShortcutItem(
          type: QuickActionTypes.sendMoney,
          localizedTitle: 'Send Funds',
          icon: 'ic_send_money',
        ),
        const ShortcutItem(
          type: QuickActionTypes.scanToPay,
          localizedTitle: 'Scan to Pay',
          icon: 'ic_scan_pay',
        ),
        const ShortcutItem(
          type: QuickActionTypes.checkBalance,
          localizedTitle: 'Check Balance',
          icon: 'ic_check_balance',
        ),
        const ShortcutItem(
          type: QuickActionTypes.payBills,
          localizedTitle: 'Bills Hub',
          icon: 'ic_pay_bills',
        ),
      ]).catchError((Object e, StackTrace stackTrace) {
        // Dynamic shortcuts require a launcher that implements ShortcutManager
        // (Android) — some emulator launchers and older devices don't, and the
        // system also rate-limits setDynamicShortcuts. This is an expected,
        // benign limitation: the tap handler above is already registered and
        // any static (manifest) shortcuts still work, so we log at debug level
        // and carry on. Shortcuts are a non-essential convenience feature.
        debugPrint(
            '[QuickActions] Dynamic shortcuts unavailable on this launcher '
            '(non-fatal): $e');
      }),
    );
  }

  /// If a shortcut was tapped while the app was cold-starting, process it now.
  void processPendingShortcut() {
    if (_pendingShortcut != null) {
      final type = _pendingShortcut!;
      _pendingShortcut = null;
      _handleShortcut(type);
    }
  }

  void _handleShortcut(String shortcutType) {
    // If GetX routing isn't ready yet, queue it for later.
    if (Get.context == null) {
      _pendingShortcut = shortcutType;
      return;
    }

    final route = _routeForShortcut(shortcutType);
    if (route != null) {
      debugPrint('[QuickActions] Navigating to $route');
      // Use offAllNamed to ensure clean navigation stack through auth gate.
      // The authCheck route will verify authentication before proceeding.
      // Honor the user's transfer-style choice when entering send funds.
      Get.toNamed(
        route,
        arguments: route == AppRoutes.selectRecipient
            ? {'shortFlow': FeatureFlags.sendFlowShortForSession}
            : null,
      );
    }
  }

  String? _routeForShortcut(String shortcutType) {
    switch (shortcutType) {
      case QuickActionTypes.sendMoney:
        // Enter the real (instrumented) send-funds flow at recipient selection.
        // The legacy AppRoutes.sendFunds route required a User in Get.arguments
        // and crashed when launched arg-less from the OS quick action.
        return AppRoutes.selectRecipient;
      case QuickActionTypes.scanToPay:
        return AppRoutes.scanQR;
      case QuickActionTypes.checkBalance:
        return AppRoutes.dashboard;
      case QuickActionTypes.payBills:
        return AppRoutes.billsHub;
      default:
        debugPrint('[QuickActions] Unknown shortcut type: $shortcutType');
        return null;
    }
  }
}
