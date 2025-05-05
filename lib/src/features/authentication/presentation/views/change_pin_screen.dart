import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/change_pin.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart'; 
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {

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
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            backgroundColor: Colors.blue,
            elevation: 0,
            title: Text(
              ScreenName.changePin.displayName,
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching Users")
              : state is UsersLoaded
                  ? ChangePin()
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
