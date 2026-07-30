import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/src/features/autosave/services/autosave_pdf_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_management_bottomsheet.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/mandate_health_banner.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class AutoSaveRuleDetailsScreen extends StatefulWidget {
  const AutoSaveRuleDetailsScreen({super.key});

  @override
  State<AutoSaveRuleDetailsScreen> createState() => _AutoSaveRuleDetailsScreenState();
}

class _AutoSaveRuleDetailsScreenState extends State<AutoSaveRuleDetailsScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  late AutoSaveRuleEntity rule;
  bool _isTogglingRule = false;
  bool _isDeletingRule = false;
  bool _isTriggeringRule = false;
  String? _sourceAccountName;
  String? _destinationAccountName;

  bool _invalidArgs = false;

  @override
  void initState() {
    super.initState();
    // Guard against a deep-link / blank entry with no (or wrong-typed) args —
    // the old hard cast crashed the whole screen. Bail to the autosave home.
    final args = Get.arguments;
    if (args is! AutoSaveRuleEntity) {
      _invalidArgs = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) Get.offAllNamed(AppRoutes.autoSaveDashboard);
      });
      return;
    }
    rule = args;
    _fetchAccountNames();
    _fetchMandateHealth();
  }

  /// Whether this rule pulls from a Mono-linked bank via a Direct Debit mandate
  /// (bank inflow), as opposed to a wallet-sourced rule.
  bool get _isLinkedBankRule =>
      (rule.triggerType == TriggerType.externalInflow ||
          rule.triggerType == TriggerType.scheduledExternal) &&
      rule.sourceLinkedAccountId.isNotEmpty;

  String get _userId =>
      context.read<AuthenticationCubit>().userId ?? '';

  /// Load the mandate status for a linked-bank rule so the health banner (and
  /// the manual-save pre-check) can tell whether the Direct Debit can still
  /// pull. No-op for wallet-sourced rules.
  void _fetchMandateHealth() {
    if (!_isLinkedBankRule) return;
    final userId = _userId;
    if (userId.isEmpty) return;
    serviceLocator<MandateCubit>().fetchUserMandates(userId: userId);
  }

  Future<void> _fetchAccountNames() async {
    // Look up real account names from AccountCardsSummaryCubit
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final source = accountState.accountSummaries.where(
        (a) => a.id.toString() == rule.sourceAccountId,
      );
      final dest = accountState.accountSummaries.where(
        (a) => a.id.toString() == rule.destinationAccountId,
      );
      setState(() {
        _sourceAccountName = source.isNotEmpty
            ? '${source.first.accountType} (****${source.first.accountNumberLast4})'
            : _truncateId(rule.sourceAccountId);
        _destinationAccountName = dest.isNotEmpty
            ? '${dest.first.accountType} (****${dest.first.accountNumberLast4})'
            : _truncateId(rule.destinationAccountId);
      });
    } else {
      setState(() {
        _sourceAccountName = _truncateId(rule.sourceAccountId);
        _destinationAccountName = _truncateId(rule.destinationAccountId);
      });
    }
  }

  String _truncateId(String id) {
    if (id.length >= 8) {
      return 'Account ${id.substring(0, 8)}...';
    }
    return 'Account $id';
  }

  void _showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    required Color confirmColor,
    required String confirmText,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: TextButton.styleFrom(
                backgroundColor: confirmColor.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text(
                  confirmText,
                  style: GoogleFonts.inter(
                    color: confirmColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleRule() {
    final action = rule.isActive ? 'pause' : 'resume';
    final actionText = rule.isActive ? 'Pause' : 'Resume';

    _showConfirmationDialog(
      title: '$actionText Rule',
      message: rule.isActive
          ? 'Are you sure you want to pause this auto-save rule? No automatic savings will occur while paused.'
          : 'Are you sure you want to resume this auto-save rule? Automatic savings will restart immediately.',
      confirmColor: rule.isActive ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
      confirmText: actionText,
      onConfirm: () {
        setState(() => _isTogglingRule = true);
        context.read<AutoSaveCubit>().toggleRuleOptimistic(
          ruleId: rule.id,
          action: action,
        );
      },
    );
  }

  void _deleteRule() {
    _showConfirmationDialog(
      title: 'Delete Rule',
      message: 'Are you sure you want to delete this auto-save rule? This action cannot be undone. All transaction history will be preserved.',
      confirmColor: const Color(0xFFEF4444),
      confirmText: 'Delete',
      onConfirm: () {
        setState(() => _isDeletingRule = true);
        context.read<AutoSaveCubit>().deleteRule(ruleId: rule.id);
      },
    );
  }

  void _triggerManualSave() async {
    HapticFeedback.mediumImpact();

    // Linked-bank rules pull via a Direct Debit mandate. If it has lapsed there
    // is nothing to debit — firing the save would just fail on the backend
    // ("mandate not ready"). Catch it here and open the re-authorization sheet
    // instead of charging into a doomed save.
    if (_isLinkedBankRule && !await _ensureMandateReadyForManualSave()) {
      return;
    }

    // A manual "save now" needs an explicit Naira amount. A percentage rule
    // saves a % of an INFLOW; there's no inflow on a manual tap, so the
    // backend rejects it without a custom amount. A fixed rule has a natural
    // default (its per-trigger amount) but we still let the user adjust it.
    // Collect the amount up front so the PIN sheet confirms the real figure
    // and the trigger never fails with "a custom amount is required".
    final saveAmount = await _promptManualSaveAmount();
    if (saveAmount == null || !mounted) return; // cancelled / unmounted

    final idPrefix = rule.id.length >= 8 ? rule.id.substring(0, 8) : rule.id;
    final transactionId = 'AUTOSAVE-$idPrefix';

    // A linked-bank manual save PULLS from the bank via a Direct Debit mandate,
    // which incurs a provider fee (aggregated Mono + LazerVault platform fee),
    // NETTED from the pulled amount. Quote it so the confirmation shows the fee
    // and the net that will actually land in the goal — the user knows exactly
    // what a direct debit costs before paying (same model as the deposit flow).
    double feeNaira = 0;
    double netNaira = saveAmount;
    if (_isLinkedBankRule) {
      try {
        final quote = await serviceLocator<OpenBankingCubit>()
            .depositFeeQuote((saveAmount * 100).round());
        if (quote != null) {
          feeNaira = quote.fee;
          netNaira = quote.netAmount;
        }
      } catch (_) {
        // Quote unavailable — proceed; the backend still nets the fee and the
        // net is recorded. Don't block the save on a transient quote failure.
      }
      if (!mounted) return;
    }

    final amtStr = currency_formatter.CurrencySymbols.formatAmountWithCurrency(saveAmount, rule.currency);
    final confirmMessage = feeNaira > 0
        ? 'Save $amtStr from your bank by direct debit. A fee of '
            '${currency_formatter.CurrencySymbols.formatAmountWithCurrency(feeNaira, rule.currency)} applies — '
            '${currency_formatter.CurrencySymbols.formatAmountWithCurrency(netNaira, rule.currency)} will be added to your goal.'
        : 'Save $amtStr now';

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'autosave_trigger',
      amount: saveAmount,
      // For a linked-bank pull, surface the aggregated direct-debit fee + the
      // amount actually leaving the bank so the PIN sheet shows the real cost.
      fee: _isLinkedBankRule && feeNaira > 0 ? feeNaira : null,
      totalAmount: _isLinkedBankRule ? saveAmount : null,
      currency: rule.currency,
      title: 'Confirm Manual Save',
      message: confirmMessage,
      // The actual save runs AFTER the sheet closes (via the cubit), so don't
      // let the sheet declare "Transaction Successful!" prematurely — that was
      // showing success even when the trigger then failed. Verify the PIN,
      // close, and let the screen surface the real outcome.
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;

    setState(() => _isTriggeringRule = true);

    if (!mounted) return;
    context.read<AutoSaveCubit>().triggerSave(
      ruleId: rule.id,
      transactionPinToken: verificationToken!,
      customAmount: saveAmount,
    );
  }

  /// Pre-flight for a manual save on a linked-bank rule: confirm the Direct
  /// Debit mandate is still debitable. If not, surface a prompt and open the
  /// re-authorization sheet, then re-check. Returns true only when the save may
  /// proceed (mandate active); false aborts so the user can re-authorize first.
  Future<bool> _ensureMandateReadyForManualSave() async {
    final userId = _userId;
    final cubit = serviceLocator<MandateCubit>();
    if (userId.isNotEmpty) {
      await cubit.fetchUserMandates(userId: userId);
    }
    if (!mounted) return false;

    MandateEntity? mandate =
        cubit.getMandateForAccount(rule.sourceLinkedAccountId);
    if (mandate != null && mandate.isActive) return true;

    final bank =
        rule.sourceBankName.isNotEmpty ? rule.sourceBankName : 'your linked bank';
    final goSetup = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        title: Text(
          'Direct Debit not active',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'This save pulls from $bank, but its Direct Debit isn\'t active right '
          'now. Set it up again to save from this bank.',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFB923C),
              foregroundColor: Colors.white,
            ),
            child: Text('Set up Direct Debit',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
    if (goSetup != true || !mounted) return false;

    await showMandateManagementBottomSheet(
      context: context,
      linkedAccountId: rule.sourceLinkedAccountId,
      userId: userId,
      bankName: bank,
      accountName: bank,
      mandate: mandate,
    );
    if (userId.isNotEmpty) {
      await cubit.fetchUserMandates(userId: userId);
    }
    if (!mounted) return false;
    // Only continue the save if the mandate is now actually debitable; NIBSS
    // activation can lag, so otherwise let the user tap Save again later.
    mandate = cubit.getMandateForAccount(rule.sourceLinkedAccountId);
    return mandate != null && mandate.isActive;
  }

  /// Bottom sheet that collects the Naira amount for a manual "save now".
  /// Required for percentage rules (no inflow to take a % of); pre-filled with
  /// the per-trigger amount for fixed rules. Returns the amount in Naira, or
  /// null if the user dismisses.
  Future<double?> _promptManualSaveAmount() async {
    final isPercentage = rule.amountType == AmountType.percentage;
    final symbol = currency_formatter.CurrencySymbols.getSymbol(rule.currency);
    final controller = TextEditingController(
      text: isPercentage ? '' : rule.amountValue.toStringAsFixed(2),
    );

    return showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String? errorText;
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            void submit() {
              final parsed = double.tryParse(controller.text.trim());
              if (parsed == null || parsed <= 0) {
                setSheetState(() => errorText = 'Enter a valid amount');
                return;
              }
              Navigator.of(ctx).pop(parsed);
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'How much to save?',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      isPercentage
                          ? 'This rule saves a percentage of incoming deposits. There\'s no deposit right now, so enter the amount to save manually.'
                          : 'Confirm or adjust the amount to save into ${rule.name} now.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      onSubmitted: (_) => submit(),
                      decoration: InputDecoration(
                        prefixText: '$symbol ',
                        prefixStyle: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        hintText: '0.00',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        errorText: errorText,
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 78, 3, 208),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEF4444)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(color: Color(0xFFEF4444)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _duplicateRule() {
    // Navigate to create screen with pre-filled data
    Get.toNamed(
      AppRoutes.createAutoSaveRule,
      arguments: {'duplicateFrom': rule},
    )?.then((_) {
      if (!mounted) return;
      Navigator.pop(context);
    });
  }

  Future<void> _exportRule() async {
    // Build a proper PDF (the previous text-only share leaked details
    // verbatim into the share intent and was hard to archive). The
    // service captures every rule field + the recent transactions
    // already loaded in state — same data the screen renders.
    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(SnackBar(
      content: Row(
        children: [
          LazerVaultLoader.tiny(),
          SizedBox(width: 12.w),
          const Text('Building PDF...'),
        ],
      ),
      duration: const Duration(seconds: 2),
    ));
    // Anchor the iOS/iPad share sheet to this screen — SharePlus THROWS on
    // iPad when a file share has no popover origin (the raw PlatformException
    // was surfaced verbatim before). Captured BEFORE the async PDF build so we
    // never touch `context` across the await. Harmless on phones/Android.
    final box = context.findRenderObject() as RenderBox?;
    final origin = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : null;
    try {
      final file = await AutoSavePdfService.generateRuleDetails(
        rule: rule,
        sourceAccountLabel:
            _sourceAccountName ?? rule.sourceAccountId,
        destinationAccountLabel:
            _destinationAccountName ?? rule.destinationAccountId,
        triggerDescription: _getTriggerDescription(),
        amountDescription: _getAmountDescription(),
        // The detail screen doesn't currently page in transactions —
        // the All Rules screen owns that history. Skip the table when
        // we don't have the data; the PDF still surfaces every rule
        // field + lifetime aggregates.
        recentTransactions: const [],
      );
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: 'Auto-Save Rule: ${rule.name}',
          text: 'Auto-save rule report: ${rule.name}',
          sharePositionOrigin: origin,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(
        content: const Text('Could not share the report. Please try again.'),
        backgroundColor: const Color(0xFFEF4444),
      ));
    }
  }

  void _navigateToEdit() {
    Get.toNamed(
      AppRoutes.editAutoSaveRule,
      arguments: rule,
    )?.then((_) {
      if (!mounted) return;
      // Refresh data when returning from edit screen
      context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
    });
  }

  void _viewTransactions() {
    // Single canonical history surface — All Rules. Completed /
    // cancelled rules are filterable from the same screen, so a
    // dedicated transactions page would duplicate functionality.
    Get.toNamed(AppRoutes.autoSaveRulesList);
  }

  void _navigateBack() {
    Get.back();
  }

  String _getTriggerDescription() {
    switch (rule.triggerType) {
      case TriggerType.onDeposit:
        return 'On Deposit';
      case TriggerType.scheduled:
        final frequency = rule.frequency;
        switch (frequency) {
          case ScheduleFrequency.daily:
            return 'Daily at ${rule.scheduleTime ?? "N/A"}';
          case ScheduleFrequency.weekly:
            return 'Weekly on ${_getDayName(rule.scheduleDay)} at ${rule.scheduleTime ?? "N/A"}';
          case ScheduleFrequency.biweekly:
            return 'Bi-Weekly at ${rule.scheduleTime ?? "N/A"}';
          case ScheduleFrequency.monthly:
            return 'Monthly on day ${rule.scheduleDay ?? "N/A"} at ${rule.scheduleTime ?? "N/A"}';
          default:
            return 'Scheduled';
        }
      case TriggerType.roundUp:
        return 'Round Up to ${currency_formatter.CurrencySymbols.formatAmountWithCurrency((rule.roundUpTo ?? 0).toDouble(), rule.currency)}';
      case TriggerType.externalInflow:
        return rule.sourceBankName.isNotEmpty
            ? 'Bank Inflow from ${rule.sourceBankName}'
            : 'Bank Inflow';
      case TriggerType.scheduledExternal:
        final where = rule.sourceBankName.isNotEmpty
            ? rule.sourceBankName
            : 'linked bank';
        final freq = rule.frequency;
        String freqText;
        switch (freq) {
          case ScheduleFrequency.daily:
            freqText = 'Daily';
            break;
          case ScheduleFrequency.weekly:
            freqText = 'Weekly on ${_getDayName(rule.scheduleDay)}';
            break;
          case ScheduleFrequency.biweekly:
            freqText = 'Bi-Weekly';
            break;
          case ScheduleFrequency.monthly:
            freqText = 'Monthly on day ${rule.scheduleDay ?? "N/A"}';
            break;
          default:
            freqText = 'Scheduled';
        }
        return '$freqText standing order from $where at ${rule.scheduleTime ?? "N/A"}';
      default:
        return 'Unknown';
    }
  }

  String _getDayName(int? day) {
    if (day == null) return 'N/A';
    const days = ['', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return day >= 1 && day <= 7 ? days[day] : 'N/A';
  }

  String _getAmountDescription() {
    if (rule.amountType == AmountType.fixed) {
      return currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.amountValue, rule.currency);
    } else {
      return '${rule.amountValue.toStringAsFixed(0)}% of deposit';
    }
  }

  @override
  Widget build(BuildContext context) {
    // No valid rule (bad/blank args) — render a placeholder while the
    // post-frame callback in initState routes back home. Never touch `rule`.
    if (_invalidArgs) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: SizedBox.shrink(),
      );
    }
    return BlocListener<AutoSaveCubit, AutoSaveState>(
      listener: (context, state) {
        if (state is AutoSaveRuleToggleSuccess) {
          setState(() {
            _isTogglingRule = false;
            rule = state.rule;
          });

          Get.snackbar(
            'Success',
            rule.isActive ? 'Rule resumed successfully' : 'Rule paused successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        } else if (state is AutoSaveRuleUpdated) {
          setState(() {
            _isTogglingRule = false;
            rule = state.rule;
          });

          Get.snackbar(
            'Success',
            'Rule updated successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        } else if (state is AutoSaveRuleDeleted || state is AutoSaveRuleDeleteSuccess) {
          setState(() => _isDeletingRule = false);

          Get.snackbar(
            'Success',
            'Rule deleted successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );

          // Fixed: Just pop instead of clearing entire stack
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        } else if (state is AutoSaveTransactionTriggered) {
          setState(() => _isTriggeringRule = false);

          Get.snackbar(
            'Success',
            'Manual save triggered successfully for ${state.transaction.formattedAmount}',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );

          // Refresh rule data to show updated totalSaved
          context.read<AutoSaveCubit>().getRulesWithCache(forceRefresh: true);
        } else if (state is AutoSaveError) {
          setState(() {
            _isTogglingRule = false;
            _isDeletingRule = false;
            _isTriggeringRule = false;
          });

          // Map backend executor strings to user-friendly copy.
          // The autosave executor returns reasons verbatim ("debit
          // rejected: insufficient funds", "savings goal already
          // reached", etc.); these are clear to engineers but
          // unfriendly in a snackbar. Falls back to the raw message
          // for unmatched cases so we never swallow useful detail.
          final friendly = _humaniseAutosaveError(state.message);
          Get.snackbar(
            friendly.title,
            friendly.body,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 4),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1F1F1F),
                const Color(0xFF0A0A0A),
                const Color(0xFF000000),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildStatusCard(),
                        SizedBox(height: 20.h),
                        if (_isLinkedBankRule)
                          MandateHealthBanner(rule: rule, userId: _userId),
                        _buildRuleInfoCard(),
                        SizedBox(height: 20.h),
                        _buildAccountsCard(),
                        SizedBox(height: 20.h),
                        _buildLimitsCard(),
                        SizedBox(height: 20.h),
                        _buildStatisticsCard(),
                        SizedBox(height: 20.h),
                        _buildActionsCard(),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          IconButton(
            onPressed: _navigateBack,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (rule.description.isNotEmpty)
                  Text(
                    rule.description,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          // Edit button
          IconButton(
            onPressed: _navigateToEdit,
            icon: Icon(
              Icons.edit,
              color: const Color.fromARGB(255, 78, 3, 208),
              size: 20.sp,
            ),
            tooltip: 'Edit Rule',
          ),
          // More options menu
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white, size: 20.sp),
            color: const Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            onSelected: (value) {
              if (value == 'duplicate') {
                _duplicateRule();
              } else if (value == 'export') {
                _exportRule();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 18.sp, color: Colors.white),
                    SizedBox(width: 12.w),
                    Text(
                      'Duplicate Rule',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 18.sp, color: Colors.white),
                    SizedBox(width: 12.w),
                    Text(
                      'Export Details',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    final statusColor = rule.isActive
        ? const Color(0xFF10B981)
        : rule.isPaused
            ? const Color(0xFFF59E0B)
            : const Color(0xFF6B7280);

    final statusText = rule.isActive
        ? 'Active'
        : rule.isPaused
            ? 'Paused'
            : rule.status.toString().split('.').last.toUpperCase();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
              boxShadow: [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Status: $statusText',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (rule.hasReachedGoal)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFF10B981),
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Goal Reached',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRuleInfoCard() {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Rule Information',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDetailRow('Rule ID', rule.id),
          SizedBox(height: 12.h),
          _buildDetailRow('Trigger Type', _getTriggerDescription()),
          SizedBox(height: 12.h),
          _buildDetailRow('Save Amount', _getAmountDescription()),
          SizedBox(height: 12.h),
          _buildDetailRow('Created', dateFormat.format(rule.createdAt)),
          if (rule.lastTriggeredAt != null) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Last Triggered', dateFormat.format(rule.lastTriggeredAt!)),
          ],
        ],
      ),
    );
  }

  Widget _buildAccountsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Accounts',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDetailRow('Source Account', _sourceAccountName ?? rule.sourceAccountId),
          SizedBox(height: 12.h),
          _buildDetailRow('Destination Account', _destinationAccountName ?? rule.destinationAccountId),
        ],
      ),
    );
  }

  Widget _buildLimitsCard() {
    final hasLimits = rule.targetAmount != null ||
        rule.minimumBalance != null ||
        rule.maximumPerSave != null;

    if (!hasLimits) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Goals & Limits',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          if (rule.targetAmount != null) ...[
            _buildDetailRow(
              'Target Amount',
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.targetAmount!, rule.currency),
            ),
            SizedBox(height: 8.h),
            _buildProgressBar(),
            SizedBox(height: 12.h),
          ],
          if (rule.minimumBalance != null) ...[
            _buildDetailRow(
              'Minimum Balance',
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.minimumBalance!, rule.currency),
            ),
            SizedBox(height: 12.h),
          ],
          if (rule.maximumPerSave != null)
            _buildDetailRow(
              'Maximum Per Save',
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.maximumPerSave!, rule.currency),
            ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    if (rule.targetAmount == null || rule.targetAmount == 0) {
      return const SizedBox.shrink();
    }

    final progress = (rule.totalSaved / rule.targetAmount!).clamp(0.0, 1.0);
    final percentage = (progress * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.totalSaved, rule.currency),
              style: GoogleFonts.inter(
                color: const Color.fromARGB(255, 78, 3, 208),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '$percentage%',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 78, 3, 208),
                    Color.fromARGB(255, 98, 33, 224),
                  ],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Statistics',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Total Saved',
                  currency_formatter.CurrencySymbols.formatAmountWithCurrency(rule.totalSaved, rule.currency),
                  Icons.savings_outlined,
                  const Color(0xFF10B981),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatItem(
                  'Times Triggered',
                  '${rule.triggerCount}',
                  Icons.replay,
                  const Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    final busy = _isTogglingRule || _isDeletingRule || _isTriggeringRule;

    // Group the CTAs into rows of two so destructive / state-changing
    // actions sit side-by-side instead of stacking down the screen.
    // Manual Trigger only shows for active rules — when present we
    // pair it with Pause; otherwise Resume gets the lead slot.
    final pauseResume = _buildActionButton(
      label: rule.isActive ? 'Pause' : 'Resume',
      icon: rule.isActive
          ? Icons.pause_circle_outline
          : Icons.play_circle_filled,
      color: rule.isActive
          ? const Color(0xFFF59E0B)
          : const Color(0xFF10B981),
      onPressed: busy ? null : _toggleRule,
      isLoading: _isTogglingRule,
    );

    final triggerOrAllRules = rule.isActive
        ? _buildActionButton(
            label: 'Manual Save',
            icon: Icons.play_circle_outline,
            color: const Color.fromARGB(255, 78, 3, 208),
            onPressed: busy ? null : _triggerManualSave,
            isLoading: _isTriggeringRule,
          )
        : _buildActionButton(
            label: 'All Rules',
            icon: Icons.list_alt_outlined,
            color: const Color(0xFF3B82F6),
            onPressed: _viewTransactions,
          );

    final deleteButton = _buildActionButton(
      label: 'Delete',
      icon: Icons.delete_outline,
      color: const Color(0xFFEF4444),
      onPressed: busy ? null : _deleteRule,
      isLoading: _isDeletingRule,
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: triggerOrAllRules),
            SizedBox(width: 12.w),
            Expanded(child: pauseResume),
          ],
        ),
        SizedBox(height: 12.h),
        // For active rules row 1 already has Manual Save, so pair
        // All Rules + Delete on row 2. For inactive rules row 1
        // already had All Rules + Resume, so row 2 is full-width
        // Delete — keeping it stretched looks less awkward than a
        // half-empty pair.
        rule.isActive
            ? Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      label: 'All Rules',
                      icon: Icons.list_alt_outlined,
                      color: const Color(0xFF3B82F6),
                      onPressed: _viewTransactions,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(child: deleteButton),
                ],
              )
            : SizedBox(width: double.infinity, child: deleteButton),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: onPressed == null
            ? const Color(0xFF2D2D2D)
            : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: onPressed == null
              ? const Color(0xFF2D2D2D)
              : color.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onPressed,
          child: Center(
            child: isLoading
                ? LazerVaultLoader.small()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: onPressed == null ? Colors.grey[600] : color,
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: onPressed == null ? Colors.grey[600] : color,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

/// Tiny pair returned by [_humaniseAutosaveError] — split-out so the
/// snackbar can show a strong title + softer detail line.
class _FriendlyError {
  final String title;
  final String body;
  const _FriendlyError(this.title, this.body);
}

/// Map verbatim backend executor messages onto user-friendly copy.
/// The executor itself returns short technical reasons ("debit
/// rejected: insufficient funds", "savings goal already reached",
/// "rule not active (status=paused)", etc.) — fine for engineers but
/// noisy in a snackbar. Unmatched messages fall through with a
/// neutral title + the raw text so we never swallow useful detail.
_FriendlyError _humaniseAutosaveError(String raw) {
  final m = raw.toLowerCase();
  if (m.contains('savings goal already reached') ||
      m.contains('target reached')) {
    return const _FriendlyError(
      'Goal already met',
      'This rule has already saved its full target amount.',
    );
  }
  if (m.contains('rule not active') || m.contains('status=paused') ||
      m.contains('status=cancelled') || m.contains('status=completed')) {
    return const _FriendlyError(
      'Rule not active',
      'Resume the rule first, then try again.',
    );
  }
  if (m.contains('insufficient') || m.contains('balance') &&
      m.contains('low')) {
    return const _FriendlyError(
      'Not enough balance',
      'Your source account doesn\'t have the funds for this save right now.',
    );
  }
  if (m.contains('debit rejected')) {
    return _FriendlyError(
      'Source account couldn\'t be debited',
      raw.replaceFirst(RegExp(r'^debit rejected:?\s*', caseSensitive: false), ''),
    );
  }
  if (m.contains('credit rejected')) {
    return _FriendlyError(
      'Destination account refused the credit',
      raw.replaceFirst(RegExp(r'^credit rejected:?\s*', caseSensitive: false), ''),
    );
  }
  if (m.contains('duplicate trigger in progress')) {
    return const _FriendlyError(
      'Already saving',
      'A save for this rule is already in flight. Hold on a moment.',
    );
  }
  if (m.contains('minimum') && m.contains('balance')) {
    return const _FriendlyError(
      'Below minimum balance',
      'Saving would take your account below its configured minimum balance.',
    );
  }
  if (m.contains('amount') && (m.contains('exceeds') || m.contains('cap'))) {
    return const _FriendlyError(
      'Above per-save cap',
      'The computed amount is over your configured maximum per save.',
    );
  }
  // Network / accounts-service unreachable — produced by the gRPC
  // client wrapper before the executor records anything.
  if (m.contains('unavailable') ||
      m.contains('deadline exceeded') ||
      m.contains('connection')) {
    return const _FriendlyError(
      'Network hiccup',
      'We couldn\'t reach the savings service. The reconciler will retry shortly.',
    );
  }
  return _FriendlyError('Couldn\'t save', raw);
}
