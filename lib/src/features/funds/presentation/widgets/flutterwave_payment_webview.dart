import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Result from the Flutterwave payment WebView
class FlutterwavePaymentResult {
  final bool success;
  final String? status;
  final String? txRef;
  final String? transactionId;
  final String? errorMessage;

  const FlutterwavePaymentResult({
    required this.success,
    this.status,
    this.txRef,
    this.transactionId,
    this.errorMessage,
  });

  factory FlutterwavePaymentResult.success({String? status, String? txRef, String? transactionId}) {
    return FlutterwavePaymentResult(
      success: true,
      status: status,
      txRef: txRef,
      transactionId: transactionId,
    );
  }

  factory FlutterwavePaymentResult.failed(String message) {
    return FlutterwavePaymentResult(
      success: false,
      errorMessage: message,
    );
  }

  factory FlutterwavePaymentResult.cancelled() {
    return const FlutterwavePaymentResult(
      success: false,
      errorMessage: 'Payment cancelled',
    );
  }
}

/// Shows the Flutterwave Standard hosted checkout in a bottom sheet WebView.
///
/// Opens the Flutterwave payment URL and intercepts the redirect to detect
/// success/failure. Returns a [FlutterwavePaymentResult].
///
/// Usage:
/// ```dart
/// final result = await showFlutterwavePaymentSheet(
///   context: context,
///   paymentUrl: 'https://checkout.flutterwave.com/v3/hosted/pay/...',
///   depositId: 'DEP-xxx',
/// );
/// if (result.success) {
///   // Payment completed — wait for webhook
/// }
/// ```
Future<FlutterwavePaymentResult> showFlutterwavePaymentSheet({
  required BuildContext context,
  required String paymentUrl,
  required String depositId,
  String redirectScheme = 'lazervault',
  String redirectPath = '/deposit/flutterwave/callback',
}) async {
  final result = await showModalBottomSheet<FlutterwavePaymentResult>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: const Color(0xFF1E3A5F).withValues(alpha: 0.7),
    isDismissible: false,
    enableDrag: false,
    builder: (context) => _FlutterwavePaymentSheet(
      paymentUrl: paymentUrl,
      depositId: depositId,
      redirectScheme: redirectScheme,
      redirectPath: redirectPath,
    ),
  );

  return result ?? FlutterwavePaymentResult.cancelled();
}

class _FlutterwavePaymentSheet extends StatefulWidget {
  final String paymentUrl;
  final String depositId;
  final String redirectScheme;
  final String redirectPath;

  const _FlutterwavePaymentSheet({
    required this.paymentUrl,
    required this.depositId,
    required this.redirectScheme,
    required this.redirectPath,
  });

  @override
  State<_FlutterwavePaymentSheet> createState() => _FlutterwavePaymentSheetState();
}

class _FlutterwavePaymentSheetState extends State<_FlutterwavePaymentSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  bool _redirectHandled = false;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _initWebView();
    // 10-minute timeout for completing payment
    _timeoutTimer = Timer(const Duration(minutes: 10), () {
      if (mounted && !_redirectHandled) {
        Navigator.of(context).pop(FlutterwavePaymentResult.failed(
          'Payment session timed out. Please try again.',
        ));
      }
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (uri == null) return NavigationDecision.navigate;

            // Intercept redirect back to app (guard against multiple redirects)
            if (!_redirectHandled &&
                (uri.scheme == widget.redirectScheme ||
                 request.url.contains(widget.redirectPath))) {
              _redirectHandled = true;
              _handleRedirect(uri);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            // Ignore errors from redirect scheme interception
            if (error.url?.startsWith(widget.redirectScheme) == true) return;
            if (mounted) {
              setState(() {
                _isLoading = false;
                _hasError = true;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _handleRedirect(Uri uri) {
    _timeoutTimer?.cancel();
    final status = uri.queryParameters['status'] ?? uri.queryParameters['resp'];
    final txRef = uri.queryParameters['tx_ref'] ?? uri.queryParameters['txRef'];
    final transactionId = uri.queryParameters['transaction_id'];

    if (!mounted) return;

    if (status == 'successful' || status == 'completed') {
      Navigator.of(context).pop(FlutterwavePaymentResult.success(
        status: status,
        txRef: txRef,
        transactionId: transactionId,
      ));
    } else if (status == 'cancelled') {
      Navigator.of(context).pop(FlutterwavePaymentResult.cancelled());
    } else {
      Navigator.of(context).pop(FlutterwavePaymentResult.failed(
        'Payment was not completed. Status: ${status ?? "unknown"}',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _showCancelConfirmation();
      },
      child: Container(
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Header bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF2D2D2D), width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Complete Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => _showCancelConfirmation(),
                  icon: const Icon(Icons.close, color: Colors.white70),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // WebView content
          Expanded(
            child: Stack(
              children: [
                if (_hasError)
                  _buildErrorState()
                else
                  WebViewWidget(controller: _controller),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'Unable to load payment page',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Please check your connection and try again.',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(FlutterwavePaymentResult.cancelled()),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                  ),
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
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Cancel Payment?',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        content: Text(
          'Are you sure you want to cancel this payment? You will need to start a new deposit.',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Continue Payment',
              style: TextStyle(color: const Color(0xFF3B82F6), fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(FlutterwavePaymentResult.cancelled());
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: const Color(0xFFEF4444), fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
