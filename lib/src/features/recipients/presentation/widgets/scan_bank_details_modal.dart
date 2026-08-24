import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'scan_bank_details_modal_widgets.dart';


// Shared surface tokens — kept in lockstep with SendFundsAmountSheet so the
// scan sheet and the amount sheet it hands off to read as one flow.
const Color _purple = Color.fromARGB(255, 78, 3, 208);
const Color _card = Color(0xFFF3F4F6);
const Color _textSecondary = Color(0xFF6B7280);

// ── SmartScanResultSheet ────────────────────────────────────────────────────

class SmartScanResultSheet extends StatefulWidget {
  final SmartScanResult scanResult;
  final String country;

  const SmartScanResultSheet({
    super.key,
    required this.scanResult,
    this.country = 'NG',
  });

  /// Show the sheet. Returns a [ScanAction] or null if dismissed.
  static Future<ScanAction?> show(
    BuildContext context, {
    required SmartScanResult scanResult,
    String country = 'NG',
  }) {
    return showModalBottomSheet<ScanAction>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => SmartScanResultSheet(
        scanResult: scanResult,
        country: country,
      ),
    );
  }

  @override
  State<SmartScanResultSheet> createState() => _SmartScanResultSheetState();
}

class _SmartScanResultSheetState extends State<SmartScanResultSheet> {
  late TextEditingController _accountNumberController;
  final FocusNode _accountFocus = FocusNode();
  String? _selectedBankCode;
  String? _selectedBankName;
  bool _isVerifying = false;

  // For ambiguous: user's chosen resolution
  String? _disambiguatedType;

  // 1.5: Track whether AccountVerificationCubit is available in the tree
  bool _hasVerificationCubit = false;

  // Guidance shown when the user taps an always-active confirm button while a
  // required field is still missing. Instead of a dead, greyed-out button
  // (which left users confused — "why can't I tap Verify?"), the button stays
  // tappable and, on tap, we point at exactly what to fix (enter the account
  // number / pick the bank) and steer them there (focus the field / open the
  // bank picker). Cleared as soon as the missing detail is supplied.
  String? _validationHint;

