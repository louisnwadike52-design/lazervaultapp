import 'package:flutter/material.dart';

import 'package:lazervault/core/services/app_update_service.dart';

/// One-time bottom-sheet modal for an OPTIONAL update. Shown once per new
/// latest build. "Update now" opens the store; "Later" dismisses.
Future<void> showUpdateModal(
  BuildContext context, {
  required AppUpdateInfo info,
  required Future<void> Function() onUpdate,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _UpdateModalContent(info: info, onUpdate: onUpdate),
  );
}

class _UpdateModalContent extends StatelessWidget {
  final AppUpdateInfo info;
  final Future<void> Function() onUpdate;

  const _UpdateModalContent({required this.info, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    const Color cardBackground = Color(0xFF1F1F1F);
    const Color textPrimary = Colors.white;
    const Color textSecondary = Color(0xFF9CA3AF);
    const Color primary = Color(0xFF3B82F6);

    final title = info.latestVersion.isNotEmpty
        ? 'Update to ${info.latestVersion}'
        : 'Update available';

    return Container(
      decoration: const BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        24 + MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.system_update, color: primary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            info.notes.isNotEmpty
                ? info.notes
                : 'A new version of Lazervault is available with the latest '
                    'improvements and fixes. Update now for the best experience.',
            style: const TextStyle(
              color: textSecondary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await onUpdate();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Update now',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Later',
              style: TextStyle(color: textSecondary, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
