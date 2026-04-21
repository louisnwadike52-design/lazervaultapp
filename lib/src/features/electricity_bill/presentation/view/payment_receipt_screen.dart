import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../services/electricity_bill_pdf_service.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../widgets/electricity_rollover_preference_sheet.dart';
import '../../../account_cards_summary/services/balance_websocket_service.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../widgets/bill_receipt_qr_block.dart';

class PaymentReceiptScreen extends StatefulWidget {
  const PaymentReceiptScreen({super.key});

  @override
  State<PaymentReceiptScreen> createState() => _PaymentReceiptScreenState();
}

class _PaymentReceiptScreenState extends State<PaymentReceiptScreen>
    with SingleTickerProviderStateMixin {
  late BillPaymentEntity payment;
  late AnimationController _checkController;
  late Animation<double> _checkScale;
  bool _isDownloading = false;
  bool _isSharing = false;
  bool _fromHistory = false;

  // Live updates via BalanceWebSocket. No polling timers.
  StreamSubscription<BalanceUpdateEvent>? _balanceSub;

  // Guards post-purchase side-effects (auto-recharge creation) to once
  // per screen mount — widget rebuilds + completion-via-websocket must
  // not re-fire the RPC.
  bool _autoRechargePostPayRan = false;

  String get _currencySymbol {
    switch (payment.currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '${payment.currency} ';
    }
  }

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null || args['payment'] == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppRoutes.electricityBillHome);
      });
      payment = BillPaymentEntity.empty();
      _checkController = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
      _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
      );
      return;
    }
    payment = args['payment'] as BillPaymentEntity;
    _fromHistory = (args['fromHistory'] as bool?) ?? false;

    _checkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );

    _checkController.forward();

    // Subscribe to live balance/transaction updates. When an event arrives
    // whose reference or transactionId matches this payment, refetch the
    // row from the server so status + token fields re-render.
    try {
      final wsService = GetIt.I<BalanceWebSocketService>();
      _balanceSub = wsService.balanceUpdates.listen(_handleBalanceEvent);
    } catch (e) {
      // Service not registered / unavailable — continue without live updates.
      // Pull-to-refresh remains available.
      print('[PaymentReceipt] BalanceWebSocketService unavailable: $e');
    }

    // Fetch the freshest payment row on load so the screen always reflects
    // server-side state (status, token arrival, etc.).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ElectricityBillCubit>().getPaymentReceipt(
            paymentId: payment.id,
          );
    });

    // If the payment already arrived completed (sync path), fire the
    // post-pay keep-alive side-effects immediately. For async/pending
    // payments we defer until a websocket-triggered refetch lands it in
    // a terminal completed state.
    if (payment.isCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _runPostPurchaseActions();
      });
    }
  }

  /// Filter matching balance events to this payment and refetch.
  void _handleBalanceEvent(BalanceUpdateEvent event) {
    if (!mounted) return;
    final matchesRef =
        event.reference != null && event.reference == payment.referenceNumber;
    final matchesTx =
        event.transactionId != null && event.transactionId == payment.id;
    if (!matchesRef && !matchesTx) return;

    // Refetch the row — the cubit will emit ReceiptLoaded which we handle
    // in the BlocListener to update local state.
    context.read<ElectricityBillCubit>().getPaymentReceipt(
          paymentId: payment.id,
        );
  }

  /// Create the auto-recharge row now that the payment itself has
  /// settled. Runs exactly once per screen mount. Mirrors the internet
  /// receipt post-pay hook — we trust the confirm screen to have already
  /// triggered the "save beneficiary" path via BeneficiaryCubit, so this
  /// hook only needs to handle auto-recharge creation.
  ///
  /// Beneficiary-id resolution order:
  ///   1. `existingBeneficiaryId` arg (passed through from confirm).
  ///   2. Re-fetch the beneficiary list and match on meter + provider.
  /// If neither yields an id we abort with a soft notice — we never
  /// create a rollover pointing at a missing beneficiary.
  Future<void> _runPostPurchaseActions() async {
    if (_autoRechargePostPayRan) return;
    _autoRechargePostPayRan = true;

    final args = Get.arguments;
    if (args is! Map<String, dynamic>) return;

    final enabled = (args['autoRechargeEnabled'] as bool?) ?? false;
    final pref = args['autoRechargePref'] as ElectricityRolloverPreference?;
    if (!enabled || pref == null) return;
    if (!payment.isCompleted) return;
    if (payment.amount <= 0) return;

    final repo = GetIt.I<ElectricityBillRepository>();

    // --- Resolve beneficiary id ---
    String? beneficiaryId = args['existingBeneficiaryId'] as String?;
    if (beneficiaryId == null || beneficiaryId.isEmpty) {
      try {
        final bensRes = await repo.getBeneficiaries();
        beneficiaryId = bensRes.fold<String?>(
          (_) => null,
          (list) {
            for (final b in list) {
              if (b.meterNumber == payment.meterNumber &&
                  (b.providerCode == payment.providerCode ||
                      b.providerId == payment.providerId)) {
                return b.id;
              }
            }
            return null;
          },
        );
      } catch (_) {
        beneficiaryId = null;
      }
    }

    if (beneficiaryId == null || beneficiaryId.isEmpty) {
      _softInfo(
        'Auto-recharge couldn\'t be enabled',
        'We couldn\'t find a saved beneficiary for this meter. Turn on '
            '"Save as beneficiary" on your next purchase to enable auto-recharge.',
      );
      return;
    }

    // --- Create the auto-recharge row ---
    final freq = RechargeFrequencyExtension.fromString(pref.frequency);
    try {
      final result = await repo.createAutoRecharge(
        beneficiaryId: beneficiaryId,
        amount: payment.amount,
        currency: payment.currency.isNotEmpty ? payment.currency : 'NGN',
        frequency: freq,
        dayOfWeek: freq == RechargeFrequency.weekly ? pref.dayOfWeek : null,
        dayOfMonth: freq == RechargeFrequency.monthly ? pref.dayOfMonth : null,
        maxRetries: 3,
        executionHour: pref.executionHour,
        executionMinute: pref.executionMinute,
      );
      result.fold(
        (failure) => _softInfo(
          'Auto-recharge couldn\'t be enabled',
          'Payment succeeded, but the schedule didn\'t save: ${failure.message}',
        ),
        (_) => _softInfo(
          'Auto-recharge enabled',
          'We\'ll top up this meter on your chosen schedule.',
          isSuccess: true,
        ),
      );
    } catch (e) {
      _softInfo(
        'Auto-recharge couldn\'t be enabled',
        'Payment succeeded, but the schedule didn\'t save. You can retry from the auto-recharge screen.',
      );
    }
  }

  /// Non-blocking info snackbar. The payment has already settled by the
  /// time this fires, so we never want to block the user.
  void _softInfo(String title, String message, {bool isSuccess = false}) {
    if (!mounted) return;
    Get.snackbar(
      title,
      message,
      backgroundColor: (isSuccess
              ? const Color(0xFF10B981)
              : const Color(0xFFFB923C))
          .withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12,
    );
  }

  @override
  void dispose() {
    _checkController.dispose();
    _balanceSub?.cancel();
    _balanceSub = null;
    super.dispose();
  }

  /// Pull-to-refresh handler: refetch the payment and await the resulting
  /// state change.
  Future<void> _onRefresh() async {
    if (!mounted) return;
    final cubit = context.read<ElectricityBillCubit>();
    final completer = Completer<void>();
    late final StreamSubscription sub;
    sub = cubit.stream.listen((state) {
      if (state is ReceiptLoaded || state is ElectricityBillError) {
        if (!completer.isCompleted) completer.complete();
        sub.cancel();
      }
    });
    cubit.getPaymentReceipt(paymentId: payment.id);
    // Guard against states we never see (e.g. screen unmounts) with a
    // bounded wait — refresh indicator must eventually stop.
    await completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        sub.cancel();
      },
    );
  }

  void _handleBack() {
    if (_fromHistory) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.electricityBillHome);
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      final path = await ElectricityBillPdfService.downloadReceipt(
        payment: payment,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      await ElectricityBillPdfService.shareReceipt(payment: payment);
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _handleBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: _handleBack,
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          title: Text(
            'Payment Receipt',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocListener<ElectricityBillCubit, ElectricityBillState>(
            listenWhen: (prev, curr) => curr is ReceiptLoaded,
            listener: (context, state) {
              if (state is ReceiptLoaded) {
                final hadToken = payment.hasToken;
                setState(() {
                  payment = state.receipt;
                });
                if (!hadToken && payment.hasToken && payment.isPrepaid) {
                  Get.snackbar(
                    'Token Received!',
                    'Your electricity token is now available',
                    backgroundColor: const Color(0xFF10B981),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(16.w),
                    duration: const Duration(seconds: 4),
                  );
                }
                // Fire post-pay side-effects once the payment has landed
                // in a terminal completed state (guarded internally).
                if (payment.isCompleted) {
                  _runPostPurchaseActions();
                }
              }
            },
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFF4E03D0),
              backgroundColor: const Color(0xFF1F1F1F),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildSuccessIcon(),
                    SizedBox(height: 12.h),
                    Text(
                      _resolveHeroTitle(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getStatusMessage(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    if (payment.hasToken) _buildTokenCard(),
                    if (payment.hasToken) SizedBox(height: 14.h),
                    _buildTransactionDetails(),
                    SizedBox(height: 20.h),
                    BillReceiptQrBlock(
                      type: 'electricity',
                      reference: payment.referenceNumber,
                      amount: payment.amount,
                      currency: 'NGN',
                      status: payment.status.name,
                      timestamp: payment.createdAt,
                      showDivider: false,
                      extraPayload: {
                        if (payment.meterNumber.isNotEmpty)
                          'meter': payment.meterNumber,
                        if (payment.providerName.isNotEmpty)
                          'provider': payment.providerName,
                        if (payment.token != null &&
                            payment.token!.isNotEmpty)
                          'token': payment.token!,
                      },
                    ),
                    SizedBox(height: 20.h),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _resolveHeroTitle() {
    // Check refund-via-source BEFORE `isFailed` so rows where status is
    // still `failed` but the backend already returned the money show a
    // "Payment Refunded" hero instead of a red "Payment Failed".
    if (payment.isRefundedViaSource) return 'Payment Refunded';
    if (payment.isFailed) return 'Payment Failed';
    if (payment.isRefundPending) return 'Refund In Progress';
    if (payment.isRefunded) return 'Payment Refunded';
    if (payment.isReversed) return 'Payment Reversed';
    if (payment.isRefundFailed) return 'Refund Failed';
    if (payment.isCompleted && payment.hasToken) return 'Payment Successful!';
    if (payment.isCompleted) return 'Payment Successful!';
    // pending / processing / awaitingWebhook
    return 'Payment Submitted';
  }

  String _getStatusMessage() {
    // If the money came back despite a `failed` status, lead with the
    // reassuring refund copy rather than a "try again" prompt.
    if (payment.isRefundedViaSource) {
      return payment.refundSource == 'auto_released'
          ? 'Charge auto-released. Your balance has been restored.'
          : 'Your payment was refunded. Your balance has been restored.';
    }
    if (payment.isFailed) {
      return 'Payment failed. Please try again.';
    }
    if (payment.hasToken) {
      return payment.isPrepaid
          ? 'Your electricity token is below'
          : 'Your payment has been processed';
    }
    if (payment.isPending || payment.isProcessing) {
      return payment.isPrepaid
          ? 'Waiting for confirmation. Your token will be sent via SMS once the provider confirms.'
          : 'Waiting for confirmation from the provider.';
    }
    return 'Your payment has been processed';
  }

  Widget _buildSuccessIcon() {
    // Status-aware hero icon so failed / pending / refunded receipts
    // aren't misrepresented with a green checkmark.
    IconData icon;
    Color color;
    if (payment.isCompleted) {
      icon = Icons.check_circle;
      color = const Color(0xFF10B981);
    } else if (payment.isRefundedViaSource) {
      // Backend returned the money but left `status=failed`; treat as
      // a soft refund, not a hard failure.
      icon = Icons.undo;
      color = const Color(0xFF6B7280);
    } else if (payment.isFailed) {
      icon = Icons.cancel;
      color = const Color(0xFFEF4444);
    } else if (payment.isRefunded || payment.isReversed) {
      icon = Icons.undo;
      color = const Color(0xFF6B7280);
    } else if (payment.isRefundPending) {
      icon = Icons.history;
      color = const Color(0xFFFB923C);
    } else if (payment.isRefundFailed) {
      icon = Icons.error_outline;
      color = const Color(0xFFEF4444);
    } else {
      // pending / processing / awaiting_webhook -> in-flight spinner-style
      icon = Icons.hourglass_top;
      color = const Color(0xFFFB923C);
    }
    return AnimatedBuilder(
      animation: _checkScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _checkScale.value,
          child: Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 40.sp),
          ),
        );
      },
    );
  }

  Widget _buildTokenCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF92400E), Color(0xFFD97706)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD97706).withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bolt,
                color: const Color(0xFFFDE68A),
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                'ELECTRICITY TOKEN',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFDE68A),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () {
              if (payment.token != null) {
                Clipboard.setData(ClipboardData(text: payment.token!));
                HapticFeedback.mediumImpact();
                Get.snackbar(
                  'Copied',
                  'Token copied to clipboard',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(16.w),
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: const Color(0xFFFDE68A).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  SelectableText(
                    payment.token ?? '',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFEF3C7),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: const Color(0xFFFDE68A).withValues(alpha: 0.8),
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Tap to copy token',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFFDE68A).withValues(alpha: 0.8),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (payment.units != null) ...[
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.electric_bolt,
                    color: const Color(0xFFFDE68A),
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${payment.units!.toStringAsFixed(2)} kWh',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFEF3C7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTransactionDetails() {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final displayDate = payment.completedAt ?? payment.createdAt;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _buildDetailRow('Amount', '$_currencySymbol${payment.amount.toStringAsFixed(2)}'),
          SizedBox(height: 10.h),
          _buildDetailRow('Service Fee', '$_currencySymbol${payment.serviceFee.toStringAsFixed(2)}'),
          SizedBox(height: 10.h),
          _buildDetailRow(
            'Total',
            '$_currencySymbol${payment.totalAmount.toStringAsFixed(2)}',
            valueColor: Colors.white,
            isBold: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(color: const Color(0xFF2D2D2D), height: 1),
          ),
          _buildDetailRow('Provider', payment.providerName),
          SizedBox(height: 10.h),
          _buildDetailRow('Customer', payment.customerName),
          SizedBox(height: 10.h),
          _buildDetailRow('Meter Number', payment.meterNumber),
          SizedBox(height: 10.h),
          _buildDetailRow('Meter Type', payment.meterType.displayName),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Divider(color: const Color(0xFF2D2D2D), height: 1),
          ),
          _buildDetailRow('Reference', payment.referenceNumber),
          SizedBox(height: 10.h),
          _buildDetailRow('Gateway', payment.paymentGateway.toUpperCase()),
          SizedBox(height: 10.h),
          _buildDetailRow('Date', dateFormat.format(displayDate)),
          SizedBox(height: 10.h),
          _buildDetailRow('Time', timeFormat.format(displayDate)),
          SizedBox(height: 10.h),
          _buildDetailRow(
            'Status',
            payment.status.displayName,
            valueColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _isSharing ? null : _shareReceipt,
            icon: _isSharing
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(Icons.share, size: 16.sp),
            label: Text(
              _isSharing ? 'Sharing...' : 'Share',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF4E03D0)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _isDownloading ? null : _downloadReceipt,
            icon: _isDownloading
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(Icons.download, size: 16.sp),
            label: Text(
              _isDownloading ? 'Saving...' : 'Download',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFF4E03D0)),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
