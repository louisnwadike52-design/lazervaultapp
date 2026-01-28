import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class RecentHistoryList extends StatefulWidget {
  const RecentHistoryList({super.key});

  @override
  State<RecentHistoryList> createState() => _RecentHistoryListState();
}

class _RecentHistoryListState extends State<RecentHistoryList> {
  bool isHistoryLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isHistoryLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          if (!isHistoryLoaded)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 78, 3, 208),
                strokeWidth: 3,
              ),
            )
          else
            Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: imagePaths.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withValues(alpha: 0.1),
                    height: 1,
                    indent: 76.w,
                    endIndent: 16.w,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.transactionHistory);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Center(
                                child: Image.asset(
                                  imagePaths[index],
                                  width: 24.w,
                                  height: 24.w,
                                  color: Color.fromARGB(255, 78, 3, 208),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bill Pay",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Electric Bill",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "-\$20.00",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: Color(0xFFE53935),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "02 Jan",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.transactionHistory);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 24.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View All Transactions',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 78, 3, 208),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 18.sp,
                          color: Color.fromARGB(255, 78, 3, 208),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
