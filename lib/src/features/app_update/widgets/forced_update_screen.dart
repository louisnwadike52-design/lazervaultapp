import 'package:flutter/material.dart';

import 'package:lazervault/core/services/app_update_service.dart';

/// Full-screen, non-dismissible update gate shown when the running build is
/// below the minimum supported build. The user cannot back out (PopScope
/// blocks pop); the only action is to open the store.
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
                  'Update required',
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
                      : 'This version of Lazervault is no longer supported. '
                          'Please update to the latest version to keep using the '
                          'app securely.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: textSecondary,
                    fontSize: 15,
                    height: 1.5,
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
                    'Update now',
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
