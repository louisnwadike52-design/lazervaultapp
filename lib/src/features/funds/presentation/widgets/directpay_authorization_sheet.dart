import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// DirectPay Authorization Result
class DirectPayAuthResult {
  final bool success;
  final String? paymentId;
  final String? reference;
  final String? errorMessage;

  const DirectPayAuthResult({
    required this.success,
    this.paymentId,
    this.reference,
    this.errorMessage,
  });

  factory DirectPayAuthResult.success({String? paymentId, String? reference}) {
    return DirectPayAuthResult(
      success: true,
      paymentId: paymentId,
      reference: reference,
    );
  }

  factory DirectPayAuthResult.failed(String message) {
    return DirectPayAuthResult(
      success: false,
      errorMessage: message,
    );
  }

  factory DirectPayAuthResult.cancelled() {
    return const DirectPayAuthResult(
      success: false,
      errorMessage: 'Authorization cancelled',
    );
  }
}

/// DirectPay Authorization Bottom Sheet
///
/// Opens the Mono DirectPay authorization URL in an in-app WebView.
/// Intercepts the redirect to detect success/failure and returns result.
///
/// Usage:
/// ```dart
/// final result = await showDirectPayAuthorizationSheet(
///   context: context,
///   paymentUrl: 'https://connect.mono.co/...',
///   redirectScheme: 'lazervault',
///   paymentId: 'pay_123',
/// );
/// if (result.success) {
///   // Payment authorized
/// }
/// ```
Future<DirectPayAuthResult> showDirectPayAuthorizationSheet({
  required BuildContext context,
  required String paymentUrl,
  required String paymentId,
  String? reference,
  String redirectScheme = 'lazervault',
  String redirectPath = '/deposit/callback',
}) async {
  final result = await showModalBottomSheet<DirectPayAuthResult>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0xFF1E3A5F).withValues(alpha: 0.7),
    isDismissible: false, // Prevent accidental dismiss during payment
    enableDrag: false,
    builder: (context) => _DirectPayAuthSheet(
      paymentUrl: paymentUrl,
      paymentId: paymentId,
      reference: reference,
      redirectScheme: redirectScheme,
      redirectPath: redirectPath,
    ),
  );

  return result ?? DirectPayAuthResult.cancelled();
}

class _DirectPayAuthSheet extends StatefulWidget {
  final String paymentUrl;
  final String paymentId;
  final String? reference;
  final String redirectScheme;
  final String redirectPath;

  const _DirectPayAuthSheet({
    required this.paymentUrl,
    required this.paymentId,
    this.reference,
    required this.redirectScheme,
    required this.redirectPath,
  });

  @override
  State<_DirectPayAuthSheet> createState() => _DirectPayAuthSheetState();
}

class _DirectPayAuthSheetState extends State<_DirectPayAuthSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  // Redirect patterns to detect completion
  late final List<String> _successPatterns;
  late final List<String> _failurePatterns;

  @override
  void initState() {
    super.initState();
    _initializePatterns();
    _initializeWebView();
  }

  void _initializePatterns() {
    final scheme = widget.redirectScheme;
    final path = widget.redirectPath;

    // Patterns that indicate successful authorization
    _successPatterns = [
      '$scheme://$path',
      '$scheme:/$path',
      'success=true',
      'status=successful',
      'payment_status=successful',
    ];

    // Patterns that indicate failed/cancelled authorization
    _failurePatterns = [
      'status=failed',
      'status=cancelled',
      'error=',
      'payment_status=failed',
    ];
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('[DirectPay] Page started: $url');
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (url) {
            debugPrint('[DirectPay] Page finished: $url');
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (error) {
            debugPrint('[DirectPay] WebView error: ${error.description}');
            // Don't show error for redirect URLs
            if (!_isRedirectUrl(error.url ?? '')) {
              if (mounted) {
                setState(() {
                  _hasError = true;
                  _errorMessage = error.description;
                  _isLoading = false;
                });
              }
            }
          },
          onNavigationRequest: (request) {
            final url = request.url;
            debugPrint('[DirectPay] Navigation request: $url');

            // Check if this is a redirect URL (success or failure)
            if (_isRedirectUrl(url)) {
              _handleRedirect(url);
              return NavigationDecision.prevent;
            }

            // Allow navigation to Mono and bank pages
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  bool _isRedirectUrl(String url) {
    final lowerUrl = url.toLowerCase();

    // Check for our app's redirect scheme
    if (lowerUrl.startsWith('${widget.redirectScheme}://') ||
        lowerUrl.startsWith('${widget.redirectScheme}:/')) {
      return true;
    }

    // Check for callback path in any URL
    if (lowerUrl.contains(widget.redirectPath)) {
      return true;
    }

    return false;
  }

  void _handleRedirect(String url) {
    debugPrint('[DirectPay] Handling redirect: $url');
    HapticFeedback.mediumImpact();

    final lowerUrl = url.toLowerCase();

    // Check for success indicators
    final isSuccess = _successPatterns.any((pattern) =>
      lowerUrl.contains(pattern.toLowerCase())
    );

    // Check for failure indicators
    final isFailure = _failurePatterns.any((pattern) =>
      lowerUrl.contains(pattern.toLowerCase())
    );

    if (isSuccess && !isFailure) {
      // Extract any parameters from the URL
      final uri = Uri.tryParse(url);
      final queryParams = uri?.queryParameters ?? {};

      Navigator.of(context).pop(DirectPayAuthResult.success(
        paymentId: queryParams['payment_id'] ?? widget.paymentId,
        reference: queryParams['reference'] ?? widget.reference,
      ));
    } else if (isFailure) {
      final uri = Uri.tryParse(url);
      final errorMsg = uri?.queryParameters['error'] ??
                       uri?.queryParameters['message'] ??
                       'Payment authorization failed';

      Navigator.of(context).pop(DirectPayAuthResult.failed(errorMsg));
    } else {
      // Default to success if we hit our redirect URL
      Navigator.of(context).pop(DirectPayAuthResult.success(
        paymentId: widget.paymentId,
        reference: widget.reference,
      ));
    }
  }

  void _handleCancel() {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Payment?'),
        content: const Text(
          'Are you sure you want to cancel this payment authorization? '
          'You will need to start over.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Continue'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(DirectPayAuthResult.cancelled());
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Cancel Payment'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Header
          _buildHeader(),

          // Content
          Expanded(
            child: _hasError ? _buildErrorView() : _buildWebView(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),

          // Title row
          Row(
            children: [
              IconButton(
                onPressed: _handleCancel,
                icon: Icon(
                  Icons.close,
                  color: Colors.grey[600],
                  size: 24.sp,
                ),
                tooltip: 'Cancel',
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 14.sp,
                          color: const Color(0xFF00D09C),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Secure Payment',
                          style: TextStyle(
                            color: const Color(0xFF1E3A5F),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Authorize with your bank',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 48.w), // Balance the close button
            ],
          ),

          // Loading indicator
          if (_isLoading)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6C5CE7),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: WebViewWidget(controller: _controller),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Colors.red[400],
            ),
            SizedBox(height: 16.h),
            Text(
              'Connection Error',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A5F),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _errorMessage ?? 'Failed to load payment page',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(
                    DirectPayAuthResult.cancelled(),
                  ),
                  child: const Text('Cancel'),
                ),
                SizedBox(width: 16.w),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _isLoading = true;
                    });
                    _controller.loadRequest(Uri.parse(widget.paymentUrl));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
