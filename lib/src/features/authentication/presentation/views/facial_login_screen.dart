import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/face_verification_cubit.dart';
import 'package:lazervault/src/features/widgets/facial_login_camera.dart';

class FacialLoginScreen extends StatefulWidget {
  const FacialLoginScreen({super.key});

  @override
  State<FacialLoginScreen> createState() => _FacialLoginScreenState();
}

class _FacialLoginScreenState extends State<FacialLoginScreen> {

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
    return BlocProvider<FaceVerificationCubit>(
      create: (context) => serviceLocator<FaceVerificationCubit>(),
      child: Scaffold(
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
            const FacialLoginCamera(),
          ],
        ),
      ),
    );
  }
}
