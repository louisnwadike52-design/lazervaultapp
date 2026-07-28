import 'package:flutter/material.dart';

import 'package:lazervault/core/services/app_update_service.dart';

/// A slim, dismissible "update available" banner pinned at the top of the
/// dashboard for OPTIONAL updates. Tapping "Update" opens the store; the X
/// hides it for the rest of the session.
class UpdateBanner extends StatelessWidget {
  final AppUpdateInfo info;
  final VoidCallback onUpdate;
  final VoidCallback onDismiss;

  const UpdateBanner({
    super.key,
    required this.info,
    required this.onUpdate,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF3B82F6);
    final version = info.latestVersion.isNotEmpty
        ? 'Version ${info.latestVersion} is available'
        : 'A new version is available';

    return Material(
      color: primary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              const Icon(Icons.system_update, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  version,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onUpdate,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: primary,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                onPressed: onDismiss,
                icon: const Icon(Icons.close, color: Colors.white, size: 18),
                tooltip: 'Dismiss',
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
