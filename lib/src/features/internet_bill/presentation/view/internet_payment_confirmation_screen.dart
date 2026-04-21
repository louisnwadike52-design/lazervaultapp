import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/internet_auto_recharge.dart';
import '../../domain/entities/internet_beneficiary.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../cubit/internet_auto_recharge_cubit.dart';
import '../cubit/internet_beneficiary_cubit.dart';
import '../widgets/internet_rollover_preference_sheet.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';

/// Confirm-payment screen for internet subscriptions. Mirrors the data
/// bundles confirm screen — same save-as-beneficiary + rollover UX so
/// users see a consistent "keep it alive" flow across bill types.
///
/// State probe: on mount we look up whether this ISP account is already
/// a saved beneficiary and whether it has an active rollover schedule.
/// Toggles are hidden when the feature is already set up so users don't
/// double-save.
class InternetPaymentConfirmationScreen extends StatefulWidget {
  const InternetPaymentConfirmationScreen({super.key});

  @override
  State<InternetPaymentConfirmationScreen> createState() =>
      _InternetPaymentConfirmationScreenState();
}

class _InternetPaymentConfirmationScreenState
    extends State<InternetPaymentConfirmationScreen>
    with TransactionPinMixin {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');
  bool _isProcessing = false;

  // Save-as-beneficiary state
  bool _saveBeneficiary = false;
  String? _beneficiaryNickname;

  // Rollover state
  bool _autoRenewEnabled = false;
  InternetRolloverPreference? _rolloverPref;

  // Probe state
  bool _probeLoading = true;
  InternetBeneficiary? _existingBeneficiary;
  InternetAutoRecharge? _existingRollover;

  // "Set Rollover" history action sets `preferRollover: true` in the
  // route args. We auto-open the picker ONCE per screen mount — once
  // attempted the user is in control, so re-entrant calls are no-ops
  // even if the probe paths both reach the auto-open site.
  bool _rolloverAutoOpenAttempted = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _probeExistingState());
  }

  /// Fetch beneficiaries + auto-recharges then hide matching toggles.
  /// Uses the datasource directly so the probe doesn't perturb cubit
  /// state that other screens rely on.
  Future<void> _probeExistingState() async {
    try {
      final args = Get.arguments as Map<String, dynamic>;
      final provider = args['provider'] as InternetProviderEntity;
      final accountNumber = args['accountNumber'] as String;
      final providerCode = _providerCodeFor(provider.serviceId);

      final ds = GetIt.I<InternetBeneficiaryRemoteDataSource>();
      final beneficiaries =
          await ds.getBeneficiaries(providerCode: providerCode);
      InternetBeneficiary? match;
      for (final b in beneficiaries) {
        if (b.accountNumber == accountNumber &&
            b.providerCode == providerCode) {
          match = b;
          break;
        }
      }

      InternetAutoRecharge? rolloverMatch;
      if (match != null) {
        final recharges = await ds.getAutoRecharges(status: 'active');
        for (final ar in recharges) {
          if (ar.beneficiaryId == match.id && ar.status == 'active') {
            rolloverMatch = ar;
            break;
          }
        }
      }

      if (!mounted) return;
      setState(() {
        _existingBeneficiary = match;
        _existingRollover = rolloverMatch;
        _probeLoading = false;
      });
      _maybeAutoOpenRollover();
    } catch (_) {
      if (!mounted) return;
      setState(() => _probeLoading = false);
      _maybeAutoOpenRollover();
    }
  }

  /// "Set Rollover" action on the history sheet routes back into the
  /// purchase flow with `preferRollover: true`. Once we know there's no
  /// existing active rollover to clash with, auto-open the preference
  /// sheet so the user lands directly on the picker instead of hunting
  /// for the toggle.
  ///
  /// Silently skipped when:
  ///   * args are missing / wrong type (cold-start without a route arg),
  ///   * `preferRollover` flag isn't set,
  ///   * the probe already saw an active rollover for this account,
  ///   * the user already enabled the toggle themselves,
  ///   * the selected package has no amount (backend rejects zero-amount
  ///     rollover — opening a picker that can't save is worse than
  ///     nothing), or
  ///   * auto-open was already attempted this mount.
  void _maybeAutoOpenRollover() {
    if (_rolloverAutoOpenAttempted) return;
    final raw = Get.arguments;
    if (raw is! Map<String, dynamic>) return;
    if (raw['preferRollover'] != true) return;
    if (_existingRollover != null) return;
    if (_autoRenewEnabled) return;
    final package = raw['package'];
    if (package is! InternetPackageEntity) return;
    if (package.amount <= 0) return;
    _rolloverAutoOpenAttempted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Re-check in case the user tapped the toggle in the frame
      // between scheduling and firing.
      if (_autoRenewEnabled) return;
      _onToggleRollover(true);
    });
  }

  /// Map VTpass serviceID → canonical uppercase provider_code used on
  /// the backend (beneficiary table, webhooks, async events, etc.).
  String _providerCodeFor(String serviceId) {
    switch (serviceId.toLowerCase()) {
      case 'smile-direct':
      case 'smile':
        return 'SMILE';
      case 'spectranet':
        return 'SPECTRANET';
      case 'ipnx':
      case 'ipnx1515':
        return 'IPNX';
      case 'swift4g':
      case 'swift':
        return 'SWIFT';
      default:
        return serviceId.toUpperCase();
    }
  }

  Future<String?> _promptForNickname() async {
    // Using a nested StatefulWidget for the dialog body so the
    // TextEditingController's lifecycle is tied to the dialog's own
    // element tree. Previously the controller was created on the
    // outer State and disposed synchronously right after the dialog
    // future resolved — that raced with the dialog's close animation
    // (TextField still held listeners on the controller during the
    // fade-out), triggering "dependents.isEmpty is not true" in
    // debug builds. Letting the dialog own its controller eliminates
    // the race.
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
    if (nickname == null || nickname.isEmpty) return;
    setState(() {
      _saveBeneficiary = true;
      _beneficiaryNickname = nickname;
    });
  }

  Future<void> _onToggleRollover(bool newValue) async {
    if (!newValue) {
      setState(() {
        _autoRenewEnabled = false;
        _rolloverPref = null;
      });
      return;
    }
    final pref = await InternetRolloverPreferenceSheet.show(context);
    if (pref == null) return;
    setState(() {
      _autoRenewEnabled = true;
      _rolloverPref = pref;
    });
  }

  void _onPay() async {
    if (_isProcessing) return;

    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as InternetProviderEntity;
    final package = args['package'] as InternetPackageEntity;
    final accountNumber = args['accountNumber'] as String;

    setState(() => _isProcessing = true);

    final transactionId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'internet_bill',
      // PIN modal + message use rounded user-facing amount; raw
      // catalog price goes to the backend separately.
      amount: package.displayAmount,
      currency: 'NGN',
      title: 'Confirm Payment',
      message:
          'Confirm internet bill payment of \u20A6${package.displayAmount.toStringAsFixed(0)}',
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
      AppRoutes.internetPaymentProcessing,
      arguments: {
        'provider': provider,
        'package': package,
        'validation': args['validation'],
        'accountNumber': accountNumber,
        'transactionId': transactionId,
        'verificationToken': verificationToken!,
        'idempotencyKey': idempotencyKey,
        // Save + rollover flags — receipt screen consumes these on success.
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
    final provider = args['provider'] as InternetProviderEntity;
    final package = args['package'] as InternetPackageEntity;
    final validation =
        args['validation'] as InternetAccountValidationEntity;
    final accountNumber = args['accountNumber'] as String;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<InternetBeneficiaryCubit>()),
        BlocProvider(create: (_) => GetIt.I<InternetAutoRechargeCubit>()),
      ],
      child: Scaffold(
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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      // Single consolidated details card collapses the
                      // previous Provider / Account / Customer / Package
                      // / Validity / Account-status stack of separate
                      // cards into one. Same content, ~1/3 the vertical
                      // footprint, so the rollover toggle below is
                      // visible without scrolling on common phones.
                      _buildConsolidatedDetailsCard(
                          provider, accountNumber, validation, package),

                      SizedBox(height: 12.h),

                      // Compact amount card \u2014 was 32sp + 20w
                      // padding (~120px tall); now a single row with the
                      // amount inline (~60px) so it occupies half the
                      // height.
                      _buildCompactAmountCard(package.displayAmount),

                      SizedBox(height: 12.h),

                      // Save-as-beneficiary + Rollover toggles
                      if (!_probeLoading)
                        Column(
                          children: [
                            if (_existingBeneficiary == null)
                              _buildToggleTile(
                                icon: Icons.bookmark_outline,
                                title: 'Save as beneficiary',
                                subtitle: _saveBeneficiary &&
                                        _beneficiaryNickname != null
                                    ? 'Nickname: $_beneficiaryNickname'
                                    : 'Quick-buy next time',
                                value: _saveBeneficiary,
                                onChanged: _onToggleSaveBeneficiary,
                              )
                            else
                              _buildInfoTile(
                                icon: Icons.bookmark,
                                title: 'Already saved',
                                subtitle: (_existingBeneficiary!.nickname != null &&
                                        _existingBeneficiary!.nickname!.isNotEmpty)
                                    ? _existingBeneficiary!.nickname!
                                    : _existingBeneficiary!.accountNumber,
                              ),
                            SizedBox(height: 8.h),
                            if (_existingRollover == null)
                              _buildToggleTile(
                                icon: Icons.autorenew,
                                title: 'Enable rollover',
                                subtitle: _autoRenewEnabled
                                    ? 'Re-purchase on a schedule'
                                    : 'Keep this package alive automatically',
                                value: _autoRenewEnabled,
                                onChanged: _onToggleRollover,
                              )
                            else
                              _buildInfoTile(
                                icon: Icons.autorenew,
                                title: 'Rollover active',
                                subtitle:
                                    '${_existingRollover!.frequency} · ${_existingRollover!.planName}',
                              ),
                          ],
                        ),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              // Pay
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Pay \u20A6${_currencyFormat.format(package.displayAmount)}',
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
        ),
      ),
    );
  }

  /// One bordered card that lists Provider / Account / Customer /
  /// Package / Validity / Account-status as label-value rows. Replaces
  /// the previous 6 separate full-width cards.
  Widget _buildConsolidatedDetailsCard(
    InternetProviderEntity provider,
    String accountNumber,
    InternetAccountValidationEntity validation,
    InternetPackageEntity package,
  ) {
    Widget row(String label, String value, IconData icon) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF4E03D0), size: 16.sp),
            SizedBox(width: 10.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            const Spacer(),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
    Widget divider() => Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          height: 1,
          color: const Color(0xFF2D2D2D),
        );
    final showStatus = validation.status.isNotEmpty &&
        validation.status != 'no_verify_required';
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Column(
        children: [
          row('Provider', provider.name, Icons.wifi),
          divider(),
          row('Account', accountNumber, Icons.account_circle_outlined),
          divider(),
          row('Customer', validation.customerName, Icons.person),
          divider(),
          row('Package', package.name, Icons.wifi_tethering),
          if (package.validity.isNotEmpty) ...[
            divider(),
            row('Validity', package.validity, Icons.schedule),
          ],
          if (showStatus) ...[
            divider(),
            row('Status', validation.status, Icons.info_outline),
          ],
        ],
      ),
    );
  }

  /// Single-row amount card \u2014 label on the left, big purple amount
  /// on the right. Half the vertical footprint of the previous stacked
  /// label-above-amount block.
  Widget _buildCompactAmountCard(double amount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Text(
            'Amount',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            '\u20A6${_currencyFormat.format(amount)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF10B981),
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // _buildDetailCard was removed — its 6 separate per-field instances
  // have been folded into the single `_buildConsolidatedDetailsCard`
  // above. Keeping the dead helper would just leak compile warnings.

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4E03D0), size: 22.sp),
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
                SizedBox(height: 3.h),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF4E03D0),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF10B981), size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Nickname-entry dialog for the save-as-beneficiary flow. Kept as
/// a private StatefulWidget so the TextEditingController is owned by
/// the dialog's element subtree — disposing on the outer State right
/// after `showDialog` returned races with the dialog's close animation
/// (the TextField still reads the controller during fade-out) and
/// raised "dependents.isEmpty is not true" assertions.
class _NicknameDialog extends StatefulWidget {
  const _NicknameDialog();

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1F1F1F),
      title: Text(
        'Name this ISP account',
        style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        maxLength: 50,
        textCapitalization: TextCapitalization.words,
        style: GoogleFonts.inter(color: Colors.white),
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          hintText: 'e.g. Home Wi-Fi',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
          filled: true,
          fillColor: const Color(0xFF2D2D2D),
          counterStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0)),
          child: Text('Save',
              style: GoogleFonts.inter(
                  color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
