import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

/// Mono Connect Widget for bank account linking
///
/// This widget launches Mono Connect web flow to allow users to link their
/// external bank accounts. Once linked, the authorization code is returned
/// via callback.
class MonoConnectWidget extends StatefulWidget {
  /// Mono public key (get from environment or config)
  final String publicKey;

  /// Callback when user successfully links account
  final Function(String authCode) onSuccess;

  /// Callback when user cancels the linking process
  final VoidCallback onCancel;

  /// Callback when an error occurs
  final Function(String error) onError;

  /// Optional: Pre-selected institution (bank) code
  final String? institutionCode;

  /// Optional: Customer reference for tracking
  final String? reference;

  const MonoConnectWidget({
    Key? key,
    required this.publicKey,
    required this.onSuccess,
    required this.onCancel,
    required this.onError,
    this.institutionCode,
    this.reference,
  }) : super(key: key);

  @override
  State<MonoConnectWidget> createState() => _MonoConnectWidgetState();
}

class _MonoConnectWidgetState extends State<MonoConnectWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('[MonoConnect] Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('[MonoConnect] Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('[MonoConnect] Error: ${error.description}');
            setState(() {
              _errorMessage = error.description;
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('[MonoConnect] Navigation request: ${request.url}');

            // Check if it's a callback URL
            if (request.url.contains('?code=')) {
              _handleCallback(request.url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'MonoConnect',
        onMessageReceived: (JavaScriptMessage message) {
          _handleMonoMessage(message.message);
        },
      )
      ..loadRequest(Uri.parse(_buildMonoConnectUrl()));
  }

  /// Build Mono Connect URL with configuration
  String _buildMonoConnectUrl() {
    final Map<String, dynamic> config = {
      'key': widget.publicKey,
    };

    // Add optional parameters
    if (widget.institutionCode != null) {
      config['institution'] = widget.institutionCode;
    }

    if (widget.reference != null) {
      config['reference'] = widget.reference;
    }

    // Mono Connect Widget URL
    final baseUrl = 'https://connect.withmono.com';

    // Encode config as query parameter
    final configJson = Uri.encodeComponent(jsonEncode(config));

    return '$baseUrl?config=$configJson';
  }

  /// Handle callback URL with authorization code
  void _handleCallback(String url) {
    debugPrint('[MonoConnect] Handling callback: $url');

    final uri = Uri.parse(url);
    final code = uri.queryParameters['code'];

    if (code != null && code.isNotEmpty) {
      debugPrint('[MonoConnect] Authorization code received: ${code.substring(0, 10)}...');
      widget.onSuccess(code);
    } else {
      debugPrint('[MonoConnect] No code in callback');
      widget.onError('No authorization code received');
    }
  }

  /// Handle messages from Mono Connect JavaScript
  void _handleMonoMessage(String message) {
    debugPrint('[MonoConnect] Message received: $message');

    try {
      final data = jsonDecode(message);
      final type = data['type'] as String?;

      switch (type) {
        case 'mono.connect.success':
          final code = data['code'] as String?;
          if (code != null) {
            widget.onSuccess(code);
          }
          break;

        case 'mono.connect.error':
          final error = data['message'] as String? ?? 'Unknown error';
          widget.onError(error);
          break;

        case 'mono.connect.close':
          widget.onCancel();
          break;

        default:
          debugPrint('[MonoConnect] Unknown message type: $type');
      }
    } catch (e) {
      debugPrint('[MonoConnect] Failed to parse message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Link Bank Account',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF111827)),
          onPressed: widget.onCancel,
        ),
        bottom: _isLoading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4),
                child: LinearProgressIndicator(
                  backgroundColor: Color(0xFFE5E7EB),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
                ),
              )
            : null,
      ),
      body: Stack(
        children: [
          // WebView
          if (_errorMessage == null)
            WebViewWidget(controller: _controller)
          else
            _buildErrorView(),

          // Loading overlay
          if (_isLoading && _errorMessage == null)
            Container(
              color: Colors.white,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading Mono Connect...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to Load',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                  _isLoading = true;
                });
                _controller.reload();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to launch Mono Connect in a modal bottom sheet
Future<String?> showMonoConnect({
  required BuildContext context,
  required String publicKey,
  String? institutionCode,
  String? reference,
}) async {
  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: MonoConnectWidget(
        publicKey: publicKey,
        institutionCode: institutionCode,
        reference: reference,
        onSuccess: (code) {
          Navigator.of(context).pop(code);
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}
