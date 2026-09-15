import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import 'donation_receipt_screen.dart';
part 'donation_processing_screen_widgets.dart';


/// Everything needed to re-dispatch the SAME donation.
///
/// `transactionId` is the client-minted id that binds the PIN
/// verification token to this donation — it is the user's single intent
/// key and a retry MUST reuse it verbatim. `transactionPin` is the
/// verification token itself, which auth-service consumes exactly once:
/// replaying it can therefore never double-debit. If the first attempt
/// died before the server consumed the token the retry goes through; if
/// the debit actually landed, the server rejects the replay instead of
/// charging twice. Both properties are why the retry re-sends this
/// record unchanged rather than minting anything new.
class DonationAttempt {
  final String crowdfundId;
  final double amount;
  final String? message;
  final bool isAnonymous;
  final String sourceAccountId;
  final String transactionPin;
  final String transactionId;

  const DonationAttempt({
    required this.crowdfundId,
    required this.amount,
    this.message,
    required this.isAnonymous,
    required this.sourceAccountId,
    required this.transactionPin,
    required this.transactionId,
  });
}

/// Where the screen currently is. Only [processing] blocks the back
/// gesture — the other two are terminal as far as this screen is
/// concerned, so the user always has a way out.
enum _DonationPhase { processing, failed, stalled }

class DonationProcessingScreen extends StatefulWidget {
  final Crowdfund crowdfund;

  /// Null only for entry points that dispatched the donation without
  /// handing over its parameters (the orphaned named route). Retry is
  /// hidden in that case rather than guessing at the request.
  final DonationAttempt? attempt;

  const DonationProcessingScreen({
    super.key,
    required this.crowdfund,
    this.attempt,
  });

  @override
  State<DonationProcessingScreen> createState() =>
      _DonationProcessingScreenState();
}

class _DonationProcessingScreenState extends State<DonationProcessingScreen>
    with SingleTickerProviderStateMixin {
  // Deliberately LONGER than the gRPC deadline the crowdfund data source
  // runs under (GrpcCallOptionsHelper._defaultAuthedCallDeadline = 90s).
  // Ordering matters: the RPC's own timeout has to win so the user gets
  // a real error with a retry. This watchdog only catches the case
  // nothing else can — a donation that produces no terminal state at
  // all, not even an error — so the user is never stranded on a spinner.
  static const Duration _watchdogTimeout = Duration(seconds: 120);

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  Timer? _watchdog;
  _DonationPhase _phase = _DonationPhase.processing;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startWatchdog();
  }

  @override
  void dispose() {
    _watchdog?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _startWatchdog() {
    _watchdog?.cancel();
    _watchdog = Timer(_watchdogTimeout, () {
      if (!mounted || _phase != _DonationPhase.processing) return;
      setState(() => _phase = _DonationPhase.stalled);
    });
  }

  void _onCompleted(BuildContext context, DonationCompleted state) {
    _watchdog?.cancel();
    if (!context.mounted) return;
    // Navigate as soon as the cubit reports completion — no artificial
    // wait. The receipt screen has its own entry animation so the
    // transition still feels paced.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DonationReceiptScreen(
          donation: state.donation,
          receipt: state.receipt,
          crowdfund: widget.crowdfund,
        ),
      ),
    );
  }

  void _onFailed(DonationFailed state) {
    _watchdog?.cancel();
    if (!mounted) return;
    setState(() {
      _phase = _DonationPhase.failed;
      _errorMessage = state.message;
    });
  }

  /// Re-dispatch the identical request. See [DonationAttempt] for why
  /// replaying the same transactionId + PIN token is the safe move and
  /// why nothing here is regenerated.
  void _retry() {
    final attempt = widget.attempt;
    if (attempt == null) return;
    setState(() {
      _phase = _DonationPhase.processing;
      _errorMessage = '';
    });
    _startWatchdog();
    context.read<CrowdfundCubit>().makeDonation(
          crowdfundId: attempt.crowdfundId,
          amount: attempt.amount,
          message: attempt.message,
          isAnonymous: attempt.isAnonymous,
          sourceAccountId: attempt.sourceAccountId,
          transactionPin: attempt.transactionPin,
          transactionId: attempt.transactionId,
        );
  }

  /// Leave for the donation history. Used from the stalled panel, where
  /// the debit may well have gone through — history is the honest place
  /// to confirm it. `offNamed` swaps this screen out rather than
  /// stacking on top of it; the routes beneath (campaign details) stay.
  void _openHistory() {
    _watchdog?.cancel();
    Get.offNamed(AppRoutes.crowdfundMyDonations);
  }

  void _close() {
    _watchdog?.cancel();
    if (!mounted) return;
    Navigator.pop(context);
  }

  /// Back gesture while the debit is genuinely in flight: refuse, and
  /// say why instead of silently swallowing the gesture.
  void _rejectPopWhileInFlight() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Still processing your donation. You can check My Donations once '
          "it's done.",
        ),
        backgroundColor: const Color(0xFF2D2D2D),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTerminal = _phase != _DonationPhase.processing;

    return PopScope(
      // Only block the back gesture while the money movement is
      // actually running. Once the operation is terminal — or the
      // watchdog gave up waiting — the user must be able to leave.
      canPop: isTerminal,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _rejectPopWhileInFlight();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocConsumer<CrowdfundCubit, CrowdfundState>(
          // H3: the cubit instance is shared with the campaign details
          // screen (which refreshes on app-resume), the report flow and
          // the list refresh. Without these guards a sibling load
          // emitting CrowdfundError/CrowdfundLoading drove the
          // navigation branch and popped this screen mid-donation.
          // Only the three donation-owned states are ours.
          listenWhen: (prev, curr) =>
              curr is DonationCompleted || curr is DonationFailed,
          listener: (context, state) {
            if (state is DonationCompleted) {
              _onCompleted(context, state);
            } else if (state is DonationFailed) {
              _onFailed(state);
            }
          },
          buildWhen: (prev, curr) =>
              curr is DonationProcessing ||
              curr is DonationCompleted ||
              curr is DonationFailed,
          builder: (context, state) {
            String currentStep = 'Processing donation...';
            int currentStepIndex = 0;
            int totalSteps = 3;

            if (state is DonationProcessing) {
              currentStep = state.step;
              currentStepIndex = state.currentStepIndex;
              totalSteps = state.totalSteps;
            } else if (state is DonationCompleted) {
              currentStep = 'Donation completed!';
              currentStepIndex = totalSteps;
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: _phase == _DonationPhase.processing
                    ? _buildProcessingBody(
                        state: state,
                        currentStep: currentStep,
                        currentStepIndex: currentStepIndex,
                        totalSteps: totalSteps,
                      )
                    : _buildOutcomeBody(),
              ),
            );
          },
        ),
      ),
    );
  }
}
