import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/widgets/bank_picker_sheet.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_suggestion.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../../domain/repositories/split_bill_repository.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'create_split_bill_screen_widgets.dart';


class CreateSplitBillScreen extends StatefulWidget {
  const CreateSplitBillScreen({super.key});

  @override
  State<CreateSplitBillScreen> createState() => _CreateSplitBillScreenState();
}

class _CreateSplitBillScreenState extends State<CreateSplitBillScreen> {
  static const int _maxParticipants = 20;

  final _totalAmountController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<_SelectedParticipant> _selectedParticipants = [];
  final Map<String, double> _customAmounts = {};
  final Map<String, double> _percentages = {};
  _SplitMethod _splitMethod = _SplitMethod.equal;

  bool _includeMyself = true;
  double _myShare = 0.0;
  bool _isCreating = false;

  // The current user's id, loaded once. Used to stop the creator from adding
  // THEMSELVES as a co-payer (they're already included via the "I'm also paying"
  // toggle) — the backend rejects that too ("cannot add yourself as a
  // participant"), but catching it inline is a friendlier error.
  String? _currentUserId;

  // Two-step wizard: 0 = amount/details, 1 = participants/review.
  int _step = 0;

  // Receiver: who actually gets paid. null => creator collects (legacy default).
  _ReceiverMode _receiverMode = _ReceiverMode.collectMyself;
  String? _receiverUserId;
  String? _receiverUsername;
  String? _receiverDisplayName;

  // External-bank receiver state. Bank list + account-name verification reuse
  // the app-wide AccountVerificationCubit (PaymentsService.VerifyBankAccount via
  // Paystack) — the same mechanism the Add-Recipient / send-funds flow uses.
  String? _receiverBankCode;
  String? _receiverBankName;
  String? _receiverAccountNumber;
  String? _receiverBankAccountName; // resolved holder name once verified
  bool _isVerifyingReceiverBank = false;
  final _receiverAccountNumberController = TextEditingController();
  // Account-number-FIRST flow (mirrors Send Funds): on 10 digits we auto-suggest
  // the bank(s) with the holder name already resolved; tap one to prefill + confirm.
  List<AccountSuggestion> _receiverBankSuggestions = const [];
  bool _suggestingReceiverBanks = false;

  String get _currency {
    final acctDetails = GetIt.I<AccountManager>().activeAccountDetails;
    return acctDetails?.currency ?? 'NGN';
  }

  /// Admin-controlled feature flag (cached/refreshed in the background by
  /// [EndpointRegistry], so this is a synchronous, cheap read). When false the
  /// external-bank receiver option is hidden entirely and the receiver step
  /// looks exactly like it did before the bank option existed.
  bool get _externalReceiverEnabled =>
      endpointRegistry.splitBillExternalReceiverEnabled;

  /// Country used for the external-bank picker. Derived from the active
  /// account currency (same source as [_currency]); defaults to NG. The bank
  /// list comes from [BanksData] for this country.
  String get _bankCountry {
    switch (_currency.toUpperCase()) {
      case 'NGN':
        return 'NG';
      case 'GBP':
        return 'GB';
      case 'USD':
        return 'US';
      case 'GHS':
        return 'GH';
      case 'KES':
        return 'KE';
      case 'ZAR':
        return 'ZA';
      default:
        return 'NG';
    }
  }

  String get _currencySymbol {
    switch (_currency.toUpperCase()) {
      case 'NGN':
        return '\u20a6';
      case 'GBP':
        return '\u00a3';
      case 'EUR':
        return '\u20ac';
      case 'USD':
        return '\$';
      case 'ZAR':
        return 'R';
      case 'GHS':
        return 'GH\u20b5'; // cedi \u2014 matches the GH bank-country support
      case 'KES':
        return 'KSh'; // shilling \u2014 matches the KE bank-country support
      default:
        return '\u20a6';
    }
  }

  @override
  void initState() {
    super.initState();
    // Warm the dynamic (Flutterwave) bank list for the external-bank picker
    // (only NG has a dynamic source; non-NG is a no-op).
    GetIt.I<BankRepository>().warmUp('NG');
    // Resolve the current user id (used to block adding yourself as a co-payer).
    GetIt.I<SecureStorageService>().getUserId().then((id) {
      if (mounted && id != null && id.trim().isNotEmpty) {
        setState(() => _currentUserId = id.trim());
      }
    });
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _receiverAccountNumberController.dispose();
    super.dispose();
  }

