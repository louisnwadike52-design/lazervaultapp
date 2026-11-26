import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../data/services/crowdfund_pdf_service.dart';
import '../../data/services/crowdfund_report_service.dart';
import '../../domain/entities/crowdfund_entities.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';
import 'package:lazervault/core/navigation/back_or_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/payment_receipt_shared.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import 'donation_processing_screen.dart';

/// THE CONTRIBUTION RECEIPT — AND THE ONLY SCREEN THE PAYMENT NEEDS.
///
/// It used to open only once a donation had COMPLETED, behind a dedicated
/// full-screen processing route that owned the wait, its own watchdog and its
/// own retry panel. Reported simply as "why's the processing stage in
/// crowdfund that slow": the RPC is not faster either way, but the customer
/// was made to watch it instead of being handed the artefact of their own
/// payment.
///
/// So the receipt now opens IMMEDIATELY after the PIN, carrying a local
/// pending row, and settles in place when the cubit reports the outcome —
/// the send-funds shape. See [pendingDonationFor] and
/// [FeatureFlags.crowdfundAsyncContribution].
class DonationReceiptScreen extends StatefulWidget {
  final CrowdfundDonation donation;
  final CrowdfundReceipt? receipt;
  final Crowdfund crowdfund;

  /// Set when this receipt opened BEFORE the money moved, so the retry can
  /// replay the identical request — same transaction id, same single-use PIN
  /// token. Null when the receipt was opened from history.
  final DonationAttempt? attempt;

  const DonationReceiptScreen({
    super.key,
    required this.donation,
    this.receipt,
    required this.crowdfund,
    this.attempt,
  });

  @override
  State<DonationReceiptScreen> createState() => _DonationReceiptScreenState();
}

