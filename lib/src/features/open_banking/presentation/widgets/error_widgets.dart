/// Error display widgets for different banking error types
library;

import 'dart:async';
import 'package:flutter/material.dart';
import '../../cubit/open_banking_state.dart';


/// Widget that displays banking errors with appropriate UI and actions
class BankingErrorWidget extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final VoidCallback? onContactSupport;
  final VoidCallback? onLogin;

  const BankingErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.onDismiss,
    this.onContactSupport,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return switch (error.errorType) {
      BankingErrorType.network => _NetworkErrorContent(
          error: error,
          onRetry: onRetry,
        ),
      BankingErrorType.serviceUnavailable => _ServiceUnavailableContent(
          error: error,
          onRetry: onRetry,
        ),
      BankingErrorType.insufficientFunds => _InsufficientFundsContent(
          error: error,
          onDismiss: onDismiss,
        ),
      BankingErrorType.limitExceeded => _LimitExceededContent(
          error: error,
          onDismiss: onDismiss,
        ),
      BankingErrorType.accountIssue => _AccountIssueContent(
          error: error,
          onContactSupport: onContactSupport,
          onDismiss: onDismiss,
        ),
      BankingErrorType.unauthorized => _UnauthorizedContent(
          error: error,
          onLogin: onLogin,
        ),
      BankingErrorType.needsMandate => _GeneralErrorContent(
          error: error,
          onRetry: null,
          onDismiss: onDismiss,
        ),
      BankingErrorType.general => _GeneralErrorContent(
          error: error,
          onRetry: error.isRetryable ? onRetry : null,
          onDismiss: onDismiss,
        ),
    };
  }
}

/// Network error content with retry option
class _NetworkErrorContent extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onRetry;

  const _NetworkErrorContent({
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return _ErrorCard(
      icon: Icons.wifi_off,
      iconColor: Colors.orange,
      title: 'Connection Issue',
      message: error.message,
      primaryAction: onRetry != null
          ? _ErrorAction(
              label: 'Try Again',
              icon: Icons.refresh,
              onPressed: onRetry!,
              isPrimary: true,
            )
          : null,
    );
  }
}

/// Service unavailable content with countdown timer
class _ServiceUnavailableContent extends StatefulWidget {
  final OpenBankingError error;
  final VoidCallback? onRetry;

  const _ServiceUnavailableContent({
    required this.error,
    this.onRetry,
  });

  @override
  State<_ServiceUnavailableContent> createState() =>
      _ServiceUnavailableContentState();
}

