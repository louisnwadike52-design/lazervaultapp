// MyCover hosted-claim bottom sheet.
//
// MyCover.ai does not expose a "create claim" REST endpoint — their
// claim flow runs entirely inside a hosted web view. We collect the
// merchant URL + the user's customer_id (and optionally policy_id /
// product_id) from the backend's per-policy `GetInsurancePolicy`
// metadata extras, then render it in an in-app bottom sheet so the
// experience feels native instead of an out-of-app browser tab.
//
// After the user files a claim, the new claim shows up on
// `MyClaimsScreen` through the live `pb.InsuranceService/GetUserClaims`
// pipeline (backend resolves user → mycover_customer_id and calls
// MyCover's `GET /v2/claims?customer_id=…` for real-time status).
//
// The bottom sheet keeps our own chrome (drag handle, close button,
// product/policy header) so it doesn't look like a browser pop-up.

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Distinguishes the two hosted MyCover flows (claim vs renewal) so the
/// sheet can pick the right copy without duplicating the entire WebView
/// scaffolding. Both flows are identical at the runtime level — a
/// MyCover-hosted form opened in-app — only the user-facing labels
/// differ.
enum MyCoverHostedFlowKind { claim, renew, buy, manage }

class MyCoverClaimBottomSheet extends StatefulWidget {
  const MyCoverClaimBottomSheet({
    super.key,
    required this.urlResolver,
    required this.policyLabel,
    this.providerName,
    this.kind = MyCoverHostedFlowKind.claim,
  });

  /// Async resolver that returns the MyCover hosted-flow URL the
  /// webview should load. The backend is the single source of truth:
  /// `GetInsurancePolicy` reads
  /// `system_settings.insurance.mycover.{claim,renew}_link`, appends
  /// the right params for this policy (customer_id / policy_id /
  /// policy_number / email / product_id), and surfaces the composed
  /// result via `coverageDetails['claim_url']` / `['renew_url']` — the
  /// final URL has the form
  /// `https://s.mycover.ai/#MERCHANT_KEY?param=…&param=…` (params
  /// inside the hash so MyCover's hash-routed SPA reads them via
  /// `window.location.hash`).
  ///
  /// We take a resolver instead of a bare URL string so the sheet can
  /// open IMMEDIATELY with chrome + a loading state, then surface
  /// any backend errors inside the sheet (with retry + open-in-browser)
  /// instead of relying on a transient toast that disappears before
  /// the user can read it. Return `null` to signal "URL not ready yet";
  /// throw to signal a real error (network, gRPC, auth).
  final Future<String?> Function() urlResolver;

  /// Headline shown in the sheet chrome — typically the product name or
  /// policy number, so the user can confirm what they're claiming on.
  final String policyLabel;

  /// Optional subtext (provider org name) for the sheet header.
  final String? providerName;

  /// Which hosted flow this sheet represents — drives the header,
  /// error wording, and footer copy. Defaults to claim for backwards
  /// compatibility with existing call sites.
  final MyCoverHostedFlowKind kind;

  static Future<void> show(
    BuildContext context, {
    required Future<String?> Function() urlResolver,
    required String policyLabel,
    String? providerName,
    MyCoverHostedFlowKind kind = MyCoverHostedFlowKind.claim,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => MyCoverClaimBottomSheet(
        urlResolver: urlResolver,
        policyLabel: policyLabel,
        providerName: providerName,
        kind: kind,
      ),
    );
  }

  /// Convenience for the renewal flow. Mirrors `show` but flips the
  /// kind so callers don't have to import the enum just to open the
  /// renewal webview.
  static Future<void> showRenewal(
    BuildContext context, {
    required Future<String?> Function() urlResolver,
    required String policyLabel,
    String? providerName,
  }) {
    return show(
      context,
      urlResolver: urlResolver,
      policyLabel: policyLabel,
      providerName: providerName,
      kind: MyCoverHostedFlowKind.renew,
    );
  }