  @override
  void initState() {
    super.initState();
    // Sanitize the OCR account number to digits up front. The digits-only input
    // formatter only guards TYPING — an OCR value with spaces/dashes (e.g.
    // "0801 234 5678") would otherwise fail the length check and read as invalid
    // even though it's a perfectly good account.
    _accountNumberController = TextEditingController(
      text: _digitsOnly(widget.scanResult.accountNumber ?? ''),
    );
    _selectedBankName = widget.scanResult.bankName;
    // Treat an empty/blank scanned code as "unresolved" so _bootstrap re-derives
    // it from the name. An empty-string code would otherwise slip past the
    // `!= null` Verify gate and be sent to the verifier as a blank bank code.
    final scannedCode = widget.scanResult.bankCode?.trim();
    _selectedBankCode =
        (scannedCode != null && scannedCode.isNotEmpty) ? scannedCode : null;
    // Warm the bank list, then resolve the bank code from the scanned name if
    // the OCR didn't provide one — so the prefilled sheet lands with a resolved
    // bank and the "Verify Account" CTA is ACTIVE (no manual bank re-pick, no
    // auto-verify: the user taps Verify themselves).
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await serviceLocator<BankRepository>().warmUp(widget.country);
    } catch (_) {/* offline — the synchronous cache / manual pick still works */}
    if (!mounted) return;
    // Now the bank list is warm, resolve the code from the scanned name so the
    // Verify CTA enables without the user re-picking the bank.
    if (_selectedBankCode == null && (_selectedBankName ?? '').isNotEmpty) {
      _resolveBankCode(_selectedBankName!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 1.5: Probe for AccountVerificationCubit in widget tree
    try {
      context.read<AccountVerificationCubit>();
      _hasVerificationCubit = true;
    } catch (_) {
      _hasVerificationCubit = false;
    }
  }

  void _resolveBankCode(String bankName) {
    final banks = serviceLocator<BankRepository>().cachedSync(widget.country);
    final match = _matchBank(bankName, banks);
    if (match != null) {
      setState(() {
        _selectedBankCode = match['code'];
        // Snap the label to the canonical list name so display + logo agree.
        _selectedBankName = match['name'];
      });
    }
  }

  /// Fuzzy-match a scanned bank name against the canonical list. OCR routinely
  /// yields abbreviations ("GTB", "UBA", "FCMB") or noisy names ("Access Bank
  /// Plc") that a plain two-way `contains` misses — leaving the Verify CTA dead
  /// even though a bank is clearly displayed. This normalises both sides (alias
  /// expansion + noise-word stripping) and scores candidates so the closest
  /// match wins.
  Map<String, String>? _matchBank(String scanned, List<Map<String, String>> banks) {
    if (banks.isEmpty) return null;
    final target = _canonicalBank(scanned);
    if (target.isEmpty) return null;

    Map<String, String>? best;
    int bestScore = 0;
    for (final bank in banks) {
      final name = bank['name'] ?? '';
      final cand = _canonicalBank(name);
      if (cand.isEmpty) continue;

      int score;
      if (cand == target) {
        score = 100;
      } else if (cand.contains(target) || target.contains(cand)) {
        // Closer lengths = a tighter match; penalise big length gaps so a short
        // token doesn't latch onto a much longer unrelated name.
        score = 70 - (cand.length - target.length).abs().clamp(0, 60);
      } else {
        final overlap = target
            .split(' ')
            .toSet()
            .intersection(cand.split(' ').toSet())
            .length;
        score = overlap > 0 ? 20 + overlap * 5 : 0;
      }
      if (score > bestScore) {
        bestScore = score;
        best = bank;
      }
    }
    // Require a meaningful match (shared token or better) — never guess.
    return bestScore >= 20 ? best : null;
  }

  /// Lowercase, expand common OCR abbreviations, then strip punctuation and
  /// generic banking noise words so only the distinctive tokens remain.
  String _canonicalBank(String raw) {
    var s = raw.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), ' ');
    const alias = <String, String>{
      'gtb': 'guaranty trust',
      'gt': 'guaranty trust',
      'gtbank': 'guaranty trust',
      'gtco': 'guaranty trust',
      'uba': 'united bank for africa',
      'fcmb': 'first city monument',
      'fbn': 'first',
      'stanbic': 'stanbic ibtc',
      // Fintech wallets + common OCR misreads → canonical single token so
      // "MoneyPoint" / "Monie" resolve to Moniepoint and the wallet names match.
      'moneypoint': 'moniepoint',
      'monie': 'moniepoint',
      'opay': 'opay',
      'palmpay': 'palmpay',
      'palm': 'palmpay',
      'kuda': 'kuda',
    };
    final expanded = s
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .map((t) => alias[t] ?? t)
        .join(' ');
    const noise = {
      'bank', 'plc', 'limited', 'ltd', 'nigeria', 'ng', 'microfinance',
      'mfb', 'the', 'of', 'and', 'company', 'co',
    };
    return expanded
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty && !noise.contains(t))
        .join(' ')
        .trim();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountFocus.dispose();
    super.dispose();
  }

  /// The resolved type — either user's disambiguation choice, or the original.
  /// 1.4: Only allow disambiguation to non-ambiguous types to prevent recursion.
  String get _effectiveType {
    final dt = _disambiguatedType;
    if (dt != null && dt != 'ambiguous') return dt;
    final base = widget.scanResult.extractionType;
    // A backend-resolved Lazervault user takes precedence over phone/email/
    // username/ambiguous — but NOT over real bank details (bank present →
    // external transfer, per product rule). Lets us offer a one-tap free
    // internal transfer.
    if (widget.scanResult.hasResolvedUser &&
        base != 'bank_details' &&
        FeatureFlags.scanResolveUsersIsEnabled) {
      return 'resolved_user';
    }
    return base;
  }

  @override
  Widget build(BuildContext context) {
    // 1.5: Conditionally wrap with BlocListener only if cubit is available.
    // Tapping anywhere on the sheet that isn't a field/button dismisses the
    // keyboard — while the user is editing an extracted field, a tap on empty
    // space closes the keyboard instead of leaving it stuck open.
    // Keyboard-aware: lift the whole sheet above the keyboard and cap its height
    // to the space that remains, so editing the account number can never bury
    // the Verify button behind the keyboard (the "account captured but can't tap
    // verify" report). Mirrors SendFundsAmountSheet's layout.
    final media = MediaQuery.of(context);
    final bottomInset = media.viewInsets.bottom;
    final available = media.size.height - media.padding.top - bottomInset - 24.h;
    final cap = media.size.height * 0.85;
    // Guard the pathological case (an enormous keyboard on a tiny viewport) so
    // the constraint can never go non-positive and assert.
    final maxSheetHeight = available <= 0
        ? cap
        : (available < cap ? available : cap);

    Widget content = GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
        constraints: BoxConstraints(
          maxHeight: maxSheetHeight,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHandle(),
              SizedBox(height: 16.h),
              _buildHeader(),
              SizedBox(height: 24.h),
              Flexible(
                child: SingleChildScrollView(
                  child: _buildBody(),
                ),
              ),
              SizedBox(height: 16.h),
              _buildActions(),
              SizedBox(height: media.padding.bottom + 8.h),
            ],
          ),
        ),
        ),
      ),
    );

    // Verification is now driven deterministically inside _onVerifyAccount
    // (await + pop), so no ambient BlocListener is needed here.
    return content;
  }

  // ── Handle bar ──────────────────────────────────────────────────────────

  // Drag handle centered with an explicit close (X) on the right — mirrors
  // SendFundsAmountSheet so the two sheets read as one flow, and gives a clear
  // way out even when the keyboard is up.
  Widget _buildHandle() => Row(
        children: [
          SizedBox(width: 22.sp),
          Expanded(
            child: Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.opaque,
            child: Icon(Icons.close_rounded, size: 22.sp, color: _textSecondary),
          ),
        ],
      );

  // ── Header ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    final (icon, title, subtitle) = switch (_effectiveType) {
      'bank_details' => (
        Icons.account_balance_outlined,
        'Bank Details Found',
        'Review and verify the extracted details',
      ),
      'resolved_user' => (
        Icons.verified_user_outlined,
        'Lazervault User',
        'Send instantly — free internal transfer',
      ),
      'internal_user' => (
        Icons.person_outline,
        'Lazervault User Found',
        'We detected a Lazervault username',
      ),
      'phone_number' => (
        Icons.phone_outlined,
        'Phone Number Found',
        'We detected a phone number',
      ),
      'email' => (
        Icons.email_outlined,
        'Email Found',
        'We detected an email address',
      ),
      'ambiguous' => (
        Icons.help_outline,
        'What Did We Find?',
        widget.scanResult.disambiguationHint ?? 'Please help us identify this',
      ),
      _ => (
        Icons.image_not_supported_outlined,
        'No Details Found',
        'Could not find payment details in this image',
      ),
    };

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: _purple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: _purple, size: 24.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              ),
            ],
          ),
        ),
        _buildConfidenceBadge(widget.scanResult.confidence),
      ],
    );
  }

  // ── Body: type-specific content ─────────────────────────────────────────

  Widget _buildBody() => switch (_effectiveType) {
        'resolved_user' => _buildResolvedUserBody(),
        'bank_details' => _buildBankDetailsBody(),
        'internal_user' => _buildInternalUserBody(),
        'phone_number' => _buildPhoneNumberBody(),
        'email' => _buildEmailBody(),
        'ambiguous' => _buildAmbiguousBody(),
        _ => _buildNoDataBody(),
      };

  // ── Resolved Lazervault user ────────────────────────────────────────────

  Widget _buildResolvedUserBody() {
    final r = widget.scanResult;
    final name = (r.resolvedDisplayName ?? '').trim().isNotEmpty
        ? r.resolvedDisplayName!.trim()
        : (r.resolvedUsername ?? r.displayName ?? 'Lazervault User');
    // What identifier matched — shown as a subtle secondary line.
    final matchedVia = (r.username ?? '').isNotEmpty
        ? '@${r.username}'
        : (r.phoneNumber ?? r.email ?? '');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _purple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _purple.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _purple.withValues(alpha: 0.12),
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: TextStyle(
                  color: _purple,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (matchedVia.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    matchedVia,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                  ),
                ],
                SizedBox(height: 6.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt, color: Colors.green[600], size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Free instant transfer',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Email ───────────────────────────────────────────────────────────────

  Widget _buildEmailBody() {
    final email = widget.scanResult.email ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Email Address'),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.email_outlined, color: Colors.grey[600], size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  email.isNotEmpty ? email : 'No email detected',
                  style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange[700], size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'No Lazervault user matched this email. Search by username or scan a bank account instead.',
                  style: TextStyle(color: Colors.orange[800], fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Bank Details ────────────────────────────────────────────────────────

  Widget _buildBankDetailsBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Account Number'),
        SizedBox(height: 8.h),
        TextField(
          controller: _accountNumberController,
          focusNode: _accountFocus,
          keyboardType: TextInputType.number,
          // 10-digit NUBAN, or the 11-digit phone that IS the account number for
          // OPay / PalmPay / Moniepoint wallets (matches the manual bank-entry
          // validator in add_recipient.dart).
          maxLength: 11,
          decoration: _inputDecoration(
            hint: 'Enter account number',
            icon: Icons.numbers_outlined,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          // Rebuild to refresh helper text; clear any "enter the account number"
          // guidance the moment the user starts supplying it.
          onChanged: (_) => setState(() {
            if (_validationHint != null &&
                _accountNumberController.text.isNotEmpty) {
              _validationHint = null;
            }
          }),
        ),
        SizedBox(height: 16.h),
        _buildFieldLabel('Bank'),
        SizedBox(height: 8.h),
        _buildBankSelector(),
        // When OCR couldn't resolve the bank (the common MoneyPoint / OPay /
        // PalmPay case), offer one-tap chips for the frequent fintech wallets so
        // the user isn't forced to open + search the full picker.
        if (_selectedBankCode == null) ...[
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final b in const ['OPay', 'PalmPay', 'Moniepoint', 'Kuda'])
                _quickBankChip(b),
            ],
          ),
        ],
        // Show hint only when the number is present but not a valid length.
        if (_accountNumberController.text.isNotEmpty &&
            !_accountLengthOk(_accountNumberController.text)) ...[
          SizedBox(height: 8.h),
          Text(
            'Account number should be 10 digits (or 11 for OPay/PalmPay) — you have ${_accountNumberController.text.length}',
            style: TextStyle(color: Colors.orange[700], fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 16.h),
        if (widget.scanResult.accountName != null &&
            widget.scanResult.accountName!.isNotEmpty) ...[
          _buildFieldLabel('Account Name (from scan)'),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.person_outline, color: Colors.grey[600], size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.scanResult.accountName!,
                    style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // ── Internal User ───────────────────────────────────────────────────────

  Widget _buildInternalUserBody() {
    final username = widget.scanResult.username;
    // 1.3: Handle null/empty username gracefully
    final hasUsername = username != null && username.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: _purple.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: _purple.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: _purple.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: _purple, size: 28.sp),
              ),
              SizedBox(height: 12.h),
              if (hasUsername)
                Text(
                  '@$username',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else
                Text(
                  'Username not detected',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (widget.scanResult.displayName != null &&
                  widget.scanResult.displayName!.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  widget.scanResult.displayName!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
              ],
            ],
          ),
        ),
        if (!hasUsername) ...[
          SizedBox(height: 12.h),
          Text(
            'The scan detected a Lazervault reference but could not read the username clearly. Try again with a clearer image.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ],
    );
  }

  // ── Phone Number ────────────────────────────────────────────────────────

  Widget _buildPhoneNumberBody() {
    final phone = widget.scanResult.phoneNumber;
    final carrier = widget.scanResult.phoneCarrier;
    // 1.2: Handle null/empty phone number
    final hasPhone = phone != null && phone.isNotEmpty;
    final isPhoneBank =
        carrier != null && ['opay', 'palmpay'].contains(carrier.toLowerCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.phone, color: Colors.blue, size: 28.sp),
              ),
              SizedBox(height: 12.h),
              if (hasPhone)
                Text(
                  phone,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                )
              else
                Text(
                  'Phone number not detected',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (carrier != null && carrier.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    carrier.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (isPhoneBank && hasPhone) ...[
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange[700], size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'This could be an ${carrier.substring(0, 1).toUpperCase()}${carrier.substring(1)} account number',
                    style: TextStyle(
                      color: Colors.orange[800],
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (!hasPhone) ...[
          SizedBox(height: 12.h),
          Text(
            'Could not read the phone number clearly. Try again with a clearer image.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ],
    );
  }

  // ── Ambiguous ───────────────────────────────────────────────────────────

  Widget _buildAmbiguousBody() {
    final types = widget.scanResult.possibleTypes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.scanResult.disambiguationHint != null &&
            widget.scanResult.disambiguationHint!.isNotEmpty) ...[
          Text(
            widget.scanResult.disambiguationHint!,
            style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
          ),
          SizedBox(height: 16.h),
        ],
        Text(
          'What is this?',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        if (types.contains('bank_details'))
          _buildDisambiguationOption(
            'bank_details',
            'Bank Account Number',
            Icons.account_balance_outlined,
          ),
        if (types.contains('phone_number'))
          _buildDisambiguationOption(
            'phone_number',
            'Phone Number (OPay / PalmPay)',
            Icons.phone_outlined,
          ),
        if (types.contains('internal_user'))
          _buildDisambiguationOption(
            'internal_user',
            'Lazervault Username',
            Icons.person_outline,
          ),
        // Fallback if possibleTypes is empty (shouldn't happen but handle it)
        if (types.isEmpty) ...[
          Text(
            'We found something but could not classify it. Please try again.',
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ],
    );
  }

  Widget _buildDisambiguationOption(String type, String label, IconData icon) {
    final selected = _disambiguatedType == type;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _disambiguatedType = type;
            // 1.1: When switching to bank_details, pre-fill account number
            // from whatever data we have (phone number or raw extracted number)
            if (type == 'bank_details') {
              final existing = _accountNumberController.text;
              if (existing.isEmpty) {
                // Try phone number as fallback
                final phone = widget.scanResult.phoneNumber ?? '';
                final local = phone.startsWith('234')
                    ? '0${phone.substring(3)}'
                    : phone;
                if (local.length == 10 &&
                    RegExp(r'^\d+$').hasMatch(local)) {
                  _accountNumberController.text = local;
                }
              }
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: selected ? _purple.withValues(alpha: 0.05) : Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected ? _purple : Colors.grey[200]!,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: selected ? _purple : Colors.grey[600], size: 22.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? _purple : Colors.black87,
                    fontSize: 15.sp,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle, color: _purple, size: 22.sp),
            ],
          ),
        ),
      ),
    );
  }

  // ── No Data ─────────────────────────────────────────────────────────────

  Widget _buildNoDataBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Icon(Icons.image_not_supported_outlined,
                  color: Colors.grey[400], size: 48.sp),
              SizedBox(height: 12.h),
              Text(
                'No payment details found',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Make sure the text is clearly visible and try with better lighting.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Action buttons ──────────────────────────────────────────────────────

  // 1.4: Use _effectiveType directly (not _buildAmbiguousActions calling
  // _buildActions) to guarantee no recursion.
  Widget _buildActions() => switch (_effectiveType) {
        'resolved_user' => _buildResolvedUserActions(),
        'bank_details' => _buildBankDetailsActions(),
        'internal_user' => _buildInternalUserActions(),
        'phone_number' => _buildPhoneNumberActions(),
        'email' => _buildEmailActions(),
        'ambiguous' => _buildAmbiguousActions(),
        _ => _buildNoDataActions(),
      };

  Widget _buildResolvedUserActions() {
    final r = widget.scanResult;
    final name = (r.resolvedDisplayName ?? '').trim().isNotEmpty
        ? r.resolvedDisplayName!.trim()
        : (r.resolvedUsername ?? 'user');
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(
                context,
                ScanAction(
                  type: ScanActionType.resolvedUserTransfer,
                  resolvedUserId: r.resolvedUserId,
                  resolvedAccountId: r.resolvedAccountId,
                  resolvedDisplayName: name,
                  username: r.resolvedUsername ?? r.username,
                  amountMinor: r.amountMinor,
                  description: r.description,
                ),
              );
            },
            icon: const Icon(Icons.send_rounded),
            label: Text('Send to $name',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        _buildScanAgainButton(),
      ],
    );
  }

  Widget _buildEmailActions() {
    return Column(
      children: [
        // Email never resolved (resolved emails are handled by the
        // 'resolved_user' path), so the only forward action is to scan again
        // or fall back to a manual search.
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(
                context,
                const ScanAction(type: ScanActionType.retryCapture),
              );
            },
            icon: const Icon(Icons.document_scanner_outlined),
            label: Text('Scan Again',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScanAgainButton() => SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {
            Navigator.pop(
              context,
              const ScanAction(type: ScanActionType.retryCapture),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: _purple,
            side: BorderSide(color: _purple),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text('Scan Again',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
        ),
      );

  Widget _buildBankDetailsActions() {
    // The Verify button is ALWAYS tappable (never greyed) except while a verify
    // is in-flight. If a required detail is missing, tapping surfaces a clear
    // "do this next" hint (see _onVerifyAccount) and steers the user to it —
    // instead of a dead button that leaves them wondering why it won't respond.
    return Column(
      children: [
        if (_validationHint != null) ...[
          _buildInlineHint(_validationHint!),
          SizedBox(height: 10.h),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isVerifying ? null : _onVerifyAccount,
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              disabledBackgroundColor: _purple.withValues(alpha: 0.6),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: _isVerifying
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LazerVaultLoader.small(),
                      SizedBox(width: 12.w),
                      Text('Verifying...', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    ],
                  )
                : Text('Verify Account', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildInternalUserActions() {
    final hasUsername = widget.scanResult.username != null &&
        widget.scanResult.username!.isNotEmpty;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            // 1.3: Disable if username is empty
            onPressed: hasUsername
                ? () {
                    Navigator.pop(
                      context,
                      ScanAction(
                        type: ScanActionType.internalTransfer,
                        username: widget.scanResult.username,
                        // Pre-fill amount/memo when OCR captured them
                        // (invoice → internal user route).
                        amountMinor: widget.scanResult.amountMinor,
                        description: widget.scanResult.description,
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.search),
            label: Text('Search User', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Always offer retry
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(
                context,
                const ScanAction(type: ScanActionType.retryCapture),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: _purple,
              side: BorderSide(color: _purple),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text('Scan Again', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberActions() {
    final hasPhone = widget.scanResult.phoneNumber != null &&
        widget.scanResult.phoneNumber!.isNotEmpty;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            // 1.2: Disable if phone number is empty
            onPressed: hasPhone
                ? () {
                    Navigator.pop(
                      context,
                      ScanAction(
                        type: ScanActionType.phoneTransfer,
                        phoneNumber: widget.scanResult.phoneNumber,
                        // Carry prefill through the phone-transfer
                        // branch too — same OCR result powers all
                        // three actions.
                        amountMinor: widget.scanResult.amountMinor,
                        description: widget.scanResult.description,
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.send),
            label: Text('Send via Phone Transfer', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        if (hasPhone) ...[
          SizedBox(height: 14.h),
          // A phone number is ALSO the account number for OPay / PalmPay /
          // Moniepoint wallets — but OCR can't tell which from the digits alone.
          // Offer one-tap resolution: pick the wallet and we jump straight to a
          // pre-filled, bank-selected Verify (no manual bank hunt). This is the
          // "it couldn't tell PalmPay from OPay and wouldn't let me pick" fix.
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Paying an OPay / PalmPay wallet?',
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp)),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _walletQuickChip('OPay')),
              SizedBox(width: 10.w),
              Expanded(child: _walletQuickChip('PalmPay')),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _useAsBankAccount(),
              icon: const Icon(Icons.account_balance_outlined),
              label: Text('Use as bank account (pick bank)',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: _purple,
                side: BorderSide(color: _purple),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
        if (!hasPhone) ...[
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  const ScanAction(type: ScanActionType.retryCapture),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: _purple,
                side: BorderSide(color: _purple),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Scan Again', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ],
    );
  }

  // 1.4: _buildAmbiguousActions no longer calls _buildActions() recursively.
  // When disambiguated, _effectiveType changes → _buildActions() dispatches
  // to the correct non-ambiguous handler directly.
  Widget _buildAmbiguousActions() {
    if (_disambiguatedType != null && _disambiguatedType != 'ambiguous') {
      // Disambiguation resolved — render the appropriate action directly
      return switch (_disambiguatedType!) {
        'bank_details' => _buildBankDetailsActions(),
        'internal_user' => _buildInternalUserActions(),
        'phone_number' => _buildPhoneNumberActions(),
        _ => _buildNoDataActions(),
      };
    }

    // Not yet disambiguated — disabled button
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Select an option above',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildNoDataActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Enter Manually',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                const ScanAction(type: ScanActionType.retryCapture),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  // ── Verify button handler ───────────────────────────────────────────────

  /// A valid destination account: 10-digit NUBAN, or the 11-digit phone that
  /// serves as the account number for OPay / PalmPay / Moniepoint wallets.
  /// Mirrors the manual bank-entry validator (add_recipient.dart) so the scan
  /// path accepts exactly what typing the account by hand would.
  bool _accountLengthOk(String v) =>
      v.length == 10 || (v.length == 11 && v.startsWith('0'));

  /// Strip everything but digits — used to clean OCR/phone values.
  String _digitsOnly(String v) => v.replaceAll(RegExp(r'[^0-9]'), '');

  Future<void> _onVerifyAccount() async {
    if (_isVerifying) return;

    // Validate on tap and STEER the user to whatever is missing, rather than
    // gating behind a disabled button. Each branch tells them what to do and
    // puts them where they can do it (focus the field / open the bank picker).
    final acct = _accountNumberController.text.trim();
    if (!_accountLengthOk(acct)) {
      setState(() => _validationHint = acct.isEmpty
          ? "Enter the recipient's account number"
          : 'Account number should be 10 digits (or 11 for OPay/PalmPay) — you have ${acct.length}');
      _accountFocus.requestFocus();
      return;
    }
    if (_selectedBankCode == null) {
      setState(() => _validationHint = "Select the recipient's bank to continue");
      // Open the picker immediately so the guidance is one tap from resolved
      // (the common OCR case: account read cleanly, bank logo/name didn't).
      _showBankPicker(serviceLocator<BankRepository>().cachedSync(widget.country));
      return;
    }
    if (!_hasVerificationCubit) {
      setState(() => _validationHint =
          'Account verification is unavailable right now. Please go back and try again.');
      return;
    }

    final cubit = context.read<AccountVerificationCubit>();
    setState(() {
      _validationHint = null;
      _isVerifying = true;
    });

    // Drive the outcome deterministically off the awaited result instead of an
    // ambient BlocListener state-*change*. A cache hit (same account verified
    // <30min ago, e.g. re-opening a scan from history) re-emits an identical
    // success that the listener could swallow — leaving the sheet stuck open
    // with no amount sheet. Awaiting the cubit and reading its terminal state
    // guarantees we always close + continue.
    try {
      await cubit.verifyAccount(
        bankCode: _selectedBankCode!,
        accountNumber: _accountNumberController.text,
        bankName: _selectedBankName ?? '',
        country: widget.country,
      );
    } catch (_) {
      // verifyAccount swallows its own errors into Failure states; this guards
      // against an unexpected throw so the spinner never sticks.
    }

    if (!mounted) return;
    final state = cubit.state;
    setState(() => _isVerifying = false);

    if (state is AccountVerificationSuccess) {
      Navigator.pop(
        context,
        ScanAction(
          type: ScanActionType.bankTransfer,
          accountNumber: state.accountNumber,
          accountName: state.accountName,
          bankName: state.bankName,
          bankCode: state.bankCode,
          // Carry OCR-extracted amount + memo through so the send-funds amount
          // + reference fields can pre-fill.
          amountMinor: widget.scanResult.amountMinor,
          description: widget.scanResult.description,
        ),
      );
    } else if (state is AccountVerificationFailure) {
      Get.snackbar(
        'Verification Failed',
        state.userMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  // ── Shared widgets ──────────────────────────────────────────────────────

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Switch a detected phone number into the bank-details flow, using the phone
  /// as the account number (OPay/PalmPay/Moniepoint wallets are addressed by
  /// phone). Optionally pre-select the wallet's bank so the user lands one tap
  /// from Verify. Never moves money — the NIP name-enquiry + PIN still gate.
  void _useAsBankAccount({String? presetBankName}) {
    final raw = widget.scanResult.phoneNumber ?? '';
    var local = _digitsOnly(raw);
    if (local.startsWith('234')) local = '0${local.substring(3)}';
    setState(() {
      _disambiguatedType = 'bank_details';
      if (local.isNotEmpty) _accountNumberController.text = local;
      if (presetBankName != null) _selectedBankName = presetBankName;
      _validationHint = null;
    });
    // Resolve against the canonical list so the code + logo line up; if the list
    // is cold this is a no-op and the user still picks the bank (name already
    // shows, and the picker self-heals a cold list).
    if (presetBankName != null) _resolveBankCode(presetBankName);
  }

  /// One-tap wallet selector chip (OPay / PalmPay) for the phone flow.
  Widget _walletQuickChip(String bankName) {
    return GestureDetector(
      onTap: () => _useAsBankAccount(presetBankName: bankName),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _purple.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _purple.withValues(alpha: 0.25)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BankLogo(bankName: bankName, country: widget.country, size: 20, borderRadius: 5),
            SizedBox(width: 8.w),
            Text(bankName,
                style: TextStyle(
                    color: _purple, fontSize: 14.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  /// Select a bank by name from a quick chip (bank-details flow) — resolves the
  /// code against the warm list; if the list is cold the name still shows and
  /// Verify steers to the picker.
  void _selectBankByName(String name) {
    setState(() {
      _selectedBankName = name;
      _validationHint = null;
    });
    _resolveBankCode(name);
  }

  /// Compact one-tap bank chip for the bank-details body's "common fintechs" row.
  Widget _quickBankChip(String bankName) {
    return GestureDetector(
      onTap: () => _selectBankByName(bankName),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _purple.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _purple.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BankLogo(bankName: bankName, country: widget.country, size: 18, borderRadius: 4),
            SizedBox(width: 6.w),
            Text(bankName,
                style: TextStyle(
                    color: _purple, fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  /// Actionable guidance shown above a confirm button when the user taps it
  /// with something still missing. Amber (a nudge, not a hard error) with an
  /// arrow to read as "do this next".
  Widget _buildInlineHint(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_upward_rounded, color: Colors.orange[800], size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.orange[900],
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceBadge(double confidence) {
    final percent = (confidence * 100).round();
    final color = confidence >= 0.8
        ? Colors.green
        : confidence >= 0.5
            ? Colors.orange
            : Colors.red;
    final icon = confidence >= 0.8
        ? Icons.check_circle
        : confidence >= 0.5
            ? Icons.warning_amber_rounded
            : Icons.error_outline;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            '$percent%',
            style: TextStyle(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: _card,
      hintText: hint,
      hintStyle: TextStyle(color: _textSecondary),
      prefixIcon: Icon(icon, color: _textSecondary),
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey[200]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: _purple, width: 2),
      ),
    );
  }

  Widget _buildBankSelector() {
    final banks = serviceLocator<BankRepository>().cachedSync(widget.country);

    return GestureDetector(
      onTap: () => _showBankPicker(banks),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            // Show the real bank image as soon as a name is present — BankLogo
            // resolves its asset from the name (or code) and falls back to a
            // branded gradient tile, so we never show the generic placeholder
            // once a bank is picked/scanned, even before the code resolves.
            if ((_selectedBankName ?? '').trim().isNotEmpty ||
                _selectedBankCode != null)
              BankLogo(
                bankName: _selectedBankName ?? '',
                bankCode: _selectedBankCode,
                country: widget.country,
                size: 28,
                borderRadius: 6,
              )
            else
              Icon(Icons.account_balance_outlined,
                  color: Colors.grey[600], size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _selectedBankName ?? 'Select bank',
                style: TextStyle(
                  color: _selectedBankName != null
                      ? Colors.black87
                      : Colors.grey[500],
                  fontSize: 15.sp,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  void _showBankPicker(List<Map<String, String>> banks) {
    final searchController = TextEditingController();
    List<Map<String, String>> available = List.from(banks);
    List<Map<String, String>> filtered = List.from(available);
    bool loading = false;

    void applyFilter() {
      final q = searchController.text.toLowerCase();
      filtered = q.isEmpty
          ? List.from(available)
          : available
              .where((b) => (b['name'] ?? '').toLowerCase().contains(q))
              .toList();
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setPickerState) {
            // Self-heal a cold/offline list so the picker is NEVER a dead, empty
            // sheet — the exact trap the auto-open-on-missing-bank path could
            // otherwise fall into. Fetch on open (and on Retry), then re-filter.
            Future<void> ensureBanks() async {
              if (available.isNotEmpty || loading) return;
              setPickerState(() => loading = true);
              try {
                await serviceLocator<BankRepository>().warmUp(widget.country);
              } catch (_) {/* stays empty → empty-state + Retry below */}
              final fresh =
                  serviceLocator<BankRepository>().cachedSync(widget.country);
              if (!mounted) return;
              setPickerState(() {
                available = List.from(fresh);
                applyFilter();
                loading = false;
              });
            }

            if (available.isEmpty && !loading) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => ensureBanks());
            }

            final kbd = MediaQuery.of(ctx).viewInsets.bottom;
            return Padding(
              padding: EdgeInsets.only(bottom: kbd),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: TextField(
                        controller: searchController,
                        decoration: _inputDecoration(
                          hint: 'Search banks...',
                          icon: Icons.search,
                        ),
                        onChanged: (_) => setPickerState(applyFilter),
                      ),
                    ),
                    Expanded(
                      child: loading
                          ? Center(child: LazerVaultLoader.small())
                          : available.isEmpty
                              ? _bankPickerEmptyState(ensureBanks)
                              : filtered.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No banks match "${searchController.text}"',
                                        style: TextStyle(
                                            color: _textSecondary,
                                            fontSize: 13.sp),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: filtered.length,
                                      itemBuilder: (ctx, index) {
                                        final bank = filtered[index];
                                        return ListTile(
                                          leading: BankLogo(
                                            bankName: bank['name'] ?? '',
                                            bankCode: bank['code'],
                                            country: widget.country,
                                            size: 36,
                                            borderRadius: 8,
                                          ),
                                          title: Text(
                                            bank['name'] ?? '',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _selectedBankCode = bank['code'];
                                              _selectedBankName = bank['name'];
                                              _validationHint = null;
                                            });
                                            Navigator.pop(ctx);
                                          },
                                        );
                                      },
                                    ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(searchController.dispose);
  }

  /// Empty-state for the bank picker when the list couldn't be loaded (offline
  /// at open) — with a Retry that re-attempts the warm-up.
  Widget _bankPickerEmptyState(Future<void> Function() onRetry) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, color: Colors.grey[400], size: 40.sp),
            SizedBox(height: 12.h),
            Text(
              "Couldn't load the bank list",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.h),
            Text(
              'Check your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 12.sp),
            ),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh, size: 18.sp),
              label: const Text('Retry'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _purple,
                side: BorderSide(color: _purple),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
