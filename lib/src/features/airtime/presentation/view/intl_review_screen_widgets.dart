part of 'intl_review_screen.dart';

// ─── Account selection bottom sheet ────────────────────────────────────────

class _AccountSheet extends StatelessWidget {
  final List<dynamic> accounts;
  final String? selectedId;
  final double requiredAmount;
  final String currency;
  final ValueChanged<String> onSelected;

  const _AccountSheet({
    required this.accounts,
    required this.selectedId,
    required this.requiredAmount,
    required this.currency,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          Text('Select Account',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 16.h),
          ...accounts.map((acc) {
            final id = acc.id.toString();
            final isSelected = selectedId == id;
            final hasFunds = acc.availableBalance >= requiredAmount;
            return GestureDetector(
              onTap: hasFunds
                  ? () {
                      onSelected(id);
                      Navigator.pop(context);
                    }
                  : null,
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4E03D0)
                        : hasFunds
                            ? const Color(0xFF2D2D2D)
                            : const Color(0xFFEF4444).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(acc.accountType,
                              style: TextStyle(
                                  color: hasFunds
                                      ? Colors.white
                                      : const Color(0xFF9CA3AF),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '$currency ${acc.availableBalance.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: hasFunds
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFEF4444),
                                fontSize: 12.sp),
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
    );
  }
}
