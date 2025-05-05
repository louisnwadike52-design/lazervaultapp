import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/src/features/widgets/new_card.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Scanner Options",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: HexColor.fromHex("#262626"),
                ),
              ),
              SizedBox(height: 16.h),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text("Scan with Camera"),
                onTap: () {
                  Navigator.pop(context); // Close the BottomSheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.image_outlined),
                title: const Text("Upload Image"),
                onTap: () {
                  Navigator.pop(context); // Close the BottomSheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
    return  Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  print("popping screen.......");
                  Get.back();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No route to go back.")),
                  );
                }
              },
            ),
            title: const Text("Add New Card"),
            centerTitle: true,
            // toolbarHeight:
            //     MediaQuery.of(context).size.height * 0.2, // Responsive height
            actions: [
              IconButton(
                icon: Icon(
                  Icons.scanner_outlined,
                  color: HexColor.fromHex("#262626"),
                ),
                onPressed: () => _showBottomSheet(context), // Open BottomSheet
              ),
            ],
          ),
          body: NewCard(),
        );
  }
}
