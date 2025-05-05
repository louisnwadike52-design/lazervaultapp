import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/src/features/widgets/create_new_password.dart';


class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {

  @override
  void initState() {
    super.initState();
    // Set status bar icons to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg/up-down-curve-bg-shrinked.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: CreateNewPassword(),
      ),
    );
  }
}
