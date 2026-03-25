import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Reusable WebView screen for KYC provider hosted flows (Smile ID, Onfido, Persona).
///
/// Loads [sessionUrl] in a full-screen WebView and intercepts the
/// `lazervault://kyc/callback` redirect to determine success/failure.
/// Auto-closes after 5 minutes with a timeout message.
class KYCProviderWebViewScreen extends StatefulWidget {
  final String sessionUrl;
  final String provider; // smile_id, onfido, persona
  final String verificationId;
  final Function(bool success) onComplete;

  const KYCProviderWebViewScreen({
    super.key,
    required this.sessionUrl,
    required this.provider,
    required this.verificationId,
    required this.onComplete,
  });

  static const String route = '/kyc/provider-webview';

  @override
  State<KYCProviderWebViewScreen> createState() =>
      _KYCProviderWebViewScreenState();
}

class _KYCProviderWebViewScreenState extends State<KYCProviderWebViewScreen> {
  // Theme colors
  static const _background = Color(0xFF0A0A0A);
  static const _cardBackground = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF3B82F6);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _error = Color(0xFFEF4444);

  late final WebViewController _controller;
  Timer? _timeoutTimer;

  bool _isLoading = true;
  bool _hasError = false;
  bool _completed = false;
  String? _errorMessage;

  static const _callbackScheme = 'lazervault';
  static const _callbackHost = 'kyc';
  static const _callbackPath = '/callback';
  static const _timeoutDuration = Duration(minutes: 5);

  void _fireCallback(bool success) {
    if (_completed) return;
    _completed = true;
    _timeoutTimer?.cancel();
    widget.onComplete(success);
  }

  @override
  void initState() {
    super.initState();
    final uri = Uri.tryParse(widget.sessionUrl);
    if (uri == null || !uri.hasScheme) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid verification URL')),
          );
          Navigator.of(context).pop();
        }
      });
      return;
    }
    _initWebView();
    _startTimeoutTimer();
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(_background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: _handleNavigation,
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            debugPrint(
              '[KYCWebView] Resource error: ${error.description} (${error.errorCode})',
            );
            if (mounted) {
              setState(() {
                _hasError = true;
                _isLoading = false;
                _errorMessage =
                    error.description.isNotEmpty
                        ? error.description
                        : 'Failed to load verification page.';
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.sessionUrl));
  }

  void _startTimeoutTimer() {
    _timeoutTimer = Timer(_timeoutDuration, () {
      if (!mounted) return;
      _showTimeoutDialog();
    });
  }

  NavigationDecision _handleNavigation(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    if (uri == null) return NavigationDecision.navigate;

    if (uri.scheme == _callbackScheme &&
        uri.host == _callbackHost &&
        uri.path == _callbackPath) {
      final status = uri.queryParameters['status']?.toLowerCase();
      final success = status == 'success' || status == 'complete';

      debugPrint(
        '[KYCWebView] Callback intercepted: status=$status, success=$success',
      );
      HapticFeedback.mediumImpact();

      _fireCallback(success);

      if (mounted) Navigator.of(context).pop();
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  void _showTimeoutDialog() {
    if (!mounted) return;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: _cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Verification Timed Out',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        content: const Text(
          'The verification session has expired. Please try again.',
          style: TextStyle(color: _textSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _fireCallback(false);
              if (mounted) Navigator.of(context).pop();
            },
            child: const Text('OK', style: TextStyle(color: _primary)),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Cancel Verification?',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        content: const Text(
          'Leaving will cancel the verification process. '
          'You can restart it later.',
          style: TextStyle(color: _textSecondary, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Stay', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Leave', style: TextStyle(color: _error)),
          ),
        ],
      ),
    );

    if (shouldLeave == true) {
      _fireCallback(false);
    }
    return shouldLeave ?? false;
  }

  String get _providerDisplayName {
    switch (widget.provider.toLowerCase()) {
      case 'smile_id':
        return 'Smile ID';
      case 'onfido':
        return 'Onfido';
      case 'persona':
        return 'Persona';
      default:
        return 'Identity Verification';
    }
  }

  void _retry() {
    if (!mounted) return;
    setState(() {
      _hasError = false;
      _isLoading = true;
      _errorMessage = null;
    });
    _controller.loadRequest(Uri.parse(widget.sessionUrl));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          backgroundColor: _background,
          elevation: 0,
          title: Text(
            _providerDisplayName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          bottom: _isLoading
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(2),
                  child: LinearProgressIndicator(
                    backgroundColor: _cardBackground,
                    valueColor: AlwaysStoppedAnimation<Color>(_primary),
                  ),
                )
              : null,
        ),
        body: _hasError ? _buildErrorView() : _buildWebView(),
      ),
    );
  }

  Widget _buildWebView() {
    return WebViewWidget(controller: _controller);
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: _error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: _error,
                size: 36,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Failed to Load',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Something went wrong. Please try again.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: _textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _retry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Retry',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                final shouldPop = await _onWillPop();
                if (shouldPop && context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: _textSecondary, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
