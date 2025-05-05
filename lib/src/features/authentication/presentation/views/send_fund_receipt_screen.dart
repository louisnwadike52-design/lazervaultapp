import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/core/types/transaction.dart';
import 'package:lazervault/src/features/widgets/send_fund_receipt.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart';

class SendFundReceiptScreen extends StatefulWidget {
  const SendFundReceiptScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  State<SendFundReceiptScreen> createState() => _SendFundReceiptScreenState();
}

class _SendFundReceiptScreenState extends State<SendFundReceiptScreen> {

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
                  Get.offAllNamed(AppRoutes.dashboard);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No route to go back.")),
                  );
                }
              },
            ),
            title: Text(ScreenName.sendFundReceipt.displayName),
            centerTitle: true,
          ),
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching Users")
              : state is UsersLoaded
                  ? SendFundReceipt(transaction: widget.transaction)
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
