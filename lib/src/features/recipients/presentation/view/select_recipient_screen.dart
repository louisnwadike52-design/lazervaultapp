import 'package:flutter/material.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/select_recipients.dart';
// Import for SystemUiOverlayStyle


class SelectRecipientScreen extends StatefulWidget {
  const SelectRecipientScreen({super.key});

  @override
  State<SelectRecipientScreen> createState() => _SelectRecipientScreenState();
}

class _SelectRecipientScreenState extends State<SelectRecipientScreen> {


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
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent, // Make status bar transparent
      //     statusBarIconBrightness:
      //         Brightness.light, // Light icons in status bar
      //   ),
      //   backgroundColor: Colors.blue, // Set your desired app bar color
      //   elevation: 0, // Remove shadow
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       if (Navigator.canPop(context)) {
      //         Get.back();
      //       } else {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(content: Text("No route to go back.")),
      //         );
      //       }
      //     },
      //     color: Colors.white, // Set back arrow color to white
      //   ),
      //   title: Text(
      //     ScreenName.selectRecipient.displayName,
      //     style: TextStyle(color: Colors.white), // Set title color to white
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.add,
      //         color: Colors.white, // Set add icon color to white
      //       ),
      //       onPressed: () => Get.toNamed(AppRoutes.addRecipient),
      //     ),
      //   ],
      // ),
      body: SelectRecipients(),
    );
  }
}
