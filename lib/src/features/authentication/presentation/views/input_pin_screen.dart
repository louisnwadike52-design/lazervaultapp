import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/input_pin.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart'; 

class InputPinScreen extends StatefulWidget {
  final User recipient;
  const InputPinScreen({super.key, required this.recipient});

  @override
  State<InputPinScreen> createState() => _InputPinScreenState();
}

class _InputPinScreenState extends State<InputPinScreen> {

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
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: state is GettingUsers
                ? const LoadingColumn(message: "Fetching Users")
                : state is UsersLoaded
                    ? InputPin(recipient: widget.recipient)
                      : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
