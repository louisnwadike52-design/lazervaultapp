import 'package:flutter/material.dart';
import '../../domain/entities/social_account_entity.dart';

/// Card widget for displaying a linked social account
class SocialAccountCard extends StatelessWidget {
  final LinkedSocialAccountEntity account;
  final VoidCallback? onTap;
  final VoidCallback? onUnlink;
  final VoidCallback? onSetPrimary;
  final VoidCallback? onReauthorize;

  const SocialAccountCard({
    super.key,
    required this.account,
    this.onTap,
    this.onUnlink,
    this.onSetPrimary,
    this.onReauthorize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildProviderIcon(),
                const SizedBox(width: 16),
                Expanded(child: _buildAccountInfo()),
                _buildActions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProviderIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Color(account.provider.brandColorValue).withValues(alpha:0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: _getProviderIcon(),
      ),
    );
  }

  Widget _getProviderIcon() {
    IconData iconData;
    switch (account.provider) {
      case SocialProvider.google:
        iconData = Icons.g_mobiledata;
        break;
      case SocialProvider.facebook:
        iconData = Icons.facebook;
        break;
      case SocialProvider.apple:
        iconData = Icons.apple;
        break;
      case SocialProvider.x:
        iconData = Icons.alternate_email;
        break;
      case SocialProvider.linkedin:
        iconData = Icons.work;
        break;
      case SocialProvider.instagram:
        iconData = Icons.camera_alt;
        break;
    }

    return Icon(
      iconData,
      color: Color(account.provider.brandColorValue),
      size: 28,
    );
  }

  Widget _buildAccountInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              account.displayTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (account.isPrimary) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Primary',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          account.displaySubtitle,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
    Color statusColor;
    String statusText = account.status.displayName;

    switch (account.status) {
      case SocialAccountStatus.active:
        statusColor = const Color(0xFF10B981);
        break;
      case SocialAccountStatus.needsReauth:
        statusColor = const Color(0xFFFB923C);
        break;
      case SocialAccountStatus.inactive:
      case SocialAccountStatus.unlinked:
        statusColor = const Color(0xFFEF4444);
        break;
    }

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          statusText,
          style: TextStyle(
            color: statusColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: Color(0xFF9CA3AF),
      ),
      color: const Color(0xFF2D2D2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onSelected: (value) {
        switch (value) {
          case 'primary':
            onSetPrimary?.call();
            break;
          case 'reauthorize':
            onReauthorize?.call();
            break;
          case 'unlink':
            _showUnlinkConfirmation(context);
            break;
        }
      },
      itemBuilder: (context) => [
        if (!account.isPrimary)
          const PopupMenuItem(
            value: 'primary',
            child: Row(
              children: [
                Icon(Icons.star, color: Color(0xFF3B82F6), size: 20),
                SizedBox(width: 12),
                Text(
                  'Set as Primary',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        if (account.needsReauthorization)
          const PopupMenuItem(
            value: 'reauthorize',
            child: Row(
              children: [
                Icon(Icons.refresh, color: Color(0xFFFB923C), size: 20),
                SizedBox(width: 12),
                Text(
                  'Reconnect',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        const PopupMenuItem(
          value: 'unlink',
          child: Row(
            children: [
              Icon(Icons.link_off, color: Color(0xFFEF4444), size: 20),
              SizedBox(width: 12),
              Text(
                'Unlink',
                style: TextStyle(color: Color(0xFFEF4444)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showUnlinkConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Unlink Account?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to unlink your ${account.provider.displayName} account?',
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onUnlink?.call();
            },
            child: const Text(
              'Unlink',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget for showing available providers to link
class LinkProviderCard extends StatelessWidget {
  final SocialProvider provider;
  final bool isLinked;
  final VoidCallback? onTap;

  const LinkProviderCard({
    super.key,
    required this.provider,
    this.isLinked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isLinked ? const Color(0xFF1F1F1F) : const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLinked ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(provider.brandColorValue).withValues(alpha:0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _getProviderIcon(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isLinked ? 'Already connected' : 'Tap to connect',
                        style: TextStyle(
                          color: isLinked
                              ? const Color(0xFF10B981)
                              : const Color(0xFF9CA3AF),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLinked)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF10B981),
                    size: 24,
                  )
                else
                  const Icon(
                    Icons.add_circle_outline,
                    color: Color(0xFF3B82F6),
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProviderIcon() {
    IconData iconData;
    switch (provider) {
      case SocialProvider.google:
        iconData = Icons.g_mobiledata;
        break;
      case SocialProvider.facebook:
        iconData = Icons.facebook;
        break;
      case SocialProvider.apple:
        iconData = Icons.apple;
        break;
      case SocialProvider.x:
        iconData = Icons.alternate_email;
        break;
      case SocialProvider.linkedin:
        iconData = Icons.work;
        break;
      case SocialProvider.instagram:
        iconData = Icons.camera_alt;
        break;
    }

    return Icon(
      iconData,
      color: Color(provider.brandColorValue),
      size: 28,
    );
  }
}
