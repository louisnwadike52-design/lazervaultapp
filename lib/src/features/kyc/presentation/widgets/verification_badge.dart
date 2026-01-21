import 'package:flutter/material.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';

/// Verification badge widget that displays user's KYC tier and status
class VerificationBadge extends StatelessWidget {
  final KYCTier tier;
  final KYCStatus status;
  final bool showLabel;
  final double? size;
  final VoidCallback? onTap;

  const VerificationBadge({
    super.key,
    required this.tier,
    required this.status,
    this.showLabel = true,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getStatusColor(theme);

    Widget badge = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Center(
        child: _buildIcon(color),
      ),
    );

    if (onTap != null) {
      badge = GestureDetector(
        onTap: onTap,
        child: badge,
      );
    }

    if (!showLabel) {
      return badge;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        badge,
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getTierLabel(),
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              _getStatusLabel(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIcon(Color color) {
    if (status == KYCStatus.approved) {
      return Icon(
        _getTierIcon(),
        color: color,
        size: (size ?? 24) * 0.5,
      );
    } else if (status == KYCStatus.inProgress ||
        status == KYCStatus.pendingReview) {
      return SizedBox(
        width: (size ?? 24) * 0.4,
        height: (size ?? 24) * 0.4,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );
    } else if (status == KYCStatus.rejected) {
      return Icon(
        Icons.close,
        color: color,
        size: (size ?? 24) * 0.5,
      );
    }
    return Icon(
      Icons.help_outline,
      color: color,
      size: (size ?? 24) * 0.5,
    );
  }

  IconData _getTierIcon() {
    switch (tier) {
      case KYCTier.tier1:
        return Icons.verified_user;
      case KYCTier.tier2:
        return Icons.verified;
      case KYCTier.tier3:
        return Icons.workspace_premium;
      default:
        return Icons.person_outline;
    }
  }

  Color _getStatusColor(ThemeData theme) {
    switch (status) {
      case KYCStatus.approved:
        return const Color(0xFF4CAF50); // Green
      case KYCStatus.inProgress:
      case KYCStatus.pendingReview:
        return const Color(0xFFFF9800); // Orange
      case KYCStatus.rejected:
        return const Color(0xFFF44336); // Red
      case KYCStatus.expired:
        return const Color(0xFFE91E63); // Pink
      default:
        return const Color(0xFF9E9E9E); // Grey
    }
  }

  String _getTierLabel() {
    switch (tier) {
      case KYCTier.tier1:
        return 'Basic';
      case KYCTier.tier2:
        return 'Verified';
      case KYCTier.tier3:
        return 'Premium';
      default:
        return 'Unverified';
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case KYCStatus.notStarted:
        return 'Not verified';
      case KYCStatus.inProgress:
        return 'Verification in progress';
      case KYCStatus.pendingReview:
        return 'Pending review';
      case KYCStatus.approved:
        return 'Verified';
      case KYCStatus.rejected:
        return 'Verification failed';
      case KYCStatus.expired:
        return 'Verification expired';
      default:
        return '';
    }
  }
}

/// Small verification badge for use in lists
class VerificationBadgeSmall extends StatelessWidget {
  final KYCTier tier;
  final KYCStatus status;
  final VoidCallback? onTap;

  const VerificationBadgeSmall({
    super.key,
    required this.tier,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return VerificationBadge(
      tier: tier,
      status: status,
      size: 32,
      showLabel: true,
      onTap: onTap,
    );
  }
}

/// Compact verification badge icon only
class VerificationBadgeIcon extends StatelessWidget {
  final KYCTier tier;
  final KYCStatus status;
  final double? size;
  final VoidCallback? onTap;

  const VerificationBadgeIcon({
    super.key,
    required this.tier,
    required this.status,
    this.size,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return VerificationBadge(
      tier: tier,
      status: status,
      size: size ?? 24,
      showLabel: false,
      onTap: onTap,
    );
  }
}

/// Tier progress indicator showing KYC journey
class TierProgressIndicator extends StatelessWidget {
  final KYCTier currentTier;
  final VoidCallback? onTierTap;

  const TierProgressIndicator({
    super.key,
    required this.currentTier,
    this.onTierTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification Level',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildTier(
            context,
            title: 'Tier 1',
            subtitle: 'Basic Account',
            description: 'Send up to ₦50,000/day',
            icon: Icons.person_outline,
            isActive: currentTier.index >= KYCTier.tier1.index,
            isCompleted: currentTier.index > KYCTier.tier1.index,
          ),
          _buildDivider(),
          _buildTier(
            context,
            title: 'Tier 2',
            subtitle: 'Verified',
            description: 'Send up to ₦500,000/day',
            icon: Icons.verified_user,
            isActive: currentTier.index >= KYCTier.tier2.index,
            isCompleted: currentTier.index > KYCTier.tier2.index,
          ),
          _buildDivider(),
          _buildTier(
            context,
            title: 'Tier 3',
            subtitle: 'Premium',
            description: 'Unlimited transactions',
            icon: Icons.workspace_premium,
            isActive: currentTier.index >= KYCTier.tier3.index,
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Container(
        height: 20,
        width: 2,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildTier(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required bool isActive,
    required bool isCompleted,
  }) {
    final theme = Theme.of(context);
    final color = isActive
        ? (isCompleted
            ? const Color(0xFF4CAF50)
            : const Color(0xFF2196F3))
        : const Color(0xFF9E9E9E);

    return InkWell(
      onTap: isActive ? onTierTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.15),
              ),
              child: Icon(
                isCompleted ? Icons.check : icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: color.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF4CAF50),
                size: 24,
              )
            else if (isActive)
              Icon(
                Icons.chevron_right,
                color: theme.dividerColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
