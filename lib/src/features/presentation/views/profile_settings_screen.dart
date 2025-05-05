import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/profile_settings.dart';


class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Make status bar transparent
          statusBarIconBrightness:
              Brightness.light, // Light icons in status bar
        ),
        backgroundColor: Colors.blue, // Set your desired app bar color
        elevation: 0, // Remove shadow
        title: Text(
          ScreenName.profileSettings.displayName,
          style: TextStyle(color: Colors.white), // Set title color to white
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set back arrow color to white
        ),
      ),
      body: ProfileSettings()
    );
  }
}