  /// Convenience for the hosted BUY flow — opens the universal MyCover link
  /// so the user can purchase a new policy. Used when the admin enables the
  /// `insurance_hosted_entrypoints_enabled` toggle.
  static Future<void> showBuy(
    BuildContext context, {
    required Future<String?> Function() urlResolver,
    String policyLabel = 'Buy Insurance',
    String? providerName,
  }) {
    return show(
      context,
      urlResolver: urlResolver,
      policyLabel: policyLabel,
      providerName: providerName,
      kind: MyCoverHostedFlowKind.buy,
    );
  }

  /// Convenience for the hosted MANAGE-PLAN flow — opens the universal
  /// MyCover link so the user can manage their existing policies.
  static Future<void> showManage(
    BuildContext context, {
    required Future<String?> Function() urlResolver,
    String policyLabel = 'Manage Your Plans',
    String? providerName,
  }) {
    return show(
      context,
      urlResolver: urlResolver,
      policyLabel: policyLabel,
      providerName: providerName,
      kind: MyCoverHostedFlowKind.manage,
    );
  }

  @override
  State<MyCoverClaimBottomSheet> createState() => _MyCoverClaimBottomSheetState();
}

class _MyCoverClaimBottomSheetState extends State<MyCoverClaimBottomSheet> {
  late final WebViewController _controller;
  bool _loading = true;
  int _progress = 0;
  bool _loadFailed = false;
  String? _errorMessage;

  bool get _isRenewal => widget.kind == MyCoverHostedFlowKind.renew;
  String get _flowNoun {
    switch (widget.kind) {
      case MyCoverHostedFlowKind.renew:
        return 'renewal';
      case MyCoverHostedFlowKind.buy:
        return 'purchase';
      case MyCoverHostedFlowKind.manage:
        return 'plan';
      case MyCoverHostedFlowKind.claim:
        return 'claim';
    }
  }

  String get _headerTitle {
    switch (widget.kind) {
      case MyCoverHostedFlowKind.renew:
        return 'Renew Your Policy';
      case MyCoverHostedFlowKind.buy:
        return 'Buy Insurance';
      case MyCoverHostedFlowKind.manage:
        return 'Manage Your Plans';
      case MyCoverHostedFlowKind.claim:
        return 'File a Claim';
    }
  }

  String get _errorTitle => "Couldn't open the $_flowNoun page";

  String get _footerText {
    switch (widget.kind) {
      case MyCoverHostedFlowKind.renew:
        return 'Renewals are processed by the insurance provider. Once you '
            'submit, your policy will reflect the new term and a receipt is sent to your email.';
      case MyCoverHostedFlowKind.buy:
        return 'Your new policy is processed by the insurance provider. Once '
            'payment completes it appears here in your policies — automatically.';
      case MyCoverHostedFlowKind.manage:
        return 'Manage your existing policies with the insurance provider. Any '
            'changes sync back to your policies here automatically.';
      case MyCoverHostedFlowKind.claim:
        return 'Claims are reviewed by the insurance provider. Once you '
            'submit, your claim appears in My Claims with live status updates.';
    }
  }

  IconData get _headerIcon {
    switch (widget.kind) {
      case MyCoverHostedFlowKind.renew:
        return Icons.autorenew_rounded;
      case MyCoverHostedFlowKind.buy:
        return Icons.add_shopping_cart_rounded;
      case MyCoverHostedFlowKind.manage:
        return Icons.tune_rounded;
      case MyCoverHostedFlowKind.claim:
        return Icons.assignment_outlined;
    }
  }

  @override
  void initState() {
    super.initState();
    _initController();
    _loadClaimUrl();
  }

  /// The URL we ultimately point the webview at. Resolved in `initState`
  /// to either `widget.claimUrl` (when valid) or a Flutter-side
  /// composition from `baseMerchantLink` + `fallbackParams`. Kept on the
  /// state so the open-in-browser fallback uses the same URL the
  /// embedded webview tried.
  String _resolvedUrl = '';

