import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';

class CardSettings extends StatefulWidget {
  const CardSettings({super.key});

  @override
  State<CardSettings> createState() => _CardSettingsState();
}

class _CardSettingsState extends State<CardSettings> {
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveController = ResponsiveController(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Card Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: HybridHexColor.fromHex("#262626"),
            ),
          ),
          SizedBox(height: 12.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RoundedCenteredImage(
                              size: 48.0,
                              backgroundColor:
                                  const Color.fromARGB(255, 209, 225, 237),
                              imagePath: imagePaths[index],
                            ),
                            SizedBox(
                                width:
                                    16.0), // Added spacing between image and text
                            Text("Payment Request"),
                          ],
                        ),
                        AdvancedSwitch(
                          controller: _controller,
                          activeColor: Colors.blue,
                          height: responsiveController.isMobile ? 20.h : 30.h,
                          width: responsiveController.isMobile ? 40.w : 20.w,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
