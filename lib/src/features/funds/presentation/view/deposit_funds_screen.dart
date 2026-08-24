import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:lazervault/src/features/funds/presentation/view/deposit_history_screen.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lazervault/core/services/auto_logout_guard.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/open_banking/presentation/mixins/linked_balance_refresh_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_link_fee_mixin.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_link_kyc_gate.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/link_account_gate.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/open_banking/data/errors/banking_errors.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/deposit.dart';
import 'package:lazervault/src/features/funds/data/services/mono_institutions_service.dart';
import 'package:lazervault/src/features/funds/domain/services/pending_deposit.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/pay_by_transfer_card.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/flutterwave_payment_webview.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/recurring_access_toggle.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_authorization_sheet.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/directpay_progress_bottomsheet.dart';
// Beam mandate widgets — single canonical mandate UX shared between the
// move_money (Beam) feature and deposits. Mandates are per-(user,
// linked_account) so the same row backs both flows; reusing the Beam
// MandateCubit + bottom-sheet keeps the UX identical and avoids
// per-feature drift.
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_state.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/linked_account_state_chip.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_mode_info.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_setup_bottomsheet.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_management_bottomsheet.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/move_money/domain/mandate_auth_attempt_store.dart';
part 'deposit_funds_screen_widgets.dart';


class DepositFundsScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCard;
  const DepositFundsScreen({
    super.key,
    required this.selectedCard,
  });

  @override
  State<DepositFundsScreen> createState() => _DepositFundsScreenState();
}