  /// Most modern hosted pages sniff the user-agent to deliver mobile
  /// markup. Some reject Android System WebView's default UA outright,
  /// which is one of the root causes we've seen for a blank webview.
  /// Pin a realistic Chrome-on-Android UA so MyCover's CDN/WAF serves
  /// us the same HTML the browser would.
  static const String _kModernUA =
      'Mozilla/5.0 (Linux; Android 14; Pixel 9a) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/137.0.0.0 Mobile Safari/537.36';

  void _initController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(_kModernUA)
      ..setBackgroundColor(const Color(0xFF1F1F1F))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (p) {
          if (!mounted) return;
          setState(() => _progress = p);
        },
        onPageStarted: (_) {
          if (!mounted) return;
          setState(() {
            _loading = true;
            _loadFailed = false;
            _errorMessage = null;
          });
        },
        onPageFinished: (_) {
          if (!mounted) return;
          setState(() => _loading = false);
        },
        // Surface load failures (network down, DNS, TLS, 4xx, 5xx) so the
        // user isn't stuck staring at a half-rendered page. Filters to the
        // main frame so subresource (favicon/analytics) errors don't trip
        // the retry UI.
        onWebResourceError: (err) {
          if (!mounted) return;
          if (err.isForMainFrame == false) return;
          setState(() {
            _loading = false;
            _loadFailed = true;
            _errorMessage = err.description.isNotEmpty
                ? err.description
                : 'We couldn\'t load the $_flowNoun page. Check your connection and try again.';
          });
        },
        onHttpError: (err) {
          if (!mounted) return;
          // Same filter — only react to top-level navigation errors.
          if (err.response?.statusCode == null) return;
          if (err.response!.statusCode >= 400) {
            setState(() {
              _loading = false;
              _loadFailed = true;
              _errorMessage =
                  'The $_flowNoun page returned an error (${err.response!.statusCode}). Please try again later.';
            });
          }
        },
      ));
  }

  Future<void> _loadClaimUrl() async {
    if (!mounted) return;
    // Start in a clean loading state so a retry from the error
    // overlay re-paints correctly.
    setState(() {
      _loading = true;
      _loadFailed = false;
      _errorMessage = null;
      _progress = 0;
      _resolvedUrl = '';
    });
    String? url;
    try {
      url = await widget.urlResolver();
    } catch (e) {
      if (!mounted) return;
      // Surface the real error class so logcat shows what's happening,
      // but the user gets the friendly message. Includes both flow
      // wordings (claim/renewal) so the caller doesn't have to.
      // ignore: avoid_print
      print('MyCoverClaimBottomSheet: $_flowNoun urlResolver threw — $e');
      setState(() {
        _loading = false;
        _loadFailed = true;
        _errorMessage = 'Couldn\'t reach the $_flowNoun service. Tap retry, '
            'or use "Open in browser" if the issue persists.';
      });
      return;
    }
    if (!mounted) return;
    final candidate = (url ?? '').trim();
    final uri = Uri.tryParse(candidate);
    if (candidate.isEmpty || uri == null || !uri.hasScheme) {
      setState(() {
        _loading = false;
        _loadFailed = true;
        _errorMessage = _isRenewal
            ? 'Renewal isn\'t ready yet for this policy. The provider is '
                'still finalising it — try again in a few moments.'
            : 'Claim filing isn\'t ready yet for this policy. The provider '
                'is still finalising your customer record — try again shortly.';
      });
      return;
    }
    _resolvedUrl = candidate;
    _controller.loadRequest(uri);
  }

  /// Open the resolved URL in the device's default browser. Used as a
  /// fallback when the embedded webview can't render (some hosted
  /// providers block WebView UAs entirely; the system browser still
  /// works in those cases).
  Future<void> _openInExternalBrowser() async {
    if (_resolvedUrl.isEmpty) return;
    final uri = Uri.tryParse(_resolvedUrl);
    if (uri == null) return;
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF1F1F1F),
          content: Text(
            'Could not open external browser. Copy this link: $_resolvedUrl',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp),
          ),
        ),
      );
    }
  }

  void _retry() {
    setState(() {
      _loading = true;
      _loadFailed = false;
      _errorMessage = null;
      _progress = 0;
    });
    _loadClaimUrl();
  }

  Widget _buildErrorOverlay() {
    return Container(
      color: const Color(0xFF1F1F1F),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded,
              color: Colors.white54, size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            _errorTitle,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            _errorMessage ??
                'Please check your connection and try again.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white60,
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: _retry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          // Last-resort escape hatch: if the embedded webview can't
          // render at all (some providers reject WebView UAs / disable
          // mixed-content / block iframes), the system browser usually
          // can. Same URL the webview tried; this is the supported
          // workaround.
          if (_resolvedUrl.isNotEmpty)
            TextButton.icon(
              onPressed: _openInExternalBrowser,
              icon: Icon(Icons.open_in_new,
                  color: Colors.white70, size: 16.sp),
              label: Text(
                'Open in browser',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // Pin the sheet to 85% of the screen height (claim + renewal both)
    // so MyCover's hosted form has room to render without the user
    // having to scroll the sheet itself to reach the form fields. The
    // top padding stays clear of the system status bar so the drag
    // handle isn't pushed under the notch.
    return SizedBox(
      height: mq.size.height * 0.85,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: Container(
          color: const Color(0xFF1F1F1F),
          padding: EdgeInsets.only(top: mq.padding.top),
          child: Column(
            children: [
              // Drag handle so it feels native.
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              // Our header — keeps the user anchored in the LazerVault chrome.
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 8.w, 8.h),
                child: Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 78, 3, 208),
                            Color.fromARGB(255, 48, 0, 140),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(_headerIcon,
                          color: Colors.white, size: 18.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _headerTitle,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            widget.providerName != null && widget.providerName!.isNotEmpty
                                ? '${widget.policyLabel} · ${widget.providerName}'
                                : widget.policyLabel,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await _controller.canGoBack()) {
                          await _controller.goBack();
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: Colors.white70, size: 16.sp),
                      tooltip: 'Back',
                    ),
                    IconButton(
                      onPressed: () => _controller.reload(),
                      icon: Icon(Icons.refresh, color: Colors.white70, size: 18.sp),
                      tooltip: 'Reload',
                    ),
                    // Always-available escape hatch: open in the
                    // system browser. Useful when the embedded webview
                    // hangs or the hosted page disables certain JS
                    // features in WebView mode. Same URL, same flow.
                    IconButton(
                      onPressed: _resolvedUrl.isEmpty
                          ? null
                          : _openInExternalBrowser,
                      icon: Icon(Icons.open_in_new,
                          color: Colors.white70, size: 18.sp),
                      tooltip: 'Open in browser',
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.white70, size: 20.sp),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),
              // Loading bar — visible while MyCover boots their form.
              if (_loading || _progress < 100)
                LinearProgressIndicator(
                  value: _progress > 0 ? _progress / 100 : null,
                  minHeight: 2,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 78, 3, 208),
                  ),
                ),
              // The web view itself — or a retry overlay when the upstream
              // load failed (DNS, TLS, 4xx, 5xx). Without this the user
              // would just see a blank white area and have no path forward.
              Expanded(
                child: _loadFailed
                    ? _buildErrorOverlay()
                    : WebViewWidget(
                        controller: _controller,
                        // Vertical-drag recognizer so the claim page scrolls to
                        // its end inside the sheet (footer/actions reachable).
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                          Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer()),
                        },
                      ),
              ),
              // Footer disclaimer — anchored at the bottom so users know
              // what's happening when the upstream form does its thing.
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                color: const Color(0xFF0A0A0A),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: const Color(0xFF9CA3AF), size: 12.sp),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        _footerText,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 10.sp,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
