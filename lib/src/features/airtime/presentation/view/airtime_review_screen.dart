import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_auto_recharge_create_sheet.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../widgets/airtime_step_indicator.dart';

class AirtimeReviewScreen extends StatefulWidget {
  const AirtimeReviewScreen({super.key});

  @override
  State<AirtimeReviewScreen> createState() => _AirtimeReviewScreenState();
}

class _AirtimeReviewScreenState extends State<AirtimeReviewScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  Country? country;
  NetworkProvider? networkProvider;
  String? phoneNumber;
  String? recipientName;
  double? amount;
  double? fee;
  double? totalAmount;
  String? _selectedAccountId;
  bool _isProcessing = false;
  bool _autoSelectedAccount = false;

  // ── Save-as-contact + auto-recharge toggle state ─────────────────────
  // Mirrors electricity's pre-payment "save beneficiary + auto-recharge"
  // tile pair. Both flags + the auto-recharge prefs are forwarded through
  // the processing screen's args to the receipt, which fires the actual
  // RPCs once the payment lands in a terminal completed state.
  bool _saveAsContact = false;
  bool _enableAutoRecharge = false;
  /// Set if the recipient phone is already a saved contact — turns the
  /// "Save as contact" toggle into a passive "Already saved" info row.
  String? _existingBeneficiaryId;
  String? _existingBeneficiaryNickname;
  /// Captured by [BillAutoRechargeCreateSheet] when the user toggles
  /// auto-recharge ON. Carries amount + frequency + day + execution time.
  /// Stays null while the toggle is OFF or the sheet is cancelled.
  Map<String, dynamic>? _autoRechargePref;
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _loadAccounts();
    // Probe saved contacts so the toggle row can render its
    // "Already saved" passive variant when the recipient is a known
    // beneficiary instead of inviting the user to save a duplicate.
    context.read<AirtimeCubit>().loadBeneficiaries();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      country = args['country'];
      networkProvider = args['provider'];
      phoneNumber = args['phoneNumber'];
      recipientName = args['recipientName'];
      amount = args['amount'];
      fee = args['fee'];
      totalAmount = args['totalAmount'];
    }
  }

  void _loadAccounts() {
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      _autoSelectAccount(accountState);
    } else {
      final userId = context.read<AuthenticationCubit>().userId ?? '';
      context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
        userId: userId,
      );
    }
  }

  void _autoSelectAccount(AccountCardsSummaryLoaded state) {
    if (_autoSelectedAccount) return;
    final currency = country?.currency ?? 'NGN';
    final matchingAccounts = state.accountSummaries
        .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
        .toList();

    for (final account in matchingAccounts) {
      if (_hasSufficientBalance(account)) {
        _selectedAccountId = account.id.toString();
        _autoSelectedAccount = true;
        break;
      }
    }
    // If no account with sufficient balance, select the first matching account
    if (_selectedAccountId == null && matchingAccounts.isNotEmpty) {
      _selectedAccountId = matchingAccounts.first.id.toString();
      _autoSelectedAccount = true;
    }
  }

  bool _hasSufficientBalance(dynamic account) {
    final currency = country?.currency ?? 'NGN';
    if (account.currency.toUpperCase() != currency.toUpperCase()) {
      return false;
    }
    return account.availableBalance >= (totalAmount ?? amount ?? 0);
  }

  /// Process payment with transaction PIN validation — payment runs inside PIN modal
  void _processPayment() async {
    if (_isProcessing) return;
    if (_selectedAccountId == null) {
      _showError('Please select an account to pay from');
      return;
    }

    // Check for insufficient balance before proceeding
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is AccountCardsSummaryLoaded) {
      final selectedAccount = accountState.accountSummaries
          .where((a) => a.id.toString() == _selectedAccountId)
          .firstOrNull;
      if (selectedAccount != null && !_hasSufficientBalance(selectedAccount)) {
        final currency = country?.currency ?? 'NGN';
        final needed = totalAmount ?? amount ?? 0;
        Get.snackbar(
          'Insufficient Balance',
          'Your ${selectedAccount.accountType} account has $currency ${selectedAccount.availableBalance.toStringAsFixed(2)} but you need $currency ${needed.toStringAsFixed(2)}',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return;
      }
    }

    if (networkProvider != null && phoneNumber != null && amount != null && country != null) {
      setState(() => _isProcessing = true);
      final transactionId = 'airtime_${DateTime.now().millisecondsSinceEpoch}_${phoneNumber!.replaceAll(RegExp(r'[^\d]'), '')}';

      String? verificationToken;

      final success = await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'airtime_purchase',
        amount: amount!,
        currency: country!.currency,
        title: 'Confirm Airtime Purchase',
        message: 'Confirm airtime purchase of ${country!.currency} ${amount!.toStringAsFixed(2)}',
        showProcessingPhase: false,
        onPinValidated: (token) async {
          verificationToken = token;
        },
      );

      if (!success || verificationToken == null) {
        if (mounted) setState(() => _isProcessing = false);
        return;
      }
      if (!mounted) return;

      // Navigate to processing screen — it handles the payment and routes to receipt
      Get.offNamed(AppRoutes.airtimePaymentProcessing, arguments: {
        'countryCode': country!.code,
        'networkProviderId': networkProvider!.id,
        'phoneNumber': phoneNumber!,
        'amount': amount!,
        'currency': country!.currency,
        'transactionId': transactionId,
        'verificationToken': verificationToken!,
        'sourceAccountId': _selectedAccountId!,
        'operatorId': networkProvider!.operatorId,
        'reloadlyOperatorId': networkProvider!.reloadlyOperatorId,
        'providerName': networkProvider!.name,
        // Forward the keep-alive toggle state so the receipt can fire
        // saveAirtimeBeneficiary + createAirtimeAutoRecharge once the
        // payment is in a terminal completed state.
        'saveAsContact': _saveAsContact && _existingBeneficiaryId == null,
        if (_nicknameController.text.trim().isNotEmpty)
          'nickname': _nicknameController.text.trim(),
        if (_existingBeneficiaryId != null)
          'existingBeneficiaryId': _existingBeneficiaryId!,
        'enableAutoRecharge':
            _enableAutoRecharge && _autoRechargePref != null,
        if (_enableAutoRecharge && _autoRechargePref != null)
          'autoRechargePref': _autoRechargePref!,
        'networkCode': networkProvider!.type.name.toUpperCase(),
        'networkName': networkProvider!.name,
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _showAccountChangeSheet() {
    final currency = country?.currency ?? 'NGN';
    final accountState = context.read<AccountCardsSummaryCubit>().state;
    if (accountState is! AccountCardsSummaryLoaded) return;

    final matchingAccounts = accountState.accountSummaries
        .where((a) => a.currency.toUpperCase() == currency.toUpperCase())
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                'Select Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...matchingAccounts.map((account) {
              final isSelected = _selectedAccountId == account.id.toString();
              final hasSufficientBalance = _hasSufficientBalance(account);

              return GestureDetector(
                onTap: hasSufficientBalance
                    ? () {
                        setState(() {
                          _selectedAccountId = account.id.toString();
                        });
                        Navigator.pop(sheetContext);
                      }
                    : () {
                        Get.snackbar(
                          'Insufficient Balance',
                          'This account does not have enough funds. You need $currency ${(totalAmount ?? amount!).toStringAsFixed(2)}',
                          backgroundColor: const Color(0xFFFB923C),
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: !hasSufficientBalance
                        ? const Color(0xFF0A0A0A).withValues(alpha: 0.5)
                        : isSelected
                            ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                            : const Color(0xFF0A0A0A),
                    border: Border.all(
                      color: !hasSufficientBalance
                          ? const Color(0xFFEF4444).withValues(alpha: 0.3)
                          : isSelected
                              ? const Color(0xFF4E03D0)
                              : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: !hasSufficientBalance
                              ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                              : const Color(0xFF4E03D0).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet,
                          color: !hasSufficientBalance
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF4E03D0),
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              account.accountType,
                              style: TextStyle(
                                color: !hasSufficientBalance
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${account.currency} ${account.availableBalance.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: !hasSufficientBalance
                                    ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                                    : const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!hasSufficientBalance)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Insufficient',
                            style: TextStyle(
                              color: const Color(0xFFEF4444),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (isSelected && hasSufficientBalance)
                        Icon(
                          Icons.check_circle,
                          color: const Color(0xFF4E03D0),
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (networkProvider == null || phoneNumber == null || amount == null) {
      return Scaffold(
        backgroundColor: Color(0xFF0A0E27),
        body: Center(
          child: Text(
            'Invalid transaction data',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        // Listen for the saved-contacts probe. When the list lands, see
        // if this recipient is already a beneficiary so the save toggle
        // renders as a passive "Already saved" info row instead of
        // inviting a duplicate.
        child: BlocListener<AirtimeCubit, AirtimeState>(
          listenWhen: (_, s) => s is AirtimeBeneficiariesLoaded,
          listener: (context, state) {
            if (state is! AirtimeBeneficiariesLoaded) return;
            final cleanInput =
                (phoneNumber ?? '').replaceAll(RegExp(r'[^\d]'), '');
            for (final b in state.beneficiaries) {
              final cleanSaved =
                  b.phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
              if (cleanSaved == cleanInput && cleanInput.isNotEmpty) {
                if (!mounted) return;
                setState(() {
                  _existingBeneficiaryId = b.id;
                  _existingBeneficiaryNickname = b.nickname ?? b.phoneNumber;
                });
                break;
              }
            }
          },
          child: Column(
          children: [
            _buildHeader(),
            const AirtimeStepIndicator(currentStep: 2),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    // Consolidated "Transaction Details" card collapses
                    // the previous Transaction Summary + Recipient cards
                    // into one so the keep-alive tiles + payment
                    // breakdown still fit at-a-glance on common phone
                    // screen sizes (the screen stays scrollable for
                    // smaller devices).
                    _buildConsolidatedDetailsCard(),
                    SizedBox(height: 12.h),
                    _buildAccountSelector(),
                    SizedBox(height: 12.h),
                    _buildPaymentBreakdownCard(),
                    SizedBox(height: 12.h),
                    _buildKeepAliveTiles(),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
        ),
      ),
    );
  }

  // ===================================================================
  // Save-as-contact + auto-recharge toggle tiles
  // ===================================================================

  /// Pair of tiles below the payment breakdown:
  ///   * Save as contact   — toggle (or "Already saved" info)
  ///   * Set auto-recharge — toggle that opens the create sheet to
  ///     capture freq/amount/time, stores the prefs locally so the
  ///     receipt can fire `createAirtimeAutoRecharge` post-success.
  Widget _buildKeepAliveTiles() {
    final saveTile = (_existingBeneficiaryId == null)
        ? _buildToggleRow(
            icon: Icons.bookmark_outline,
            title: 'Save as contact',
            subtitle: _saveAsContact &&
                    _nicknameController.text.trim().isNotEmpty
                ? 'Nickname: ${_nicknameController.text.trim()}'
                : 'Quick top-up this number next time',
            value: _saveAsContact,
            onChanged: _onToggleSaveContact,
          )
        : _buildInfoRow(
            icon: Icons.bookmark,
            title: 'Contact already saved',
            subtitle:
                'Saved as "${_existingBeneficiaryNickname ?? phoneNumber ?? ''}"',
          );

    final autoTile = _buildToggleRow(
      icon: Icons.autorenew,
      title: 'Set auto-recharge',
      subtitle: _enableAutoRecharge && _autoRechargePref != null
          ? _formatAutoRechargeSummary(_autoRechargePref!)
          : 'Top up this number on a schedule',
      value: _enableAutoRecharge,
      onChanged: _onToggleAutoRecharge,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [saveTile, SizedBox(height: 8.h), autoTile],
    );
  }

  Widget _buildToggleRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: const Color(0xFF4E03D0), size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF4E03D0),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: const Color(0xFF10B981), size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Save-as-contact toggle handler. Mirrors the electricity meter
  /// "Save as beneficiary" flow: turning ON opens a nickname dialog;
  /// cancelling or submitting an empty value keeps the switch off so a
  /// blank-nicknamed contact never gets saved by accident. Turning OFF
  /// clears the nickname controller so re-toggling re-prompts.
  Future<void> _onToggleSaveContact(bool value) async {
    if (!value) {
      setState(() {
        _saveAsContact = false;
        _nicknameController.clear();
      });
      return;
    }
    final nickname = await _promptForNickname();
    if (nickname == null || nickname.trim().isEmpty) {
      // User cancelled — keep the switch off so the toggle doesn't end
      // up "on" with no nickname behind it.
      if (mounted) setState(() => _saveAsContact = false);
      return;
    }
    setState(() {
      _saveAsContact = true;
      _nicknameController.text = nickname.trim();
    });
  }

  Future<String?> _promptForNickname() {
    return showDialog<String>(
      context: context,
      builder: (_) => _AirtimeNicknameDialog(
        initial: _nicknameController.text.trim(),
        recipient: phoneNumber ?? '',
        networkName: networkProvider?.name ?? 'Contact',
      ),
    );
  }

  /// Auto-recharge toggle handler. Turning ON opens the shared create
  /// sheet to capture freq/amount/time without firing the API — the
  /// receipt screen makes the actual call once the payment + the
  /// beneficiary id are both available. Cancelling the sheet flips the
  /// toggle back off.
  Future<void> _onToggleAutoRecharge(bool value) async {
    if (!value) {
      setState(() {
        _enableAutoRecharge = false;
        _autoRechargePref = null;
      });
      return;
    }
    Map<String, dynamic>? captured;
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle:
          '${networkProvider?.name ?? 'Network'} · ${phoneNumber ?? ''}',
      title: 'Auto-recharge schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      initialAmount: amount,
      // Use the network's actual per-transaction range so the picker
      // refuses a value the upstream provider would reject.
      minAmount: networkProvider?.minAmount ?? 50,
      maxAmount: networkProvider?.maxAmount,
      onSubmit: ({
        required double amount,
        required String frequency,
        required int dayOfWeek,
        required int dayOfMonth,
        required int executionHour,
        required int executionMinute,
      }) async {
        captured = {
          'amount': amount,
          'frequency': frequency,
          'dayOfWeek': dayOfWeek,
          'dayOfMonth': dayOfMonth,
          'executionHour': executionHour,
          'executionMinute': executionMinute,
        };
      },
    );
    if (!mounted) return;
    setState(() {
      _enableAutoRecharge = captured != null;
      _autoRechargePref = captured;
    });
  }

  String _formatAutoRechargeSummary(Map<String, dynamic> pref) {
    final freq = (pref['frequency'] as String?) ?? 'daily';
    final amt = (pref['amount'] as num?)?.toDouble() ?? 0;
    final hour = (pref['executionHour'] as int?) ?? 0;
    final minute = (pref['executionMinute'] as int?) ?? 0;
    final cs = country?.currencySymbol ?? '₦';
    String when;
    switch (freq.toLowerCase()) {
      case 'weekly':
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        final idx = ((pref['dayOfWeek'] as int?) ?? 0).clamp(0, 6);
        when = 'Every ${days[idx]}';
        break;
      case 'monthly':
        when = 'Day ${pref['dayOfMonth'] ?? 1} each month';
        break;
      default:
        when = 'Every day';
    }
    final time =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    return '$when at $time · $cs${amt.toStringAsFixed(0)}';
  }

  /// Consolidated "Transaction Details" card — replaces the previous
  /// Transaction Summary + Recipient Details split. Same visual rhythm
  /// as the receipt's details card so the user sees consistent rows
  /// across review → receipt.
  Widget _buildConsolidatedDetailsCard() {
    final cs = country?.currencySymbol ?? '₦';
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _buildDetailRow('Recipient', phoneNumber ?? ''),
          if ((recipientName ?? '').trim().isNotEmpty) ...[
            SizedBox(height: 10.h),
            _buildDetailRow('Name', recipientName!.trim()),
          ],
          SizedBox(height: 10.h),
          _buildDetailRow('Network', networkProvider?.name ?? ''),
          SizedBox(height: 10.h),
          _buildDetailRow('Country', country?.name ?? ''),
          SizedBox(height: 10.h),
          _buildDetailRow(
            'Amount',
            '$cs${(amount ?? 0).toStringAsFixed(0)}',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Review Transaction',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Please confirm your airtime purchase',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.until((route) => route.settings.name == AppRoutes.airtime || route.isFirst),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.close,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _buildTransactionSummaryCard and _buildRecipientDetailsCard were
  // collapsed into _buildConsolidatedDetailsCard above to free vertical
  // space for the new keep-alive tiles (save contact + auto-recharge).

  Widget _buildAccountSelector() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is AccountCardsSummaryLoading) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AccountCardsSummaryLoaded) {
          // Auto-select on first load
          if (!_autoSelectedAccount) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _autoSelectAccount(state));
              }
            });
          }

          // Find the selected account
          final selectedAccount = _selectedAccountId != null
              ? state.accountSummaries
                  .where((a) => a.id.toString() == _selectedAccountId)
                  .firstOrNull
              : null;

          if (selectedAccount == null) {
            return GestureDetector(
              onTap: _showAccountChangeSheet,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet,
                      color: const Color(0xFF4E03D0),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Select Account',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: const Color(0xFF9CA3AF),
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            );
          }

          final hasSufficientBalance = _hasSufficientBalance(selectedAccount);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pay From',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showAccountChangeSheet,
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: const Color(0xFF4E03D0),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: hasSufficientBalance
                      ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                      : const Color(0xFF1F1F1F).withValues(alpha: 0.5),
                  border: Border.all(
                    color: hasSufficientBalance
                        ? const Color(0xFF4E03D0)
                        : const Color(0xFFEF4444).withValues(alpha: 0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: hasSufficientBalance
                            ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
                            : const Color(0xFFEF4444).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Icons.account_balance_wallet,
                        color: hasSufficientBalance
                            ? const Color(0xFF4E03D0)
                            : const Color(0xFFEF4444),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedAccount.accountType,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${selectedAccount.currency} ${selectedAccount.availableBalance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!hasSufficientBalance)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Insufficient',
                          style: TextStyle(
                            color: const Color(0xFFEF4444),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (hasSufficientBalance)
                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF4E03D0),
                        size: 24.sp,
                      ),
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

  Widget _buildPaymentBreakdownCard() {
    final hasFee = fee != null && fee! > 0;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Breakdown',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          _buildBreakdownRow(hasFee ? 'Airtime Amount' : 'Amount', amount!, isTotal: !hasFee),

          if (hasFee) ...[
            SizedBox(height: 8.h),
            _buildBreakdownRow('Service Fee', fee!),

            SizedBox(height: 12.h),
            Divider(color: Colors.white.withValues(alpha: 0.1)),
            SizedBox(height: 12.h),

            _buildBreakdownRow('Total Amount', totalAmount ?? amount!, isTotal: true),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: isTotal ? Colors.white : Colors.white.withValues(alpha: 0.6),
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          '${country?.currencySymbol ?? '₦'}${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            color: Colors.white,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4E03D0),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: _isProcessing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Processing...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
                  'Confirm Payment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

}

/// Nickname-collection dialog opened when "Save as contact" is toggled
/// on. Mirrors the electricity meter "_NicknameDialog": single text
/// field, Cancel returns null, Save returns the trimmed value (refuses
/// empty so the toggle stays off when the user submits a blank field).
class _AirtimeNicknameDialog extends StatefulWidget {
  final String initial;
  final String recipient;
  final String networkName;
  const _AirtimeNicknameDialog({
    required this.initial,
    required this.recipient,
    required this.networkName,
  });

  @override
  State<_AirtimeNicknameDialog> createState() =>
      _AirtimeNicknameDialogState();
}

class _AirtimeNicknameDialogState extends State<_AirtimeNicknameDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final v = _controller.text.trim();
    if (v.isEmpty) {
      setState(() => _error = 'Nickname is required');
      return;
    }
    Navigator.of(context).pop(v);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'Save this contact',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Give ${widget.recipient.isNotEmpty ? widget.recipient : "this number"} '
            'a nickname so you can find it fast next time.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
            decoration: InputDecoration(
              hintText: 'e.g. Mum, Brother, Office',
              hintStyle: TextStyle(
                color: const Color(0xFF4B5563),
                fontSize: 14.sp,
              ),
              errorText: _error,
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
                borderSide: const BorderSide(color: Color(0xFF4E03D0)),
              ),
            ),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
        ],
      ),
      actionsPadding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ),
        TextButton(
          onPressed: _submit,
          child: Text(
            'Save',
            style: TextStyle(
              color: const Color(0xFF4E03D0),
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
