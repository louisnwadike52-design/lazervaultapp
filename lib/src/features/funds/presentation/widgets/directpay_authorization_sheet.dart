import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

/// Which flow is hosting the Mono webview. Drives the sheet chrome (header copy,
/// cancel-dialog wording, and whether we render our own close button). The
/// webview behaviour and redirect handling are identical across flows.
enum DirectPayFlow { deposit, mandate, kyc }

extension DirectPayFlowChrome on DirectPayFlow {
  String get headerTitle {
    switch (this) {
      case DirectPayFlow.kyc:
        return 'Identity Verification';
      case DirectPayFlow.mandate:
        return 'Set up Direct Debit';
      case DirectPayFlow.deposit:
        return 'Secure Payment';
    }
  }

  String get headerSubtitle {
    switch (this) {
      case DirectPayFlow.kyc:
        return 'Verify your identity securely';
      case DirectPayFlow.mandate:
        return 'Authorize recurring access';
      case DirectPayFlow.deposit:
        return 'Authorize with your bank';
    }
  }

  /// KYC uses Mono's own close control inside the widget, so we don't render a
  /// second one in our header. Deposit/mandate keep our close affordance.
  bool get showCloseButton => this != DirectPayFlow.kyc;

  String get cancelTitle =>
      this == DirectPayFlow.kyc ? 'Stop verification?' : 'Cancel Payment?';

  String get cancelBody => this == DirectPayFlow.kyc
      ? 'Are you sure you want to stop identity verification? You will need to start over.'
      : 'Are you sure you want to cancel this payment authorization? You will need to start over.';

  String get cancelConfirmLabel =>
      this == DirectPayFlow.kyc ? 'Stop' : 'Cancel Payment';
}

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
  DirectPayFlow flow = DirectPayFlow.deposit,
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
      flow: flow,
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
  final DirectPayFlow flow;

  const _DirectPayAuthSheet({
    required this.paymentUrl,
    required this.paymentId,
    this.reference,
    required this.redirectScheme,
    required this.redirectPath,
    this.flow = DirectPayFlow.deposit,
  });

  @override
  State<_DirectPayAuthSheet> createState() => _DirectPayAuthSheetState();
}

