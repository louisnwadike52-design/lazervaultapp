import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/deposit_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/deposit.dart';
import 'package:lazervault/src/features/funds/data/services/mono_institutions_service.dart';
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
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_setup_bottomsheet.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_management_bottomsheet.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class DepositFundsScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCard;
  const DepositFundsScreen({
    super.key,
    required this.selectedCard,
  });

  @override
  State<DepositFundsScreen> createState() => _DepositFundsScreenState();
}

class _DepositFundsScreenState extends State<DepositFundsScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  String _selectedBank = '';
  bool _isListening = false;
  String _recognizedText = '';
  bool _isVoiceEnabled = false;

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
  bool _useRecurringAccess = false;


  /// Methods available for the current currency + platform. The backend
  /// (banking-service routing + system_settings) remains the source of truth;
  /// this list only governs what we OFFER:
  ///   • Link Account (Mono direct debit) — NGN only.
  ///   • Bank Transfer (virtual NUBAN)    — NGN only (non-NGN wallets have no NUBAN).
  ///   • Apple Pay (Flutterwave)          — iOS only, non-NGN (Flutterwave Apple Pay corridors).
  ///   • Card (Flutterwave hosted)        — non-NGN.
  List<_DepositMethod> get _availableMethods {
    if (_isNGN) {
      return const [_DepositMethod.linkAccount, _DepositMethod.bankTransfer];
    }
    return [
      if (Platform.isIOS) _DepositMethod.applePay,
      _DepositMethod.card,
    ];
  }

  // DirectPay progress controller for animated bottomsheet
  final DirectPayProgressController _progressController = DirectPayProgressController();
  bool _isProgressSheetShown = false;

  // Watchdog: if linking/initiating stalls (e.g. a provider call hangs), flip the
  // progress sheet to a retryable failure instead of spinning on "Linking Account"
  // forever. Cancelled as soon as the flow advances to authorizing/processing.
  Timer? _linkWatchdog;

  void _startLinkWatchdog() {
    _linkWatchdog?.cancel();
    _linkWatchdog = Timer(const Duration(seconds: 30), () {
      if (!mounted || !_isProgressSheetShown) return;
      final stage = _progressController.stage;
      if (stage == DirectPayStage.linking || stage == DirectPayStage.initiating) {
        _progressController.updateStage(
          DirectPayStage.failed,
          errorTitle: 'Taking too long',
          errorMessage:
              "We couldn't finish linking your bank in time. Please check your connection and try again.",
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
    _initializeSpeech();
    _loadBanks();
    // Load the user's saved mandates + previously-linked bank accounts so the
    // "Deposit again" carousel can show them. Fire after the first frame.
    if (_isNGN) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadUserMandates();
        _loadLinkedAccounts();
      });
    }
    // Listen to amount changes to update button state
    _amountController.addListener(_onAmountChanged);
  }

  /// Fetch the user's previously-linked bank accounts for the carousel.
  void _loadLinkedAccounts() {
    if (!mounted) return;
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      debugPrint('[Deposit] _loadLinkedAccounts: auth not ready, skipping');
      return;
    }
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

  Future<void> _initializeSpeech() async {
    await _speech.initialize();
    await _flutterTts.setLanguage('en-GB');
    await _flutterTts.setPitch(1.0);
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _recognizedText = result.recognizedWords;
              _processVoiceCommand(_recognizedText);
            });
          },
        );
      }
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _processVoiceCommand(String command) {
    command = command.toLowerCase();

    // Process bank selection
    for (var bank in _banks) {
      if (command.contains(bank['name'].toLowerCase())) {
        setState(() => _selectedBank = bank['name']);
        _speakResponse('Selected ${bank['name']}');
        break;
      }
    }

    // Process amount
    final amountMatch = RegExp(r'\d+').firstMatch(command);
    if (amountMatch != null) {
      final amount = amountMatch.group(0);
      setState(() => _amountController.text = amount!);
      _speakResponse('Amount set to $_currencySymbol$amount');
    }
  }

  Future<void> _speakResponse(String text) async {
    await _flutterTts.speak(text);
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
          if (authState is! AuthenticationSuccess) {
            Get.snackbar('Authentication Error', 'You need to be logged in to make a deposit.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.7),
              colorText: Colors.white
            );
          }
        },
        builder: (authContext, authState) {
          return Scaffold(
            backgroundColor: const Color(0xFF1A1A1A),
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
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSelectedCardSummary(),
                          SizedBox(height: 28.h),
                          // Saved banks first (deposit again with one tap),
                          // then the method-first picker.
                          _buildSavedBanksCarousel(context),
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
                  );
                },
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
      onTap: isLoading ? null : () => _openMethodSheet(method),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10.r),
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
        return [
          _buildSheetAmountField(setSheetState),
          SizedBox(height: 16.h),
          RecurringAccessToggle(
            isRecurringEnabled: _useRecurringAccess,
            onToggle: (v) => setSheetState(() => setState(() => _useRecurringAccess = v)),
          ),
          SizedBox(height: 16.h),
          _sheetPrimaryButton(
            label: 'Link & Deposit',
            icon: Icons.link,
            onPressed: () {
              if (!_validateSheetAmount(min: 200)) return;
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
              _startFlutterwaveDeposit(context, paymentMethod: 'apple_pay', sourceLabel: 'Apple Pay');
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
              if (!_validateSheetAmount()) return;
              Navigator.of(sheetCtx).pop();
              _startFlutterwaveDeposit(context, paymentMethod: 'card', sourceLabel: 'Card');
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
  Widget _buildSavedBanksCarousel(BuildContext context) {
    if (_linkedAccounts.isEmpty) return const SizedBox.shrink();
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
                      Text('Your linked banks — tap to deposit, swipe to browse.',
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
              height: 158.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: accounts.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (_, i) => _buildLinkedAccountCard(context, accounts[i]),
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
    final mandate = _mandateForAccount(account);
    final recurring = mandate != null;
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: () => _openRedepositSheet(context, account),
      child: Container(
        width: 224.w,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _bankLogoAvatar(account.bankName, size: 36),
                const Spacer(),
                _accessChip(persistent: recurring),
                SizedBox(width: 4.w),
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
            // LIVE-ONLY: show a figure only when this session's Mono read
            // landed (within minutes) — never a DB cache as current balance.
            Builder(builder: (_) {
              final fresh = account.balanceUpdatedAt != null &&
                  DateTime.now().difference(account.balanceUpdatedAt!).inMinutes < 3;
              if (fresh) {
                return Text('₦${account.lastKnownBalance.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w700));
              }
              return Row(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    width: 9.w,
                    height: 9.w,
                    child: const CircularProgressIndicator(
                        strokeWidth: 1.5, color: Color(0xFF9CA3AF))),
                SizedBox(width: 5.w),
                Text('Fetching balance…',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.sp)),
              ]);
            }),
            SizedBox(height: 6.h),
            Row(
              children: [
                Text(recurring ? 'Tap to deposit' : 'Tap to deposit (one-time)',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 11.sp)),
                const Spacer(),
                Icon(recurring ? Icons.refresh : Icons.chevron_right,
                    color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
              ],
            ),
          ],
        ),
      ),
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
                        _depositFromLinkedAccount(account);
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

    final result = await showDirectPayAuthorizationSheet(
      context: context,
      flow: DirectPayFlow.mandate,
      paymentUrl: url,
      paymentId: mandate?.id ?? '',
      reference: mandate?.reference,
      redirectPath: '/mandate/callback',
    );
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
  void _depositFromLinkedAccount(LinkedBankAccount account) {
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
    // Arm "Try Again" on the failure sheet to RE-FIRE this exact redeposit
    // (without it the button only dismissed the sheet).
    _retryDeposit = () => _depositFromLinkedAccount(account);
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
    );
  }

  /// Per-account action sheet: deposit, manage recurring (if any), unlink.
  void _showAccountActions(BuildContext screenCtx, LinkedBankAccount account) {
    final mandate = _mandateForAccount(account);
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
              if (mandate != null)
                ListTile(
                  leading: Icon(Icons.link, color: const Color(0xFF10B981)),
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

  /// Bank "logo" as a gradient-initial avatar (remote bank logo URLs are disabled
  /// app-wide; the gradient initial is the standard fallback). Colour is derived
  /// deterministically from the bank name so each bank keeps a stable look.
  Widget _bankLogoAvatar(String bankName, {double size = 42}) {
    final name = bankName.trim().isEmpty ? 'Bank' : bankName.trim();
    final initials = name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : name.substring(0, 1).toUpperCase();
    final palettes = <List<Color>>[
      [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      [const Color(0xFF0EA5E9), const Color(0xFF2563EB)],
      [const Color(0xFF10B981), const Color(0xFF059669)],
      [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
      [const Color(0xFFEC4899), const Color(0xFF8B5CF6)],
      [const Color(0xFF14B8A6), const Color(0xFF0EA5E9)],
    ];
    final pair = palettes[name.codeUnits.fold<int>(0, (a, b) => a + b) % palettes.length];
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: pair, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12.r),
      ),
      alignment: Alignment.center,
      child: Text(initials,
          style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
    );
  }

  /// One-time vs Persistent access chip for a linked account.
  Widget _accessChip({required bool persistent}) {
    final color = persistent ? const Color(0xFF10B981) : const Color(0xFF9CA3AF);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(persistent ? Icons.link : Icons.schedule, color: color, size: 11.sp),
          SizedBox(width: 3.w),
          Text(persistent ? 'Persistent' : 'One-time',
              style: TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildLinkedAccountRow(BuildContext context, LinkedBankAccount account) {
    final persistent = _mandateForAccount(account) != null;
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
          _bankLogoAvatar(account.bankName),
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
                    _accessChip(persistent: persistent),
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
    final accountNumber = (widget.selectedCard['accountNumber'] ??
        widget.selectedCard['account_number'] ?? '') as String;
    final accountName = (widget.selectedCard['accountName'] ??
        widget.selectedCard['account_name'] ?? '') as String;
    final bankName = (widget.selectedCard['bankName'] ??
        widget.selectedCard['bank_name'] ?? '') as String;
    final authState = context.read<AuthenticationCubit>().state;
    final userId =
        authState is AuthenticationSuccess ? authState.profile.user.id : null;
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
      // Cancelled / failed on the checkout side. The webhook never credits,
      // so just surface it; no balance moved.
      _showDepositFailure(result.errorMessage ?? 'Payment was not completed');
    }
    // On success the banking webhook credits and the WebSocket emits
    // DepositWebSocketCompleted, which the listener turns into the dashboard
    // redirect + success snackbar.
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

    // Remember how to re-run this exact deposit if it fails and the user
    // taps "Try Again". Uses the State's own context (valid while mounted).
    _retryDeposit = () => _launchNGNMonoBottomsheet(this.context);

    // Launch Mono Connect SDK
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

      // Show progress bottomsheet. Fresh-link journeys start at "Linking
      // Account"; with the recurring toggle ON the rail reads as a Direct
      // Debit setup ("Setting Up Direct Debit" / "Authorize Direct Debit").
      _progressController.show(
        bankName: result.institutionName ?? 'Bank',
        amount: amount,
        currency: _currency,
        flow: _useRecurringAccess
            ? DirectPayProgressFlow.mandateSetup
            : DirectPayProgressFlow.linkAndDeposit,
      );
      _showProgressBottomsheet(context);

      // Link the account using the OpenBankingCubit
      serviceLocator<OpenBankingCubit>().linkAccount(
        userId: userId,
        code: result.code,
        accessToken: accessToken,
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
      builder: (sheetContext) => DirectPayProgressBottomsheet(
        controller: _progressController,
        onSuccess: () {
          _isProgressSheetShown = false;
          Navigator.of(sheetContext).pop();
          // Navigate back to dashboard, then surface the success snackbar so it
          // lands over the dashboard (Get.snackbar is a global overlay that
          // survives the route change).
          _navigateToDashboard();
          _showDepositCompletedSnackbar();
        },
        onDismiss: () {
          _isProgressSheetShown = false;
          Navigator.of(sheetContext).pop();
          // Stays on the deposit form so the user can adjust the amount /
          // bank and try again.
        },
        onRetry: () {
          _isProgressSheetShown = false;
          if (Navigator.of(sheetContext).canPop()) {
            Navigator.of(sheetContext).pop();
          }
          // Re-run the exact deposit the user last started.
          final retry = _retryDeposit;
          if (retry != null) {
            retry();
          }
        },
        onExit: () {
          _isProgressSheetShown = false;
          // _navigateToDashboard clears the whole stack (incl. this sheet),
          // so no explicit pop needed.
          _navigateToDashboard();
        },
      ),
    ).whenComplete(() {
      _isProgressSheetShown = false;
      _cancelLinkWatchdog();
    });
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
  bool _completedSnackbarShown = false;

  void _showDepositCompletedSnackbar() {
    if (_completedSnackbarShown) return;
    _completedSnackbarShown = true;
    Get.closeAllSnackbars();
    Get.snackbar(
      'Deposit Completed',
      'Your deposit has been completed successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withValues(alpha: 0.9),
      colorText: Colors.white,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: Icon(
        Icons.check_circle_rounded,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }

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

  /// Push a classified failure into the progress sheet — UNLESS the backend
  /// signalled the KYC gate, in which case route the user into identity
  /// verification (DirectPay/Direct Debit refuse without a verified BVN).
  void _showDepositFailure(String? raw) {
    final lower = (raw ?? '').toLowerCase();
    if (lower.contains('kyc_required') ||
        lower.contains('kyc required') ||
        lower.contains('verify your identity')) {
      // Close the progress sheet, then send the user to KYC.
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
      Get.snackbar(
        'Verify your identity',
        'Complete a quick BVN verification to deposit from your bank account.',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed(AppRoutes.kycBVNVerification);
      return;
    }

    final info = _classifyDepositFailure(raw);
    _progressController.updateStage(
      DirectPayStage.failed,
      errorTitle: info.title,
      errorMessage: info.message,
      retryable: info.retryable,
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
    const maxTailTicks = 30; // ~5 minutes
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
      debugPrint('[Deposit] Account linked: ${state.account.id}, bankName: ${state.account.bankName}');
      setState(() {
        _linkedAccountId = state.account.id;
        _selectedBank = state.account.bankName; // narration + receipts
      });

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
      // Check deposit status
      final deposit = state.deposit;
      debugPrint('[Deposit] DepositStatusUpdated: status=${deposit.status}');
      if (deposit.status == DepositStatus.successful) {
        // Deposit completed - refresh balances
        _refreshAccountBalances(context);

        // Mark the sheet terminal. DO NOT navigate from here — that used to
        // call _navigateToDashboard() synchronously, tearing the progress sheet
        // down before it ever rendered its success state (the dashboard flashed
        // instead of the black sheet completing on the deposit screen). The
        // sheet's own onSuccess callback drives the pop + navigation AFTER it
        // shows "Deposit Successful", so the user sees it complete here first.
        _progressController.updateStage(DirectPayStage.success);
      } else if (deposit.status == DepositStatus.failed) {
        _showDepositFailure(deposit.failureReason);
      }
      // pending/processing → keep the sheet on "processing"; the poll
      // continues until a terminal status arrives.
    } else if (state is OpenBankingError) {
      debugPrint('[Deposit] OpenBankingError: ${state.message}, operation: ${state.operation}');
      // Don't surface link/unlink-list errors as a deposit failure (they're
      // background loads for the carousel); only deposit-flow errors matter.
      if (state.operation == 'fetchLinkedAccounts' || state.operation == 'unlinkAccount') {
        return;
      }
      _showDepositFailure(state.message);
    } else if (state is LinkedAccountsLoaded) {
      // Cache the user's linked banks for the "Deposit again" carousel.
      if (mounted) {
        setState(() => _linkedAccounts = state.accounts);
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

      // Refresh account balances
      _refreshAccountBalances(context);

      if (_isProgressSheetShown) {
        // Mono DirectPay/mandate: let the black progress sheet show "Deposit
        // Successful" ON the deposit screen, then navigate via its onSuccess
        // (shares the P1 terminal→navigate path). No dashboard flash.
        _progressController.updateStage(DirectPayStage.success);
      } else {
        // Flutterwave (no progress sheet): go straight to the dashboard, then
        // show the snackbar over it. (_navigateToDashboard is idempotent.)
        _navigateToDashboard();
        _showDepositCompletedSnackbar();
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
        IconButton(
          icon: Icon(
            _isVoiceEnabled ? Icons.mic : Icons.mic_off,
            color: _isVoiceEnabled ? const Color(0xFF3498DB) : Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isVoiceEnabled = !_isVoiceEnabled;
              if (_isVoiceEnabled) {
                _startListening();
              } else {
                _stopListening();
              }
            });
          },
        ),
            // serviceName='deposits' so the voice agent routes to the
            // deposit-funds tools (the previous 'loans' string was a
            // copy-paste leftover that sent the agent to the wrong
            // service). Chat icon follows so users can also drive the
            // same flow via text.
            ServiceVoiceButton(
              serviceName: 'deposits',
            ),
            SizedBox(width: 8.w),
            MicroserviceChatIcon(
              serviceName: 'Deposits',
              sourceContext: 'deposits',
            ),
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

  Widget _buildSelectedCardSummary() {
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
          Text(
            "$_currencySymbol${_cardBalance().toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
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
                  color: (widget.selectedCard['isUp'] == true)
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  widget.selectedCard['trend']?.toString() ?? '—',
                  style: TextStyle(
                    color: (widget.selectedCard['isUp'] == true)
                        ? Colors.green[300]
                        : Colors.red[300],
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
      );
    } catch (e) {
      debugPrint('[Deposit] MandateSetupBottomsheet error: $e');
    }
    debugPrint('[Deposit] MandateSetupBottomsheet returned: enabled=$enabled');

    if (!mounted) return;

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
    // "Deposit from to LazerVault".
    final bankLabel = _selectedBank.isNotEmpty ? _selectedBank : 'your bank';
    serviceLocator<OpenBankingCubit>().initiateDeposit(
      userId: userId,
      linkedAccountId: _linkedAccountId!,
      destinationAccountId: destinationAccountId,
      amount: amount,
      narration: 'Deposit from $bankLabel to LazerVault',
      accessToken: accessToken,
      currency: _currency,
      countryCode: _countryCodeForCurrency(_currency),
    );
  }


  @override
  void dispose() {
    _cancelLinkWatchdog();
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _flutterTts.stop();
    _speech.cancel();
    _progressController.dispose();
    super.dispose();
  }
}

/// Bottom sheet widget with bank search functionality
class _BankSearchBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> banks;
  final String selectedBank;
  final Function(String) onBankSelected;

  const _BankSearchBottomSheet({
    required this.banks,
    required this.selectedBank,
    required this.onBankSelected,
  });

  @override
  State<_BankSearchBottomSheet> createState() => _BankSearchBottomSheetState();
}

class _BankSearchBottomSheetState extends State<_BankSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _filteredBanks = widget.banks;
    _searchController.addListener(_filterBanks);
  }

  void _filterBanks() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = widget.banks;
      } else {
        _filteredBanks = widget.banks.where((bank) {
          final bankName = (bank['name'] as String? ?? '').toLowerCase();
          return bankName.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBanks);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Bank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Search field
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search banks...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 22.sp,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              autofocus: true,
            ),
          ),
          SizedBox(height: 16.h),
          // Results count
          if (_searchController.text.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                '${_filteredBanks.length} bank${_filteredBanks.length == 1 ? '' : 's'} found',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13.sp,
                ),
              ),
            ),
          // Bank list
          Expanded(
            child: _filteredBanks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No banks found',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try a different search term',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredBanks.length,
                    itemBuilder: (context, index) {
                      final bank = _filteredBanks[index];
                      final isSelected = widget.selectedBank == bank['name'];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onBankSelected(bank['name']),
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? bank['color'].withValues(alpha: 0.1)
                                  : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16.r),
                              border: isSelected
                                  ? Border.all(color: bank['color'], width: 2)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: bank['color'].withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    bank['icon'],
                                    color: bank['color'],
                                    size: 24.sp,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    bank['name'],
                                    style: TextStyle(
                                      color: isSelected
                                          ? bank['color']
                                          : Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: bank['color'],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Friendly, classified deposit-failure copy + whether an identical retry
/// could plausibly succeed.
class _DepositFailureInfo {
  final String title;
  final String message;
  final bool retryable;

  const _DepositFailureInfo(this.title, this.message, {required this.retryable});
}

/// The deposit methods the picker can offer. The set shown depends on the
/// wallet currency + platform (see `_availableMethods`).
enum _DepositMethod { linkAccount, applePay, bankTransfer, card }

extension _DepositMethodMeta on _DepositMethod {
  String get label {
    switch (this) {
      case _DepositMethod.linkAccount:
        return 'Link Account';
      case _DepositMethod.applePay:
        return 'Apple Pay';
      case _DepositMethod.bankTransfer:
        return 'Bank Transfer';
      case _DepositMethod.card:
        return 'Card';
    }
  }

  String get subtitle {
    switch (this) {
      case _DepositMethod.linkAccount:
        return 'Deposit straight from your bank via Mono';
      case _DepositMethod.applePay:
        return 'Fast, secure checkout with Apple Pay';
      case _DepositMethod.bankTransfer:
        return 'Transfer to your account number';
      case _DepositMethod.card:
        return 'Pay with a debit or credit card';
    }
  }

  IconData get icon {
    switch (this) {
      case _DepositMethod.linkAccount:
        return Icons.account_balance;
      case _DepositMethod.applePay:
        return Icons.apple;
      case _DepositMethod.bankTransfer:
        return Icons.swap_horiz;
      case _DepositMethod.card:
        return Icons.credit_card;
    }
  }
}
