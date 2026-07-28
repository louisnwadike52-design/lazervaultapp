import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:lazervault/core/services/help_config_service.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/webview_bottom_sheet.dart';

/// Implicit legal-consent line shown at the point of account creation on BOTH
/// signup flows (email/password and phone/passcode). Renders
/// "By tapping "{action}", you agree to our Terms & Conditions and Privacy
/// Policy." with the two documents as tappable links that open in the app's
/// themed webview bottom sheet.
///
/// URLs are admin-managed (keys `help_terms_url` / `help_privacy_url`) and read
/// from [HelpConfigService] — the same source Settings → Legal already uses, so
/// there is a single place an admin updates them. Falls back to the built-in
/// lazervault.app/legal/* URLs when the config hasn't loaded, so the links
/// always resolve to something valid (required for store review).
class LegalConsentText extends StatefulWidget {
  /// The CTA verb this line sits under, e.g. "Create account" or "Continue".
  final String action;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;

  const LegalConsentText({
    super.key,
    required this.action,
    this.textAlign = TextAlign.center,
    this.padding = EdgeInsets.zero,
  });

  @override
  State<LegalConsentText> createState() => _LegalConsentTextState();
}

class _LegalConsentTextState extends State<LegalConsentText> {
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _link = Color(0xFF3B82F6);

  final TapGestureRecognizer _termsTap = TapGestureRecognizer();
  final TapGestureRecognizer _privacyTap = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    // Best-effort refresh so the links point at the latest admin-set URLs.
    // Sync `config` already returns a valid (fallback) value meanwhile.
    HelpConfigService.instance.ensure().then((_) {
      if (mounted) setState(() {});
    });
    _termsTap.onTap = () => _open(
          HelpConfigService.instance.config.termsUrl,
          'Terms & Conditions',
        );
    _privacyTap.onTap = () => _open(
          HelpConfigService.instance.config.privacyUrl,
          'Privacy Policy',
        );
  }

  @override
  void dispose() {
    _termsTap.dispose();
    _privacyTap.dispose();
    super.dispose();
  }

  void _open(String url, String title) {
    if (!mounted || url.isEmpty) return;
    showWebViewBottomSheet(context, url: url, title: title);
  }

  @override
  Widget build(BuildContext context) {
    const base = TextStyle(
      color: _textSecondary,
      fontSize: 12,
      height: 1.4,
    );
    final linkStyle = base.copyWith(
      color: _link,
      fontWeight: FontWeight.w600,
    );
    return Padding(
      padding: widget.padding,
      child: Text.rich(
        TextSpan(
          style: base,
          children: [
            TextSpan(text: 'By tapping "${widget.action}", you agree to our '),
            TextSpan(text: 'Terms & Conditions', style: linkStyle, recognizer: _termsTap),
            const TextSpan(text: ' and '),
            TextSpan(text: 'Privacy Policy', style: linkStyle, recognizer: _privacyTap),
            const TextSpan(text: '.'),
          ],
        ),
        textAlign: widget.textAlign,
      ),
    );
  }
}
