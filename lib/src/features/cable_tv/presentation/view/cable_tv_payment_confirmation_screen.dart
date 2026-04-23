import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import '../../domain/entities/cable_tv_auto_recharge.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/smart_card_validation_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../widgets/cable_tv_rollover_preference_sheet.dart';

/// Confirm-payment screen for cable TV subscriptions. Mirrors the data
/// bundles + internet bill confirm screens — same save-as-beneficiary
/// + auto-renew UX so users see a consistent "keep it alive" flow
/// across bill types.
///
/// State probe: on mount we look up whether this smart card is already
/// a saved beneficiary and whether it has an active auto-renew. Toggles
/// are hidden when the feature is already set up so users don't
/// double-save.
class CableTVPaymentConfirmationScreen extends StatefulWidget {
  const CableTVPaymentConfirmationScreen({super.key});

  @override
  State<CableTVPaymentConfirmationScreen> createState() =>
      _CableTVPaymentConfirmationScreenState();
}

class _CableTVPaymentConfirmationScreenState
    extends State<CableTVPaymentConfirmationScreen>
    with TransactionPinMixin {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');
  bool _isProcessing = false;

  // Save-as-beneficiary state
  bool _saveBeneficiary = false;
  String? _beneficiaryNickname;

  // Auto-renew state
  bool _autoRenewEnabled = false;
  CableTVRolloverPreference? _rolloverPref;

  // Probe state
  bool _probeLoading = true;
  CableTVBeneficiary? _existingBeneficiary;
  CableTVAutoRecharge? _existingAutoRenew;

  // Account selector state
  AccountSummaryEntity? _selectedAccount;
  bool _accountAutoSelected = false;

  // "Set Auto-Renew" history action sets `preferRollover: true` in the
  // route args. We auto-open the picker ONCE per screen mount.
  bool _rolloverAutoOpenAttempted = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _probeExistingState();
      _loadAccounts();
    });
  }

  void _loadAccounts() {
    final state = context.read<AccountCardsSummaryCubit>().state;
    if (state is AccountCardsSummaryLoaded) {
      _preSelectAccount(state);
    } else {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
              userId: authState.profile.user.id,
            );
      }
    }
  }

  void _preSelectAccount(AccountCardsSummaryLoaded state) {
    if (_accountAutoSelected) return;
    final ngnAccounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == 'NGN')
        .toList();
    if (ngnAccounts.isEmpty) return;
    final primary = ngnAccounts.where((a) => a.isPrimary).firstOrNull;
    setState(() {
      _selectedAccount = primary ?? ngnAccounts.first;
      _accountAutoSelected = true;
    });
  }

  bool _hasSufficientBalance(AccountSummaryEntity account, double amount) =>
      account.availableBalance >= amount;

  /// Fetch beneficiaries + auto-recharges then hide matching toggles.
  /// Uses the datasource directly so the probe doesn't perturb cubit
  /// state that other screens rely on.
  Future<void> _probeExistingState() async {
    try {
      final args = Get.arguments as Map<String, dynamic>;
      final smartCardNumber = args['smartCardNumber'] as String;
      final provider = args['provider'] as CableTVProviderEntity;
      final providerCode = provider.serviceId.toLowerCase();

      final ds = GetIt.I<CableTVBeneficiaryRemoteDataSource>();
      final beneficiaries = await ds.getBeneficiaries();
      CableTVBeneficiary? match;
      for (final b in beneficiaries) {
        if (b.smartCardNumber == smartCardNumber &&
            b.providerCode.toLowerCase() == providerCode) {
          match = b;
          break;
        }
      }

      CableTVAutoRecharge? autoMatch;
      if (match != null) {
        try {
          final recharges = await ds.getAutoRecharges(status: 'active');
          for (final ar in recharges) {
            if (ar.beneficiaryId == match.id && ar.status == 'active') {
              autoMatch = ar;
              break;
            }
          }
        } catch (_) {
          // Soft-fail: beneficiary probe still useful on its own.
        }
      }

      if (!mounted) return;
      setState(() {
        _existingBeneficiary = match;
        _existingAutoRenew = autoMatch;
        _probeLoading = false;
      });
      _maybeAutoOpenRollover();
    } catch (_) {
      if (!mounted) return;
      setState(() => _probeLoading = false);
      _maybeAutoOpenRollover();
    }
  }

  /// "Set Auto-Renew" history action routes back into the purchase
  /// flow with `preferRollover: true`. Once we know there's no active
  /// auto-renew to clash with, auto-open the preference sheet so the
  /// user lands directly on the picker.
  ///
  /// Silently skipped when: args missing/wrong type, flag not set,
  /// an auto-renew already exists, toggle already on, package has
  /// zero amount, or auto-open was already attempted.
  void _maybeAutoOpenRollover() {
    if (_rolloverAutoOpenAttempted) return;
    final raw = Get.arguments;
    if (raw is! Map<String, dynamic>) return;
    if (raw['preferRollover'] != true) return;
    if (_existingAutoRenew != null) return;
    if (_autoRenewEnabled) return;
    final package = raw['package'];
    if (package is! TVPackageEntity) return;
    if (package.amount <= 0) return;
    _rolloverAutoOpenAttempted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_autoRenewEnabled) return;
      _onToggleAutoRenew(true);
    });
  }

  Future<String?> _promptForNickname() async {
    return showDialog<String>(
      context: context,
      builder: (ctx) => const _NicknameDialog(),
    );
  }

  Future<void> _onToggleSaveBeneficiary(bool newValue) async {
    if (!newValue) {
      setState(() {
        _saveBeneficiary = false;
        _beneficiaryNickname = null;
      });
      return;
    }
    final nickname = await _promptForNickname();
    // null means the user pressed Cancel — leave toggle off.
    // Empty string is allowed: card is saved using smart card number as display.
    if (nickname == null) return;
    if (!mounted) return;
    setState(() {
      _saveBeneficiary = true;
      _beneficiaryNickname = nickname.isEmpty ? null : nickname;
    });
  }

  Future<void> _onToggleAutoRenew(bool newValue) async {
    if (!newValue) {
      setState(() {
        _autoRenewEnabled = false;
        _rolloverPref = null;
      });
      return;
    }
    final pref = await CableTVRolloverPreferenceSheet.show(context);
    if (pref == null) return;
    if (!mounted) return;
    setState(() {
      _autoRenewEnabled = true;
      _rolloverPref = pref;
    });
  }

  void _onPay() async {
    if (_isProcessing) return;

    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as CableTVProviderEntity;
    final package = args['package'] as TVPackageEntity;
    final smartCardNumber = args['smartCardNumber'] as String;

    if (_selectedAccount == null) {
      Get.snackbar(
        'No Account Selected',
        'Please select a payment account',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (!_hasSufficientBalance(_selectedAccount!, package.amount)) {
      Get.snackbar(
        'Insufficient Balance',
        'Your account balance (₦${_selectedAccount!.availableBalance.toStringAsFixed(2)}) '
            'is less than ₦${_currencyFormat.format(package.amount)}',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    setState(() => _isProcessing = true);

    final transactionId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'cable_subscription',
      amount: package.amount,
      currency: 'NGN',
      title: 'Confirm Payment',
      message:
          'Confirm cable TV payment of ₦${_currencyFormat.format(package.amount)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) {
      setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    Get.offNamed(
      AppRoutes.cableTVPaymentProcessing,
      arguments: {
        'provider': provider,
        'package': package,
        'validation': args['validation'],
        'smartCardNumber': smartCardNumber,
        'transactionId': transactionId,
        'verificationToken': verificationToken!,
        'idempotencyKey': idempotencyKey,
        'accountId': _selectedAccount?.id,
        // Save + auto-renew flags — receipt screen consumes these on
        // successful payment.
        'saveBeneficiary': _saveBeneficiary,
        'beneficiaryNickname': _beneficiaryNickname,
        'autoRenewEnabled': _autoRenewEnabled,
        'rolloverPref': _rolloverPref,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as CableTVProviderEntity;
    final package = args['package'] as TVPackageEntity;
    final validation = args['validation'] as SmartCardValidationEntity;
    final smartCardNumber = args['smartCardNumber'] as String;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'Confirm Payment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
        listener: (context, state) {
          if (state is AccountCardsSummaryLoaded && !_accountAutoSelected) {
            _preSelectAccount(state);
          }
        },
        child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Summary card ──────────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                            color: const Color(0xFF2D2D2D), width: 1),
                      ),
                      child: Column(
                        children: [
                          _buildRow('Provider', provider.name),
                          _buildDivider(),
                          _buildRow('Smart Card', smartCardNumber),
                          _buildDivider(),
                          _buildRow('Customer', validation.customerName),
                          _buildDivider(),
                          _buildRow('Package', package.name),
                          if (validation.currentPackage.isNotEmpty) ...[
                            _buildDivider(),
                            _buildRow(
                                'Current', validation.currentPackage),
                          ],
                          if (package.validity.isNotEmpty) ...[
                            _buildDivider(),
                            _buildRow('Validity', package.validity),
                          ],
                          _buildDivider(),
                          // Total row — bigger, green
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 14.h),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF9CA3AF),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '₦${_currencyFormat.format(package.amount)}',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF10B981),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    // ── Pay From ──────────────────────────────────────────
                    _buildAccountCard(),
                    SizedBox(height: 14.h),
                    // ── Toggles card ──────────────────────────────────────
                    _buildToggleCard(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _isProcessing ? null : _onPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    disabledBackgroundColor:
                        const Color(0xFF4E03D0).withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: _isProcessing
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                      : Text(
                          'Pay ₦${_currencyFormat.format(package.amount)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
        ),  // SafeArea
      ),    // BlocListener
    );
  }

  Widget _buildAccountCard() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
                ),
              ),
            ),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          if (!_accountAutoSelected) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _preSelectAccount(state);
            });
          }
          if (_selectedAccount == null) {
            return GestureDetector(
              onTap: () => _showAccountSelector(state.accountSummaries),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_balance_wallet,
                        color: const Color(0xFF4E03D0), size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Select Payment Account',
                        style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: const Color(0xFF9CA3AF), size: 14.sp),
                  ],
                ),
              ),
            );
          }

          final args = Get.arguments as Map<String, dynamic>?;
          final package = args?['package'] as TVPackageEntity?;
          final hasSufficient = package == null ||
              _hasSufficientBalance(_selectedAccount!, package.amount);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pay From',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        _showAccountSelector(state.accountSummaries),
                    child: Text(
                      'Change',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4E03D0),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: hasSufficient
                      ? const Color(0xFF4E03D0).withValues(alpha: 0.08)
                      : const Color(0xFFEF4444).withValues(alpha: 0.08),
                  border: Border.all(
                    color: hasSufficient
                        ? const Color(0xFF4E03D0)
                        : const Color(0xFFEF4444).withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: hasSufficient
                            ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
                            : const Color(0xFFEF4444).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(19.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: hasSufficient
                            ? const Color(0xFF4E03D0)
                            : const Color(0xFFEF4444),
                        size: 18.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_selectedAccount!.currency} Account  ···${_selectedAccount!.accountNumberLast4}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Balance: ₦${_selectedAccount!.availableBalance.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!hasSufficient)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Insufficient',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEF4444),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    else
                      Icon(Icons.check_circle,
                          color: const Color(0xFF4E03D0), size: 22.sp),
                  ],
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _showAccountSelector(List<AccountSummaryEntity> all) {
    final ngnAccounts =
        all.where((a) => a.currency.toUpperCase() == 'NGN').toList();
    if (ngnAccounts.isEmpty) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Select Account',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.h),
            ...ngnAccounts.map((account) {
              final isSelected = _selectedAccount?.id == account.id;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedAccount = account);
                  Navigator.pop(sheetCtx);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                        : const Color(0xFF2D2D2D),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4E03D0)
                          : const Color(0xFF374151),
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        child: Icon(Icons.account_balance_wallet,
                            color: const Color(0xFF4E03D0), size: 18.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${account.currency} Account  ···${account.accountNumberLast4}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Balance: ₦${account.availableBalance.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle,
                            color: const Color(0xFF4E03D0), size: 20.sp),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  /// Both toggles in one card separated by a divider, so probe-loading,
  /// info and toggle states all stay vertically compact.
  Widget _buildToggleCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: _probeLoading
          ? Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation(Color(0xFF4E03D0)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Checking saved state…',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 13.sp),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                _buildToggleRow(
                  icon: _existingBeneficiary != null
                      ? Icons.bookmark
                      : Icons.bookmark_add_outlined,
                  title: _existingBeneficiary != null
                      ? 'Smart card saved'
                      : 'Save this smart card',
                  subtitle: _existingBeneficiary != null
                      ? () {
                          final nick = _existingBeneficiary!.nickname;
                          return (nick != null && nick.isNotEmpty)
                              ? 'Saved as "$nick"'
                              : 'Already in your contacts';
                        }()
                      : _saveBeneficiary
                          ? (_beneficiaryNickname != null &&
                                  _beneficiaryNickname!.isNotEmpty
                              ? 'Will save as "$_beneficiaryNickname"'
                              : 'Will save without a nickname')
                          : 'Quick repeat purchases next time',
                  isLocked: _existingBeneficiary != null,
                  value: _existingBeneficiary != null || _saveBeneficiary,
                  onChanged: _existingBeneficiary != null
                      ? null
                      : _onToggleSaveBeneficiary,
                ),
                _buildDivider(),
                _buildToggleRow(
                  icon: Icons.autorenew,
                  title: _existingAutoRenew != null
                      ? 'Auto-renew active'
                      : 'Enable auto-renew',
                  subtitle: _existingAutoRenew != null
                      ? 'On ${_existingAutoRenew!.frequency.toLowerCase()} schedule'
                      : _autoRenewEnabled && _rolloverPref != null
                          ? 'On ${_rolloverPref!.frequency} schedule'
                          : 'Keep this package alive automatically',
                  isLocked: _existingAutoRenew != null,
                  value: _existingAutoRenew != null || _autoRenewEnabled,
                  onChanged: _existingAutoRenew != null
                      ? null
                      : _onToggleAutoRenew,
                ),
              ],
            ),
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isLocked,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    final iconColor = isLocked
        ? const Color(0xFF10B981)
        : const Color(0xFF4E03D0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isLocked)
            Icon(Icons.check_circle,
                color: const Color(0xFF10B981), size: 18.sp)
          else
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: const Color(0xFF4E03D0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      const Divider(color: Color(0xFF2D2D2D), height: 1, thickness: 1);
}

/// Nested stateful dialog so the `TextEditingController` lifecycle is
/// tied to the dialog's own element tree — avoids a dispose race with
/// the fade-out animation that was showing up in debug builds on the
/// internet confirm screen.
class _NicknameDialog extends StatefulWidget {
  const _NicknameDialog();

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'Save as…',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'e.g. Home DSTV',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 15.sp,
          ),
          filled: true,
          fillColor: const Color(0xFF0A0A0A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Color(0xFF3B82F6)),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(
            'Save',
            style: GoogleFonts.inter(
              color: const Color(0xFF3B82F6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
