import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/set_fingerprint.dart';


class SetFingerPrintScreen extends StatefulWidget {
  const SetFingerPrintScreen({super.key});

  @override
  State<SetFingerPrintScreen> createState() => _SetFingerPrintScreenState();
}

class _SetFingerPrintScreenState extends State<SetFingerPrintScreen> {


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
      body: SetFingerPrint(),
    );
  }
}
