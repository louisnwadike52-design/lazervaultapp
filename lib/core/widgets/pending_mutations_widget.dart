import 'dart:async';
import 'package:flutter/material.dart';
import '../offline/mutation.dart';
import '../offline/mutation_queue.dart';

/// Widget that displays pending mutations (offline queued operations).
///
/// Shows a banner or card indicating operations that are queued for
/// retry when the device comes back online. Users can cancel queued
/// operations from this widget.
///
/// Usage:
/// ```dart
/// PendingMutationsWidget(
///   mutationQueue: serviceLocator<MutationQueue>(),
///   filterTypes: [MutationType.tagPayment, MutationType.tagCreation],
/// )
/// ```
class PendingMutationsWidget extends StatefulWidget {
  /// The mutation queue to display.
  final MutationQueue mutationQueue;

  /// Optional filter to only show specific mutation types.
  /// If null, all mutations are shown.
  final List<MutationType>? filterTypes;

  /// Called when a mutation is cancelled.
  final void Function(QueuedMutation mutation)? onMutationCancelled;

  /// Whether to show as a compact banner (true) or expanded list (false).
  final bool compact;

  /// Whether to show the processing spinner.
  final bool showProcessingIndicator;

  const PendingMutationsWidget({
    super.key,
    required this.mutationQueue,
    this.filterTypes,
    this.onMutationCancelled,
    this.compact = true,
    this.showProcessingIndicator = true,
  });

  @override
  State<PendingMutationsWidget> createState() => _PendingMutationsWidgetState();
}

class _PendingMutationsWidgetState extends State<PendingMutationsWidget> {
  List<QueuedMutation> _mutations = [];
  StreamSubscription<MutationStatusEvent>? _statusSubscription;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadMutations();
    _statusSubscription = widget.mutationQueue.statusStream.listen((event) {
      _loadMutations();
      setState(() {
        _isProcessing = event.status == MutationStatus.processing;
      });
    });
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    super.dispose();
  }

  void _loadMutations() {
    final all = widget.mutationQueue.getPendingMutations();
    setState(() {
      if (widget.filterTypes != null) {
        _mutations = all
            .where((m) => widget.filterTypes!.contains(m.type))
            .toList();
      } else {
        _mutations = all;
      }
    });
  }

  Future<void> _cancelMutation(QueuedMutation mutation) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Cancel Queued Operation?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'This ${_getMutationDescription(mutation)} will not be processed when you come back online.',
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFEF4444)),
            child: const Text('Cancel Operation'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await widget.mutationQueue.cancel(mutation.id);
      widget.onMutationCancelled?.call(mutation);
      _loadMutations();
    }
  }

  String _getMutationDescription(QueuedMutation mutation) {
    switch (mutation.type) {
      case MutationType.tagPayment:
        return 'tag payment';
      case MutationType.tagCreation:
        final amount = mutation.payload['amount'];
        final currency = mutation.payload['currency'] ?? '';
        return 'tag creation ($currency ${amount?.toStringAsFixed(2) ?? '?'})';
      case MutationType.invoicePayment:
        return 'invoice payment';
      case MutationType.transfer:
        return 'money transfer';
      case MutationType.groupContribution:
        return 'group contribution';
      case MutationType.invoiceCreation:
        return 'invoice creation';
      case MutationType.generic:
        return 'operation';
    }
  }

  String _getMutationIcon(MutationType type) {
    switch (type) {
      case MutationType.tagPayment:
        return '🏷️';
      case MutationType.tagCreation:
        return '📝';
      case MutationType.invoicePayment:
        return '📄';
      case MutationType.transfer:
        return '💸';
      case MutationType.groupContribution:
        return '👥';
      case MutationType.invoiceCreation:
        return '📋';
      case MutationType.generic:
        return '📌';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_mutations.isEmpty) {
      return const SizedBox.shrink();
    }

    if (widget.compact) {
      return _buildCompactBanner();
    } else {
      return _buildExpandedList();
    }
  }

  Widget _buildCompactBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _isProcessing && widget.showProcessingIndicator
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFB923C)),
                    ),
                  )
                : const Icon(
                    Icons.cloud_off,
                    color: Color(0xFFFB923C),
                    size: 16,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isProcessing ? 'Processing...' : '${_mutations.length} pending operation${_mutations.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isProcessing
                      ? 'Syncing queued operations'
                      : 'Will retry when you\'re back online',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.expand_more, color: Color(0xFF9CA3AF)),
            onPressed: () => _showMutationsSheet(context),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _mutations.map((mutation) => _buildMutationTile(mutation)).toList(),
    );
  }

  Widget _buildMutationTile(QueuedMutation mutation) {
    final isProcessing = mutation.status == MutationStatus.processing;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isProcessing
              ? const Color(0xFF3B82F6).withValues(alpha: 0.5)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Row(
        children: [
          Text(
            _getMutationIcon(mutation.type),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getMutationDescription(mutation),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isProcessing
                      ? 'Processing...'
                      : mutation.retryCount > 0
                          ? 'Retry ${mutation.retryCount}/3'
                          : 'Queued',
                  style: TextStyle(
                    color: isProcessing
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (isProcessing && widget.showProcessingIndicator)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: Color(0xFF9CA3AF)),
              onPressed: () => _cancelMutation(mutation),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
        ],
      ),
    );
  }

  void _showMutationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pending Operations',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF9CA3AF)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'These operations will be processed when you\'re back online.',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _mutations.length,
                    itemBuilder: (context, index) {
                      return _buildMutationTile(_mutations[index]);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A small indicator badge showing the count of pending mutations.
///
/// Use this in app bars or navigation items to indicate offline operations.
class PendingMutationsBadge extends StatefulWidget {
  final MutationQueue mutationQueue;
  final List<MutationType>? filterTypes;
  final Widget child;

  const PendingMutationsBadge({
    super.key,
    required this.mutationQueue,
    required this.child,
    this.filterTypes,
  });

  @override
  State<PendingMutationsBadge> createState() => _PendingMutationsBadgeState();
}

class _PendingMutationsBadgeState extends State<PendingMutationsBadge> {
  int _count = 0;
  StreamSubscription<MutationStatusEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _updateCount();
    _subscription = widget.mutationQueue.statusStream.listen((_) => _updateCount());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _updateCount() {
    final mutations = widget.mutationQueue.getPendingMutations();
    setState(() {
      if (widget.filterTypes != null) {
        _count = mutations.where((m) => widget.filterTypes!.contains(m.type)).length;
      } else {
        _count = mutations.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_count == 0) {
      return widget.child;
    }

    return Badge(
      label: Text(_count.toString()),
      backgroundColor: const Color(0xFFFB923C),
      child: widget.child,
    );
  }
}