class _DepositFundsScreenState extends State<DepositFundsScreen>
    with TransactionPinMixin, BankLinkFeeMixin, LinkedBalanceRefreshMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  final TextEditingController _amountController = TextEditingController();
  // Inline deposit fee preview (aggregated Mono + LazerVault fee + net credit),
  // fetched from the backend as the user types. Decoupled from the sheet's
  // setState via a ValueNotifier so the async result redraws just the fee row.
  final ValueNotifier<DepositFeeCalculation?> _feePreview = ValueNotifier(null);
  Timer? _feeDebounce;
  String _selectedBank = '';

  // Dynamic bank list loaded from Mono supported banks
  List<Map<String, dynamic>> _banks = [];

  // Linked bank account ID (if user has linked an account)
  String? _linkedAccountId;

  // The in-flight deposit id, captured on DepositInitiated so we can poll
  // its settlement status after DirectPay authorization.
  String? _currentDepositId;

  // DirectPay vs Mandate toggle (NGN accounts)
  // false = DirectPay (one-time authorization per transaction)
  // true = Mandate (authorize once for recurring access)
  // DEFAULT to Direct Debit (recurring mandate): it authorizes once and makes
  // every future deposit instant. The backend tries the mandate first and falls
  // back to one-time DirectPay automatically when no usable mandate exists
  // (see deposit_service InitiateDeposit), so this default never blocks a deposit.
  bool _useRecurringAccess = true;

  /// BVN/KYC standing for the Direct Debit toggle. Direct Debit needs a verified
  /// BVN (Mono creates a customer keyed on BVN before a mandate) — so the toggle
  /// is LOCKED until this is true, rather than letting the user flip it and get
  /// silently downgraded to DirectPay. Fail-open default (true) is corrected by
  /// [_ensureBvnKycForToggle] the moment the link sheet opens; `_bvnKycFetched`
  /// guards against re-fetching on every sheet rebuild.
  bool _bvnVerifiedForMandate = true;
  bool _bvnKycFetched = false;
  bool _bvnKycFetchInFlight = false;


  /// Methods available for the current currency + platform. The backend
  /// (banking-service routing + system_settings) remains the source of truth;
  /// this list only governs what we OFFER:
  ///   • Link Account (Mono direct debit) — NGN only.
  ///   • Bank Transfer (virtual NUBAN)    — NGN only (non-NGN wallets have no NUBAN).
  ///   • Apple Pay (Flutterwave)          — iOS only, non-NGN (Flutterwave Apple Pay corridors).
  ///   • Card (Flutterwave hosted)        — ALL currencies. Flutterwave fully
  ///     supports NGN card charges, and banking-service routes paymentMethod
  ///     'card' to the Flutterwave hosted checkout even for NGN wallets.
  List<_DepositMethod> get _availableMethods {
    if (_isNGN) {
      return const [
        _DepositMethod.linkAccount,
        _DepositMethod.bankTransfer,
        _DepositMethod.card,
      ];
    }
    return [
      if (Platform.isIOS) _DepositMethod.applePay,
      _DepositMethod.card,
    ];
  }

  // DirectPay progress controller for animated bottomsheet
  final DirectPayProgressController _progressController = DirectPayProgressController();
  bool _isProgressSheetShown = false;

  // Guards a single resume after the KYC detour. The deposit screen is
  // re-created when KYC routes back to it (Get.offNamed), so this prevents the
  // resumed link/deposit from launching twice (e.g. a rebuild re-entering the
  // resume path). Cleared once the resumed flow has been kicked off.
  bool _isResuming = false;

  // Guards the pre-launch KYC check so a double-tap on a deposit action can't
  // fire two concurrent status fetches / two Mono launches / two KYC saves.
  bool _kycCheckInFlight = false;

  // Whether the "resolving" loading overlay (spinner shown while the KYC
  // pre-check runs, before we know whether to launch Mono or ask for KYC) is on
  // screen. Kept as a guard so show/hide are idempotent and we never pop the
  // wrong route.
  bool _resolvingOverlayShown = false;

  // Bank-Transfer VA activation (verified user who has no virtual account yet).
  // We provision it on demand rather than bouncing them back into KYC (which just
  // loops with "already verified"). The provisioned NUBAN is held here so the
  // details render immediately in-session.
  bool _activatingAccount = false;
  String? _provisionedAccountNumber;
  String? _provisionedAccountName;
  String? _provisionedBankName;

  // Watchdog: if linking/initiating stalls (e.g. a provider call hangs), flip the
  // progress sheet to a retryable failure instead of spinning on "Linking Account"
  // forever. Cancelled as soon as the flow advances to authorizing/processing.
  Timer? _linkWatchdog;

  void _startLinkWatchdog() {
    _linkWatchdog?.cancel();
    // 60s: linking runs a backend link + e-mandate creation (a couple of Mono
    // API calls). Only fire if we are STILL on linking/initiating — once the
    // flow reaches authorizing/processing the deposit is in motion and the
    // WebSocket / settlement poll own the outcome.
    _linkWatchdog = Timer(const Duration(seconds: 60), () {
      if (!mounted || !_isProgressSheetShown) return;
      final stage = _progressController.stage;
      if (stage == DirectPayStage.linking || stage == DirectPayStage.initiating) {
        _progressController.updateStage(
          DirectPayStage.failed,
          errorTitle: 'Taking too long',
          errorMessage:
              "We couldn't reach your bank in time. Please check your connection and try again.",
          retryable: true,
        );
      }
    });
  }

  void _cancelLinkWatchdog() {
    _linkWatchdog?.cancel();
    _linkWatchdog = null;
  }

  // The user's previously-linked bank accounts (shown in the "Deposit again"
  // carousel). A linked account may or may not have an active recurring
  // mandate — we badge the ones that do. Cached locally so the carousel
  // survives OpenBankingCubit state changes during a deposit.
  List<LinkedBankAccount> _linkedAccounts = [];
  // Section-level state for the "Deposit again" carousel: loading covers the
  // window from screen-open until the fetch resolves (previously the section
  // was an invisible gap that popped in); error renders a compact retry row.
  bool _linkedAccountsLoading = false;
  bool _linkedAccountsError = false;
  // One-time "how to refresh a linked-bank balance" guide is evaluated once per
  // screen instance (persisted per-user so it's shown once, ever).
  bool _refreshGuideChecked = false;


  /// Get currency from selected card
  String get _currency {
    final currency = widget.selectedCard['currency'] as String? ?? 'GBP';
    return currency.toUpperCase();
  }

  /// Check if NGN account (uses Mono direct debit flow)
  bool get _isNGN => _currency == 'NGN';

  /// Get currency symbol for display
  String get _currencySymbol {
    switch (_currency) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      default:
        return '₦';
    }
  }

  @override
  void initState() {
    super.initState();
    // Telemetry: deposit screen view (currency is bounded server-side).
    AnalyticsService.instance.trackDepositScreen(_currency);
    _loadBanks();
    // Load the user's saved mandates + previously-linked bank accounts so the
    // "Deposit again" carousel can show them. Fire after the first frame.
    if (_isNGN) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadUserMandates();
        _loadLinkedAccounts();
        // Hydrate the mandate auth-attempt stamps so the linked-account cards
        // can distinguish 'confirming at the bank' from 'finish setup'.
        MandateAuthAttemptStore.hydrate();
      });
    }
    // Listen to amount changes to update button state
    _amountController.addListener(_onAmountChanged);

    // KYC-detour resume: when this screen is re-created after the user
    // completed identity verification mid-deposit, restore the in-flight
    // context and continue the deposit. Detected via the `resumePending`
    // marker carried through navigation arguments AND a saved PendingDeposit.
    // Deferred to a post-frame callback so the BlocProviders in build() exist
    // before we re-open the progress sheet / re-launch the link.
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeResumeAfterKyc());
  }

  /// If we returned from a KYC detour with a saved PendingDeposit, restore the
  /// amount/currency/recurring toggle and continue the deposit (re-link via
  /// Mono if no account was linked yet, otherwise redeposit from the already-
  /// linked account). Guarded so it only runs once.
  void _maybeResumeAfterKyc() {
    if (!mounted || _isResuming) return;

    final resumeRequested = widget.selectedCard['resumePending'] == true;
    final pending = serviceLocator<PendingDeposit>();
    if (!resumeRequested || !pending.pending) return;

    _isResuming = true;

    // The user just returned from the identity/BVN gate — force the Direct Debit
    // toggle to re-check KYC on the next sheet build so a freshly-verified user
    // sees it unlocked (not the stale locked state).
    _bvnKycFetched = false;
    _bvnVerifiedForMandate = true;

    // ATOMIC CONSUME: snapshot EVERY field we need into locals, then clear the
    // PendingDeposit IMMEDIATELY — before any restore / snackbar / sheet work.
    // The pending context must be consumed exactly once: if the user backs out
    // during the resume, a later screen re-creation must never re-resume a
    // stale deposit (wrong amount/account from hours ago). All restore below
    // reads from these locals, never from `pending`.
    final amount = pending.amount;
    final useRecurringAccess = pending.useRecurringAccess;
    final linkedBankName = pending.linkedBankName ?? '';
    final linkedAccountId = pending.linkedAccountId ?? '';
    final hadLinkedAccount = linkedAccountId.isNotEmpty;
    pending.clear();

    // Restore the form context the user had before the KYC gate (from locals).
    if (amount > 0) {
      // Trim a trailing ".0" so the field reads as the user typed it.
      _amountController.text = amount == amount.roundToDouble()
          ? amount.toStringAsFixed(0)
          : amount.toString();
    }
    _useRecurringAccess = useRecurringAccess;
    if (linkedBankName.isNotEmpty) {
      _selectedBank = linkedBankName;
    }
    if (linkedAccountId.isNotEmpty) {
      _linkedAccountId = linkedAccountId;
    }
    if (mounted) setState(() {});

    Get.snackbar(
      'Identity verified',
      'Continuing your deposit…',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.95),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    if (hadLinkedAccount) {
      // The bank was already linked before the gate — resume the DEPOSIT, not
      // the link. Route through the SAME fee-disclosed, PIN-gated confirm as a
      // normal redeposit (it shows its own progress sheet) so the resume path
      // isn't a back-door around the fee + tx-PIN. Fall back to the id-only
      // resume only if the full account object isn't cached (never dead-end).
      LinkedBankAccount? resumeAccount;
      for (final a in _linkedAccounts) {
        if (a.id == _linkedAccountId) {
          resumeAccount = a;
          break;
        }
      }
      if (resumeAccount != null) {
        _confirmFeeAndDepositFromLinkedAccount(resumeAccount);
      } else {
        _progressController.show(
          bankName: _selectedBank.isNotEmpty ? _selectedBank : 'your bank',
          amount: amount,
          currency: _currency,
          flow: DirectPayProgressFlow.redeposit,
        );
        _showProgressBottomsheet(context);
        _progressController.updateStage(DirectPayStage.initiating);
        _redepositFromLinkedAccountId();
      }
    } else {
      // No account linked yet — re-run the full Link & Deposit now that KYC
      // is satisfied. _launchNGNMonoBottomsheet shows the progress sheet
      // itself once Mono Connect returns a code.
      _launchNGNMonoBottomsheet(context);
    }
  }

  /// Re-fire a deposit from the account that was already linked before the KYC
  /// gate fired. Mirrors _depositFromLinkedAccount but works from the saved
  /// _linkedAccountId (we don't keep the full LinkedBankAccount across the
  /// detour — the id + bank name are enough to re-initiate). The recurring
  /// path is honoured exactly as the user chose: with the toggle on the
  /// backend tries the mandate first and falls back to DirectPay.
  void _redepositFromLinkedAccountId() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final linkedId = _linkedAccountId;
    if (linkedId == null || linkedId.isEmpty) return;
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) return;
    final destId = widget.selectedCard['id']?.toString() ?? '';
    if (destId.isEmpty) {
      Get.snackbar('Error', 'Missing destination account.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white);
      return;
    }
    final bankLabel = _selectedBank.isNotEmpty ? _selectedBank : 'your bank';
    // Arm "Try Again" so a failed resume redeposit re-fires this same path.
    _retryDeposit = _redepositFromLinkedAccountId;
    serviceLocator<OpenBankingCubit>().initiateDeposit(
      userId: authState.profile.user.id,
      linkedAccountId: linkedId,
      destinationAccountId: destId,
      amount: amount,
      narration: 'Deposit from $bankLabel to Lazervault',
      accessToken: authState.profile.session.accessToken,
      currency: _currency,
      countryCode: _countryCodeForCurrency(_currency),
      useRecurringAccess: _useRecurringAccess,
    );
  }


  /// Fetch the user's previously-linked bank accounts for the carousel.
  void _loadLinkedAccounts() {
    if (!mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      debugPrint('[Deposit] _loadLinkedAccounts: auth not ready, skipping');
      return;
    }
    // Seed instantly from the singleton cubit's cache so a RE-entry shows the
    // saved banks with no gap/pop-in; the fetch below then refreshes them.
    final cached = serviceLocator<OpenBankingCubit>().linkedAccounts;
    setState(() {
      if (_linkedAccounts.isEmpty && cached.isNotEmpty) {
        _linkedAccounts = List.of(cached);
      }
      // Only show the section loader when there is nothing to render yet —
      // a background refresh over visible cards must not flip the UI back
      // to a spinner.
      _linkedAccountsLoading = _linkedAccounts.isEmpty;
      _linkedAccountsError = false;
    });
    debugPrint('[Deposit] _loadLinkedAccounts: fetching for ${authState.profile.user.id}');
    serviceLocator<OpenBankingCubit>().fetchLinkedAccounts(
      userId: authState.profile.user.id,
      accessToken: authState.profile.session.accessToken,
    );
  }

  /// Pull the user's saved mandates into the shared MandateCubit cache so the
  /// Link Account method can show + manage them. Silent on failure (mandates
  /// are an optional enhancement).
  void _loadUserMandates() {
    if (!mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    serviceLocator<MandateCubit>().fetchUserMandates(
      userId: authState.profile.user.id,
    );
  }

  /// Called when amount text changes
  void _onAmountChanged() {
    // Trigger rebuild to update button state
    if (mounted) {
      setState(() {});
    }
    _updateFeePreview();
  }

  // Debounced backend fee quote for the inline preview shown under the amount
  // field. Clears when the amount is empty/invalid; otherwise sets _feePreview to
  // the aggregated (Mono provider fee + LazerVault fee) + net credit.
  void _updateFeePreview() {
    _feeDebounce?.cancel();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) {
      _feePreview.value = null;
      return;
    }
    _feeDebounce = Timer(const Duration(milliseconds: 400), () async {
      final calc = await serviceLocator<OpenBankingCubit>()
          .depositFeeQuote((amount * 100).round());
      if (mounted) _feePreview.value = calc;
    });
  }

  // Cost-confirmed refresh of a linked SOURCE bank's balance from the deposit
  // screen (the balance tells the user whether the bank has funds to pull). A
  // live Mono read is billed, so quote the fee and, when > 0, show it + take a
  // txPIN before charging + reading. Mirrors the Linked Banks refresh flow.
  /// One-time educational modal (only for users who already have a linked bank)
  /// explaining that linked-bank balances are cached to save cost, and how to
  /// pull a live figure with the explicit "Refresh balance" button.
  Future<void> _maybeShowBalanceRefreshGuide(
      List<LinkedBankAccount> accounts) async {
    if (_refreshGuideChecked || accounts.isEmpty || !mounted) return;
    _refreshGuideChecked = true; // at most once per screen visit
    try {
      final authState = context.read<AuthenticationCubit>().state;
      final uid =
          authState is AuthenticationSuccess ? authState.profile.user.id : '';
      // Suppressed ONLY when the user ticked "Don't show this again" (or turned
      // the guide off in Settings). Otherwise it reappears on each deposit-screen
      // visit (once per visit). Key is centralised in FeatureFlags so the
      // Settings toggle and this modal stay in two-way sync.
      final key = FeatureFlags.depositBalanceGuideKey(uid);
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(key) == true) return;
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showBalanceRefreshGuideDialog(key);
      });
    } catch (_) {/* best-effort — never block the screen on the guide */}
  }

  void _showBalanceRefreshGuideDialog(String suppressKey) {
    const brand = Color(0xFF4E03D0);
    const card = Color(0xFF1B1626);
    bool dontShowAgain = false;
    Widget step(IconData icon, String title, String body) => Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: brand.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(icon, color: const Color(0xFFB794F6), size: 16.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 2.h),
                Text(body,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.66),
                        fontSize: 12.sp,
                        height: 1.35)),
              ]),
            ),
          ]),
        );
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: StatefulBuilder(
          builder: (context, setDlgState) => Container(
          padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: brand.withValues(alpha: 0.35)),
            boxShadow: [
              BoxShadow(
                  color: brand.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 10)),
            ],
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF6D28D9), brand],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(Icons.sync_rounded, color: Colors.white, size: 26.sp),
            ),
            SizedBox(height: 14.h),
            Text('Your linked bank balances',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800)),
            SizedBox(height: 8.h),
            Text(
              'Each linked bank shows its last saved balance and the time it '
              'was updated. To keep your data costs low, we do not refresh it '
              'automatically. Refresh any card when you want the current figure '
              'from your bank.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12.5.sp,
                  height: 1.4),
            ),
            SizedBox(height: 18.h),
            step(Icons.account_balance_rounded, 'Choose a linked bank',
                'Open a card under "Deposit again" and select the bank you want.'),
            step(Icons.sync_rounded, 'Tap "Refresh balance"',
                'The refresh control on the card fetches a live balance '
                'securely from your bank.'),
            step(Icons.check_circle_rounded, 'See the updated balance',
                'The card updates in place with a new timestamp. A small bank '
                'fee may apply per refresh.'),
            SizedBox(height: 14.h),
            // Opt-out. Unchecked by default: the guide reappears each visit
            // UNTIL the user ticks this, which persists the suppress flag.
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setDlgState(() => dontShowAgain = !dontShowAgain),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: dontShowAgain ? brand : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                        color: dontShowAgain
                            ? brand
                            : Colors.white.withValues(alpha: 0.4),
                        width: 1.5),
                  ),
                  child: dontShowAgain
                      ? Icon(Icons.check, size: 14.sp, color: Colors.white)
                      : null,
                ),
                SizedBox(width: 10.w),
                Text("Don't show this again",
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12.5.sp)),
              ]),
            ),
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Persist the choice ONLY when the user opted out.
                  if (dontShowAgain) {
                    try {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(suppressKey, true);
                    } catch (_) {/* best-effort */}
                  }
                  if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brand,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                child: Text('Got it',
                    style: TextStyle(
                        fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
          ),
        ),
      ),
    );
  }

  /// Styled modal for when the ACTIVE account can't cover the balance-refresh
  /// fee. The backend reserves the fee BEFORE the live read, so this fires with
  /// nothing charged and no bank call made — the user just needs funds in the
  /// account they're depositing from. Offers a clear path to top it up.
  void _showRefreshFeeInsufficientDialog(String message) {
    const brand = Color(0xFF4E03D0);
    const card = Color(0xFF1B1626);
    const warn = Color(0xFFFB923C);
    final text = message.trim().isNotEmpty
        ? message.trim()
        : "This account doesn't have enough to cover the refresh fee.";
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (dialogCtx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 22.h, 20.w, 18.h),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: warn.withValues(alpha: 0.35)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 10)),
            ],
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: warn.withValues(alpha: 0.16),
              ),
              child: Icon(Icons.account_balance_wallet_rounded,
                  color: warn, size: 26.sp),
            ),
            SizedBox(height: 14.h),
            Text('Not enough to refresh',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w800)),
            SizedBox(height: 8.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: 12.5.sp,
                  height: 1.4),
            ),
            SizedBox(height: 8.h),
            Text(
              "You weren't charged and your bank wasn't contacted. Add funds to "
              'the account you\'re depositing from, then try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 11.5.sp,
                  height: 1.4),
            ),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(dialogCtx).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brand,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                child: Text('Got it',
                    style: TextStyle(
                        fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> _refreshSourceBalance(dynamic account) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    // ONE shared, per-account, fee-gated refresh (see LinkedBalanceRefreshMixin) —
    // the same function the withdrawal screen calls, driving the singleton cubit so
    // the update reflects on every linked-bank surface.
    await refreshLinkedBalance(
      context,
      account as LinkedBankAccount,
      userId: authState.profile.user.id,
      accessToken: authState.profile.session.accessToken,
    );
  }

  /// Swipe-down-to-refresh: re-pull linked accounts, mandates and live
  /// balances so the saved-banks carousel + method list reflect the latest
  /// state. Awaits the bank list so the spinner stays until real work lands.
  Future<void> _pullToRefresh() async {
    _loadLinkedAccounts();
    _loadUserMandates();
    _refreshAccountBalances(context);
    await _loadBanks();
    // Small settle so the refresh spinner doesn't blink out before the
    // async cubit emits repaint the carousel.
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  /// Load supported banks from Mono API
  ///
  /// Fetches the list of banks/institutions that Mono actually supports.
  /// This ensures users only see banks that will work with the deposit flow.
  Future<void> _loadBanks() async {
    try {
      // Fetch banks from Mono API (cached)
      final monoInstitutions = await MonoInstitutionsService.instance.getInstitutions();

      if (mounted) {
        setState(() {
          if (monoInstitutions.isNotEmpty) {
            // Convert Mono institution data to display format
            _banks = monoInstitutions.map((inst) => <String, dynamic>{
              'name': inst.name,
              'code': inst.bankCode ?? '',
              'monoId': inst.id, // Store Mono institution ID for later use
              'icon': Icons.account_balance,
              'color': _getBankColor(inst.name),
              'monoSupported': true,
              'supportsMobileBanking': inst.supportsMobileBanking,
              'supportsInternetBanking': inst.supportsInternetBanking,
            }).toList();

            // Sort alphabetically
            _banks.sort((a, b) =>
                (a['name'] as String).compareTo(b['name'] as String));
          } else {
            // Fallback to config banks if API returns empty
            final monoBanks = MonoConfig.supportedBanks;
            _banks = monoBanks.entries.map((entry) => <String, dynamic>{
              'name': entry.key,
              'code': entry.value,
              'monoId': MonoConfig.getMonoInstitutionId(entry.key), // May be null
              'icon': Icons.account_balance,
              'color': _getBankColor(entry.key),
              'monoSupported': true,
            }).toList();
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading banks: $e');
      if (mounted) {
        // Fallback to letting Mono show its own bank selector
        setState(() {
          _banks = [];
        });
      }
    }
  }

  /// Get a consistent color for a bank based on its name
  Color _getBankColor(String bankName) {
    final colors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange,
      Colors.purple, Colors.teal, Colors.indigo, Colors.pink,
    ];
    final index = bankName.hashCode.abs() % colors.length;
    return colors[index];
  }



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<DepositCubit>()),
        BlocProvider.value(value: serviceLocator<OpenBankingCubit>()),
        // MandateCubit is registered as a singleton in injection_container —
        // sharing it across Beam + deposits + linked-accounts keeps a
        // single source of truth for mandate state (the in-cubit cache).
        BlocProvider.value(value: serviceLocator<MandateCubit>()),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, authState) {
          // Intentionally silent on de-auth: when the session ends (auto
          // sign-out / expiry) the user is navigated away anyway, so a
          // "You need to be logged in" toast here is just noise.
        },
        builder: (authContext, authState) {
          // Gradient lives on a full-screen Container BEHIND a transparent
          // Scaffold so it always covers the entire screen (behind the app bar
          // and all the way to the bottom). Previously the gradient was on the
          // body Container, which didn't fill the full height — the Scaffold's
          // solid colour showed through below it as a mismatched band.
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1430), Color(0xFF120F1C), Color(0xFF0A090F)],
                stops: [0.0, 0.42, 1.0],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(),
              body: BlocListener<OpenBankingCubit, OpenBankingState>(
              listener: _openBankingListener,
              child: BlocConsumer<DepositCubit, DepositState>(
                listener: _blocListener,
                builder: (context, state) {
                  final isLoading = state is DepositLoading;
                  final openBankingState = context.watch<OpenBankingCubit>().state;
                  final isOpenBankingLoading = openBankingState is OpenBankingLoading ||
                                               openBankingState is AccountLinkingInProgress;
                  return RefreshIndicator(
                    onRefresh: _pullToRefresh,
                    color: const Color(0xFF8B5CF6),
                    backgroundColor: const Color(0xFF1A1A1A),
                    child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSelectedCardSummary(),
                          SizedBox(height: 28.h),
                          // Saved banks first (deposit again with one tap),
                          // then the method-first picker. While the linked-
                          // accounts fetch is in flight, the carousel slot
                          // renders a labelled loading row instead of an
                          // invisible gap.
                          _buildSavedBanksCarousel(context, isOpenBankingLoading),
                          Text(
                            'How would you like to deposit?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Choose a method to continue.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          _buildMethodList(isLoading || isOpenBankingLoading),
                        ],
                      ),
                    ),
                  ),
                  );
                },
              ),
            ),
            ),
          );
        },
      ),
    );
  }

  /// Mono info banner showing open banking message

  /// NGN Mono Direct Debit View - Shows amount input, Mono open banking info and button to link bank
  /// User enters amount first, then links their bank via Mono
  /// After linking, the deposit is initiated via Mono DirectPay API
  /// Also includes Pay by Transfer option as an alternative
  // ===== DEPOSIT METHOD PICKER =====

  /// The list of deposit-method cards shown on the landing. Tapping a card
  /// opens a focused modal for that method.
  Widget _buildMethodList(bool isLoading) {
    final methods = _availableMethods;
    if (methods.isEmpty) {
      return Text(
        'No deposit methods are available for this wallet yet.',
        style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13.sp),
      );
    }
    return Column(
      children: methods
          .map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildMethodCard(m, isLoading),
              ))
          .toList(),
    );
  }

  Widget _buildMethodCard(_DepositMethod method, bool isLoading) {
    final accent = const Color.fromARGB(255, 78, 3, 208);
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: isLoading ? null : () => _openDepositMethodGated(method),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.07),
              Colors.white.withValues(alpha: 0.02),
            ],
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: accent.withValues(alpha: 0.20)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent.withValues(alpha: 0.45),
                    accent.withValues(alpha: 0.18),
                  ],
                ),
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: accent.withValues(alpha: 0.30)),
              ),
              child: Icon(method.icon, color: Colors.white, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.label,
                    style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    method.subtitle,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.4), size: 22.sp),
          ],
        ),
      ),
    );
  }

  /// True when the destination account already has a real, provisioned NUBAN —
  /// i.e. it can receive deposits. A non-empty account number on a virtual
  /// account is the signal (the backend leaves it empty until the mint lands).
  bool get _targetHasVirtualAccount =>
      (_provisionedAccountNumber ??
              widget.selectedCard['accountNumber'] ??
              widget.selectedCard['account_number'] ??
              '')
          .toString()
          .trim()
          .isNotEmpty;

  /// Entry point from a method card — the SAME gate for EVERY method (transfer,
  /// card, link, Apple Pay). The primary check is whether the destination can
  /// RECEIVE money (a NUBAN exists), NOT whether the user is KYC-verified: a BVN
  /// only matters because it's what mints the NUBAN, so KYC is the fallback.
  ///
  /// Runs the moment the method card is tapped, BEFORE the amount/fee sheet:
  ///   • has NUBAN (or non-NGN, which doesn't use one) → open the sheet instantly;
  ///   • no NUBAN + verified → loading overlay while we mint it, then open;
  ///   • no NUBAN + unverified → route to BVN KYC (sheet never opens).
  /// This unifies card/link (which used to check while already calling the
  /// provider) with transfer (which checked first) and gives a proper loading
  /// state from the tap instead of the sheet silently closing.
  Future<void> _openDepositMethodGated(_DepositMethod method) async {
    // Fast path: already fundable, or a non-NGN account (no NUBAN concept).
    if (!_isNGN || _targetHasVirtualAccount) {
      _openMethodSheet(method);
      return;
    }
    final res = await ensureDepositReady(
      context,
      accountHasVirtualAccount: false,
      currency: _currency,
      isPrimary: widget.selectedCard['isPrimary'] == true,
    );
    if (!mounted) return;
    if (res.status == DepositReadiness.needsKyc) return; // verification took over
    if (res.status == DepositReadiness.provisioning) {
      // The NUBAN mint didn't complete this attempt — BLOCK the flow with a modal
      // and do NOT open the method sheet, so the user never lands in a deposit
      // method they can't complete. They retry once the account is ready.
      await showAccountSetupPendingModal(context);
      return;
    }
    // ready — capture the freshly-minted NUBAN so the sheet shows it, then proceed.
    if (res.mintedAccountNumber != null) {
      setState(() => _provisionedAccountNumber = res.mintedAccountNumber);
    }
    if (!mounted) return;
    _openMethodSheet(method);
  }

  /// Opens a focused modal for the chosen deposit method. Amount entry +
  /// method-specific content + the continue CTA live here, keeping the
  /// landing screen clean. The CTA closes the sheet, then runs the method's
  /// flow on the screen context (which holds the cubits).
  void _openMethodSheet(_DepositMethod method) {
    final screenContext = context;
    showModalBottomSheet(
      context: screenContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                child: StatefulBuilder(
                  builder: (ctx, setSheetState) =>
                      _methodSheetContent(sheetCtx, method, setSheetState),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _methodSheetContent(
    BuildContext sheetCtx,
    _DepositMethod method,
    void Function(void Function()) setSheetState,
  ) {
    final accent = const Color.fromARGB(255, 78, 3, 208);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Drag handle
        Center(
          child: Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
        // Header
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(method.icon, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.label,
                      style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                  Text(method.subtitle,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(sheetCtx).pop(),
              icon: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.6), size: 22.sp),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ..._methodSheetBody(sheetCtx, method, setSheetState),
      ],
    );
  }

  List<Widget> _methodSheetBody(
    BuildContext sheetCtx,
    _DepositMethod method,
    void Function(void Function()) setSheetState,
  ) {
    switch (method) {
      case _DepositMethod.bankTransfer:
        // Open-amount transfer — just show the account details to copy.
        return [
          _buildBankTransferContent(context),
          SizedBox(height: 16.h),
          _sheetPrimaryButton(
            label: 'Done',
            icon: Icons.check,
            onPressed: () => Navigator.of(sheetCtx).pop(),
          ),
        ];
      case _DepositMethod.linkAccount:
        // Resolve BVN/KYC standing once so the Direct Debit toggle reflects
        // whether a mandate is even possible (locked → "Verify BVN" otherwise).
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _ensureBvnKycForToggle(setSheetState);
        });
        return [
          _buildSheetAmountField(setSheetState),
          SizedBox(height: 16.h),
          RecurringAccessToggle(
            isRecurringEnabled: _useRecurringAccess,
            kycVerified: _bvnVerifiedForMandate,
            onToggle: (v) => setSheetState(() => setState(() => _useRecurringAccess = v)),
            onVerifyRequested: () {
              Navigator.of(sheetCtx).pop();
              _promptVerifyThenKyc();
            },
          ),
          SizedBox(height: 16.h),
          _sheetPrimaryButton(
            label: 'Link & Deposit',
            icon: Icons.link,
            onPressed: () {
              if (!_validateSheetAmount(min: 200)) return;
              // Identity was verified before this sheet opened (the method-card
              // tap gates KYC first). Pop the sheet, then launch Mono directly.
              Navigator.of(sheetCtx).pop();
              _launchNGNMonoBottomsheet(context);
            },
          ),
          SizedBox(height: 12.h),
          _buildMonoHowItWorks(),
        ];
      case _DepositMethod.applePay:
        return [
          _buildSheetAmountField(setSheetState),
          SizedBox(height: 16.h),
          _sheetPrimaryButton(
            label: 'Pay with Apple Pay',
            icon: Icons.apple,
            color: Colors.black,
            onPressed: () {
              if (!_validateSheetAmount()) return;
              Navigator.of(sheetCtx).pop();
              // Identity already verified before this sheet opened.
              _startFlutterwaveDeposit(context,
                  paymentMethod: 'apple_pay', sourceLabel: 'Apple Pay');
            },
          ),
          SizedBox(height: 10.h),
          _sheetSecureNote('You will confirm with Apple Pay on the secure checkout.'),
        ];
      case _DepositMethod.card:
        return [
          _buildSheetAmountField(setSheetState),
          SizedBox(height: 16.h),
          _sheetPrimaryButton(
            label: 'Pay with Card',
            icon: Icons.credit_card,
            onPressed: () {
              // Flutterwave's NGN card minimum is ₦100; other corridors just
              // need a positive amount.
              if (!_validateSheetAmount(min: _isNGN ? 100 : 0)) return;
              Navigator.of(sheetCtx).pop();
              // Identity already verified before this sheet opened.
              _startFlutterwaveDeposit(context,
                  paymentMethod: 'card', sourceLabel: 'Card');
            },
          ),
          SizedBox(height: 10.h),
          _sheetSecureNote('You will enter your card details on the secure checkout.'),
        ];
    }
  }

  /// Compact amount field for the method sheet (writes the shared controller).
  Widget _buildSheetAmountField(void Function(void Function()) setSheetState) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13.sp)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(_currencySymbol,
                  style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.w700)),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => setSheetState(() {}),
                  style: TextStyle(color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3), fontSize: 28.sp, fontWeight: FontWeight.w700),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          if (_isNGN) ...[
            SizedBox(height: 6.h),
            Text('Min: ₦200 • Max: ₦1,000,000',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11.sp)),
          ],
          // Inline aggregated fee + net credit (the user sees ONE fee; the
          // Mono/LazerVault split is a settlement concern). Hidden when 0.
          ValueListenableBuilder<DepositFeeCalculation?>(
            valueListenable: _feePreview,
            builder: (_, calc, __) {
              // Show when a fee applies OR a platform-funded discount fully
              // waived it (a free promo deposit should say so, not hide).
              if (calc == null || (calc.fee <= 0 && calc.discount <= 0)) {
                return const SizedBox.shrink();
              }
              final feeText = calc.fee <= 0
                  ? 'Free · you receive ₦${(calc.netAmount / 100).toStringAsFixed(2)}'
                  : '₦${(calc.fee / 100).toStringAsFixed(2)} · you receive ₦${(calc.netAmount / 100).toStringAsFixed(2)}';
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transaction fee',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp)),
                        Flexible(
                          child: Text(
                            feeText,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    // Platform-funded discount — the single "you save" line.
                    if (calc.discount > 0)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          'You save ₦${(calc.discount / 100).toStringAsFixed(2)} — discount applied',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: const Color(0xFF10B981),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _validateSheetAmount({double min = 0}) {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0 || amount < min) {
      Get.snackbar(
        'Invalid Amount',
        min > 0 ? 'Enter at least $_currencySymbol${min.toStringAsFixed(0)}.' : 'Please enter a valid amount.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return false;
    }
    return true;
  }

  Widget _sheetPrimaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color.fromARGB(255, 78, 3, 208),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp),
            SizedBox(width: 8.w),
            Text(label, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _sheetSecureNote(String text) {
    return Row(
      children: [
        Icon(Icons.lock_outline, color: Colors.white.withValues(alpha: 0.5), size: 14.sp),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(text, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
        ),
      ],
    );
  }


  /// LINK ACCOUNT (Mono direct debit) — recurring toggle + Link & Deposit.

  /// SAVED BANKS CAROUSEL — a horizontally-swipeable strip of the user's
  /// previously-linked bank accounts. Each shows a "Persistent" badge when it
  /// has an active mandate (reusable with no re-auth via Mono DebitMandate).
  /// Tapping opens a deposit-amount sheet; the overflow menu offers manage +
  /// unlink. "View all" lists them all in a modal.
  Widget _buildSavedBanksCarousel(BuildContext context, bool isLoading) {
    // While the open-banking cubit is fetching for the first time, the
    // accounts list is still empty — render a labelled loading row in
    // the carousel's slot so the section's identity stays present
    // (instead of an invisible gap that later pops in).
    if (_linkedAccounts.isEmpty) {
      BoxDecoration sectionBox() => BoxDecoration(
            color: const Color(0xFF241C3D).withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          );
      if (isLoading || _linkedAccountsLoading) {
        return Container(
          margin: EdgeInsets.only(bottom: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          decoration: sectionBox(),
          child: LazerVaultLoadingRow(
            label: 'Loading linked accounts',
            padding: EdgeInsets.zero,
            labelStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            loaderSize: 22,
          ),
        );
      }
      // Fetch failed with nothing cached — compact retry row instead of a
      // silent gap, so the user knows their saved banks exist and can reload.
      if (_linkedAccountsError) {
        return Container(
          margin: EdgeInsets.only(bottom: 24.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: sectionBox(),
          child: Row(
            children: [
              Icon(Icons.wifi_off_rounded,
                  color: Colors.white.withValues(alpha: 0.55), size: 18.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  "Couldn't load your linked banks.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13.sp,
                  ),
                ),
              ),
              TextButton(
                onPressed: _loadLinkedAccounts,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF8B5CF6),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  minimumSize: Size(0, 32.h),
                ),
                child: Text('Retry',
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        );
      }
      // Loaded fine and the user simply has no linked banks yet — no section.
      return const SizedBox.shrink();
    }
    // Rebuild on mandate-cache changes so the Persistent badge stays accurate.
    return BlocBuilder<MandateCubit, MandateState>(
      builder: (context, _) {
        final accounts = _linkedAccounts;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deposit again',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
                      SizedBox(height: 2.h),
                      Text('Your linked banks. Tap to deposit, swipe to browse.',
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
                    ],
                  ),
                ),
                if (accounts.length > 1)
                  TextButton(
                    onPressed: () => _showAllAccountsSheet(context),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 78, 3, 208),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                    ),
                    child: Text('View all', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: 172.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                itemCount: accounts.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                // Each card sits inside its OWN Builder: ListView item
                // builders run during LAYOUT (not inside any widget's build
                // method), so the card's per-account `context.select` throws
                // provider's "add a Builder" red box if given the itemBuilder
                // context directly. The Builder gives the select a real build
                // scope of its own, keeping the per-card rebuild-on-refresh.
                itemBuilder: (_, i) => Builder(
                  builder: (cardContext) =>
                      _buildLinkedAccountCard(cardContext, accounts[i]),
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }

  /// The active mandate for a linked account (sync cache lookup), or null.
  MandateEntity? _mandateForAccount(LinkedBankAccount account) {
    final m = serviceLocator<MandateCubit>().getMandateForAccount(account.id);
    return (m != null && m.isActive) ? m : null;
  }

  Widget _buildLinkedAccountCard(BuildContext context, LinkedBankAccount account) {
    // Deposit-access state for this card:
    //   persistent → active Direct Debit (auto-debit, no approval)
    //   pending    → Direct Debit authorized but awaiting NIBSS activation; THIS
    //                deposit still uses one-time DirectPay until it goes live
    //   onetime    → no mandate, one-time DirectPay only
    final mode = _accessModeForAccount(account);
    final settingUp = mode == 'pending';
    // While Direct Debit is still activating, the top chip honestly reads
    // "One-time" (that's the rail this deposit uses now); the amber "Setting up
    // Direct Debit" badge below carries the recurring-setup signal + info modal.
    // A switch awaiting Mono confirmation shows its own "Switching…" chip.
    final chipMode = mode == 'persistent'
        ? 'persistent'
        : mode == 'switching'
            ? 'switching'
            : 'onetime';
    final accent = _cardAccentColor(mode);
    // Live spinner while THIS account's balance refresh is in flight. Use a
    // per-account `select` (NOT `watch` on the whole cubit) so refreshing ONE
    // bank rebuilds only ITS card — a whole-state watch rebuilt every card on
    // every emit, which read as "all my banks are updating at once".
    final isRefreshing = context.select<OpenBankingCubit, bool>((c) {
      final s = c.state;
      return s is BalanceRefreshing && s.accountId == account.id;
    });
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () => _openRedepositSheet(context, account),
      child: Container(
        width: 228.w,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF241C3D).withValues(alpha: 0.80),
              const Color(0xFF15121F).withValues(alpha: 0.92),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: accent.withValues(alpha: 0.30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _bankLogoAvatar(account.bankName, bankCode: account.bankCode, size: 36),
                const Spacer(),
                _accessChip(
                  mode: chipMode,
                  onTap: () => _showAccessModeInfo(mode, account),
                  showInfo: true,
                ),
                SizedBox(width: 6.w),
                InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () => _showAccountActions(context, account),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Icon(Icons.more_vert, color: Colors.white.withValues(alpha: 0.6), size: 18.sp),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              account.bankName.isNotEmpty ? account.bankName : 'Linked bank',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 3.h),
            Text(
              account.displayAccountNumber,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp),
            ),
            SizedBox(height: 4.h),
            // COST-AWARE: balances are the last-known (cached) figure — a live
            // Mono read costs money, so it's an EXPLICIT action via the "Refresh
            // balance" button below. A chip labels whether the figure is live.
            // Balance + freshness on the left; an explicit refresh icon on the
            // right. The whole card taps to deposit, so there's no separate
            // deposit CTA — keeps the card clean and uncluttered.
            Builder(builder: (_) {
              // Live progress while the Mono read is in flight — makes the
              // (network-bound) refresh visible right on the card.
              if (isRefreshing) {
                return Row(children: [
                  SizedBox(
                    width: 15.w,
                    height: 15.w,
                    child: const CircularProgressIndicator(
                        strokeWidth: 2, color: Color(0xFF3B82F6)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text('Refreshing balance…',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ]);
              }
              final hasBalance = account.balanceUpdatedAt != null;
              final fresh = hasBalance &&
                  DateTime.now().difference(account.balanceUpdatedAt!).inMinutes <
                      3;
              final dot =
                  !hasBalance ? const Color(0xFF6B7280) : (fresh
                      ? const Color(0xFF10B981)
                      : const Color(0xFFFB923C));
              return Row(children: [
                Expanded(
                  // Tapping the balance/updated area opens the full details
                  // sheet. Consumes the tap so it never fires the card's deposit
                  // action (the card's InkWell wraps everything else).
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _showLinkedAccountDetails(account),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          hasBalance
                              ? '₦${account.lastKnownBalance.toStringAsFixed(2)}'
                              : 'Balance hidden',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 4.h),
                        // "Last updated …" replaces the live/not-live chip: a
                        // small, truncating line the user can tap for details.
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: 6.w,
                            height: 6.w,
                            decoration:
                                BoxDecoration(color: dot, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 5.w),
                          Flexible(
                            child: Text(
                              _lastUpdatedLabel(account.balanceUpdatedAt),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.55),
                                  fontSize: 9.5.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Icon(Icons.info_outline_rounded,
                              size: 11.sp,
                              color: Colors.white.withValues(alpha: 0.4)),
                        ]),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                // Hide refresh when the Mono session is expired — a live read would
                // just fail at the provider; the reconnect affordance handles it
                // (mirrors the withdrawal card).
                if (!account.needsReauthorization)
                  _refreshBalanceButton(account, isRefreshing),
              ]);
            }),
            // Direct Debit still activating → keep the amber badge below.
            if (settingUp) ...[
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: _settingUpDirectDebitBadge(account),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Explicit refresh-balance icon-button on a linked-bank card — pulls a live
  /// (cost-confirmed) balance from the bank. Shows a spinner while in flight and
  /// consumes its own tap so it never fires the card's deposit action.
  Widget _refreshBalanceButton(LinkedBankAccount account, bool isRefreshing) {
    const blue = Color(0xFF3B82F6);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isRefreshing ? null : () => _refreshSourceBalance(account),
      child: Tooltip(
        message: 'Refresh balance',
        child: Container(
          width: 34.w,
          height: 34.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: blue.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: blue.withValues(alpha: 0.42)),
          ),
          child: isRefreshing
              ? SizedBox(
                  width: 15.w,
                  height: 15.w,
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: blue),
                )
              : Icon(Icons.sync_rounded, size: 17.sp, color: blue),
        ),
      ),
    );
  }

  static const List<String> _monthsShort = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  /// Short, truncatable "last updated" label for a linked-bank card. Relative
  /// for recent refreshes, an absolute short date once it's older than a day.
  String _lastUpdatedLabel(DateTime? updatedAt) {
    if (updatedAt == null) return 'Not refreshed yet';
    final d = DateTime.now().difference(updatedAt);
    if (d.inSeconds < 45) return 'Updated just now';
    if (d.inMinutes < 60) return 'Updated ${d.inMinutes}m ago';
    if (d.inHours < 24) return 'Updated ${d.inHours}h ago';
    if (d.inDays < 7) return 'Updated ${d.inDays}d ago';
    return 'Updated ${updatedAt.day} ${_monthsShort[updatedAt.month - 1]}';
  }

  /// Full, human timestamp for the details sheet, e.g. "12 Jul 2026, 3:30 PM".
  String _fullTimestamp(DateTime t) {
    final l = t.toLocal();
    final h24 = l.hour;
    final ampm = h24 >= 12 ? 'PM' : 'AM';
    final h12 = h24 % 12 == 0 ? 12 : h24 % 12;
    final mm = l.minute.toString().padLeft(2, '0');
    return '${l.day} ${_monthsShort[l.month - 1]} ${l.year}, $h12:$mm $ampm';
  }

  /// Full-details sheet for a linked bank: balance, freshness, account + access
  /// mode, and an explicit refresh action. Opened by tapping the "Last updated"
  /// line on the card.
  void _showLinkedAccountDetails(LinkedBankAccount account) {
    const card = Color(0xFF1B1626);
    const brand = Color(0xFF4E03D0);
    final hasBalance = account.balanceUpdatedAt != null;
    final fresh = hasBalance &&
        DateTime.now().difference(account.balanceUpdatedAt!).inMinutes < 3;
    final statusColor = !hasBalance
        ? const Color(0xFF9CA3AF)
        : (fresh ? const Color(0xFF10B981) : const Color(0xFFFB923C));
    final statusText = !hasBalance
        ? 'Not refreshed yet'
        : (fresh ? 'Live balance' : 'Last-known balance');
    final mode = _accessModeForAccount(account);
    final modeLabel = mode == 'persistent'
        ? 'Direct Debit (auto)'
        : mode == 'switching'
            ? 'Switching…'
            : mode == 'pending'
                ? 'Setting up Direct Debit'
                : 'One-time';

    Widget detailRow(String label, String value, {Color? valueColor}) => Padding(
          padding: EdgeInsets.symmetric(vertical: 7.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120.w,
                child: Text(label,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 12.sp)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: valueColor ?? Colors.white,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
          border: Border.all(color: brand.withValues(alpha: 0.3)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Row(children: [
            _bankLogoAvatar(account.bankName,
                bankCode: account.bankCode, size: 42),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                    account.bankName.isNotEmpty
                        ? account.bankName
                        : 'Linked bank',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 2.h),
                Text(account.displayAccountNumber,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.55),
                        fontSize: 12.sp)),
              ]),
            ),
          ]),
          SizedBox(height: 18.h),
          // Balance headline
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
            ),
            child: Column(children: [
              Text(
                  hasBalance
                      ? '₦${account.lastKnownBalance.toStringAsFixed(2)}'
                      : 'Balance hidden',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800)),
              SizedBox(height: 8.h),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 7.w,
                  height: 7.w,
                  decoration:
                      BoxDecoration(color: statusColor, shape: BoxShape.circle),
                ),
                SizedBox(width: 6.w),
                Text(statusText,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700)),
              ]),
            ]),
          ),
          SizedBox(height: 14.h),
          detailRow(
              'Last updated',
              account.balanceUpdatedAt != null
                  ? _fullTimestamp(account.balanceUpdatedAt!)
                  : 'Never. Tap refresh below'),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          detailRow('Deposit access', modeLabel),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          detailRow('Account', account.displayAccountNumber),
          SizedBox(height: 16.h),
          Text(
            'Balances are the last figure pulled from your bank. Refresh to get '
            'the latest straight from the bank. A small fee may apply.',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11.sp,
                height: 1.4),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(sheetCtx).pop();
                _refreshSourceBalance(account);
              },
              icon: Icon(Icons.sync_rounded, size: 18.sp),
              label: Text('Refresh balance',
                  style:
                      TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: brand,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 13.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Tappable amber badge for a card whose Direct Debit mandate is authorized
  /// but still activating with NIBSS. Tapping opens an info modal. The inner
  /// InkWell consumes the tap, so it opens the modal without firing the card's
  /// deposit tap.
  Widget _settingUpDirectDebitBadge(LinkedBankAccount account) {
    const amber = Color(0xFFFB923C);
    return InkWell(
      borderRadius: BorderRadius.circular(7.r),
      onTap: () => _showDirectDebitSetupInfo(account),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: amber.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(color: amber.withValues(alpha: 0.38)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_bottom, color: amber, size: 11.sp),
            SizedBox(width: 5.w),
            Flexible(
              child: Text('Setting up Direct Debit',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: amber, fontSize: 10.sp, fontWeight: FontWeight.w700)),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.info_outline, color: amber.withValues(alpha: 0.85), size: 11.sp),
          ],
        ),
      ),
    );
  }

  /// Explains the "Direct Debit setting up" state (authorized, awaiting NIBSS)
  /// in a themed dialog. Reached from the card badge and the account-actions
  /// sheet.
  void _showDirectDebitSetupInfo(LinkedBankAccount account) {
    const amber = Color(0xFFFB923C);
    final bank = account.bankName.isNotEmpty ? account.bankName : 'your bank';
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: amber.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.hourglass_bottom, color: amber, size: 19.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text('Direct Debit is being set up',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'You authorized recurring Direct Debit for $bank. Your bank is now '
                'activating it with NIBSS. This can take a little while, sometimes up to 24 hours.',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 13.sp, height: 1.45),
              ),
              SizedBox(height: 14.h),
              _setupInfoBullet(Icons.bolt, const Color(0xFF3B82F6),
                  'You can deposit right now. Until Direct Debit is live, deposits use a secure one-time approval.'),
              SizedBox(height: 10.h),
              _setupInfoBullet(Icons.autorenew, const Color(0xFF10B981),
                  'Once it is active, future deposits debit automatically with no approval step.'),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFF3B82F6)),
                  child: Text('Got it', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tapping the "Direct Debit" / "One-time" chip on a card opens the shared
  /// access-mode info modal (same one Beam uses) explaining each deposit mode.
  void _showAccessModeInfo(String mode, LinkedBankAccount account) {
    showMandateModeInfoModal(
      context,
      current: mode == 'persistent'
          ? MandateModeView.directDebit
          : mode == 'pending'
              ? MandateModeView.settingUp
              : MandateModeView.oneTime,
      bankName: account.bankName,
      actionNoun: 'deposit',
      switchHint: 'Tap the 3-dots on the card to switch between them.',
    );
  }

  Widget _setupInfoBullet(IconData icon, Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 16.sp),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(text,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.78), fontSize: 12.5.sp, height: 1.4)),
        ),
      ],
    );
  }


  /// Deposit-amount sheet for a linked account. Reuses the mandate when one is
  /// active (DebitMandate, no re-auth); otherwise a one-time DirectPay deposit.
  void _openRedepositSheet(BuildContext screenCtx, LinkedBankAccount account) {
    _amountController.clear();
    // Read the latest mandate for this account (ANY status), so a paused or
    // expired Direct Debit is handled explicitly instead of silently falling
    // back to a one-time payment.
    final mandate = serviceLocator<MandateCubit>().getMandateForAccount(account.id);
    if (mandate != null && mandate.isPaused) {
      _showMandateActionSheet(
        screenCtx,
        title: 'Direct Debit paused',
        body: 'Your saved Direct Debit for ${account.bankName} is paused. '
            'Reinstate it to deposit again without re-authorizing.',
        actionLabel: 'Reinstate Direct Debit',
        onAction: () => _reinstateMandateThenRedeposit(account, mandate),
      );
      return;
    }
    if (mandate != null && mandate.needsReauthorization) {
      _showMandateActionSheet(
        screenCtx,
        title: 'Direct Debit ${mandate.isExpired ? 'expired' : 'ended'}',
        body: 'Your saved Direct Debit for ${account.bankName} can no longer be '
            'used. Re-authorize once to keep depositing without a bank login '
            'each time.',
        actionLabel: 'Re-authorize Direct Debit',
        onAction: () => _reauthorizeMandateThenRedeposit(account),
      );
      return;
    }
    final recurring = mandate != null && mandate.isActive;
    showModalBottomSheet(
      context: screenCtx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(sheetCtx).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
              child: StatefulBuilder(
                builder: (ctx, setSheetState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.account_balance, color: Colors.white.withValues(alpha: 0.85), size: 22.sp),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Deposit from ${account.bankName}',
                                  style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700)),
                              Text(recurring ? 'Reusing your saved authorization' : 'You will authorize this one-time payment',
                                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12.sp)),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(sheetCtx).pop(),
                          icon: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.6), size: 22.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildSheetAmountField(setSheetState),
                    SizedBox(height: 16.h),
                    _sheetPrimaryButton(
                      label: recurring ? 'Deposit again' : 'Continue',
                      icon: recurring ? Icons.refresh : Icons.arrow_forward,
                      onPressed: () {
                        if (!_validateSheetAmount(min: _isNGN ? 200 : 0)) return;
                        Navigator.of(sheetCtx).pop();
                        // NGN bank deposits require a verified identity — gate
                        // before re-depositing; a KYC detour resumes by
                        // re-depositing from this same linked account.
                        if (_isNGN) {
                          _ensureKycThenDeposit(
                            linkedAccountId: account.id,
                            linkedBankName: account.bankName,
                            proceed: () =>
                                _confirmFeeAndDepositFromLinkedAccount(account),
                          );
                        } else {
                          _confirmFeeAndDepositFromLinkedAccount(account);
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
                    _sheetSecureNote(recurring
                        ? 'We will debit ${account.bankName} via your saved mandate. No re-authorization needed.'
                        : 'You will confirm this payment securely with ${account.bankName}.'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dark action sheet used when a saved Direct Debit can't be used as-is
  /// (paused or expired) — explains why and offers the corrective action.
  void _showMandateActionSheet(
    BuildContext screenCtx, {
    required String title,
    required String body,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    showModalBottomSheet(
      context: screenCtx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 8.h),
                Text(body,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 13.sp,
                        height: 1.45)),
                SizedBox(height: 20.h),
                _sheetPrimaryButton(
                  label: actionLabel,
                  icon: Icons.verified_user_outlined,
                  onPressed: () {
                    Navigator.of(sheetCtx).pop();
                    onAction();
                  },
                ),
                SizedBox(height: 6.h),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(sheetCtx).pop(),
                    child: Text('Not now',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reinstate a paused mandate, then reopen the deposit sheet so the user can
  /// deposit once it's active again.
  void _reinstateMandateThenRedeposit(
      LinkedBankAccount account, MandateEntity mandate) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    serviceLocator<MandateCubit>().reinstateMandate(
      mandateId: mandate.id,
      userId: authState.profile.user.id,
    );
    Get.snackbar('Direct Debit', 'Reinstating your Direct Debit...',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 2));
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _openRedepositSheet(context, account);
    });
  }

  /// Re-authorize an expired/cancelled mandate by creating a fresh one (in-app),
  /// then reopen the deposit sheet so the user can deposit via the new mandate.
  Future<void> _reauthorizeMandateThenRedeposit(LinkedBankAccount account) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final user = authState.profile.user;
    final ok = await showMandateSetupBottomSheet(
      context: context,
      linkedAccountId: account.id,
      userId: user.id,
      bankName: account.bankName,
      accountName: account.accountName,
      userEmail: user.email,
      userName: '${user.firstName} ${user.lastName}'.trim(),
    );
    if (ok && mounted) _openRedepositSheet(context, account);
  }

  /// Switch a persistent (Direct Debit) account back to one-time DirectPay by
  /// PAUSING its mandate. Reversible — "Switch to Direct Debit" reinstates it
  /// with no re-authorization. (Permanent revocation is "Manage Direct Debit →
  /// Cancel".) The badge flips to "One-time" once the cache refreshes.
  void _switchToOneTime(LinkedBankAccount account, MandateEntity mandate) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final userId = authState.profile.user.id;
    serviceLocator<MandateCubit>().pauseMandate(
      mandateId: mandate.id,
      userId: userId,
    );
    Get.snackbar(
      'Switching to one-time',
      'We’re confirming with your bank. Deposits from ${account.bankName} will '
          'use one-time approval — you can switch back anytime.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F1F1F),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    // Refresh once the pause response lands; the cubit's pauseMandate already
    // polls until Mono confirms so the "Switching…" chip settles to "One-time".
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _loadUserMandates();
    });
  }

  /// Switch a one-time account to persistent Direct Debit. If a PAUSED mandate
  /// exists, reinstate it instantly (no re-authorization). Otherwise create +
  /// authorize a fresh mandate (in-app Mono auth sheet). KYC gating happens in
  /// showMandateSetupBottomSheet / the backend (KYC_REQUIRED) — see Phase D for
  /// the proactive pre-flight check.
  Future<void> _switchToDirectDebit(
      LinkedBankAccount account, MandateEntity? mandate) async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final user = authState.profile.user;
    if (mandate != null && mandate.isPaused) {
      serviceLocator<MandateCubit>().reinstateMandate(
        mandateId: mandate.id,
        userId: user.id,
      );
      Get.snackbar(
        'Switching to Direct Debit',
        'We’re reactivating your Direct Debit with ${account.bankName}. Future '
            'deposits will skip bank login once it’s confirmed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      // The cubit's reinstateMandate already polls until Mono confirms, so the
      // "Switching…" chip settles to "Direct Debit" on its own.
      Future.delayed(const Duration(milliseconds: 700), () {
        if (mounted) _loadUserMandates();
      });
      return;
    }
    // No reusable mandate — create + authorize a fresh one.
    final ok = await showMandateSetupBottomSheet(
      context: context,
      linkedAccountId: account.id,
      userId: user.id,
      bankName: account.bankName,
      accountName: account.accountName,
      userEmail: user.email,
      userName: '${user.firstName} ${user.lastName}'.trim(),
    );
    if (!mounted) return;
    // Reload EITHER WAY so the card reflects the new state ("Setting up" on a
    // granted authorization; plain "One-time" when it wasn't granted).
    _loadUserMandates();
    if (ok) {
      Get.snackbar(
        'Setting up Direct Debit',
        'Authorization received — ${account.bankName} is activating your '
            'Direct Debit. Deposits use one-time approval until it is live.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.92),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
    if (!ok) {
      final m = serviceLocator<MandateCubit>().getMandateForAccount(account.id);
      final confirming = m != null &&
          (m.authAttemptedRecently ||
              MandateAuthAttemptStore.openedRecently(m.id));
      if (confirming) {
        // Authorization was granted on an earlier attempt and the bank is
        // still confirming — the card reads "Setting up"; match it (a
        // finish-setup nag would send them into the spent Mono link).
        Get.snackbar(
          'Setting up Direct Debit',
          'Your authorization is being confirmed by ${account.bankName} — this '
              'can take up to 30 minutes and completes automatically.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFB923C).withValues(alpha: 0.95),
          colorText: Colors.black,
          duration: const Duration(seconds: 4),
        );
      } else if (m != null && m.awaitingUserAuthorization) {
        // They started (a mandate exists) but abandoned the bank
        // authorization — point them at the resume path.
        Get.snackbar(
          'Setup not finished',
          'Your bank authorization wasn\'t completed. Open the '
              '${account.bankName} card menu and choose "Finish Direct Debit '
              'setup" to complete it.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.95),
          colorText: Colors.black,
          duration: const Duration(seconds: 4),
        );
      }
      // No mandate at all ("Not Now" on the explainer) — a deliberate
      // decline; respect it silently.
    }
  }

  /// Well-styled confirmation before flipping a linked account's deposit
  /// method. Both directions are reversible; the switch is applied on Mono
  /// (pause / reinstate the mandate) AND our backend — this sheet makes that
  /// explicit before we call it. Returns true only if the user confirms.
  Future<bool> _confirmPaymentMethodSwitch({
    required LinkedBankAccount account,
    required bool toDirectDebit,
  }) async {
    final accent =
        toDirectDebit ? const Color(0xFF10B981) : const Color(0xFF6366F1);
    final title = toDirectDebit
        ? 'Switch to Direct Debit?'
        : 'Switch to one-time (DirectPay)?';
    final currentLabel = toDirectDebit ? 'One-time' : 'Direct Debit';
    final newLabel = toDirectDebit ? 'Direct Debit' : 'One-time';
    final body = toDirectDebit
        ? 'Future deposits from ${account.bankName} will reuse your saved '
            'authorization — no bank login each time. We’ll reactivate '
            'your Direct Debit with ${account.bankName} instantly.'
        : 'You’ll approve each deposit from ${account.bankName} at your '
            'bank. We’ll pause your Direct Debit with ${account.bankName} '
            '— you can switch back anytime with no re-authorization.';
    final confirmLabel =
        toDirectDebit ? 'Switch to Direct Debit' : 'Switch to one-time';

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 18.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        toDirectDebit
                            ? Icons.autorenew_rounded
                            : Icons.touch_app_rounded,
                        color: accent,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Text(title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _switchMethodChip(currentLabel, const Color(0xFF6B7280)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Icon(Icons.arrow_forward_rounded,
                          color: Colors.white.withValues(alpha: 0.5),
                          size: 18.sp),
                    ),
                    _switchMethodChip(newLabel, accent),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(body,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 13.sp,
                        height: 1.45)),
                SizedBox(height: 22.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(sheetCtx).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text(confirmLabel,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(height: 4.h),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(sheetCtx).pop(false),
                    child: Text('Cancel',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return result ?? false;
  }

  /// A pill showing a payment-method label (current vs new) in the switch
  /// confirmation sheet.
  Widget _switchMethodChip(String label, Color color) {
    final isMuted = color == const Color(0xFF6B7280);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: TextStyle(
              color: isMuted ? Colors.white.withValues(alpha: 0.8) : color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600)),
    );
  }

  /// In-app authorization for a freshly created e-mandate (the recurring
  /// toggle flow). Opens Mono's hosted mandate authorization in OUR themed
  /// bottom sheet (DirectPayFlow.mandate chrome) — same sheet as one-time
  /// DirectPay — never an external browser. The deposit proceeds afterwards
  /// whether or not the user completes authorization: an unauthorized mandate
  /// just means THIS deposit uses one-time approval, and the mandate stays
  /// awaiting_authorization for the webhook + readiness reconciler to settle.
  Future<void> _authorizeMandateThenProceed(
      AccountLinkedWithMandate state) async {
    final url = state.mandateAuthorizationUrl!;
    final mandate = state.mandate;
    debugPrint('[Deposit] Opening in-app mandate authorization sheet');
    _progressController.updateStage(DirectPayStage.authorizing);

    final mandateId = mandate?.id ?? '';
    final result = await showDirectPayAuthorizationSheet(
      context: context,
      flow: DirectPayFlow.mandate,
      paymentUrl: url,
      paymentId: mandateId,
      reference: mandate?.reference,
      redirectPath: '/mandate/callback',
    );
    // Stamp ONLY on the explicit success callback — opening the widget means
    // nothing (a user can open/close it at will) and must not change state.
    // A granted authorization is the real signal: the mandate is now
    // provisioning with the bank/NIBSS, so surfaces render "Setting up" while
    // Mono converges. Server-side stamp so ANY device sees it; the local
    // store is the offline fallback.
    if (result.success && mandateId.isNotEmpty) {
      await MandateAuthAttemptStore.markOpened(mandateId);
      unawaited(serviceLocator<MandateCubit>().markAuthAttempt(mandateId));
    }
    if (!mounted) return;

    if (result.success) {
      // Background-refresh the mandate until Mono reports it ready. The
      // webhook + readiness reconciler cover missed updates server-side.
      final authState = context.read<AuthenticationCubit>().state;
      if (mandate != null && authState is AuthenticationSuccess) {
        serviceLocator<MandateCubit>().pollMandateStatus(
          mandateId: mandate.id,
          userId: authState.profile.user.id,
        );
      }
      Get.snackbar(
        'Direct Debit Authorized',
        'Future deposits from ${state.account.bankName} will be instant.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Direct Debit Pending',
        'You can finish the Direct Debit setup later. This deposit will use one-time approval.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // Proceed with THIS deposit now (one-time approval until the mandate is
    // ready to debit).
    _progressController.updateStage(DirectPayStage.initiating);
    _proceedWithMonoDeposit(context);
  }

  /// Fire a deposit from an existing linked account. Reuses the mandate when
  /// active (useRecurringAccess: true → DebitMandate); otherwise the backend
  /// returns a DirectPay auth URL which the listener opens in-app.
  /// Fee-disclosed, PIN-gated redeposit from a previously-linked account.
  /// Shows the aggregated deposit fee (Mono cost + LazerVault margin) on the
  /// transaction-PIN sheet BEFORE we pull — for BOTH rails (Direct Debit when a
  /// mandate is active, else one-time DirectPay). On a validated PIN it hands the
  /// minted token to [_depositFromLinkedAccount]; the backend PreValidates it.
  bool _confirmingRedeposit = false;

  Future<void> _confirmFeeAndDepositFromLinkedAccount(
      LinkedBankAccount account) async {
    // Guard against a double-tap opening two redeposit confirmations → two deposits.
    if (_confirmingRedeposit) return;
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) return;
    _confirmingRedeposit = true;
    try {
      await _runConfirmFeeAndDeposit(account, amount);
    } finally {
      if (mounted) _confirmingRedeposit = false;
    }
  }

  Future<void> _runConfirmFeeAndDeposit(
      LinkedBankAccount account, double amount) async {
    final recurring = _mandateForAccount(account) != null;

    // Rail-accurate aggregated fee (connect leg is 0 on a redeposit). Null only
    // on a backend hiccup — we still PIN-gate, just without a fee row (the amount
    // sheet already showed the worst-case inline preview).
    final quote = await serviceLocator<OpenBankingCubit>().fetchDepositFeeQuote(
      amountKobo: (amount * 100).round(),
      useRecurringAccess: recurring,
      firstTimeLink: false,
    );
    if (!mounted) return;
    double feeNaira;
    if (quote != null && quote.grandTotal > 0) {
      feeNaira = quote.grandTotal / 100.0;
    } else if (quote == null && (_feePreview.value?.fee ?? 0) > 0) {
      // Backend quote hiccup — fall back to the inline preview's (worst-case) fee so
      // the PIN sheet never shows ₦0 while the backend still nets a real deposit fee.
      feeNaira = _feePreview.value!.fee / 100.0;
    } else {
      feeNaira = 0.0;
    }

    final txnId = 'deposit-${account.id}-${DateTime.now().millisecondsSinceEpoch}';
    String? token;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'deposit',
      // The bank is debited `amount`; the fee is NETTED from it (wallet credited
      // amount − fee), never added on top — so the total pulled IS the amount.
      amount: amount,
      fee: feeNaira > 0 ? feeNaira : null,
      totalAmount: amount,
      currency: _currency,
      title: 'Deposit from ${account.bankName}',
      message: recurring
          ? 'Confirm this Direct Debit deposit with your PIN.'
          : 'Confirm this deposit with your PIN.',
      // Keep the PIN sheet a pure confirm step: it dismisses after "PIN Verified"
      // and the DirectPay progress sheet takes over (which also handles the
      // one-time DirectPay bank-authorization webview). No stacked sheets.
      showProcessingPhase: false,
      onPinValidated: (verificationToken) async {
        token = verificationToken;
      },
    );
    if (!mounted || !ok || token == null) return;
    _depositFromLinkedAccount(account,
        verificationToken: token, transactionId: txnId);
  }

  void _depositFromLinkedAccount(LinkedBankAccount account,
      {String? verificationToken, String? transactionId}) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) return;
    final destId = widget.selectedCard['id']?.toString() ?? '';
    if (destId.isEmpty) {
      Get.snackbar('Error', 'Missing destination account.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white);
      return;
    }
    final recurring = _mandateForAccount(account) != null;
    _selectedBank = account.bankName;
    _linkedAccountId = account.id;
    // Arm "Try Again" on the failure sheet to re-run the fee+PIN confirm (a fresh
    // PIN token is minted each attempt — reusing a stale one would be rejected).
    _retryDeposit = () => _confirmFeeAndDepositFromLinkedAccount(account);
    // Already-linked bank: the rail starts at "Preparing Deposit" — there is
    // no linking step on a redeposit.
    _progressController.show(
      bankName: account.bankName,
      amount: amount,
      currency: _currency,
      flow: DirectPayProgressFlow.redeposit,
    );
    _showProgressBottomsheet(context);
    serviceLocator<OpenBankingCubit>().initiateDeposit(
      userId: authState.profile.user.id,
      linkedAccountId: account.id,
      destinationAccountId: destId,
      amount: amount,
      narration: 'Deposit from ${account.bankName}',
      accessToken: authState.profile.session.accessToken,
      currency: _currency,
      countryCode: _countryCodeForCurrency(_currency),
      useRecurringAccess: recurring,
      verificationToken: verificationToken,
      transactionId: transactionId,
    );
  }

  /// Per-account action sheet: deposit, switch mode, manage recurring, unlink.
  void _showAccountActions(BuildContext screenCtx, LinkedBankAccount account) {
    final mandate = _mandateForAccount(account); // active mandate (for Manage)
    // Raw mandate of ANY status — drives the DirectPay⇄Direct-Debit switch.
    final rawMandate = serviceLocator<MandateCubit>().getMandateForAccount(account.id);
    final isPersistent = rawMandate != null && rawMandate.isActive;
    // Direct Debit authorized but still activating with NIBSS — it's already
    // being set up, so we show status (not a "switch to Direct Debit" CTA).
    final isActivating = rawMandate != null && rawMandate.isActivating;
    // A deposit-method switch is mid-flight (awaiting Mono confirmation) — show a
    // read-only "in progress" tile instead of a switch CTA so we don't fire a
    // second pause/reinstate before the first settles.
    final isSwitching = rawMandate != null && rawMandate.switchProcessing;
    final switchingToDirectDebit = isSwitching && rawMandate.isSwitchingToDirectDebit;
    // Awaiting authorization BUT the auth widget was opened recently (this or
    // any device): the payment leg is likely done and Mono is confirming at
    // the bank — the link is SPENT, so show "Setting up" status instead of a
    // Finish-setup CTA that would dead-end. Mirrors _accessModeForAccount.
    final isConfirmingAuth = rawMandate != null &&
        rawMandate.awaitingUserAuthorization &&
        (rawMandate.authAttemptedRecently ||
            MandateAuthAttemptStore.openedRecently(rawMandate.id));
    if (isConfirmingAuth) _pollConfirmingMandate(rawMandate.id);
    showModalBottomSheet(
      context: screenCtx,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2.r)),
              ),
              SizedBox(height: 8.h),
              ListTile(
                leading: Icon(Icons.refresh, color: Colors.white.withValues(alpha: 0.85)),
                title: Text('Deposit from ${account.bankName}', style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                onTap: () {
                  Navigator.of(sheetCtx).pop();
                  _openRedepositSheet(context, account);
                },
              ),
              // Switch between one-time (DirectPay) and persistent (Direct Debit).
              if (isSwitching)
                ListTile(
                  leading: const Icon(Icons.sync, color: Color(0xFF818CF8)),
                  title: Text(
                      switchingToDirectDebit
                          ? 'Switching to Direct Debit…'
                          : 'Switching to one-time…',
                      style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                  subtitle: Text(
                      'We’re confirming this change with your bank. It’ll settle shortly.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
                  onTap: () => Navigator.of(sheetCtx).pop(),
                )
              else if (isPersistent)
                ListTile(
                  leading: Icon(Icons.schedule, color: const Color(0xFF9CA3AF)),
                  title: Text('Switch to DirectPay (one-time)', style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                  subtitle: Text('Approve each deposit at your bank; switch back anytime', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
                  onTap: () async {
                    Navigator.of(sheetCtx).pop();
                    final ok = await _confirmPaymentMethodSwitch(
                        account: account, toDirectDebit: false);
                    if (ok && mounted) _switchToOneTime(account, rawMandate);
                  },
                )
              else if (isActivating || isConfirmingAuth)
                // Already authorized + activating with NIBSS, OR the user just
                // completed the auth widget and Mono is confirming it at the
                // bank (spent link). Either way it's already being set up —
                // show status, not a "Finish setup" CTA. Tap opens the same
                // info modal as the card badge.
                ListTile(
                  leading: Icon(Icons.hourglass_bottom, color: const Color(0xFFFB923C)),
                  title: Text('Setting up Direct Debit', style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                  subtitle: Text(
                      isActivating
                          ? 'Authorized. Activating with your bank. Deposits use one-time approval until it is live.'
                          : 'Confirming your authorization with your bank — this can take up to 30 minutes and completes automatically.',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
                  trailing: Icon(Icons.info_outline, color: const Color(0xFFFB923C).withValues(alpha: 0.85), size: 18.sp),
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _showDirectDebitSetupInfo(account);
                  },
                )
              else
                ListTile(
                  leading: Icon(
                      rawMandate != null && rawMandate.awaitingUserAuthorization
                          ? Icons.touch_app_outlined
                          : Icons.link,
                      color: rawMandate != null && rawMandate.awaitingUserAuthorization
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFF10B981)),
                  title: Text(
                      rawMandate != null && rawMandate.awaitingUserAuthorization
                          ? 'Finish Direct Debit setup'
                          : 'Switch to Direct Debit (persistent)',
                      style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                  subtitle: Text(
                      rawMandate != null && rawMandate.awaitingUserAuthorization
                          ? 'Your bank authorization wasn\'t completed. Tap to finish.'
                          : 'Skip bank login on future deposits',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
                  onTap: () async {
                    Navigator.of(sheetCtx).pop();
                    // A paused mandate reinstates instantly (a real Mono state
                    // change) — confirm first. With no reusable mandate,
                    // _switchToDirectDebit opens the Mono authorization setup
                    // sheet, which is itself the confirmation + auth step.
                    final hasReusable = rawMandate != null && rawMandate.isPaused;
                    if (hasReusable) {
                      final ok = await _confirmPaymentMethodSwitch(
                          account: account, toDirectDebit: true);
                      if (!ok || !mounted) return;
                    }
                    _switchToDirectDebit(account, rawMandate);
                  },
                ),
              if (mandate != null)
                ListTile(
                  leading: Icon(Icons.tune, color: Colors.white.withValues(alpha: 0.7)),
                  title: Text('Manage Direct Debit', style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                  subtitle: Text('Pause, reinstate or cancel', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp)),
                  onTap: () {
                    Navigator.of(sheetCtx).pop();
                    _manageMandate(context, mandate);
                  },
                ),
              ListTile(
                leading: Icon(Icons.link_off, color: const Color(0xFFEF4444)),
                title: Text('Unlink ${account.bankName}', style: TextStyle(color: const Color(0xFFEF4444), fontSize: 15.sp)),
                onTap: () {
                  Navigator.of(sheetCtx).pop();
                  _confirmUnlink(account);
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Unlink a bank account, with confirmation. Cancels any mandate + removes
  /// the Mono link (banking-service UnlinkBankAccount → Mono UnlinkAccount).
  Future<void> _confirmUnlink(LinkedBankAccount account) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Unlink ${account.bankName}?', style: const TextStyle(color: Colors.white)),
        content: Text(
          'You will need to re-link this bank to deposit from it again. Any persistent authorisation will be cancelled.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Unlink', style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    serviceLocator<OpenBankingCubit>().unlinkAccount(
      accountId: account.id,
      userId: authState.profile.user.id,
      accessToken: authState.profile.session.accessToken,
    );
  }

  /// "View all" — every linked bank as a row with deposit + manage + unlink.
  void _showAllAccountsSheet(BuildContext screenCtx) {
    showModalBottomSheet(
      context: screenCtx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(sheetCtx).size.height * 0.8),
        decoration: BoxDecoration(
          // Lighter, airier surface than the old near-black sheet.
          color: const Color(0xFF26262E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(2.r)),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 18.h, 22.w, 2.h),
                child: Text('Your linked banks',
                    style: TextStyle(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 10.h),
                child: Text(
                  '${_linkedAccounts.length} ${_linkedAccounts.length == 1 ? 'account' : 'accounts'}. Persistent banks let you deposit again without re-approving.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12.sp),
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(18.w, 4.h, 18.w, 24.h),
                  children: _linkedAccounts.map((a) => _buildLinkedAccountRow(context, a)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bank logo (bundled asset keyed by bank code, gradient-initials fallback).
  Widget _bankLogoAvatar(String bankName, {String? bankCode, double size = 42}) {
    return BankLogo(
      bankName: bankName,
      bankCode: bankCode,
      size: size,
      borderRadius: 12,
    );
  }

  /// One-time vs Persistent access chip for a linked account.
  /// The deposit-mode of a linked account, for the card badge:
  /// "persistent" (active mandate), "pending" (mandate mid-authorization), or
  /// "onetime" (no usable mandate). A pending mandate must NOT read as
  /// "one-time" — it's a Direct Debit being set up.
  String _accessModeForAccount(LinkedBankAccount account) {
    final m = serviceLocator<MandateCubit>().getMandateForAccount(account.id);
    if (m == null) return 'onetime';
    // A deposit-method switch awaiting Mono confirmation takes precedence over
    // the (still-transitioning) status so the card shows "Switching…" instead of
    // prematurely flipping to the destination and then reverting.
    if (m.switchProcessing) return 'switching';
    if (m.isActive) return 'persistent';
    if (m.isActivating) return 'pending';
    if (m.awaitingUserAuthorization) {
      // Authorization GRANTED recently (any device — the stamp is only written
      // on the widget's explicit success callback): Mono/the bank is
      // provisioning the mandate, so show "Setting up" and poll to converge.
      if (m.authAttemptedRecently || MandateAuthAttemptStore.openedRecently(m.id)) {
        _pollConfirmingMandate(m.id);
        return 'pending';
      }
      // Mandate exists but authorization was never granted (the user merely
      // opened/closed the Mono widget, or never opened it). Deposits use the
      // one-time rail, so the badge honestly reads "One-time" — resuming the
      // Direct Debit setup stays available in the account action sheet.
      return 'onetime';
    }
    return 'onetime';
  }

  // Throttled status poll for a mandate whose authorization is confirming at
  // the bank — flips the card to Direct Debit as soon as Mono reports it.
  DateTime? _lastConfirmingPoll;
  void _pollConfirmingMandate(String mandateId) {
    final now = DateTime.now();
    if (_lastConfirmingPoll != null &&
        now.difference(_lastConfirmingPoll!) < const Duration(seconds: 30)) {
      return;
    }
    _lastConfirmingPoll = now;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    serviceLocator<MandateCubit>().pollMandateStatus(
      mandateId: mandateId,
      userId: authState.profile.user.id,
    );
  }

  /// State-coloured edge for a linked-account card: green when Direct Debit is
  /// active, amber while it's setting up, soft purple for one-time only.
  Color _cardAccentColor(String mode) {
    switch (mode) {
      case 'persistent':
        return const Color(0xFF10B981); // green — active Direct Debit
      case 'pending':
        return const Color(0xFFFB923C); // amber — setting up
      case 'switching':
        return const Color(0xFF818CF8); // indigo — switch awaiting confirmation
      default:
        return const Color(0xFF7C5CFF); // soft purple — one-time
    }
  }

  /// Thin mapper onto the shared [LinkedAccountStateChip] so Deposit, Beam,
  /// Withdrawal and budgeting all render the SAME pill. Pass [onTap] to open
  /// the access-mode info modal.
  Widget _accessChip({required String mode, VoidCallback? onTap, bool showInfo = false}) {
    final state = mode == 'persistent'
        ? LinkedAccountState.directDebit
        : mode == 'switching'
            ? LinkedAccountState.switching
            : mode == 'pending'
                ? LinkedAccountState.settingUp
                : LinkedAccountState.oneTime;
    return LinkedAccountStateChip(state: state, onTap: onTap, showInfoAffordance: showInfo);
  }

  Widget _buildLinkedAccountRow(BuildContext context, LinkedBankAccount account) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          _bankLogoAvatar(account.bankName, bankCode: account.bankCode),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.bankName.isNotEmpty ? account.bankName : 'Linked bank',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(account.displayAccountNumber,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12.sp)),
                    ),
                    SizedBox(width: 8.w),
                    Builder(builder: (rowCtx) {
                      final rowMode = _accessModeForAccount(account);
                      return _accessChip(
                        mode: rowMode,
                        onTap: () => _showAccessModeInfo(rowMode, account),
                        showInfo: true,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showAccountActions(context, account),
            icon: Icon(Icons.more_vert, color: Colors.white.withValues(alpha: 0.7), size: 20.sp),
          ),
        ],
      ),
    );
  }

  void _manageMandate(BuildContext context, MandateEntity mandate) {
    final authState = context.read<AuthenticationCubit>().state;
    final userId = authState is AuthenticationSuccess ? authState.profile.user.id : '';
    showMandateManagementBottomSheet(
      context: context,
      linkedAccountId: mandate.linkedAccountId,
      userId: userId,
      bankName: mandate.bankName,
      accountName: mandate.accountName,
      mandate: mandate,
    ).then((_) {
      if (mounted) {
        _loadUserMandates();
        _loadLinkedAccounts();
      }
    });
  }


  /// BANK TRANSFER — show the account details to copy. accounts-service is the
  /// single source of truth for accounts + virtual-account details; the
  /// selectedCard already carries them (account_name / account_number /
  /// bank_name), so we read straight from it — nothing constructed.
  Widget _buildBankTransferContent(BuildContext context) {
    // A VA we just provisioned in-session (verified user who had none) wins, so
    // the details appear immediately without needing to re-open the screen.
    final accountNumber = (_provisionedAccountNumber ??
        widget.selectedCard['accountNumber'] ??
        widget.selectedCard['account_number'] ?? '') as String;
    final accountName = (_provisionedAccountName ??
        widget.selectedCard['accountName'] ??
        widget.selectedCard['account_name'] ?? '') as String;
    final bankName = (_provisionedBankName ??
        widget.selectedCard['bankName'] ??
        widget.selectedCard['bank_name'] ?? '') as String;
    final authState = context.read<AuthenticationCubit>().state;
    final userId =
        authState is AuthenticationSuccess ? authState.profile.user.id : null;

    // No REAL NUBAN provisioned yet (backend sends an empty account_number until
    // a Flutterwave NUBAN is minted, which requires a KYC-verified BVN). Never
    // show an empty/synthetic number as a deposit target — route the user into
    // verification instead. Once KYC completes and the BVN-retry worker mints the
    // real NUBAN, accounts-service starts sending it and this card hydrates the
    // real bank/number/holder on the next dashboard refresh (no re-login needed).
    if (accountNumber.trim().isEmpty) {
      return _buildActivateAccountState();
    }

    return PayByTransferCard(
      accountNumber: accountNumber,
      accountName: accountName,
      bankName: bankName,
      accountId: widget.selectedCard['id'] is String
          ? widget.selectedCard['id'] as String
          : widget.selectedCard['id']?.toString(),
      userId: userId,
      currency: _currency,
      countryCode: _countryCodeForCurrency(_currency),
    );
  }

  /// Shown on the Bank Transfer tab when the wallet has no real NUBAN yet.
  /// Presents a clear "Complete verification to activate your account" state
  /// (never a mock or an empty number) that routes into the BVN/KYC flow and
  /// resumes the deposit on return via [_saveAndGoToKyc].
  Widget _buildActivateAccountState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified_user_outlined,
                  color: const Color(0xFF2962FF), size: 22.r),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Complete verification to activate your account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'Your deposit account number is created after a quick BVN identity '
            'check. Verify once and your bank account details appear here '
            'automatically — no need to sign in again.',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75), fontSize: 13.sp),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2962FF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              onPressed: _activatingAccount ? null : _activateBankTransferAccount,
              child: _activatingAccount
                  ? SizedBox(
                      height: 18.r,
                      width: 18.r,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Verify Now'),
            ),
          ),
        ],
      ),
    );
  }

  /// A verified user landed on Bank Transfer without a NUBAN yet (their VA mint
  /// is async, or an older account pre-dates auto-provisioning). Provision it on
  /// demand instead of bouncing them back into KYC — which just loops with
  /// "already verified". Only a genuinely UNVERIFIED user is routed to KYC.
  /// Shows a spinner on the CTA throughout; the minted NUBAN renders in-session.
  Future<void> _activateBankTransferAccount() async {
    if (_activatingAccount) return;
    setState(() => _activatingAccount = true);
    // Single source of truth: the central VA gate. It runs the ONE check
    // (does the NUBAN exist?), shows the blocking "Setting up your account" modal
    // while minting when it doesn't (minting requires the BVN KYC), routes to
    // verification when that isn't possible, and controls the flow via modals —
    // no separate Prove-status check, no snackbars.
    final res = await ensureDepositReady(
      context,
      accountHasVirtualAccount: _targetHasVirtualAccount,
      currency: _currency,
      isPrimary: widget.selectedCard['isPrimary'] == true,
    );
    if (!mounted) return;
    setState(() => _activatingAccount = false);
    if (res.status == DepositReadiness.ready && res.mintedAccountNumber != null) {
      setState(() {
        _provisionedAccountNumber = res.mintedAccountNumber;
        _provisionedAccountName = res.mintedAccountName ?? _provisionedAccountName;
        _provisionedBankName = res.mintedBankName ?? _provisionedBankName;
      });
    } else if (res.status == DepositReadiness.provisioning) {
      await showAccountSetupPendingModal(context);
    }
    // needsKyc → verification took over inside the gate; nothing to do here.
  }

  /// APPLE PAY / CARD — Flutterwave hosted checkout. The CTA initiates the
  /// deposit; on DepositRequiresAuthorization the listener opens the secure
  /// checkout webview.

  /// Validate + kick off a Flutterwave-mediated deposit (Apple Pay / Card).
  /// On success the cubit emits DepositRequiresAuthorization and the bloc
  /// listener opens the hosted-checkout webview.
  void _startFlutterwaveDeposit(
    BuildContext context, {
    required String paymentMethod,
    required String sourceLabel,
  }) {
    FocusScope.of(context).unfocus();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (amount <= 0) {
      Get.snackbar('Invalid Amount', 'Please enter a valid amount to deposit.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white);
      return;
    }
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar('Authentication Error', 'You need to be logged in to make a deposit.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white);
      return;
    }
    final targetAccountId = (widget.selectedCard['id'] ?? '').toString();
    if (targetAccountId.isEmpty) {
      Get.snackbar('Error', 'Missing account information for this wallet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white);
      return;
    }
    serviceLocator<DepositCubit>().initiateDeposit(
          targetAccountId: targetAccountId,
          amount: amount,
          currency: _currency,
          sourceBankName: sourceLabel,
          countryCode: _countryCodeForCurrency(_currency),
          accessToken: authState.profile.session.accessToken,
          paymentMethod: paymentMethod,
        );
  }

  /// Open the Flutterwave hosted checkout for an authorization-required
  /// deposit (Apple Pay / Card). Shared by the bloc listener.
  Future<void> _openFlutterwaveCheckout(String paymentUrl, String depositId) async {
    if (!mounted) return;
    final result = await showFlutterwavePaymentSheet(
      context: context,
      paymentUrl: paymentUrl,
      depositId: depositId,
    );
    if (!mounted) return;
    if (!result.success) {
      // Cancelled / failed on the checkout side. The webhook never credits
      // (we only credit on a VERIFIED Flutterwave success), so just surface it;
      // no balance moved. The deposit row stays pending until the reconciler
      // confirms with Flutterwave (it won't credit a charge the user abandoned).
      _showDepositFailure(result.errorMessage ?? 'Payment was not completed');
      return;
    }
    // SUCCESS on the checkout side. The banking webhook is the primary credit
    // path (charge.completed → verify → CreditBalance) and the WebSocket emits
    // DepositWebSocketCompleted → dashboard redirect. As a BACKSTOP for a
    // missed/delayed webhook, also poll GetDepositStatus, which hits the
    // backend verify-on-return (re-verifies with Flutterwave + credits on read).
    // The credit is idempotent (deposit-{id}), so webhook + poll can't
    // double-credit.
    _currentDepositId = depositId;
    if (mounted) {
      _pollDepositSettlement(context);
    }
  }

  /// Shared "How Mono Direct Debit Works" info block.
  Widget _buildMonoHowItWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white.withValues(alpha: 0.7), size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'How Mono Direct Debit Works',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              _buildInfoItem(Icons.lock_outline, 'Bank-grade security'),
              SizedBox(height: 8.h),
              _buildInfoItem(Icons.flash_on, 'Instant deposits'),
              SizedBox(height: 8.h),
              _buildInfoItem(Icons.credit_card_off, 'No card details needed'),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'By continuing, you agree to Mono\'s End-user Policy. Mono will have read-only access to your account.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 11.sp,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// Info item widget for the "How Mono Works" section
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 78, 3, 208),
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  /// Launch the NGN Mono Connect SDK with DirectPay/Mandate support
  void _launchNGNMonoBottomsheet(BuildContext context) async {
    // Bank-linking (Link & Deposit) is only offered on the PERSONAL account.
    // On any other account type show the themed "personal account only" modal
    // (pointing to bank transfer / card / LazerBeam) instead of opening Mono
    // Connect. Fails open on missing metadata so a personal deposit is never
    // wrongly blocked; the backend also caps linked-bank count separately.
    if (!canLinkBankForAccountType(
        widget.selectedCard['accountType']?.toString())) {
      showPersonalAccountOnlyLinkDialog(context);
      return;
    }

    // Validate amount first
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText) ?? 0;

    if (amount < 200) {
      Get.snackbar(
        'Invalid Amount',
        'Minimum deposit amount is ₦200',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (amount > 1000000) {
      Get.snackbar(
        'Invalid Amount',
        'Maximum deposit amount is ₦1,000,000',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Authentication Error',
        'You need to be logged in to make a deposit.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    if (!MonoConfig.isEnabled) {
      Get.snackbar(
        'Configuration Error',
        'Open banking is not configured. Please contact support.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    debugPrint('[MonoConnect] Amount validated: ₦$amount');
    debugPrint('[MonoConnect] Recurring access mode: $_useRecurringAccess');

    final user = authState.profile.user;
    final userId = user.id;
    final accessToken = authState.profile.session.accessToken;
    final customerName = '${user.firstName} ${user.lastName}'.trim();
    final customerEmail = user.email;

    debugPrint('[MonoConnect] Launching Mono Connect SDK');
    debugPrint('[MonoConnect] Customer: $customerName ($customerEmail)');
    debugPrint('[MonoConnect] User ID: $userId');

    // FEE CONSENT FIRST — before the Mono Connect webview, never after (a
    // post-link fee is a surprise charge). Fetch the REAL, broken-down fees for
    // this deposit — the one-time bank-connection fee plus this deposit's fee for
    // the chosen rail (Direct Debit vs one-time) — and show the consolidated
    // agreement sheet. Fee-aware: a zero-fee quote needs no sheet at all; if the
    // quote can't be fetched (backend hiccup) we fall back to the generic notice
    // so we NEVER link without some consent. On decline we abort before the webview.
    final quote = await serviceLocator<OpenBankingCubit>().fetchDepositFeeQuote(
      amountKobo: (amount * 100).round(),
      useRecurringAccess: _useRecurringAccess,
      firstTimeLink: true, // this Link & Deposit path always runs Mono Connect
    );
    if (!mounted) return;
    if (quote != null && !quote.isFree) {
      final proceed = await showDepositFeeAgreementSheet(context, quote);
      if (!proceed || !mounted) {
        debugPrint('[MonoConnect] User declined the fee agreement — aborting link');
        return;
      }
    } else if (quote == null) {
      final proceed = await showBankConnectionFeeNotice(context);
      if (!proceed || !mounted) {
        debugPrint('[MonoConnect] User declined the connection-fee notice — aborting link');
        return;
      }
    }
    // else: quote.isFree → no fees configured, proceed straight to the webview.
    // One idempotency id for this whole link attempt.
    final txnId = 'link-${DateTime.now().millisecondsSinceEpoch}';

    // Remember how to re-run this exact deposit if it fails and the user
    // taps "Try Again". Uses the State's own context (valid while mounted).
    _retryDeposit = () => _launchNGNMonoBottomsheet(this.context);

    // Launch Mono Connect SDK (only after the fee has been acknowledged).
    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: customerEmail.isNotEmpty ? customerEmail : null,
      reference: 'lzv_deposit_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (result != null) {
      debugPrint('[MonoConnect] Success - Code: ${result.code.substring(0, result.code.length > 10 ? 10 : result.code.length)}...');
      debugPrint('[MonoConnect] Institution: ${result.institutionName ?? result.institutionId ?? 'unknown'}');

      // Show progress bottomsheet + link. Fresh-link journeys start at "Linking
      // Account"; with the recurring toggle ON the rail reads as Direct Debit
      // setup. The fee was already consented to above, so link straight through.
      final obc = serviceLocator<OpenBankingCubit>();
      _progressController.show(
        bankName: result.institutionName ?? 'Bank',
        amount: amount,
        currency: _currency,
        flow: _useRecurringAccess
            ? DirectPayProgressFlow.mandateSetup
            : DirectPayProgressFlow.linkAndDeposit,
      );
      if (!mounted) return;
      _showProgressBottomsheet(context);
      obc.linkAccount(
        userId: userId,
        code: result.code,
        accessToken: accessToken,
        transactionId: txnId,
        // Honour the Direct Debit toggle: only auto-create a mandate when the
        // user opted into recurring access. Left to its default (true) this
        // ALWAYS created a Mono mandate at link time — so a user who turned
        // Direct Debit OFF (wanting one-time DirectPay) still got the "Set up
        // Direct Debit" authorization sheet and a stuck `awaiting_authorization`
        // mandate they never asked for. false ⇒ cubit emits AccountLinked ⇒ the
        // listener goes straight to one-time DirectPay, no mandate created.
        autoCreateMandate: _useRecurringAccess,
      );
    } else {
      debugPrint('[MonoConnect] User cancelled or closed');
    }
  }

  /// Show the DirectPay progress bottomsheet
  void _showProgressBottomsheet(BuildContext context) {
    if (_isProgressSheetShown) return;
    _isProgressSheetShown = true;
    _startLinkWatchdog();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      // NOTE: the sheet POPS ITS OWN modal route (DirectPayProgressBottomsheet
      // ._dismiss) before invoking these callbacks — so these are POST-dismiss
      // side effects ONLY and must NOT pop again (double-pop would remove the
      // wrong route). whenComplete below resets _isProgressSheetShown.
      // AutoLogoutSuppressed: the user may background the app mid-flow (e.g.
      // to approve/send the payment from their bank app) while this rail waits
      // on the webhook — auto-logout must not fire until the sheet closes.
      builder: (sheetContext) => AutoLogoutSuppressed(
          child: DirectPayProgressBottomsheet(
        controller: _progressController,
        onSuccess: () {
          _isProgressSheetShown = false;
          // The dashboard's WebSocket "Funds Received" banner is the SINGLE
          // in-app deposit confirmation (dashboard_card_summary). The sheet
          // already showed "Deposit Successful", so we don't stack a second
          // snackbar here (that was the double-snackbar bug).
          _navigateToDashboard();
        },
        onDismiss: () {
          _isProgressSheetShown = false;
          // Stays on the deposit form so the user can adjust the amount /
          // bank and try again. (Route already popped by the sheet.)
        },
        onRetry: () {
          _isProgressSheetShown = false;
          // Re-run the exact deposit the user last started.
          final retry = _retryDeposit;
          if (retry != null) {
            retry();
          }
        },
        onExit: () {
          _isProgressSheetShown = false;
          _navigateToDashboard();
        },
        onKycVerify: () {
          // KYC-required terminal state: the sheet already popped its route;
          // save the in-flight deposit + route into BVN verification. Backing
          // out of KYC returns the user to a clean deposit screen (no spinner).
          _isProgressSheetShown = false;
          _cancelLinkWatchdog();
          _saveAndGoToKyc();
        },
      )),
    ).whenComplete(() {
      _isProgressSheetShown = false;
      _cancelLinkWatchdog();
    });
  }

  /// Single, idempotent handler for a CONFIRMED-credited deposit. Driven only
  /// by DepositStatusUpdated(successful) (banking's authoritative post-credit
  /// status) — so the success UI (balance refresh, navigation, snackbar) can
  /// never fire merely because the card payment sheet closed. Shows the success
  /// only once real money has credited the wallet.
  bool _depositSettledHandled = false;
  void _handleDepositSettled(BuildContext context) {
    if (_depositSettledHandled) return;
    _depositSettledHandled = true;

    // Pull fresh, server-authoritative balances.
    _refreshAccountBalances(context);

    if (_isProgressSheetShown) {
      // Mono DirectPay/mandate: the black progress sheet shows "Deposit
      // Successful" here, then its onSuccess callback navigates (no flash).
      _progressController.updateStage(DirectPayStage.success);
    } else {
      // Card / Apple Pay (no progress sheet): route to the dashboard, where the
      // WebSocket "Funds Received" banner + animated balance update are the
      // single in-app deposit confirmation (no second screen snackbar).
      _navigateToDashboard();
    }
  }

  /// Navigate back to dashboard after successful deposit
  // Guards against the redirect firing more than once (the success stage
  // can be observed by both the poll listener and the sheet's timer).
  bool _dashboardRedirectDone = false;

  void _navigateToDashboard() {
    if (_dashboardRedirectDone) return;
    _dashboardRedirectDone = true;

    // Clear form
    _amountController.clear();

    // Go straight to the dashboard, clearing the whole navigation stack.
    // Get.offAllNamed removes every route (including any still-open modal
    // bottom sheet) and pushes DashboardScreen fresh — so it loads the
    // updated balance. The previous Get.until((route) => route.isFirst)
    // landed on the INITIAL route (authCheck), not the dashboard, which is
    // why the redirect appeared to do nothing.
    Get.offAllNamed(AppRoutes.dashboard);
  }

  /// Success snackbar shown AFTER navigating to the dashboard. Get.snackbar
  /// is a global overlay, so it renders over the dashboard regardless of the
  /// route change. Guarded so the same deposit only shows it once.
  /// The deposit action to re-run when the user taps "Try Again" on a
  /// retryable failure. Set whenever a deposit is launched so the retry
  /// reproduces the same flow (same launcher) the user started.
  VoidCallback? _retryDeposit;

  /// Map a raw provider/backend error into user-friendly copy + whether
  /// retrying the SAME deposit could plausibly succeed. Covers both Mono and
  /// Flutterwave error shapes (the failure surfaces through the same listener
  /// regardless of which provider the backend routed to).
  _DepositFailureInfo _classifyDepositFailure(String? raw) {
    final msg = (raw ?? '').toLowerCase();

    bool has(List<String> needles) => needles.any(msg.contains);

    // --- Terminal: retrying the identical request won't help -------------
    if (has(['insufficient', 'not enough', 'wallet_empty', 'low balance'])) {
      return const _DepositFailureInfo(
        'Insufficient Funds',
        'There were not enough funds in your bank account to complete this deposit.',
        retryable: false,
      );
    }
    if (has(['currency', 'mismatch'])) {
      return const _DepositFailureInfo(
        'Currency Mismatch',
        "This bank account's currency doesn't match the wallet you're funding. Pick a matching account.",
        retryable: false,
      );
    }
    if (has(['not supported', 'unsupported', 'country', 'no provider'])) {
      return const _DepositFailureInfo(
        'Not Supported Yet',
        "We can't fund this wallet from that bank or region yet. Try a different account.",
        retryable: false,
      );
    }
    if (has(['limit', 'exceeded', 'maximum', 'too large'])) {
      return const _DepositFailureInfo(
        'Limit Reached',
        'This deposit goes over your allowed limit. Try a smaller amount.',
        retryable: false,
      );
    }
    if (has(['frozen', 'suspended', 'closed', 'blocked', 'restricted'])) {
      return const _DepositFailureInfo(
        'Account Unavailable',
        'This account can\'t receive deposits right now. Please contact support.',
        retryable: false,
      );
    }
    if (has(['mandate']) &&
        has(['paused', 'expired', 'inactive', 'cancelled', 'canceled', 'revoked'])) {
      return const _DepositFailureInfo(
        'Authorization Needed',
        'Your saved bank authorization is no longer active. Link your bank again to continue.',
        retryable: true,
      );
    }
    // Backend refused to run an unpinned debit because it couldn't confirm the
    // linked bank's account details — surfaced so we NEVER charge the wrong bank.
    // Re-linking re-fetches a clean NUBAN + bank code.
    if (has([
      'bank_details_unverified',
      "couldn't confirm your",
      're-link your bank',
      'relink your bank',
      'account details for this deposit',
    ])) {
      return const _DepositFailureInfo(
        'Re-link Your Bank',
        "We couldn't confirm your linked bank's details for this deposit, so we didn't charge any account. Re-link your bank to continue — it takes a few seconds.",
        retryable: true,
        retryLabel: 'Re-link bank',
      );
    }

    // --- Retryable: transient / user-recoverable -------------------------
    if (has(['cancel', 'closed', 'dismissed', 'aborted', 'user_closed'])) {
      return const _DepositFailureInfo(
        'Authorization Cancelled',
        'You closed the authorization before it finished. Tap Try Again to continue.',
        retryable: true,
      );
    }
    if (has(['timeout', 'timed out', 'deadline'])) {
      return const _DepositFailureInfo(
        'Taking Too Long',
        'Your bank took too long to respond. Please try again.',
        retryable: true,
      );
    }
    if (has([
      'network',
      'unavailable',
      'connection',
      'unreachable',
      'circuit',
      '503',
      '502',
      'temporarily',
      'try again',
    ])) {
      return const _DepositFailureInfo(
        'Connection Problem',
        "We couldn't reach your bank just now. Check your connection and try again.",
        retryable: true,
      );
    }

    // --- Default: unknown → let the user retry ---------------------------
    return const _DepositFailureInfo(
      'Deposit Failed',
      'Something went wrong completing your deposit. Please try again.',
      retryable: true,
    );
  }

  /// True when a backend error message signals the identity-verification gate.
  /// The gate surfaces in several shapes across paths (link, DirectPay deposit,
  /// mandate setup, REST vs gRPC), so we match the canonical code AND the
  /// human-readable variants. The discriminating error CODE
  /// (`OpenBankingError.errorCode == 'KYC_REQUIRED'`) is preferred where
  /// available (see [_openBankingListener]); this is the message-only net for
  /// paths that surface only text (e.g. a persisted `failureReason`).
  bool _isKycError(String? raw) {
    final lower = (raw ?? '').toLowerCase();
    if (lower.isEmpty) return false;
    return lower.contains('kyc_required') ||
        lower.contains('kyc required') ||
        lower.contains('verify your identity') ||
        lower.contains('identity verification required') ||
        lower.contains('verify your bvn') ||
        (lower.contains('bvn') && lower.contains('required'));
  }

  /// Push a classified failure into the progress sheet — UNLESS the backend
  /// signalled the KYC gate, in which case route the user into identity
  /// verification (DirectPay/Direct Debit refuse without a verified BVN).
  void _showDepositFailure(String? raw) {
    if (_isKycError(raw)) {
      _goToKycThenResume(
        snackbarMessage:
            'Complete a quick BVN verification to deposit from your bank account.',
      );
      return;
    }

    final info = _classifyDepositFailure(raw);
    _progressController.updateStage(
      DirectPayStage.failed,
      errorTitle: info.title,
      errorMessage: info.message,
      retryable: info.retryable,
      retryLabel: info.retryLabel,
    );
  }

  /// The backend gated this deposit/mandate on identity verification. Instead
  /// of auto-navigating to KYC (which used to leave the dark progress sheet
  /// orphaned and stuck-spinning underneath the BVN screen — `Get.back` never
  /// pops a `showModalBottomSheet`/Navigator sheet because `isBottomSheetOpen`
  /// is false for it), drive the progress sheet into a clear KYC-required
  /// TERMINAL state. The user then chooses:
  ///   - "Verify Now"  → [_saveAndGoToKyc] (saves context + routes to BVN)
  ///   - "Close"       → dismisses to the deposit form, no stuck spinner.
  /// The navigation now only happens on an explicit tap, so backing out of KYC
  /// without completing it can never reveal a frozen sheet.
  void _goToKycThenResume({required String snackbarMessage}) {
    // Stop the watchdog from flipping this into a generic "Taking too long"
    // failure — this is a deliberate KYC terminal state, not a stall.
    _cancelLinkWatchdog();

    // If the progress sheet isn't currently mounted (e.g. the mandate-setup
    // KYC gate fired after the sheet was popped for the mandate sheet),
    // re-show it so the KYC-required state has somewhere to render.
    if (!_isProgressSheetShown) {
      final amount = double.tryParse(_amountController.text.trim()) ?? 0;
      _progressController.show(
        bankName: _selectedBank.isNotEmpty ? _selectedBank : 'your bank',
        amount: amount,
        currency: _currency,
        flow: _useRecurringAccess
            ? DirectPayProgressFlow.mandateSetup
            : DirectPayProgressFlow.redeposit,
      );
      _showProgressBottomsheet(context);
    }

    _progressController.failKyc(
      title: 'Verification required',
      message: snackbarMessage,
    );
  }

  /// PRE-LAUNCH KYC gate. Bank deposits (Mono link + DirectPay/Direct Debit)
  /// require an identity-verified user (backend Tier 2 / BVN). Rather than let
  /// an unverified user complete the whole Mono link only to be rejected, we
  /// check their KYC standing FIRST and route them into verification if they're
  /// short — then [_maybeResumeAfterKyc] continues this exact deposit afterward.
  ///
  /// Source of truth: the Mono **Prove** tier (`ProveKycHttpService.status()`),
  /// the SAME signal the backend deposit gate and the BVN screen use — gate on
  /// `tier >= 2`. We deliberately do NOT use `KYCRepository` here (different
  /// backend path → risk of a stale source-of-truth split).
  ///
  /// Resilience: this is a UX optimization, not a security control (the backend
  /// re-gates authoritatively and the reactive net in [_openBankingListener] /
  /// [_showDepositFailure] still catches a slip-through). So on a FETCH FAILURE
  /// or timeout we FAIL OPEN and proceed. A *successful* low/unknown tier
  /// (`tier < 2`) always GATES.
  ///
  /// `linkedAccountId`/`linkedBankName` are passed for the redeposit-from-an-
  /// already-linked-account entry point so a KYC detour resumes by re-depositing
  /// (not re-linking). They're null for the fresh link-and-deposit entry point.
  /// Full-screen, non-dismissible spinner shown for the brief window between
  /// tapping a link/deposit action and the next phase resolving (Mono sheet or
  /// the verify-KYC prompt). Without it the user taps and sees "nothing" for a
  /// few seconds while the KYC status call runs. Idempotent via
  /// [_resolvingOverlayShown]; always paired with [_hideResolvingOverlay] before
  /// the next UI is shown.
  void _showResolvingOverlay() {
    if (_resolvingOverlayShown || !mounted) return;
    _resolvingOverlayShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          // Material ancestor is REQUIRED: without it the Text widgets below
          // inherit no DefaultTextStyle and render with the debug yellow
          // double-underline on the black barrier. It also gives us the card
          // surface + elevation for free.
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 320.w),
                child: Container(
                  padding: EdgeInsets.fromLTRB(28.w, 30.h, 28.w, 26.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161616),
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: const Color(0xFF2A2A2A), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.55),
                        blurRadius: 34,
                        spreadRadius: 2,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Brand loader on a soft tinted disc for emphasis.
                      Container(
                        width: 74.w,
                        height: 74.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF2962FF).withValues(alpha: 0.10),
                          border: Border.all(
                            color: const Color(0xFF2962FF).withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: LazerVaultLoader(size: 40),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Setting up your deposit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Just a moment while we check your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 22.h),
                      // Slim indeterminate progress conveys ongoing work.
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: SizedBox(
                          height: 4.h,
                          width: 150.w,
                          child: const LinearProgressIndicator(
                            backgroundColor: Color(0xFF262626),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Color(0xFF2962FF)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Dismiss the resolving overlay if it's up. Safe to call unconditionally and
  /// more than once — the next phase (Mono sheet / KYC dialog / error) always
  /// calls this first so the spinner never lingers behind it.
  void _hideResolvingOverlay() {
    if (!_resolvingOverlayShown) return;
    _resolvingOverlayShown = false;
    if (!mounted) return;
    final nav = Navigator.of(context, rootNavigator: true);
    if (nav.canPop()) nav.pop();
  }

  Future<void> _ensureKycThenDeposit({
    String? linkedAccountId,
    String? linkedBankName,
    required VoidCallback proceed,
  }) async {
    if (_kycCheckInFlight) return;

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Authentication Error',
        'You need to be logged in to make a deposit.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    // Carry the resume context so a KYC detour continues the right path.
    if (linkedAccountId != null && linkedAccountId.isNotEmpty) {
      _linkedAccountId = linkedAccountId;
      if (linkedBankName != null && linkedBankName.isNotEmpty) {
        _selectedBank = linkedBankName;
      }
    }

    _kycCheckInFlight = true;
    // Show a loading state for the whole resolution window (KYC status call can
    // take a few seconds). It's dismissed the instant the next phase is known —
    // right before the Mono sheet, the verify prompt, or an error — so the user
    // is never left staring at a screen that appears to be doing nothing.
    _showResolvingOverlay();

    try {
      final status = await ProveKycHttpService(serviceLocator<SecureStorageService>())
          .status()
          .timeout(const Duration(seconds: 8));
      if (!mounted) {
        _hideResolvingOverlay();
        return;
      }
      _hideResolvingOverlay();
      if (status.tier >= 2) {
        proceed();
      } else {
        _promptVerifyThenKyc();
      }
    } catch (e) {
      // Network / timeout / parse error → fail open. The backend re-gates and
      // the reactive KYC net will catch an unverified user after linking.
      debugPrint('[Deposit] KYC pre-check failed, proceeding (backend re-gates): $e');
      _hideResolvingOverlay();
      if (!mounted) return;
      proceed();
    } finally {
      _kycCheckInFlight = false;
    }
  }

  /// Fetch the user's BVN/KYC tier for the Direct Debit toggle gate. Runs at
  /// most once per sheet-open (guarded by [_bvnKycFetched]); same Prove source
  /// of truth (`tier >= 2`) as the deposit gate. Fail-open on error (the backend
  /// still re-gates and the mandate falls back to DirectPay). When the user
  /// isn't tier-2 we also force the recurring switch OFF so the default-ON never
  /// triggers a doomed mandate attempt for an unverified user.
  Future<void> _ensureBvnKycForToggle(
      void Function(void Function()) setSheetState) async {
    if (_bvnKycFetched || _bvnKycFetchInFlight) return;
    _bvnKycFetchInFlight = true;
    try {
      final status = await ProveKycHttpService(serviceLocator<SecureStorageService>())
          .status()
          .timeout(const Duration(seconds: 8));
      if (!mounted) return;
      final verified = status.tier >= 2;
      setSheetState(() {
        setState(() {
          _bvnVerifiedForMandate = verified;
          _bvnKycFetched = true;
          if (!verified) _useRecurringAccess = false;
        });
      });
    } catch (e) {
      // Fail-open: leave the toggle usable; backend re-gates + mandate falls back.
      debugPrint('[Deposit] BVN toggle KYC fetch failed (fail-open): $e');
      if (mounted) _bvnKycFetched = true;
    } finally {
      _bvnKycFetchInFlight = false;
    }
  }

  /// Ask the user to verify before we send them into KYC. Shown when the
  /// pre-launch gate finds an insufficient tier — gives a clear explanation and
  /// a clean cancel point (so we never yank them into KYC unexpectedly).
  void _promptVerifyThenKyc() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: const Text(
          'Verify your identity',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        content: Text(
          'To deposit from your bank account, we need to verify your identity '
          'with a quick BVN check. It only takes a moment.',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Not now',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2962FF),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Get.back();
              _saveAndGoToKyc();
            },
            child: const Text('Verify Now'),
          ),
        ],
      ),
    );
  }

  /// Persist the in-flight deposit context and route the user into KYC. Invoked
  /// when the user taps "Verify Now" on the KYC-required terminal state. The
  /// `returnTo` marker tells the BVN screen to route BACK to this deposit
  /// screen on success (and to refresh the KYC tier) instead of popping into a
  /// dead stack — [_maybeResumeAfterKyc] then resumes the deposit. Carries any
  /// account already linked before the gate so the resume re-deposits from it
  /// instead of re-linking.
  void _saveAndGoToKyc() {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;

    serviceLocator<PendingDeposit>().save(
      selectedCard: widget.selectedCard,
      amount: amount,
      currency: _currency,
      useRecurringAccess: _useRecurringAccess,
      linkedAccountId: _linkedAccountId,
      linkedBankName: _selectedBank.isNotEmpty ? _selectedBank : null,
    );

    Get.toNamed(
      AppRoutes.kycBVNVerification,
      arguments: {'returnTo': 'deposit'},
    );
  }

  /// Handle DirectPay authorization in-app using WebView
  Future<void> _handleDirectPayAuth(String paymentUrl, String paymentId) async {
    debugPrint('[DirectPay] Opening authorization WebView for payment: $paymentId');
    debugPrint('[DirectPay] URL: $paymentUrl');

    final result = await showDirectPayAuthorizationSheet(
      context: context,
      paymentUrl: paymentUrl,
      paymentId: paymentId,
      redirectScheme: 'lazervault',
      redirectPath: '/deposit/callback',
    );

    if (result.success) {
      debugPrint('[DirectPay] Authorization successful');
      // Update progress to processing stage
      _progressController.updateStage(DirectPayStage.processing);
      // PRIMARY (no polling): subscribe to the ws-balance WebSocket for this
      // deposit. When the backend settles (webhook → credit → NotifyDeposit), it
      // pushes DepositWebSocketCompleted, which advances the progress sheet to
      // success. DepositCubit owns the WS; arm it on the deposit reference.
      serviceLocator<DepositCubit>().onPaymentCompleted(_currentDepositId ?? paymentId);
      // FALLBACK only: a sparse settlement watchdog that also triggers the
      // backend's poll-on-read crediting for environments where Mono's webhook
      // can't reach us (local dev / a delayed webhook). Not a tight UI loop.
      _pollDepositSettlement(context);
    } else {
      debugPrint('[DirectPay] Authorization failed: ${result.errorMessage}');
      _showDepositFailure(result.errorMessage ?? 'Payment authorization was cancelled');
    }
  }

  /// Poll the deposit's settlement status until it reaches a terminal state
  /// or we exhaust the budget. The backend's GetDepositStatus verifies with
  /// Mono + credits on poll, so this drives both settlement AND the UI.
  ///
  /// IMPORTANT: capture the OpenBankingCubit + auth values SYNCHRONOUSLY up
  /// front. After the first `await`, the DirectPay sheet's context is gone
  /// and `context.read<OpenBankingCubit>()` throws "Could not find the
  /// correct Provider". The cubit is a GetIt singleton, so resolve it from
  /// serviceLocator instead of via the widget tree.
  Future<void> _pollDepositSettlement(BuildContext context) async {
    final depositId = _currentDepositId;
    if (depositId == null || depositId.isEmpty) {
      debugPrint('[Deposit] _pollDepositSettlement: no deposit id; skipping');
      return;
    }
    final authState = context.read<AuthenticationCubit>().state;
    final accessToken =
        authState is AuthenticationSuccess ? authState.profile.session.accessToken : '';
    final userId =
        authState is AuthenticationSuccess ? authState.profile.user.id : '';
    if (accessToken.isEmpty || userId.isEmpty) return;

    // Resolve the singleton cubit once (NOT through context — survives the
    // async gap + the DirectPay sheet teardown).
    final openBankingCubit = serviceLocator<OpenBankingCubit>();

    // FALLBACK watchdog (the WebSocket is the primary path). A handful of
    // SPARSE checks — not a 60s tight loop. The first check is immediate so the
    // backend's poll-on-read settles + credits in environments where Mono's
    // webhook can't reach us (local dev); the later checks are a safety net if
    // no WS event arrives. We stop the instant the sheet reaches a terminal
    // stage (the WS event usually gets there first).
    const delaysSeconds = [0, 4, 10, 20, 35];
    for (final delay in delaysSeconds) {
      if (!mounted) return;
      try {
        final stage = _progressController.stage;
        if (stage == DirectPayStage.success || stage == DirectPayStage.failed) {
          return; // WS (or an earlier check) already finished it.
        }
      } catch (_) {
        return; // controller disposed → flow ended.
      }
      if (delay > 0) {
        await Future<void>.delayed(Duration(seconds: delay));
        if (!mounted) return;
      }
      debugPrint('[Deposit] settlement watchdog check (t+${delay}s) id=$depositId');
      try {
        openBankingCubit.checkDepositStatus(
          depositId: depositId,
          userId: userId,
          accessToken: accessToken,
        );
      } catch (e) {
        debugPrint('[Deposit] watchdog checkDepositStatus threw (continuing): $e');
      }
    }

    // SLOW-SETTLEMENT TAIL: mandate debits can take minutes to settle at the
    // provider, and the WS only pushes COMPLETIONS — if the sparse checks end
    // while the deposit is still processing, the sheet used to hang on
    // "Processing Deposit" forever. Keep a slow bounded poll going (every 10s,
    // up to 5 minutes) until a terminal stage; on timeout flip the sheet to a
    // retry-less failure telling the user we'll finish in the background (the
    // backend deposit reconciler keeps settling it server-side).
    const tailInterval = Duration(seconds: 10);
    const maxTailTicks = 18; // ~3 minutes (poll-on-read now credits each tick)
    for (var tick = 0; tick < maxTailTicks; tick++) {
      await Future<void>.delayed(tailInterval);
      if (!mounted) return;
      try {
        final stage = _progressController.stage;
        if (stage == DirectPayStage.success || stage == DirectPayStage.failed) {
          return;
        }
        if (!_isProgressSheetShown) return; // user left the flow
      } catch (_) {
        return;
      }
      debugPrint('[Deposit] settlement tail poll #$tick id=$depositId');
      try {
        openBankingCubit.checkDepositStatus(
          depositId: depositId,
          userId: userId,
          accessToken: accessToken,
        );
      } catch (e) {
        debugPrint('[Deposit] tail poll threw (continuing): $e');
      }
    }
    if (!mounted || !_isProgressSheetShown) return;
    final stage = _progressController.stage;
    if (stage != DirectPayStage.success && stage != DirectPayStage.failed) {
      _progressController.updateStage(
        DirectPayStage.failed,
        errorTitle: 'Still processing',
        errorMessage:
            'Your bank is taking longer than usual. We will keep processing '
            'this deposit and credit you automatically once it completes. '
            'You can check Deposit History for updates.',
        retryable: false,
      );
    }
  }

  /// Handle open banking state changes
  void _openBankingListener(BuildContext context, OpenBankingState state) {
    debugPrint('[Deposit] OpenBankingListener received state: ${state.runtimeType}');

    if (state is AccountLinked) {
      // Account successfully linked
      debugPrint('[Deposit] Account linked: ${state.account.id}, bankName: ${state.account.bankName}, isNew: ${state.isNewAccount}');
      // Already-linked edge case: the backend deduped to an existing row
      // (same bank account for this user) instead of creating a duplicate.
      // Tell the user we're reusing their existing connection rather than
      // silently proceeding (or showing the same bank twice).
      if (!state.isNewAccount) {
        Get.snackbar(
          '${state.account.bankName} already linked',
          'Using your existing connection for this deposit.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF1F1F1F),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
      setState(() {
        _linkedAccountId = state.account.id;
        _selectedBank = state.account.bankName; // narration + receipts
      });

      // The bank is LINKED now. A retry from here must reuse this connection,
      // NOT re-open Mono Connect and re-link it. Re-point "Try Again" at the
      // redeposit path (rail starts at "Preparing Deposit", no linking step) so
      // a failed DEPOSIT retries the deposit — reusing the saved mandate /
      // DirectPay — instead of re-linking an already-linked account.
      _retryDeposit = () => _confirmFeeAndDepositFromLinkedAccount(state.account);

      // Update progress to initiating stage
      _progressController.updateStage(DirectPayStage.initiating);

      // If the user opted in to recurring access on the toggle, offer the
      // Beam-pattern mandate setup BEFORE proceeding with the first deposit.
      // Same canonical bottom sheet the move_money feature uses — single
      // mandate row backs both flows. User can opt in (CreateMandate +
      // open authorization URL) or "Not Now" (fall through to one-time
      // DirectPay for this deposit).
      if (_useRecurringAccess) {
        _offerMandateSetupThenProceed(context, state);
      } else {
        debugPrint('[Deposit] Calling _proceedWithMonoDeposit (one-time DirectPay)');
        _proceedWithMonoDeposit(context);
      }
    } else if (state is AccountLinkedWithMandate) {
      // Account linked AND a mandate was auto-created (GSM for personal
      // accounts). Without this branch the progress sheet hangs at
      // "Linking Account" forever — the cubit emits AccountLinkedWithMandate
      // (NOT AccountLinked) when auto-mandate is on, and the old listener
      // only handled AccountLinked.
      debugPrint('[Deposit] Account linked WITH mandate: ${state.account.id}, '
          'mandateFailed=${state.mandateFailed}, mandate=${state.mandate?.id}');
      setState(() {
        _linkedAccountId = state.account.id;
        _selectedBank = state.account.bankName; // narration + receipts
      });

      // Linked (with mandate) now — re-point "Try Again" at the redeposit path
      // so a failed deposit reuses this connection instead of re-linking. See
      // the AccountLinked branch above for the full rationale.
      _retryDeposit = () => _confirmFeeAndDepositFromLinkedAccount(state.account);

      _progressController.updateStage(DirectPayStage.initiating);

      if (state.mandateFailed) {
        // Mandate creation failed but the account IS linked — fall back to
        // a one-time DirectPay deposit so the user isn't blocked.
        debugPrint('[Deposit] Mandate failed (${state.mandateError}); '
            'falling back to one-time DirectPay');
        _proceedWithMonoDeposit(context);
      } else if (state.mandateNeedsAuthorization &&
          (state.mandateAuthorizationUrl ?? '').isNotEmpty) {
        // E-mandate created but awaiting the user's authorization at their
        // bank. Open it in OUR themed in-app sheet (same chrome as one-time
        // DirectPay and Connect, with DirectPayFlow.mandate copy) — never an
        // external browser — then proceed with this deposit either way.
        _authorizeMandateThenProceed(state);
      } else {
        // Mandate is already usable (or no auth step) — proceed directly.
        _proceedWithMonoDeposit(context);
      }
    } else if (state is DepositInitiated) {
      // Past linking — the deposit exists now, so the link watchdog is no longer needed.
      _cancelLinkWatchdog();
      // Deposit initiated - check if DirectPay authorization is needed
      final deposit = state.deposit;
      debugPrint('[Deposit] Deposit initiated: ${deposit.id}');
      // Remember the deposit id so we can poll its settlement status after
      // DirectPay authorization (the backend settles on poll when Mono's
      // webhook can't reach us).
      _currentDepositId = deposit.id;

      if (deposit.requiresAuthorization &&
          deposit.paymentUrl != null &&
          deposit.paymentUrl!.isNotEmpty) {
        // DirectPay authorization needed - update progress and open in-app WebView
        debugPrint('[Deposit] DirectPay authorization required: ${deposit.paymentUrl}');
        _progressController.updateStage(DirectPayStage.authorizing);
        _handleDirectPayAuth(
          deposit.paymentUrl!,
          deposit.paymentId ?? deposit.id,
        );
      } else {
        // No authorization needed (mandate already approved or instant).
        // Poll for settlement so the UI advances + dashboard redirects.
        _progressController.updateStage(DirectPayStage.processing);
        _pollDepositSettlement(context);
      }
    } else if (state is DepositStatusUpdated) {
      // DepositStatusUpdated comes from banking's GetDepositStatus, which only
      // returns `successful` AFTER the wallet was actually credited (webhook or
      // verify-on-return → processSuccessfulDeposit). This is the AUTHORITATIVE
      // "real money credited" signal — so it (not a payment-sheet-closed event)
      // is what drives the success UI.
      final deposit = state.deposit;
      debugPrint('[Deposit] DepositStatusUpdated: status=${deposit.status}');
      if (deposit.status == DepositStatus.successful) {
        // Telemetry: authoritative terminal settlement.
        AnalyticsService.instance.trackDepositSettled(status: 'successful');
        _handleDepositSettled(context);
      } else if (deposit.status == DepositStatus.failed) {
        AnalyticsService.instance.trackDepositSettled(status: 'failed');
        _showDepositFailure(deposit.failureReason);
      }
      // pending/processing → keep the sheet on "processing"; the poll
      // continues until a terminal status arrives.
    } else if (state is ServiceUnavailable || state is OpenBankingOffline) {
      // The banking / KYC / Mono backend is unreachable (a gateway is down → gRPC
      // UNAVAILABLE, or the network dropped). Surface a clear TEMPORARILY-
      // UNAVAILABLE state — never the misleading "can't reach your bank / check
      // your connection". If the progress sheet is up, drive its styled failed
      // rail (retryable); otherwise show the themed service-unavailable modal.
      final msg = state is ServiceUnavailable && state.message.trim().isNotEmpty
          ? state.message
          : 'This service is temporarily unavailable. Please try again in a moment.';
      debugPrint('[Deposit] backend unreachable: $state');
      // The passive carousel fetch may be what died here — resolve its section
      // state so the loader can't spin forever (retry row when still empty).
      if (mounted && _linkedAccountsLoading) {
        setState(() {
          _linkedAccountsLoading = false;
          _linkedAccountsError = _linkedAccounts.isEmpty;
        });
      }
      // ONLY surface this while a deposit/link is actually in flight (progress
      // sheet up). ServiceUnavailable/Offline carry no operation, so the same
      // state also fires for the passive background _loadLinkedAccounts on screen
      // open — we must NOT pop a modal over the deposit form for that. The active
      // deposit path always has the sheet; drive its styled failed rail instead.
      if (_isProgressSheetShown) {
        _progressController.updateStage(
          DirectPayStage.failed,
          errorTitle: 'Temporarily unavailable',
          errorMessage: msg,
          retryable: true,
          retryLabel: 'Try again',
        );
      }
    } else if (state is OpenBankingError) {
      debugPrint('[Deposit] OpenBankingError: ${state.message}, code: ${state.errorCode}, operation: ${state.operation}');
      // Don't surface link/unlink-list errors as a deposit failure (they're
      // background loads for the carousel); only deposit-flow errors matter.
      if (state.operation == 'fetchLinkedAccounts' || state.operation == 'unlinkAccount') {
        // But DO resolve the carousel's section state so it can't spin
        // forever — an empty carousel shows a compact retry row instead.
        if (mounted && state.operation == 'fetchLinkedAccounts') {
          setState(() {
            _linkedAccountsLoading = false;
            _linkedAccountsError = _linkedAccounts.isEmpty;
          });
        }
        return;
      }
      // Code-first KYC routing: the cubit preserves the backend error CODE, so
      // route on it directly rather than relying on message text (which varies
      // across the link / DirectPay / mandate paths). _isKycError(message) is
      // the secondary net inside _showDepositFailure for message-only paths.
      if (state.errorCode == 'KYC_REQUIRED') {
        _goToKycThenResume(
          snackbarMessage:
              'Complete a quick BVN verification to deposit from your bank account.',
        );
        return;
      }
      // Code-first: unverified linked-bank details. Route on the structured code
      // so it holds regardless of the message text (the exception may carry a
      // generic userMessage). Pass a canonical, classifier-recognizable message
      // so _classifyDepositFailure deterministically renders the re-link CTA.
      if (state.errorCode == 'BANK_DETAILS_UNVERIFIED') {
        // The stored bank details couldn't pin the debit (masked/empty NUBAN) AND
        // the backend's silent re-fetch couldn't repair them — so the ONLY real
        // recovery is a fresh Mono Connect link (which fetches a clean NUBAN +
        // bank code and reuses/repairs the existing row — no duplicate). Re-point
        // the failure sheet's action at the RELINK launcher, not the doomed
        // deposit; without this the "Try Again" button just re-hit the same error
        // and never opened the Connect widget.
        _retryDeposit = () => _launchNGNMonoBottomsheet(context);
        _showDepositFailure(
            "We couldn't confirm your bank account details. Re-link your bank to continue.");
        return;
      }
      // Refresh-fee couldn't be reserved on the active account. The backend
      // holds the fee BEFORE the live read, so this fires before any Mono
      // call — nothing was charged. Show a clear, styled modal (not a generic
      // deposit-failure toast) so the user knows the active account is short.
      if (state.operation == 'refreshBalance' &&
          state.errorCode == BankingErrorCode.insufficientFunds) {
        _showRefreshFeeInsufficientDialog(state.message);
        return;
      }
      // Linked-bank cap (per-user, admin-tunable default 3) OR provider capacity
      // exhausted (Mono subscription can't onboard a NEW link) — surface as a
      // styled modal with CTAs, not a toast. Nothing was charged (both are
      // checked before any fee). Stop the progress rail first so it isn't left
      // spinning behind the modal.
      if (state.errorCode == kLinkLimitReachedCode ||
          state.errorCode == kLinkingCapacityCode) {
        if (_isProgressSheetShown) {
          _progressController.updateStage(
            DirectPayStage.failed,
            errorTitle: state.errorCode == kLinkingCapacityCode
                ? 'Linking paused'
                : 'Limit reached',
            errorMessage: state.message,
            retryable: false,
          );
        }
        if (state.errorCode == kLinkingCapacityCode) {
          showLinkingCapacityDialog(context);
        } else {
          showLinkLimitReachedDialog(context, state.message);
        }
        return;
      }
      _showDepositFailure(state.message);
    } else if (state is LinkedAccountsLoaded) {
      // Cache the user's linked banks for the "Deposit again" carousel.
      if (mounted) {
        setState(() {
          _linkedAccounts = state.accounts;
          _linkedAccountsLoading = false;
          _linkedAccountsError = false;
        });
      }
      // One-time educational guide: how to see a live linked-bank balance.
      _maybeShowBalanceRefreshGuide(state.accounts);
    } else if (state is BalanceRefreshed) {
      // A refresh just landed — update that card's balance in place so the
      // explicit "Refresh" button visibly reflects the live figure.
      if (mounted) {
        setState(() {
          _linkedAccounts = _linkedAccounts
              .map((a) => a.id == state.accountId
                  ? a.copyWith(
                      lastKnownBalance: state.newBalance,
                      balanceUpdatedAt: DateTime.now())
                  : a)
              .toList();
        });
      }
    } else if (state is AccountUnlinked) {
      // Drop it from the carousel + refresh.
      if (mounted) {
        setState(() => _linkedAccounts.removeWhere((a) => a.id == state.accountId));
      }
      Get.snackbar('Unlinked', 'Bank account removed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
          colorText: Colors.white);
      _loadLinkedAccounts();
      _loadUserMandates();
    }
  }

  void _blocListener(BuildContext context, DepositState state) {
    if (state is DepositFailure) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Failed',
        state.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );
      // DO NOT navigate on error - stay on screen
    } else if (state is DepositRequiresAuthorization) {
      // Flutterwave-mediated method (Apple Pay / Card): open the hosted
      // checkout. On success the banking webhook credits and the WebSocket
      // emits DepositWebSocketCompleted (handled below) → dashboard redirect.
      _currentDepositId = state.depositId;
      _openFlutterwaveCheckout(state.paymentUrl, state.depositId);
    } else if (state is DepositSuccess) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Initiated',
        'Your deposit of $_currencySymbol${_amountController.text} is being processed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.hourglass_top_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );
    } else if (state is DepositWebSocketCompleted) {
      setState(() {
        _selectedBank = '';
      });
      // A real-time "completed" push is NOT proof the wallet was credited — it
      // can arrive on payment capture before settlement. Re-verify with banking
      // (authoritative); the resulting DepositStatusUpdated(successful) is what
      // actually drives the success UI (navigate + snackbar). This guarantees
      // the success snackbar only shows once real money has credited the wallet.
      final depId = _currentDepositId;
      final auth = context.read<AuthenticationCubit>().state;
      if (depId != null && depId.isNotEmpty && auth is AuthenticationSuccess) {
        serviceLocator<OpenBankingCubit>().checkDepositStatus(
          depositId: depId,
          userId: auth.profile.user.id,
          accessToken: auth.profile.session.accessToken,
        );
      }
    } else if (state is DepositReversed) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Reversed',
        state.reason,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 6),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.undo_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );

      // Refresh balances since reversal affects the balance
      _refreshAccountBalances(context);
    } else if (state is DepositWebSocketFailed) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Deposit Failed',
        state.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
        icon: Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 28.sp,
        ),
      );
    }
  }
  
  /// Refreshes the account balances - DISABLED: WebSocket handles real-time updates
  /// The ws-balance-service pushes balance updates to the Flutter app via WebSocket,
  /// which triggers the balance animation on the dashboard automatically.
  void _refreshAccountBalances(BuildContext context) {
    // REMOVED: Manual refresh is no longer needed - WebSocket handles balance updates
    // The dashboard will receive the update via BalanceWebSocketCubit and show animation
    print('Manual refresh skipped - WebSocket will handle balance update');
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Deposit Funds',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
            // Deposit history — every past deposit with its live status.
            IconButton(
              tooltip: 'Deposit history',
              onPressed: () => Get.to(() => const DepositHistoryScreen()),
              icon: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(10.r),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: Icon(Icons.receipt_long_rounded,
                    color: Colors.white.withValues(alpha: 0.9), size: 17.sp),
              ),
            ),
            // Single integrated voice surface: ServiceVoiceButton drives the
            // production voice agent (the old local speech_to_text Icons.mic
            // toggle was a duplicate and has been removed).
            // serviceName='deposits' so the voice agent routes to the
            // deposit-funds tools (the previous 'loans' string was a
            // copy-paste leftover that sent the agent to the wrong
            // service). Chat icon follows so users can also drive the
            // same flow via text.
            // Sized to MATCH the history chip (≈17.sp icon in a ~30px chip) so
            // the three app-bar actions read as one consistent row.
            ServiceVoiceButton(
              serviceName: 'deposits',
              buttonSize: 30.w,
              iconSize: 17.sp,
            ),
            SizedBox(width: 8.w),
            MicroserviceChatIcon(
              serviceName: 'Deposits',
              sourceContext: 'deposits',
              size: 30,
              iconSize: 17,
            ),
            SizedBox(width: 8.w),
],
    );
  }

  /// Map a wallet currency to its ISO country code so the deposit request
  /// carries a country (NGN → NG → Mono). Mirrors the backend
  /// countryCodeForCurrency. Defaults to NG (the primary Mono market).
  String _countryCodeForCurrency(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return 'NG';
      case 'GHS':
        return 'GH';
      case 'KES':
        return 'KE';
      case 'ZAR':
        return 'ZA';
      case 'USD':
        return 'US';
      case 'GBP':
        return 'GB';
      default:
        return 'NG';
    }
  }

  /// Safely coerce the selected-card balance to a double. The card map can
  /// arrive with balance as a double, int, numeric string, or absent
  /// entirely (e.g. when navigated to with a sparse card). Never let a null
  /// or wrong-typed value crash `.toStringAsFixed`.
  double _cardBalance() {
    final raw = widget.selectedCard['balance'];
    if (raw is double) return raw;
    if (raw is int) return raw.toDouble();
    if (raw is String) return double.tryParse(raw) ?? 0.0;
    return 0.0;
  }

  /// Resolve the live account summary for the deposit card from the global
  /// AccountCardsSummaryCubit state (kept fresh by the balance WebSocket), or
  /// null if not loaded / no match.
  AccountSummaryEntity? _liveSelectedSummary(AccountCardsSummaryState state) {
    final id = widget.selectedCard['id']?.toString() ?? '';
    if (id.isEmpty) return null;
    final List<AccountSummaryEntity> list = switch (state) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => const <AccountSummaryEntity>[],
    };
    for (final s in list) {
      if (s.id == id) return s;
    }
    return null;
  }

  Widget _buildSelectedCardSummary() {
    // Live-bind to the balance cubit so the deposit card's balance + trend %
    // animate/refresh in real time when a deposit credits (same WS feed the
    // dashboard uses), instead of showing the static snapshot it opened with.
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      bloc: serviceLocator<AccountCardsSummaryCubit>(),
      builder: (context, summaryState) {
        final live = _liveSelectedSummary(summaryState);
        final double cardBalance = live?.balance ?? _cardBalance();
        final bool cardIsUp = live?.isUp ?? (widget.selectedCard['isUp'] == true);
        final String cardTrend = live != null
            ? '${live.trendPercentage >= 0 ? '+' : ''}${live.trendPercentage.toStringAsFixed(1)}%'
            : (widget.selectedCard['trend']?.toString() ?? '—');
        return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 78, 3, 208),
            Color.fromARGB(255, 95, 20, 225),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedCard['accountType']?.toString() ?? 'Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  widget.selectedCard['accountNumber']?.toString() ??
                      widget.selectedCard['account_number']?.toString() ??
                      '••••',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          TweenAnimationBuilder<double>(
            // begin = the snapshot the screen opened with; end = the live
            // balance. TweenAnimationBuilder re-animates from the current value
            // to `end` whenever it changes, so a credit counts up smoothly.
            tween: Tween<double>(begin: _cardBalance(), end: cardBalance),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            builder: (context, value, _) => Text(
              "$_currencySymbol${value.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: cardIsUp
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  cardTrend,
                  style: TextStyle(
                    color: cardIsUp ? Colors.green[300] : Colors.red[300],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
        );
      },
    );
  }








  /// Build the deposit button content based on loading states


  /// Launch Mono Connect widget to link bank and authorize deposit

  /// Find matching bank name in our list from Mono's institution name

  /// Offer the Beam-pattern mandate setup sheet right after the user's
  /// Mono Connect linking completes. Reuses the canonical
  /// move_money/mandate_setup_bottomsheet so the UX is identical across
  /// Beam (transfers) + deposits. After the sheet closes — whether the
  /// user enabled the mandate or chose "Not Now" — we proceed with the
  /// underlying deposit so the user gets value from this session even
  /// when they decline recurring access.
  Future<void> _offerMandateSetupThenProceed(
    BuildContext context,
    AccountLinked state,
  ) async {
    // Dismiss the progress sheet briefly so the mandate sheet has a
    // clean stage (re-shown after the user decides).
    if (_isProgressSheetShown && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      _isProgressSheetShown = false;
    }

    final authState = context.read<AuthenticationCubit>().state;
    final userId = authState is AuthenticationSuccess ? authState.profile.user.id : '';
    final user = authState is AuthenticationSuccess ? authState.profile.user : null;

    // Set when the mandate sheet's KYC gate fires. In that case we DON'T fall
    // through to re-show the progress sheet / deposit here — we've detoured the
    // user into KYC (saving the in-flight deposit, which includes the
    // already-linked account, so the resume redeposits without re-linking).
    bool kycDetour = false;

    bool enabled = false;
    try {
      enabled = await showMandateSetupBottomSheet(
        context: context,
        linkedAccountId: state.account.id,
        userId: userId,
        bankName: state.account.bankName,
        accountName: state.account.accountName,
        userEmail: user?.email,
        userName: user != null
            ? '${user.firstName} ${user.lastName}'.trim()
            : null,
        // phone is captured by the backend MonoCustomer record on first
        // mandate creation; we don't ship one from Flutter today.
        onKycRequired: () {
          kycDetour = true;
          // The account is already linked here — carry it so the resume
          // redeposits from it instead of re-opening Mono Connect.
          _linkedAccountId = state.account.id;
          _selectedBank = state.account.bankName;
          _goToKycThenResume(
            snackbarMessage:
                'Complete a quick BVN verification to set up Direct Debit.',
          );
        },
      );
    } catch (e) {
      debugPrint('[Deposit] MandateSetupBottomsheet error: $e');
    }
    debugPrint('[Deposit] MandateSetupBottomsheet returned: enabled=$enabled');

    if (!mounted || kycDetour) return;

    // Re-show the progress sheet for the (now-resumed) deposit flow. The
    // account is already linked at this point, so the rail resumes at
    // "Preparing Deposit" with no linking step.
    final parsedAmount = double.tryParse(_amountController.text) ?? 0.0;
    _progressController.show(
      bankName: state.account.bankName,
      amount: parsedAmount,
      currency: _currency,
      flow: DirectPayProgressFlow.redeposit,
    );
    _showProgressBottomsheet(context);
    _progressController.updateStage(DirectPayStage.initiating);

    // Whether the user enabled the mandate or chose Not Now, kick off the
    // deposit. If they enabled a mandate that needs e-mandate / signed
    // authorization, the first deposit STILL uses DirectPay because the
    // mandate isn't ready yet — that's fine, the next deposit will pick
    // up the active mandate automatically.
    _proceedWithMonoDeposit(context);
  }

  /// Proceed with deposit after account is linked
  void _proceedWithMonoDeposit(BuildContext buildContext) {
    debugPrint('[Deposit] _proceedWithMonoDeposit called');

    final authState = buildContext.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      debugPrint('[Deposit] ERROR: User not authenticated');
      return;
    }

    final amountText = _amountController.text;
    final amount = double.tryParse(amountText) ?? 0;
    debugPrint('[Deposit] Amount text: "$amountText", parsed amount: $amount, linkedAccountId: $_linkedAccountId');

    if (amount <= 0) {
      debugPrint('[Deposit] ERROR: Amount is <= 0, cannot proceed');
      Get.snackbar(
        'Error',
        'Please enter a valid deposit amount.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    if (_linkedAccountId == null) {
      debugPrint('[Deposit] ERROR: linkedAccountId is null');
      Get.snackbar(
        'Error',
        'Bank account not linked. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final userId = authState.profile.user.id;
    final accessToken = authState.profile.session.accessToken;

    // Get destination account ID
    String? destinationAccountId;
    if (widget.selectedCard['id'] is int) {
      destinationAccountId = widget.selectedCard['id'].toString();
    } else if (widget.selectedCard['id'] is String) {
      destinationAccountId = widget.selectedCard['id'] as String;
    }
    debugPrint('[Deposit] Destination account ID: $destinationAccountId (from widget.selectedCard["id"]: ${widget.selectedCard['id']})');

    if (destinationAccountId == null) {
      debugPrint('[Deposit] ERROR: destinationAccountId is null');
      Get.snackbar(
        'Error',
        'Invalid account information. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    debugPrint('[Deposit] Initiating deposit: userId=$userId, linkedAccountId=$_linkedAccountId, destAccountId=$destinationAccountId, amount=$amount');

    // Initiate deposit via open banking. Pass the destination wallet's
    // currency + derived country so the backend routes NGN → Mono instead
    // of falling through to Flutterwave (which rejects an empty country
    // with "country  is not supported for Flutterwave deposits").
    // _selectedBank can be empty on the fresh-link path (it is only set by the
    // redeposit flow) — without the guard the Mono checkout remark read
    // "Deposit from to Lazervault".
    final bankLabel = _selectedBank.isNotEmpty ? _selectedBank : 'your bank';
    serviceLocator<OpenBankingCubit>().initiateDeposit(
      userId: userId,
      linkedAccountId: _linkedAccountId!,
      destinationAccountId: destinationAccountId,
      amount: amount,
      narration: 'Deposit from $bankLabel to Lazervault',
      accessToken: accessToken,
      currency: _currency,
      countryCode: _countryCodeForCurrency(_currency),
      // Be EXPLICIT about the path the user chose: recurring → mandate debit
      // (DebitMandate), one-time → DirectPay. Don't make the backend infer it
      // from the linked account's mandate state.
      useRecurringAccess: _useRecurringAccess,
    );
  }


  @override
  void dispose() {
    _cancelLinkWatchdog();
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _feeDebounce?.cancel();
    _feePreview.dispose();
    _progressController.dispose();
    super.dispose();
  }
}
