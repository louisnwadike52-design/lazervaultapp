import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/countries.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  Country selectedCountry = AppData.countries.first;
  final notificationsController = ValueNotifier<bool>(true);
  final fingerPrintController = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    ResponsiveController responsiveController = ResponsiveController(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildListTile(
                    context,
                    config: ListTileConfig(
                      title: "Change pin",
                      imagePath: "assets/images/profile/key.png",
                      color: "#3784F9",
                      trailing: IconButton(
                        onPressed: () {
                          Get.toNamed(
                              AppRoutes.changePin); // Navigate to change pin
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 16.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildListTile(
                    context,
                    config: ListTileConfig(
                      title: "Notification",
                      imagePath: "assets/images/profile/notification.png",
                      color: "#9937FC",
                      trailing: AdvancedSwitch(
                        controller: notificationsController,
                        activeColor: Colors.blue,
                        height: responsiveController.isMobile ? 20.h : 30.h,
                        width: responsiveController.isMobile ? 40.w : 20.w,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildListTile(
                    context,
                    config: ListTileConfig(
                      title: "Fingerprint",
                      imagePath: "assets/images/profile/fingerprint.png",
                      color: "#FB7E36",
                      trailing: AdvancedSwitch(
                        controller: fingerPrintController,
                        activeColor: Colors.blue,
                        height: responsiveController.isMobile ? 20.h : 30.h,
                        width: responsiveController.isMobile ? 40.w : 20.w,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildListTile(
                    context,
                    config: ListTileConfig(
                      title: "Face ID",
                      imagePath: "assets/images/profile/finger-scan.png",
                      color: "#475078",
                      trailing: IconButton(
                        onPressed: () {
                          Get.toNamed("/face-id"); // Navigate to Face ID
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 16.0, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildListTile(
                    context,
                    config: ListTileConfig(
                      title: "Language",
                      imagePath: "assets/images/profile/translate.png",
                      color: "#7C92A0",
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UniversalImageLoader(
                            imagePath: "assets/images/flags/usa-flag.png",
                            width: 24.0.w,
                            height: 14.0.h,
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.languages);
                            },
                            icon: const Icon(Icons.arrow_forward_ios,
                                size: 16.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _buildListTile(
                    context,
                    config: ListTileConfig(
                      title: "Report a bug",
                      imagePath: "assets/images/profile/info-circle.png",
                      color: "#F55E5E",
                      trailing: IconButton(
                        onPressed: () {
                          Get.toNamed(
                              "/report-a-bug"); // Navigate to Report a Bug
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            size: 16.0, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileConfig {
  final String title;
  final String imagePath;
  final String color;
  final Widget? trailing;

  ListTileConfig({
    required this.title,
    required this.imagePath,
    required this.color,
    this.trailing,
  });
}

Widget _buildListTile(
  BuildContext context, {
  required ListTileConfig config,
}) {
  return ListTile(
    leading: RoundedCenteredImage(
      size: 48.0,
      backgroundColor: HexColor.fromHex(config.color),
      imagePath: config.imagePath,
    ),
    title: Text(config.title),
    trailing: config.trailing,
  );
}
