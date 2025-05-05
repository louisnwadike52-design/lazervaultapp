import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class RecentHistoryList extends StatefulWidget {
  const RecentHistoryList({super.key});

  @override
  State<RecentHistoryList> createState() => _RecentHistoryListState();
}

class _RecentHistoryListState extends State<RecentHistoryList> {
  bool isHistoryLoaded = false;
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onDragListener);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isHistoryLoaded = true;
      });
    });
  }

  void _onDragListener() {
    if (_controller.size >= 0.9) {
      // Trigger when sheet is dragged up significantly
      Get.offAllNamed(AppRoutes.signIn); // Navigate and clear stack
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h, // Fixed initial height
      color: Colors.transparent,
      child: DraggableScrollableSheet(
        snap: true,
        maxChildSize: 1.0,
        initialChildSize: 1.0,
        minChildSize: 0.9,
        // initialChildSize: 1.0, // Start at full container height (300.h)
        // minChildSize: 0.9, // Keep at container height when not expanded
        // maxChildSize: 1.0, // Expand to full screen height
        // snap: true,
        // snapSizes: [
        //   1.0,
        //   Get.height / 300.h
        // ], // Snap to container height or full screen
        expand: true, // Important: don't expand the initial container
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                if (!isHistoryLoaded)
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: CircularProgressIndicator(),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: imagePaths.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.w),
                          leading: RoundedCenteredImage(
                            size: 48.0,
                            backgroundColor:
                                const Color.fromARGB(255, 209, 225, 237),
                            imagePath: imagePaths[index],
                          ),
                          title: Text(
                            "Bill Pay",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              color: HexColor.fromHex("#262626"),
                            ),
                          ),
                          subtitle: Text(
                            "Electric Bill",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "-\$20.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16.sp,
                                  color: HexColor.fromHex("#DE5F27"),
                                ),
                              ),
                              Text(
                                "02 Jan",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: HexColor.fromHex("#A3A3A3"),
                                ),
                              ),
                            ],
                          ),
                          dense: true,
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
