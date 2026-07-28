import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

/// Holds a P2P chat destination captured from a tapped push notification until
/// the app is authenticated and a navigator is ready.
///
/// Two entry timings are handled:
///  * **Warm** (app foreground/background): the tap fires while authenticated →
///    [consumeAndNavigate] routes immediately.
///  * **Cold start / from-terminated**: the tap is delivered during push init
///    (via getInitialMessage) BEFORE login → we stash the target; the dashboard
///    calls [consumeAndNavigate] on mount (after the login gate), so the user
///    lands on the chat once signed in.
///
/// Navigation uses `Get.toNamed` (a push on top of the dashboard) so Back from
/// the chat returns to the dashboard — never out of the app or to the login
/// gate. Consumption is atomic (take-and-clear) so it fires exactly once even
/// if both the tap handler and the dashboard try.
class PendingChatNavigation {
  PendingChatNavigation._();
  static final PendingChatNavigation instance = PendingChatNavigation._();

  Map<String, dynamic>? _pending;

  /// Stash a chat target from a p2p_message push payload. [otherUserId] is the
  /// SENDER (the other party from the recipient's perspective).
  void set({
    required String otherUserId,
    String? otherUserName,
    String? conversationId,
  }) {
    if (otherUserId.isEmpty) return;
    _pending = {
      'otherUserId': otherUserId,
      if (otherUserName != null && otherUserName.isNotEmpty)
        'otherUserName': otherUserName,
      if (conversationId != null && conversationId.isNotEmpty)
        'conversationId': conversationId,
      // Opened from a push tap → treat as an existing/known contact so the chat
      // header doesn't show a "not saved" affordance.
      'isSavedRecipient': true,
      'fromPush': true,
    };
  }

  bool get hasPending => _pending != null;

  bool _isAuthenticated() {
    try {
      final s = serviceLocator<AuthenticationCubit>().state;
      return s is AuthenticationSuccess || s is AuthenticationAuthenticated;
    } catch (_) {
      return false;
    }
  }

  bool _onAuthOrLockRoute() {
    final r = Get.currentRoute;
    return r.startsWith('/auth/') ||
        r.startsWith('/kyc/') ||
        r.contains('login') ||
        r.contains('passcode') ||
        r.contains('sign-in') ||
        r.contains('signup');
  }

  /// If a chat target is pending AND the app is authenticated AND we're not
  /// sitting on the login/onboarding gate, navigate to it (once). Otherwise
  /// leave it stashed for the next caller (typically the dashboard on mount).
  void consumeAndNavigate() {
    if (_pending == null) return;
    if (!_isAuthenticated()) return;
    if (Get.context == null) return; // navigator not mounted yet
    if (_onAuthOrLockRoute()) return; // wait until past the gate
    final args = _pending;
    _pending = null; // take-and-clear: fire exactly once
    // Defer to the next frame so we never push during a build / route change.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.toNamed(AppRoutes.p2pChat, arguments: args);
    });
  }
}
