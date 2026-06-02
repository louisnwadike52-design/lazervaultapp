import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_prediction_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_prediction_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/transfer_success_prediction.dart';

// Dark theme palette (per CLAUDE.md).
const Color _cardBackground = Color(0xFF1F1F1F);
const Color _divider = Color(0xFF2D2D2D);
const Color _textPrimary = Colors.white;
const Color _textSecondary = Color(0xFF9CA3AF);
const Color _success = Color(0xFF10B981);
const Color _warning = Color(0xFFFB923C);
const Color _error = Color(0xFFEF4444);

/// Informational, READ-ONLY alert showing transfer success signals (bank
/// network availability + recipient trust) for an EXTERNAL transfer. Rendered
/// BEFORE the PIN/confirm action. Never blocks or alters the transfer.
///
/// Drive it with a [TransferPredictionCubit] (resolved from GetIt serviceLocator
/// by the host screen) — this widget only presents the cubit's current state.
class TransferPredictionAlert extends StatelessWidget {
  /// Optional outer margin so the host screen controls spacing.
  final EdgeInsetsGeometry margin;

  const TransferPredictionAlert({
    super.key,
    this.margin = const EdgeInsets.only(top: 12, bottom: 4),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransferPredictionCubit, TransferPredictionState>(
      builder: (context, state) {
        return switch (state) {
          TransferPredictionLoaded(prediction: final p) =>
            _PredictionCard(prediction: p, margin: margin),
          TransferPredictionUnavailable() =>
            _NeutralCard(margin: margin),
          // Initial + Loading: render nothing (non-blocking, no spinner noise).
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

class _PredictionCard extends StatelessWidget {
  final TransferSuccessPrediction prediction;
  final EdgeInsetsGeometry margin;

  const _PredictionCard({required this.prediction, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bankRow(),
          if (prediction.bankBand != 'unknown' &&
              prediction.recipientTrustBand != 'unknown')
            const SizedBox(height: 10),
          _recipientRow(),
        ],
      ),
    );
  }

  Widget _bankRow() {
    if (prediction.bankBand == 'unknown') return const SizedBox.shrink();

    final (label, color) = switch (prediction.bankBand) {
      'good' => ('Good', _success),
      'fair' => ('Fair', _warning),
      'poor' => ('Poor', _error),
      _ => ('Unknown', _textSecondary),
    };

    final icon = switch (prediction.bankBand) {
      'good' => Icons.check_circle_outline,
      'fair' => Icons.info_outline,
      'poor' => Icons.warning_amber_rounded,
      _ => Icons.help_outline,
    };

    return _Line(
      icon: icon,
      color: color,
      title: 'Bank network',
      value: '$label (${prediction.bankAvailabilityPct}%)',
      valueColor: color,
    );
  }

  Widget _recipientRow() {
    // blocklist takes precedence — strongest signal.
    if (prediction.blocklisted) {
      return const _Line(
        icon: Icons.block,
        color: _error,
        title: 'Recipient',
        value: 'Caution: flagged account',
        valueColor: _error,
      );
    }

    if (prediction.recipientTrustBand == 'unknown') {
      return const SizedBox.shrink();
    }

    final (icon, color, value) = switch (prediction.recipientTrustBand) {
      'verified' => (
          Icons.verified_user_outlined,
          _success,
          'Verified recipient',
        ),
      'new' => (
          Icons.person_outline,
          _textSecondary,
          'New recipient',
        ),
      'caution' => (
          Icons.warning_amber_rounded,
          _warning,
          'Caution: first time / flagged',
        ),
      _ => (Icons.help_outline, _textSecondary, 'Recipient unknown'),
    };

    return _Line(
      icon: icon,
      color: color,
      title: 'Recipient',
      value: value,
      valueColor: color,
    );
  }
}

/// Cold-start / no data / fetch error: never an error, never blocking.
class _NeutralCard extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  const _NeutralCard({required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider),
      ),
      child: const _Line(
        icon: Icons.info_outline,
        color: _textSecondary,
        title: 'Bank network',
        value: 'Status unavailable',
        valueColor: _textSecondary,
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;
  final Color valueColor;

  const _Line({
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: _textSecondary,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor == _textSecondary ? _textPrimary : valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
