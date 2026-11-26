import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lazervault/core/network/network_timeouts.dart';

/// RUN A KYC PROFILE WRITE BEHIND A BLOCKING, BOUNDED PROGRESS OVERLAY.
///
/// ## The report this exists for
///
/// 2026-11-24: a customer could not finish verification. He was shown the UI
/// to correct his details, used it, "after which the UI became unresponsive".
/// It was not unresponsive — `openKycDateOfBirthFix` awaited
/// `updateUserProfile` with no progress indicator and no time limit, so once
/// the confirm dialog popped there was a plain form on screen, a live
/// Continue button, and nothing to say a save was in flight. On a congested
/// cell that is indistinguishable from a tap that did nothing, so the
/// customer taps again — which starts a SECOND identity write, or a second
/// billed verification attempt against a three-attempt cap.
///
/// ## What it guarantees
///
/// * **Something is always on screen** while the write is in flight, and it
///   is modal, so the underlying action cannot be re-fired by a second tap.
/// * **It always comes down.** The dismissal is in a `finally` and the future
///   is bounded by [NetworkTimeouts.interactive], so neither a thrown error
///   nor a socket that never answers can leave the overlay stranded over a
///   screen the customer then cannot use. This is the failure mode being
///   fixed; re-introducing it by dismissing on the happy path only would be
///   worse than having no overlay at all.
/// * **OS back cannot strand it either** — `canPop: false` plus a
///   non-dismissible barrier. A back press during an identity write has no
///   good meaning: the write either lands or times out, and letting the
///   customer leave mid-flight is how a screen resumes with a stale profile.
/// * **A timeout is reported as a timeout**, not as a refusal. "Could not
///   save" over a write that may well have landed sends the customer to
///   support over a correction that is already applied; [TimeoutException]
///   is left to the caller to word for the action in hand.
///
/// ## Why 45 seconds and not a tunable
///
/// [NetworkTimeouts.interactive] is the app's single answer to "the user
/// tapped something and is watching a spinner", chosen for Nigerian 2G/3G
/// cells where a request that WOULD have succeeded routinely takes twenty
/// seconds. A second number here would drift from it. It is a UI-liveness
/// bound, not a business rule: the server is still the authority on whether
/// the write applied, and the caller re-reads rather than assuming.
Future<T> runKycSave<T>(
  BuildContext context, {
  required String message,
  required Future<T> Function() action,
  Duration? timeout,
}) async {
  final navigator = Navigator.of(context, rootNavigator: true);

  // Tracked so the pop below cannot hit the CALLER's route. The overlay is
  // non-dismissible, so normally only our own pop closes it — but a
  // route-level teardown (the screen underneath being removed while the write
  // was in flight) closes it too, and an unguarded pop would then navigate
  // the customer off the flow at the exact moment their correction landed.
  var closed = false;

  // Unawaited deliberately: this future completes when the overlay is popped
  // in the `finally`, which is after `action` has settled. Awaiting it here
  // would deadlock the save behind its own progress indicator.
  final shown = showDialog<void>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (_) => KycSavingOverlay(message: message),
  ).whenComplete(() => closed = true);

  try {
    return await action().timeout(timeout ?? NetworkTimeouts.interactive);
  } finally {
    if (!closed && navigator.canPop()) navigator.pop();
    // Let the pop settle before the caller shows its own dialog or snackbar,
    // so a refusal message is not pushed under an overlay that is still on
    // its way out — the stale-looking screen this whole helper is about.
    await shown;
  }
}

/// The overlay itself. Separate so the copy and the shape are testable
/// without driving a network call.
class KycSavingOverlay extends StatelessWidget {
  const KycSavingOverlay({super.key, this.message = 'Saving…'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2.4),
              ),
              const SizedBox(height: 14),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.4,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