class _DirectPayAuthSheetState extends State<_DirectPayAuthSheet> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  // Mono Prove "blocked-continue" detection. The Prove consent screen disables
  // its "Grant Permission" button until every required verification document is
  // provided; the user gets no explanation. We poll the page, and when the
  // continue action stays disabled with incomplete items, we tell them what to
  // do. Gated to prove.mono.co so DirectPay bank-auth flows are unaffected.
  String _currentUrl = '';
  Timer? _proveProbeTimer;
  String? _lastBlockedKey;
  bool _blockedDialogOpen = false;
  // Consecutive probe ticks where "Grant Permission" is disabled but we found
  // no actionable item to surface (e.g. the provider rejected a detail like an
  // invalid date of birth). After a few ticks we show a generic "couldn't
  // complete" hint so the user isn't stuck on a dead button.
  int _disabledNoActionTicks = 0;

  // Redirect patterns to detect completion
  late final List<String> _successPatterns;
  late final List<String> _failurePatterns;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.paymentUrl;
    _initializePatterns();
    _initializeWebView();
    // Poll for (a) the Prove "can't-continue" state (disabled Grant Permission
    // with outstanding documents) and (b) a provider client-side crash. The
    // Mono SPA can throw an UNCAUGHT exception on an in-app transition (e.g.
    // tapping Continue on the "remember me" resume screen) — that fires no page
    // load, no network error and no console message, so onPageFinished's
    // detector never runs. Polling here catches it within a tick. Cheap JS read.
    _proveProbeTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        _probeProveBlockedState();
        _detectClientSideError();
      },
    );
  }

  @override
  void dispose() {
    _proveProbeTimer?.cancel();
    super.dispose();
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
      // Mono's Prove/DirectPay widgets are Next.js SPAs that sniff the UA and
      // crash ("client-side exception") when they see a bare WebView agent.
      // Present as Chrome-on-Android so feature detection succeeds.
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 14; Pixel 7) AppleWebKit/537.36 '
        '(KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36')
      // Surface the real JS error instead of the generic Next.js boundary text.
      ..setOnConsoleMessage((msg) {
        debugPrint('[DirectPay][JS:${msg.level.name}] ${msg.message}');
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('[DirectPay] Page started: $url');
            _currentUrl = url;
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (url) {
            debugPrint('[DirectPay] Page finished: $url');
            _currentUrl = url;
            if (mounted) {
              setState(() => _isLoading = false);
            }
            // Mono's SPA renders its crash as a normal HTTP-200 page ("Application
            // error: a client-side exception…"), so onWebResourceError never
            // fires. Sniff the rendered text and surface our own clean error view
            // instead of leaving the user on the broken Mono page.
            _detectClientSideError();
          },
          onWebResourceError: (error) {
            debugPrint('[DirectPay] WebView error: ${error.description} '
                '(mainFrame=${error.isForMainFrame})');
            // Ignore sub-resource failures (fonts, analytics, etc.) — only a
            // main-frame load failure should surface the error view.
            if (error.isForMainFrame == false) return;
            // The deep-link redirect "fails" to load by design — not an error.
            if (_isRedirectUrl(error.url ?? '')) return;
            if (mounted) {
              setState(() {
                _hasError = true;
                // Never leak a raw "net::ERR_FAILED" to the user.
                _errorMessage =
                    'We couldn\'t reach the verification service. Please check '
                    'your connection and try again.';
                _isLoading = false;
              });
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

    // Android: grant camera/microphone to the page (Mono Prove does a live
    // facial/biometric check) and allow media without a user gesture. Without
    // this, getUserMedia() throws inside the SPA and the React tree unmounts.
    final platform = _controller.platform;
    if (platform is AndroidWebViewController) {
      platform.setMediaPlaybackRequiresUserGesture(false);
      platform.setOnPlatformPermissionRequest((request) {
        request.grant();
      });
    }
  }

  /// Reads the rendered page text and, if it matches a known provider crash
  /// boundary (Next.js "client-side exception", Mono "Application error"),
  /// flips to our graceful error view. No-op on healthy pages.
  Future<void> _detectClientSideError() async {
    if (!mounted || _hasError) return;
    try {
      final raw = await _controller.runJavaScriptReturningResult(
        "(document.body ? document.body.innerText : '').slice(0, 600)",
      );
      final text = raw.toString().toLowerCase();
      final crashed = text.contains('client-side exception') ||
          (text.contains('application error') &&
              text.contains('browser console'));
      if (crashed && mounted) {
        debugPrint('[DirectPay] Detected provider client-side crash');
        setState(() {
          _hasError = true;
          _errorMessage =
              'The verification service hit a problem loading. Please try again '
              'in a moment.';
          _isLoading = false;
        });
      }
    } catch (_) {
      // JS eval can fail on some pages (CSP / about:blank); ignore — a real
      // network failure still routes through onWebResourceError.
    }
  }

  // JS read: is this the Prove consent screen, is "Grant Permission" disabled,
  // and which verification documents are still outstanding (action Upload/Add/
  // Verify/Pending)? Validated against the live Prove DOM.
  static const String _proveProbeJs = r'''
(function(){
  try{
    var btns=[].slice.call(document.querySelectorAll('button'));
    var grant=btns.filter(function(b){return /grant permission/i.test(b.innerText||'')})[0];
    if(!grant) return JSON.stringify({prove:false});
    var labels=[];
    [].slice.call(document.querySelectorAll('*')).forEach(function(e){
      var t=(e.innerText||'').trim();
      var m=t.match(/^([A-Za-z ]{2,20})\s*[-–]\s*(Upload|Add|Verify|Pending)$/);
      if(m && e.children.length<=4) labels.push(m[1].trim());
    });
    var uniq=labels.filter(function(v,i){return labels.indexOf(v)===i});
    return JSON.stringify({prove:true,disabled:!!grant.disabled,incomplete:uniq});
  }catch(err){ return JSON.stringify({prove:false}); }
})()
''';

  Future<void> _probeProveBlockedState() async {
    if (!mounted || _hasError || _blockedDialogOpen) return;
    if (!_currentUrl.toLowerCase().contains('prove.mono.co')) return;
    try {
      final raw = await _controller.runJavaScriptReturningResult(_proveProbeJs);
      final map = _asJsonMap(raw);
      if (map == null || map['prove'] != true) return;
      final disabled = map['disabled'] == true;
      final incomplete = (map['incomplete'] as List?)
              ?.map((e) => e.toString())
              .where((s) => s.isNotEmpty)
              .toList() ??
          <String>[];
      if (!disabled) {
        // Grant Permission is enabled (or the page moved on) — fully resolved.
        _lastBlockedKey = null;
        _disabledNoActionTicks = 0;
        return;
      }
      if (incomplete.isNotEmpty) {
        // We know exactly what is outstanding — guide the user to provide it.
        _disabledNoActionTicks = 0;
        final key = incomplete.join(',');
        if (key == _lastBlockedKey) return; // already guided for this exact set
        _lastBlockedKey = key;
        _showProveActionNeededDialog(incomplete);
        return;
      }
      // Grant Permission disabled but nothing actionable we can detect (e.g. the
      // provider rejected a detail like an invalid date of birth). Give it a few
      // ticks in case it is still validating, then surface a generic "couldn't
      // complete" hint so the user isn't stuck staring at a dead button.
      _disabledNoActionTicks++;
      if (_disabledNoActionTicks >= 4) {
        _showProveStuckDialog();
      }
    } catch (_) {
      // Page not ready / eval blocked — ignore and try again next tick.
    }
  }

  /// Decodes a JS result that may arrive as a JSON string (Android) or an
  /// already-decoded value (iOS), tolerating one layer of double-encoding.
  Map<String, dynamic>? _asJsonMap(Object? raw) {
    dynamic v = raw;
    for (var i = 0; i < 2; i++) {
      if (v is Map) return v.cast<String, dynamic>();
      if (v is String) {
        try {
          v = jsonDecode(v);
        } catch (_) {
          return null;
        }
      } else {
        return null;
      }
    }
    return v is Map ? v.cast<String, dynamic>() : null;
  }

  void _showProveActionNeededDialog(List<String> items) {
    if (!mounted) return;
    _blockedDialogOpen = true;
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Icon(Icons.assignment_late_outlined,
                color: const Color(0xFF4E03D0), size: 24.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text('One more step',
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F))),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To finish verifying your identity, please provide the following '
              'in the Verification Documents section:',
              style: TextStyle(
                  fontSize: 14.sp, color: Colors.grey[700], height: 1.4),
            ),
            SizedBox(height: 12.h),
            ...items.map((it) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    children: [
                      Icon(Icons.upload_file_rounded,
                          size: 18.sp, color: const Color(0xFF4E03D0)),
                      SizedBox(width: 8.w),
                      Text(it,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E3A5F))),
                    ],
                  ),
                )),
            SizedBox(height: 12.h),
            Text(
              'Tap each item above and follow the prompts. "Grant Permission" '
              'will become available once they are complete.',
              style: TextStyle(
                  fontSize: 13.sp, color: Colors.grey[600], height: 1.4),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0)),
            child: const Text('Got it'),
          ),
        ],
      ),
    ).then((_) => _blockedDialogOpen = false);
  }

  /// Shown when "Grant Permission" stays disabled with nothing actionable we can
  /// detect (e.g. the provider rejected a detail like an invalid date of birth),
  /// so the user isn't left staring at a dead button. Offers a retry (reload) or
  /// a clean close (returns cancelled — the host can then offer skip/continue).
  void _showProveStuckDialog() {
    if (!mounted || _blockedDialogOpen) return;
    _blockedDialogOpen = true;
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          children: [
            Icon(Icons.error_outline_rounded,
                color: const Color(0xFFEF4444), size: 24.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text("We couldn't complete verification",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E3A5F))),
            ),
          ],
        ),
        content: Text(
          "Some of your details couldn't be confirmed by our verification "
          'partner. Please try again, or close and continue — you can finish '
          'verifying later.',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[700], height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(DirectPayAuthResult.cancelled());
            },
            child: Text('Close', style: TextStyle(color: Colors.grey[700])),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _disabledNoActionTicks = 0;
              _lastBlockedKey = null;
              _controller.reload();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0)),
            child: const Text('Try Again'),
          ),
        ],
      ),
    ).then((_) => _blockedDialogOpen = false);
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
        title: Text(widget.flow.cancelTitle),
        content: Text(widget.flow.cancelBody),
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
            child: Text(widget.flow.cancelConfirmLabel),
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
              color: const Color.fromARGB(255, 78, 3, 208),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),

          // Title row
          Row(
            children: [
              // Our close control. Hidden for KYC (Mono renders its own X inside
              // the widget, so a second one is confusing); a matching spacer
              // keeps the title centered in that case.
              if (widget.flow.showCloseButton)
                IconButton(
                  onPressed: _handleCancel,
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                    size: 24.sp,
                  ),
                  tooltip: 'Cancel',
                )
              else
                SizedBox(width: 48.w),
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
                          widget.flow.headerTitle,
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
                      widget.flow.headerSubtitle,
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
                  Color.fromARGB(255, 78, 3, 208),
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
                    backgroundColor: const Color.fromARGB(255, 78, 3, 208),
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
