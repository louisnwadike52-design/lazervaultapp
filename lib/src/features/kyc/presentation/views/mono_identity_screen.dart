import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mono_connect/mono_connect.dart';

import '../../../../core/config/mono_config.dart';

/// Mono Identity verification screen for Nigerian users (BVN-based KYC).
///
/// Uses the Mono Connect SDK with identity scope to verify a user's BVN.
/// On successful verification, the auth code is returned via [onSuccess].
class MonoIdentityScreen extends StatefulWidget {
  final String sessionToken; // From CreateVerificationSession response
  final String verificationId;
  final String userName;
  final String userEmail;
  final Function(String authCode) onSuccess;
  final VoidCallback onClose;

  const MonoIdentityScreen({
    super.key,
    required this.sessionToken,
    required this.verificationId,
    required this.userName,
    required this.userEmail,
    required this.onSuccess,
    required this.onClose,
  });

  static const String route = '/kyc/mono-identity';

  @override
  State<MonoIdentityScreen> createState() => _MonoIdentityScreenState();
}

class _MonoIdentityScreenState extends State<MonoIdentityScreen> {
  // Theme colors
  static const _background = Color(0xFF0A0A0A);
  static const _cardBackground = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF3B82F6);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _success = Color(0xFF10B981);
  static const _error = Color(0xFFEF4444);

  bool _isLaunching = false;
  bool _isProcessing = false;
  bool _hasError = false;
  String? _errorMessage;

  void _handleSuccess(String code) {
    if (_isProcessing) return;
    _isProcessing = true;
    widget.onSuccess(code);
  }

  Future<void> _launchMonoIdentity() async {
    if (_isLaunching) return;

    if (widget.sessionToken.isEmpty) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = 'Session token not available. Please try again.';
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _isLaunching = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      final publicKey = MonoConfig.publicKey;
      final ref = 'lzv_kyc_${DateTime.now().millisecondsSinceEpoch}';

      final customer = MonoCustomer(
        newCustomer: MonoNewCustomer(
          name: widget.userName,
          email: widget.userEmail,
        ),
      );

      final completer = Completer<String?>();

      final config = ConnectConfiguration(
        publicKey: publicKey,
        customer: customer,
        reference: ref,
        scope: 'identity',
        onSuccess: (code) {
          debugPrint(
            '[MonoIdentity] Success - Code: ${code.substring(0, code.length > 10 ? 10 : code.length)}...',
          );
          HapticFeedback.mediumImpact();
          if (!completer.isCompleted) {
            completer.complete(code);
          }
        },
        onEvent: (event) {
          debugPrint('[MonoIdentity] Event: ${event.type.value}');
        },
        onClose: () {
          debugPrint('[MonoIdentity] Widget closed');
          HapticFeedback.lightImpact();
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        },
      );

      debugPrint('[MonoIdentity] Launching Mono Connect for identity...');
      debugPrint('[MonoIdentity] User: ${widget.userName}');
      debugPrint('[MonoIdentity] Verification ID: ${widget.verificationId}');

      // Launch Mono Connect in a themed bottom sheet
      _launchMonoBottomSheet(config);

      final result = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () => null,
      );

      if (!mounted) return;
      setState(() => _isLaunching = false);

      if (result != null) {
        _handleSuccess(result);
      }
      // If null (user cancelled or timed out), stay on screen so they can retry
    } catch (e) {
      debugPrint('[MonoIdentity] Error: $e');
      if (mounted) {
        setState(() {
          _isLaunching = false;
          _hasError = true;
          _errorMessage = 'Failed to launch verification. Please try again.';
        });
      }
    }
  }

  void _launchMonoBottomSheet(ConnectConfiguration config) {
    showModalBottomSheet<dynamic>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0xFF0D0D1A).withValues(alpha: 0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      clipBehavior: Clip.hardEdge,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: _primary.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: _primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: ConnectWebView.config(
                  config: config,
                  showLogs: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        title: const Text(
          'BVN Verification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: widget.onClose,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.fingerprint_rounded,
                    color: _primary,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              const Center(
                child: Text(
                  'Verify Your Identity with BVN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'We use your Bank Verification Number to confirm\nyour identity securely.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _textSecondary, fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),

              // Info cards
              _buildInfoCard(
                Icons.shield_outlined,
                'Bank-Grade Security',
                'Your BVN data is encrypted and never stored on our servers.',
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                Icons.speed_outlined,
                'Instant Verification',
                'Verification usually completes within seconds.',
              ),
              const SizedBox(height: 12),
              _buildInfoCard(
                Icons.lock_outline_rounded,
                'Regulatory Compliance',
                'Required by CBN for Tier 2 account access.',
              ),

              // Error message
              if (_hasError) ...[
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: _error,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _errorMessage ?? 'Something went wrong.',
                          style: const TextStyle(
                            color: _error,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              // CTA button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLaunching ? null : _launchMonoIdentity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    disabledBackgroundColor: _primary.withValues(alpha: 0.5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isLaunching
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          _hasError ? 'Retry Verification' : 'Start Verification',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),

              // Secondary action
              Center(
                child: TextButton(
                  onPressed: widget.onClose,
                  child: const Text(
                    'I\'ll do this later',
                    style: TextStyle(color: _textSecondary, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _success, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
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

