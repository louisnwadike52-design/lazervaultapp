import 'package:flutter/material.dart';

/// Shows a bottom sheet dialog for BVN name reconciliation
/// when the BVN-verified name doesn't closely match the profile name (50-80% match)
Future<String?> showDataReconciliationDialog(
  BuildContext context, {
  required String verifiedName,
  required String profileName,
  required double matchScore,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF1F1F1F),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => _ReconciliationContent(
      verifiedName: verifiedName,
      profileName: profileName,
      matchScore: matchScore,
    ),
  );
}

class _ReconciliationContent extends StatelessWidget {
  final String verifiedName;
  final String profileName;
  final double matchScore;

  const _ReconciliationContent({
    required this.verifiedName,
    required this.profileName,
    required this.matchScore,
  });

  @override
  Widget build(BuildContext context) {
    final matchPercent = (matchScore * 100).round();

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_search,
                  color: Color(0xFFFB923C),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Verify Your Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Your BVN name differs from your profile. Please choose which name to use.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // BVN verified name (prominent)
          _NameCard(
            label: 'Name on BVN',
            name: verifiedName,
            icon: Icons.verified,
            iconColor: const Color(0xFF10B981),
            isRecommended: true,
          ),
          const SizedBox(height: 12),

          // Profile name
          _NameCard(
            label: 'Your profile name',
            name: profileName,
            icon: Icons.person,
            iconColor: const Color(0xFF9CA3AF),
            isRecommended: false,
          ),
          const SizedBox(height: 16),

          // Match score indicator
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: matchScore,
                    backgroundColor: const Color(0xFF2D2D2D),
                    color: matchScore >= 0.7
                        ? const Color(0xFFFB923C)
                        : const Color(0xFFEF4444),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$matchPercent% match',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Explanation
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your BVN name is verified by your bank. Using it ensures seamless transactions.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Primary button: Use BVN name
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop('use_bvn_name'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Update to BVN Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Secondary button: Keep profile name
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop('keep_profile_name'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Keep My Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameCard extends StatelessWidget {
  final String label;
  final String name;
  final IconData icon;
  final Color iconColor;
  final bool isRecommended;

  const _NameCard({
    required this.label,
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.isRecommended,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRecommended
            ? const Color(0xFF10B981).withValues(alpha: 0.08)
            : const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRecommended
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                    if (isRecommended) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'RECOMMENDED',
                          style: TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
