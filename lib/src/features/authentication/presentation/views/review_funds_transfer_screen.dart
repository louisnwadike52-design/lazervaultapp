import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/recipient.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/review_funds_transfer.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart';

class ReviewFundsTransferScreen extends StatefulWidget {
  const ReviewFundsTransferScreen({super.key, required this.recipient});

  final Recipient recipient;

  @override
  State<ReviewFundsTransferScreen> createState() =>
      _ReviewFundsTransferScreenState();
}

class _ReviewFundsTransferScreenState extends State<ReviewFundsTransferScreen> {

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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Get.back();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No route to go back.")),
                  );
                }
              },
            ),
            title: Text(ScreenName.reviewFundsTransfer.displayName),
            centerTitle: true,
          ),
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching Users")
              : state is UsersLoaded
                  // onTap: () => context.push('/send-funds', extra: recipients[index]),
                  ? ReviewFundsTransfer(recipient: widget.recipient)
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
