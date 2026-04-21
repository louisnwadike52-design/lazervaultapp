import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class EducationPaymentConfirmationScreen extends StatefulWidget {
  const EducationPaymentConfirmationScreen({super.key});

  @override
  State<EducationPaymentConfirmationScreen> createState() =>
      _EducationPaymentConfirmationScreenState();
}

class _EducationPaymentConfirmationScreenState
    extends State<EducationPaymentConfirmationScreen>
    with TransactionPinMixin {
  late EducationProviderEntity _provider;
  late int _quantity;
  late String _phone;
  late double _totalAmount;
  String? _billersCode;
  bool _isProcessing = false;

  // Save-as-candidate state. When toggled on we store the nickname
  // captured from the prompt dialog; the receipt screen's post-purchase
  // hook persists the beneficiary on completed payments.
  bool _saveCandidate = false;
  String? _candidateNickname;

  /// Seeded from AccountManager on mount, updated when the user picks a
  /// different wallet from the Change sheet. On confirm we write this
  /// back to AccountManager so the gRPC interceptor stamps the right
  /// `x-account-id` metadata on the purchase RPC.
  String? _selectedAccountId;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _selectedAccountId = GetIt.I<AccountManager>().activeAccountId;
    // The global AccountCardsSummaryCubit is already seeded at app
    // startup (post-login via AuthenticationCubit). If it happens to
    // be in Initial state on this screen, we just render a loading
    // placeholder rather than refiring fetch — that path requires a
    // userId we don't hold here.
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _provider = args['provider'] as EducationProviderEntity;
      _quantity = args['quantity'] as int;
      _phone = args['phone'] as String;
      _totalAmount = args['totalAmount'] as double;
      _billersCode = args['billersCode'] as String?;
    }
  }

  void _confirmPurchase() async {
    if (_isProcessing) return;

    // Activate the selected account so the gRPC auth interceptor
    // stamps `x-account-id` metadata on the purchase RPC.
    if (_selectedAccountId != null) {
      GetIt.I<AccountManager>().setActiveAccount(_selectedAccountId!);
    }

    setState(() {
      _isProcessing = true;
    });

    const uuid = Uuid();
    final transactionId = uuid.v4();
    final idempotencyKey = uuid.v4();

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'education_purchase',
      amount: _totalAmount,
      currency: 'NGN',
      title: 'Confirm Purchase',
      message: 'Confirm education purchase of \u20A6${_totalAmount.toStringAsFixed(0)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) {
      setState(() {
        _isProcessing = false;
      });
      return;
    }
    if (!mounted) return;

    // Navigate AFTER modal is dismissed. Forward the save-candidate
    // flag + nickname so the receipt screen can persist the
    // beneficiary on a completed payment.
    Get.offNamed(AppRoutes.educationPaymentProcessing, arguments: {
      'provider': _provider,
      'quantity': _quantity,
      'phone': _phone,
      'totalAmount': _totalAmount,
      'transactionId': transactionId,
      'verificationToken': verificationToken!,
      'idempotencyKey': idempotencyKey,
      if (_billersCode != null) 'billersCode': _billersCode,
      'saveCandidate': _saveCandidate,
      'candidateNickname': _candidateNickname,
    });
  }

  Future<void> _onToggleSaveCandidate(bool newValue) async {
    if (!newValue) {
      setState(() {
        _saveCandidate = false;
        _candidateNickname = null;
      });
      return;
    }
    final nickname = await showDialog<String>(
      context: context,
      builder: (ctx) => const _NicknameDialog(),
    );
    if (nickname == null || nickname.isEmpty) return;
    if (!mounted) return;
    setState(() {
      _saveCandidate = true;
      _candidateNickname = nickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Confirm Purchase',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Review header
                    _buildReviewHeader(),

                    SizedBox(height: 24.h),

                    // Pay From — reactive display of the currently
                    // selected wallet/account from AccountManager. The
                    // "Change" link routes to the main account-summary
                    // screen where the active account lives.
                    _buildPayFromCard(),

                    SizedBox(height: 16.h),

                    // Purchase details card
                    _buildDetailsCard(),

                    SizedBox(height: 16.h),

                    // Save-as-candidate toggle — persists the phone
                    // number as a beneficiary on completed payments.
                    _buildSaveCandidateTile(),

                    SizedBox(height: 16.h),

                    // Security note
                    _buildSecurityNote(),
                  ],
                ),
              ),
            ),

            // Confirm button
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color.fromARGB(255, 78, 3, 208)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            color: Colors.white,
            size: 40.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            'Review Your Purchase',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please confirm the details below before proceeding',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Provider', _provider.name),
          _buildDivider(),
          _buildDetailRow('Quantity', '$_quantity ${_quantity == 1 ? 'PIN' : 'PINs'}'),
          _buildDivider(),
          _buildDetailRow('Phone Number', _phone),
          if (_billersCode != null && _billersCode!.isNotEmpty) ...[
            _buildDivider(),
            _buildDetailRow('JAMB Profile Code', _billersCode!),
          ],
          _buildDivider(),
          _buildDetailRow('Unit Price', '\u20A6${_formatAmount(_provider.amount)}'),
          _buildDivider(),
          _buildDetailRow(
            'Total Amount',
            '\u20A6${_formatAmount(_totalAmount)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? const Color(0xFF4E03D0) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      height: 1,
      color: const Color(0xFF2D2D2D),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lock_outline,
            size: 16.sp,
            color: const Color(0xFF4E03D0),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Your payment is secured with end-to-end encryption',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF4E03D0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _confirmPurchase,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4E03D0),
            disabledBackgroundColor:
                const Color(0xFF4E03D0).withValues(alpha: 0.4),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
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
                  'Confirm Purchase',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }

  /// "Pay From" tile backed by the global AccountCardsSummaryCubit.
  /// Mirrors the airtime/data review pattern: auto-select on first
  /// load, "Change" opens a bottom-sheet picker of wallets with
  /// matching currency, tap a row → local state + AccountManager
  /// update so the subsequent purchase RPC's metadata lands on the
  /// right account.
  Widget _buildPayFromCard() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        List<AccountSummaryEntity> summaries = const [];
        bool loading = false;
        if (state is AccountCardsSummaryLoading) loading = true;
        if (state is AccountCardsSummaryLoaded) {
          summaries = state.accountSummaries;
          // Seed selection on first render when nothing's set yet.
          if (_selectedAccountId == null && summaries.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _selectedAccountId = summaries.first.id);
              }
            });
          }
        }
        if (state is AccountBalanceUpdated) {
          summaries = state.accountSummaries;
        }

        final selected = summaries.where(
          (a) => a.id == _selectedAccountId,
        ).firstOrNull ??
            (summaries.isNotEmpty ? summaries.first : null);

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
                if (summaries.length > 1)
                  GestureDetector(
                    onTap: () => _showAccountChangeSheet(summaries),
                    child: Text(
                      'Change',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4E03D0),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: selected != null
                      ? const Color(0xFF4E03D0).withValues(alpha: 0.5)
                      : const Color(0xFF2D2D2D),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet,
                      color: const Color(0xFF4E03D0), size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: loading && selected == null
                        ? Text(
                            'Loading accounts…',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                          )
                        : selected == null
                            ? Text(
                                'No account available',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 14.sp,
                                ),
                              )
                            : Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selected.accountType,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    '${selected.currency} ${_formatAmount(selected.balance)}'
                                    '${selected.accountNumberLast4.isNotEmpty ? '  ·  ••••${selected.accountNumberLast4}' : ''}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Bottom sheet of wallets. Currency-filtered only if there's more
  /// than one currency — otherwise we show them all. Tap a row →
  /// update selection + dismiss.
  void _showAccountChangeSheet(List<AccountSummaryEntity> all) {
    // Prefer NGN matches first — education purchases are NGN-only on
    // the backend — but fall back to all so the user can still see
    // wallets even if none match (rare case).
    final ngn = all
        .where((a) => a.currency.toUpperCase() == 'NGN')
        .toList();
    final list = ngn.isNotEmpty ? ngn : all;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Pay From',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                for (final account in list)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _buildAccountRow(sheetCtx, account),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountRow(BuildContext sheetCtx, AccountSummaryEntity account) {
    final selected = account.id == _selectedAccountId;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedAccountId = account.id);
        Navigator.of(sheetCtx).pop();
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
              : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected
                ? const Color(0xFF4E03D0)
                : const Color(0xFF2D2D2D),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.account_balance_wallet,
                color: const Color(0xFF4E03D0), size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.accountType,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${account.currency} ${_formatAmount(account.balance)}'
                    '${account.accountNumberLast4.isNotEmpty ? '  ·  ••••${account.accountNumberLast4}' : ''}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle,
                  color: const Color(0xFF4E03D0), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveCandidateTile() {
    final subtitle = _saveCandidate &&
            _candidateNickname != null &&
            _candidateNickname!.isNotEmpty
        ? 'Saved as "$_candidateNickname"'
        : 'Save this phone number for one-tap repeat purchases';
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.bookmark_add_outlined,
              color: const Color(0xFF4E03D0), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Save as candidate',
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
          Switch(
            value: _saveCandidate,
            onChanged: _onToggleSaveCandidate,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFF4E03D0),
          ),
        ],
      ),
    );
  }
}

/// Nickname prompt dialog — owns its controller so the Flutter engine
/// doesn't dispose it mid-dialog-animation. Returns the trimmed text on
/// Save, null on Cancel / dismiss.
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
          hintText: 'e.g. My Son\'s WAEC',
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
            borderSide: const BorderSide(color: Color(0xFF4E03D0)),
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
              color: const Color(0xFF4E03D0),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
