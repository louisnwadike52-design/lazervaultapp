import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';

class ThemedDrawer extends StatelessWidget {
  const ThemedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveController responsiveController =
        ResponsiveController(context);
    double screenWidth = responsiveController.screenWidth;
    double drawerWidth = screenWidth < 600 ? screenWidth * 0.8 : 304.0;

    return Drawer(
      width: drawerWidth,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Jane Cooper"),
            accountEmail: Text("jane.cooper@example.com"),
            currentAccountPicture: CircleAvatar(
              radius: 16.0, // Reduced size to 16.0
              backgroundImage: AssetImage('assets/images/Profile.png'),
            ),
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 78, 3, 208)),
            otherAccountsPictures: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 8.0),
          _buildListTile(
              context,
              "My account",
              "assets/images/profile/user-octagon.png",
              "#3784F9",
              AppRoutes.myAccount),
          SizedBox(height: 8.0),
          _buildListTile(context, "Location",
              "assets/images/profile/location.png", "#9937FC", "/location"),
          SizedBox(height: 8.0),
          _buildListTile(
              context,
              "Set Fingerprint",
              "assets/images/profile/location.png",
              "#9937FC",
              AppRoutes.setFingerPrint),
          SizedBox(height: 8.0),
          _buildListTile(context, "Privacy policy",
              "assets/images/profile/shield-tick.png", "#5FDA6B", "/privacy"),
          SizedBox(height: 8.0),
          _buildListTile(
              context,
              "Settings",
              "assets/images/profile/settings.png",
              "#7C92A0",
              AppRoutes.profileSettings),
          SizedBox(height: 8.0),
          _buildListTile(context, "Help & Support",
              "assets/images/profile/message.png", "#FFD420", "/help"),
          SizedBox(height: 8.0),
          _buildListTile(context, "Contact us",
              "assets/images/profile/contact-us.png", "#FF7465", "/contact"),
          SizedBox(height: 8.0),
          _buildListTile(context, "Logout", "assets/images/profile/logout.png",
              "#FF2D2D", AppRoutes.signIn),
          SizedBox(height: 8.0),
          ListTile(
            style: ListTileStyle.drawer,
            title: Text("Switch to Other Account",
                style: TextStyle(color: Colors.blue)),
            onTap: () {
              Get.toNamed("/switch-account"); // Navigates using GoRouter
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, String imagePath,
      String color, String path) {
    return ListTile(
      leading: RoundedCenteredImage(
        size: 48.0,
        backgroundColor: HexColor.fromHex(color),
        imagePath: imagePath,
      ),
      title: Text(title),
      style: ListTileStyle.drawer,
      trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
      onTap: () {
        if (Navigator.canPop(context)) {
          Get.back();
        }
        Get.toNamed(path);
      },
    );
  }
}
