import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/set_fingerprint.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart';

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
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
        }
      },
      builder: (context, state) {
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
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching Users")
              : state is UsersLoaded
                  ? SetFingerPrint()
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