class _ServiceUnavailableContentState
    extends State<_ServiceUnavailableContent> {
  Timer? _timer;
  Duration? _remaining;

  @override
  void initState() {
    super.initState();
    if (widget.error.retryAfter != null) {
      _remaining = widget.error.retryAfter;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining != null && _remaining!.inSeconds > 0) {
        setState(() {
          _remaining = _remaining! - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        setState(() {
          _remaining = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canRetry = _remaining == null || _remaining!.inSeconds <= 0;

    return _ErrorCard(
      icon: Icons.cloud_off,
      iconColor: Colors.red,
      title: 'Service Temporarily Unavailable',
      message: widget.error.message,
      subtitle: _remaining != null && _remaining!.inSeconds > 0
          ? 'Retry available in ${_remaining!.inSeconds} seconds'
          : null,
      primaryAction: widget.onRetry != null && canRetry
          ? _ErrorAction(
              label: 'Try Again',
              icon: Icons.refresh,
              onPressed: widget.onRetry!,
              isPrimary: true,
            )
          : null,
    );
  }
}

/// Insufficient funds content with balance info
class _InsufficientFundsContent extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onDismiss;

  const _InsufficientFundsContent({
    required this.error,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    String? balanceInfo;
    if (error.details != null) {
      final available = error.details!['available_balance'] as int?;
      final currency = error.details!['currency'] as String? ?? 'NGN';
      if (available != null) {
        balanceInfo = 'Available: $currency${(available / 100).toStringAsFixed(2)}';
      }
    }

    return _ErrorCard(
      icon: Icons.account_balance_wallet,
      iconColor: Colors.amber,
      title: 'Insufficient Funds',
      message: error.message,
      subtitle: balanceInfo,
      primaryAction: onDismiss != null
          ? _ErrorAction(
              label: 'Got It',
              onPressed: onDismiss!,
              isPrimary: true,
            )
          : null,
    );
  }
}

/// Limit exceeded content with limit info
class _LimitExceededContent extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onDismiss;

  const _LimitExceededContent({
    required this.error,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    String? limitInfo;
    if (error.details != null) {
      final limitType = error.details!['limit_type'] as String?;
      final limit = error.details!['limit'] as int?;
      final currency = error.details!['currency'] as String? ?? 'NGN';
      if (limit != null && limitType != null) {
        limitInfo = '${limitType.toUpperCase()} limit: $currency${(limit / 100).toStringAsFixed(2)}';
      }
    }

    return _ErrorCard(
      icon: Icons.block,
      iconColor: Colors.orange,
      title: 'Limit Exceeded',
      message: error.message,
      subtitle: limitInfo,
      primaryAction: onDismiss != null
          ? _ErrorAction(
              label: 'Got It',
              onPressed: onDismiss!,
              isPrimary: true,
            )
          : null,
    );
  }
}

/// Account issue content with support option
class _AccountIssueContent extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onContactSupport;
  final VoidCallback? onDismiss;

  const _AccountIssueContent({
    required this.error,
    this.onContactSupport,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return _ErrorCard(
      icon: Icons.warning_amber,
      iconColor: Colors.red,
      title: 'Account Issue',
      message: error.message,
      primaryAction: onContactSupport != null
          ? _ErrorAction(
              label: 'Contact Support',
              icon: Icons.support_agent,
              onPressed: onContactSupport!,
              isPrimary: true,
            )
          : null,
      secondaryAction: onDismiss != null
          ? _ErrorAction(
              label: 'Dismiss',
              onPressed: onDismiss!,
            )
          : null,
    );
  }
}

/// Unauthorized content with login option
class _UnauthorizedContent extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onLogin;

  const _UnauthorizedContent({
    required this.error,
    this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return _ErrorCard(
      icon: Icons.lock_outline,
      iconColor: Colors.blue,
      title: 'Session Expired',
      message: error.message,
      primaryAction: onLogin != null
          ? _ErrorAction(
              label: 'Log In Again',
              icon: Icons.login,
              onPressed: onLogin!,
              isPrimary: true,
            )
          : null,
    );
  }
}

/// General error content
class _GeneralErrorContent extends StatelessWidget {
  final OpenBankingError error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  const _GeneralErrorContent({
    required this.error,
    this.onRetry,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return _ErrorCard(
      icon: Icons.error_outline,
      iconColor: Colors.red,
      title: 'Something Went Wrong',
      message: error.message,
      primaryAction: onRetry != null
          ? _ErrorAction(
              label: 'Try Again',
              icon: Icons.refresh,
              onPressed: onRetry!,
              isPrimary: true,
            )
          : onDismiss != null
              ? _ErrorAction(
                  label: 'Dismiss',
                  onPressed: onDismiss!,
                  isPrimary: true,
                )
              : null,
    );
  }
}

/// Base error card widget
class _ErrorCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String? subtitle;
  final _ErrorAction? primaryAction;
  final _ErrorAction? secondaryAction;

  const _ErrorCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (primaryAction != null || secondaryAction != null) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (secondaryAction != null) ...[
                    TextButton(
                      onPressed: secondaryAction!.onPressed,
                      child: Text(secondaryAction!.label),
                    ),
                    const SizedBox(width: 16),
                  ],
                  if (primaryAction != null)
                    primaryAction!.isPrimary
                        ? FilledButton.icon(
                            onPressed: primaryAction!.onPressed,
                            icon: primaryAction!.icon != null
                                ? Icon(primaryAction!.icon)
                                : const SizedBox.shrink(),
                            label: Text(primaryAction!.label),
                          )
                        : TextButton(
                            onPressed: primaryAction!.onPressed,
                            child: Text(primaryAction!.label),
                          ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error action button configuration
class _ErrorAction {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _ErrorAction({
    required this.label,
    this.icon,
    required this.onPressed,
    this.isPrimary = false,
  });
}

/// Inline error banner for less intrusive errors
class BankingErrorBanner extends StatelessWidget {
  final String message;
  final bool isRetryable;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  const BankingErrorBanner({
    super.key,
    required this.message,
    this.isRetryable = false,
    this.onRetry,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      content: Text(message),
      leading: const Icon(Icons.error_outline, color: Colors.red),
      backgroundColor: Colors.red.shade50,
      actions: [
        if (isRetryable && onRetry != null)
          TextButton(
            onPressed: onRetry,
            child: const Text('RETRY'),
          ),
        if (onDismiss != null)
          TextButton(
            onPressed: onDismiss,
            child: const Text('DISMISS'),
          ),
      ],
    );
  }
}

/// Offline indicator widget
class OfflineIndicator extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineIndicator({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade800,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.wifi_off, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'No internet connection',
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: const Text(
                'RETRY',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

/// Retrying indicator widget
class RetryingIndicator extends StatelessWidget {
  final int attempt;
  final int maxAttempts;
  final String? operation;

  const RetryingIndicator({
    super.key,
    required this.attempt,
    required this.maxAttempts,
    this.operation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.amber.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              operation != null
                  ? 'Retrying $operation... (attempt $attempt of $maxAttempts)'
                  : 'Retrying... (attempt $attempt of $maxAttempts)',
              style: TextStyle(color: Colors.amber.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
