part of 'donation_processing_screen.dart';

// Presentation for the donation processing screen. Split out per the
// file-size rule; same palette as the donation payment form so the two
// read as one flow.

const _accent = Color(0xFF4E03D0);
const _danger = Color(0xFFEF4444);
const _surface = Color(0xFF1F1F1F);
const _border = Color(0xFF2D2D2D);
const _warning = Color(0xFFF59E0B);

extension _DonationProcessingWidgets on _DonationProcessingScreenState {
  // ────────────────────────────────────────────────────────────
  // In-flight
  // ────────────────────────────────────────────────────────────

  Widget _buildProcessingBody({
    required CrowdfundState state,
    required String currentStep,
    required int currentStepIndex,
    required int totalSteps,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        ScaleTransition(
          scale: _scaleAnimation,
          child: _haloIcon(
            icon: state is DonationCompleted
                ? Icons.check_circle
                : Icons.volunteer_activism,
            color: _accent,
          ),
        ),
        SizedBox(height: 28.h),
        Text(
          currentStep,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'Please wait while we process your donation',
          style: TextStyle(color: Colors.grey[500], fontSize: 13.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 28.h),
        _buildProgressSteps(currentStepIndex, totalSteps),
        SizedBox(height: 28.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: currentStepIndex / totalSteps,
            backgroundColor: _border,
            valueColor: const AlwaysStoppedAnimation<Color>(_accent),
            minHeight: 8.h,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Step $currentStepIndex of $totalSteps',
          style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
        ),
        const Spacer(),
        _campaignFooter(),
      ],
    );
  }

  Widget _buildProgressSteps(int currentStep, int totalSteps) {
    // Three real steps, mirroring the cubit's emit boundaries: PIN
    // verify → money-movement RPC → receipt. No artificial fourth
    // step — the cubit no longer pads with Future.delayed.
    const steps = ['Verify', 'Process', 'Receipt'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep - 1;
        final isLit = isCompleted || isCurrent;

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isLit ? _accent : _border,
                    border: Border.all(
                      color: isLit ? _accent : _border,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, color: Colors.white, size: 20.sp)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isCurrent ? Colors.white : Colors.grey[600],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  steps[index],
                  style: TextStyle(
                    color: isLit ? Colors.white : Colors.grey[600],
                    fontSize: 11.sp,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (index < steps.length - 1)
              Container(
                width: 40.w,
                height: 2.h,
                margin: EdgeInsets.only(bottom: 24.h),
                color: isCompleted ? _accent : _border,
              ),
          ],
        );
      }),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Terminal — failed / stalled
  // ────────────────────────────────────────────────────────────

  Widget _buildOutcomeBody() {
    final failed = _phase == _DonationPhase.failed;

    return Column(
      children: [
        const Spacer(),
        _haloIcon(
          icon: failed ? Icons.error_outline : Icons.hourglass_bottom,
          color: failed ? _danger : _warning,
        ),
        SizedBox(height: 24.h),
        Text(
          failed ? 'Donation failed' : 'Still processing',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          failed
              ? _errorMessage
              : "This is taking longer than usual. Your donation may still go "
                  "through — check My Donations before trying again so you "
                  "don't give twice.",
          style: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 28.h),
        _campaignFooter(),
        const Spacer(),
        _buildOutcomeActions(failed: failed),
      ],
    );
  }

  Widget _buildOutcomeActions({required bool failed}) {
    // Retry is offered only on a real failure AND only when we still
    // hold the original request — see [DonationAttempt]. On a stalled
    // donation the outcome is unknown, so history is the primary action.
    final canRetry = failed && widget.attempt != null;

    return Column(
      children: [
        if (canRetry)
          _actionButton(
            label: 'Retry donation',
            onTap: _retry,
            background: _accent,
            foreground: Colors.white,
          ),
        if (!failed)
          _actionButton(
            label: 'Check My Donations',
            onTap: _openHistory,
            background: _accent,
            foreground: Colors.white,
          ),
        if (canRetry || !failed) SizedBox(height: 12.h),
        _actionButton(
          label: 'Close',
          onTap: _close,
          background: _surface,
          foreground: Colors.white,
        ),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // Shared pieces
  // ────────────────────────────────────────────────────────────

  Widget _haloIcon({required IconData icon, required Color color}) {
    return Container(
      width: 96.w,
      height: 96.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 48.sp),
    );
  }

  Widget _campaignFooter() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: _accent, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Supporting: ${widget.crowdfund.title}',
              style: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required VoidCallback onTap,
    required Color background,
    required Color foreground,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
