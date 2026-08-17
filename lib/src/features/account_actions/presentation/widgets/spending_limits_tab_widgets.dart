part of 'spending_limits_tab.dart';

/// Real "Today's usage" bar. Fetches actual daily spend vs the configured daily
/// limit from accounts-service once on init. Renders nothing when no daily limit
/// is set (a usage bar against "no limit" is meaningless).
class _LimitUsageSection extends StatefulWidget {
  final String accountId;
  final String currencySymbol;

  const _LimitUsageSection({
    required this.accountId,
    required this.currencySymbol,
  });

  @override
  State<_LimitUsageSection> createState() => _LimitUsageSectionState();
}

class _LimitUsageSectionState extends State<_LimitUsageSection> {
  SpendingUsageEntity? _usage;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final usage = await context
        .read<AccountActionsCubit>()
        .fetchSpendingUsage(accountId: widget.accountId);
    if (!mounted) return;
    setState(() {
      _usage = usage;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox.shrink();
    }
    final usage = _usage;
    // No daily limit configured → no usage bar.
    if (usage == null || usage.dailyLimit <= 0) {
      return const SizedBox.shrink();
    }

    final pct =
        (usage.dailySpent / usage.dailyLimit).clamp(0.0, 1.0).toDouble();
    final sym = widget.currencySymbol;
    final over = usage.dailySpent >= usage.dailyLimit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s usage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (usage.remainingDaily >= 0)
              Text(
                '$sym${usage.remainingDaily.toStringAsFixed(2)} left',
                style: TextStyle(
                  color: over
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF10B981),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: pct,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: over
                      ? [const Color(0xFFEF4444), const Color(0xFFB91C1C)]
                      : [
                          const Color(0xFF3B82F6),
                          const Color.fromARGB(255, 78, 3, 208),
                        ],
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$sym${usage.dailySpent.toStringAsFixed(2)} spent today',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            Text(
              '$sym${usage.dailyLimit.toStringAsFixed(2)} limit',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