  double get _totalAmount {
    return double.tryParse(_totalAmountController.text) ?? 0.0;
  }

  int get _totalParticipants {
    return _selectedParticipants.length + (_includeMyself ? 1 : 0);
  }

  void _calculateSplits() {
    if (_totalAmount <= 0 || _totalParticipants == 0) {
      setState(() {
        _myShare = 0.0;
        _customAmounts.clear();
        _percentages.clear();
      });
      return;
    }

    switch (_splitMethod) {
      case _SplitMethod.equal:
        final totalCents = (_totalAmount * 100).round();
        final baseCents = totalCents ~/ _totalParticipants;
        var remainderCents = totalCents - (baseCents * _totalParticipants);
        setState(() {
          if (_includeMyself) {
            _myShare = (baseCents + remainderCents) / 100.0;
            remainderCents = 0;
          } else {
            _myShare = 0.0;
          }
          for (var i = 0; i < _selectedParticipants.length; i++) {
            final extra = (i == 0 && remainderCents > 0) ? remainderCents : 0;
            _customAmounts[_selectedParticipants[i].key] =
                (baseCents + extra) / 100.0;
          }
        });

      case _SplitMethod.custom:
        double totalAssigned =
            _customAmounts.values.fold(0.0, (sum, amt) => sum + amt);
        setState(() {
          _myShare = _includeMyself
              ? (_totalAmount - totalAssigned).clamp(0.0, _totalAmount)
              : 0.0;
        });

      case _SplitMethod.percentage:
        setState(() {
          for (var participant in _selectedParticipants) {
            final percentage = _percentages[participant.key] ?? 0.0;
            _customAmounts[participant.key] =
                _totalAmount * (percentage / 100.0);
          }
          double totalAssigned =
              _customAmounts.values.fold(0.0, (sum, amt) => sum + amt);
          _myShare = _includeMyself
              ? (_totalAmount - totalAssigned).clamp(0.0, _totalAmount)
              : 0.0;
        });
    }
  }

  /// Adds a co-payer from a resolved Lazervault user (search result OR a device
  /// contact matched to a Lazervault user via [UsernameSearchBottomSheet]).
  /// Co-payers are keyed by their stable id; max-20 cap + dedupe preserved.
  void _addParticipant({
    required String userId,
    required String username,
    required String displayName,
  }) {
    if (_selectedParticipants.length >= _maxParticipants) {
      showAppSnackbar(
        'Limit Reached',
        'Maximum $_maxParticipants co-payers allowed',
        type: AppSnackbarType.error,
      );
      return;
    }
    final key = userId.isNotEmpty ? userId : username;
    // Dedupe by stable key (also covers re-adding the same person).
    if (_selectedParticipants.any((p) => p.key == key)) {
      return;
    }
    setState(() {
      _selectedParticipants.add(_SelectedParticipant(
        userId: userId,
        username: username,
        displayName: displayName,
      ));
    });
    _calculateSplits();
  }

  /// Maps a [UserSearchResultEntity] onto the (username, displayName) the
  /// participant/receiver models use. Returns null + surfaces a friendly
  /// snackbar when the pick can't be used as a Lazervault co-payer.
  ///
  /// The "is this a Lazervault user" decision keys off [isLazervaultUser] (the
  /// backend `is_lazervault_user` flag / a non-empty userId), NOT the username —
  /// username is frequently empty for users matched by name/phone/email or for
  /// saved internal recipients, and the old username-only gate wrongly rejected
  /// them as "not on Lazervault".
  ({String userId, String username, String displayName})? _resolvePickedUser(
      UserSearchResultEntity user, {bool asParticipant = true}) {
    // Genuinely off-platform (e.g. a device contact who hasn't signed up).
    if (!user.isLazervaultUser) {
      showAppSnackbar(
        'Not on Lazervault',
        "They're not on Lazervault yet — invite them or add their bank as the "
            'receiver instead.',
        type: AppSnackbarType.error,
        duration: const Duration(seconds: 4),
      );
      return null;
    }
    final userId = user.userId.trim();
    final username = user.username.trim();
    // Block adding YOURSELF as a co-payer: you're already covered by the "I'm
    // also paying" toggle + your creator share, so adding yourself would be a
    // double count (the backend rejects it too — this is the friendlier inline
    // path). Not applied to the receiver picker (collecting to yourself is fine,
    // though the dedicated "I'll collect it" option is simpler).
    if (asParticipant &&
        _currentUserId != null &&
        userId.isNotEmpty &&
        userId == _currentUserId) {
      showAppSnackbar(
        "That's you",
        "You're already included as a payer — use the \"I'm also paying\" "
            'toggle to set your own share.',
        type: AppSnackbarType.error,
        duration: const Duration(seconds: 4),
      );
      return null;
    }
    // The backend keys co-payers/receiver by user id (preferred), falling back
    // to username — so a missing @handle no longer blocks a valid user. Only
    // bail if BOTH are absent (no stable identifier to key them by).
    if (userId.isEmpty && username.isEmpty) {
      showAppSnackbar(
        'Couldn\'t add them',
        "We couldn't load their account details — please try again.",
        type: AppSnackbarType.error,
        duration: const Duration(seconds: 4),
      );
      return null;
    }
    return (
      userId: userId,
      username: username,
      displayName: user.fullName.trim(),
    );
  }

