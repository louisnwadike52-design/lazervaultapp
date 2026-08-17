part of 'create_internet_rollover_screen.dart';

/// Bottom sheet showing packages for the selected ISP. Reads from
/// `InternetBillCubit` which was seeded by the parent screen — we
/// reuse that same cubit instance via `BlocProvider.value` so this
/// sheet doesn't double-fire the RPC.
class _PackagePickerSheet extends StatelessWidget {
  const _PackagePickerSheet();

  static const _bg = Color(0xFF0A0A0A);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);

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
          Text(
            'Choose a Package',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 360.h),
            child: BlocBuilder<InternetBillCubit, InternetBillState>(
              buildWhen: (_, s) =>
                  s is InternetBillLoading ||
                  s is InternetPackagesLoaded ||
                  s is InternetBillError,
              builder: (context, state) {
                if (state is InternetBillLoading) {
                  return const Center(
                    child: LazerVaultLoader.tiny(),
                  );
                }
                if (state is InternetBillError) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      state.message,
                      style: TextStyle(color: _red, fontSize: 13.sp),
                    ),
                  );
                }
                final packages = state is InternetPackagesLoaded
                    ? state.packages
                    : const <InternetPackageEntity>[];
                if (packages.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      'No packages available for this ISP right now.',
                      style: TextStyle(color: _muted, fontSize: 13.sp),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: packages.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (_, i) {
                    final p = packages[i];
                    return InkWell(
                      onTap: () => Navigator.of(context).pop(p),
                      child: Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: _bg,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: _border),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (p.validity.isNotEmpty) ...[
                                    SizedBox(height: 2.h),
                                    Text(
                                      p.validity,
                                      style: TextStyle(
                                        color: _muted,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '₦${p.displayAmount.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: _green,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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
