import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart'
    as currency_formatter;
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/services/autosave_pdf_service.dart';
import 'package:lazervault/src/features/autosave/utils/autosave_trigger_labels.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/payment_receipt_shared.dart';
import 'package:lazervault/src/features/tag_pay/services/tag_pay_pdf_service.dart'
    show TagPayPdfService;

part 'autosave_rule_receipt_screen_widgets.dart';

/// Receipt for a just-created Auto-Save rule.
///
/// Reads the rule the SERVER returned (passed as `rule`), not the wizard's
/// input map — the backend can clamp an amount, apply the min-save floor or
/// normalise a schedule, and a receipt showing what you typed instead of what
/// was stored is worse than no receipt. The map is still used for the resolved
/// account NAMES, which the entity only holds as UUIDs.
///
/// Styled to match the send-funds receipt (status badge → hero → detail cards →
/// Download/Share) so every receipt in the app reads the same way, and shares
/// the same PDF/JPG/PNG export the money receipts offer.
class AutoSaveRuleReceiptScreen extends StatefulWidget {
  const AutoSaveRuleReceiptScreen({super.key});

  @override
  State<AutoSaveRuleReceiptScreen> createState() =>
      _AutoSaveRuleReceiptScreenState();
}

class _AutoSaveRuleReceiptScreenState extends State<AutoSaveRuleReceiptScreen> {
  Map<String, dynamic> _args = {};
  AutoSaveRuleEntity? _rule;
  bool _invalidArgs = false;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _args = Get.arguments as Map<String, dynamic>? ?? {};
    final passed = _args['rule'];
    if (passed is AutoSaveRuleEntity) _rule = passed;

    // This receipt is only meaningful straight after a rule was created. On a
    // blank / deep-link entry there is nothing to render, so route home rather
    // than paint an empty shell.
    if (_rule == null) {
      _invalidArgs = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Get.offAllNamed(AppRoutes.autoSaveDashboard);
      });
    }
  }

  String get _sourceLabel =>
      (_args['sourceAccountName'] as String?)?.trim().isNotEmpty == true
          ? _args['sourceAccountName'] as String
          : 'Source account';

  String get _destinationLabel =>
      (_args['destinationAccountName'] as String?)?.trim().isNotEmpty == true
          ? _args['destinationAccountName'] as String
          : 'Savings account';

  String _money(double v) =>
      currency_formatter.CurrencySymbols.formatAmountWithCurrency(
          v, _rule?.currency ?? 'NGN');

  // ── Export ──────────────────────────────────────────────────────────────

  Future<void> _download() async {
    final rule = _rule;
    if (rule == null || _isDownloading) return;
    final format = await pickReceiptFormat(context, action: 'Download');
    if (format == null || !mounted) return;
    setState(() => _isDownloading = true);
    try {
      final path = await AutoSavePdfService.downloadRuleReceipt(
        rule: rule,
        sourceAccountLabel: _sourceLabel,
        destinationAccountLabel: _destinationLabel,
        triggerDescription: rule.triggerDescription,
        amountDescription: rule.amountDescription,
        format: format,
      );
      _snack('Receipt saved', '${format.ext.toUpperCase()} saved to $path',
          ok: true);
    } catch (_) {
      _snack('Save failed', 'Could not save the receipt. Please try again.');
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _share() async {
    final rule = _rule;
    if (rule == null || _isSharing) return;
    // Capture the iOS popover anchor BEFORE the async gap so no BuildContext
    // is touched across it.
    final origin = TagPayPdfService.shareOriginFromContext(context);
    final format = await pickReceiptFormat(context, action: 'Share');
    if (format == null || !mounted) return;
    setState(() => _isSharing = true);
    try {
      await AutoSavePdfService.shareRuleReceipt(
        rule: rule,
        sourceAccountLabel: _sourceLabel,
        destinationAccountLabel: _destinationLabel,
        triggerDescription: rule.triggerDescription,
        amountDescription: rule.amountDescription,
        format: format,
        sharePositionOrigin: origin,
      );
    } catch (_) {
      _snack('Share failed', 'Could not share the receipt. Please try again.');
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  void _snack(String title, String body, {bool ok = false}) {
    Get.snackbar(
      title,
      body,
      backgroundColor:
          ok ? const Color(0xFF10B981) : const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.w),
    );
  }

  // ── Navigation ──────────────────────────────────────────────────────────

  void _toDashboard() => Get.offAllNamed(AppRoutes.autoSaveDashboard);

  /// Both ops run in THIS frame and the list enters WITHOUT animation: an
  /// animated push let the dashboard mount, fetch and PAINT for the slide's
  /// duration, which read as a flash between receipt and list.
  void _toRules() {
    Get.offAllNamed(AppRoutes.autoSaveDashboard);
    Get.toNamed(AppRoutes.autoSaveRulesList, preventDuplicates: false);
  }

  void _createAnother() {
    // Rebuild as dashboard → create so the wizard's Back has a real target;
    // offAllNamed alone left an empty stack and Back exited the feature.
    Get.offAllNamed(AppRoutes.autoSaveDashboard);
    Get.toNamed(AppRoutes.createAutoSaveRule);
  }

  @override
  Widget build(BuildContext context) {
    if (_invalidArgs || _rule == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: SizedBox.shrink(),
      );
    }
    final rule = _rule!;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _toDashboard();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _backBar(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      _hero(rule),
                      SizedBox(height: 16.h),
                      _detailsCard(rule),
                      SizedBox(height: 12.h),
                      _ctaCard(),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
              _actions(),
            ],
          ),
        ),
      ),
    );
  }
}
