import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
import 'package:lazervault/src/features/tag_pay/presentation/cubit/tag_pay_cubit.dart';
import 'package:lazervault/src/features/tag_pay/presentation/cubit/tag_pay_state.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/tag_pay_entity.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../../domain/repositories/split_bill_repository.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class CreateSplitBillScreen extends StatefulWidget {
  const CreateSplitBillScreen({super.key});

  @override
  State<CreateSplitBillScreen> createState() => _CreateSplitBillScreenState();
}

class _CreateSplitBillScreenState extends State<CreateSplitBillScreen> {
  static const int _maxParticipants = 20;

  final _totalAmountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer.search();

  final List<_SelectedParticipant> _selectedParticipants = [];
  final Map<String, double> _customAmounts = {};
  final Map<String, double> _percentages = {};
  _SplitMethod _splitMethod = _SplitMethod.equal;

  bool _includeMyself = true;
  double _myShare = 0.0;
  bool _isCreating = false;

  // Receiver: who actually gets paid. null => creator collects (legacy default).
  _ReceiverMode _receiverMode = _ReceiverMode.collectMyself;
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
  }

  @override
  void dispose() {
    _totalAmountController.dispose();
    _descriptionController.dispose();
    _searchController.dispose();
    _receiverAccountNumberController.dispose();
    _debouncer.dispose();
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
            _customAmounts[_selectedParticipants[i].username] =
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
            final percentage = _percentages[participant.username] ?? 0.0;
            _customAmounts[participant.username] =
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

  void _addParticipant(TagPayEntity user) {
    if (_selectedParticipants.length >= _maxParticipants) {
      Get.snackbar(
        'Limit Reached',
        'Maximum $_maxParticipants co-payers allowed',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    if (_selectedParticipants.any((p) => p.username == user.tagPay)) {
      return;
    }
    setState(() {
      _selectedParticipants.add(_SelectedParticipant(
        username: user.tagPay,
        displayName: user.displayName,
      ));
    });
    _calculateSplits();
  }

  void _removeParticipant(String username) {
    setState(() {
      _selectedParticipants.removeWhere((p) => p.username == username);
      _customAmounts.remove(username);
      _percentages.remove(username);
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
    if (_totalAmount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid total amount',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_selectedParticipants.isEmpty) {
      Get.snackbar(
        'No Co-payers',
        'Please select at least one co-payer',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // External-bank receiver must have a verified account before we create.
    if (_bankReceiverActive && !_isBankReceiverReady) {
      Get.snackbar(
        'Bank Account Required',
        'Select a bank and verify a 10-digit account number to be paid to.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Verify total splits equal total amount
    double totalSplits =
        _customAmounts.values.fold(0.0, (sum, amt) => sum + amt) + _myShare;
    if ((totalSplits - _totalAmount).abs() > 0.01) {
      Get.snackbar(
        'Split Error',
        'Total splits ($_currencySymbol${NumberFormat('#,##0.00').format(totalSplits)}) do not equal total amount ($_currencySymbol${NumberFormat('#,##0.00').format(_totalAmount)})',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    setState(() => _isCreating = true);

    final participants = _selectedParticipants.map((p) {
      final amount = _customAmounts[p.username] ?? 0.0;
      final percentage = _percentages[p.username] ?? 0.0;
      return SplitBillParticipantInput(
        username: p.username,
        amount: amount,
        percentage: percentage,
      );
    }).toList();

    final SplitBillReceiverInput? receiver = switch (_receiverMode) {
      _ReceiverMode.lazerVaultUser when _receiverUsername != null =>
        SplitBillReceiverInput.internalUser(_receiverUsername!),
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
          totalAmount: _totalAmount,
          currency: _currency,
          description: _descriptionController.text.isEmpty
              ? 'Split Bill'
              : _descriptionController.text,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Create Split Bill',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
            Get.snackbar(
              'Success',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.offNamed(
              AppRoutes.splitBillDetail,
              arguments: {'splitBillId': state.bill.id},
            );
          } else if (state is SplitBillError) {
            setState(() => _isCreating = false);
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
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
                      _buildAmountInput(),
                      const SizedBox(height: 16),
                      _buildDescriptionInput(),
                      const SizedBox(height: 24),
                      _buildReceiverSection(),
                      const SizedBox(height: 24),
                      _buildSplitMethodSelector(),
                      const SizedBox(height: 16),
                      _buildIncludeMyselfToggle(),
                      const SizedBox(height: 24),
                      _buildParticipantsSection(),
                      const SizedBox(height: 16),
                      if (_selectedParticipants.isNotEmpty &&
                          _totalAmount > 0) ...[
                        _buildSummaryCard(),
                        const SizedBox(height: 24),
                      ],
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              if (_selectedParticipants.isNotEmpty && _totalAmount > 0)
                _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Amount',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _totalAmountController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: const TextStyle(
                color: Color(0xFF4B5563),
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              prefixText: _currencySymbol,
              prefixStyle: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              border: InputBorder.none,
            ),
            onChanged: (_) => _calculateSplits(),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionInput() {
    return TextField(
      controller: _descriptionController,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Description (e.g., Dinner at restaurant)',
        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
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
        _receiverUsername != null) {
      final name = (_receiverDisplayName?.isNotEmpty ?? false)
          ? _receiverDisplayName!
          : '@$_receiverUsername';
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
    final pickedUser = _receiverMode == _ReceiverMode.lazerVaultUser &&
        _receiverUsername != null;

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
          'Co-payers each pay their share to this receiver.',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildReceiverModeCard(
                mode: _ReceiverMode.collectMyself,
                icon: Icons.account_balance_wallet_outlined,
                title: "I'll collect it",
                subtitle: 'Paid to you',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildReceiverModeCard(
                mode: _ReceiverMode.lazerVaultUser,
                icon: Icons.person_outline,
                title: 'Another LazerVault user',
                subtitle: 'Pick a recipient',
              ),
            ),
            // External-bank receiver is admin-gated. When the flag is off the
            // option card (and its bank-entry section below) are not rendered,
            // so the step looks exactly like the internal-only version.
            if (_externalReceiverEnabled) ...[
              const SizedBox(width: 8),
              Expanded(
                child: _buildReceiverModeCard(
                  mode: _ReceiverMode.bankAccount,
                  icon: Icons.account_balance_outlined,
                  title: 'Bank account',
                  subtitle: 'Pay to a bank',
                ),
              ),
            ],
          ],
        ),
        if (_externalReceiverEnabled &&
            _receiverMode == _ReceiverMode.bankAccount) ...[
          const SizedBox(height: 12),
          _buildBankReceiverSection(),
        ],
        if (_receiverMode == _ReceiverMode.lazerVaultUser) ...[
          const SizedBox(height: 12),
          if (pickedUser)
            _buildSelectedReceiverChip()
          else
            GestureDetector(
              onTap: () => _showReceiverSearchBottomSheet(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF4834D4), size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Select a LazerVault user',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildReceiverModeCard({
    required _ReceiverMode mode,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _receiverMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() => _receiverMode = mode);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4834D4).withValues(alpha: 0.12)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4834D4)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF4834D4)
                  : const Color(0xFF9CA3AF),
              size: 22,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedReceiverChip() {
    final displayName = (_receiverDisplayName?.isNotEmpty ?? false)
        ? _receiverDisplayName!
        : '@$_receiverUsername';
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
      Get.snackbar(
        'Verification Failed',
        state.userMessage,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    }
  }

  void _verifyReceiverBankAccount() {
    final bankCode = _receiverBankCode;
    final acct = _receiverAccountNumberController.text.trim();
    if (bankCode == null) {
      Get.snackbar(
        'Bank Required',
        'Please select a bank first',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    if (acct.length != 10 || !RegExp(r'^\d{10}$').hasMatch(acct)) {
      Get.snackbar(
        'Invalid Account Number',
        'Account number must be exactly 10 digits',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
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

  Widget _buildBankReceiverSection() {
    final verified = _isBankReceiverReady;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bank picker
        GestureDetector(
          onTap: _showBankPickerBottomSheet,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                    color: Color(0xFF4834D4), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _receiverBankName ?? 'Select bank',
                    style: TextStyle(
                      color: _receiverBankName != null
                          ? Colors.white
                          : const Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF9CA3AF), size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Account number field
        TextField(
          controller: _receiverAccountNumberController,
          keyboardType: TextInputType.number,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: (value) {
            // Any change invalidates a previous verification.
            if (_receiverBankAccountName != null ||
                _receiverAccountNumber != null) {
              setState(() {
                _receiverBankAccountName = null;
                _receiverAccountNumber = null;
              });
            }
            if (value.length == 10) {
              _verifyReceiverBankAccount();
            }
          },
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Enter 10-digit account number',
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            prefixIcon:
                const Icon(Icons.numbers, color: Color(0xFF6B7280)),
            suffixIcon: _isVerifyingReceiverBank
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

  void _showBankPickerBottomSheet() {
    final banks = GetIt.I<BankRepository>().cachedSync(_bankCountry);
    final searchController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        var filtered = List<Map<String, String>>.from(banks);
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.75,
              minChildSize: 0.5,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B5563),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select Bank',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search banks...',
                          hintStyle:
                              const TextStyle(color: Color(0xFF6B7280)),
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFF6B7280)),
                          filled: true,
                          fillColor: const Color(0xFF2D2D2D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onChanged: (q) {
                          final query = q.trim().toLowerCase();
                          setSheetState(() {
                            filtered = query.isEmpty
                                ? List<Map<String, String>>.from(banks)
                                : banks
                                    .where((b) => (b['name'] ?? '')
                                        .toLowerCase()
                                        .contains(query))
                                    .toList();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final bank = filtered[index];
                          return ListTile(
                            leading: const Icon(Icons.account_balance,
                                color: Color(0xFF4834D4)),
                            title: Text(
                              bank['name'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _receiverBankCode = bank['code'];
                                _receiverBankName = bank['name'];
                                // Re-verify against the newly chosen bank.
                                _receiverBankAccountName = null;
                                _receiverAccountNumber = null;
                              });
                              Navigator.pop(sheetContext);
                              if (_receiverAccountNumberController.text
                                      .trim()
                                      .length ==
                                  10) {
                                _verifyReceiverBankAccount();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    ).whenComplete(searchController.dispose);
  }

  void _showReceiverSearchBottomSheet(BuildContext context) {
    final tagPayCubit = context.read<TagPayCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => BlocProvider.value(
        value: tagPayCubit,
        child: DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return _SearchUsersSheet(
              scrollController: scrollController,
              selectedUsernames: const {},
              onUserSelected: (user) {
                setState(() {
                  _receiverUsername = user.tagPay;
                  _receiverDisplayName = user.displayName;
                });
                Navigator.pop(bottomSheetContext);
              },
            );
          },
        ),
      ),
    );
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
            TextButton.icon(
              onPressed: () => _showSearchBottomSheet(context),
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Add'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4834D4),
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
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _showSearchBottomSheet(context),
                  child: const Text('Search users to add'),
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
    final amount = _customAmounts[participant.username] ?? 0.0;

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
              participant.displayName.isNotEmpty
                  ? participant.displayName[0].toUpperCase()
                  : participant.username[0].toUpperCase(),
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
                  participant.displayName.isNotEmpty
                      ? participant.displayName
                      : '@${participant.username}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (participant.displayName.isNotEmpty)
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
                  _customAmounts[participant.username] =
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
                  _percentages[participant.username] =
                      double.tryParse(value) ?? 0.0;
                  _calculateSplits();
                },
              ),
            ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _removeParticipant(participant.username),
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

  void _showSearchBottomSheet(BuildContext context) {
    final tagPayCubit = context.read<TagPayCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => BlocProvider.value(
        value: tagPayCubit,
        child: DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return _SearchUsersSheet(
              scrollController: scrollController,
              selectedUsernames: _selectedParticipants
                  .map((p) => p.username)
                  .toSet(),
              onUserSelected: (user) {
                _addParticipant(user);
                Navigator.pop(bottomSheetContext);
              },
            );
          },
        ),
      ),
    );
  }
}

class _SearchUsersSheet extends StatefulWidget {
  final ScrollController scrollController;
  final Set<String> selectedUsernames;
  final ValueChanged<TagPayEntity> onUserSelected;

  const _SearchUsersSheet({
    required this.scrollController,
    required this.selectedUsernames,
    required this.onUserSelected,
  });

  @override
  State<_SearchUsersSheet> createState() => _SearchUsersSheetState();
}

class _SearchUsersSheetState extends State<_SearchUsersSheet> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer.search();

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    final cleanQuery = normalizeLazerVaultUserSearchQuery(query);
    if (cleanQuery.length < 2) return;
    _debouncer.run(() {
      if (mounted) {
        context.read<TagPayCubit>().searchTagPay(cleanQuery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFF4B5563),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Search Users',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search by username...',
              hintStyle: const TextStyle(color: Color(0xFF6B7280)),
              prefixIcon:
                  const Icon(Icons.search, color: Color(0xFF6B7280)),
              filled: true,
              fillColor: const Color(0xFF2D2D2D),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: _onSearch,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: BlocBuilder<TagPayCubit, TagPayState>(
            builder: (context, state) {
              if (state is TagPayLoading) {
                return const Center(
                  child: LazerVaultLoader.small(),
                );
              }

              if (state is TagPaySearchResults) {
                final available = state.results
                    .where((r) =>
                        !widget.selectedUsernames.contains(r.tagPay))
                    .toList();

                if (available.isEmpty) {
                  return const Center(
                    child: Text(
                      'No users found',
                      style:
                          TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                  );
                }

                return ListView.builder(
                  controller: widget.scrollController,
                  itemCount: available.length,
                  itemBuilder: (context, index) {
                    final user = available[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color(0xFF4834D4).withValues(alpha: 0.2),
                        child: Text(
                          user.displayName.isNotEmpty
                              ? user.displayName[0].toUpperCase()
                              : user.tagPay[0].toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF4834D4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(
                        user.displayName.isNotEmpty
                            ? user.displayName
                            : '@${user.tagPay}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: user.displayName.isNotEmpty
                          ? Text(
                              '@${user.tagPay}',
                              style: const TextStyle(
                                  color: Color(0xFF9CA3AF)),
                            )
                          : null,
                      trailing: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF4834D4),
                      ),
                      onTap: () => widget.onUserSelected(user),
                    );
                  },
                );
              }

              if (state is TagPayError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Color(0xFFEF4444)),
                  ),
                );
              }

              return const Center(
                child: Text(
                  'Search for users by their username',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SelectedParticipant {
  final String username;
  final String displayName;

  const _SelectedParticipant({
    required this.username,
    required this.displayName,
  });
}

enum _SplitMethod { equal, custom, percentage }

enum _ReceiverMode { collectMyself, lazerVaultUser, bankAccount }
