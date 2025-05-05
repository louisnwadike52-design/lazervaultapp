import 'package:flutter/material.dart';
// Import for SystemUiOverlayStyle
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/add_recipient.dart';  
import 'package:lazervault/src/features/widgets/loading_column.dart';

class AddRecipientScreen extends StatefulWidget {
  const AddRecipientScreen({super.key});

  @override
  State<AddRecipientScreen> createState() => _AddRecipientScreenState();
}

class _AddRecipientScreenState extends State<AddRecipientScreen> {

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
          body: state is GettingUsers
              ? const LoadingColumn(message: "...")
              : state is UsersLoaded
                  ? AddRecipient()
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
