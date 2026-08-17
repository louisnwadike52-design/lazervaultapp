part of 'past_contribution_details_sheet.dart';

/// Bottom-sheet variant of the past-contribution detail screen.
/// Mirrors the cycles-history `CycleDetailsBottomSheet` pattern so
/// the two history surfaces feel like the same feature: tap a row →
/// modal slides up with the full breakdown. Loads the aggregated
/// detail bundle once on open and re-uses every sub-widget that the
/// active-membership detail screen already exposes.
class PastContributionDetailsSheet extends StatefulWidget {
  final String contributionId;
  final PastContributionEntry? seedEntry;

  const PastContributionDetailsSheet({
    super.key,
    required this.contributionId,
    this.seedEntry,
  });

  /// Convenience launcher — keeps the call-site identical to
  /// `CycleDetailsBottomSheet.show` so the two history surfaces stay
  /// visually + behaviourally consistent.
  static Future<void> show(
    BuildContext context, {
    required String contributionId,
    PastContributionEntry? seedEntry,
  }) {
    final cubit = context.read<GroupAccountCubit>();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      builder: (_) => BlocProvider<GroupAccountCubit>.value(
        value: cubit,
        child: FractionallySizedBox(
          heightFactor: 0.92,
          child: PastContributionDetailsSheet(
            contributionId: contributionId,
            seedEntry: seedEntry,
          ),
        ),
      ),
    );
  }

  @override
  State<PastContributionDetailsSheet> createState() =>
      _PastContributionDetailsSheetState();
}

class _PastContributionDetailsSheetState
    extends State<PastContributionDetailsSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final auth = context.read<AuthenticationCubit>().state;
    final token = auth is AuthenticationSuccess
        ? auth.profile.session.accessToken
        : null;
    context.read<GroupAccountCubit>().loadPastContributionDetails(
          widget.contributionId,
          accessToken: token,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle.
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.seedEntry?.contribution.title ??
                          'Past contribution',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFF2D2D2D), height: 1),
            Expanded(
              child:
                  BlocBuilder<GroupAccountCubit, GroupAccountState>(
                buildWhen: (a, b) =>
                    b is PastContributionDetailsLoading ||
                    b is PastContributionDetailsLoaded ||
                    b is PastContributionDetailsError,
                builder: (context, state) {
                  if (state is PastContributionDetailsLoading) {
                    return const Center(
                        child: LazerVaultLoader.small());
                  }
                  if (state is PastContributionDetailsError) {
                    return _ErrorView(
                      message: state.message,
                      onRetry: _load,
                    );
                  }
                  if (state is PastContributionDetailsLoaded) {
                    final details =
                        state.details as PastContributionDetails;
                    return RefreshIndicator(
                      backgroundColor: const Color(0xFF1F1F1F),
                      color: const Color.fromARGB(255, 78, 3, 208),
                      onRefresh: () async => _load(),
                      child:
                          _PastDetailsBody(details: details),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClosedCycleRow extends StatelessWidget {
  final Map<String, dynamic> raw;
  final String currency;
  const _ClosedCycleRow({required this.raw, required this.currency});

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0.##');
    final cycleIndex = (raw['cycleIndex'] as num?)?.toInt() ?? 0;
    final raisedAmount =
        double.tryParse('${raw['raisedAmount'] ?? 0}') ?? 0;
    final targetAmount =
        double.tryParse('${raw['targetAmount'] ?? 0}') ?? 0;
    final receiverName = (raw['receiverName'] as String?) ?? '';
    final closedAtStr = raw['endedAt'] as String?;
    final closedAt = closedAtStr != null
        ? DateTime.tryParse(closedAtStr)
        : null;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF2D2D2D),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$cycleIndex',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cycle $cycleIndex',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (receiverName.isNotEmpty)
                  Text(
                    'Recipient: $receiverName',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 11.sp,
                    ),
                  ),
                if (closedAt != null)
                  Text(
                    'Closed ${DateFormat('MMM d, yyyy').format(closedAt)}',
                    style: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 10.sp,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$currency ${fmt.format(raisedAmount)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (targetAmount > 0)
                Text(
                  'of $currency ${fmt.format(targetAmount)}',
                  style: GoogleFonts.inter(
                    color: Colors.grey[500],
                    fontSize: 10.sp,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveCycleAtExitBanner extends StatelessWidget {
  final Map<String, dynamic> cycle;
  const _ActiveCycleAtExitBanner({required this.cycle});

  @override
  Widget build(BuildContext context) {
    final cycleIndex = (cycle['cycleIndex'] as num?)?.toInt() ?? 0;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.history,
              color: const Color(0xFFFB923C), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              cycleIndex > 0
                  ? 'Cycle $cycleIndex was active when your membership ended.'
                  : 'A cycle was running when your membership ended.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 56.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
            ),
            SizedBox(height: 12.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
