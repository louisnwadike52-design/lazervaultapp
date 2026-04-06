import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';

/// Admin Dashboard Screen for Gift Card Sell Provider Management
/// Allows administrators to toggle between manual and Prestmit automated selling
///
/// Features:
/// - View current provider status
/// - Toggle provider with confirmation
/// - View provider description
/// - Audit log of changes
class GiftCardSellProviderAdminScreen extends StatefulWidget {
  const GiftCardSellProviderAdminScreen({Key? key}) : super(key: key);

  @override
  State<GiftCardSellProviderAdminScreen> createState() => _GiftCardSellProviderAdminScreenState();
}

class _GiftCardSellProviderAdminScreenState extends State<GiftCardSellProviderAdminScreen> {
  String? _currentProvider;
  String? _currentDescription;
  bool _isLoading = true;
  bool _isToggling = false;
  String? _errorMessage;
  String? _successMessage;

  // Audit log (in production, this would come from backend)
  final List<_ProviderChangeLog> _auditLog = [];

  @override
  void initState() {
    super.initState();
    _loadProviderStatus();
  }

  Future<void> _loadProviderStatus() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final cubit = context.read<GiftCardCubit>();
      await cubit.getSellProvider();
      // State will be updated via BlocBuilder
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load provider status: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleProvider(String newProvider) async {
    // Show confirmation dialog
    final confirmed = await _showToggleConfirmationDialog(newProvider);
    if (!confirmed) return;

    setState(() {
      _isToggling = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // In production, this would call the admin API
      // For now, we'll simulate the toggle
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _currentProvider = newProvider;
        _currentDescription = newProvider == 'prestmit'
            ? 'Automated processing via Prestmit API'
            : 'Manual review by admin';
        _isToggling = false;

        // Add to audit log
        _auditLog.add(_ProviderChangeLog(
          timestamp: DateTime.now(),
          from: _currentProvider ?? 'manual',
          to: newProvider,
          admin: 'Admin User',
        ));

        _successMessage = 'Provider updated to $newProvider';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Provider updated to $newProvider'),
          backgroundColor: const Color(0xFF10B981),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to toggle provider: $e';
        _isToggling = false;
      });
    }
  }

  Future<bool> _showToggleConfirmationDialog(String newProvider) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Confirm Provider Change',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You are about to change the gift card sell provider.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            _buildProviderInfo('Current', _currentProvider ?? 'manual'),
            const SizedBox(height: 12),
            const Icon(Icons.arrow_downward, color: Color(0xFF9CA3AF)),
            const SizedBox(height: 12),
            _buildProviderInfo('New', newProvider),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: newProvider == 'prestmit'
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                    : const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: newProvider == 'prestmit'
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF10B981),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    newProvider == 'prestmit' ? Icons.info_outline : Icons.check_circle_outline,
                    color: newProvider == 'prestmit'
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF10B981),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      newProvider == 'prestmit'
                          ? 'Prestmit mode will automatically process gift cards via API. This usually takes 5-15 minutes.'
                          : 'Manual mode requires admin approval for each gift card sale.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: newProvider == 'prestmit'
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF10B981),
            ),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Widget _buildProviderInfo(String label, String provider) {
    final isPrestmit = provider == 'prestmit';
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isPrestmit
                ? const Color(0xFF3B82F6)
                : const Color(0xFF10B981),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPrestmit ? Icons.flash_on : Icons.person,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                provider.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Card Sell Provider'),
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadProviderStatus,
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<GiftCardCubit, GiftCardState>(
        listener: (context, state) {
          if (state is SellProviderLoaded) {
            setState(() {
              _currentProvider = state.provider;
              _currentDescription = state.description;
              _isLoading = false;
            });
          } else if (state is SellProviderError) {
            setState(() {
              _errorMessage = state.message;
              _isLoading = false;
            });
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error banner
              if (_errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => setState(() => _errorMessage = null),
                      ),
                    ],
                  ),
                ),

              // Success banner
              if (_successMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.white),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _successMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => setState(() => _successMessage = null),
                      ),
                    ],
                  ),
                ),

              // Current status card
              Card(
                color: const Color(0xFF1F1F1F),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _currentProvider == 'prestmit'
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _currentProvider == 'prestmit'
                                  ? Icons.flash_on
                                  : Icons.person,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Provider',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _currentProvider?.toUpperCase() ?? 'LOADING...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isLoading)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _currentDescription ?? 'Loading...',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Provider toggle section
              Text(
                'Change Provider',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Prestmit option
              _buildProviderOption(
                title: 'Prestmit (Automated)',
                description: 'Cards are automatically processed via Prestmit API. '
                    'Usually takes 5-15 minutes. Available 24/7.',
                icon: Icons.flash_on,
                color: const Color(0xFF3B82F6),
                isSelected: _currentProvider == 'prestmit',
                onTap: _isToggling ? () {} : () => _toggleProvider('prestmit'),
              ),

              const SizedBox(height: 12),

              // Manual option
              _buildProviderOption(
                title: 'Manual (Admin Review)',
                description: 'Cards require admin review before processing. '
                    'Slower but more control over each transaction.',
                icon: Icons.person,
                color: const Color(0xFF10B981),
                isSelected: _currentProvider == 'manual',
                onTap: _isToggling ? () {} : () => _toggleProvider('manual'),
              ),

              const SizedBox(height: 24),

              // Audit log section
              Text(
                'Recent Changes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              if (_auditLog.isEmpty)
                Card(
                  color: const Color(0xFF1F1F1F),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: const Color(0xFF9CA3AF),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No recent changes',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                ..._auditLog.map((log) => Card(
                      color: const Color(0xFF1F1F1F),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Icon(
                          log.to == 'prestmit' ? Icons.flash_on : Icons.person,
                          color: log.to == 'prestmit'
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF10B981),
                        ),
                        title: Text(
                          'Changed from ${log.from.toUpperCase()} to ${log.to.toUpperCase()}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        subtitle: Text(
                          'by ${log.admin} • ${_formatDate(log.timestamp)}',
                          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                        ),
                      ),
                    )),

              const SizedBox(height: 24),

              // Information section
              Text(
                'Provider Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Card(
                color: const Color(0xFF1F1F1F),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        Icons.info_outline,
                        'Prestmit API',
                        'Automated gift card trading across Africa',
                        const Color(0xFF3B82F6),
                      ),
                      const Divider(height: 32, color: Color(0xFF2D2D2D)),
                      _buildInfoRow(
                        Icons.speed,
                        'Processing Time',
                        '5-15 minutes average',
                        const Color(0xFF10B981),
                      ),
                      const Divider(height: 32, color: Color(0xFF2D2D2D)),
                      _buildInfoRow(
                        Icons.access_time,
                        'Availability',
                        '24/7 automated processing',
                        const Color(0xFF3B82F6),
                      ),
                      const Divider(height: 32, color: Color(0xFF2D2D2D)),
                      _buildInfoRow(
                        Icons.security,
                        'Security',
                        'Full idempotency and distributed locks',
                        const Color(0xFF10B981),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Warning card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  border: Border.all(color: const Color(0xFFFB923C)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Color(0xFFFB923C)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Important Notice',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Changing the provider will affect all new gift card sells immediately. '
                              'Existing in-progress sells will continue with their current provider.',
                              style: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProviderOption({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? color : const Color(0xFF2D2D2D),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class _ProviderChangeLog {
  final DateTime timestamp;
  final String from;
  final String to;
  final String admin;

  _ProviderChangeLog({
    required this.timestamp,
    required this.from,
    required this.to,
    required this.admin,
  });
}
