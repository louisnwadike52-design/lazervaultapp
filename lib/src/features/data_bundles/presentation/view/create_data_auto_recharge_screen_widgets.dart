part of 'create_data_auto_recharge_screen.dart';

/// Compact picker showing the data plans loaded for the selected
/// beneficiary's network. Wraps `DataBundlesCubit` (already in DI as a
/// factory) — caller passes a freshly-created instance via
/// `BlocProvider.value` so this sheet doesn't double-init network
/// requests.
class _PlanPickerSheet extends StatelessWidget {
  const _PlanPickerSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF4B5563),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text('Choose a Data Plan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 360.h),
            child: BlocBuilder<DataBundlesCubit, DataBundlesState>(
              buildWhen: (_, s) =>
                  s is DataBundlesLoading ||
                  s is DataPlansLoaded ||
                  s is DataBundlesError,
              builder: (context, state) {
                if (state is DataBundlesLoading) {
                  return const Center(
                      child: LazerVaultLoader.tiny());
                }
                if (state is DataBundlesError) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text(state.message,
                        style: TextStyle(
                            color: const Color(0xFFEF4444),
                            fontSize: 13.sp)),
                  );
                }
                final plans = state is DataPlansLoaded ? state.plans : const [];
                if (plans.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text('No plans available for this network',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp)),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) {
                    final p = plans[i];
                    return InkWell(
                      onTap: () => Navigator.of(context).pop(p),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(10.r),
                          border:
                              Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(p.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(width: 12.w),
                            // displayPrice is already a formatted string
                            // ("₦500" / "₦500.50") — no numeric coercion.
                            Text(p.displayPrice,
                                style: TextStyle(
                                    color: const Color(0xFF10B981),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
