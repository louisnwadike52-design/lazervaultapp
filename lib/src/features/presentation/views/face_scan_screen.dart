import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For SystemChrome
import 'package:lazervault/src/features/widgets/face_scan.dart';

class FaceScanScreen extends StatefulWidget {
  const FaceScanScreen({super.key});

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/human-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.bottomCenter,
          //       end: Alignment.topCenter,
          //       colors: [
          //         Color.fromARGB(0, 49, 9, 113),
          //         Color.fromARGB(200, 232, 233, 234),
          //       ],
          //     ),
          //   ),
          // ),
          const FaceScan(),
        ],
      ),
    );
  }
}