  void _removeParticipant(String key) {
    setState(() {
      _selectedParticipants.removeWhere((p) => p.key == key);
      _customAmounts.remove(key);
      _percentages.remove(key);
    });
    _calculateSplits();
  }

  SplitMethodType _toSplitMethodType() {
    return switch (_splitMethod) {
      _SplitMethod.equal => SplitMethodType.equal,
      _SplitMethod.custom => SplitMethodType.custom,
      _SplitMethod.percentage => SplitMethodType.percentage,
    };
  }

  void _createSplitBill() {
    if (_titleController.text.trim().isEmpty) {
      showAppSnackbar(
        'Title Required',
        'Please give this split bill a title',
        type: AppSnackbarType.error,
      );
      return;
    }

    if (_totalAmount <= 0) {
      showAppSnackbar(
        'Invalid Amount',
        'Please enter a valid total amount',
        type: AppSnackbarType.error,
      );
      return;
    }

    if (_selectedParticipants.isEmpty) {
      showAppSnackbar(
        'No Co-payers',
        'Please select at least one co-payer',
        type: AppSnackbarType.error,
      );
      return;
    }

    // External-bank receiver must have a verified account before we create.
    if (_bankReceiverActive && !_isBankReceiverReady) {
      showAppSnackbar(
        'Bank Account Required',
        'Select a bank and verify a 10-digit account number to be paid to.',
        type: AppSnackbarType.error,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Verify total splits equal total amount
    double totalSplits =
        _customAmounts.values.fold(0.0, (sum, amt) => sum + amt) + _myShare;
    if ((totalSplits - _totalAmount).abs() > 0.01) {
      showAppSnackbar(
        'Split Error',
        'Total splits ($_currencySymbol${NumberFormat('#,##0.00').format(totalSplits)}) do not equal total amount ($_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount)})',
        type: AppSnackbarType.error,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    setState(() => _isCreating = true);

    final participants = _selectedParticipants.map((p) {
      final amount = _customAmounts[p.key] ?? 0.0;
      final percentage = _percentages[p.key] ?? 0.0;
      return SplitBillParticipantInput(
        userId: p.userId,
        username: p.username,
        displayName: p.displayName,
        amount: amount,
        percentage: percentage,
      );
    }).toList();

    final SplitBillReceiverInput? receiver = switch (_receiverMode) {
      _ReceiverMode.lazerVaultUser when _receiverUserId != null =>
        SplitBillReceiverInput.internalUser(
          userId: _receiverUserId!,
          username: _receiverUsername ?? '',
          displayName: _receiverDisplayName ?? '',
        ),
      // Gated on the admin flag via [_bankReceiverActive]: when the feature is
      // off this falls through to `null` (creator collects / internal default).
      _ReceiverMode.bankAccount when _bankReceiverActive && _isBankReceiverReady =>
        SplitBillReceiverInput.externalBank(
          bankCode: _receiverBankCode!,
          accountNumber: _receiverAccountNumber!,
        ),
      _ => null,
    };

    context.read<SplitBillCubit>().createSplitBill(
          title: _titleController.text.trim(),
          totalAmount: _totalAmount,
          currency: _currency,
          description: _descriptionController.text.trim(),
          splitMethod: _toSplitMethodType(),
          creatorShare: _myShare,
          participants: participants,
          receiver: receiver,
          includeSelfAsCopayer: _includeMyself,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: _step == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => setState(() => _step = 0),
              )
            : null,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create Split Bill',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Step ${_step + 1} of 2 · ${_step == 0 ? 'Amount & details' : 'People'}',
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Row(
            children: [
              Expanded(
                child: Container(height: 3, color: const Color(0xFF4834D4)),
              ),
              Expanded(
                child: Container(
                  height: 3,
                  color: _step == 1
                      ? const Color(0xFF4834D4)
                      : const Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AccountVerificationCubit, AccountVerificationState>(
            listener: _onAccountVerificationStateChanged,
          ),
          BlocListener<SplitBillCubit, SplitBillState>(
            listener: (context, state) {
          if (!mounted) return;
          if (state is SplitBillCreated) {
            setState(() => _isCreating = false);
            showAppSnackbar(
              'Success',
              state.message,
              type: AppSnackbarType.success,
            );
            Get.offNamed(
              AppRoutes.splitBillDetail,
              arguments: {'splitBillId': state.bill.id},
            );
          } else if (state is SplitBillError) {
            setState(() => _isCreating = false);
            showAppSnackbar(
              'Error',
              state.message,
              type: AppSnackbarType.error,
              duration: const Duration(seconds: 4),
            );
          }
        },
          ),
        ],
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      if (_step == 0) ...[
                        _buildTitleInput(),
                        const SizedBox(height: 16),
                        _buildAmountInput(),
                        const SizedBox(height: 16),
                        _buildDescriptionInput(),
                        const SizedBox(height: 24),
                        _buildReceiverSection(),
                        const SizedBox(height: 24),
                        _buildSplitMethodSelector(),
                        const SizedBox(height: 16),
                        _buildIncludeMyselfToggle(),
                      ] else ...[
                        _buildParticipantsSection(),
                        const SizedBox(height: 16),
                        if (_selectedParticipants.isNotEmpty &&
                            _totalAmount > 0) ...[
                          _buildSummaryCard(),
                          const SizedBox(height: 24),
                        ],
                      ],
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              _buildStepBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Total amount',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        // Compact single-line amount field (was an oversized 32px hero box that
        // read as a display, not an input).
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Text(
                _currencySymbol,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _totalAmountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onChanged: (_) => _calculateSplits(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _titleController,
          maxLength: 100,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: 'e.g., Dinner at Terra Kulture',
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            counterStyle: const TextStyle(color: Color(0xFF4B5563), fontSize: 11),
            prefixIcon:
                const Icon(Icons.title_rounded, color: Color(0xFF6B7280)),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4834D4)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionInput() {
    return TextField(
      controller: _descriptionController,
      maxLength: 500,
      maxLines: 2,
      minLines: 1,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Add a note (optional)',
        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
        counterStyle: const TextStyle(color: Color(0xFF4B5563), fontSize: 11),
        prefixIcon:
            const Icon(Icons.description_outlined, color: Color(0xFF6B7280)),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4834D4)),
        ),
      ),
    );
  }

  /// Defensive: the bank-receiver mode only counts as active while the admin
  /// flag is on. If the flag flips off after a selection (or via a stale
  /// state), every gate below treats the receiver as the no-receiver/internal
  /// default so a disabled feature can never be submitted.
  bool get _bankReceiverActive =>
      _externalReceiverEnabled && _receiverMode == _ReceiverMode.bankAccount;

  /// True once a bank + a verified 10-digit account are selected.
  bool get _isBankReceiverReady =>
      _receiverBankCode != null &&
      (_receiverAccountNumber?.length == 10) &&
      (_receiverBankAccountName?.isNotEmpty ?? false);

  String get _receiverSummaryLabel {
    if (_receiverMode == _ReceiverMode.lazerVaultUser &&
        _receiverUserId != null) {
      final name = (_receiverDisplayName?.isNotEmpty ?? false)
          ? _receiverDisplayName!
          : ((_receiverUsername?.isNotEmpty ?? false)
              ? '@$_receiverUsername'
              : 'Lazervault user');
      return name;
    }
    if (_bankReceiverActive && _isBankReceiverReady) {
      // Prefer the verified holder name; fall back to "<bank> ••••<last4>".
      if (_receiverBankAccountName?.isNotEmpty ?? false) {
        return _receiverBankAccountName!;
      }
      final acct = _receiverAccountNumber!;
      final last4 = acct.length >= 4 ? acct.substring(acct.length - 4) : acct;
      return '${_receiverBankName ?? 'Bank'} ••••$last4';
    }
    return 'You';
  }

  Widget _buildReceiverSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Who's getting paid?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Pick who collects the money — co-payers each pay their share to them.',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
        ),
        const SizedBox(height: 12),
        // Option 1 — the creator collects (default / legacy behaviour).
        _buildReceiverOption(
          mode: _ReceiverMode.collectMyself,
          icon: Icons.account_balance_wallet_outlined,
          title: "I'll collect it",
          subtitle: 'Shares are paid into your wallet',
        ),
        const SizedBox(height: 10),
        // Option 2 — another Lazervault user / contact. The picker expands
        // inline under the option once it's selected.
        _buildReceiverOption(
          mode: _ReceiverMode.lazerVaultUser,
          icon: Icons.person_outline,
          title: 'A Lazervault user',
          subtitle: 'Pay another Lazervault user',
          expandedChild: _buildLazerVaultUserPicker(),
        ),
        // Option 3 — an external bank account (admin-gated). Rendered as part
        // of the same coherent selector when enabled, with the bank-entry +
        // name-verification form inline. When the flag is off the option (and
        // its form) are not rendered, so the step looks internal-only.
        if (_externalReceiverEnabled) ...[
          const SizedBox(height: 10),
          _buildReceiverOption(
            mode: _ReceiverMode.bankAccount,
            icon: Icons.account_balance_outlined,
            title: 'A bank account',
            subtitle: 'Pay out to any Nigerian bank account',
            expandedChild: _buildBankReceiverSection(),
          ),
        ],
      ],
    );
  }

  /// One full-width selectable receiver option. A leading icon chip, a title +
  /// subtitle with room to breathe (unlike the old cramped 3-up cards), a
  /// trailing radio, and — when selected — an inline [expandedChild] (the
  /// LazerVault-user picker or the bank-entry form). Tapping the row selects it.
  Widget _buildReceiverOption({
    required _ReceiverMode mode,
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? expandedChild,
  }) {
    final isSelected = _receiverMode == mode;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF4834D4).withValues(alpha: 0.10)
            : const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              isSelected ? const Color(0xFF4834D4) : const Color(0xFF2D2D2D),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => setState(() => _receiverMode = mode),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4834D4).withValues(alpha: 0.18)
                          : const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: isSelected
                          ? const Color(0xFF4834D4)
                          : const Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFFE5E7EB),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    size: 20,
                    color: isSelected
                        ? const Color(0xFF4834D4)
                        : const Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),
          if (isSelected && expandedChild != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: expandedChild,
            ),
        ],
      ),
    );
  }

  /// Inline Lazervault-user picker shown under the "A Lazervault user" option
  /// once selected: a chip for the picked user, or a tap-target that opens the
  /// shared username/contact search sheet (same one the co-payer add uses).
  Widget _buildLazerVaultUserPicker() {
    if (_receiverUserId != null) return _buildSelectedReceiverChip();
    return GestureDetector(
      onTap: () => _showReceiverSearchBottomSheet(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF141414),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: Color(0xFF4834D4), size: 20),
            SizedBox(width: 12),
            Text(
              'Select a Lazervault user',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedReceiverChip() {
    final hasUsername = _receiverUsername?.isNotEmpty ?? false;
    final displayName = (_receiverDisplayName?.isNotEmpty ?? false)
        ? _receiverDisplayName!
        : (hasUsername ? '@$_receiverUsername' : 'Lazervault user');
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4834D4)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFF4834D4).withValues(alpha: 0.2),
            child: Text(
              displayName.replaceAll('@', '').isNotEmpty
                  ? displayName.replaceAll('@', '')[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                color: Color(0xFF4834D4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (hasUsername)
                  Text(
                    '@$_receiverUsername',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _showReceiverSearchBottomSheet(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4834D4),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Change'),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _receiverUserId = null;
                _receiverUsername = null;
                _receiverDisplayName = null;
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child:
                  Icon(Icons.close, color: Color(0xFFEF4444), size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // External-bank receiver UI + verification
  // ===========================================================================

  /// Reacts to the app-wide [AccountVerificationCubit] used by the send-funds /
  /// add-recipient flow. We only consume results while the bank-account
  /// receiver mode is active so we don't react to verifications triggered by
  /// other screens that share this global cubit.
  void _onAccountVerificationStateChanged(
      BuildContext context, AccountVerificationState state) {
    if (!mounted) return;
    if (_receiverMode != _ReceiverMode.bankAccount) return;

    if (state is AccountVerificationLoading) {
      setState(() => _isVerifyingReceiverBank = true);
    } else if (state is AccountVerificationSuccess) {
      setState(() {
        _isVerifyingReceiverBank = false;
        _receiverBankCode = state.bankCode;
        _receiverAccountNumber = state.accountNumber;
        _receiverBankAccountName = state.accountName;
        if (state.bankName.isNotEmpty) _receiverBankName = state.bankName;
      });
    } else if (state is AccountVerificationFailure) {
      setState(() {
        _isVerifyingReceiverBank = false;
        _receiverBankAccountName = null;
      });
      showAppSnackbar(
        'Verification Failed',
        state.userMessage,
        type: AppSnackbarType.error,
        duration: const Duration(seconds: 4),
      );
    }
  }

  void _verifyReceiverBankAccount() {
    final bankCode = _receiverBankCode;
    final acct = _receiverAccountNumberController.text.trim();
    if (bankCode == null) {
      showAppSnackbar(
        'Bank Required',
        'Please select a bank first',
        type: AppSnackbarType.error,
      );
      return;
    }
    if (acct.length != 10 || !RegExp(r'^\d{10}$').hasMatch(acct)) {
      showAppSnackbar(
        'Invalid Account Number',
        'Account number must be exactly 10 digits',
        type: AppSnackbarType.error,
      );
      return;
    }
    context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: bankCode,
          accountNumber: acct,
          bankName: _receiverBankName ?? '',
          country: _bankCountry,
        );
  }

  /// Account-first: on a full 10-digit number with no bank chosen yet, ask the
  /// backend which bank(s) it could belong to (holder name already resolved).
  Future<void> _suggestReceiverBanks(String accountNumber) async {
    setState(() => _suggestingReceiverBanks = true);
    final suggestions =
        await context.read<AccountVerificationCubit>().suggestBanks(
              accountNumber: accountNumber,
              country: _bankCountry,
            );
    if (!mounted) return;
    setState(() {
      _suggestingReceiverBanks = false;
      _receiverBankSuggestions = suggestions;
    });
  }

  /// Tapping a suggestion prefills the bank + confirms the receiver (the holder
  /// name came back resolved from the suggest call), so no second verify is needed.
  void _selectReceiverSuggestion(AccountSuggestion s) {
    setState(() {
      _receiverBankCode = s.bankCode;
      _receiverBankName = s.bankName;
      _receiverAccountNumber = s.accountNumber;
      _receiverBankAccountName = s.accountName;
      _receiverBankSuggestions = const [];
    });
  }

  Widget _buildReceiverSuggestionRow(AccountSuggestion s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: GestureDetector(
        onTap: () => _selectReceiverSuggestion(s),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_balance,
                  color: Color(0xFF4834D4), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.accountName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      s.bankName,
                      style: const TextStyle(
                          color: Color(0xFF9CA3AF), fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right,
                  color: Color(0xFF9CA3AF), size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankReceiverSection() {
    final verified = _isBankReceiverReady;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Account number FIRST (mirrors Send Funds). On 10 digits we auto-suggest
        // the bank with the holder name resolved; a manual bank picker is the fallback.
        TextField(
          controller: _receiverAccountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: (value) {
            // Any change invalidates a previous verification + suggestions.
            if (_receiverBankAccountName != null ||
                _receiverAccountNumber != null ||
                _receiverBankSuggestions.isNotEmpty) {
              setState(() {
                _receiverBankAccountName = null;
                _receiverAccountNumber = null;
                _receiverBankSuggestions = const [];
              });
            }
            if (value.length == 10) {
              // If a bank is already chosen, verify directly; otherwise suggest banks.
              if (_receiverBankCode != null) {
                _verifyReceiverBankAccount();
              } else {
                _suggestReceiverBanks(value);
              }
            }
          },
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Enter the 10-digit account number',
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            prefixIcon:
                const Icon(Icons.numbers, color: Color(0xFF6B7280)),
            suffixIcon: (_isVerifyingReceiverBank || _suggestingReceiverBanks)
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: LazerVaultLoader.small(),
                    ),
                  )
                : (verified
                    ? const Icon(Icons.check_circle,
                        color: Color(0xFF10B981))
                    : null),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4834D4)),
            ),
          ),
        ),
        // Auto-suggested banks for the entered account number (tap to prefill +
        // confirm — the holder name is already resolved).
        if (!verified && _receiverBankSuggestions.isNotEmpty) ...[
          const SizedBox(height: 10),
          const Text(
            'Select the account holder’s bank',
            style: TextStyle(
                color: Color(0xFF9CA3AF), fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          ..._receiverBankSuggestions.map(_buildReceiverSuggestionRow),
        ],
        // Manual bank picker fallback (secondary to the auto-suggest above).
        if (!verified) ...[
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _showBankPickerBottomSheet,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _receiverBankCode != null
                      ? const Color(0xFF4834D4)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance,
                      color: Color(0xFF4834D4), size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _receiverBankName ?? 'Or choose the bank manually',
                      style: TextStyle(
                        color: _receiverBankName != null
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.keyboard_arrow_down,
                      color: Color(0xFF9CA3AF), size: 18),
                ],
              ),
            ),
          ),
        ],
        // Verified account holder name (read-only confirmation)
        if (verified) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle,
                    color: Color(0xFF10B981), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Account verified',
                        style: TextStyle(
                          color: Color(0xFF10B981),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _receiverBankAccountName!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        // Fee disclosure
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.info_outline, color: Color(0xFF9CA3AF), size: 14),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'A bank transfer fee may be deducted from the payout.',
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showBankPickerBottomSheet() async {
    // Reuse the shared bank-search sheet (the SAME widget the send-funds /
    // add-recipient flow uses), rendered in the dark split-bills palette. It
    // owns/disposes its own controller and shows bank logos with an initials
    // fallback — no bespoke picker, and none of the `dependents.isEmpty`
    // teardown the old autofocus+whenComplete-dispose sheet tripped.
    final bank = await BankPickerSheet.show(
      context,
      country: _bankCountry,
      selectedBankCode: _receiverBankCode,
      theme: BankPickerTheme.dark(),
    );
    if (!mounted || bank == null) return;
    setState(() {
      _receiverBankCode = bank['code'];
      _receiverBankName = bank['name'];
      // A new bank invalidates any prior verification + suggestions.
      _receiverBankAccountName = null;
      _receiverAccountNumber = null;
      _receiverBankSuggestions = const [];
    });
    if (_receiverAccountNumberController.text.trim().length == 10) {
      _verifyReceiverBankAccount();
    }
  }

  /// Receiver picker — Lazervault user OR device contact (resolved to a
  /// Lazervault user) via the shared [UsernameSearchBottomSheet].
  Future<void> _showReceiverSearchBottomSheet(BuildContext context) async {
    final picked = await UsernameSearchBottomSheet.show(context);
    if (!mounted || picked == null) return;
    final resolved = _resolvePickedUser(picked, asParticipant: false);
    if (resolved == null) return; // not-on-Lazervault contact (snackbar shown)
    setState(() {
      _receiverUserId = resolved.userId;
      _receiverUsername = resolved.username;
      _receiverDisplayName = resolved.displayName;
    });
  }

  Widget _buildSplitMethodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Split Method',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child: _buildMethodChip(_SplitMethod.equal, 'Equal')),
            const SizedBox(width: 8),
            Expanded(
                child: _buildMethodChip(_SplitMethod.custom, 'Custom')),
            const SizedBox(width: 8),
            Expanded(
                child:
                    _buildMethodChip(_SplitMethod.percentage, 'Percentage')),
          ],
        ),
      ],
    );
  }

  Widget _buildMethodChip(_SplitMethod method, String label) {
    final isSelected = _splitMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() => _splitMethod = method);
        _calculateSplits();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4834D4)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4834D4)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIncludeMyselfToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, color: Color(0xFF4834D4)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "I'm also a co-payer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_includeMyself && _myShare > 0)
                  Text(
                    'My share: $_currencySymbol${NumberFormat('#,##0.00').format(_myShare)}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: _includeMyself,
            onChanged: (value) {
              setState(() => _includeMyself = value);
              _calculateSplits();
            },
            activeTrackColor: const Color(0xFF4834D4),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Co-payers (${_selectedParticipants.length})',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showSearchBottomSheet(context),
              icon: const Icon(Icons.person_add_alt_1, size: 18),
              label: const Text('Add person'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4834D4),
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        if (_selectedParticipants.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.group_outlined,
                    size: 28,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'No co-payers added',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _showSearchBottomSheet(context),
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text('Search users to add'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF4834D4)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          )
        else
          ..._selectedParticipants
              .map((p) => _buildParticipantCard(p)),
      ],
    );
  }

  Widget _buildParticipantCard(_SelectedParticipant participant) {
    final amount = _customAmounts[participant.key] ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor:
                const Color(0xFF4834D4).withValues(alpha: 0.2),
            child: Text(
              _participantInitial(participant),
              style: const TextStyle(
                color: Color(0xFF4834D4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _participantPrimary(participant),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Show @handle as a secondary line only when we have both a
                // display name AND a username (avoids a lone "@").
                if (participant.displayName.isNotEmpty &&
                    participant.username.isNotEmpty)
                  Text(
                    '@${participant.username}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          if (_splitMethod == _SplitMethod.equal)
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$_currencySymbol${NumberFormat('#,##0.00').format(amount)}',
                style: const TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else if (_splitMethod == _SplitMethod.custom)
            SizedBox(
              width: 100,
              child: TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: const TextStyle(color: Color(0xFF4B5563)),
                  prefixText: _currencySymbol,
                  prefixStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  filled: true,
                  fillColor: const Color(0xFF2D2D2D),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _customAmounts[participant.key] =
                      double.tryParse(value) ?? 0.0;
                  _calculateSplits();
                },
              ),
            )
          else
            SizedBox(
              width: 80,
              child: TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: const TextStyle(color: Color(0xFF4B5563)),
                  suffixText: '%',
                  suffixStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  filled: true,
                  fillColor: const Color(0xFF2D2D2D),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _percentages[participant.key] =
                      double.tryParse(value) ?? 0.0;
                  _calculateSplits();
                },
              ),
            ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _removeParticipant(participant.key),
            child: const Icon(Icons.close, color: Color(0xFFEF4444), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4834D4).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4834D4).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total Amount',
              '$_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount)}'),
          const SizedBox(height: 8),
          _buildSummaryRow('Paying to', _receiverSummaryLabel),
          const SizedBox(height: 8),
          _buildSummaryRow('Co-payers', '$_totalParticipants'),
          if (_splitMethod == _SplitMethod.equal) ...[
            const SizedBox(height: 8),
            _buildSummaryRow('Per Person',
                '$_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount / _totalParticipants)}'),
          ],
          if (_includeMyself && _myShare > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow('Your Share',
                '$_currencySymbol${NumberFormat('#,##0.00').format(_myShare)}'),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Safe display helpers — a globally-searched user may arrive with an empty
  // username or display name; never index [0] on an empty string or show "@".
  String _participantInitial(_SelectedParticipant p) {
    final base = p.displayName.isNotEmpty
        ? p.displayName
        : (p.username.isNotEmpty ? p.username : 'U');
    return base[0].toUpperCase();
  }

  String _participantPrimary(_SelectedParticipant p) {
    if (p.displayName.isNotEmpty) return p.displayName;
    if (p.username.isNotEmpty) return '@${p.username}';
    return 'Lazervault user';
  }

  /// Step-aware bottom bar: "Next" (step 0 → validate + advance) or the
  /// create bar (step 1).
  Widget _buildStepBar() {
    if (_step == 1) return _buildBottomBar();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _goToStepTwo,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4834D4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Validate step-1 inputs (title + amount + receiver) before advancing to people.
  void _goToStepTwo() {
    if (_titleController.text.trim().isEmpty) {
      showAppSnackbar('Title required', 'Give this split bill a title first.',
          type: AppSnackbarType.error);
      return;
    }
    if (_totalAmount <= 0) {
      showAppSnackbar('Enter an amount', 'Enter the total bill amount first.',
          type: AppSnackbarType.error);
      return;
    }
    if (_bankReceiverActive && !_isBankReceiverReady) {
      showAppSnackbar('Receiver incomplete',
          'Select a bank and verify the account number.',
          type: AppSnackbarType.error);
      return;
    }
    setState(() => _step = 1);
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_bankReceiverActive && !_isBankReceiverReady) ...[
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      color: Color(0xFFFB923C), size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Select a bank and verify the account number',
                    style:
                        TextStyle(color: Color(0xFFFB923C), fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
            SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_isCreating ||
                    (_bankReceiverActive && !_isBankReceiverReady))
                ? null
                : _createSplitBill,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4834D4),
              disabledBackgroundColor:
                  const Color(0xFF4834D4).withValues(alpha: 0.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: _isCreating
                ? LazerVaultLoader.small()
                : const Text(
                    'Create Split Bill',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
          ],
        ),
      ),
    );
  }

  /// Co-payer picker — Lazervault user OR device contact (resolved to a
  /// Lazervault user) via the shared [UsernameSearchBottomSheet].
  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final picked = await UsernameSearchBottomSheet.show(context);
    if (!mounted || picked == null) return;
    final resolved = _resolvePickedUser(picked);
    if (resolved == null) return; // not-on-Lazervault contact (snackbar shown)
    _addParticipant(
      userId: resolved.userId,
      username: resolved.username,
      displayName: resolved.displayName,
    );
  }
}