class _DonationReceiptScreenState extends State<DonationReceiptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late CrowdfundPdfService _pdfService;
  bool _isProcessingPdf = false;

  /// What is on screen RIGHT NOW. Starts as whatever the caller handed us —
  /// a local pending row on the live path, a settled row from history — and
  /// is replaced wholesale when the server answers.
  late CrowdfundDonation _donation;
  CrowdfundReceipt? _receipt;
  String? _failureMessage;

  /// The money is in flight: nothing has been confirmed and nothing has
  /// failed. The one state in which this screen must not be shared or filed.
  bool get _pending =>
      _failureMessage == null &&
      (_donation.status == DonationStatus.processing ||
          _donation.status == DonationStatus.pending);
  bool get _failed =>
      _failureMessage != null || _donation.status == DonationStatus.failed;
  bool get _completed => !_pending && !_failed;

  @override
  void initState() {
    _pdfService = GetIt.I<CrowdfundPdfService>();
    // SEED FROM THE WIDGET, NOT FROM THEMSELVES.
    //
    // These read `_donation = _donation; _receipt = _receipt;` — a
    // self-assignment, so `_donation` (a `late` field with no initialiser)
    // was READ before it was ever written and initState threw
    // LateInitializationError on every single donation. The receipt is
    // pushed immediately after the PIN and AFTER `cubit.makeDonation` has
    // already been dispatched, so the donor's money was on its way and the
    // only thing they saw was the global error widget on a black screen.
    _donation = widget.donation;
    _receipt = widget.receipt;
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ── What the outcome looks like ───────────────────────────────────────
  //
  // One vocabulary for the four things this screen can be saying, so the
  // circle, the heading, the blurb and the share gate cannot disagree.

  Color get _statusColor => _completed
      ? const Color(0xFF10B981)
      : _failed
          ? const Color(0xFFEF4444)
          : const Color(0xFFF59E0B);

  IconData get _statusIcon => _completed
      ? Icons.check
      : _failed
          ? Icons.close_rounded
          : Icons.hourglass_bottom;

  String get _statusTitle => _completed
      ? 'Donation successful'
      : _failed
          ? 'Donation not completed'
          : 'Sending your donation';

  String get _statusBlurb {
    if (_completed) return 'Thank you for your generous support';
    if (_failed) {
      // NEVER A RAW PROVIDER STRING. The customer gets a calm line and the
      // detail stays in the admin audit, which is the rule the rest of the
      // money flows follow.
      return _failureMessage?.trim().isNotEmpty == true
          ? _failureMessage!
          : 'Nothing was taken from your wallet. You can try again.';
    }
    return 'This usually takes a few seconds. You can stay here — '
        'the receipt updates itself.';
  }

  /// SETTLE IN PLACE, RATHER THAN NAVIGATE.
  ///
  /// The processing screen used to own this and then push a NEW receipt. One
  /// screen means no route swap at the moment of completion, no second entry
  /// animation, and nothing for a user who tapped Back mid-flight to miss.
  void _onCubitState(BuildContext context, CrowdfundState state) {
    if (state is DonationCompleted) {
      setState(() {
        _donation = state.donation;
        _receipt = state.receipt ?? _receipt;
        _failureMessage = null;
      });
      // Re-run the entry animation on the real outcome, not on the pending
      // placeholder the screen opened with.
      _animationController
        ..reset()
        ..forward();
      return;
    }
    if (state is DonationFailed) {
      setState(() => _failureMessage = state.message);
    }
  }

  /// Replay the IDENTICAL request. The transaction id and the single-use PIN
  /// token are reused verbatim: if the first attempt died before the server
  /// consumed the token the retry goes through, and if the debit actually
  /// landed the server refuses the replay rather than charging twice. See
  /// [DonationAttempt].
  void _retry() {
    final a = widget.attempt;
    if (a == null) return;
    setState(() {
      _failureMessage = null;
      _donation = pendingDonationFor(a, widget.crowdfund);
    });
    context.read<CrowdfundCubit>().makeDonation(
          crowdfundId: a.crowdfundId,
          amount: a.amount,
          message: a.message,
          isAnonymous: a.isAnonymous,
          sourceAccountId: a.sourceAccountId,
          transactionPin: a.transactionPin,
          transactionId: a.transactionId,
        );
  }

  Future<void> _downloadPDF() async {
    if (_receipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt not available for download'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_isProcessingPdf) return;

    setState(() => _isProcessingPdf = true);

    try {
      final filePath = await _pdfService.downloadReceipt(
        _receipt!,
        _donation,
        widget.crowdfund,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receipt saved to: ${filePath.split('/').last}'),
          backgroundColor: const Color(0xFF10B981),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to download: ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessingPdf = false);
      }
    }
  }

  /// SHARE IT THE WAY EVERY OTHER MONEY RECEIPT IS SHARED.
  ///
  /// The same Revolut-style generator the send-funds, deposit and withdrawal
  /// receipts use, fed with the CONTRIBUTION's own facts — the campaign is
  /// the recipient, the wallet is the source, and the details that only a
  /// crowdfund has (the campaign code, the creator, the donor's message, an
  /// anonymous flag) ride in `extraRows` rather than being dropped.
  ///
  /// The crowdfund-specific PDF remains behind Download, for the long-form
  /// document with the QR.
  Future<void> _shareStyledReceipt() async {
    if (_isProcessingPdf) return;
    setState(() => _isProcessingPdf = true);
    final text = 'Lazervault contribution receipt · '
        '${_donation.currency} ${_donation.amount.toStringAsFixed(2)} to '
        '"${widget.crowdfund.title}"';
    try {
      final fmt = await pickReceiptFormat(context);
      if (fmt == null || !mounted) return;
      await shareBankingReceiptAs(
        format: fmt,
        shareText: text,
        details: {
          'amount': _donation.amount,
          'fee': 0.0,
          'currency': _donation.currency,
          'sourceAccountName': 'Lazervault wallet',
          'recipientName': widget.crowdfund.title,
          'recipientBankName': 'Lazervault crowdfund',
          'reference': _receipt?.receiptNumber ?? _donation.id,
          'transactionId': _donation.transactionId ?? _donation.id,
          'status': _donation.status.name,
          'transferType': 'Crowdfund contribution',
          'narration': _donation.message ?? '',
          'timestamp': _donation.donationDate,
          // A LIST OF MapEntry, NOT A MAP. The generator type-checks
          // `rawExtra is List<MapEntry<String, String>>` and silently drops
          // anything else — a map here would have been accepted by the call
          // and ignored by the document, which is the worst shape a bug can
          // take: a receipt missing exactly the rows that make it a
          // crowdfund receipt, with no error anywhere.
          'extraRows': <MapEntry<String, String>>[
            MapEntry('Campaign', widget.crowdfund.title),
            MapEntry('Campaign code', widget.crowdfund.crowdfundCode),
            MapEntry(
                'Creator',
                '${widget.crowdfund.creator.firstName} '
                    '${widget.crowdfund.creator.lastName}'),
            if (_donation.isAnonymous) const MapEntry('Shown as', 'Anonymous'),
          ],
        },
      );
    } catch (_) {
      // The crowdfund PDF is the fallback, not an error message: the customer
      // asked to share a receipt and there is still one to give them.
      await _sharePDF();
    } finally {
      if (mounted) setState(() => _isProcessingPdf = false);
    }
  }

  Future<void> _sharePDF() async {
    if (_receipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt not available for sharing'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_isProcessingPdf) return;

    setState(() => _isProcessingPdf = true);

    try {
      await _pdfService.shareReceipt(
        _receipt!,
        _donation,
        widget.crowdfund,
        sharePositionOrigin:
            CrowdfundReportService.shareOriginFromContext(context),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to share: ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessingPdf = false);
      }
    }
  }

  /// Goes back to the crowdfund landing — same exit pattern the
  /// send-funds receipt uses (`Get.offAllNamed(AppRoutes.dashboard)`),
  /// but for the crowdfund flow we land back on the crowdfund home.
  void _exitReceipt() {
    offAllKeepingHome(AppRoutes.crowdfund);
  }

  /// Stable QR payload encoding the donation reference. Donor scans
  /// it to surface the receipt later, or campaign owner uses it for
  /// reconciliation.
  String get _qrData {
    final txn = _donation.transactionId ?? _donation.id;
    return 'lazervault://crowdfund/donation/$txn';
  }

  @override
  Widget build(BuildContext context) {
    // The cubit outlives the route swap from the payment screen, so the
    // outcome lands here whether it arrives in 200ms or 90 seconds.
    return BlocListener<CrowdfundCubit, CrowdfundState>(
      listener: _onCubitState,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          // LEAVING WHILE IT IS STILL MOVING IS ALLOWED, AND SAID OUT LOUD.
          //
          // The debit is idempotent on the transaction id, so walking away
          // cannot duplicate or cancel it — the receipt is readable again from
          // My Donations. Refusing the gesture, as the old processing screen
          // did, only trapped people.
          if (_pending) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Your donation is still going through. You can find it in '
                  'My Donations.',
                ),
                backgroundColor: const Color(0xFF2D2D2D),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          _exitReceipt();
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        // THE OUTCOME, NOT AN ASSUMPTION OF ONE.
                        //
                        // This was an unconditional green tick over the words
                        // "Donation Successful" — correct only because the
                        // screen used to be unreachable before completion. It
                        // now opens while the money is still moving, so a
                        // hardcoded success would tell a customer their
                        // contribution had landed at the exact moment it had
                        // not.
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 56.w,
                            height: 56.w,
                            decoration: BoxDecoration(
                              color: _statusColor,
                              shape: BoxShape.circle,
                            ),
                            child: _pending
                                ? Padding(
                                    padding: EdgeInsets.all(14.w),
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.4,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : Icon(
                                    _statusIcon,
                                    color: Colors.white,
                                    size: 30.sp,
                                  ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          '${_donation.currency} ${_donation.amount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          _statusTitle,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          _statusBlurb,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF8E8E93),
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 18.h),
                        // Receipt card
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1F1F),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(0xFF2D2D2D),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // NO WORDMARK HERE. The brand sits once, at the
                              // top-right of the screen, exactly as it does on
                              // the send-funds receipt — printing it a second
                              // time directly under the amount made the card
                              // read as a separate document inside the page.
                              Center(
                                child: Text(
                                  'DONATION RECEIPT',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12.sp,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              if (_receipt != null) ...[
                                _buildReceiptRow(
                                  'Receipt Number',
                                  _receipt!.receiptNumber,
                                  isHighlighted: true,
                                ),
                                SizedBox(height: 16.h),
                              ],
                              _buildReceiptRow(
                                'Donation ID',
                                _donation.id,
                              ),
                              SizedBox(height: 16.h),
                              Divider(color: const Color(0xFF2D2D2D)),
                              SizedBox(height: 16.h),
                              _buildReceiptRow(
                                'Campaign',
                                widget.crowdfund.title,
                              ),
                              SizedBox(height: 16.h),
                              _buildReceiptRow(
                                'Creator',
                                '${widget.crowdfund.creator.firstName} ${widget.crowdfund.creator.lastName}',
                                trailing: widget.crowdfund.creator.verified
                                    ? Icon(
                                        Icons.verified,
                                        color: const Color(0xFF10B981),
                                        size: 16.sp,
                                      )
                                    : null,
                              ),
                              SizedBox(height: 16.h),
                              Divider(color: const Color(0xFF2D2D2D)),
                              SizedBox(height: 16.h),
                              _buildReceiptRow(
                                'Amount',
                                '${_donation.currency} ${_donation.amount.toStringAsFixed(2)}',
                                isAmount: true,
                              ),
                              SizedBox(height: 16.h),
                              _buildReceiptRow(
                                'Date & Time',
                                DateFormat('MMM dd, yyyy • hh:mm a')
                                    .format(_donation.donationDate),
                              ),
                              SizedBox(height: 16.h),
                              if (_donation.transactionId != null) ...[
                                _buildReceiptRow(
                                  'Transaction ID',
                                  _donation.transactionId!,
                                ),
                                SizedBox(height: 16.h),
                              ],
                              _buildReceiptRow(
                                'Payment Method',
                                _donation.paymentMethod,
                              ),
                              SizedBox(height: 16.h),
                              _buildReceiptRow(
                                'Status',
                                _getStatusText(_donation.status),
                                trailing: _buildStatusBadge(_donation.status),
                              ),
                              if (_donation.message != null &&
                                  _donation.message!.isNotEmpty) ...[
                                SizedBox(height: 16.h),
                                Divider(color: const Color(0xFF2D2D2D)),
                                SizedBox(height: 16.h),
                                Text(
                                  'Your Message',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0A0A0A),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    _donation.message!,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 13.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                              SizedBox(height: 16.h),
                              Divider(color: const Color(0xFF2D2D2D)),
                              SizedBox(height: 16.h),
                              // QR code + reference at the bottom of the
                              // receipt card. Same shape as the send-funds
                              // receipt — scan to surface this donation later.
                              Center(
                                child: QrImageView(
                                  data: _qrData,
                                  version: QrVersions.auto,
                                  size: 90.w,
                                  backgroundColor: Colors.transparent,
                                  dataModuleStyle: const QrDataModuleStyle(
                                    color: Colors.white,
                                  ),
                                  eyeStyle:
                                      const QrEyeStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Center(
                                child: Text(
                                  _donation.transactionId ?? _donation.id,
                                  style: GoogleFonts.robotoMono(
                                    fontSize: 10.sp,
                                    color: const Color(0xFF8E8E93),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
                _buildBottomActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top bar — back chevron on the left, LazerVault logo on the
  /// right. Mirrors the send-funds receipt's `_buildBackButton`.
  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _exitReceipt,
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          // The shared mark — logo + wordmark — so this receipt carries the
          // same identity, in the same place, as send-funds, deposit,
          // withdrawal and TagPay.
          const ReceiptBrandMark(),
        ],
      ),
    );
  }

  /// Bottom actions — icon-only Download + Share side-by-side, then
  /// a full-width Done. Buttons live OUTSIDE the scroll so they stay
  /// pinned and visible against the dark background.
  Widget _buildBottomActions() {
    // NOTHING TO FILE UNTIL THERE IS SOMETHING TO FILE.
    //
    // Download and Share are hidden while the money is still moving: a PDF
    // minted then would carry a pending row and read, to whoever it is sent
    // to, as proof of a contribution that may not have happened. They return
    // the instant the outcome lands.
    final canFile = _completed;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 12.h),
      child: Column(
        children: [
          if (canFile) ...[
            Row(
              children: [
                Expanded(
                  child: _iconAction(
                    icon: Icons.download_outlined,
                    label: 'Download',
                    isLoading: _isProcessingPdf,
                    onTap: _isProcessingPdf ? () {} : _downloadPDF,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _iconAction(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    isLoading: _isProcessingPdf,
                    onTap: _isProcessingPdf ? () {} : _shareStyledReceipt,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
          // RETRY, WHERE THE FAILURE IS. The processing screen owned this and
          // the processing screen is gone; a failed contribution with no way
          // to try again from the screen that reports it sends the customer
          // back through the whole amount flow.
          if (_failed && widget.attempt != null) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _retry,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF4E03D0)),
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Try again',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _exitReceipt,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                LazerVaultLoader.tiny()
              else
                Icon(icon, color: Colors.white, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isAmount = false,
    Widget? trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 13.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: isAmount
                        ? PayFlowTheme.accentOnDark
                        : isHighlighted
                            ? PayFlowTheme.accentOnDark
                            : Colors.white,
                    fontSize: isAmount ? 18.sp : 13.sp,
                    fontWeight: isAmount || isHighlighted
                        ? FontWeight.bold
                        : FontWeight.w600,
                    fontFamily: isHighlighted ? 'monospace' : null,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 6.w),
                trailing,
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(DonationStatus status) {
    Color color;
    switch (status) {
      case DonationStatus.completed:
        color = const Color(0xFF10B981);
        break;
      case DonationStatus.processing:
        color = const Color(0xFFF59E0B);
        break;
      case DonationStatus.pending:
        color = const Color(0xFF6B7280);
        break;
      case DonationStatus.failed:
        color = const Color(0xFFEF4444);
        break;
      case DonationStatus.refunded:
        color = const Color.fromARGB(255, 78, 3, 208);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _getStatusText(status),
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getStatusText(DonationStatus status) {
    switch (status) {
      case DonationStatus.pending:
        return 'Pending';
      case DonationStatus.processing:
        return 'Processing';
      case DonationStatus.completed:
        return 'Completed';
      case DonationStatus.failed:
        return 'Failed';
      case DonationStatus.refunded:
        return 'Refunded';
    }
  }
}
