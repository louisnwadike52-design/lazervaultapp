import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Confirmation screen shown right after a claim is filed.
///
/// Previously filing a claim (uploading documents, entering details) ended in a
/// fleeting snackbar + an immediate pop — no acknowledgement of a significant
/// action. This gives the user a proper receipt: the claim number to reference,
/// what was filed, and what happens next. Self-contained (no cubit deps) so any
/// claim flow can route to it.
class InsuranceClaimConfirmationScreen extends StatelessWidget {
  final String claimNumber;
  final String status; // raw status, e.g. "submitted" / "under_review"
  final String claimType; // raw type, e.g. "death" / "disability"
  final String policyNumber;
  final String? amount; // formatted claim amount (already includes any symbol), optional

  const InsuranceClaimConfirmationScreen({
    super.key,
    required this.claimNumber,
    required this.status,
    required this.claimType,
    this.policyNumber = '',
    this.amount,
  });

  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _accent = Color(0xFF6366F1); // insurance indigo
  static const _success = Color(0xFF10B981);
  static const _textSecondary = Color(0xFF9CA3AF);

  static TextStyle _t({double? size, FontWeight? weight, Color? color, double? height, double? spacing}) =>
      GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color, height: height, letterSpacing: spacing);

  String get _prettyClaimType {
    final t = claimType.trim().toLowerCase();
    switch (t) {
      case 'death':
        return 'Death benefit';
      case 'disability':
      case 'permanent_disability':
        return 'Disability';
      case 'critical_illness':
        return 'Critical illness';
      case 'retrenchment':
        return 'Retrenchment';
      case '':
        return 'Claim';
      default:
        return t
            .split(RegExp(r'[_\s]+'))
            .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' ');
    }
  }

  String get _prettyStatus {
    final s = status.trim().toLowerCase().replaceAll('_', ' ');
    if (s.isEmpty || s == 'submitted' || s == 'pending') return 'Submitted';
    return s.split(' ').map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: _success.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(color: _success, shape: BoxShape.circle),
                            child: const Icon(Icons.check_rounded, color: Colors.white, size: 34),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Claim submitted',
                        textAlign: TextAlign.center,
                        style: _t(size: 22, weight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(
                      "We've received your claim and sent it to your insurer for review.",
                      textAlign: TextAlign.center,
                      style: _t(size: 13.5, color: _textSecondary, height: 1.45),
                    ),
                    const SizedBox(height: 20),
                    // Claim number pill
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: _accent.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: _accent.withValues(alpha: 0.4)),
                        ),
                        child: Text('Claim #$claimNumber',
                            style: _t(size: 14, weight: FontWeight.w700, color: const Color(0xFFB8BCFF))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Details card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _divider),
                      ),
                      child: Column(
                        children: [
                          _row('Claim type', _prettyClaimType),
                          if (policyNumber.trim().isNotEmpty) ...[
                            _sep(),
                            _row('Policy', policyNumber),
                          ],
                          if (amount != null && amount!.trim().isNotEmpty) ...[
                            _sep(),
                            _row('Amount claimed', amount!),
                          ],
                          _sep(),
                          _row('Status', _prettyStatus, valueColor: const Color(0xFFFB923C)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // What happens next
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: _divider),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('What happens next',
                              style: _t(size: 15, weight: FontWeight.w700, color: Colors.white)),
                          const SizedBox(height: 14),
                          _step(Icons.search_rounded, 'Your insurer reviews the claim',
                              'They may reach out if more information or documents are needed.'),
                          const SizedBox(height: 14),
                          _step(Icons.notifications_active_outlined, "We'll keep you posted",
                              'Track the status any time under My Claims — you\'ll get an update as it progresses.'),
                          const SizedBox(height: 14),
                          _step(Icons.account_balance_wallet_outlined, 'Payout on approval',
                              'If approved, the settlement is paid to your Lazervault wallet.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom CTA
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: _bg,
                border: Border(top: BorderSide(color: _divider)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Done', style: _t(size: 16, weight: FontWeight.w800, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label, style: _t(size: 13, color: _textSecondary))),
        const SizedBox(width: 12),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.right,
              style: _t(size: 13.5, weight: FontWeight.w600, color: valueColor ?? Colors.white)),
        ),
      ],
    );
  }

  Widget _sep() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Divider(height: 1, color: _divider),
      );

  Widget _step(IconData icon, String title, String body) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(color: _accent.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFFB8BCFF), size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _t(size: 13.5, weight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 2),
              Text(body, style: _t(size: 12, color: _textSecondary, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}
