import 'package:flutter/material.dart';

import 'package:lazervault/core/services/app_update_service.dart';

/// Full-screen, non-dismissible update gate shown when the running build is
/// below the minimum supported build (`app_min_build_android` /
/// `app_min_build_ios`, both operator settings).
///
/// STRONGER THAN A BOTTOM SHEET ON PURPOSE. A sheet that cannot be closed is
/// still a sheet: the app is behind it, the OS back gesture argues with it,
/// and on Android a sheet dismissed by a system gesture leaves the user
/// looking at a build we have decided is not safe to use. This takes the whole
/// screen, blocks pop (PopScope), and offers exactly one action — open the
/// store. The optional update is the one that is a dismissible sheet
/// (update_modal.dart), which is the difference the user should feel.
///
/// The copy says what is needed and thanks the customer for being here. It
/// names no fault and makes no apology: it is the operator's voice, and an
/// older build is not something the customer did.
class ForcedUpdateScreen extends StatelessWidget {
  final AppUpdateInfo info;
  final Future<void> Function() onUpdate;

  const ForcedUpdateScreen({
    super.key,
    required this.info,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFF0A0A0A);
    const Color textPrimary = Colors.white;
    const Color textSecondary = Color(0xFF9CA3AF);
    const Color primary = Color(0xFF4E03D0); // LazerVault brand purple

    return PopScope(
      canPop: false,
      child: Material(
        color: background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.system_update,
                    color: primary,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Update required 🚀',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  info.notes.isNotEmpty
                      ? info.notes
                      : 'A newer version of Lazervault is needed to continue '
                          'using the app. Update now to keep everything '
                          'working securely. 🔒',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                // A SEPARATE LINE, not part of the body above, because the
                // body is replaced wholesale by the operator's release notes
                // when there are any — and the thank-you should survive that.
                const Text(
                  'Thank you for choosing Lazervault 💜',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: onUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Update now ⬆️',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
