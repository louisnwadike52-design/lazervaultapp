import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Final card with share options
class WrappedShareCard extends StatelessWidget {
  final FinancialWrapped wrapped;
  final VoidCallback? onShare;
  final VoidCallback? onReplay;
  final VoidCallback? onClose;

  const WrappedShareCard({
    super.key,
    required this.wrapped,
    this.onShare,
    this.onReplay,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.share,
      showLogo: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Success icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667eea).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.celebration,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            'That\'s Your ${wrapped.year} Wrapped!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Summary text
          Text(
            'You spent \$${wrapped.summary?.totalSpent.toStringAsFixed(0) ?? '0'}, saved \$${wrapped.summary?.totalSaved.toStringAsFixed(0) ?? '0'}, and made ${wrapped.summary?.transactionCount ?? 0} transactions.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          // Share button
          _ActionButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              onShare?.call();
            },
            icon: Icons.share,
            label: 'Share Your Wrapped',
            isPrimary: true,
          ),
          const SizedBox(height: 12),
          // Replay button
          _ActionButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              onReplay?.call();
            },
            icon: Icons.replay,
            label: 'Watch Again',
            isPrimary: false,
          ),
          const SizedBox(height: 12),
          // Close button
          _ActionButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              onClose?.call();
            },
            icon: Icons.close,
            label: 'Close',
            isPrimary: false,
          ),
          const Spacer(),
          // Footer
          Text(
            'Thank you for using LazerVault!',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final bool isPrimary;

  const _ActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF667eea),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
